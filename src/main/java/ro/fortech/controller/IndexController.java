package ro.fortech.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Tamas on 5/12/2017.
 */
@Controller
@RequestMapping("/")
public class IndexController {

    @RequestMapping("")
    public String index() {
        return "redirect:/search";
    }
}
