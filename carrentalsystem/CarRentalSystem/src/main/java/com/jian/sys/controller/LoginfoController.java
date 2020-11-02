package com.jian.sys.controller;


import com.jian.sys.pojo.Loginfo;
import com.jian.sys.service.LoginfoService;
import com.jian.sys.utils.DataGridView;
import com.jian.sys.utils.ResultObj;
import com.jian.sys.vo.LoginfoVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/loginfo")
public class LoginfoController {
    @Autowired
    LoginfoService loginfoService;

    /**
     * 查询所有的日志 以及模糊查询
     * @param loginfoVo
     * @return
     */
    @RequestMapping("/loadAllLoginfo")
    public DataGridView loadAllLoginfo(LoginfoVo loginfoVo){
        return this.loginfoService.queryAllLogininfo(loginfoVo);
    }
    /**
     * 删除日志
     */
    @RequestMapping("deleteLoginfo")
    public ResultObj deleteLoginfo(Integer id){
        try {
            this.loginfoService.deleteLoginfo(id);
            return ResultObj.DELETE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }
    }
    /**
     * 批量删除日志
     */
    @RequestMapping("batchDeleteLoginfo")
    public ResultObj batchDeleteLoginfo(Integer[] ids){
        try {
            this.loginfoService.batchDeleteLoginfo(ids);
            return ResultObj.DELETE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }
    }
}
