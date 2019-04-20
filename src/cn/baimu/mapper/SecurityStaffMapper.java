package cn.baimu.mapper;

import cn.baimu.po.SecurityStaff;

import java.util.List;

/**
 * SecurityStaffMapper
 */
public interface SecurityStaffMapper {

    /**
     * 根据在职地点查询安保人员
     * @param workPlace
     * @return
     * @throws Exception
     */
    public List<SecurityStaff> findSecurityStaffByWorkPlace(String workPlace) throws Exception;

}
