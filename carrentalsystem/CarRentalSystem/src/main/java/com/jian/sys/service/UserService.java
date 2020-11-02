package com.jian.sys.service;

import com.jian.sys.pojo.Role;
import com.jian.sys.pojo.User;
import com.jian.sys.utils.DataGridView;
import com.jian.sys.vo.UserVo;

import java.util.List;

public interface UserService {
    User login(UserVo userVo);
    //查询所有 以及模糊查询
    DataGridView queryAllUser(UserVo userVo);
    //添加用户
    void addUser(UserVo userVo);
    //修改
    void updateUser(UserVo userVo);
    //删除
    void deleteUser(Integer id);
    //重置密码
    void resetPwdUser(Integer id);
    //查询当前用户拥有的角色
    List<Role> queryUserHaveRole(Integer id);
    //保存分配的角色
    void saveSelectRole(Integer uid, Integer[] ids);
}
