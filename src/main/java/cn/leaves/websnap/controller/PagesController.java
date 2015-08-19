package cn.leaves.websnap.controller;

import cn.leaves.websnap.batis.entity.Page;
import cn.leaves.websnap.batis.entity.Pagecollectcontent;
import cn.leaves.websnap.batis.entity.Seedcontentprocessrule;
import cn.leaves.websnap.batis.mapper.PageMapper;
import cn.leaves.websnap.batis.mapper.PagecollectcontentMapper;
import cn.leaves.websnap.batis.mapper.SeedMapper;
import cn.leaves.websnap.batis.mapper.SeedcontentprocessruleMapper;
import cn.leaves.websnap.pager.PagerContext;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Created by leaves chen<leaves615@gmail.com> on 15/8/17.
 *
 * @Author leaves chen<leaves615@gmail.com>
 */
@Controller
@RequestMapping("/pages")
public class PagesController {
    @Resource
    private PageMapper pageMapper;
    @Resource
    private SeedMapper seedMapper;
    @Resource
    private PagecollectcontentMapper contentMapper;
    @Resource
    private SeedcontentprocessruleMapper contentRuleMapper;

    @RequestMapping("/list")
    public String list(Page record, ModelMap map) {
        record.setHascontent(true);
        if (StringUtils.hasText(record.getTitle())) {
            record.setTitle("%"+record.getTitle()+"%");
        }
        PageHelper.startPage(PagerContext.getPageNo(), PagerContext.getPageSize());
        map.put("page", new PageInfo(pageMapper.findBySelective(record)));
        map.put("seeds", seedMapper.selectAll());
        if (StringUtils.hasText(record.getTitle())) {
            record.setTitle(record.getTitle().replaceAll("%",""));
        }
        map.put("record", record);
        return "/pages/list";
    }

    @RequestMapping("/{id}")
    public String detail(@PathVariable Long id, ModelMap map) {
        Page page = pageMapper.selectByPrimaryKey(id);
        List<Pagecollectcontent> contents = contentMapper.selectByPageId(id);
        List<Long> ruleIds = contents.stream().map(item -> item.getContentruleid()).collect(Collectors.toList());
        Map<Long, Seedcontentprocessrule> ruleMap = ruleIds.stream().collect(
                Collectors.toMap(
                        (p) -> p, (p) -> contentRuleMapper.selectByPrimaryKey(
                                p)));
        map.put("page", page);
        map.put("contents", contents);
        map.put("ruleMap", ruleMap);
        map.put("baseDomain", getBaseDomain(page.getWeburl()));
        return "/pages/detail";
    }

    private String getBaseDomain(String url) {
        try {
            URL _url = new URL(url);
            return url.substring(0, url.indexOf(_url.getPath()));
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
        return "";
    }
}
