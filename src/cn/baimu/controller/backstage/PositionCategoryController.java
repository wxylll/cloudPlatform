package cn.baimu.controller.backstage;

import cn.baimu.service.PositionCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/backstage")
public class PositionCategoryController {

    @Autowired
    private PositionCategoryService positionCategoryService;

    @RequestMapping("/showPositionCategorys")
    public String showPositionCategorys() {
        return "";
    }

}
