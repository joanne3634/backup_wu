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
package com.deelon.crowdfunding.common.util;

import javax.servlet.http.HttpServletRequest;

import com.deelon.core.util.AppUtil;
import com.deelon.loan.model.front.TUser;
import com.deelon.platform.model.system.SysFile;
import com.deelon.platform.service.system.SysFileService;

/**
 * TUserUtil
 *
 * <P></P>s
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
		//if(u==null)u=new TUser();
		return u;
	}
	
	
	/**
	 * 获取sys_file
	 *
	 *
	 * @param request
	 * @return
	 */
	public static SysFile getSysFile(String fileId){
		SysFileService sysFileService = (SysFileService)AppUtil.getBean(SysFileService.class);
		SysFile sysFile = sysFileService.getById(Long.valueOf(fileId));    
		return sysFile;
	}
	
	
	/**
	 * 保存sys_file
	 *
	 *
	 * @param request
	 * @return
	 */
	public static void saveSysFile(SysFile sysFile){
		SysFileService sysFileService = (SysFileService)AppUtil.getBean(SysFileService.class);
		sysFileService.add(sysFile);
	}
}
