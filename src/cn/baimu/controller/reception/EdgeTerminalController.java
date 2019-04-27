package cn.baimu.controller.reception;

import cn.baimu.po.User;
import cn.baimu.service.EdgeTerminalService;
import com.sun.deploy.net.HttpResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 边缘端管理
 */
@Controller
public class EdgeTerminalController {

    @Autowired
    private EdgeTerminalService edgeTerminalService;

    //显示用户所属所有边缘端
    @RequestMapping("/showTerminal")
    public String showEdgeTerminal(Model model, HttpSession httpSession){
        try {
            User user = (User) httpSession.getAttribute("receptionUser");
            System.out.println(user.getUid());
            model.addAttribute("edgeTerminals",edgeTerminalService.getEdgeTerminals(user.getUid()));
            System.out.println(edgeTerminalService.getEdgeTerminals(user.getUid()));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "reception/edgeterminal/edgeterminal";
    }

    //边缘端接入
    @ResponseBody
    @RequestMapping("/insertEdgeTerminal")
    public void insertEdgeTerminal(HttpSession httpSession, HttpServletResponse response){
        User user = (User) httpSession.getAttribute("receptionUser");

        response.setContentType("text/html;charset=utf-8");
        try {
            response.getWriter().write("<script>alert('添加成功')</script>");
            response.getWriter().flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //移除边缘端
    @RequestMapping("/removeEdgeTerminal")
    public void removeEdgeTerminal() {

    }

}
