package com.jian.sys.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.jian.sys.constant.SystemConstant;
import com.jian.sys.mapper.MenuMapper;
import com.jian.sys.pojo.Menu;
import com.jian.sys.service.MenuService;
import com.jian.sys.utils.DataGridView;
import com.jian.sys.vo.MenuVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
@Service
@Transactional
public class MenuServiceImpl implements MenuService {
    @Resource
//    @Autowired
    MenuMapper menuMapper;

    /**
     * 查询所有的菜单
     * @param menuVo
     * @return
     */
    @Override
    public List<Menu> queryAllMenuForList(MenuVo menuVo) {
       return  menuMapper.queryAllMenu(menuVo);
    }
    /**
     * 根据用户ID查询所有的菜单
     * @param menuVo
     * @return
     */
    @Override
    public List<Menu> queryAllMenuByUserIdForList(MenuVo menuVo,Integer userId) {
        return  menuMapper.queryAllMenu(menuVo);
    }

    @Override
    public DataGridView queryAllMenu(MenuVo menuVo) {
        Page<Menu> page= PageHelper.startPage(menuVo.getPage(),menuVo.getLimit());
        List<Menu> list=this.menuMapper.queryAllMenu(menuVo);
        return new DataGridView(page.getTotal(),list);
    }

    /**
     * 添加菜单
     * @param menuVo
     */
    @Override
    public void addMenu(MenuVo menuVo) {
        this.menuMapper.insertSelective(menuVo);
    }

    /**
     * 修改菜单
     * @param menuVo
     */
    @Override
    public void updateMenu(MenuVo menuVo) {
        this.menuMapper.updateByPrimaryKeySelective(menuVo);
    }

    @Override
    public List<Menu> queryMenuCheckChildren(Integer id) {
       return this.menuMapper.queryMenuCheckChildren(id);
    }

    @Override
    public void deleteMenu(Integer id) {
        //还需要删除中间表

        //删除菜单表
        this.menuMapper.deleteByPrimaryKey(id);
    }
}
