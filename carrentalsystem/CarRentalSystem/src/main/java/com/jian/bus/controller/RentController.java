package com.jian.bus.controller;

import com.jian.bus.pojo.Customer;
import com.jian.bus.service.CustomerService;
import com.jian.bus.service.RentService;
import com.jian.bus.vo.CarVo;
import com.jian.bus.vo.CustomerVo;
import com.jian.bus.vo.RentVo;
import com.jian.sys.constant.SystemConstant;
import com.jian.sys.pojo.User;
import com.jian.sys.utils.DataGridView;
import com.jian.sys.utils.RandomUtils;
import com.jian.sys.utils.ResultObj;
import com.jian.sys.utils.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;

@RestController
@RequestMapping("/rent")
public class RentController {
    @Autowired
    RentService RentService;
    @Autowired
    CustomerService customerService;

    /**
     * 检查客户是否存在
     * @param customerVo
     * @return
     */
    @RequestMapping("/checkCustomerExist")
    public ResultObj checkCustomerExist(CustomerVo customerVo){
        Customer customer = this.customerService.queryCustomerByIdentity(customerVo);
        if(null!=customer){
            return ResultObj.EXIST_TRUE;
        }else{
            return ResultObj.EXIST_FALSE;
        }
    }

    /**
     * 初始化出租单信息
     * @param rentVo
     * @return
     */
    @RequestMapping("/initRentCarForm")
    public RentVo initRentCarForm(RentVo rentVo){
        //默认开始时间
        rentVo.setBegindate(new Date());
        //设置出租单号
        rentVo.setRentid(RandomUtils.createCarRentId(SystemConstant.RENT_PREFIX_CZ));
        //设置操作员
        User user= (User) WebUtils.getHttpSession().getAttribute("user");
        rentVo.setOpername(user.getRealname());
        return rentVo;
    }

    /**
     * 添加出租信息
     * @param rentVo
     * @return
     */
    @RequestMapping("/addRentCar")
    public ResultObj addRentCar(RentVo rentVo){
        try{
            this.RentService.addRent(rentVo);
            return ResultObj.CAR_RENT_SUCCESS;
        }catch (Exception e){
            return ResultObj.CAR_RENT_ERROR;
        }
    }

    /**
     * 加载所有的及模糊查询
     * @param rentVo
     * @return
     */
    @RequestMapping("/loadAllRent")
    public DataGridView loadAllRent(RentVo rentVo){
        return this.RentService.loadAllRent(rentVo);
    }

    /**
     * 更新出租单
     * @param rentVo
     * @return
     */
    @RequestMapping("/updateRent")
    public ResultObj updateRent(RentVo rentVo){
        try {
            this.RentService.updateRent(rentVo);
            return  ResultObj.UPDATE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.UPDATE_ERROR;
        }
    }

    /**
     * 删除出租单
     * @param id
     * @return
     */
    @RequestMapping("/deleteRent")
    public ResultObj deleteRent(String id){
        try {
            this.RentService.deleteRent(id);
            return  ResultObj.DELETE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }
    }
}
