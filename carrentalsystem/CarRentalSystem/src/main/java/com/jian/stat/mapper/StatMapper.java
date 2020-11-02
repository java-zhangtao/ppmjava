package com.jian.stat.mapper;

import com.jian.stat.pojo.StatEntity;

import java.util.List;

public interface StatMapper {
    //查询所有的客户地区
    public List<StatEntity> loadCustomerAreaJson();
    //查询操作员年度业绩
    List<StatEntity> loadOpernameYearOutstand(String year);
    //查询公司年度业绩
    List<Double> loadCompanyYearOutstand(String year);
}
