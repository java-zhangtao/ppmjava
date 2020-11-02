package com.jian.stat.service.impl;

import com.jian.stat.mapper.StatMapper;
import com.jian.stat.pojo.StatEntity;
import com.jian.stat.service.StatService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service
public class StatServiceImpl implements StatService {
    @Resource
    StatMapper statMapper;
    @Override
    public List<StatEntity> loadCustomerAreaJson() {
        return this.statMapper.loadCustomerAreaJson();
    }

    @Override
    public List<StatEntity> loadOpernameYearOutstand(String year) {
        return this.statMapper.loadOpernameYearOutstand(year);
    }

    @Override
    public List<Double> loadCompanyOutstand(String year) {
        List<Double>list=this.statMapper.loadCompanyYearOutstand(year);
        for (int i = 0; i <list.size() ; i++) {
            if(null==list.get(i)){
                list.set(i,0.0);
            }
        }
        return list;
    }
}
