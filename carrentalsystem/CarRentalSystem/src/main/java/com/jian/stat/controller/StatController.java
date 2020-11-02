package com.jian.stat.controller;

import com.jian.stat.pojo.StatEntity;
import com.jian.stat.service.StatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/stat")
public class StatController {
    @Autowired
    private StatService statService;

    /**
     * 跳转到客户地区统计
     * @return
     */
    @RequestMapping("/toCustomerAreaStat")
    public String toCustomerAreaStat(){
        return "stat/customerAreaStat";
    }
    /**
     * 加载地区地区数据
     */
    @RequestMapping("/loadCustomerAreaJson")
    @ResponseBody
    public List<StatEntity> loadCustomerAreaJson(){
        return this.statService.loadCustomerAreaJson();
    }
    /**
     * 跳转到操作员业绩统计
     * @return
     */
    @RequestMapping("/toOpernameYearOutstandStat")
    public String toOpernameYearOutstandStat(){
        return "stat/opernameYearOutstandStat";
    }
    /**
     * 查询操作员业绩
     */
    @RequestMapping("/loadOpernameYearOutstandJson")
    @ResponseBody
    public Map<String,Object> loadOpernameYearOutstandJson(String year){
        Map<String,Object> map=new HashMap<>();
        List<StatEntity> statEntityList=this.statService.loadOpernameYearOutstand(year);
        List<String> names=new ArrayList<>();
        List<Double> values=new ArrayList<>();
        for (StatEntity entity : statEntityList) {
            names.add(entity.getName());
            values.add(entity.getValue());
        }
        map.put("name",names);
        map.put("value",values);
        return map;
    }
    /**
     * 跳转到公司年度业绩统计
     * @return
     */
    @RequestMapping("/toCompanyYearOutstandStat")
    public String toCompanyYearOutstandStat(){
        return "stat/companyYearOutstandStat";
    }
    /**
     * 查询操作员业绩
     */
    @RequestMapping("/loadCompanyYearOutstandJson")
    @ResponseBody
    public List<Double> loadCompanyYearOutstandJson(String year){
        List<Double> list=this.statService.loadCompanyOutstand(year);
        return list;
    }
}
