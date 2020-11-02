package com.jian.bus.mapper;

import com.jian.bus.pojo.Check;
import com.jian.bus.vo.CheckVo;

import java.util.List;

public interface CheckMapper {
    int deleteByPrimaryKey(String checkid);

    int insert(Check record);

    int insertSelective(Check record);

    Check selectByPrimaryKey(String checkid);

    int updateByPrimaryKeySelective(Check record);

    int updateByPrimaryKey(Check record);
    //加载所有检查单信息以及模糊查询
    List<Check> loadAllCheck(CheckVo checkVo);
}