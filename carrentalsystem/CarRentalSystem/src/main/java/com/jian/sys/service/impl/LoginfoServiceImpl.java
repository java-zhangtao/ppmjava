package com.jian.sys.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.jian.sys.mapper.LoginfoMapper;
import com.jian.sys.pojo.Loginfo;
import com.jian.sys.service.LoginfoService;
import com.jian.sys.utils.DataGridView;
import com.jian.sys.vo.LoginfoVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class LoginfoServiceImpl implements LoginfoService {
    @Resource
    LoginfoMapper loginfoMapper;
    @Override
    public void addLoginfo(Loginfo loginfo) {
        this.loginfoMapper.insertSelective(loginfo);
    }

    @Override
    public DataGridView queryAllLogininfo(LoginfoVo loginfoVo) {
        Page<Loginfo> page=PageHelper.startPage(loginfoVo.getPage(),loginfoVo.getLimit());
        List<Loginfo> list=this.loginfoMapper.queryAllLoginfo(loginfoVo);
        return new DataGridView(page.getTotal(),list);
    }

    @Override
    public void deleteLoginfo(Integer id) {
        this.loginfoMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void batchDeleteLoginfo(Integer[] ids) {
        for (Integer id : ids) {
            this.loginfoMapper.deleteByPrimaryKey(id);
        }
    }
}
