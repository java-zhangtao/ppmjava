package com.jian.sys.mapper;

import com.jian.sys.pojo.Menu;
import com.jian.sys.vo.MenuVo;

import java.util.List;

public interface MenuMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Menu record);

    int insertSelective(Menu record);

    Menu selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Menu record);

    int updateByPrimaryKey(Menu record);
    //查询所有可用的菜单
    List<Menu> queryAllMenu(Menu menu);
    //检查子菜单
    List<Menu> queryMenuCheckChildren(Integer id);
}