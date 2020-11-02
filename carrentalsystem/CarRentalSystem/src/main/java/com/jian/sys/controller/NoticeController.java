package com.jian.sys.controller;


import com.jian.sys.pojo.Notice;
import com.jian.sys.service.NoticeService;
import com.jian.sys.utils.DataGridView;
import com.jian.sys.utils.ResultObj;
import com.jian.sys.vo.NoticeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/notice")
public class NoticeController {
    @Autowired
    private NoticeService noticeService;
    /**
     * 查询所有的以及模糊查询
     */
    @RequestMapping("/loadAllNotice")
    public DataGridView loadAllNotice(NoticeVo noticeVo){
        return this.noticeService.queryAllNotice(noticeVo);
    }

    /**
     * 添加公告
     * @param noticeVo
     * @return
     */
    @RequestMapping("/addNotice")
    public ResultObj addNotice(NoticeVo noticeVo){
        try {
            this.noticeService.addNotice(noticeVo);
            return ResultObj.ADD_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.ADD_ERROR;
        }
    }
    /**
     * 修改公告
     * @param noticeVo
     * @return
     */
    @RequestMapping("/updateNotice")
    public ResultObj updateNotice(NoticeVo noticeVo){
        try {
            this.noticeService.updateNotice(noticeVo);
            return ResultObj.UPDATE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.UPDATE_ERROR;
        }
    }
    /**
     * 修改公告
     * @param id
     * @return
     */
    @RequestMapping("/deleteNotice")
    public ResultObj deleteNotice(Integer id){
        try {
            this.noticeService.deleteNotice(id);
            return ResultObj.DELETE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }
    }
    /**
     * 批量删除公告
     * @param ids
     * @return
     */
    @RequestMapping("/batchDeleteNotice")
    public ResultObj batchDeleteNotice(Integer[] ids){
        try {
            this.noticeService.batchDeleteNotice(ids);
            return ResultObj.DELETE_SUCCESS;
        }catch (Exception e){
            e.printStackTrace();
            return ResultObj.DELETE_ERROR;
        }
    }

    /**
     * 通过公告id查询公告
     * @param id
     * @return
     */
    @RequestMapping("/loadNoticeById")
    public Notice loadNoticeById(Integer id){
        return this.noticeService.loadNoticeById(id);
    }
}
