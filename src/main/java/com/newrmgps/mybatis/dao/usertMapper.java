package com.newrmgps.mybatis.dao;

import com.newrmgps.mybatis.pojo.usert;

public interface usertMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(usert record);

    int insertSelective(usert record);

    usert selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(usert record);

    int updateByPrimaryKey(usert record);
}