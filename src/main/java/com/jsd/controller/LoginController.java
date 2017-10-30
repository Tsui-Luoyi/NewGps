package com.jsd.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("LoginAction")
public class LoginController {

	class TDuser {
		public Integer getUserId() {
			return userId;
		}

		public void setUserId(Integer userId) {
			this.userId = userId;
		}

		public String getUsercode() {
			return usercode;
		}

		public void setUsercode(String usercode) {
			this.usercode = usercode;
		}

		public String getUserPwd() {
			return userPwd;
		}

		public void setUserPwd(String userPwd) {
			this.userPwd = userPwd;
		}

		Integer userId;
		String usercode;
		String userPwd;

		TDuser() {

		}

	}

	@RequestMapping("")
	public String logins(HttpServletRequest request,
			HttpServletResponse response) {
		TDuser user = new TDuser();
		user.setUsercode("usercode");
		user.setUserPwd("userPwd");
//		String checkImg = (String) request.getAttribute("checkImg");
		HttpSession session = request.getSession(true); 
		String licence=(String) session.getAttribute("checkImg");
		System.out.println(licence);
		session.removeAttribute("checkImg");// 请求验证码
//		String s = null;
//		if (licence == null || licence == null) {
//			s = "loginerror";
//		}
//		if (!licence.toLowerCase().equals(licence.toLowerCase())) {
//			request.setAttribute("flag", "2");
//			request.setAttribute("idError", "验证码有误，请重新输入！");
//			request.setAttribute("userId", user.userId);
//			s = "loginerror";
//		}
//		response.sendRedirect("index.jsp");
		return "redirect:/web/index.jsp";
	}
}
