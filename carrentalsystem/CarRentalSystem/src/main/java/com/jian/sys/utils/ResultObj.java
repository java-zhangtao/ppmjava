package com.jian.sys.utils;

import com.jian.sys.constant.SystemConstant;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 返回结果状态
 */
@Data
@AllArgsConstructor
public class ResultObj {

    /**
     *登录
     */
    public static final ResultObj LOGIN_SUCCESS=new ResultObj(SystemConstant.OK,"登录成功");
    public static final ResultObj LOGIN_ERROR=new ResultObj(SystemConstant.ERROR,"用户名或密码错误");
    public static final ResultObj LOGIN_CODE_ERROR = new ResultObj(SystemConstant.ERROR,"验证码错误");
    /**
     * CRUD
     */
    public static final ResultObj ADD_SUCCESS=new ResultObj(SystemConstant.OK,"添加成功");
    public static final ResultObj ADD_ERROR=new ResultObj(SystemConstant.ERROR,"添加失败");
    public static final ResultObj UPDATE_SUCCESS=new ResultObj(SystemConstant.OK,"修改成功");
    public static final ResultObj UPDATE_ERROR=new ResultObj(SystemConstant.ERROR,"修改失败");
    public static final ResultObj DELETE_SUCCESS=new ResultObj(SystemConstant.OK,"删除成功");
    public static final ResultObj DELETE_ERROR=new ResultObj(SystemConstant.ERROR,"删除失败");
    public static final ResultObj OPERATE_SUCCESS=new ResultObj(SystemConstant.OK,"操作成功");
    public static final ResultObj OPERATE_ERROR=new ResultObj(SystemConstant.ERROR,"操作失败");
    public static final ResultObj RESET_SUCCESS=new ResultObj(SystemConstant.OK,"重置成功");
    public static final ResultObj RESET_ERROR=new ResultObj(SystemConstant.ERROR,"重置失败");
    public static final ResultObj DISPATCH_SUCCESS=new ResultObj(SystemConstant.OK,"分配成功");
    public static final ResultObj DISPATCH_ERROR=new ResultObj(SystemConstant.ERROR,"分配失败");
    /**
     * 判断客户是否存在
     */
    public static final ResultObj EXIST_TRUE = new ResultObj(SystemConstant.OK,"客户存在");
    public static final ResultObj EXIST_FALSE = new ResultObj(SystemConstant.ERROR,"客户不存在或者身份证号错误！");
    /**
     * 汽车出租状态
     */
    public static final ResultObj CAR_RENT_SUCCESS = new ResultObj(SystemConstant.OK,"汽车出租成功");
    public static final ResultObj CAR_RENT_ERROR = new ResultObj(SystemConstant.ERROR,"汽车出租失败");
    /**
     * 汽车检查状态
     */
    public static final ResultObj CAR_CHECK_SUCCESS = new ResultObj(SystemConstant.OK,"汽车检查成功");
    public static final ResultObj CAR_CHECK_ERROR = new ResultObj(SystemConstant.OK,"汽车检查失败");

    private Integer code;
    private String msg;
}
