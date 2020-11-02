package com.jian.bus.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/bus")
public class BusinessController {
    /**
     * 跳转到客户管理
     * @return
     */
    @RequestMapping("/toCustomerManager")
    public String toCustomerManager(){
        return "business/customer/customerManager";
    }
    /**
     * 跳转到汽车管理
     * @return
     */
    @RequestMapping("/toCarManager")
    public String toCarManager(){
        return "business/car/carManager";
    }
    /**
     * 跳转到汽车出租
     * @return
     */
    @RequestMapping("/toRentCarManager")
    public String toRentCarManager(){
        return "business/carrent/carRentManager";
    }
    /**
     * 跳转到汽车出租管理
     * @return
     */
    @RequestMapping("/toRentManager")
    public String toRentManager(){
        return "business/rent/rentManager";
    }
    /**
     * 跳转到汽车出租管理
     * @return
     */
    @RequestMapping("/toCheckManager")
    public String toCheckManager(){
        return "business/check/checkManager";
    }
    /**
     * 跳转到汽车入库
     * @return
     */
    @RequestMapping("/toCheckCarManager")
    public String toCheckCarManager(){
        return "business/carcheck/carCheckManager";
    }
}
