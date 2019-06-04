package cn.baimu.controller.reception;

import cn.baimu.websocket.handler.RealTimeDataHandler;
import cn.baimu.websocket.handler.RealTimeVideoDataHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

/**
 * 实时数据处理
 */
@Controller
public class RealTimeDataController {

    @Autowired
    private RealTimeVideoDataHandler realTimeVideoDataHandler;
    @Autowired
    private RealTimeDataHandler realTimeDataHandler;

    @RequestMapping("/showDetail")
    public String showDetail(@RequestParam String position, Model model) {
        model.addAttribute("position", position);
        return "reception/real_time_data/detail";
    }

    @RequestMapping("/send")
    public void send(@RequestParam String message) {
        try {
            realTimeDataHandler.sendMessage(message,"");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/send2")
    public void send2(@RequestParam MultipartFile img, @RequestParam String test) {
        try {
            realTimeVideoDataHandler.sendToUser(img.getBytes(),"123");
        } catch (Exception e) {
            e.printStackTrace();
        }
//        OpenCVFrameGrabber grabber = new OpenCVFrameGrabber(0);
//        try {
//            grabber.start();   //开始获取摄像头数据
//        } catch (FrameGrabber.Exception e) {
//            System.out.println("这出错了");
//            e.printStackTrace();
//        }
//        OpenCVFrameConverter.ToIplImage converter = new OpenCVFrameConverter.ToIplImage();
//
//        while(true) {
//            Frame img = null;
//            try {
//                img = grabber.grab();
//            } catch (FrameGrabber.Exception e) {
//                System.out.println("这出错了2");
//                e.printStackTrace();
//            }
//            opencv_core.IplImage image = converter.convertToIplImage(img);
//            BufferedImage bufferedImage = new BufferedImage(image.width(),
//                    image.height(), BufferedImage.TYPE_3BYTE_BGR);
//            ByteArrayOutputStream baos = new ByteArrayOutputStream();
//            WritableRaster raster = bufferedImage.getRaster();
//            DataBufferByte dataBuffer = (DataBufferByte) raster.getDataBuffer();
//            byte[] data = dataBuffer.getData();
//            ((ByteBuffer) image.createBuffer()).get(data);
//            try {
//                ImageIO.write(bufferedImage,"jpg",baos);
//            } catch (IOException e) {
//                System.out.println("这出错了3");
//                e.printStackTrace();
//            }
//            data = baos.toByteArray();
//            realTimeDataHandler.sendVideo(data,"123");
//
//            try {
//                Thread.sleep(100);//10毫秒刷新一次图像
//            } catch (InterruptedException e) {
//                e.printStackTrace();
//            }
//        }
    }

}
