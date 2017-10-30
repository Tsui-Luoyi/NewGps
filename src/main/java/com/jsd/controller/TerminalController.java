package com.jsd.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.jsd.db.pojo.Command;
import com.jsd.db.pojo.Commandhistory;
import com.jsd.db.pojo.Terminal;
import com.jsd.db.pojo.Tuser;
import com.jsd.db.pojo.Tvband;
import com.jsd.service.JsdTerminal;
import com.jsd.service.JsdTuser;
import com.jsd.service.JsdVehicle;
import com.jsd.service.impl.JsdTerminalImpl;
import com.jsd.service.impl.JsdTuserImpl;
import com.jsd.service.impl.JsdVehicleImpl;
import com.jsd.service.vo.ShowCommandsVo;
import com.jsd.service.vo.ShowGVT;
import com.jsd.service.vo.VehicleGoupVo;
import com.jsd.service.vo.VehicleVo;
import com.jsd.test.newCustomerTest;
import com.jsd.utils.Page;

@Controller
@RequestMapping("Terminal")
public class TerminalController {
	
	//查询出当前用户的所有未绑定的终端.
	@RequestMapping(value="/getUTerminals",produces={"text/html;charset=UTF-8;"})
	public void  selectTerminalsByUserId(HttpServletResponse response) {
		System.out.println("进入查询未绑定终端的列表");
		JsdTerminal jsdTerminalImpl = new JsdTerminalImpl();
		//假设已经获得了创建者用户id
		List<Terminal> terminals = jsdTerminalImpl.selectTerminalsByUserId(97);
		for (Terminal terminal : terminals) {
			System.out.println(terminal.getCode());
		}
		String jsonString = JSON.toJSONString(terminals);
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
	//查询出用户的所有未绑定的终端(传入用户Id.)
	@RequestMapping(value="/getTerminalsByUserId",produces={"text/html;charset=UTF-8;"})
	public void  selectTerminalsByUserId(HttpServletResponse response,Integer id) {
		System.out.println("进入查询用户未绑定终端的列表");
		System.out.println("用户id"+id);
		JsdTerminal jsdTerminalImpl = new JsdTerminalImpl();
		//假设已经获得了创建者用户id
		List<Terminal> terminals = jsdTerminalImpl.selectTerminalsByUserId(id);
		String jsonString = JSON.toJSONString(terminals);
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
	//查询当前创建者用户的他的用户及其子用户.
	@RequestMapping(value="/getUsers",produces={"text/html;charset=UTF-8;"})
	public void  getUsers(HttpServletResponse response) {
		System.out.println("进入查询用户的列表");
		JsdTuser jsdTuserImpl = new JsdTuserImpl();
		//假设已经获得了创建者用户id,假设已经获取到了当期用户
		List<Tuser> list = jsdTuserImpl.selectUserandChildUser(97);
		String jsonString = JSON.toJSONString(list);
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

	@RequestMapping("toFindTerminal")
	public  String toFindTerminal( ){
		
		System.out.println("进入绑定终端的jsp方法");
		
		return "findTerminal";
	}
	@RequestMapping("AddTvband")
	public  @ResponseBody String AddTvband( Integer vehicleId,String codes){
		//进行检测
		//通过session获取id
		System.out.println("进入绑定终端的方法");
		System.out.println("车辆id是:"+vehicleId+"终端codes为"+codes);
	     JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();
		int num = jsdVehicleImpl.addTvband(vehicleId, codes);
		System.out.println("共绑定了"+num+"个终端");
		return num+"";
	}
	//查询出车辆已经绑定的终端列表
	@RequestMapping(value="/getVTerminals",produces={"text/html;charset=UTF-8;"})
	public void  getVTerminals(HttpServletResponse response,Integer vehicleId) {
		System.out.println("进入查询车辆绑定终端的列表");
		//假设已经获得了创建者用户id
		JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();
		List<Tvband> tvbands = jsdVehicleImpl.selectTvbandsByVehicleId(vehicleId);
		String jsonString = JSON.toJSONString(tvbands);
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
	
	//为车辆解绑终端
	@RequestMapping("deleteTvband")
	public  @ResponseBody String deleteTvband( Integer vehicleId,String code){
		//进行检测
		//通过session获取id
		System.out.println("进入绑定终端的方法");
		System.out.println("车辆id是:"+vehicleId+"终端code为"+code);
	     JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();
		int num = jsdVehicleImpl.delelteTvbandByVC(code, vehicleId);
		System.out.println("解绑的个数为"+num);
		return num+"";
	}
	//获取终端的列表
	@RequestMapping(value = "/getTerminals", produces = { "text/html;charset=UTF-8;" })
	public void getTerminals(HttpServletResponse response, String data) {

		System.out.println("进入查询车辆的列表方法");
		System.out.println(data);
		  JsdTerminal jsdTerminalImpl = new JsdTerminalImpl();
		  Page<Terminal> terminalLists = jsdTerminalImpl.getTerminalLists(97, data);
		String jsonString = JSON.toJSONString(terminalLists);
		System.out.println(jsonString);
		jsdTerminalImpl.updateTerminalStatus(1, 0);
		response.setContentType("application/json; charset=UTF-8");
		try {
			response.getWriter().print(jsonString);
			response.getWriter().flush();// 刷新流.
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//进行退货操作.
		@RequestMapping("returns")
		public  @ResponseBody String returns(String codes){
			//进行检测
			//通过session获取id
			System.out.println("进入终端的退货方法");
			System.out.println("终端codes为"+codes);
			  JsdTerminal jsdTerminalImpl = new JsdTerminalImpl();
			  int num = jsdTerminalImpl.returns(codes);
			System.out.println("共退货了"+num+"个终端");
			return   ""+num;
		}
        //对已经退货的数据进行删除操作.
		@RequestMapping("deleteTerminals")
	public  @ResponseBody String deleteTerminals(String codes){
					//进行检测
					//通过session获取id
					System.out.println("进入终端的删除方法");
					System.out.println("终端codes为"+codes);
					  JsdTerminal jsdTerminalImpl = new JsdTerminalImpl();
					  int num = jsdTerminalImpl.deleteTerminalsByCodes(codes);
					  System.out.println("共删除了"+num+"个终端");					 return   ""+num;
			}
	
	//取消退货或者退后失败
		@RequestMapping("returnsOffails")
	public  @ResponseBody String returnsOffails(String codes){
					//进行检测
					//通过session获取id
					System.out.println("进入取消退货的方法");
					System.out.println("终端codes为"+codes);
					  JsdTerminal jsdTerminalImpl = new JsdTerminalImpl();
					  int num = jsdTerminalImpl.returnsOffails(codes);
					  System.out.println("共取消退后了"+num+"个终端");		
		  return   ""+num;
			}
		
		
		//移动终端
		@RequestMapping("moveTerminals")
	public  @ResponseBody String moveTerminals(String codes,Integer nUserId){
			System.out.println("进入移动终端的方法");
			System.out.println("终端codes为"+codes);
			JsdTerminal jsdTerminalImpl = new JsdTerminalImpl();
			int num = jsdTerminalImpl.updateTerminalsUser(codes, nUserId);
			System.out.println("共移动了"+num+"个终端");		
			return   ""+num;
		}
		
		//移动终端
		@RequestMapping("toMoveTerminal")
		public  String toMoveTerminal(){
			System.out.println("进入去移动终端的页面");
			return   "moveTerminal";
		}
		
		//通过终端code的内容来转到命令主页面
		@RequestMapping("toCommandPage")
		public  void  toCommandPage( String code,Model model ,HttpServletResponse response){
			System.out.println("进入跳转到命令页面页面");
	      JsdTerminal jsdTerminalImpl = new JsdTerminalImpl();
	      JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();
	      System.out.println("传递过来的终端编号为"+code);
		 Terminal terminal = jsdTerminalImpl.getTerminalByCode(code);
		System.out.println(terminal.getTypeid());
		 List<Command> commands = jsdVehicleImpl.selectCommandsByTerminalType(terminal.getTypeid());
		  ShowCommandsVo vo = new ShowCommandsVo(terminal, commands);
		  String jsonString = JSON.toJSONString(vo);
		  System.out.println(jsonString);
		 System.out.println("能跳转就过去");
		 response.setContentType("application/json; charset=UTF-8");
			try {
				response.getWriter().print(jsonString);
				response.getWriter().flush();// 刷新流.
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		//添加命令的历史记录
		@RequestMapping("addCommandhistory")
		public @ResponseBody String addCommandhistory(Commandhistory commandhistory){
			System.out.println("进入添加命令列表的页面");
			JsdTerminal jsdTerminalImpl = new JsdTerminalImpl();
			int num = jsdTerminalImpl.addCommandhistory(commandhistory);
			System.out.println("添加个数为"+num+"个");
			return ""+num ;
			
		}
		//展示出当前用户的GVT
		@RequestMapping("showGVT")
		public  void  showGVT( String code,Model model ,HttpServletResponse response){
			System.out.println("进入展示分组车辆终端页面页面");
	      JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();
	      List<ShowGVT> showGVT = jsdVehicleImpl.showGVT(5);
		  String jsonString = JSON.toJSONString(showGVT);
		 System.out.println("能跳转就过去");
		 response.setContentType("application/json; charset=UTF-8");
			try {
				response.getWriter().print(jsonString);
				response.getWriter().flush();// 刷新流.
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
				

}
