package cn.baimu.service.impl;

import cn.baimu.mapper.SecurityStaffMapper;
import cn.baimu.po.SecurityStaff;
import cn.baimu.service.SecurityStaffService;
import com.mysql.cj.protocol.Security;
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

    @Override
    public void update(SecurityStaff securityStaff) throws Exception {
        securityStaffMapper.update(securityStaff);
    }

    @Override
    public void remove(String ssid) throws Exception {
        securityStaffMapper.remove(ssid);
    }

    @Override
    public SecurityStaff getStaff(String ssid) throws Exception {
        return securityStaffMapper.getStaff(ssid);
    }

    @Override
    public List<SecurityStaff> findFree(String workPlace) throws Exception {
        return securityStaffMapper.findFree(workPlace);
    }

    @Override
    public void assignTo(String ssid, String eid) throws Exception {
        SecurityStaff staff = securityStaffMapper.getStaff(ssid);
        staff.setWorkStatus(true);
        staff.setAssign(eid);
        securityStaffMapper.update(staff);
    }

    @Override
    public void freeStaffs(String eid) throws Exception {
        List<SecurityStaff> staffs = securityStaffMapper.findByAssign(eid);
        if (staffs != null) {
            for (SecurityStaff staff : staffs) {
                staff.setWorkStatus(false);
                staff.setAssign(null);
                securityStaffMapper.update(staff);
            }
        }
    }

}
