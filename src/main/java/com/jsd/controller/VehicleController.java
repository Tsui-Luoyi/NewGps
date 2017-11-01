package com.jsd.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.jsd.db.pojo.Driver;
import com.jsd.db.pojo.Group;
import com.jsd.db.pojo.Tcustomer;
import com.jsd.db.pojo.Tuser;
import com.jsd.db.pojo.VVehicleGroup;
import com.jsd.db.pojo.Vehicle;
import com.jsd.db.pojo.Vehicledetail;
import com.jsd.domain.factory.BeanFactory;
import com.jsd.service.JsdCustomer;
import com.jsd.service.JsdGroup;
import com.jsd.service.JsdTuser;
import com.jsd.service.JsdVehicle;
import com.jsd.service.impl.JsdCustomerImpl;
import com.jsd.service.impl.JsdGroupImpl;
import com.jsd.service.impl.JsdTuserImpl;
import com.jsd.service.impl.JsdVehicleImpl;
import com.jsd.service.vo.ShowCGV;
import com.jsd.service.vo.ShowGV;
import com.jsd.service.vo.VehicleGoupVo;
import com.jsd.service.vo.VehicleVo;
import com.jsd.utils.Page;
import com.jsd.utils.StringUtils;

@Controller
@RequestMapping("Vehicle")
public class VehicleController {

	@RequestMapping("toAddVehicle")
	public String toAddVehicle() {
		System.out.println("进入toAddVehicle页面");
		return "addVehicle";
	}

	@RequestMapping("toImportVehicles")
	public String toImportVehicles() {
		System.out.println("进入批量导入车辆的页面");
		return "importVehicles";
	}

	@RequestMapping("toMoveVehicles")
	public String toMoveVehicles() {
		System.out.println("进入去移动车辆的页面");
		return "moveVehicle";
	}

	@RequestMapping("toFindVehicles")
	public String toFindVehicles() {
		System.out.println("进入批量导入车辆的页面");
		return "findVehicle";
	}

	@RequestMapping("checkLicesenPlate")
	public @ResponseBody String selectVehicleBylicensePlate(String licensePlate) {
		System.out.println("进入检查车牌号页面页面车牌号为" + licensePlate);
		JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();
		Vehicle vehicle = jsdVehicleImpl
				.selectVehicleBylicensePlate(licensePlate);
		if (null == vehicle) {
			return "true";
		}
		return "false";
	}

	@RequestMapping("addVehicle")
	public @ResponseBody String addVehicle(Vehicle vehicle, String selectedGroup,HttpSession session) {
		System.out.println("进入添加车辆方法");
		System.out.println(vehicle.getLicensePlate());
		System.out.println("为车辆添加分组字符串的列表为: " + selectedGroup);
		JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();
		int addVehicle = jsdVehicleImpl.addVehicle((int) session.getAttribute("userId"), vehicle);

		if (addVehicle != 1) {
			// 添加失败
			return "0";
		}

		Vehicle vehicle2 = jsdVehicleImpl.selectVehicleBylicensePlate(vehicle
				.getLicensePlate());
		if (null == vehicle2) {
			System.out.println("您可能添加未成功");
			return "0";
		}
		jsdVehicleImpl.addvehicleGroups(vehicle2.getId(), selectedGroup);
		// 查询出车主的id
		Vehicle vehicle3 = jsdVehicleImpl.selectVehicleBylicensePlate(vehicle
				.getLicensePlate());
		if (null == vehicle3) {
			return "0";
		}
		System.out.println("添加车辆的id为" + vehicle3.getId());
		return "" + vehicle3.getId();
	}

	@RequestMapping("addVehicleDetail")
	public @ResponseBody String addVehicleDetail(Vehicledetail vehicledetail) {
		System.out.println("进入添加车辆详情方法");
		System.out.println(vehicledetail.getLicensePlate());
		System.out.println(vehicledetail.getColor());
		System.out.println(vehicledetail.getEnginecode());
		System.out.println(vehicledetail.getImage());
		System.out.println(vehicledetail.getName());
		System.out.println(vehicledetail.getProducter());
		System.out.println(vehicledetail.getVehbrand());

		JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();
		int num = jsdVehicleImpl.addvehicleDetail(
				vehicledetail.getLicensePlate(), vehicledetail);
		if (num != 1) {
			// 添加失败
			return "0";
		}
		return num + "";
	}

