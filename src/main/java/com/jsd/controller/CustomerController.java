package com.jsd.controller;

import java.io.IOException;
import java.util.List;

import javax.json.JsonString;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.jsd.db.pojo.Tcustomer;
import com.jsd.db.pojo.TcustomerList;
import com.jsd.service.JsdCustomer;
import com.jsd.service.impl.JsdCustomerImpl;
import com.jsd.service.vo.CustomerVo;
import com.jsd.utils.Page;
import com.mysql.fabric.xmlrpc.base.Data;

@Controller
@RequestMapping("/Customer")

public class CustomerController {

	@RequestMapping("/checkCustomer")
	
	public  @ResponseBody String checkCustomer( String name,HttpSession session){
		
		System.out.println(name);
		JsdCustomer customer = new JsdCustomerImpl();
		int flag = customer.checkCustomerName((int) session.getAttribute("userId"), name);
		System.out.println(flag);
		if (flag==0) {
			System.out.println("没有false页面");
			return "false";
		}
		return "tRue";
	}
	@RequestMapping("/toAddCustomer")
	public String toAddCustomer( HttpSession session){
	   System.out.println("登录成功");
	   //如果登录失败跳转到其他的页面
	   System.out.println(session.getAttribute("userId"));
		return "addCustomer";
	}
	
@RequestMapping(value ="/addCustomer",produces={"text/html;charset=UTF-8;"})
	public  @ResponseBody String addCustomer( CustomerVo c,HttpSession session){
		System.out.println(c.getPhone());
		JsdCustomer customer = new JsdCustomerImpl();    
		int addCustomer = customer.addCustomer((int) session.getAttribute("userId"),c);
		System.out.println(addCustomer);
		return "success";
	}


@RequestMapping(value ="/selecTcustomersByCAId",produces={"text/html;charset=UTF-8;"})
	public void selecTcustomersByCAId( HttpServletResponse response,HttpSession session){
		//userId从session中获得,现在先假设已经获得了.
		System.out.println("开始查询没有管理员的客户");
		
	    JsdCustomer customer = new JsdCustomerImpl();               
	    List<Tcustomer> Customers = customer.selectTcustomersByCnA((int) session.getAttribute("userId"));
	    String jsonString = JSON.toJSONString(Customers);
		response.setContentType("application/json; charset=UTF-8");
		try {
			response.getWriter().print(jsonString);
			System.out.println("执行完毕");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

@RequestMapping(value ="/toFindCustomer",produces={"text/html;charset=UTF-8;"})
public String toFindCustomer (){
	System.out.println("登录成功");
	return "findCustomer";
}

@RequestMapping(value ="/getCustomerLists",produces={"text/html;charset=UTF-8;"})
//接受参数的时候可能有一点小问题.
/*"pageSize":$("#pageSize").val(),
"pageNo":$("#currentPage").val(),
"customername":$("#searchCustom").val(),
"contact_phone":$("#searchTel").val(),
"user_name":$("#searchAdmin").val(),
"orderBy":$("#sortBy").val(),
"order":*/
public void getCustomerLists ( HttpServletResponse response, String data,HttpSession session  ){
	
	System.out.println("进入查询");
	System.out.println(data);

	JsdCustomer customer = new JsdCustomerImpl();
	//通过Session获取userId,通过
	Page<TcustomerList> page = customer.getCustomerLists((int) session.getAttribute("userId"), data);
	String string = JSON.toJSONString(page);
	response.setContentType("application/json; charset=UTF-8");
		try {
			response.getWriter().print(string);
			response.getWriter().flush();//刷新流.
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
}
@RequestMapping(value ="/deleteCustomerByCustomerId")
public  @ResponseBody String deleteCustomerByCustomerId ( Integer id ){
	System.out.println("进入删除");
	System.out.println(id);
	JsdCustomer customer = new JsdCustomerImpl();
	//通过Session获取userId,通过
	    int num = customer.deleteCustomerByCustomerId(id);
	    System.out.println(num+"删除完毕");
	    return ""+num;	    
}

@RequestMapping(value ="/nonUseCustomerByCustomerId")
public  @ResponseBody String nonUseCustomerByCustomerId ( Integer id ){
	System.out.println("进入停用"+id);
	JsdCustomer customer = new JsdCustomerImpl();
	//通过Session获取userId,通过
	int num = customer.nonUseCustomerByCustomerId(id);
	System.out.println(num);
	System.out.println(num+"停用完毕");
	return ""+num;
	
}
	

}
