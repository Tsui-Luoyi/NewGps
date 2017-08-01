package com.newrmgps.mybatis.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.newrmgps.mybatis.dao.TuserMapper;
import com.newrmgps.mybatis.pojo.Tuser;
import com.newrmgps.mybatis.service.TuserService;
@Service 
public class TuserServiceimpl implements TuserService {
@Resource
 private TuserMapper uDao;
	@Override
	public void saveTuser(Tuser tuser) {
	// TODO Auto-generated method stub
		System.out.println("插入用户");
          uDao.insertSelective( tuser);
          System.out.println("插入用户成功");
	}
	@Override
	public List<Tuser> queryByclientId(Integer id) {
		// TODO Auto-generated method stub
		System.out.println("进行查询");
		List<Tuser> selectByclientId = uDao.selectByclientId(id);
		System.out.println("查询完毕");
		return selectByclientId;
	}
	@Override
	public List<Tuser> queryBycreateUserId(Integer id) {
		// TODO Auto-generated method stub
		System.out.println("根据父用户id查询子用户");
		List<Tuser> list = uDao.selectBycreateUserId(id);
		System.out.println("根据父用户id查询子用户完成");
		
		return list;
	}
	@Override
	public void deleteById(Integer id) {
	// TODO Auto-generated method stub
		  int num = uDao.deleteByPrimaryKey(id);
		   System.out.println(num);
	}

}
