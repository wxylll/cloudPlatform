package cn.baimu.service;

import cn.baimu.po.PositionCategory;

import java.util.List;

public interface PositionCategoryService {

    /**
     * 获取所有分类
     * @return
     * @throws Exception
     */
    public List<PositionCategory> findAll() throws Exception;

    /**
     * 插入新分类
     * @param positionCategory
     * @throws Exception
     */
    public void add(PositionCategory positionCategory) throws Exception;

}
