package com.jian.bus.mapper;

import com.jian.bus.pojo.Customer;
import com.jian.bus.vo.CustomerVo;
import com.jian.sys.utils.DataGridView;

import java.util.List;

public interface CustomerMapper {
    int deleteByPrimaryKey(String identity);

    int insert(Customer record);

    int insertSelective(Customer record);

    Customer selectByPrimaryKey(String identity);

    int updateByPrimaryKeySelective(Customer record);

    int updateByPrimaryKey(Customer record);
    //查询所有以及模糊查询
    List<Customer> loadAllCustomer(Customer customer);
}