package cn.baimu.controller.backstage;

import cn.baimu.po.PositionCategory;
import cn.baimu.service.PositionCategoryService;
import cn.itcast.commons.CommonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
public class PositionCategoryController {

    @Autowired
    private PositionCategoryService positionCategoryService;

    //获取所有分类并显示
    @RequestMapping("/showPositionCategorys")
    public String showPositionCategorys(Model model) {
        try {
            model.addAttribute("allCategory", positionCategoryService.findAll());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "backstage/category/show";
    }

    //添加分类
    @RequestMapping("/addCategory")
    public void addCategory(PositionCategory positionCategory, HttpServletResponse response) {
        try {
            positionCategory.setPcid(CommonUtils.uuid());
            positionCategoryService.add(positionCategory);
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

    //更新分类信息
    @RequestMapping("/updateCategory")
    public void updateCategory(PositionCategory positionCategory, HttpServletResponse response) {
        try {
            positionCategoryService.update(positionCategory);
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

    //删除分类
    @RequestMapping("/removeCategory")
    public void removeCategory(String pcid, HttpServletResponse response) {
        response.setCharacterEncoding("utf-8");
        try {
            if (positionCategoryService.isUsed(pcid) > 0) {
                response.getWriter().write("删除失败，该分类被使用，无法删除！");
                return;
            }
            positionCategoryService.remove(pcid);
            response.getWriter().write("succeed");
        } catch (Exception e) {
            try {
                response.getWriter().write("删除失败！");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
            e.printStackTrace();
        }
    }

    //获取指定分类信息
    @RequestMapping("/getCategory")
    public String getCategory(String pcid, Model model) {
        try {
            model.addAttribute("category", positionCategoryService.get(pcid));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "backstage/category/desc";
    }

}
