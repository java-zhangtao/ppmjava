package com.jian.bus.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.jian.bus.mapper.CarMapper;
import com.jian.bus.mapper.CheckMapper;
import com.jian.bus.mapper.CustomerMapper;
import com.jian.bus.mapper.RentMapper;
import com.jian.bus.pojo.Car;
import com.jian.bus.pojo.Check;
import com.jian.bus.pojo.Customer;
import com.jian.bus.pojo.Rent;
import com.jian.bus.service.CheckService;
import com.jian.bus.vo.CheckVo;
import com.jian.sys.constant.SystemConstant;
import com.jian.sys.pojo.User;
import com.jian.sys.utils.DataGridView;
import com.jian.sys.utils.RandomUtils;
import com.jian.sys.utils.WebUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CheckServiceImpl implements CheckService {
    @Resource
    CheckMapper checkMapper;
    @Resource
    CarMapper carMapper;
    @Resource
    RentMapper rentMapper;
    @Resource
    CustomerMapper customerMapper;
    @Override
    public void addCheck(CheckVo checkVo) {
        checkVo.setCreatetime(new Date());
        this.checkMapper.insertSelective(checkVo);
        Rent rent = this.rentMapper.selectByPrimaryKey(checkVo.getRentid());
        Car car=this.carMapper.selectByPrimaryKey(rent.getCarnumber());
        car.setIsrenting(SystemConstant.RENT_CAR_TRUE);
        this.carMapper.updateByPrimaryKeySelective(car);
    }

    @Override
    public DataGridView loadAllCheck(CheckVo checkVo) {
        Page<Check> page=PageHelper.startPage(checkVo.getPage(),checkVo.getLimit());
        List<Check> list=this.checkMapper.loadAllCheck(checkVo);
        return new DataGridView(page.getTotal(),list);
    }

    @Override
    public void updateCheck(CheckVo checkVo) {
        this.checkMapper.updateByPrimaryKeySelective(checkVo);
    }

    @Override
    public void deleteCheck(String checkid) {
        Check check = this.checkMapper.selectByPrimaryKey(checkid);
        Rent rent = this.rentMapper.selectByPrimaryKey(check.getRentid());
        Car car = this.carMapper.selectByPrimaryKey(rent.getCarnumber());
        car.setIsrenting(SystemConstant.RENT_CAR_FALSE);
        this.carMapper.updateByPrimaryKeySelective(car);
        this.checkMapper.deleteByPrimaryKey(checkid);
    }

    @Override
    public Rent checkRentExist(String rentid) {
        return this.rentMapper.selectByPrimaryKey(rentid);
    }

    @Override
    public Map<String, Object> loadAllInfoByRentId(String rentid) {
        //出账单信息
        Rent rent = this.rentMapper.selectByPrimaryKey(rentid);
        //汽车信息
        Car car = this.carMapper.selectByPrimaryKey(rent.getCarnumber());
        //客户信息
        Customer customer = this.customerMapper.selectByPrimaryKey(rent.getIdentity());
        //组装检查单信息
        Check check=new Check();
        check.setCheckdate(new Date());
        check.setRentid(rent.getRentid());
        User user= (User) WebUtils.getHttpSession().getAttribute("user");
        check.setOpername(user.getRealname());
        check.setCheckid(RandomUtils.createCarRentId(SystemConstant.RENT_PREFIX_JC));
        Map<String,Object>map=new HashMap<>();
        map.put("car",car);
        map.put("rent",rent);
        map.put("check",check);
        map.put("customer",customer);
        return map;
    }
}
