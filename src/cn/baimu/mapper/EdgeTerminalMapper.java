package cn.baimu.mapper;

import cn.baimu.po.EdgeTerminal;

import java.util.List;

/**
 * EdgeTerminalMapper
 */
public interface EdgeTerminalMapper {

    /**
     * 根据用户id查询边缘端
     * @param uid
     * @return
     * @throws Exception
     */
    public List<EdgeTerminal> findByUid(String uid) throws Exception;

    /**
     * 根据uid和权限查找边缘端
     * @param uid
     * @param jurisdiction
     * @return
     * @throws Exception
     */
    public List<EdgeTerminal> findByJurisdiction(String uid, String jurisdiction) throws Exception;

    /**
     * 新增边缘端
     * @param edgeTerminal
     * @throws Exception
     */
    public void add(EdgeTerminal edgeTerminal) throws Exception;

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
     * 根据监管地点获取设备
     * @param monitoring
     * @throws Exception
     */
    public int findByMonitoring(String monitoring) throws Exception;

}
