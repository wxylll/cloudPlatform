package cn.hawkeye.service.impl;

import cn.hawkeye.mapper.Text3Mapper;
import cn.hawkeye.service.Text3Service;
import org.springframework.beans.factory.annotation.Autowired;

public class Text3Servicelmpl implements Text3Service {
    @Autowired
    private Text3Mapper text3Mapper;
    @Override
    public int print() {
        return text3Mapper.print();
    }
}
