package cn.baimu.controller.reception;

import cn.baimu.po.*;
import cn.baimu.service.EdgeTerminalService;
import cn.baimu.service.OutlierService;
import cn.baimu.service.SecurityStaffService;
import cn.baimu.service.TempDataService;
import cn.baimu.utils.MapUtil;
import cn.baimu.websocket.handler.RealTimeTextDataHandler;
import cn.baimu.websocket.handler.RealTimeVideoDataHandler;
import cn.itcast.commons.CommonUtils;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 实时数据处理
 */
@Controller
public class RealTimeDataController {

    @Autowired
    private RealTimeVideoDataHandler realTimeVideoDataHandler;
    @Autowired
    private RealTimeTextDataHandler realTimeTextDataHandler;
    @Autowired
    private SecurityStaffService securityStaffService;
    @Autowired
    private EdgeTerminalService edgeTerminalService;
    @Autowired
    private TempDataService tempDataService;
    @Autowired
    private OutlierService outlierService;

    //显示正在异常爆发的地点和疏导完成的爆发记录
    @RequestMapping("/showBreakOut")
    public String showBreakOut(HttpSession httpSession, Model model) {
        User user = (User) httpSession.getAttribute("receptionUser");
        try {
            model.addAttribute("records", tempDataService.findAllRecord(user.getUid()));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "reception/real_time_data/guidance";
    }

    //显示某一地点详细数据
    @RequestMapping("/showDetail")
    public String showDetail(@RequestParam String eid, Model model, HttpSession httpSession) {
        User user = (User) httpSession.getAttribute("receptionUser");
        try {
            TempRecord tempRecord = tempDataService.findRecord(eid);
            EdgeTerminal edgeTerminal = edgeTerminalService.getEdgeTerminal(eid);
            model.addAttribute("edgeTerminal", edgeTerminal);

            if (tempRecord == null || tempRecord.getStatus() > 1)  //无数据则转到提示页面
                return "reception/real_time_data/no_data";

            List<TempData> tempDatas = tempDataService.findAllData(eid);

            Date begin = tempRecord.getStartTime();
            String lastTime = getLastTime(begin);

            List<SecurityStaff> frees = null;
            if (tempRecord.getStatus() == 0) { //匹配合适的安保人员
                frees = securityStaffService.findFree(user.getJurisdiction());
                for (SecurityStaff staff : frees) {
                    String distanceAndTime = MapUtil.getDistanceAndTime(staff.getWorkPlace(),tempRecord.getPosition());
                    if (distanceAndTime != null && !distanceAndTime.trim().equals("")) {
                        int distance = Integer.valueOf(distanceAndTime.split(":")[0]);
                        int time = Integer.valueOf(distanceAndTime.split(":")[1]);
                        staff.setDistance(distance);
                        staff.setTime(time);
                    }
                }
            }

            model.addAttribute("tempDatas",tempDatas);
            model.addAttribute("tempRecord",tempRecord);
            model.addAttribute("lastTime",lastTime);
            model.addAttribute("staffs", frees);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "reception/real_time_data/detail";
    }

    //计算持续时间
    private String getLastTime(Date begin) {
        Date now = new Date();
        int ms = (int) (now.getTime() - begin.getTime());
        int second = (ms/1000) % 60;
        int minute = (ms/(1000*60)) % 60;
        int hour = (ms/(1000*60*60)) % 60;
        return String.format("%02d", hour) + ":" + String.format("%02d", minute) + ":" + String.format("%02d", second);
    }

    //推送人流数据
    @ResponseBody
    @RequestMapping("/sendMessageToUser")
    public void sendMessageToUser(@RequestParam String message, @RequestParam String uid) {
        try {
            realTimeTextDataHandler.sendToUser(message, uid);
            DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String[] data = message.substring(5).split(",");
            TempData tempData = new TempData();
            tempData.setNow(Integer.valueOf(data[0]));
            tempData.setTime(format.parse(data[1]));
            tempData.setEid(data[2]);
            tempDataService.insertDataItem(tempData); //保存临时数据
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/testSend")
    public void test(@RequestParam String message, @RequestParam String uid) {
        realTimeTextDataHandler.sendToUser(message, uid);
    }

    //推送视频数据
    @ResponseBody
    @RequestMapping("/sendVideoToUser")
    public void sendVideoToUser(@RequestParam MultipartFile img, @RequestParam String uid, @RequestParam String eid) {
        try {
            realTimeVideoDataHandler.sendToUser(img.getBytes(), uid + eid);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //标记爆发开始
    @ResponseBody
    @RequestMapping("/burstStart")
    public void burstStart(String eid, String startTime, String uid, HttpServletResponse response) {
        try {
            EdgeTerminal edgeTerminal = edgeTerminalService.getEdgeTerminal(eid);

            DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

            TempRecord tempRecord = new TempRecord();
            tempRecord.setPosition(edgeTerminal.getMonitoring()); //设置地点
            tempRecord.setCategory(edgeTerminal.getPositionCategory()); //设置分类
            tempRecord.setStartTime(format.parse(startTime)); //设置开始时间
            tempRecord.setStatus(0); //设置状态
            tempRecord.setEid(eid); //设置设备id
            tempRecord.setUid(uid); //设置用户id

            tempDataService.insertRecord(tempRecord); //插入记录

            realTimeTextDataHandler.sendToUser("msg:burst" + eid, uid); //通知用户有异常发生
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

    //爆发结束
    @ResponseBody
    @RequestMapping("/burstEnd")
    public void burstEnd(@RequestParam String eid , @RequestParam String uid, HttpServletResponse response) {
        TempRecord tempRecord = null;
        try {
            tempRecord = tempDataService.findRecord(eid);
            if (tempRecord == null) {
                response.getWriter().write("failed");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            try {
                response.getWriter().write("failed");
                return;
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }

        //标志此次异常结束
        if (tempRecord.getStatus() == 0) { //如果未进行疏导，则标记为自动解除
            tempRecord.setStatus(3);
        } else if (tempRecord.getStatus() == 1) { //如正在进行疏导则标记为疏导完成
            tempRecord.setStatus(2);
        }
        try {
            tempDataService.updateRecord(tempRecord);
            securityStaffService.freeStaffs(eid); //解除疏导安保人员的任务
            realTimeTextDataHandler.sendToUser("msg:end" + eid,uid);
        } catch (Exception e) {
            e.printStackTrace();
            try {
                response.getWriter().write("failed");
                return;
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
        try {
            response.getWriter().write("succeed");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //上传异常视频
    @ResponseBody
    @RequestMapping("/uploadVideo")
    public void uploadVideo(@RequestParam MultipartFile video, @RequestParam String eid , HttpServletRequest request, HttpServletResponse response) {
        //获取此次记录,及对应的边缘端信息
        TempRecord tempRecord = null;
        EdgeTerminal edgeTerminal = null;
        try {
            tempRecord = tempDataService.findRecord(eid);
            edgeTerminal = edgeTerminalService.getEdgeTerminal(eid);
        } catch (Exception e) {
            e.printStackTrace();
            try {
                response.getWriter().write("failed");
                return;
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }

        //保存视频文件
        String oldName = video.getOriginalFilename();
        String relativePath = "video/"+ eid + "/";
        String path = request.getSession().getServletContext().getRealPath("/") + relativePath;
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd~HH-mm-ss");
        String newName = format.format(tempRecord.getStartTime()) + oldName.substring(oldName.indexOf(".")); //将爆发时间作为视频文件的名称
        File dir = new File(path);
        if (!dir.exists()) {
            dir.mkdir();
        }
        File saveTo = new File(path + newName);

        try {
            FileUtils.copyInputStreamToFile(video.getInputStream(), saveTo);
        } catch (IOException e) {
            e.printStackTrace();
            try {
                response.getWriter().write("failed");
                return;
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }

        //整理保存此次异常记录
        Outlier outlier = new Outlier();
        outlier.setOid(CommonUtils.uuid()); //设置异常数据id
        outlier.setPosition(edgeTerminal.getMonitoring()); //设置爆发地点
        outlier.setStartTime(tempRecord.getStartTime()); //设置爆发开始时间
        outlier.setPcid(edgeTerminal.getPcid()); //设置地点分类
        outlier.setMaxFlow(tempRecord.getMax()); //设置最大人流
        outlier.setAverageFlow(tempRecord.getAverage()); //设置平均人流
        outlier.setNumberOfSecurity(tempRecord.getNumberOfStaff()); //设置参与疏导的安保人员数量
        int duration = (int)(new Date().getTime() - tempRecord.getStartTime().getTime());
        outlier.setDuration(duration); //设置持续时间
        outlier.setVideo(relativePath + newName); //设置视频数据保存路径
        try {
            outlierService.add(outlier); //保存异常数据到数据库
            tempDataService.removeAllData(eid); //删除所有临时记录
        } catch (Exception e) {
            e.printStackTrace();
            try {
                response.getWriter().write("failed");
                return;
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }

        try {
            response.getWriter().write("succeed"); //返回成功信息
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //删除临时记录
    @RequestMapping("/removeRecord")
    public void removeRecord(String eid, HttpServletResponse response) {
        try {
            tempDataService.removeRecord(eid);
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
