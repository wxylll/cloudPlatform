package cn.baimu.controller.reception;

import cn.baimu.websocket.handler.RealTimeTextDataHandler;
import cn.baimu.websocket.handler.RealTimeVideoDataHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

/**
 * 实时数据处理
 */
@Controller
public class RealTimeDataController {

    @Autowired
    private RealTimeVideoDataHandler realTimeVideoDataHandler;
    @Autowired
    private RealTimeTextDataHandler realTimeTextDataHandler;

    @RequestMapping("/showDetail")
    public String showDetail(@RequestParam String position, @RequestParam String eid, Model model) {
        model.addAttribute("position", position);
        return "reception/real_time_data/detail";
    }

    //推送人流数据
    @RequestMapping("/sendMessageToUser")
    public void sendMessageToUser(@RequestParam String message, @RequestParam String uid) {
            realTimeTextDataHandler.sendToUser(message, uid);
    }

    //推送视频数据
    @RequestMapping("/sendVideoToUser")
    public void sendVideoToUser(@RequestParam MultipartFile img, @RequestParam String uid) {
        try {
            realTimeVideoDataHandler.sendToUser(img.getBytes(), uid);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
