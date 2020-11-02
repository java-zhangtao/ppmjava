package com.jian.sys.controller;

import cn.hutool.core.date.DateUtil;
import com.jian.sys.utils.AppFileUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/file")
public class FileController {
    /**
     * 文件上传
     */
    @RequestMapping("/uploadFile")
    public Map<String,Object> uploadFile(MultipartFile mf){
        Map<String,Object> map = new HashMap<>();
        //1.获取文件名字
        String oldName = mf.getOriginalFilename();
        //2.创建新的文件名字
        String newName= AppFileUtils.createNewFileName(oldName);
        //3.得到当前日期的字符串
        String dirName= DateUtil.format(new Date(),"yyyy-MM-dd");
        //4.构建文件夹
        File dirFile=new File(AppFileUtils.UPLOAD_PATH,dirName);
        //5.判断文件夹是否存在
        if(!dirFile.exists()){
            dirFile.mkdirs();//创建文件夹
        }
        //6.创建文件对象
        File file=new File(dirFile,newName+"_temp");
        //7.将mf的图片信息转换到文件中
        try {
            mf.transferTo(file);
        } catch (IllegalStateException | IOException e) {
            e.printStackTrace();
        }
        map.put("path",dirName+"/"+newName+"_temp");
        return map;
    }
    /**
     * 图片下载
     */
    @RequestMapping("/showImageByPath")
    public ResponseEntity<Object> showImageByPath(String path){
        return AppFileUtils.createResponseEntity(path);
    }

    /**
     * 测试
     */
    @RequestMapping("/showImageByPath")
    public ResponseEntity<Object> testShowImageByPath(String path){
        return AppFileUtils.createResponseEntity(path);
    }
    /**
     * 测试
     */
    @RequestMapping("/showImageByPath")
    public ResponseEntity<Object> testShowImageByPath2(String path){
        return AppFileUtils.createResponseEntity(path);
    }
    /**
     * 测试
     */
    @RequestMapping("/showImageByPath")
    public ResponseEntity<Object> testShowImageByPath3(String path){
        return AppFileUtils.createResponseEntity(path);
    }
    /**
     * 测试
     */
    @RequestMapping("/showImageByPath")
    public ResponseEntity<Object> testShowImageByPath4(String path){
        return AppFileUtils.createResponseEntity(path);
    }
}
