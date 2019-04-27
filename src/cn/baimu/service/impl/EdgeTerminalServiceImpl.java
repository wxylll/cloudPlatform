package cn.baimu.service.impl;

import cn.baimu.mapper.EdgeTerminalMapper;
import cn.baimu.po.EdgeTerminal;
import cn.baimu.service.EdgeTerminalService;
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
    public void add(EdgeTerminal edgeTerminal) throws Exception {
        edgeTerminalMapper.add(edgeTerminal);
    }

}
