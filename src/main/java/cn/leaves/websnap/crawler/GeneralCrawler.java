package cn.leaves.websnap.crawler;

import cn.leaves.websnap.batis.entity.Pagecollectcontent;
import cn.leaves.websnap.batis.entity.Seed;
import cn.leaves.websnap.batis.entity.Seedcontentprocessrule;
import cn.leaves.websnap.batis.entity.Seedpagerule;
import cn.leaves.websnap.batis.mapper.*;
import cn.leaves.websnap.util.UrlMatchUtil;
import edu.uci.ics.crawler4j.crawler.Page;
import edu.uci.ics.crawler4j.crawler.WebCrawler;
import edu.uci.ics.crawler4j.url.WebURL;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.context.annotation.Scope;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.expression.spel.support.StandardEvaluationContext;
import org.springframework.stereotype.Component;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Method;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * Created by leaves chen<leaves615@gmail.com> on 15/8/9.
 */
@SuppressWarnings("SpringJavaAutowiringInspection")
@Component
@Scope(value = "prototype")
public class GeneralCrawler extends WebCrawler {
    private static Log logger = LogFactory.getLog(GeneralCrawler.class);

    @Resource
    private SeedMapper                   seedMapper;
    @Resource
    private SeedpageruleMapper           seedpageruleMapper;
    @Resource
    private SeedcontentprocessruleMapper seedcontentprocessruleMapper;
    @Resource
    private PageMapper                   pageMapper;
    @Resource
    private PagecollectcontentMapper     pagecollectcontentMapper;
    @Resource
    private PlatformTransactionManager txManager;

    private Long seedId;

    private Seed                         seed;
    private List<Seedpagerule>           pagerules;
    private Map<Long,List<Seedcontentprocessrule>> contentprocessruleMap;


    public void init(Long seedId) {
        this.seedId = seedId;
        seed = seedMapper.selectByPrimaryKey(seedId);
        pagerules = seedpageruleMapper.selectBySeedId(seedId);
        contentprocessruleMap=seedcontentprocessruleMapper.selectBySeedId(seedId).stream().collect(
                Collectors.groupingBy(Seedcontentprocessrule::getPageid));
    }

    @Override
    public boolean shouldVisit(Page page, WebURL url) {
        String path = getPath(url.getURL());
        boolean shouldVist = UrlMatchUtil.pageRuleMatch(path, pagerules) && (!checkVisited(url.getURL()));
        if (logger.isDebugEnabled()) {
            logger.debug("crawler judge url[" + url.getURL() + "] be " + (shouldVist ? "visit" : "not need"));
        }
        return shouldVist;
    }

    @Override
    public void visit(Page page) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);

        TransactionStatus status = txManager.getTransaction(def);
        try {
            if (logger.isDebugEnabled()) {
                logger.debug("crawler visit url: " + page.getWebURL().getURL());
            }
            if (!UrlMatchUtil.pageRuleMatch(getPath(page.getWebURL().getURL()), pagerules)) {
                return;
            }
            if (checkVisited(page.getWebURL().getURL())) {
                return;
            }

            String charset = page.getContentCharset();
            if (StringUtils.isEmpty(charset)) {
                charset = seed.getCharset();
            }
            String html = new String(page.getContentData(), charset);
            Document document = Jsoup.parse(html);

            String title = document.select("html head title").text();
            cn.leaves.websnap.batis.entity.Page dbPage = new cn.leaves.websnap.batis.entity.Page(
                    seedId, title, page.getWebURL().getURL(), new Date(), false);
            pageMapper.insert(dbPage);

            List<Seedcontentprocessrule> rules = getContentRules(getPath(page.getWebURL().getURL()));
            Map<Seedcontentprocessrule, String> collectedMap = new HashMap<>();
            boolean needStorge = true;
            for (Seedcontentprocessrule rule : rules) {
                String collectedValue = null;
                switch (rule.getCollecttype()) {
                    case "html": {
                        collectedValue = document.select(rule.getCollectpattern()).html();
                        break;
                    }
                    case "regex":{
                        Pattern pattern1 = Pattern.compile(rule.getCollectpattern());
                        Matcher matcher = pattern1.matcher(html);
                        if (matcher.find()) {
                            collectedValue = matcher.group(1);
                        }
                        break;
                    }
                }
                if (rule.getConditional()) {
                    if (!parseCondition(rule.getConditionpattern(), collectedValue)) {
                        if (logger.isDebugEnabled()) {
                            logger.debug("Content does not meet the conditions.  Content:"+collectedValue);
                        }
                        needStorge = false;
                    }
                }
                collectedMap.put(rule, collectedValue);
            }
            if (needStorge) {
                for (Map.Entry<Seedcontentprocessrule, String> entry : collectedMap.entrySet()) {
                    if (entry.getKey().getStorage()) {
                        Pagecollectcontent collectContent = new Pagecollectcontent(
                                dbPage.getId(), entry.getKey().getId(), entry.getValue());
                        pagecollectcontentMapper.insert(collectContent);
                    }
                }
                dbPage.setHascontent(true);
                pageMapper.updateByPrimaryKey(dbPage);
            }
            txManager.commit(status);
        } catch (UnsupportedEncodingException e) {
            logger.error("charset error", e);
            txManager.rollback(status);
        }
    }

    private boolean checkVisited(String url) {
        int num =  pageMapper.countUrl(url);
        return num > 0;
    }

    private List<Seedcontentprocessrule> getContentRules(String path) {
        Seedpagerule rule =  pagerules.stream().filter(
                (r) -> UrlMatchUtil.pageRuleMatch(path, r)).findFirst().orElseGet(null);
        if (rule==null) {
            return Collections.emptyList();
        }
        return contentprocessruleMap.get(rule.getId()).stream().sorted(
                Comparator.comparing(Seedcontentprocessrule::getConditional)).collect(Collectors.toList());
    }

    private String getPath(String url) {
        try {
            URL _url = new URL(url);
            return _url.getPath()+"?" +_url.getQuery()+"#"+_url.getRef();
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
        return "";
    }

    private boolean parseCondition(String condition, String value) {
        try {
            SpelExpressionParser parser = new SpelExpressionParser();
            StandardEvaluationContext context = new StandardEvaluationContext();
            Method containMethod = GeneralCrawler.class.getDeclaredMethod("contain", String.class, String.class);
            context.registerFunction("contain",containMethod);
            return parser.parseExpression(condition).getValue(context, value, Boolean.class);
        } catch (Exception e) {
            if (logger.isErrorEnabled()) {
                logger.error(e.getMessage()+". parseCondition failed, condition:"+condition+" value:"+value);
            }
            if (logger.isDebugEnabled()) {
                logger.error("trace", e);
            }
            return false;
        }
    }

    public static boolean contain(String source, String target) {
        if (source == null) {
            source = "";
        }
        return source.contains(target);
    }


    public static void main(String[] args) {
        GeneralCrawler crawler = new GeneralCrawler();
        String exp = "#this eq 'a' or #this eq 'this is test'";
        String value = "this is test";
        System.out.println(crawler.parseCondition(exp, value));
    }
}
