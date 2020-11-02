package com.jian.bus.controller;

import com.jian.bus.pojo.Rent;
import com.jian.bus.service.CheckService;
import com.jian.bus.service.RentService;
import com.jian.bus.vo.CheckVo;
import com.jian.sys.constant.SystemConstant;
import com.jian.sys.pojo.User;
import com.jian.sys.utils.DataGridView;
import com.jian.sys.utils.RandomUtils;
import com.jian.sys.utils.ResultObj;
import com.jian.sys.utils.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Date;
import java.util.Map;

@RestController
@RequestMapping("/check")
public class CheckController {
    @Autowired
    CheckService checkService;

    /**
     * 判断出租单是否存在
     * @param rentid
     * @return
     */
    @RequestMapping("/checkRentExist")
    public Rent checkRentExist(String rentid){
        return this.checkService.checkRentExist(rentid);
    }

    /**
     * 根据出租单号 查询汽车、客户、出租单、检查单的信息
     * @param rentid
     * @return
     */
    @RequestMapping("/loadAllInfoByRentId")
    public Map<String,Object> loadAllInfoByRentId(String rentid){
        return this.checkService.loadAllInfoByRentId(rentid);
    }
    /**
     * 初始化检查单信息
     * @param checkVo
     * @return
     */
    @RequestMapping("/initCheckCarForm")
    public CheckVo initCheckCarForm(CheckVo checkVo){
        //默认开始时间
        checkVo.setCheckdate(new Date());
        //设置检查单号
        checkVo.setCheckid(RandomUtils.createCarRentId(SystemConstant.RENT_PREFIX_JC));
        //设置操作员
        User user= (User) WebUtils.getHttpSession().getAttribute("user");
        checkVo.setOpername(user.getRealname());
        return checkVo;
    }

    /**
     * 添加检查信息
     * @param checkVo
     * @return
     */
    @RequestMapping("/addCheckCar")
    public ResultObj addCheckCar(CheckVo checkVo){
        try{
            this.checkService.addCheck(checkVo);
            return ResultObj.CAR_CHECK_SUCCESS;
        }catch (Exception e){
            return ResultObj.CAR_CHECK_ERROR;
        }
    }

    /**
     * 加载所有的及模糊查询
     * @param checkVo
     * @return
     */
    @RequestMapping("/loadAllCheck")
    public DataGridView loadAllCheck(CheckVo checkVo){
        return this.checkService.loadAllCheck(checkVo);
    }

    /**
     * 更新检查单
     * @param checkVo
     * @return
     */
    @RequestMapping("/updateCheck")
    public ResultObj updateCheck(CheckVo checkVo){
        try {
            this.checkService.updateCheck(checkVo);
            return  ResultObj.UPDATE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.UPDATE_ERROR;
        }
    }

    /**
     * 删除检查单
     * @param id
     * @return
     */
    @RequestMapping("/deleteCheck")
    public ResultObj deleteCheck(String id){
        try {
            this.checkService.deleteCheck(id);
            return  ResultObj.DELETE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }
    }
}
