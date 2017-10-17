package com.jsd.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.jsd.db.pojo.Group;
import com.jsd.db.pojo.Tuser;
import com.jsd.service.JsdGroup;
import com.jsd.service.JsdTuser;
import com.jsd.service.impl.JsdGroupImpl;
import com.jsd.service.impl.JsdTuserImpl;
import com.jsd.service.impl.JsdVehicleImpl;
import com.jsd.service.vo.GroupVo;
import com.jsd.service.vo.ShowGV;
import com.jsd.utils.Page;

@Controller
@RequestMapping("Group")

public class GroupController {
	
	@RequestMapping("showGV")
	public void  showGV(HttpServletResponse response){
		System.out.println("假设已经获取到了登录用户的id");
		System.out.println("展示出用户的所有分组");
	JsdGroup jsdGroupImpl = new JsdGroupImpl();
	List<Group> groups = jsdGroupImpl.selectGroupsforpageBycreateUserId(1);
	String jsonString = JSONArray.fromObject(groups).toString();
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
	@RequestMapping("addGroupsForMonitor")
	public @ResponseBody  String addGroupsForMonitor(String selectedGroup,String userId){
		System.out.println("假设已经获取到了登录用户的id");
		System.out.println(selectedGroup);
		JsdTuserImpl jsdTuserImpl = new JsdTuserImpl();
		System.out.println(userId);
		System.out.println(selectedGroup);
		int num = jsdTuserImpl.addTuserGroup(Integer.parseInt(userId), selectedGroup);
		if (num!=0) {
			return ""+num;
		}
		return "false";
	
	}
	//toAddGroup addGroup
	@RequestMapping("toAddGroup")
	public String toAddGroup(){
		
	   System.out.println("进入去添加分组页面,并且假设用户处于登录中");
		
		return "addGroup";
	}
	@RequestMapping("toFindGroup")
	public String toFindGroup(){
		
		System.out.println("进入去查询分组页面,并且假设用户处于登录中");
		
		return "findGroup";
	}
	@RequestMapping("addGroup")
	public  @ResponseBody String  addGroup(Group group,String selectedUser){
		System.out.println("进入添加分组方法");
		System.out.println(group.getName());
		System.out.println("为分组添加字符串的列表为: "+selectedUser);
		JsdGroup jsdGroupImpl = new JsdGroupImpl();
		int addGroup = jsdGroupImpl.addGroup(1, group);
		if (addGroup!=1) {
			//添加失败
			return "0";
		}
		Group group2 = jsdGroupImpl.getGroupByName(group.getName());
		if (null==group2) {
		return "0";
		}
		
		int num = jsdGroupImpl.addUserGroups(group2.getId(), selectedUser);
		return ""+num;
	}
	@RequestMapping("checkGroupName")
	public @ResponseBody String checkGroupName(String name){
		
		System.out.println("进入验证分组名称的方法,效率可能有些低"+name);
		JsdGroup jsdGroupImpl = new JsdGroupImpl();
		int num = jsdGroupImpl.checkGroupName(name);
		if (num==1) {
			return "true";
		}
		return "false";
	}
	@RequestMapping(value ="/getGroupLists",produces={"text/html;charset=UTF-8;"})
	public  void  getMonitorLists( HttpServletResponse response, String data){
		
		System.out.println("进入查询分组列表方法");
		System.out.println(data);
		JsdGroup jsdGroupImpl = new JsdGroupImpl();
	    Page<GroupVo> groupLists = jsdGroupImpl.getGroupLists(data, 1);
		String jsonString = JSON.toJSONString(groupLists);
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
