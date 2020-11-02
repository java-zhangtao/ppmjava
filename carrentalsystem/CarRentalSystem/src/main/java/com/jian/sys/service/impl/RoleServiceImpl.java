package com.jian.sys.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.jian.sys.mapper.RoleMapper;
import com.jian.sys.pojo.Menu;
import com.jian.sys.pojo.Role;
import com.jian.sys.service.RoleService;
import com.jian.sys.utils.DataGridView;
import com.jian.sys.vo.RoleVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class RoleServiceImpl implements RoleService {
    @Resource
    RoleMapper roleMapper;
    @Override
    public DataGridView queryAllRole(RoleVo roleVo) {
        Page<Role> page= PageHelper.startPage(roleVo.getPage(),roleVo.getLimit());
        List<Role> list=this.roleMapper.queryAllRole(roleVo);
        return new DataGridView(page.getTotal(),list);
    }
    public List<Map<String, Object>> queryAllRoleForList(RoleVo roleVo){
        return this.roleMapper.queryAllRoleForList(roleVo);
    }
    @Override
    public void addRole(RoleVo roleVo) {
        this.roleMapper.insertSelective(roleVo);
    }

    @Override
    public void updateRole(RoleVo roleVo) {
        this.roleMapper.updateByPrimaryKeySelective(roleVo);
    }

    @Override
    public void deleteRole(Integer id) {
        //删除中间表
        this.roleMapper.deleteRoleAndMenuById(id);
        //再删除角色表
        this.roleMapper.deleteByPrimaryKey(id);
    }

    @Override
    public List<Menu> queryRoleHaveMenu(Integer roleId) {
        return this.roleMapper.queryHaveRoleMenu(roleId);
    }

    @Override
    public void saveSelectPermission(Integer rid, Integer[] ids) {
        //先删除原有的中间表的数据
        this.roleMapper.deleteRoleAndMenuById(rid);
        //再添加新数据
        for (Integer id : ids) {
            this.roleMapper.addRoleAndMenu(rid,id);
        }

    }
}
