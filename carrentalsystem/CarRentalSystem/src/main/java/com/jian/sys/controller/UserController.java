package com.jian.sys.controller;


import com.jian.sys.constant.SystemConstant;
import com.jian.sys.pojo.Role;
import com.jian.sys.service.RoleService;
import com.jian.sys.service.UserService;
import com.jian.sys.utils.ChineseToPinYinUtils;
import com.jian.sys.utils.DataGridView;
import com.jian.sys.utils.ResultObj;
import com.jian.sys.vo.RoleVo;
import com.jian.sys.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserController {
    @Autowired
    UserService userService;
    @Autowired
    RoleService roleService;
    /**
     * 查询所有的 及模糊查询
     * @param userVo
     * @return
     */
    @RequestMapping("/loadAllUser")
    public DataGridView loadAllUser(UserVo userVo){
        return this.userService.queryAllUser(userVo);
    }

    /**
     * 添加用户
     * @param userVo
     * @return
     */
    @RequestMapping("/addUser")
    public ResultObj addUser(UserVo userVo){
        try {
            this.userService.addUser(userVo);
            return ResultObj.ADD_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.ADD_ERROR;
        }
    }
    /**
     * 修改用户
     * @param userVo
     * @return
     */
    @RequestMapping("/updateUser")
    public ResultObj updateUser(UserVo userVo){
        try {
            this.userService.updateUser(userVo);
            return ResultObj.UPDATE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.UPDATE_ERROR;
        }
    }
    /**
     * 删除用户
     * @param id
     * @return
     */
    @RequestMapping("/deleteUser")
    public ResultObj addUser(Integer id){
        try {
            this.userService.deleteUser(id);
            return ResultObj.DELETE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }
    }

    /**
     * 重置用户密码
     * @param id
     * @return
     */
    @RequestMapping("/resetPwdUser")
    public ResultObj resetPwdUser(Integer id){
        try{
            this.userService.resetPwdUser(id);
            return ResultObj.RESET_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.RESET_ERROR;
        }
    }

    /**
     * 将中文转换为拼音
     * @param username
     * @return
     */
    @RequestMapping("/usernameChineseToPinYin")
    public Map<String,Object> usernameChineseToPinYin(String username){
        Map<String,Object> map=new HashMap<>();
        String pingYin = ChineseToPinYinUtils.getPingYin(username);
        map.put("value",pingYin);
        return  map;
    }
    @RequestMapping("/userRoleTableInit")
    public DataGridView userRoleTableInit(Integer id){
        //1.查询所有的角色]
        RoleVo roleVo=new RoleVo();
        roleVo.setAvailable(SystemConstant.AVAILABLE_TRUE);
        List<Map<String, Object>> allRole=this.roleService.queryAllRoleForList(roleVo);
        //2.当前用户拥有哪些角色
        List<Role>currentUser=this.userService.queryUserHaveRole(id);
        //比较两者 标记出当前用户的角色
        if(null!=currentUser&&currentUser.size()>0){
            for (Map<String, Object> map : allRole) {
                boolean LAY_CHECKED=false;
                Integer roleId= (Integer) map.get("roleid");
                for (Role role : currentUser) {
                    if(role.getRoleid()==roleId){
                        LAY_CHECKED=true;
                        break;
                    }
                }
                map.put("LAY_CHECKED",LAY_CHECKED);
            }
        }
        return new DataGridView(Long.valueOf(allRole.size()),allRole);
    }

    /**
     * 保存分配的角色
     * @param uid
     * @param ids
     * @return
     */
    @RequestMapping("/saveSelectRole")
    public ResultObj saveSelectRole(Integer uid,Integer[] ids){
        try{
            this.userService.saveSelectRole(uid,ids);
            return ResultObj.DISPATCH_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.DISPATCH_ERROR;
        }
    }
}
