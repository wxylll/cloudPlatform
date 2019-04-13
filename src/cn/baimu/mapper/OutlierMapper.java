package cn.baimu.mapper;

import cn.baimu.po.Outlier;

import java.util.List;

public interface OutlierMapper {

    //获取所有异常数据
    public List<Outlier> findAll();

}
