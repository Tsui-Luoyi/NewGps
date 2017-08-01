package com.newrmgps.mybatis.dao;

import java.util.List;

import com.newrmgps.mybatis.pojo.Tuser;

public interface TuserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Tuser record);

    int insertSelective(Tuser record);

    Tuser selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Tuser record);
    int updateByPrimaryKey(Tuser record);
    List<Tuser> selectByclientId (Integer id);
    
    List<Tuser> selectBycreateUserId (Integer id);
}