package com.jian.sys.service;

import com.jian.sys.pojo.Loginfo;
import com.jian.sys.utils.DataGridView;
import com.jian.sys.vo.LoginfoVo;

/**
 * 日志服务接口
 */
public interface LoginfoService {
    //添加日志
    void addLoginfo(Loginfo loginfo);
    //查询所有 以及模糊查询
    DataGridView queryAllLogininfo(LoginfoVo loginfoVo);
    //删除日志
    void deleteLoginfo(Integer id);
    //批量删除日志
    void batchDeleteLoginfo(Integer[] ids);
}
