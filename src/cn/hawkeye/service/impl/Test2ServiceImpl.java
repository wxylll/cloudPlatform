package cn.hawkeye.service.impl;

import cn.hawkeye.mapper.Test2Mapper;
import cn.hawkeye.service.Test2Service;
import org.springframework.beans.factory.annotation.Autowired;

public class Test2ServiceImpl implements Test2Service {

    @Autowired
    private Test2Mapper test2Mapper;

    @Override
    public int count() {
        return test2Mapper.count1();
    }
}
