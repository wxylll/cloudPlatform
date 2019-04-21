package cn.baimu.controller.reception;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 实时数据处理
 */
@Controller
public class RealTimeDataController {

    @RequestMapping("/showDetail")
    public String showDetail() {
        return "jsps/reception/real_time_data/detail";
    }

}
