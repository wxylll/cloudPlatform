package cn.baimu.po;

/**
 * 边缘端
 */
public class EdgeTerminal {

    private String eid; //边缘设备id（账号）
    private String secretKey; //设备密钥
    private String uid; //设备所属前台用户id
    private String monitoring; //设备监视地点
    private String pcid; //监视地点所属分类id
    private String positionCategory; //监视地点所属分类

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

    public String getSecretKey() {
        return secretKey;
    }

    public void setSecretKey(String secretKey) {
        this.secretKey = secretKey;
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
