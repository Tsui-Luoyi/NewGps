package com.newrmgps.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.jms.Session;

import org.omg.CORBA.PUBLIC_MEMBER;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mysql.fabric.xmlrpc.base.Array;
import com.newrmgps.mybatis.pojo.Tclient;
import com.newrmgps.mybatis.pojo.Tcu;
import com.newrmgps.mybatis.pojo.TclientList;
import com.newrmgps.mybatis.pojo.Tuser;
import com.newrmgps.mybatis.service.TclientService;
import com.newrmgps.mybatis.service.TuserService;

@Controller
public class TclientController {
   @Resource
   private TclientService tclientService;
   @Resource
   private TuserService tuserService ;
   @RequestMapping(value="/Tclient/save")
    public  String  saveTcleint(Model model){//@RequestBody Tcu tcu
	   System.out.println("传过来了");
	   Tclient tclient = new Tclient();
     	tclient.setId(69999);
	     tclient.setClientname("testA");
	     tclientService.saveTclient(tclient);
	          Tuser tuser = new Tuser();
	         tuser.setClientid(29999);
	         tuser.setCreaterUserid(0);
	//         tuser.setCreatetime(new Date());
	       //  tuser.setId(3000);
	         tuser.setUserCode("jsd");
	         tuser.setUserName("金圣达");
	         tuser.setUserPassword("666666");
	         tuserService.saveTuser(tuser);
	     System.out.println("成功");
       return  "success";
   }
   @RequestMapping(value="/Tclient/only")
   public  String  isExsistTcleint(String clientName ){//@RequestBody Tcu tcu
	   //通过姓名查询所有
	      int num = tclientService.findByTclientName(clientName);
	      if (num>0) {
	   	 System.out.println(num);
			return "true";
		}   
	   return  "addClient";
   }
   @RequestMapping(value="/toLogin")
   public  String  toLogin( ){
	   return  "login";
   }
   @RequestMapping("Tclient/query")
  public  String  queryTclientList () {
	             //填写查询的条件
        TclientList tlientList = new TclientList();
	   //将查询条件返回给后台的接口.
                     tlientList.setClientname("一级测试");
            
                    List<TclientList> list = tclientService.queryAll(tlientList);
  
	   return "success";
   }
	   @RequestMapping("Tclient/updateClient")
	   public  String  updateTclient(){
		   //将传递过来的vo获得client对象,作为参数传递给接口处理
		                    Tclient tclient = new Tclient();
		                    tclient.setId(1);
		                    tclient.setClientname("修改1");
		                    tclient.setContactName("修改1联系人");
		                    tclient.setContactPhone("18713010000");
		                    tclient.setCreaterUserid(0);
		                    tclient.setCreatetime(new Date());       
		                    tclientService.updatTclient(tclient);
		   return "success";
	   }
   @RequestMapping("Tclient/deleteTclient")
       public  String  deleteTclient(){
	   Integer id = 1;
	 
	    tclientService.deleteTclientAll(3);
	   return "success";
   }
   @RequestMapping("Tclient/deletePartTclient")
   public  String  deletePartTclient(){
   //简单的批量删除客户,不关联其他 传递过来的是list数组
      ArrayList<Integer> arrayList = new  ArrayList<Integer>();
      arrayList.add(2);
      arrayList.add(6);
      arrayList.add(8);
      //配量删除客户
      System.out.println("进入批量删除");
       tclientService.deleteBydartId(arrayList);
     System.out.println("走出批量删除");
   return "success";
}
   
}
