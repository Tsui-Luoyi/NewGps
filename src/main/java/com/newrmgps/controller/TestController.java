package com.newrmgps.controller;

import java.util.HashMap;

import javax.annotation.Resource;







import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.jsd.db.pojo.TcustomerList;
import com.jsd.service.JsdCustomer;
import com.jsd.service.impl.JsdCustomerImpl;
import com.jsd.utils.Page;
import com.newrmgps.mybatis.sdk.factory.NewRmgpsFacotry;
@Controller
@RequestMapping("/logintest")
//@Service("NewRmgpsFacotry")
public class TestController {
//	@Autowired
	@RequestMapping(value="/Tclient/save")
	public String checkuser() {
		TcustomerList tcustomerList = new TcustomerList();
tcustomerList.setPageNo(1);
   tcustomerList.setPageSize(3);
 // tcustomerList.setCustomername("中国");
	//	 tcustomerList.setCustomername("张三");
    //    tcustomerList.setOrder("DESC");
	//   tcustomerList.setOrderBy("CREATETIME");
		String jsonString = JSON.toJSONString(tcustomerList);
		JsdCustomerImpl jsdCustomerImpl = new JsdCustomerImpl();
		Page<TcustomerList> customerLists = jsdCustomerImpl.getCustomerLists(1, jsonString);
		System.out.println(customerLists);
		return "fenye";
	}
/*	@RequestMapping(value="/list")
	public @ResponseBody Page<TcustomerList> checkuser(@RequestBody TcustomerList Data ) {
		System.out.println(Data+"%%%");
	//	int checkCustomerName =NewRmgpsFacotry.getJsdCustomer().checkCustomerName(40, "三级测试客户");
		      JsdCustomer jsdCustomerImpl = new JsdCustomerImpl();
		   System.out.println(Data);
		     String jsonString = JSON.toJSONString(Data);
		      Page<TcustomerList> page = jsdCustomerImpl.getCustomerLists(1, jsonString);   	  
		  	System.out.println(page);
		return page;
	}*/
	/*@RequestMapping(value="/list")
	"pageSize":$("#pageSize").val(),
	"pageNo":$("#currentPage").val(),
	"customername":$("#searchCustom").val(),
	"contact_phone":$("#searchTel").val(),
	"user_name":$("#searchAdmin").val(),
	"orderBy":$("#sortBy").val(),
	"order":$("#sortType").val()
	public @ResponseBody Page<TcustomerList> checkuser(HttpServletRequest request) {
	 System.out.println(Integer.parseInt(request.getParameter("pageSize")));    
	 System.out.println(Integer.parseInt(  request.getParameter("pageNo")));    
	     HashMap<String, Object> map = new HashMap<String, Object>();
	     map.put("pageSize", request.getParameter("pageSize"));
	     map.put("pageNo", request.getParameter("pageNo"));
	     map.put("customername", request.getParameter("customername"));
	     map.put("contact_phone", request.getParameter("contact_phone"));
	     map.put("user_name", request.getParameter("user_name"));
	     map.put("orderBy", request.getParameter("orderBy"));
	     map.put("order", request.getParameter("order"));
	     //将map解析成json字符串.
	     String jsonString2 = JSON.toJSONString(map);
	     System.out.println(jsonString2);
	       //	int checkCustomerName =NewRmgpsFacotry.getJsdCustomer().checkCustomerName(40, "三级测试客户");
		JsdCustomer jsdCustomerImpl = new JsdCustomerImpl();
		Page<TcustomerList> page = jsdCustomerImpl.getCustomerLists(1, jsonString2);   	  
		System.out.println(page);
		return page;
	}*/
	@RequestMapping(value="/list")
	/*"pageSize":$("#pageSize").val(),
	"pageNo":$("#currentPage").val(),
	"customername":$("#searchCustom").val(),
	"contact_phone":$("#searchTel").val(),
	"user_name":$("#searchAdmin").val(),
	"orderBy":$("#sortBy").val(),
	"order":$("#sortType").val()*/
	public @ResponseBody Page<TcustomerList> checkuser(HttpServletRequest request) {
		System.out.println(request.getParameter("data"+"%%"));
		JsdCustomer jsdCustomerImpl = new JsdCustomerImpl();
		Page<TcustomerList> page = jsdCustomerImpl.getCustomerLists(1, request.getParameter("data"));   	  
		
		return page;
	}
	
	public static void main(String[] args){
//		JsdCustomer jsdc=NewRmgpsFacotry.getJsdCustomer();
		int checkCustomerName =NewRmgpsFacotry.getJsdCustomer().checkCustomerName(40, "三级测试客户");
//		int checkCustomerName = jsdc.checkCustomerName(40, "三级测试客户");
		System.out.println(checkCustomerName);
	}
}
