package com.newrmgps.mybatis.sdk.factory;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jsd.service.*;
import com.jsd.service.impl.JsdCustomerImpl;
import com.jsd.service.vo.CustomerVo;

@Controller
public class NewRmgpsFacotry {

	/*public static JsdCustomer getJsdCustomer() {
		JsdCustomer JsdCustomerimpl=new JsdCustomerImpl();
		          
		return JsdCustomerimpl;
		
	}*/
	@RequestMapping("/addCustomer")
	public String  addCustomer(CustomerVo  customer) {
		System.out.println(customer);
		JsdCustomerImpl jsdCustomerImpl = new JsdCustomerImpl(); 
		 int num1 = jsdCustomerImpl.addCustomer(1, customer);
		 System.out.println(num1);
		return "success";
		
	}
	@RequestMapping("/checkCustomer")
	public String  checkCustomer( String name) {
		System.out.println(name);
		JsdCustomerImpl jsdCustomerImpl = new JsdCustomerImpl(); 
		int num1 = jsdCustomerImpl.checkCustomerName(1, name);
		if (num1 ==1 ) {
			return "true";
		}
		return "false";
		
	}


}
