package cn.baimu.po;

/**
 * 地点分类信息封装类
 */
public class PositionCategory {

    private String pcid; //分类id
    private String categoryName; //分类名

    public String getPcid() {
        return pcid;
    }

    public void setPcid(String pcid) {
        this.pcid = pcid;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
}
