package com.jian.sys.service;

import com.jian.sys.pojo.Notice;
import com.jian.sys.utils.DataGridView;
import com.jian.sys.vo.NoticeVo;

import java.util.List;

/**
 * 公告服务接口
 */
public interface NoticeService {
    //查询所有的公告 以及模糊查询
    DataGridView queryAllNotice(NoticeVo noticeVo);
    //添加公告
    void addNotice(NoticeVo noticeVo);
    //修改公告
    void updateNotice(NoticeVo noticeVo);
    //删除公告
    void deleteNotice(Integer id);
    //批量删除
    void batchDeleteNotice(Integer[] ids);
    //通过id查询公告
    Notice loadNoticeById(Integer id);
}
