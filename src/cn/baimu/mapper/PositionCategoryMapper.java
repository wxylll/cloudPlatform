package cn.baimu.mapper;

import cn.baimu.po.PositionCategory;

import java.util.List;

public interface PositionCategoryMapper {

    //获取所有分类
    public List<PositionCategory> findAll();

}
