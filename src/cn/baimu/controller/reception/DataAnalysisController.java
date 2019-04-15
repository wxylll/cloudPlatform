package cn.baimu.controller.reception;

import cn.baimu.mapper.PositionCategoryMapper;
import cn.baimu.mapper.SchemeMapper;
import cn.baimu.po.Outlier;
import cn.baimu.po.PositionCategory;
import cn.baimu.po.Scheme;
import cn.baimu.service.OutlierService;
import cn.itcast.commons.CommonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.*;

/**
 * 前台数据分析
 */
@Controller
public class DataAnalysisController {

    @Autowired
    private OutlierService outlierService;

    @RequestMapping("/showOutliers")
    public String showOutliers(Model model) {
        try {
            model.addAttribute("categoryOutliers",outlierService.countCategoryOutbreaks());
            model.addAttribute("outliers",outlierService.countOutbreaks(null));
            model.addAttribute("outliers2",outlierService.findAll());
            System.out.println(outlierService.countCategoryOutbreaks());
            for (Map<String,Integer> entry : outlierService.countCategoryOutbreaks()) {
                System.out.println(entry.entrySet());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "jsps/test";
    }

    //创建模拟数据
    @Autowired
    private PositionCategoryMapper positionCategoryMapper;
    @Autowired
    private SchemeMapper schemeMapper;
    @RequestMapping("/createData")
    public void createData() throws Exception {
        Random random = new Random();
        String[] positions = {"长春工业大学校门口","长春工业大学食堂","长春工业大学5栋","长春工业大学主楼","长春工业大学图书馆","长春工业大学男厕所","长春工业大学篮球场","长春工业大学足球场"};
        List<PositionCategory> positionCategories = positionCategoryMapper.findAll();
        List<Outlier> list = new ArrayList<>();
        for (int i = 0,size = positionCategories.size(); i < positions.length; i++) {
            Outlier outlier = new Outlier();
            outlier.setPosition(positions[i]);
            outlier.setPcid(positionCategories.get(i%size).getPcid());
            list.add(outlier);
        }
        for (int i = 0,size = list.size(); i < 200; i++) {
            Outlier outlier = list.get(random.nextInt(size));
            List<Scheme> schemes = schemeMapper.findByCategory(outlier.getPcid());
            outlier.setSid(schemes.get(random.nextInt(schemes.size())).getSid());
            outlier.setOid(CommonUtils.uuid());
            outlier.setStartTime(new Date(new Date().getTime() + random.nextInt()));
            outlier.setDuration(random.nextInt());
            outlier.setMaxFlow(random.nextInt(2000) + 500);
            outlier.setAverageFlow(random.nextInt(2000) + 500);
            outlier.setVideo("-----");
            outlier.setNumberOfSecurity(random.nextInt(50));
            outlierService.add(outlier);
        }
    }

}
