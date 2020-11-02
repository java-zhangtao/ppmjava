package com.jian.sys.mapper;

import com.jian.sys.pojo.Notice;
import com.jian.sys.vo.NoticeVo;

import java.util.List;

public interface NoticeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Notice record);

    int insertSelective(Notice record);

    Notice selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Notice record);

    int updateByPrimaryKey(Notice record);
    //查询所有的公告和模糊查询
    List<Notice> queryAllNotice(NoticeVo noticeVo);
}