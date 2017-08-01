package com.newrmgps.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.newrmgps.mybatis.pojo.Tuser;
import com.newrmgps.mybatis.pojo.usert;
import com.newrmgps.mybatis.service.IUserService;
import com.newrmgps.mybatis.service.TuserService;

@Controller
@RequestMapping("/user")
public class UserController {
	@Resource
	private IUserService userService;
	@Resource
	private TuserService   tuserService;
	
	@RequestMapping("/showUser")
	public String toIndex(HttpServletRequest request,Model model){
		int userId = Integer.parseInt(request.getParameter("id"));
		usert user = this.userService.getUserById(userId);
		model.addAttribute("user", user);
		return "showUser";
	}
	@RequestMapping("/Tuser/querybyclientid")
	public  String  queryByClientId(){
		  List<Tuser> queryByclientId = tuserService.queryByclientId(1);
		  System.out.println("查询过后");
		  System.out.println(queryByclientId);
		return "success";
	}
	@RequestMapping("/Tuser/querybyCreateUser")
	public  String  queryByCreateUser(){
	List<Tuser> list = tuserService.queryBycreateUserId(1);
		  System.out.println("查询过后");
		  System.out.println(list);
		return "success";
	}
	@RequestMapping("/Tuser/deletebyId")
	public  String  deletebyId(){
		System.out.println("删除开始");
	        tuserService.deleteById(2);
		System.out.println("删除成功");
		return "success";
	}
}