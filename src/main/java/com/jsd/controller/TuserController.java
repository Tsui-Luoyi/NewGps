package com.jsd.controller;

import java.io.IOException;
import java.util.List;

import javax.json.Json;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.annotation.JsonTypeInfo.Id;
import com.jsd.db.pojo.Group;
import com.jsd.db.pojo.Tcustomer;
import com.jsd.db.pojo.Tuser;
import com.jsd.domain.factory.BeanFactory;
import com.jsd.service.JsdCustomer;
import com.jsd.service.JsdGroup;
import com.jsd.service.JsdTuser;
import com.jsd.service.impl.JsdCustomerImpl;
import com.jsd.service.impl.JsdGroupImpl;
import com.jsd.service.impl.JsdTuserImpl;
import com.jsd.service.vo.CustomerVo;
import com.jsd.service.vo.TuserVo;
import com.jsd.test.newCustomerTest;
import com.jsd.utils.Page;

@Controller
@RequestMapping("/User")
public class TuserController {
	
	
	
	@RequestMapping("login")
	public String toLogin(String userCode, HttpSession session){
		     JsdTuser jsdTuserImpl = new JsdTuserImpl();
		     System.out.println("登录code为"+userCode);
		     if (userCode==null) {
				return "error";
			}
      Tuser tuser = jsdTuserImpl.selectTuserByUserCode(userCode);
      System.out.println(tuser.getId());
         if (null!=tuser) {
	   System.out.println("登录成功");
	  session.setAttribute("userId", tuser.getId()); 
	  session.setAttribute("userName", tuser.getUserName());
	  return "center";
}
		System.out.println("登录失败");
		return "error";
	}
	
	@RequestMapping("checkUserCode")
	public  @ResponseBody String checkUserCode( String userCode,HttpSession session){
		//进行检测
		//通过session获取id
		System.out.println("进行验证");
		System.out.println(userCode);
		JsdTuser jsdTuserImpl = new JsdTuserImpl();
		int checkUserCode = jsdTuserImpl.checkUserCode((int) session.getAttribute("userId"), userCode);
		System.out.println(checkUserCode);
		if (checkUserCode==1) {
			return "true";
		}else {
			return"false";
		}
	}
	@RequestMapping(value ="/toAddMonitor",produces={"text/html;charset=UTF-8;"})
	public  String  toAddMonitor(Model model,HttpSession session){
		//判断登录,并且使用用户id查询出用户的所属客户传递到前台页面
		 JsdCustomerImpl jsdCustomerImpl = new JsdCustomerImpl();
		 int id = jsdCustomerImpl.selectCustomerIdByAdminId((int) session.getAttribute("userId"));
		 System.out.println(id);
		 model.addAttribute("customerId", id);
		System.out.println("进入跳转页面");
		
		return "addMonitor";
	}
	
	
	@RequestMapping("/toLogin")
	public  String  toLogin(){
		//判断登录,并且使用用户id查询出用户的所属客户传递到前台页面
		//假设登录成功
		
		System.out.println("进入login页面");
		return "login";
	}
	@RequestMapping("/tomanager")
	public  String  tomanager(){
		//判断登录,并且使用用户id查询出用户的所属客户传递到前台页面
		//假设登录成功
		
		System.out.println("进入login页面");
		return "manager";
	}
	@RequestMapping("/toPositionCenter")
	public  String  toPositionCenter(){
		//判断登录,并且使用用户id查询出用户的所属客户传递到前台页面
		//假设登录成功
		System.out.println("进入login页面");
		return "positionCenter";
	}
	
