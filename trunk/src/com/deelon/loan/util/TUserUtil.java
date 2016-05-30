/*
 * Copyright (c) 2008 Asiainfo Technologies(China),Inc.
 *
 * FileName: TUserUtil.java
 *
 * Description:
 *
 * Created: Allen 2014-8-8
 * 
 * |--------------------------------------------------History---------------------------------------------------|
 * |                                                                                                            |
 * |-----Author-----|-----Date-----|----Version----|----------------------------Desc----------------------------| 
 * || 
 * |------------------------------------------------------------------------------------------------------------|
 */
package com.deelon.loan.util;

import javax.servlet.http.HttpServletRequest;

import com.deelon.loan.model.front.TUser;

/**
 * TUserUtil
 *
 * <P></P>
 * 
 * @author Administrator 2014-8-8
 * @version 0.0.1
 */
public class TUserUtil {
	// ----------------------------------------------------- Properties

	// ----------------------------------------------------- Constructors

	// ----------------------------------------------------- Methods
	/**
	 * 获取当前登录用户
	 *
	 *
	 * @param request
	 * @return
	 */
	public static TUser getLogUser(HttpServletRequest request){
		TUser u=(TUser)request.getSession().getAttribute("user");
		return u;
	}
}
