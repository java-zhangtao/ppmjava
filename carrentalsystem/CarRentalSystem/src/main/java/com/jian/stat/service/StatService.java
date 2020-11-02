package com.jian.stat.service;

import com.jian.stat.pojo.StatEntity;

import java.util.List;

public interface StatService {
    //加载所有的地区数据
    public List<StatEntity> loadCustomerAreaJson();
    //查询操作员年度业绩
    List<StatEntity> loadOpernameYearOutstand(String year);
    //查询公司年度业绩
    List<Double> loadCompanyOutstand(String year);
}
