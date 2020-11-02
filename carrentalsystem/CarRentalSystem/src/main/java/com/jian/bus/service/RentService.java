package com.jian.bus.service;

import com.jian.bus.vo.CarVo;
import com.jian.bus.vo.RentVo;
import com.jian.sys.utils.DataGridView;

public interface RentService {
    //添加出租单信息
    void addRent(RentVo rentVo);
    //加载所有的出租信息以及模糊查询
    DataGridView loadAllRent(RentVo rentVo);
    //修改出租信息
    void updateRent(RentVo rentVo);
    //删除出租信息
    void deleteRent(String rentid);
}
