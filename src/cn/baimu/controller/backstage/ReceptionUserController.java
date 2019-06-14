package cn.baimu.controller.backstage;

import cn.baimu.po.User;
import cn.baimu.service.UserService;
import cn.baimu.websocket.handler.RealTimeTextDataHandler;
import cn.itcast.commons.CommonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Controller
public class ReceptionUserController {

    @Autowired
    private UserService userService;
    @Autowired
    private RealTimeTextDataHandler realTimeTextDataHandler;

    //注册前台账号
    @RequestMapping("/register")
    public void register(User user, HttpServletResponse response) {
        try {
            user.setUid(CommonUtils.uuid());
            userService.add(user);
            response.getWriter().write("succeed");
        } catch (Exception e) {
            try {
                response.getWriter().write("failed");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
            e.printStackTrace();
        }
    }

    //展示所有前台账号
    @RequestMapping("/showReceptionUsers")
    public String showReceptionUsers(Model model) {
        try {
            List<User> users = userService.findAll();
            for (User user : users) {
                user.setOnline(realTimeTextDataHandler.userIsOnline(user.getUid()));
            }
            model.addAttribute("users", users);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "backstage/reception/show";
    }

    //修改前台账号
    @RequestMapping("/modifyUser")
    public void modifyUser(User user, HttpServletResponse response) {
        try {
            userService.update(user);
            response.getWriter().write("succeed");
        } catch (Exception e) {
            try {
                response.getWriter().write("failed");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
            e.printStackTrace();
        }

    }

    //移除前台账号
    @RequestMapping("/removeUser")
    public void removeUser(String uid, HttpServletResponse response) {
        try {
            userService.delete(uid);
            response.getWriter().write("succeed");
        } catch (Exception e) {
            try {
                response.getWriter().write("failed");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
            e.printStackTrace();
        }
    }

    //获取指定用户
    @RequestMapping("/getUser")
    public String getUser(String uid, Model model) {
        try {
            model.addAttribute("user", userService.get(uid));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "backstage/reception/desc";
    }

}
