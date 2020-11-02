package com.jian.bus.service;

import com.jian.bus.pojo.Customer;
import com.jian.bus.vo.CustomerVo;
import com.jian.sys.utils.DataGridView;

public interface CustomerService {
    //加载所有的客户信息 以及模糊查询
    DataGridView loadAllCustomer(CustomerVo customerVo);
    //添加客户
    void addCustomer(CustomerVo customerVo);
    //修改客户
    void updateCustomer(CustomerVo customerVo);
    //删除客户
    void deleteCustomer(String id);
    //批量删除客户
    void batchDeleteCustomer(String[] ids);
    //根据客户身份证号查询是否存在
    Customer queryCustomerByIdentity(CustomerVo customerVo);
}
