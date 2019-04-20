package cn.baimu.mapper;

import cn.baimu.po.Scheme;

import java.util.List;

/**
 * SchemeMapper
 */
public interface SchemeMapper {

    /**
     * 获取分类下所有方案
     * @return
     */
    public List<Scheme> findByCategory(String pcid);

}
