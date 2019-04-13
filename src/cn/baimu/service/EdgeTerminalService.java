package cn.baimu.service;

import cn.baimu.po.EdgeTerminal;

import java.util.List;

public interface EdgeTerminalService {

    /**
     * 获取用户所管理的边缘端
     * @param uid
     * @return
     * @throws Exception
     */
    public List<EdgeTerminal> getEdgeTerminals(String uid) throws Exception;

}
