package cn.leaves.websnap.controller;

import cn.leaves.websnap.batis.entity.Page;
import cn.leaves.websnap.batis.mapper.PageMapper;
import cn.leaves.websnap.batis.mapper.SeedMapper;
import cn.leaves.websnap.pager.PagerContext;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

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
}
