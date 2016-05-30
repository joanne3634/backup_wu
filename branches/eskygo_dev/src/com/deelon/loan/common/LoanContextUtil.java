/*
 * Copyright (c) 2008 Asiainfo Technologies(China),Inc.
 *
 * FileName: LoanContextUtil.java
 *
 * Description:
 *
 * Created: Allen 2014-9-15
 * 
 * |--------------------------------------------------History---------------------------------------------------|
 * |                                                                                                            |
 * |-----Author-----|-----Date-----|----Version----|----------------------------Desc----------------------------| 
 * || 
 * |------------------------------------------------------------------------------------------------------------|
 */
package com.deelon.loan.common;

import javax.servlet.http.HttpServletRequest;

import com.deelon.loan.model.front.TUser;

/**
 * LoanContextUtil
 *
 * <P></P>
 * 
 * @author Administrator 2014-9-15
 * @version 0.0.1
 */
public class LoanContextUtil {
	  /**
	   * 网贷前端 登录用户
	   * @return
	   */
	  public static TUser getCurrentTUser(HttpServletRequest request,String key){
		  TUser u=(TUser)request.getSession().getAttribute(key);
		  return u;
	  }
	  
}
