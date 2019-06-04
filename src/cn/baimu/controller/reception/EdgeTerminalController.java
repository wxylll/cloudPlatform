package cn.baimu.controller.reception;

import cn.baimu.po.EdgeTerminal;
import cn.baimu.po.User;
import cn.baimu.service.EdgeTerminalService;
import cn.baimu.service.UserService;
import cn.baimu.websocket.handler.RealTimeDataHandler;
import com.sun.deploy.net.HttpResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * 边缘端管理
 */
@Controller
public class EdgeTerminalController {

    @Autowired
    private EdgeTerminalService edgeTerminalService;
    @Autowired
    private RealTimeDataHandler realTimeDataHandler;
    @Autowired
    private UserService userService;

    //显示用户管辖范围内的所有边缘端
    @RequestMapping("/showTerminal")
    public String showEdgeTerminal(Model model, HttpSession httpSession){
        try {
            User user = (User) httpSession.getAttribute("receptionUser");
            List<EdgeTerminal> edgeTerminals = edgeTerminalService.findByJurisdiction(user.getUid(),user.getJurisdiction());
            for (EdgeTerminal edgeTerminal : edgeTerminals) {

            }
            model.addAttribute("edgeTerminals",edgeTerminals);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "reception/edgeterminal/edgeterminal";
    }

    //边缘端注册
    @ResponseBody
    @RequestMapping("/registerEdgeTerminal")
    public void registerEdgeTerminal(String position, HttpServletResponse response){
        String msg = "{";
        response.setCharacterEncoding("utf-8"); //设置编码
        String eid = null;
        try {
            eid = edgeTerminalService.register(position); //注册边缘端
            if (eid == null) {
                msg = msg + "'status':'failed','msg':'该地点已被监管！'}";
                response.getWriter().write(msg); //失败返回响应信息
                return;
            }
            msg = msg + "'eid':'" + eid + "',"; //保存eid信息
        } catch (Exception e) {
            msg = msg + "'status':'failed','msg':'未知错误！'}"; //保存失败信息
            try {
                response.getWriter().write(msg); //失败返回响应信息
            } catch (IOException e1) {
                e1.printStackTrace();
            }
            e.printStackTrace();
            return;
        }

        try {
            User user = userService.findCrownUser(position); //获取
            if (user != null) {
                realTimeDataHandler.sendMessage("new:",user.getUid());
                msg = msg + "'msg':'已成功建立连接，请等待用户：" + user.getUid() + "进行接管！',";
            } else {
                msg = msg + "'msg':'未找到可接管此设备的用户，请与相关部门联系！',"; //保存信息提示未找到可接管此边缘端的用户
                edgeTerminalService.delete(eid);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            msg = msg + "'status':'succeed'}"; //保存最终成功信息
            response.getWriter().write(msg); //最终响应
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //移除边缘端
    @ResponseBody
    @RequestMapping("/removeEdgeTerminal")
    public void removeEdgeTerminal(String eid,HttpServletResponse response) {
        try {
            edgeTerminalService.delete(eid);
            response.getWriter().write("succeed"); //返回成功信息
        } catch (Exception e) {
            try {
                response.getWriter().write("failed"); //返回失败信息
            } catch (IOException e1) {
                e1.printStackTrace();
            }
            e.printStackTrace();
        }
    }

    //更新边缘端
    @ResponseBody
    @RequestMapping("/updateEdgeTerminal")
    public void updateEdgeTerminal(EdgeTerminal edgeTerminal, HttpServletResponse response) {
        try {
            edgeTerminalService.update(edgeTerminal); //更新边缘端信息
            response.getWriter().write("succeed"); //返回成功信息
        } catch (Exception e) {
            try {
                response.getWriter().write("succeed"); //返回失败信息
            } catch (IOException e1) {
                e1.printStackTrace();
            }
            e.printStackTrace();
        }
    }

}
