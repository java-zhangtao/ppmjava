package com.jian.bus.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.jian.bus.mapper.CarMapper;
import com.jian.bus.mapper.RentMapper;
import com.jian.bus.pojo.Car;
import com.jian.bus.pojo.Rent;
import com.jian.bus.service.RentService;
import com.jian.bus.vo.CarVo;
import com.jian.bus.vo.RentVo;
import com.jian.sys.constant.SystemConstant;
import com.jian.sys.utils.DataGridView;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
public class RentServiceImpl implements RentService {
    @Resource
    RentMapper rentMapper;
    @Resource
    CarMapper carMapper;
    @Override
    public void addRent(RentVo rentVo) {
        rentVo.setCreatetime(new Date());
        rentVo.setRentflag(SystemConstant.RENT_CAR_TRUE);
        this.rentMapper.insertSelective(rentVo);
        Car car=this.carMapper.selectByPrimaryKey(rentVo.getCarnumber());
        car.setIsrenting(SystemConstant.RENT_CAR_TRUE);
        this.carMapper.updateByPrimaryKeySelective(car);
    }

    @Override
    public DataGridView loadAllRent(RentVo rentVo) {
        Page<Rent> page=PageHelper.startPage(rentVo.getPage(),rentVo.getLimit());
        List<Rent> list=this.rentMapper.loadAllRent(rentVo);
        return new DataGridView(page.getTotal(),list);
    }

    @Override
    public void updateRent(RentVo rentVo) {
        this.rentMapper.updateByPrimaryKeySelective(rentVo);
    }

    @Override
    public void deleteRent(String rentid) {
        Rent rent = this.rentMapper.selectByPrimaryKey(rentid);
        Car car = this.carMapper.selectByPrimaryKey(rent.getCarnumber());
        car.setIsrenting(SystemConstant.RENT_CAR_FALSE);
        this.carMapper.updateByPrimaryKeySelective(car);
        this.rentMapper.deleteByPrimaryKey(rentid);
    }
}
