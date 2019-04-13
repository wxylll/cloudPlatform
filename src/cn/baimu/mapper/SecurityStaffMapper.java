package cn.baimu.mapper;

import cn.baimu.po.SecurityStaff;

import java.util.List;

/**
 * SecurityStaffMapper
 */
public interface SecurityStaffMapper {

    //根据在职地点查询安保人员
    public List<SecurityStaff> findSecurityStaffByWorkPlace(String workPlace) throws Exception;

}
