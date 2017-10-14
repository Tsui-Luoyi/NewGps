package com.jsd.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jsd.db.pojo.Tuser;
import com.jsd.service.JsdCustomer;
import com.jsd.service.JsdTuser;
import com.jsd.service.impl.JsdCustomerImpl;
import com.jsd.service.impl.JsdTuserImpl;
import com.jsd.service.vo.CustomerVo;
import com.jsd.service.vo.TuserVo;
import com.jsd.test.newCustomerTest;

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
	public  String  toAddMonitor(Model model ){
		//判断登录,并且使用用户id查询出用户的所属客户传递到前台页面
		 JsdCustomerImpl jsdCustomerImpl = new JsdCustomerImpl();
		 int id = jsdCustomerImpl.selectCustomerIdByAdminId(10);
		 System.out.println(id);
		 model.addAttribute("customerId", id);
		System.out.println("进入跳转页面");
		
		return "addMonitor";
	}
	@RequestMapping(value ="/addCustomAdmin",produces={"text/html;charset=UTF-8;"})
	public  @ ResponseBody String addCustomer( TuserVo u){
		System.out.println(u.getUserCode());
		System.out.println(u.getCustomerid());
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
	@RequestMapping(value ="/addCustomMonitor",produces={"text/html;charset=UTF-8;"})
	public  @ ResponseBody String addCustomerMonitor( Tuser u){
		System.out.println(u.getUserCode());
		System.out.println(u.getCustomerid());
		System.out.println(u.getUserPassword());
		System.out.println(u.getUserTypeid());
		//通过session获取id,
		System.out.println("添加监控员");
		JsdTuser jsdTuserImpl = new JsdTuserImpl();
		System.out.println(u.getCustomerid());
		int addTuser = jsdTuserImpl.addMonitor(u);
		System.out.println(addTuser);
		if (addTuser==1) {
			return "true";
		}
		return "false";
	}
	
	

}
