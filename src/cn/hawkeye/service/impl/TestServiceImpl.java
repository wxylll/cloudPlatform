package cn.hawkeye.service.impl;

import cn.hawkeye.mapper.TestMapper;
import cn.hawkeye.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;

public class TestServiceImpl implements TestService {

    @Autowired
    private TestMapper testMapper;

    @Override
    public int count() {
        return testMapper.count();
    }
}
