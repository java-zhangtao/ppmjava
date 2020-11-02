package com.jian.bus.controller;

import com.jian.bus.service.CarService;
import com.jian.bus.service.CustomerService;
import com.jian.bus.vo.CarVo;
import com.jian.bus.vo.CustomerVo;
import com.jian.sys.utils.DataGridView;
import com.jian.sys.utils.ResultObj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/car")
public class CarController {
    @Autowired
    CarService carService;

    /**
     * 加载所有的汽车信息以及模糊查询
     * @param carVo
     * @return
     */
    @RequestMapping("/loadAllCar")
    public DataGridView loadAllCar(CarVo carVo){
        return this.carService.loadAllCar(carVo);
    }

    /**
     * 添加汽车
     * @param carVo
     * @return
     */
    @RequestMapping("/addCar")
    public ResultObj addCar(CarVo carVo){
        try{
            this.carService.addCar(carVo);
            return ResultObj.ADD_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.ADD_ERROR;
        }
    }
    /**
     * 修改汽车
     * @param carVo
     * @return
     */
    @RequestMapping("/updateCar")
    public ResultObj updateCar(CarVo carVo){
        try{
            this.carService.updateCar(carVo);
            return ResultObj.UPDATE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.UPDATE_ERROR;
        }
    }
    /**
     * 删除汽车
     * @param id
     * @return
     */
    @RequestMapping("/deleteCar")
    public ResultObj deleteCar(String id){
        try{
            this.carService.deleteCar(id);
            return ResultObj.DELETE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }
    }
}
