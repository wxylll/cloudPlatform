package cn.baimu.po;

/**
 * 疏导方案封装类
 */
public class Scheme {

    private String sid; //方案id
    private String schemeName; //方案名
    private String pcid; //方案所属分类id
    private int score; //方案得分

    public String getSid() {
        return sid;
    }

    public void setSid(String sid) {
        this.sid = sid;
    }

    public String getSchemeName() {
        return schemeName;
    }

    public void setSchemeName(String schemeName) {
        this.schemeName = schemeName;
    }

    public String getPcid() {
        return pcid;
    }

    public void setPcid(String pcid) {
        this.pcid = pcid;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }
}
