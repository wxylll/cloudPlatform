package cn.baimu.controller.reception;

import cn.baimu.po.User;
import cn.baimu.service.SecurityStaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 安保人员管理
 */
@Controller
public class SecurityStaffController {

    @Autowired
    private SecurityStaffService securityStaffService;

    //显示用户管辖范围所有安保人员信息
    @RequestMapping("/showSecurityStaffs")
    public String showSecurityStaffs(Model model, HttpSession httpSession) {
        User user = (User) httpSession.getAttribute("receptionUser");
        try {
            model.addAttribute("",securityStaffService.findSecurityStaffByWorkPlace(user.getJurisdiction()));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "reception/securitystaff/show";
    }

    //添加安保人员信息
    @ResponseBody
    @RequestMapping("/addSecurityStaff")
    public void addSecurityStaff(HttpSession httpSession, HttpServletResponse response) throws IOException {
        User user = (User) httpSession.getAttribute("receptionUser");



        response.setContentType("text/html;charset=utf-8");
        response.getWriter().write("<script>alert('添加成功')</script>");
        response.getWriter().flush();
    }

    //移除安保人员信息
    @RequestMapping("/removeSecurityStaff")
    public void removeSecurityStaff() {

    }

}
