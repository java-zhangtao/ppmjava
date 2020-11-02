package com.jian.sys.utils;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.IdUtil;
import com.jian.sys.constant.SystemConstant;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * 文件上传下载工具类
 */
public class AppFileUtils {
    public static String UPLOAD_PATH = "E:/upload/";
    static {
        //读取配置文件
        InputStream stream = AppFileUtils.class.getClassLoader().getResourceAsStream("file.properties");
        Properties properties=new Properties();
        try {
            properties.load(stream);
        } catch (IOException e) {
            e.printStackTrace();
        }
        //获取文件路径
        String filePath=properties.getProperty("filepath");
        if(null!=filePath){
            UPLOAD_PATH=filePath;
        }
    }

    /**
     * 通过老文件名创建新的文件名字
     * @param oldName
     * @return
     */
    public static String createNewFileName(String oldName) {
        String tempName=oldName.substring(oldName.lastIndexOf("."),oldName.length());
        //IdUtil.simpleUUID()-->生成不带"-"
//        IdUtil.randomUUID()-->生成带"-"
        return IdUtil.simpleUUID().toUpperCase()+tempName;
    }

    /**
     * 图片下载传给前台
     * @param path
     * @return
     */
    public static ResponseEntity<Object> createResponseEntity(String path) {
        File file=new File(UPLOAD_PATH,path);
        //判断文件是否存在
        if(file.exists()){
            byte[] bytes=null;
            try{
                //读取文件
                bytes= FileUtil.readBytes(file);
            }catch (Exception e){
                e.printStackTrace();
            }
            //创建封装响应头信息的对象
            HttpHeaders header=new HttpHeaders();
            //封装响应内容类型(APPLICATION_OCTET_STREAM 响应的内容不限定)
            header.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            //设置下载的文件的名称
//			header.setContentDispositionFormData("attachment", "123.jpg");
            //创建ResponseEntity对象
            ResponseEntity<Object> entity = new ResponseEntity<Object>(bytes, header, HttpStatus.CREATED);
            return entity;
        }
        return null;
    }
    /**
     * 当用户提交图片时将图片"_temp"后缀删除 重命名
     */
    public static String renameFile(String goodsImg){
       File file=new File(UPLOAD_PATH,goodsImg);
       String replace=goodsImg.replace("_temp","");
       if (file.exists()){
           file.renameTo(new File(UPLOAD_PATH,replace));
       }
        return replace;
    }

    /**
     * 更换图片删除原先图片
     * @param oldPath
     */
    public static void removeFileByPath(String oldPath) {
        File fIle=new File(UPLOAD_PATH,oldPath);
        if(fIle.exists()){
            if(!SystemConstant.DEFAULT_IMAGE.equals(oldPath)){
                fIle.delete();
            }
       }
    }
}
