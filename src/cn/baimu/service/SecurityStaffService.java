package cn.baimu.service;

import cn.baimu.po.SecurityStaff;

import java.util.List;

public interface SecurityStaffService {

    /**
     * 通过任职地点查询安保人员
     * @return
     * @throws Exception
     */
    public List<SecurityStaff> findSecurityStaffByWorkPlace(String workPlace) throws Exception;

    /**
     * 添加安保人员
     * @param securityStaff
     * @throws Exception
     */
    public void add(SecurityStaff securityStaff) throws Exception;

    /**
     * 更新安保人员
     * @param securityStaff
     * @throws Exception
     */
    public void update(SecurityStaff securityStaff) throws Exception;

    /**
     * 删除安保人员
     * @param ssid
     * @throws Exception
     */
    public void remove(String ssid) throws Exception;

    /**
     * 获取指定安保人员信息
     * @param ssid
     * @return
     * @throws Exception
     */
    public SecurityStaff getStaff(String ssid) throws Exception;

    /**
     * 查找空闲的安保人员
     * @param workPlace
     * @return
     * @throws Exception
     */
    public List<SecurityStaff> findFree(String workPlace) throws Exception;

    /**
     * 指派安保人员
     * @param eid
     * @throws Exception
     */
    public void assignTo(String ssid, String eid) throws Exception;

    /**
     * 解除安保人员任务
     * @param eid
     * @throws Exception
     */
    public void freeStaffs(String eid) throws Exception;

}
