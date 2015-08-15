package cn.leaves.websnap.util;

import cn.leaves.websnap.batis.entity.Seedpagerule;
import org.springframework.util.AntPathMatcher;
import org.springframework.util.Assert;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by leaves chen<leaves615@gmail.com> on 15/8/9.
 */
public class UrlMatchUtil {
    static AntPathMatcher antPathMatcher = new AntPathMatcher();

    public static boolean pageRuleMatch(String path, List<Seedpagerule> rules) {
        Assert.notNull(rules, "规则不能为空");
        Assert.notNull(path, "要匹配的路径不能为空");
        for (Seedpagerule rule : rules) {
            boolean match = pageRuleMatch(path, rule);
            if (match) return true;
        }
        return false;
    }

    public static boolean pageRuleMatch(String path, Seedpagerule rule) {
        switch (rule.getMatchtype()) {
            case Seedpagerule.MATCH_TYPE_ANT_STYLE: {
                return antPathMatch(path, rule.getPattern());
            }
            case Seedpagerule.MATCH_TYPE_REGEX: {
                return regexPathMatch(path, rule.getPattern());
            }
        }
        return false;
    }

    private static boolean antPathMatch(String path, String pattern) {
        return antPathMatcher.match(pattern, path);
    }

    private static boolean regexPathMatch(String path, String pattern) {
        Pattern pattern1 = Pattern.compile(pattern);
        Matcher matcher = pattern1.matcher(path);
        return matcher.find();
    }


    public static void main(String[] args) {
        System.out.println(regexPathMatch("/news/info_33.aspx?itemid=321","/news/info_33\\.aspx\\?itemid=\\d*"));
    }
}
