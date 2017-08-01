package com.newrmgps.mybatis.dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder.In;

import com.newrmgps.mybatis.pojo.Tclient;
import com.newrmgps.mybatis.pojo.TclientList;

public interface TclientMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Tclient record);

    int insertSelective(Tclient record);

    Tclient selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Tclient record);

    int updateByPrimaryKey(Tclient record);
    
    int selectByTclientName(String tclientName);
    // 7月27号添加
     List<TclientList> queryAll(TclientList list );
    //7月28号添加批量删除.
     void deleteBydartId(ArrayList arrayList);
    
}