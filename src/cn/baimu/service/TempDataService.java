package cn.baimu.service;

import cn.baimu.po.TempData;
import cn.baimu.po.TempRecord;

import java.util.List;

public interface TempDataService {

    /**
     * 插入临时数据
     * @param tempData
     * @throws Exception
     */
    public void insertDataItem(TempData tempData) throws Exception;

    /**
     * 获取指定设备的所有临时数据
     * @param eid
     * @return
     * @throws Exception
     */
    public List<TempData> findAllData(String eid) throws Exception;

    /**
     * 删除指定设备的所有临时数据
     * @param eid
     * @throws Exception
     */
    public void removeAllData(String eid) throws Exception;

    /**
     * 插入新临时记录
     * @param tempRecord
     * @throws Exception
     */
    public void insertRecord(TempRecord tempRecord) throws Exception;

    /**
     *获取指定用户的所有临时记录
     * @param uid
     * @return
     * @throws Exception
     */
    public List<TempRecord> findAllRecord(String uid) throws Exception;

    /**
     * 更新临时记录
     * @param tempRecord
     * @throws Exception
     */
    public void updateRecord(TempRecord tempRecord) throws Exception;

    /**
     * 删除临时记录
     * @param eid
     * @throws Exception
     */
    public void removeRecord(String eid) throws Exception;

    /**
     * 获取指定临时记录
     * @param eid
     * @return
     * @throws Exception
     */
    public TempRecord findRecord(String eid) throws Exception;

}
