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

    /**
     *登录
     */
    @RequestMapping("/login")
    public String login(String username, String password, Model model, HttpSession httpSession){
        User user = userService.login(username,password);
        if (user != null) {
            httpSession.setAttribute("receptionUser",user); //保存用户信息
            List<EdgeTerminal> edgeTerminals = null;
            try {
                edgeTerminals = edgeTerminalService.getEdgeTerminals(user.getId()); //获取用户管辖范围类的边缘端信息
            } catch (Exception e) {
                e.printStackTrace();
            }
            httpSession.setAttribute("jurisdiction", edgeTerminals);
            return "jsps/reception/main";
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
        List<Outlier> outliers = null;
        try {
            outliers = outlierMapper.combinationQuery("北京",null,new Date());
        } catch (Exception e) {
            e.printStackTrace();
        }
        for (Outlier outlier : outliers) {
            System.out.println(outlier.toString() + "");
        }
        return "index";
    }

}
