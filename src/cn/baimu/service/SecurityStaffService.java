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

}
