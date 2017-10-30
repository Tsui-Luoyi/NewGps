package com.jsd.controller;

import java.io.IOException; 
 


import javax.servlet.ServletException; 
import javax.servlet.http.HttpServletRequest; 
import javax.servlet.http.HttpServletResponse; 
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jsd.web.utils.VerifyCodeUtils;
 
@Controller
@RequestMapping("AuthImage")
public class AuthImage{ 
	
    static final long serialVersionUID = 1L; 
    @RequestMapping("")
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
        response.setHeader("Pragma", "No-cache"); 
        response.setHeader("Cache-Control", "no-cache"); 
        response.setDateHeader("Expires", 0); 
        response.setContentType("image/jpeg"); 
        //生成随机字串 
        String verifyCode = VerifyCodeUtils.generateVerifyCode(4); 
        //存入会话session 
        HttpSession session = request.getSession(true); 
        //删除以前的
        session.removeAttribute("checkImg");
        session.setAttribute("checkImg", verifyCode.toLowerCase()); 
        //生成图片 
        int w = 70, h = 21; 
        VerifyCodeUtils.outputImage(w, h, response.getOutputStream(), verifyCode); 
   
    } 
}