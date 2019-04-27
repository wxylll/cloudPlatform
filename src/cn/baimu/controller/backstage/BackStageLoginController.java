package cn.baimu.controller.backstage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/backstage")
public class BackStageLoginController {

    //后台登录
    @RequestMapping("/login")
    public String login() {
        System.out.println("login");
        return "";
    }

}
