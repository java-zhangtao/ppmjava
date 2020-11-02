package com.jian.bus.mapper;

import com.jian.bus.pojo.Car;
import com.jian.bus.vo.CarVo;

import java.util.List;

public interface CarMapper {
    int deleteByPrimaryKey(String carnumber);

    int insert(Car record);

    int insertSelective(Car record);

    Car selectByPrimaryKey(String carnumber);

    int updateByPrimaryKeySelective(Car record);

    int updateByPrimaryKey(Car record);
    //加载所有的汽车信息以及模糊查询
    List<Car> loadAllCar(Car car);
}