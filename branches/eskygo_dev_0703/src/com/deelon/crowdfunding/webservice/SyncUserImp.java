package com.deelon.crowdfunding.webservice;

import org.springframework.beans.factory.annotation.Autowired;

import com.deelon.core.util.StringUtil;
import com.deelon.loan.service.front.TUserService;

public class SyncUserImp implements SyncUserInterface{
	
	@Autowired
	private TUserService tUserService;

	/*public String insertUserInfo(String loginName, String loginPwd,String realName, String email, String mobile, 
			String idNumber,String groupId, String registerTime) {
		String result="";
		try {
			result = tUserService.syncInsertUser(loginName,loginPwd,realName,email,mobile,idNumber,groupId,registerTime);
		} catch (Exception e) {
			result = "同步用户异常";
			e.printStackTrace();
		};
		return result;
	}*/
	
	public String insertUserInfo(String xmluserDatas) {
		String result = "";
		try {
			if(StringUtil.isEmpty(xmluserDatas)){
				result = "参数不能为空";
			}else{
				result = tUserService.syncInsertUser(xmluserDatas);	
			}
	} catch (Exception e) {
		//e.printStackTrace();
		result = e.getMessage();
	};
		return result;
	}

}
