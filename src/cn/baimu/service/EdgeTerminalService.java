package cn.baimu.service;

import cn.baimu.po.EdgeTerminal;

import java.util.List;

/**
 * 边缘端service
 */
public interface EdgeTerminalService {

    /**
     * 获取用户所管理的边缘端
     * @param uid
     * @return
     * @throws Exception
     */
    public List<EdgeTerminal> getEdgeTerminals(String uid) throws Exception;

}
