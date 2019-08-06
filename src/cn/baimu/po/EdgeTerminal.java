package cn.baimu.po;

/**
 * 边缘端
 */
public class EdgeTerminal {

    private String eid; //边缘设备id
    private String uid; //设备所属前台用户id
    private String monitoring; //设备监视地点
    private String pcid; //监视地点所属分类id
    private String positionCategory; //监视地点所属分类
    private int status; //设备状态（0未监管，1已监管）
    private int threshold; //人流阈值
    private boolean isOnline; //设备是否在线

    public int getThreshold() {
        return threshold;
    }

    public void setThreshold(int threshold) {
        this.threshold = threshold;
    }

    public boolean isOnline() {
        return isOnline;
    }

    public void setOnline(boolean online) {
        isOnline = online;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getPositionCategory() {
        return positionCategory;
    }

    public void setPositionCategory(String positionCategory) {
        this.positionCategory = positionCategory;
    }

    public String getEid() {
        return eid;
    }

    public void setEid(String eid) {
        this.eid = eid;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getMonitoring() {
        return monitoring;
    }

    public void setMonitoring(String monitoring) {
        this.monitoring = monitoring;
    }

    public String getPcid() {
        return pcid;
    }

    public void setPcid(String pcid) {
        this.pcid = pcid;
    }
}
