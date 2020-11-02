package com.jian.sys.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/sys")
public class SystemController {
    /**
     * 跳转到登录页面
     * @return
     */
    @RequestMapping("/toLogin")
    public String toLogin(){
        return "system/main/login";
    }
    /**
     * 跳转到首页页面
     * @return
     */
    @RequestMapping("/toIndex")
    public String toIndex(){
        return "system/main/index";
    }
    /**
     * 跳转到工作台管理
     * @return
     */
    @RequestMapping("/toDeskManager")
    public String toDeskManager(){
        return "system/desk/deskManager";
    }
    /**
     * 跳转到菜单管理
     * @return
     */
    @RequestMapping("/toMenuManager")
    public String toMenuManager(){
        return "system/menu/menuManager";
    }
    /**
     * 跳转到菜单管理 -左边
     * @return
     */
    @RequestMapping("/toMenuManagerLeft")
    public String toMenuManagerLeft(){
        return "system/menu/menuManagerLeft";
    }
    /**
     * 跳转到菜单管理 -右边
     * @return
     */
    @RequestMapping("/toMenuManagerRight")
    public String toMenuManagerRight(){
        return "system/menu/menuManagerRight";
    }
    /**
     * 跳转到角色管理
     * @return
     */
    @RequestMapping("/toRoleManager")
    public String toRoleManager(){
        return "system/role/roleManager";
    }
    /**
     * 跳转到用户管理
     * @return
     */
    @RequestMapping("/toUserManager")
    public String toUserManager(){
        return "system/user/userManager";
    }
    /**
     * 跳转到日志管理
     * @return
     */
    @RequestMapping("/toLoginfoManager")
    public String toLoginfoManager(){
        return "system/loginfo/loginfoManager";
    }
    /**
     * 跳转到公告管理
     * @return
     */
    @RequestMapping("/toNoticeManager")
    public String toNoticeManager(){
        return "system/notice/noticeManager";
    }
}
