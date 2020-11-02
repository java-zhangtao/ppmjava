package com.jian.sys.controller;

import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.LineCaptcha;
import com.jian.sys.pojo.Loginfo;
import com.jian.sys.pojo.User;
import com.jian.sys.service.LoginfoService;
import com.jian.sys.service.UserService;
import com.jian.sys.utils.ResultObj;
import com.jian.sys.utils.WebUtils;
import com.jian.sys.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

@RestController
@RequestMapping("/login")
public class LoginController {
    @Autowired
    LoginfoService loginfoService;
    @Autowired
    UserService userService;
    @RequestMapping("/login")
    public ResultObj login(UserVo userVo) {
        User user = this.userService.login(userVo);
        String code=WebUtils.getHttpSession().getAttribute("code").toString();
        if(userVo.getCode().equals(code)){
            if(null!=user){
                WebUtils.getHttpSession().setAttribute("user",user);

                Loginfo loginfo=new Loginfo();
                loginfo.setLogintime(new Date());
                loginfo.setLoginip(WebUtils.getHttpServletRequest().getLocalAddr());
                loginfo.setLoginname(user.getRealname()+"-"+user.getLoginname());
                this.loginfoService.addLoginfo(loginfo);
                return ResultObj.LOGIN_SUCCESS;
            }else {
                return ResultObj.LOGIN_ERROR;
            }
        }else
        {
            return ResultObj.LOGIN_CODE_ERROR;
        }

    }

    /**
     * 获取验证码 放在session
     * @param response
     * @param session
     * @throws IOException
     */
    @RequestMapping("/getCode")
    public void getCode(HttpServletResponse response,HttpSession session) throws IOException {
        //定义图形验证码的长和宽
        LineCaptcha lineCaptcha = CaptchaUtil.createLineCaptcha(116, 36,4,5);
        session.setAttribute("code",lineCaptcha.getCode());
        ServletOutputStream outputStream=response.getOutputStream();
        ImageIO.write(lineCaptcha.getImage(),"JPEG",outputStream);
    }
}
