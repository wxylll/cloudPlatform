package cn.baimu.mapper;

import cn.baimu.po.Outlier;

import java.util.Date;
import java.util.List;

public interface OutlierMapper {

    /*
     *获取所有异常数据
     */
    public List<Outlier> findAll() throws Exception;

    /**
     * 组合查询异常数据
     * @param position 异常发生地点
     * @param startTime 时间范围左边界，null为无限制
     * @param endTime 时间范围右边界，null为无限制
     * @return
     */
    public List<Outlier> combinationQuery(String position, Date startTime, Date endTime) throws Exception;

}
