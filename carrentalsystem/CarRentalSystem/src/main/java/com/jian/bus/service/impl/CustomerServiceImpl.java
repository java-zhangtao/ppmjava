package com.jian.bus.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.jian.bus.mapper.CustomerMapper;
import com.jian.bus.pojo.Customer;
import com.jian.bus.service.CustomerService;
import com.jian.bus.vo.CustomerVo;
import com.jian.sys.utils.DataGridView;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
public class CustomerServiceImpl implements CustomerService {
    @Resource
    CustomerMapper customerMapper;
    @Override
    public DataGridView loadAllCustomer(CustomerVo customerVo) {
        Page<Customer>page= PageHelper.startPage(customerVo.getPage(),customerVo.getLimit());
        List<Customer> list = this.customerMapper.loadAllCustomer(customerVo);
        return new DataGridView(page.getTotal(),list);
    }

    @Override
    public void addCustomer(CustomerVo customerVo) {
        customerVo.setCreatetime(new Date());
        this.customerMapper.insertSelective(customerVo);
    }

    @Override
    public void updateCustomer(CustomerVo customerVo) {
        this.customerMapper.updateByPrimaryKeySelective(customerVo);
    }

    @Override
    public void deleteCustomer(String id) {
        this.customerMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void batchDeleteCustomer(String[] ids) {
        for (String id : ids) {
            this.customerMapper.deleteByPrimaryKey(id);
        }
    }

    @Override
    public Customer queryCustomerByIdentity(CustomerVo customerVo) {
        return this.customerMapper.selectByPrimaryKey(customerVo.getIdentity());
    }
}
