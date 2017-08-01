package com.newrmgps.mybatis.service;


import java.util.List;

import com.newrmgps.mybatis.pojo.Tuser;

public interface TuserService {
/**
 *  return type : void
 * @param tuser
 */
   public void  saveTuser(Tuser tuser);
   /** 根据 所属客户id 查询出所有的 Tuser
 * @param id
 * @return list
 */
public List<Tuser>  queryByclientId(Integer id);

/** 根据id作为父用户的id查询所有的子用户
 * @param id
 * @return List
 */
List<Tuser> queryBycreateUserId (Integer id);


/** 根据用户id删除用户
 * @return void 
 * @param id
 * 
 */
public   void   deleteById (Integer id);


}
