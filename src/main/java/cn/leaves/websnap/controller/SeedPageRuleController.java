package cn.leaves.websnap.controller;

import cn.leaves.websnap.batis.entity.Seedpagerule;
import cn.leaves.websnap.batis.mapper.SeedpageruleMapper;
import cn.leaves.websnap.pager.PagerContext;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;

/**
 * Created by leaves chen<leaves615@gmail.com> on 15/8/17.
 *
 * @Author leaves chen<leaves615@gmail.com>
 */
@RequestMapping("/seed/{seedid}/pageRule")
@Controller
public class SeedPageRuleController {
    @Resource
    private SeedpageruleMapper pageruleMapper;

    @RequestMapping("/list")
    public String list(@PathVariable Long seedid, ModelMap map) {
        PageHelper.startPage(PagerContext.getPageNo(), PagerContext.getPageSize());
        Page<Seedpagerule> page = pageruleMapper.selectBySeedId(seedid);
        map.put("page", new PageInfo(page));
        return "/seed/pageRule/list";
    }

    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String addPage(@PathVariable Long seedid) {
        return "/seed/pageRule/add";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @Transactional
    public String add(@PathVariable Long seedid, Seedpagerule rule, RedirectAttributes redirectAttributes) {
        pageruleMapper.insert(rule);
        return String.format("redirect:/seed/%s/pageRule/list", seedid);
    }

    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String updatePage(@PathVariable Long seedid, @PathVariable Long id, ModelMap map) {
        Seedpagerule rule = (Seedpagerule) map.getOrDefault("rule", pageruleMapper.selectByPrimaryKey(id));
        map.put("rule", rule);
        return "/seed/pageRule/edit";
    }

    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    @Transactional
    public String update(@PathVariable Long seedid, Seedpagerule rule, RedirectAttributes redirectAttributes) {
        pageruleMapper.updateByPrimaryKey(rule);
        return String.format("redirect:/seed/%s/pageRule/list", seedid);
    }

    @RequestMapping("/{id}/delete")
    @Transactional
    public String delete(@PathVariable Long seedid,@PathVariable Long id) {
        pageruleMapper.deleteByPrimaryKey(id);
        return String.format("redirect:/seed/%s/pageRule/list", seedid);
    }
}
