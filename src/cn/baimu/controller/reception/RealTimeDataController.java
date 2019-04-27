package cn.baimu.controller.reception;

import cn.baimu.websocket.handler.WebsocketEndPoint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.IOException;

/**
 * 实时数据处理
 */
@Controller
public class RealTimeDataController {

    @Autowired
    private WebsocketEndPoint websocketEndPoint;

    @RequestMapping("/showDetail")
    public String showDetail() {
        return "reception/real_time_data/detail";
    }

    @RequestMapping("/send")
    public void send(String message) {
        try {
            websocketEndPoint.sendMessage(message);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
