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

    @Override
    public void update(PositionCategory positionCategory) throws Exception {
        positionCategoryMapper.update(positionCategory);
    }

    @Override
    public void remove(String pcid) throws Exception {
        positionCategoryMapper.remove(pcid);
    }

    @Override
    public PositionCategory get(String pcid) throws Exception {
        return positionCategoryMapper.get(pcid);
    }

    @Override
    public int isUsed(String pcid) throws Exception {
        return positionCategoryMapper.isUsed(pcid);
    }
}
