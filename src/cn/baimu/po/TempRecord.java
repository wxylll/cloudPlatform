package cn.baimu.po;

import java.util.Date;

/**
 * 封装临时记录
 */
public class TempRecord {

    private String position; //爆发地点
    private String category; //地点分类
    private Date startTime; //开始时间
    private int numberOfStaff; //派遣的安保人员数量
    private int status; //当前状态（0未处理，1疏导中，2疏导完成，3自动解除）
    private int max; //最大人流
    private int average; //平均人流
    private String eid; //来源设备
    private String uid; //处理用户

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getMax() {
        return max;
    }

    public void setMax(int max) {
        this.max = max;
    }

    public int getAverage() {
        return average;
    }

    public void setAverage(int average) {
        this.average = average;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public int getNumberOfStaff() {
        return numberOfStaff;
    }

    public void setNumberOfStaff(int numberOfStaff) {
        this.numberOfStaff = numberOfStaff;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getEid() {
        return eid;
    }

    public void setEid(String eid) {
        this.eid = eid;
    }
}
