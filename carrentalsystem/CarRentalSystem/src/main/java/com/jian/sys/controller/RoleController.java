package com.jian.sys.controller;

import com.jian.sys.constant.SystemConstant;
import com.jian.sys.pojo.Menu;
import com.jian.sys.service.MenuService;
import com.jian.sys.service.RoleService;
import com.jian.sys.utils.DataGridView;
import com.jian.sys.utils.ResultObj;
import com.jian.sys.utils.TreeNode;
import com.jian.sys.vo.MenuVo;
import com.jian.sys.vo.RoleVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/role")
public class RoleController {
    @Autowired
    RoleService roleService;
    @Autowired
    MenuService menuService;
    /**
     * 查询所有以及模糊查询
     * @param roleVo
     * @return
     */
    @RequestMapping("/loadAllRole")
    public DataGridView loadAllRole(RoleVo roleVo){
        return this.roleService.queryAllRole(roleVo);
    }

    /**
     * 添加角色
     * @param roleVo
     * @return
     */
    @RequestMapping("/addRole")
    public ResultObj addRole(RoleVo roleVo){
        try {
            this.roleService.addRole(roleVo);
            return ResultObj.ADD_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return  ResultObj.ADD_ERROR;
        }
    }
    /**
     * 修改角色
     * @param roleVo
     * @return
     */
    @RequestMapping("/updateRole")
    public ResultObj updateRole(RoleVo roleVo){
        try {
            this.roleService.updateRole(roleVo);
            return ResultObj.UPDATE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return  ResultObj.UPDATE_ERROR;
        }
    }
    /**
     * 删除角色
     * @param id
     * @return
     */
    @RequestMapping("/deleteRole")
    public ResultObj deleteRole(Integer id){
        try {
            this.roleService.deleteRole(id);
            return ResultObj.DELETE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return  ResultObj.DELETE_ERROR;
        }
    }

    /**
     * 返回需要分配权限的角色的菜单
     * @param roleId
     * @return
     */
    @RequestMapping("/queryRolePermission")
    public DataGridView queryRolePermission(Integer roleId){
        MenuVo menuVo=new MenuVo();
        menuVo.setAvailable(SystemConstant.AVAILABLE_TRUE);
        //1.查询所有的可用菜单
        List<Menu> allMenuList=this.menuService.queryAllMenuForList(menuVo);
        //2.查询角色所拥有的菜单
        List<Menu> roleMenuList=this.roleService.queryRoleHaveMenu(roleId);
        //3.将两者进行比较 使checkArr赋值 确认角色的菜单
        List<TreeNode> nodes=new ArrayList<>();
        for (Menu menu : allMenuList) {
            String checkArr="0";
            for (Menu role : roleMenuList) {
                if(role.getId()==menu.getId()){
                    checkArr="1";
                    break;
                }
            }
            Integer id=menu.getId();
            Integer pid=menu.getPid();
            String title=menu.getTitle();
            Boolean spread=(menu.getSpread()>SystemConstant.ZERO)?SystemConstant.MENU_SPREAD_TRUE:SystemConstant.MENU_SPREAD_FALSE;
            TreeNode treeNode=new TreeNode(id,pid,title,spread,checkArr);
            nodes.add(treeNode);
        }
        return new DataGridView(nodes);
    }
    @RequestMapping("/saveSelectPermission")
    public ResultObj saveSelectPermission(Integer rid,Integer[] ids){
        try {
            this.roleService.saveSelectPermission(rid,ids);
            return ResultObj.DISPATCH_SUCCESS;
        }catch (Exception e){
            return ResultObj.DISPATCH_ERROR;
        }
    }
}
