package cn.baimu.controller.reception;

import cn.baimu.mapper.OutlierMapper;
import cn.baimu.po.Outlier;
import cn.baimu.po.User;
import cn.baimu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

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
            List<String> string = new ArrayList();
            string.add("王府井");
            string.add("长安大厦");
            string.add("天安门广场");
            httpSession.setAttribute("position", string);
            return "jsps/test";
        }else {
            model.addAttribute("loginError","用户名或密码错误！");
            return "jsps/reception/login/login";
        }
    }

    @RequestMapping("/test")
    public String test() {
        System.out.println("111111111");
        return "index";
    }

    @Autowired
    private OutlierMapper outlierMapper;
    @RequestMapping("/test2")
    public String test2() {
        List<Outlier> outliers = outlierMapper.findAll();
        for (Outlier outlier : outliers) {
            System.out.println(outlier.toString() + "");
        }
        return "index";
    }

}
