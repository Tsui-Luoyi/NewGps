package com.newrmgps.mybatis.sdk.factory;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jsd.service.*;
import com.jsd.service.impl.JsdCustomerImpl;

//@Service
public class NewRmgpsFacotry {

	public static JsdCustomer getJsdCustomer() {
		JsdCustomer JsdCustomerimpl=new JsdCustomerImpl();
		return JsdCustomerimpl;
		
	}

}
