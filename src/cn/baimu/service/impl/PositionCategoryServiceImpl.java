package cn.baimu.service.impl;

import cn.baimu.mapper.PositionCategoryMapper;
import cn.baimu.po.PositionCategory;
import cn.baimu.service.PositionCategoryService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class PositionCategoryServiceImpl implements PositionCategoryService {

    @Autowired
    private PositionCategoryMapper positionCategoryMapper;

    @Override
    public List<PositionCategory> findAll() throws Exception {
        return positionCategoryMapper.findAll();
    }

    @Override
    public void add(PositionCategory positionCategory) throws Exception {
        positionCategoryMapper.add(positionCategory);
    }
}
