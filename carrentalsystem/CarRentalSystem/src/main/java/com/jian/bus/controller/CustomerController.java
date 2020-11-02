package com.jian.bus.controller;

import com.jian.bus.service.CustomerService;
import com.jian.bus.vo.CustomerVo;
import com.jian.sys.utils.DataGridView;
import com.jian.sys.utils.ResultObj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/customer")
public class CustomerController {
    @Autowired
    CustomerService customerService;

    /**
     * 加载所有的客户信息以及模糊查询
     * @param customerVo
     * @return
     */
    @RequestMapping("/loadAllCustomer")
    public DataGridView loadAllCustomer(CustomerVo customerVo){
        return this.customerService.loadAllCustomer(customerVo);
    }

    /**
     * 添加客户
     * @param customerVo
     * @return
     */
    @RequestMapping("/addCustomer")
    public ResultObj addCustomer(CustomerVo customerVo){
        try{
            this.customerService.addCustomer(customerVo);
            return ResultObj.ADD_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.ADD_ERROR;
        }
    }
    /**
     * 修改客户
     * @param customerVo
     * @return
     */
    @RequestMapping("/updateCustomer")
    public ResultObj updateCustomer(CustomerVo customerVo){
        try{
            this.customerService.updateCustomer(customerVo);
            return ResultObj.UPDATE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.UPDATE_ERROR;
        }
    }
    /**
     * 删除客户
     * @param id
     * @return
     */
    @RequestMapping("/deleteCustomer")
    public ResultObj deleteCustomer(String id){
        try{
            this.customerService.deleteCustomer(id);
            return ResultObj.DELETE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }
    }
    /**
     * 批量客户
     * @param ids
     * @return
     */
    @RequestMapping("/batchDeleteCustomer")
    public ResultObj batchDeleteCustomer(String[] ids){
        try{
            this.customerService.batchDeleteCustomer(ids);
            return ResultObj.DELETE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }
    }

}
