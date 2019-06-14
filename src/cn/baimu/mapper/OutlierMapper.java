package cn.baimu.mapper;

import cn.baimu.po.Outlier;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * OutlierMapper
 */
public interface OutlierMapper {

    /*
     *获取所有异常数据
     */
    public List<Outlier> findAll() throws Exception;

    /**
     * 组合查询异常数据
     * @param position 异常发生地点，null为无限制
     * @param startTime 时间范围左边界，null为无限制
     * @param endTime 时间范围右边界，null为无限制
     * @return
     * @throws Exception
     */
    public List<Outlier> combinationQuery(String position, Date startTime, Date endTime) throws Exception;

    /**
     * 统计人流爆发次数
     * @return
     */
    public List<Map<String,Integer>> countOutbreaks(String jurisdiction) throws Exception;

    /**
     * 统计各个地点分类下的人流爆发次数
     * @return
     * @throws Exception
     */
    public List<Map<String,Integer>> countCategoryOutbreaks() throws Exception;

    /**
     * 插入异常数据
     * @param outlier
     * @throws Exception
     */
    public void add(Outlier outlier) throws Exception;

}
