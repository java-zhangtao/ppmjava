package com.jian.sys.controller;

import com.jian.sys.constant.SystemConstant;
import com.jian.sys.pojo.Menu;
import com.jian.sys.pojo.User;
import com.jian.sys.service.MenuService;
import com.jian.sys.utils.*;
import com.jian.sys.vo.MenuVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/menu")
public class MenuController {
    @Autowired
//    @Resource
    MenuService menuService;
    /**
     * 加载所有的菜单
     * @return
     */
    @RequestMapping("/loadAllMenuIndexLeftJson")
    public DataGridView loadAllMenuIndexLeftJson(MenuVo menuVo){
        User user= (User) WebUtils.getHttpSession().getAttribute("user");
        List<Menu> list = null;
        menuVo.setAvailable(SystemConstant.AVAILABLE_TRUE);
        if(SystemConstant.USER_TYPE_SUPER==user.getType()){
            list=menuService.queryAllMenuForList(menuVo);
        }else {
            list=menuService.queryAllMenuByUserIdForList(menuVo,user.getUserid());
        }
        //1.构建前端使用的数据类型
        List<TreeNode> treeNodes=new ArrayList<>();
        for (Menu menu : list) {
            Integer id=menu.getId();
            Integer pid=menu.getPid();
            String title=menu.getTitle();
            String href=menu.getHref();
            String icon=menu.getIcon();
            String target=menu.getTarget();
            Boolean spread=(menu.getSpread()>SystemConstant.ZERO)?SystemConstant.MENU_SPREAD_TRUE:SystemConstant.MENU_SPREAD_FALSE;
            TreeNode node=new TreeNode(id,pid,title,href,icon,spread,target);
            treeNodes.add(node);
        }
        //2.现在为线性结构 需要层级结构
        List<TreeNode> nodes = TreeNodeBuilder.builder(treeNodes, 1);
        return new DataGridView(nodes);
    }

    /**
     * 加载菜单管理左侧的菜单树
     * @param menuVo
     * @return
     */
    @RequestMapping("/loadMenuManagerLeftTreeJson")
    public DataGridView loadMenuManagerLeftTreeJson(MenuVo menuVo){
        menuVo.setAvailable(SystemConstant.AVAILABLE_TRUE);
        List<Menu> list=this.menuService.queryAllMenuForList(menuVo);
        //1.构建前端使用的数据类型
        List<TreeNode> treeNodes=new ArrayList<>();
        for (Menu menu : list) {
            Integer id=menu.getId();
            Integer pid=menu.getPid();
            String title=menu.getTitle();
            Boolean spread=(menu.getSpread()>SystemConstant.ZERO)?SystemConstant.MENU_SPREAD_TRUE:SystemConstant.MENU_SPREAD_FALSE;
            TreeNode node=new TreeNode(id,pid,title,spread);
            treeNodes.add(node);
        }
        return new DataGridView(treeNodes);
    }

    /**
     * 查询所有的菜单
     * @param menuVo
     * @return
     */
    @RequestMapping("/loadAllMenu")
    public DataGridView queryAllMenu(MenuVo menuVo){
        return this.menuService.queryAllMenu(menuVo);
    }

    /**
     * 添加菜单
     */
    @RequestMapping("addMenu")
    public ResultObj addMenu(MenuVo menuVo){
        try {
            this.menuService.addMenu(menuVo);
            return ResultObj.ADD_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.ADD_ERROR;
        }
    }

    /**
     * 修改菜单
     * @param menuVo
     * @return
     */
    @RequestMapping("/updateMenu")
    public ResultObj updateMenu(MenuVo menuVo){
        try {
            this.menuService.updateMenu(menuVo);
            return ResultObj.UPDATE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.UPDATE_ERROR;
        }
    }
    /**
     * 检查是否存在子菜单
     */
    @RequestMapping("/checkDeleteMenuChildren")
    public Map<String,Object> checkDeleteMenuChildren(Integer id){
        Map<String,Object> map=new HashMap<>();
        List<Menu> list = this.menuService.queryMenuCheckChildren(id);
        if(list.size()>0){
            map.put("value",true);
        }else{
            map.put("value",false);
        }
        return map;
    }

    @RequestMapping("/deleteMenu")
    public ResultObj deleteMenu(Integer id){
        try {
            this.menuService.deleteMenu(id);
            return ResultObj.DELETE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }
    }
}
