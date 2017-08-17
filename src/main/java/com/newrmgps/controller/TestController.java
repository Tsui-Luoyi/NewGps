package com.newrmgps.controller;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jsd.service.JsdCustomer;
import com.newrmgps.mybatis.sdk.factory.NewRmgpsFacotry;
@Controller
@RequestMapping("/logintest")
//@Service("NewRmgpsFacotry")
public class TestController {
//	@Autowired
	@RequestMapping(value="/Tclient/save")
	public String checkuser() {
		return "";
	}
	
	public static void main(String[] args){
//		JsdCustomer jsdc=NewRmgpsFacotry.getJsdCustomer();
		int checkCustomerName =NewRmgpsFacotry.getJsdCustomer().checkCustomerName(40, "三级测试客户");
//		int checkCustomerName = jsdc.checkCustomerName(40, "三级测试客户");
		System.out.println(checkCustomerName);
	}
}
