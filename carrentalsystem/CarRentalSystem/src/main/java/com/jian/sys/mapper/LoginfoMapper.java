package com.jian.sys.mapper;

import com.jian.sys.pojo.Loginfo;
import com.jian.sys.vo.LoginfoVo;

import java.util.List;

public interface LoginfoMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Loginfo record);

    int insertSelective(Loginfo record);

    Loginfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Loginfo record);

    int updateByPrimaryKey(Loginfo record);
    //查询所有及模糊查询
    List<Loginfo> queryAllLoginfo(LoginfoVo loginfoVo);
}