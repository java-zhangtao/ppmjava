package com.jian.sys.mapper;

import com.jian.sys.pojo.Role;
import com.jian.sys.pojo.User;
import com.jian.sys.vo.UserVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserMapper {
    int deleteByPrimaryKey(Integer userid);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer userid);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    /**
     * 登录
     */
    User login(UserVo userVo);
    //查询所有用户 以及模糊查询
    List<User> queryAllUser(User user);
    //查询当前用户拥有的角色
    List<Role> queryUserHaveRole(@Param("uid") Integer id);
    //根据用户的id删除对应的角色
    void deleteRoleAndUserByUid(Integer uid);
    //保存用户分配的角色
    void saveSelectRole(@Param("uid") Integer uid,@Param("rid") Integer id);
}