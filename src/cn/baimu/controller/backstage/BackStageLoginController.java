package cn.baimu.controller.backstage;

import cn.baimu.po.EdgeTerminal;
import cn.baimu.po.User;
import cn.baimu.utils.StringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class BackStageLoginController {

    //后台登录
    @RequestMapping("/adminLogin")
    public String adminLogin(@RequestParam String username, @RequestParam String password, Model model) {

        if (username.equals("admin") && password.equals("123456")) {
            return "backstage/main";
        }

        model.addAttribute("loginError","用户名或密码错误！");
        return "backstage/login/login";
    }

}
