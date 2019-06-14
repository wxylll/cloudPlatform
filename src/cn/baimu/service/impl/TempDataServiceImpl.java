package cn.baimu.service.impl;

import cn.baimu.mapper.TempDataMapper;
import cn.baimu.po.TempData;
import cn.baimu.po.TempRecord;
import cn.baimu.service.TempDataService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class TempDataServiceImpl implements TempDataService {

    @Autowired
    private TempDataMapper tempDataMapper;

    @Override
    public void insertDataItem(TempData tempData) throws Exception {
        tempDataMapper.insertDataItem(tempData);
    }

    @Override
    public List<TempData> findAllData(String eid) throws Exception {
        return tempDataMapper.findAllData(eid);
    }

    @Override
    public void removeAllData(String eid) throws Exception {
        tempDataMapper.removeAllData(eid);
    }

    @Override
    public void insertRecord(TempRecord tempRecord) throws Exception {
        tempDataMapper.insertRecord(tempRecord);
    }

    @Override
    public List<TempRecord> findAllRecord(String uid) throws Exception {
        return tempDataMapper.findAllRecord(uid);
    }

    @Override
    public void updateRecord(TempRecord tempRecord) throws Exception {
        tempDataMapper.updateRecord(tempRecord);
    }

    @Override
    public void removeRecord(String eid) throws Exception {
        tempDataMapper.removeRecord(eid);
    }

    @Override
    public TempRecord findRecord(String eid) throws Exception {
        return tempDataMapper.findRecord(eid);
    }
}
