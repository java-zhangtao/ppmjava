package com.jian.sys.task;

import com.jian.sys.constant.SystemConstant;
import com.jian.sys.utils.AppFileUtils;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.scheduling.annotation.Schedules;
import org.springframework.stereotype.Component;

import java.io.File;

@Component
@EnableScheduling //开启定时任务
public class TimingRemoveTempImage {
    /**
     * 定时任务
     */
    @Scheduled(cron = "0 0 12 * * ?")
    public void TimingRemoveTemp(){
        //获取文件夹
        File file=new File(AppFileUtils.UPLOAD_PATH);
        deleteFile(file);
    }

    /**
     * 删除文件
     * @param file
     */
    public void deleteFile(File file){
        if(null != file){
            File[] files=file.listFiles();
            if(null!=files&&files.length>0){
                for (File f : files) {
                    if(f.isFile()){
                        if(f.getName().endsWith("_temp")){
                            f.delete();
                        }else {
                            deleteFile(f);
                        }
                    }
                }
            }
        }
    }
}
