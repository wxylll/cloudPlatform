package cn.baimu.controller.reception;

import cn.baimu.mapper.PositionCategoryMapper;
import cn.baimu.mapper.SchemeMapper;
import cn.baimu.po.Outlier;
import cn.baimu.po.PositionCategory;
import cn.baimu.po.Scheme;
import cn.baimu.po.User;
import cn.baimu.service.OutlierService;
import cn.itcast.commons.CommonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * 前台数据分析
 */
@Controller
public class DataAnalysisController {

    @Autowired
    private OutlierService outlierService;

    //显示所有异常数据
    @RequestMapping("/showOutliers")
    public String showOutliers(Model model, HttpSession session) {
        User user = (User) session.getAttribute("receptionUser");
        try {
            model.addAttribute("categoryOutliers",outlierService.countCategoryOutbreaks());
            model.addAttribute("outliers",outlierService.countOutbreaks(user.getJurisdiction()));
            model.addAttribute("detailOutliers",outlierService.combinationQuery(user.getJurisdiction(),null,null));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "reception/data_analysis/show";
    }

    //显示某个异常地点的详细数据
    @RequestMapping("/showDetails")
    public String showDetails(@RequestParam String position, Model model) {
        try {
            model.addAttribute("outliers",outlierService.combinationQuery(position,null,null));
            model.addAttribute("position",position);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "reception/data_analysis/desc";
    }

}
