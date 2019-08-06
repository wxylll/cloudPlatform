package cn.baimu.po;

import java.util.Date;

/**
 * 封装临时数据
 */
public class TempData {

    private int now; //当前人流
    private Date time; //数据获取时间
    private String eid; //数据来源

    public String getEid() {
        return eid;
    }

    public void setEid(String eid) {
        this.eid = eid;
    }

    public int getNow() {
        return now;
    }

    public void setNow(int now) {
        this.now = now;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }
}
