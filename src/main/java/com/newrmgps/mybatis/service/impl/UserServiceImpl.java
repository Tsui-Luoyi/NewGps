package com.newrmgps.mybatis.service.impl;



import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.newrmgps.mybatis.dao.usertMapper;
import com.newrmgps.mybatis.pojo.usert;
import com.newrmgps.mybatis.service.IUserService;

@Service("userService")

public class UserServiceImpl implements IUserService {
	@Resource
	private usertMapper userDao;

	public usert getUserById(int userId) {
		// TODO Auto-generated method stub
		return userDao.selectByPrimaryKey(userId);
	}

}