	@RequestMapping("/toAddCustomAdmin")
	public  String  toAddCustomAdmin(){
		//判断登录,并且使用用户id查询出用户的所属客户传递到前台页面
		//假设登录成功
		System.out.println("进入login页面");
		return "addCustomerAdmin";
	}
	@RequestMapping("/toManagerCenter")
	public  String  toManagerCenter(){
		//判断登录,并且使用用户id查询出用户的所属客户传递到前台页面
		//假设登录成功
		System.out.println("进入login页面");
		return "managerCenter";
	}
	@RequestMapping(value ="/toFindMonitor",produces={"text/html;charset=UTF-8;"})
	public  String  toFindMonitor(){
		//判断登录,并且使用用户id查询出用户的所属客户传递到前台页面
	    //假设登录成功
		
		System.out.println("进入findMonitor页面");
		
		return "findMonitor";
	}
	@RequestMapping(value ="/ToChangeUser",produces={"text/html;charset=UTF-8;"})
	public  String  ToChangeUser(int id, Model model,HttpSession session){
		//判断登录,并且使用用户id查询出用户的所属客户传递到前台页面
		//假设登录成功changeUser
		 JsdCustomerImpl jsdCustomerImpl = new JsdCustomerImpl();
		 int customerId = jsdCustomerImpl.selectCustomerIdByAdminId((int) session.getAttribute("userId"));
		 System.out.println(customerId);
		 model.addAttribute("customerId", customerId);
		System.out.println("进入跳转页面");
		System.out.println(id);
		model.addAttribute("id", id);
		System.out.println("进入changeUser页面");
		return "changeUser";
	}
	@RequestMapping(value ="/addCustomAdmin",produces={"text/html;charset=UTF-8;"})
	public  @ ResponseBody String addCustomAdmin( TuserVo u,HttpSession session){
		System.out.println(u.getUserCode());
		System.out.println(u.getCustomerid());
		//通过session获取id,
		System.out.println("添加管理员");
		JsdTuser jsdTuserImpl = new JsdTuserImpl();
		JsdCustomer jsdCustomerImpl = new JsdCustomerImpl();
		System.out.println(u.getCustomerid());
		u.setUserTypeid(1);
		int addTuser = jsdTuserImpl.addTuser((int) session.getAttribute("userId"), u);
		if (addTuser==0) {
			return "false";
		}
		Tuser user = jsdTuserImpl.selectTuserByUserCode(u.getUserCode());
		Tcustomer tcustomer2 = new Tcustomer();
		tcustomer2.setId(u.getCustomerid());
		tcustomer2.setAdminid(user.getId());
		 jsdCustomerImpl.updateByPrimaryKeySelective(tcustomer2);
		System.out.println(addTuser);
		if (addTuser==1) {
			return "true";
		}
		return "false";
	}
	@RequestMapping(value ="/addCustomMonitor",produces={"text/html;charset=UTF-8;"})
	public  @ ResponseBody String addCustomerMonitor( Tuser u,HttpSession session){
		System.out.println(u.getUserCode());
		System.out.println(u.getUserName());
		System.out.println(u.getUserPassword());
		System.out.println(u.getUserTypeid());
		//通过session获取id,
		System.out.println("添加监控员");
		JsdTuser jsdTuserImpl = new JsdTuserImpl();
		//通过创建者用户id获得客户id.
		JsdCustomer jsdCustomerImpl = new JsdCustomerImpl();
		int customerId = jsdCustomerImpl.selectCustomerIdByAdminId((int) session.getAttribute("userId"));
		System.out.println(customerId);
		u.setCustomerid(customerId);
		u.setCreaterUserid((int) session.getAttribute("userId"));
		int addTuser = jsdTuserImpl.addMonitor(u);
		System.out.println(addTuser);
		Tuser tuser = jsdTuserImpl.selectTuserByUserCode(u.getUserCode());
		System.out.println(tuser.getId());
		if (addTuser==1) {
			return tuser.getId()+"";
		}
		return "false";
	}
	@RequestMapping(value ="/updateMonitor",produces={"text/html;charset=UTF-8;"})
	public  @ ResponseBody String updateMonitor( Tuser u){
		System.out.println("进入修改监控员页面");
		//通过session获取id,
		
	System.out.println("监控员名称是是"+u.getUserName());
		JsdTuser jsdTuserImpl = new JsdTuserImpl();
		int addTuser = jsdTuserImpl.updateUserByuserId(u);
		System.out.println(addTuser);
		if (addTuser==1) {
			return "success";
		}
	/*	Tuser tuser = jsdTuserImpl.selectTuserByUserCode(u.getUserCode());
		System.out.println(tuser.getId());
		if (addTuser==1) {
			return tuser.getId()+"";
		}*/
		return "false";
	}
	@RequestMapping(value ="/getMonitorLists",produces={"text/html;charset=UTF-8;"})
	public  void  getMonitorLists( HttpServletResponse response, String data,HttpSession session){
		
		System.out.println("进入查询监控员列表方法");
		System.out.println(data);
		JsdTuser jsdTuserImpl = new JsdTuserImpl();
	    Page<Tuser> tuserLists = jsdTuserImpl.getTuserLists(data, (int) session.getAttribute("userId"));
		String jsonString = JSON.toJSONString(tuserLists);
		response.setContentType("application/json; charset=UTF-8");
			try {
				response.getWriter().print(jsonString);
				response.getWriter().flush();//刷新流.
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
	@RequestMapping("deleteMonitorByMonitorId")
	public @ResponseBody String deleteMonitorByMonitorId(int id){
		System.out.println("进入删除监控员方法");
		
		JsdTuser jsdTuserImpl = new JsdTuserImpl();
		int num = jsdTuserImpl.deleteMonitorByMonitorId(id);
		
		System.out.println("删除操作完成");
		return num+"";
		
		
	}
	//deletePartMonitorByMonitorId nonMonitorByMonitor
	@RequestMapping("deletePartMonitorByMonitorId")
	public @ResponseBody String deletePartMonitorByMonitorId(String selectId){
		System.out.println(selectId);
		
		JsdTuser jsdTuserImpl = new JsdTuserImpl();
		int num = jsdTuserImpl.deletePartMonitorByMonitorId(selectId);
		System.out.println("删除操作完成");
		return num+"";	
	}
	@RequestMapping("nonMonitorByMonitor")
	public @ResponseBody String nonMonitorByMonitor(int id){
		
		System.out.println("进入停用监控员的操作停用id为"+id);
		
		JsdTuser jsdTuserImpl = new JsdTuserImpl();
		int num = jsdTuserImpl.nonMonitorByMonitor(id);
		System.out.println("停用操作完成");
		return num+"";
		
		
	}
	@RequestMapping("resetPasswordByuserId")
	public @ResponseBody String resetPasswordByuserId(int id){
		
		System.out.println("进入重置监控员的操作停用id为"+id);
		
		JsdTuser jsdTuserImpl = new JsdTuserImpl();
		int num = jsdTuserImpl.resetPasswordByuserId(id);
		System.out.println("重置操作完成");
		return num+"";
		
	
	}
	@RequestMapping("	RestartMonitorByMonitor")
	public @ResponseBody String 	RestartMonitorByMonitor(int id){
		
		System.out.println("进入重启监控员的操作停用id为"+id);
		
		JsdTuser jsdTuserImpl = new JsdTuserImpl();
		int num = jsdTuserImpl.RestartMonitorByMonitor(id);
		System.out.println("重启操作完成");
		return num+"";
		
		
	}
//showMonitorsForPage
	
	@RequestMapping(value = "showMonitorsForPage", produces={"text/html;charset=UTF-8;"})
	public void	showMonitorsForPage(HttpServletResponse response,HttpSession session){
		
		System.out.println("假设已经获取到了登录用户的id");
		System.out.println("展示出用户的所有监控员");
	    JsdTuser jsdTuserImpl = new JsdTuserImpl();
	    List<Tuser> tusers = jsdTuserImpl.showMonitorsForPage((int) session.getAttribute("userId"));
	    for (Tuser tuser : tusers) {
			System.out.println(JSON.toJSONString(tuser));
		}
	    String jsonString = JSONArray.fromObject(tusers).toString();
	    System.out.println(jsonString);
		response.setContentType("application/json; charset=UTF-8");
				try {
					response.getWriter().print(jsonString);
					response.getWriter().flush();//刷新流.
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		
	}
	
	
	

}
