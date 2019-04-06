package cn.baimu.po;

/**
 * 前台用户信息封装
 * @author wxy
 */
public class User {

    private String id; //用户id
    private String username; //用户名
    private String password; //密码
    private String jurisdiction; //管辖范围

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getJurisdiction() {
        return jurisdiction;
    }

    public void setJurisdiction(String jurisdiction) {
        this.jurisdiction = jurisdiction;
    }
}
