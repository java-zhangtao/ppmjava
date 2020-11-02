package com.jian.bus.service;

import com.jian.bus.vo.CarVo;
import com.jian.sys.utils.DataGridView;

public interface CarService {
    //加载所有的汽车信息 以及模糊查询
    DataGridView loadAllCar(CarVo carVo);
    //添加汽车
    void addCar(CarVo carVo);
    //修改汽车
    void updateCar(CarVo carVo);
    //删除汽车
    void deleteCar(String id);
}
