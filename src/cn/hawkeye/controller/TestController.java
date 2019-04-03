package cn.hawkeye.controller;

import cn.hawkeye.service.Test2Service;
import cn.hawkeye.service.TestService;
import cn.hawkeye.service.Text3Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestController {

    @Autowired
    private TestService testService;

    @Autowired
    private Test2Service test2Service;

    @Autowired
    private Text3Service text3Service;

    @RequestMapping("/test")
    public String test() {
        System.out.println(testService.count());
        return "index";
    }

    @RequestMapping("/test2")
    public String test2() {
        System.out.println(test2Service.count());
        return "test";
    }

    @RequestMapping("/text3")
    public String text3(){
        System.out.println(text3Service.print());
        return "index";
    }

}
