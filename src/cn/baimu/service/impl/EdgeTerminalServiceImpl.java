package cn.baimu.service.impl;

import cn.baimu.mapper.EdgeTerminalMapper;
import cn.baimu.po.EdgeTerminal;
import cn.baimu.service.EdgeTerminalService;
import cn.itcast.commons.CommonUtils;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class EdgeTerminalServiceImpl implements EdgeTerminalService {

    @Autowired
    private EdgeTerminalMapper edgeTerminalMapper;

    @Override
    public List<EdgeTerminal> getEdgeTerminals(String uid) throws Exception {
        return edgeTerminalMapper.findByUid(uid);
    }

    @Override
    public List<EdgeTerminal> findByJurisdiction(String uid, String jurisdiction) throws Exception {
        return edgeTerminalMapper.findByJurisdiction(uid, jurisdiction);
    }

    @Override
    public String register(String position) throws Exception {

        EdgeTerminal edgeTerminal = new EdgeTerminal();
        String eid = CommonUtils.uuid(); //分配id
        edgeTerminal.setEid(eid);
        edgeTerminal.setMonitoring(position); //设置监管地点
        edgeTerminal.setUid(null); //将所属用户设为空
        edgeTerminal.setStatus(0); //将边缘端状态设未监管

        if (edgeTerminalMapper.findByMonitoring(position) == 0) //如果该地点未被监管
            edgeTerminalMapper.add(edgeTerminal); //添加到数据库
        else
            return null;

        return eid;

    }

    @Override
    public void update(EdgeTerminal edgeTerminal) throws Exception {
        edgeTerminalMapper.update(edgeTerminal);
    }

    @Override
    public void delete(String eid) throws Exception {
        edgeTerminalMapper.delete(eid);
    }

    @Override
    public void unBound(String uid) throws Exception {
        edgeTerminalMapper.unBound(uid);
    }

}
