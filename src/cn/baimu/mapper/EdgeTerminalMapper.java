package cn.baimu.mapper;

import cn.baimu.po.EdgeTerminal;

import java.util.List;

public interface EdgeTerminalMapper {

    /**
     * 根据用户id查询边缘端
     * @param uid
     * @return
     * @throws Exception
     */
    public List<EdgeTerminal> findByUid(String uid) throws Exception;

}