	@RequestMapping("addDriver")
	public @ResponseBody String addDriver(Driver driver, String vid) {
		System.out.println("进入添加车主方法");
		System.out.println(driver.getIdcard());
		System.out.println(driver.getName());
		System.out.println(driver.getPhone());
		System.out.println(driver.getTel());
		System.out.println(driver.getyDriveNum());
		System.out.println(driver.getyDriveType());
		System.out.println(driver.getCertifdate());
		System.out.println(vid + "@@@");
		JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();
		// 假设addDriver已经存在,验证身份证号
		int num = jsdVehicleImpl.addDriver(driver);
		if (num != 1) {
			// 添加失败
			return "0";
		}
		List<Driver> checkDrivers = jsdVehicleImpl.checkDrivers(driver
				.getIdcard());
		if (checkDrivers.size() == 1) {
			Integer driverId = checkDrivers.get(0).getId();
			System.out.println("打印车主id为" + driverId);
			// 在通过传递过来的id来更新数据库.跟新车辆表,检验成功
			int num1 = jsdVehicleImpl.updateVehicle(BeanFactory.createVehicle(
					Integer.parseInt(vid), driverId));
			return num1 + "";
		}
		return "0";
	}

	@RequestMapping("/uploadExcelFile")
	public String uploadExcelFile(MultipartFile fileName,
			HttpServletRequest request) {
		// 原始文件名称
		System.out.println("%%%%%");
		System.out.println("##" + fileName);
		System.out.println(fileName.getOriginalFilename());
		System.out.println(fileName.getName());
		String pictureFile_name = fileName.getOriginalFilename();
		System.out.println(pictureFile_name);

		// 判断文件是否为空
		if (!fileName.isEmpty()) {
			// 将上传内容备份服务器上
			File destFile = new File("F:/upload", System.currentTimeMillis()
					+ ".xls");
			try {
				fileName.transferTo(destFile);
				JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();

				String successMessage = jsdVehicleImpl.importVehiicle2007(1, 1,
						destFile.getAbsolutePath());
				return "success";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		// String importVehicles = jsdVehicleImpl.importVehiicle2007(1, 1, url)
		System.out.println("批量添加完成");
		return "success";
	}

	// getVehicles
	@RequestMapping(value = "/getVehicles", produces = { "text/html;charset=UTF-8;" })
	public void getVehicles(HttpServletResponse response, String data,HttpSession session) {

		System.out.println("进入查询车辆的列表方法");
		System.out.println(data);
		
		JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();
	/*	Page<VVehicleGroup> vehicleLists =  jsdVehicleImpl.getGehicleListsByUserId(data, (int) session.getAttribute("userId"));*/
	    Page<VVehicleGroup> vehicleLists = jsdVehicleImpl.getGehicleListsByUserId(data,  (int) session.getAttribute("userId"));
		String jsonString = JSON.toJSONString(vehicleLists);
		System.out.println((int) session.getAttribute("userId"));
		System.out.println(vehicleLists.getResults());
		System.out.println(jsonString);
		response.setContentType("application/json; charset=UTF-8");
		try {
			response.getWriter().print(jsonString);
			response.getWriter().flush();// 刷新流.
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// deleteVehicle

	@RequestMapping("deleteVehicle")
	public @ResponseBody String deleteVehicle(int id) {
		System.out.println("进入删除车辆的方法");

		JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();
		int num = jsdVehicleImpl.deleteAllByVehicleId(id);
		System.out.println("删除操作完成");
		return num + "";

	}

	@RequestMapping("stopVehicle")
	public @ResponseBody String stopVehicle(int id) {
		System.out.println("进入停用车辆的方法");

		JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();
		int num = jsdVehicleImpl.stopVehicle(id);
		System.out.println("停用操作完成");
		return num + "";

	}

	@RequestMapping("restartVehicle")
	public @ResponseBody String restartVehicle(int id) {
		System.out.println("进入重启车辆的方法");

		JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();
		int num = jsdVehicleImpl.startVehicle(id);
		System.out.println("重启操作完成");
		return num + "";

	}

	@RequestMapping("deleteVehicles")
	public @ResponseBody String deleteVehicles(String selectId) {
		System.out.println("进入批量删除车辆的方法");

		JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();
		int num = jsdVehicleImpl.deletePartByVehicleIds(selectId);
		System.out.println("批量删除操作完成");
		return num + "";

	}

	@RequestMapping("toChangeVehicle")
	public String toChangeVehicle(Model model, String license_plate) {
		try {
			System.out.println("车牌号为"+license_plate);
			String string = new String(license_plate.getBytes("iso8859-1"),
					"utf-8");
			System.out.println(string);
			model.addAttribute("license_plate", string);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "changeVehicle";

	}

	// UpdateVehicleDetail

	@RequestMapping("UpdateVehicleDetail")
	public @ResponseBody String UpdateVehicleDetail(Vehicledetail vehicledetail) {
		System.out.println(vehicledetail.getLicensePlate());
		JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();
		int num = jsdVehicleImpl.updateVehicleDetail(vehicledetail);
		System.out.println("修改完成");
		return "" + num;
	}

	@RequestMapping("showGVs")
	public void showGVs(HttpServletResponse response,HttpSession session) {
		System.out.println("假设已经获取到了登录用户的id");
		System.out.println("展示出所有的用户车辆");
		JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();

		List<ShowGV> showGVs = jsdVehicleImpl.showGVs((int) session.getAttribute("userId"));
		/*
		 * for (Tuser tuser : tusers) {
		 * System.out.println(JSON.toJSONString(tuser)); }
		 */
		String jsonString = JSONArray.fromObject(showGVs).toString();
		System.out.println(jsonString);
		response.setContentType("application/json; charset=UTF-8");
		try {
			response.getWriter().print(jsonString);
			response.getWriter().flush();// 刷新流.
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping("selectCGVByCreaterUserId")
	public void selectCGVByCreaterUserId(HttpServletResponse response,HttpSession session) {
		System.out.println("假设已经获取到了登录用户的id");
		System.out.println("展示出所有的客户用户车辆");
		JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();

		List<ShowCGV> selectCGV = jsdVehicleImpl.selectCGVByCreaterUserId((int) session.getAttribute("userId"));
		String jsonString = JSONArray.fromObject(selectCGV).toString();
		System.out.println(jsonString);
		response.setContentType("application/json; charset=UTF-8");
		try {
			response.getWriter().print(jsonString);
			response.getWriter().flush();// 刷新流.
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/*@RequestMapping("moveLeft")
	public @ResponseBody String move(String seleceedType, String selectId,
			String targetType, String targetId, String pId) {
		// 进入移动车辆的
		System.out.println("用户类型" + seleceedType + "旧id" + selectId + "墓地类型"
				+ targetType + "新id" + targetId + "父id" + pId);
		// 根据创建者用户查询出所属客户id
		JsdCustomer jsdCustomerImpl = new JsdCustomerImpl();
		int oldCustomerId = jsdCustomerImpl.selectCustomerIdByAdminId(1);
		JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();
		if (seleceedType == "group") {
			List<Integer> ids = StringUtils.ids(selectId);
			for (Integer groupId : ids) {
				jsdVehicleImpl.updateGroupOfCustomer(Integer.parseInt(pId),
						groupId, Integer.parseInt(targetId));
			}
		}
		// 查询出车辆所属分组.pid.
		if (seleceedType == "vehicle") {
			List<Integer> ids = StringUtils.ids(selectId);
			for (Integer vehicleId : ids) {
				jsdVehicleImpl.updateVehicleOfGroup(Integer.parseInt(pId),
						vehicleId, Integer.parseInt(targetId));
			}
		}
		return "success";
	}*/

	/*@RequestMapping("moveRight")
	public @ResponseBody String moveTree2(String seleceedType, String selectId,
			String targetType, String targetId, String pId) {
		// 进入移动车辆的
		System.out.println("用户类型" + seleceedType + "旧id" + selectId + "墓地类型"
				+ targetType + "新id" + targetId + "父id" + pId);
		// 根据创建者用户查询出所属客户id
		JsdCustomer jsdCustomerImpl = new JsdCustomerImpl();
		int oldCustomerId = jsdCustomerImpl.selectCustomerIdByAdminId(1);
		JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();
		if (seleceedType == "group") {
			if (null == targetId) {
				List<Integer> ids = StringUtils.ids(selectId);
				for (Integer groupId : ids) {
					jsdVehicleImpl.updateGroupOfCustomer(Integer.parseInt(pId),
							groupId, oldCustomerId);
				}
			}

			List<Integer> ids = StringUtils.ids(selectId);
			for (Integer groupId : ids) {
				jsdVehicleImpl.updateGroupOfCustomer(Integer.parseInt(pId),
						groupId, Integer.parseInt(targetId));
			}
		}
		
		
		// 查询出车辆所属分组.pid.
		if (seleceedType == "vehicle") {
			// 车辆之间的相互移动
			List<Integer> ids = StringUtils.ids(selectId);
			for (Integer vehicleId : ids) {
				jsdVehicleImpl.updateVehicleOfGroup(Integer.parseInt(pId),
						vehicleId, Integer.parseInt(targetId));
			}
		}
		if (seleceedType == "customer") {
			// 客户和客户之间的相互移动.
			List<Integer> ids = StringUtils.ids(selectId);
			for (Integer groupId : ids) {
				jsdVehicleImpl.updateGroupOfCustomer(Integer.parseInt(pId),
						groupId, Integer.parseInt(targetId));
			}

		}
		return "success";
	}*/
	
	@RequestMapping("move")
	public @ResponseBody String move(String type, String oPIds, String targetIds, Integer nPId) {
		// 进入移动车辆的
		System.out.println("移动类型" + type + "旧父id" + oPIds + "新id" + targetIds + "父id" + nPId);
		
		JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();
		if (type.equals("group")) {
			System.out.println("进行分组移动");
		 jsdVehicleImpl.updateGroupsOfCustomer(Integer.parseInt(oPIds), targetIds, nPId);
		 System.out.println("分组移动完成");
		}
		// 查询出车辆所属分组.
		else {
		  System.out.println("进行车辆移动");
			jsdVehicleImpl.updateVehiclesOfGroups(oPIds, targetIds, nPId);	
			System.out.println("分组移动完成");
		}
		return "success";
	}

	
	// //查询出所有的客户来.可能出错因为去掉了;
	@RequestMapping(value = "/getCustomers", produces = { "text/html;charset=UTF-8" })
	public void getCustomers(HttpServletResponse response,HttpSession session) {
		System.out.println("展示出当前用户的所有客户以及他的父客户来.");

		JsdCustomer jsdCustomerImpl = new JsdCustomerImpl();
		// 假如已经知道了创建者用户id.
		List<Tcustomer> customers = jsdCustomerImpl.selecTcustomersByCAId((int) session.getAttribute("userId"));
         System.out.println(customers.size());
		String jsonString = JSONArray.fromObject(customers).toString();
		System.out.println(jsonString);
		response.setContentType("application/json; charset=UTF-8");
		try {
			response.getWriter().print(jsonString);
			response.getWriter().flush();// 刷新流.
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 根据客户id查询出所有的分组来.

	@RequestMapping(value = "/getGroups", produces = { "text/html;charset=UTF-8" })
	public void getGroups(HttpServletResponse response, Integer customerId) {
		System.out.println("展示出某个客户的所有分组来");
		System.out.println("客户id为"+customerId);
		JsdGroup jsdGroupImpl = new JsdGroupImpl();
		List<Group> groups = jsdGroupImpl.selectGroupsByCustomerId(customerId);

		String jsonString = JSONArray.fromObject(groups).toString();
		System.out.println(jsonString);
		response.setContentType("application/json; charset=UTF-8");
		try {
			response.getWriter().print(jsonString);
			response.getWriter().flush();// 刷新流.
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 根据分组id查询所属车辆.
	@RequestMapping(value = "/getVehiclesByGroupId", produces = { "text/html;charset=UTF-8" })
	public void getVehiclesByGroupId(HttpServletResponse response, Integer groupId) {
		System.out.println("展示出某个分组的车辆来");
		System.out.println("分组id为"+groupId);
		JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();
		List<Vehicle> vehicles = jsdVehicleImpl
				.selectVehiclesByGroupId(groupId);
		String jsonString = JSONArray.fromObject(vehicles).toString();
		System.out.println(jsonString);
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
