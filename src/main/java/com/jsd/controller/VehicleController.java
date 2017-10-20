package com.jsd.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.jsd.db.pojo.Driver;
import com.jsd.db.pojo.Group;
import com.jsd.db.pojo.Vehicle;
import com.jsd.db.pojo.Vehicledetail;
import com.jsd.domain.factory.BeanFactory;
import com.jsd.service.JsdGroup;
import com.jsd.service.JsdVehicle;
import com.jsd.service.impl.JsdGroupImpl;
import com.jsd.service.impl.JsdVehicleImpl;

@Controller
@RequestMapping("Vehicle")

public class VehicleController {
	
	@RequestMapping("toAddVehicle")
	public String toAddVehicle(){
		System.out.println("进入toAddVehicle页面");
		return "addVehicle";
	}
	@RequestMapping("toImportVehicles")
	public String toImportVehicles(){
		System.out.println("进入批量导入车辆的页面");
		return "importVehicles";
	}
	@RequestMapping("checkLicesenPlate")
	public @ResponseBody String selectVehicleBylicensePlate(String licensePlate){
		System.out.println("进入检查车牌号页面页面车牌号为"+licensePlate);
		JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();
		Vehicle vehicle = jsdVehicleImpl.selectVehicleBylicensePlate(licensePlate);
		if (null==vehicle) {
			return "true";
		}
		return "false";
	}
	@RequestMapping("addVehicle")
	public  @ResponseBody String  addVehicle(Vehicle vehicle,String selectedGroup){
		System.out.println("进入添加车辆方法");
		System.out.println(vehicle.getLicensePlate());
		System.out.println("为车辆添加分组字符串的列表为: "+selectedGroup);
		JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();
		 int addVehicle = jsdVehicleImpl.addVehicle(1, vehicle);
		
		if (addVehicle!=1) {
			//添加失败
			return "0";
		}
	    
	Vehicle vehicle2 = jsdVehicleImpl.selectVehicleBylicensePlate(vehicle.getLicensePlate());
		if (null==vehicle2) {
	  System.out.println("您可能添加未成功");
		return "0";
		}
	  jsdVehicleImpl.addvehicleGroups(vehicle2.getId(), selectedGroup);
	 //查询出车主的id
	 Vehicle vehicle3 = jsdVehicleImpl.selectVehicleBylicensePlate(vehicle.getLicensePlate());
	 if (null==vehicle3) {
		return "0";
	}
	 System.out.println("添加车辆的id为"+vehicle3.getId());
	 return ""+vehicle3.getId();
	}
	@RequestMapping("addVehicleDetail")
	public  @ResponseBody String  addVehicleDetail(Vehicledetail vehicledetail  ){
		System.out.println("进入添加车辆详情方法");
		System.out.println(vehicledetail.getLicensePlate());
		System.out.println(vehicledetail.getColor());
		System.out.println(vehicledetail.getEnginecode());
		System.out.println(vehicledetail.getImage());
		System.out.println(vehicledetail.getName());
		System.out.println(vehicledetail.getProducter());
		System.out.println(vehicledetail.getVehbrand());
	
		JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();
		int num = jsdVehicleImpl.addvehicleDetail(vehicledetail.getLicensePlate(), vehicledetail);
		if (num!=1) {
			//添加失败
			return "0";
		}
		return num+"";
	}
	
	@RequestMapping("addDriver")
	public  @ResponseBody String  addDriver(Driver driver,String vid  ){
		System.out.println("进入添加车主方法");
		System.out.println(driver.getIdcard());
		System.out.println(driver.getName());
		System.out.println(driver.getPhone());
		System.out.println(driver.getTel());
		System.out.println(driver.getyDriveNum());
		System.out.println(driver.getyDriveType());
		System.out.println(driver.getCertifdate());
		System.out.println(vid+"@@@");
		JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();	
		//假设addDriver已经存在,验证身份证号
		int num = jsdVehicleImpl.addDriver(driver);
		if (num!=1) {
			//添加失败
			return "0";
		}
		List<Driver> checkDrivers = jsdVehicleImpl.checkDrivers(driver.getIdcard());
		if (checkDrivers.size()==1) {
			Integer driverId = checkDrivers.get(0).getId();
		  System.out.println("打印车主id为"+driverId);
		  //在通过传递过来的id来更新数据库.跟新车辆表,检验成功
		  int num1 = jsdVehicleImpl.updateVehicle(BeanFactory.createVehicle(Integer.parseInt(vid), driverId));
		  return num1+"";
		}
		  return "0";
	}
	@RequestMapping("/uploadExcelFile")
	public String uploadExcelFile( MultipartFile fileName ,HttpServletRequest request){
		//原始文件名称
		System.out.println("%%%%%");
		System.out.println("##"+fileName);
		System.out.println(fileName.getOriginalFilename());
		System.out.println(fileName.getName());
		String pictureFile_name =  fileName.getOriginalFilename();
		System.out.println(pictureFile_name);
		
		  // 判断文件是否为空  
        if (!fileName.isEmpty()) {  
        	//将上传内容备份服务器上
    		File destFile = new File("F:/upload", System.currentTimeMillis() + ".xls");
    		try {
				fileName.transferTo(destFile);
				JsdVehicle jsdVehicleImpl = new JsdVehicleImpl();
				
	    		String successMessage = jsdVehicleImpl.importVehiicle2007(1, 1, destFile.getAbsolutePath());
	    		return "success";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
    		
        }  	
	//	String importVehicles = jsdVehicleImpl.importVehiicle2007(1, 1, url)
		System.out.println("批量添加完成");
		return "success";
	}

}
