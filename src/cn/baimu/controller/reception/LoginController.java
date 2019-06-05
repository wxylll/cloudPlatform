package cn.baimu.controller.reception;

import cn.baimu.mapper.OutlierMapper;
import cn.baimu.po.EdgeTerminal;
import cn.baimu.po.Outlier;
import cn.baimu.po.User;
import cn.baimu.service.EdgeTerminalService;
import cn.baimu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 * 前台登录管理
 * @author wxy
 */
@Controller
public class LoginController {

    @Autowired
    private UserService userService;
    @Autowired
    private EdgeTerminalService edgeTerminalService;

    //登录
    @RequestMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password, Model model, HttpSession httpSession){
        if (httpSession.getAttribute("receptionUser") != null) {
            model.addAttribute("loginError","同一浏览器只能登录一个账号！");
        }
        User user = userService.login(username,password);
        if (user != null) {
            httpSession.setAttribute("receptionUser",user); //保存用户信息
            List<EdgeTerminal> edgeTerminals = null;
            try {
                edgeTerminals = edgeTerminalService.getEdgeTerminals(user.getUid()); //获取用户管辖范围类已接管的边缘端信息
            } catch (Exception e) {
                e.printStackTrace();
            }
            httpSession.setAttribute("jurisdictions", edgeTerminals);
            return "reception/main";
        }else {
            model.addAttribute("loginError","用户名或密码错误！");
            return "reception/login/login";
        }
    }

    //退出
    @RequestMapping("/logout")
    public String logout(HttpSession httpSession) {
        httpSession.removeAttribute("receptionUser");
        return "reception/login/login";
    }

}
