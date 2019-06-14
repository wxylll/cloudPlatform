package cn.baimu.controller.reception;

import cn.baimu.po.SecurityStaff;
import cn.baimu.po.TempRecord;
import cn.baimu.po.User;
import cn.baimu.service.SecurityStaffService;
import cn.baimu.service.TempDataService;
import cn.itcast.commons.CommonUtils;
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
    @Autowired
    private TempDataService tempDataService;

    //显示用户管辖范围所有安保人员信息
    @RequestMapping("/showSecurityStaffs")
    public String showSecurityStaffs(Model model, HttpSession httpSession) {
        User user = (User) httpSession.getAttribute("receptionUser");
        try {
            model.addAttribute("staffs",securityStaffService.findSecurityStaffByWorkPlace(user.getJurisdiction()));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "reception/securitystaff/show";
    }

    //添加安保人员信息
    @ResponseBody
    @RequestMapping("/addSecurityStaff")
    public void addSecurityStaff(SecurityStaff securityStaff,  HttpServletResponse response){
        response.setContentType("text/html;charset=utf-8");
        try {
            securityStaff.setSsid(CommonUtils.uuid());
            securityStaffService.add(securityStaff);
            response.getWriter().write("succeed");
            response.getWriter().flush();
        } catch (Exception e) {
            try {
                response.getWriter().write("failed");
                response.getWriter().flush();
            } catch (IOException e1) {
                e1.printStackTrace();
            }
            e.printStackTrace();
        }

    }

    //获取指定安保人员信息
    @RequestMapping("/getStaff")
    public String getStaff(String ssid, Model model) {
        try {
            model.addAttribute("staff", securityStaffService.getStaff(ssid));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "reception/securitystaff/desc";
    }

    //移除安保人员信息
    @RequestMapping("/removeSecurityStaff")
    public void removeSecurityStaff(String ssid, HttpServletResponse response) {
        try {
            securityStaffService.remove(ssid);
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

    //更新安保人员信息
    @RequestMapping("/updateSecurityStaff")
    public void updateSecurityStaff(SecurityStaff securityStaff,  HttpServletResponse response) {
        try {
            securityStaffService.update(securityStaff);
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

    //派遣安保人员
    @RequestMapping("/assign")
    public void assign(String staffs, String eid, HttpServletResponse response) {
        String[] assign = staffs.split(",");
        try {
            for (String ssid : assign) {
                securityStaffService.assignTo(ssid,eid);
            }
            TempRecord record = tempDataService.findRecord(eid); //标记为疏导中
            if (record.getStatus() == 0) record.setStatus(1);
            tempDataService.updateRecord(record);
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

}
