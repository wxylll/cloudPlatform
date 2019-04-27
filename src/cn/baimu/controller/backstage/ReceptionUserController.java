package cn.baimu.controller.backstage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/backstage")
public class ReceptionUserController {

    //注册前台账号
    @RequestMapping("/register")
    public String register() {
        System.out.println("register");
        return "";
    }

    //展示所有前台账号
    @RequestMapping("/showReceptionUsers")
    public String showReceptionUsers() {
        return "";
    }

    //修改前台账号
    @RequestMapping("/modifyUser")
    public void modifyUser() {

    }

    //移除前台账号
    @RequestMapping("/removeUser")
    public void removeUser() {

    }

}
