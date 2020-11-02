package com.jian.sys.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.jian.sys.mapper.NoticeMapper;
import com.jian.sys.pojo.Notice;
import com.jian.sys.pojo.User;
import com.jian.sys.service.NoticeService;
import com.jian.sys.utils.DataGridView;
import com.jian.sys.utils.RandomUtils;
import com.jian.sys.utils.WebUtils;
import com.jian.sys.vo.NoticeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class NoticeServiceImpl implements NoticeService {
//    @Autowired
    @Resource
    NoticeMapper noticeMapper;
    @Override
    public DataGridView queryAllNotice(NoticeVo noticeVo) {
        Page<Notice> page= PageHelper.startPage(noticeVo.getPage(),noticeVo.getLimit());
        List<Notice> list=this.noticeMapper.queryAllNotice(noticeVo);
        return new DataGridView(page.getTotal(),list);
    }

    @Override
    public void addNotice(NoticeVo noticeVo) {
        noticeVo.setCreatetime(new Date());
        User user= (User) WebUtils.getHttpSession().getAttribute("user");
        noticeVo.setOpername(user.getRealname());
        this.noticeMapper.insertSelective(noticeVo);
    }

    @Override
    public void updateNotice(NoticeVo noticeVo) {
        this.noticeMapper.updateByPrimaryKeySelective(noticeVo);
    }

    @Override
    public void deleteNotice(Integer id) {
        this.noticeMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void batchDeleteNotice(Integer[] ids) {
        for (Integer id : ids) {
            this.noticeMapper.deleteByPrimaryKey(id);
        }
    }

    @Override
    public Notice loadNoticeById(Integer id) {
        return this.noticeMapper.selectByPrimaryKey(id);
    }
}
