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

    /**
     * 根据uid和权限查找边缘端（包括直接管辖的，以及管辖范围内未被接管的边缘端）
     * @param uid
     * @param jurisdiction
     * @return
     * @throws Exception
     */
    public List<EdgeTerminal> findByJurisdiction(String uid, String jurisdiction) throws Exception;

    /**
     * 注册边缘端
     * @param position
     * @return
     * @throws Exception
     */
    public String register(String position) throws Exception;

    /**
     * 更新边缘端信息
     * @param edgeTerminal
     * @throws Exception
     */
    public void update(EdgeTerminal edgeTerminal) throws Exception;

    /**
     * 删除边缘端
     * @param eid
     * @throws Exception
     */
    public void delete(String eid) throws Exception;

    /**
     * 解除与指定用户与边缘端的绑定关系
     * @param uid
     * @throws Exception
     */
    public void unBound(String uid) throws Exception;

    /**
     * 判断边缘端是否存在
     * @param eid
     * @return
     * @throws Exception
     */
    public EdgeTerminal getEdgeTerminal(String eid) throws Exception;

}
