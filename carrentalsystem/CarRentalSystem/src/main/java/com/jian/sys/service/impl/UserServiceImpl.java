package com.jian.sys.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.jian.sys.constant.SystemConstant;
import com.jian.sys.mapper.UserMapper;
import com.jian.sys.pojo.Role;
import com.jian.sys.pojo.User;
import com.jian.sys.service.UserService;
import com.jian.sys.utils.DataGridView;
import com.jian.sys.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class UserServiceImpl implements UserService {
    @Resource
//    @Autowired
    private UserMapper userMapper;
    /**
     * 登录
     * @param userVo
     */
    public User login(UserVo userVo) {
        //加密 进行比较
        String pwd= DigestUtils.md5DigestAsHex(userVo.getPwd().getBytes());
        userVo.setPwd(pwd);
        User user = userMapper.login(userVo);
        return user;
    }

    @Override
    public DataGridView queryAllUser(UserVo userVo) {
        Page<User> page= PageHelper.startPage(userVo.getPage(),userVo.getLimit());
        List<User> list= this.userMapper.queryAllUser(userVo);
        return new DataGridView(page.getTotal(),list);
    }

    @Override
    public void addUser(UserVo userVo) {
        userVo.setType(SystemConstant.USER_TYPE_NORMAL);
        userVo.setPwd(DigestUtils.md5DigestAsHex(SystemConstant.DEFAULT_PASSWORD.getBytes()));
        this.userMapper.insertSelective(userVo);
    }

    @Override
    public void updateUser(UserVo userVo) {
        this.userMapper.updateByPrimaryKeySelective(userVo);
    }

    @Override
    public void deleteUser(Integer id) {
        this.userMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void resetPwdUser(Integer id) {
        User user=this.userMapper.selectByPrimaryKey(id);
        user.setPwd(DigestUtils.md5DigestAsHex(SystemConstant.DEFAULT_PASSWORD.getBytes()));
        this.userMapper.updateByPrimaryKeySelective(user);
    }

    @Override
    public List<Role> queryUserHaveRole(Integer id) {
        return this.userMapper.queryUserHaveRole(id);
    }

    @Override
    public void saveSelectRole(Integer uid, Integer[] ids) {
        //1，先删除对应的用户的角色 再重新添加
        this.userMapper.deleteRoleAndUserByUid(uid);
        //2.保存用户分配的角色
        for (Integer id : ids) {
            this.userMapper.saveSelectRole(uid,id);
        }

    }
}
