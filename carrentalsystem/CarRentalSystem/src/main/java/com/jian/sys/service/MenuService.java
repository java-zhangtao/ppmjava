package com.jian.sys.service;

import com.jian.sys.pojo.Menu;
import com.jian.sys.utils.DataGridView;
import com.jian.sys.vo.MenuVo;

import java.util.List;

public interface MenuService {
    /**
     * 查找所有可用的菜单返回
     */
    List<Menu> queryAllMenuForList(MenuVo menuVo);
    /**
     * 根据用户ID查找所有可用的菜单
     */
    List<Menu> queryAllMenuByUserIdForList(MenuVo menuVo,Integer userId);
    /**
     * 查询所有的菜单
     */
    public DataGridView queryAllMenu(MenuVo menuVo);

    /**
     * 添加菜单
     * @param menuVo
     */
    void addMenu(MenuVo menuVo);

    /**
     * 修改菜单
     * @param menuVo
     */
    void updateMenu(MenuVo menuVo);

    /**
     * 检查是否存在子菜单
     * @param id
     */
    List<Menu> queryMenuCheckChildren(Integer id);

    /**
     * 删除菜单
     * @param id
     */
    void deleteMenu(Integer id);
}
