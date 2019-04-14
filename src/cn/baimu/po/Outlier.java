package cn.baimu.po;

import java.util.Date;

/**
 * 人流异常数据封装类
 */
public class Outlier {
    private String oid; //异常数据id
    private String position; //异常发生地点
    private String pcid; //地点所属分类id
    private String positionCategory; //地点所属分类
    private Date startTime; //异常开始时间
    private int duration; //异常持续时间
    private int maxFlow; //最大人流
    private int averageFlow; //平均人流
    private String video; //视频文件路径
    private String sid; //采用方案id
    private String scheme; //采用方案
    private int numberOfSecurity; //参与疏导的安保人员数量

    public String getPcid() {
        return pcid;
    }

    public void setPcid(String pcid) {
        this.pcid = pcid;
    }

    public String getSid() {
        return sid;
    }

    public void setSid(String sid) {
        this.sid = sid;
    }

    public String getPositionCategory() {
        return positionCategory;
    }

    public void setPositionCategory(String positionCategory) {
        this.positionCategory = positionCategory;
    }

    public String getScheme() {
        return scheme;
    }

    public void setScheme(String scheme) {
        this.scheme = scheme;
    }

    public String getOid() {
        return oid;
    }

    public void setOid(String oid) {
        this.oid = oid;
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

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public int getMaxFlow() {
        return maxFlow;
    }

    public void setMaxFlow(int maxFlow) {
        this.maxFlow = maxFlow;
    }

    public int getAverageFlow() {
        return averageFlow;
    }

    public void setAverageFlow(int averageFlow) {
        this.averageFlow = averageFlow;
    }

    public String getVideo() {
        return video;
    }

    public void setVideo(String video) {
        this.video = video;
    }

    public int getNumberOfSecurity() {
        return numberOfSecurity;
    }

    public void setNumberOfSecurity(int numberOfSecurity) {
        this.numberOfSecurity = numberOfSecurity;
    }

}
