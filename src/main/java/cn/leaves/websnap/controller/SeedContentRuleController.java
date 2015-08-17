package cn.leaves.websnap.controller;

import cn.leaves.websnap.batis.entity.Seedcontentprocessrule;
import cn.leaves.websnap.batis.entity.Seedpagerule;
import cn.leaves.websnap.batis.mapper.SeedcontentprocessruleMapper;
import cn.leaves.websnap.pager.PagerContext;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;

/**
 * Created by leaves chen<leaves615@gmail.com> on 15/8/17.
 *
 * @Author leaves chen<leaves615@gmail.com>
 */
@Controller
@RequestMapping("/seed/{seedid}/pageRule/{ruleid}/content")
public class SeedContentRuleController {
    @Resource
    private SeedcontentprocessruleMapper contentMapper;

    @RequestMapping("/list")
    public String list(@PathVariable Long seedid, @PathVariable Long ruleid, ModelMap map) {
        PageHelper.startPage(PagerContext.getPageNo(), PagerContext.getPageSize());
        Page<Seedcontentprocessrule> page = contentMapper.selectByRuleId(ruleid);
        map.put("page", new PageInfo(page));
        return "/seed/pageRule/content/list";
    }

    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String addPage(@PathVariable Long seedid, @PathVariable Long ruleid) {
        return "/seed/pageRule/content/add";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String add(@PathVariable Long seedid, @PathVariable Long ruleid, Seedcontentprocessrule content) {
        contentMapper.insert(content);
        return String.format("redirect:/seed/%s/pageRule/%s/content/list", seedid, ruleid);
    }

    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String updatePage(
            @PathVariable Long seedid, @PathVariable Long ruleid, @PathVariable Long id, ModelMap map) {
        Seedcontentprocessrule content = (Seedcontentprocessrule) map.getOrDefault(
                "content", contentMapper.selectByPrimaryKey(
                        id));
        map.put("content", content);
        return "/seed/pageRule/content/edit";
    }

    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    public String update(
            @PathVariable Long seedid, @PathVariable Long ruleid, @PathVariable Long id,
            Seedcontentprocessrule content) {
        contentMapper.updateByPrimaryKey(content);
        return String.format("redirect:/seed/%s/pageRule/%s/content/list", seedid, ruleid);
    }

    @RequestMapping(value = "/{id}/delete")
    public String delete(@PathVariable Long seedid, @PathVariable Long ruleid, @PathVariable Long id) {
        contentMapper.deleteByPrimaryKey(id);
        return String.format("redirect:/seed/%s/pageRule/%s/content/list", seedid, ruleid);
    }
}
