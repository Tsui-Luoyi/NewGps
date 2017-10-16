package com.jsd.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jsd.db.pojo.Group;
import com.jsd.service.JsdGroup;
import com.jsd.service.impl.JsdGroupImpl;
import com.jsd.service.impl.JsdTuserImpl;
import com.jsd.service.impl.JsdVehicleImpl;
import com.jsd.service.vo.ShowGV;

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

}
