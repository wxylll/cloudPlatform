package cn.baimu.service.impl;

import cn.baimu.mapper.OutlierMapper;
import cn.baimu.po.Outlier;
import cn.baimu.service.OutlierService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Date;
import java.util.List;
import java.util.Map;

public class OutlierServiceImpl implements OutlierService {

    @Autowired
    private OutlierMapper outlierMapper;

    @Override
    public List<Outlier> findAll() throws Exception {
        return outlierMapper.findAll();
    }

    @Override
    public List<Outlier> combinationQuery(String position, Date startTime, Date endTime) throws Exception {
        return outlierMapper.combinationQuery(position, startTime, endTime);
    }

    @Override
    public List<Map<String, Integer>> countOutbreaks(Date startTime) throws Exception {
        return outlierMapper.countOutbreaks(startTime);
    }

    @Override
    public List<Map<String, Integer>> countCategoryOutbreaks() throws Exception {
        return outlierMapper.countCategoryOutbreaks();
    }

    @Override
    public void add(Outlier outlier) throws Exception {
        outlierMapper.add(outlier);
    }

}
