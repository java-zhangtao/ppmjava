package com.jian.sys.mapper;

import com.jian.sys.pojo.Menu;
import com.jian.sys.pojo.Role;
import com.jian.sys.vo.RoleVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface RoleMapper {
    int deleteByPrimaryKey(Integer roleid);

    int insert(Role record);

    int insertSelective(Role record);

    Role selectByPrimaryKey(Integer roleid);

    int updateByPrimaryKeySelective(Role record);

    int updateByPrimaryKey(Role record);
    //查询所有以及模糊查询
    List<Role> queryAllRole(Role role);
    //删除中间表 sys_role_menu
    void deleteRoleAndMenuById(Integer id);
    //查询角色用户的菜单
    List<Menu> queryHaveRoleMenu(@Param("rid") Integer roleId);
    //添加新的角色拥有的菜单 sys_role_menu
    void addRoleAndMenu(@Param("rid") Integer rid, @Param("mid") Integer id);
    //查询所有放到LIst
    List<Map<String, Object>> queryAllRoleForList(RoleVo roleVo);
}