package com.jian.sys.constant;

/**
 * 常用的常量
 */
public class SystemConstant {

    /**
     * 一般使用的常量
     */
    public static final Integer ONE=1;
    public static final Integer ZERO = 0;
    /**
     * 状态码
     */
    public static final Integer ERROR=-1;
    public static final Integer OK=200;

    /**
     * 是否可用
     */
    public static final Integer AVAILABLE_TRUE=1;
    public static final Integer AVAILABLE_FALSE=0;
    /**
     * 用户身份
     */
    public static final Integer USER_TYPE_SUPER=1;
    public static final Integer USER_TYPE_NORMAL=2;
    /**
     * 菜单是否展开
     */
    public static final Boolean MENU_SPREAD_TRUE=true;
    public static final Boolean MENU_SPREAD_FALSE=false;
    /**
     * 重置默认密码
     */
    public static final String DEFAULT_PASSWORD="123456";
    public static  final String LOGIN_ERROR="用户名或密码不正确";
    /**
     * 默认图片
     */
    public static final String DEFAULT_IMAGE = null;
    /**
     * 前缀
     */
    public static final String RENT_PREFIX_CZ = "CZ";
    public static final String RENT_PREFIX_JC = "JC";
    /**
     * 汽车出租状态
     */
    public static final Integer RENT_CAR_TRUE = 0;
    public static final Integer RENT_CAR_FALSE = 1;
}
