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

    /**
     * 更新分类信息
     * @param positionCategory
     * @throws Exception
     */
    public void update(PositionCategory positionCategory) throws Exception;

    /**
     * 删除分类
     * @param pcid
     * @throws Exception
     */
    public void remove(String pcid) throws Exception;

    /**
     * 获取指定分类信息
     * @param pcid
     * @throws Exception
     */
    public PositionCategory get(String pcid) throws Exception;

    /**
     * 判断分类是被使用
     * @param pcid
     * @return
     * @throws Exception
     */
    public int isUsed(String pcid) throws Exception;

}
