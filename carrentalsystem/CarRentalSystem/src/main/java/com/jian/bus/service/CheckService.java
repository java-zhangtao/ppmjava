package com.jian.bus.service;

import com.jian.bus.pojo.Rent;
import com.jian.bus.vo.CheckVo;
import com.jian.bus.vo.RentVo;
import com.jian.sys.utils.DataGridView;

import java.util.Map;

public interface CheckService {
    //添加检查单信息
    void addCheck(CheckVo checkVo);
    //加载所有的检查信息以及模糊查询
    DataGridView loadAllCheck(CheckVo checkVo);
    //修改检查信息
    void updateCheck(CheckVo checkVo);
    //删除检查信息
    void deleteCheck(String checkid);
    //检查是否存在出租单
    Rent checkRentExist(String rentid);
    //根据出租单号 查询汽车、客户、出租单、检查单的信息
    Map<String, Object> loadAllInfoByRentId(String rentid);
}
