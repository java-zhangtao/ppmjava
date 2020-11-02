package com.jian.sys.service;

import com.jian.sys.pojo.Menu;
import com.jian.sys.pojo.Role;
import com.jian.sys.utils.DataGridView;
import com.jian.sys.vo.RoleVo;

import java.util.List;
import java.util.Map;

/**
 * 角色服务接口
 */
public interface RoleService {
    //查询所有以及模糊查询
    DataGridView queryAllRole(RoleVo roleVo);
    //添加角色
    void addRole(RoleVo roleVo);
    //修改角色
    void updateRole(RoleVo roleVo);
    //删除角色
    void deleteRole(Integer id);
    //查询角色所拥护的菜单
    List<Menu> queryRoleHaveMenu(Integer roleId);
    //保存分配的权限
    void saveSelectPermission(Integer rid, Integer[] ids);

    List<Map<String, Object>> queryAllRoleForList(RoleVo roleVo);
}
