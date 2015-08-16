package cn.leaves.websnap.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by leaves chen<leaves615@gmail.com> on 15/8/15.
 *
 * @Author leaves chen<leaves615@gmail.com>
 */
@Controller
public class MainController {
    @RequestMapping("/")
    public String main() {
        return "main";
    }
}
