package cn.baimu.service.impl;

import cn.baimu.mapper.SecurityStaffMapper;
import cn.baimu.po.SecurityStaff;
import cn.baimu.service.SecurityStaffService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class SecurityStaffServiceImpl implements SecurityStaffService {

    @Autowired
    private SecurityStaffMapper securityStaffMapper;

    @Override
    public List<SecurityStaff> findSecurityStaffByWorkPlace(String workPlace) throws Exception {
        return securityStaffMapper.findSecurityStaffByWorkPlace(workPlace);
    }

    @Override
    public void add(SecurityStaff securityStaff) throws Exception {
        securityStaffMapper.add(securityStaff);
    }

}
