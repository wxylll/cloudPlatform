package cn.baimu.controller.reception;

import cn.baimu.po.User;
import cn.baimu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * 前台登录管理
 * @author wxy
 */
@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    /**
     *登录
     */
    @RequestMapping("/login")
    public String login(String username, String password, Model model, HttpSession httpSession) {
        User user = userService.login(username,password);
        if (user != null) {
            httpSession.setAttribute("receptionUser",user);
            return "index";
        }else {
            model.addAttribute("loginError","用户名或密码错误！");
            return "jsps/reception/login/login";
        }
    }

}
