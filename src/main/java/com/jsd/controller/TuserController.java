package com.jsd.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jsd.service.JsdCustomer;
import com.jsd.service.JsdTuser;
import com.jsd.service.impl.JsdCustomerImpl;
import com.jsd.service.impl.JsdTuserImpl;
import com.jsd.service.vo.CustomerVo;
import com.jsd.service.vo.TuserVo;

@Controller
@RequestMapping("/User")
public class TuserController {
	
	@RequestMapping("toAddCustomAdmin")
	public String toAddUserAdmin(){
		System.out.println("登录成功");
		return "addCustomerAdmin";
	}
	
	@RequestMapping("checkUserCode")
	public  @ResponseBody String checkUserCode( String userCode){
		//进行检测
		//通过session获取id
		System.out.println("进行验证");
		System.out.println(userCode);
		JsdTuser jsdTuserImpl = new JsdTuserImpl();
		int checkUserCode = jsdTuserImpl.checkUserCode(1, userCode);
		System.out.println(checkUserCode);
		if (checkUserCode==1) {
			return "true";
		}else {
			return"false";
		}
	}
	@RequestMapping(value ="/toAddMonitor",produces={"text/html;charset=UTF-8;"})
	public  String  toAddMonitor( ){
		//判断登录
		System.out.println("进入跳转页面");
		
		return "addMonitor";
	}
	@RequestMapping(value ="/addCustomAdmin",produces={"text/html;charset=UTF-8;"})
	public  @ ResponseBody String addCustomer( TuserVo u){
		System.out.println(u.getUserCode());
		//通过session获取id,
		System.out.println("添加管理员");
		JsdTuser jsdTuserImpl = new JsdTuserImpl();
		System.out.println(u.getCustomerid());
		u.setUserTypeid(1);
		int addTuser = jsdTuserImpl.addTuser(1, u);
		System.out.println(addTuser);
		if (addTuser==1) {
			return "true";
		}
		return "false";
	}
	
	

}
