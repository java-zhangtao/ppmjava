package com.jian.bus.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.jian.bus.mapper.CarMapper;
import com.jian.bus.pojo.Car;
import com.jian.bus.service.CarService;
import com.jian.bus.vo.CarVo;
import com.jian.sys.utils.DataGridView;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
public class CarServiceImpl implements CarService {
    @Resource
    CarMapper carMapper;
    @Override
    public DataGridView loadAllCar(CarVo carVo) {
        Page<Car> page= PageHelper.startPage(carVo.getPage(),carVo.getLimit());
        List<Car> list = this.carMapper.loadAllCar(carVo);
        return new DataGridView(page.getTotal(),list);
    }

    @Override
    public void addCar(CarVo carVo) {
        carVo.setCreatetime(new Date());
        this.carMapper.insertSelective(carVo);
    }

    @Override
    public void updateCar(CarVo carVo) {
        this.carMapper.updateByPrimaryKeySelective(carVo);
    }

    @Override
    public void deleteCar(String id) {
        this.carMapper.deleteByPrimaryKey(id);
    }
}
