package com.jian.bus.mapper;

import com.jian.bus.pojo.Rent;
import com.jian.bus.vo.RentVo;

import java.util.List;

public interface RentMapper {
    int deleteByPrimaryKey(String rentid);

    int insert(Rent record);

    int insertSelective(Rent record);

    Rent selectByPrimaryKey(String rentid);

    int updateByPrimaryKeySelective(Rent record);

    int updateByPrimaryKey(Rent record);
    //加载所有出租信息以及模糊查询
    List<Rent> loadAllRent(Rent rent);
}