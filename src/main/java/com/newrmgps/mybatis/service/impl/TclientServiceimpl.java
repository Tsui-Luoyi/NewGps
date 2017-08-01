package com.newrmgps.mybatis.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.newrmgps.mybatis.dao.TclientMapper;
import com.newrmgps.mybatis.pojo.Tclient;
import com.newrmgps.mybatis.pojo.TclientList;
import com.newrmgps.mybatis.pojo.Tuser;
import com.newrmgps.mybatis.service.TclientService;
import com.newrmgps.mybatis.service.TuserService;
@Service
public class TclientServiceimpl implements TclientService{
	@Resource
	private  TclientMapper  cDao;
	@Resource
	private  TuserService  tuserService;
	@Override
	public void saveTclient(Tclient tclient) {
		// TODO Auto-generated method stub
		System.out.println("保存");
		  cDao.insertSelective(tclient);
		  System.out.println("保存成功");
	}
	@Override
	public int findByTclientName(String tclientName) {
		// TODO Auto-generated method stub
		  int  num = cDao.selectByTclientName(tclientName);
		return num;
	}
	@Override
	public List<TclientList> queryAll(TclientList tlientList) {
		// 达到条件查询的目的
		System.out.println("到达内部");
		List<TclientList> queryAll = cDao.queryAll(tlientList);
		System.out.println("跳出内部");
		return queryAll;
	}
	@Override
	public void updatTclient(Tclient tclient) {
		// TODO Auto-generated method stub
		    System.out.println("进入修改");
		    cDao.updateByPrimaryKeySelective(tclient);
		    System.out.println("做出修改");
	}
	@Override
	public void deleteTclient(Integer id) {
		// TODO Auto-generated method stub
		System.out.println("删除开始");
		  cDao.deleteByPrimaryKey(id);
		  System.out.println("删除结束");
	}
	@Override
	public void deleteTclientAll(Integer id) {
		// TODO Auto-generated method stub
//通过id 查询出所有的子用户. 遍历将id作为父id查询出所有的子用户判断如果子用户为空,则删除
		List<Tuser> queryByclientId = tuserService.queryByclientId(id); 
		if (queryByclientId.size()==0) {
			System.out.println("客户下不含有用户");
			cDao.deleteByPrimaryKey(id);
		}else {
			  System.out.println("马上进入递归删除");
			  deleteUserAll(queryByclientId);
			  System.out.println("走出递归删除");
			  cDao.deleteByPrimaryKey(id);
		}
	       
	}
	/**
	 * 根据用户的集合删除所有的子用户
	 * @param list
	 */
	public  void deleteUserAll(List<Tuser> list) {
		for (Tuser tuser : list) {
			  System.out.println("进入递归删除");

			  List<Tuser> list2 = tuserService.queryBycreateUserId(tuser.getId());
			  if (list2.size()==0) {
				 tuserService.deleteById(tuser.getId());
			}else {
				 deleteUserAll(list2);
				 tuserService.deleteById(tuser.getId());
			}
			 		}
		
	}
	@Override
	public void deleteBydartId(ArrayList arrayList) {
		// 实现简单的批量删除的功能.
		 System.out.println("进入批量删除");
		  cDao.deleteBydartId(arrayList);
	}

}
