package com.newrmgps.mybatis.service;

import java.util.ArrayList;
import java.util.List;

import com.newrmgps.mybatis.pojo.Tclient;
import com.newrmgps.mybatis.pojo.TclientList;

public interface TclientService {
	/**
	  添加客户
	  参数: 客户
	   返回值: void*/
      public void  saveTclient( Tclient tclient);
      /**
       * 
       * @param 客户姓名
       * @return 客户的数量
       */
    public   int findByTclientName(String tclientName);
    /**
     *  实现根据传递过来的条件查询客户列表的需求
     * @param list
     * @return list
     */
    List<TclientList> queryAll(TclientList tlientList );
     /**
      * 实现客户的修改
     * @param tclient
     * @return void
     */
    public void  updatTclient( Tclient tclient);
    /**
     * @param id
     * @return void
     */
    public void deleteTclient(Integer  id);
    /**
     * 仅仅根据传递过来的客户的id来实现删除所有.
     * @param id
     */
    public void  deleteTclientAll(Integer id);
     /**
      * 实现简单的批量删除的功能.
     * @param arrayList
     */
    public void deleteBydartId(ArrayList arrayList);
}
