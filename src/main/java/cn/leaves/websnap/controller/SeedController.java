package cn.leaves.websnap.controller;

import cn.leaves.websnap.batis.entity.Seed;
import cn.leaves.websnap.batis.mapper.SeedMapper;
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
 * Created by leaves chen<leaves615@gmail.com> on 15/8/15.
 *
 * @Author leaves chen<leaves615@gmail.com>
 */
@Controller
@RequestMapping("/seed")
public class SeedController {
    @Resource
    private SeedMapper seedMapper;

    @RequestMapping("/list")
    public String list(Seed seed, ModelMap map) {
        PageHelper.startPage(PagerContext.getPageNo(), PagerContext.getPageSize());
        map.put("page", new PageInfo(seedMapper.findBySelective(seed)));
        return "seed/list";
    }

    @RequestMapping("/{id}/disable")
    @Transactional
    public String disable(@PathVariable() Long id, RedirectAttributes redirectAttributes) {
        Seed seed = new Seed();
        seed.setId(id);
        seed.setStatus(false);
        seedMapper.updateByPrimaryKeySelective(seed);
        return "redirect:/seed/list";
    }

    @RequestMapping("/{id}/enable")
    @Transactional
    public String enable(@PathVariable() Long id, RedirectAttributes redirectAttributes) {
        Seed seed = new Seed();
        seed.setId(id);
        seed.setStatus(true);
        seedMapper.updateByPrimaryKeySelective(seed);
        return "redirect:/seed/list";
    }

    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String addPage() {
        return "/seed/add";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @Transactional
    public String add(Seed seed,RedirectAttributes redirectAttributes) {
        seedMapper.insert(seed);
        return "redirect:/seed/list";
    }

    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String updatePage(@PathVariable Long id, ModelMap map) {
        Seed seed = (Seed) map.getOrDefault("seed", seedMapper.selectByPrimaryKey(id));
        map.put("seed", seed);
        return "/seed/edit";
    }

    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    @Transactional
    public String update(Seed seed, RedirectAttributes redirectAttributes) {
        seedMapper.updateByPrimaryKeySelective(seed);
        return "redirect:/seed/list";
    }

    @RequestMapping(value = "/{id}/delete", method = RequestMethod.POST)
    @Transactional
    public String delete(@PathVariable Long id) {
        seedMapper.deleteByPrimaryKey(id);
        return "redirect:/seed/list";
    }
}
