/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.service.operationLog;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.loan.common.TSettingParem;
import com.deelon.loan.dao.operationLog.TuserLogDao;
import com.deelon.loan.model.TuserLog;

@ Service
public class TuserLogService extends BaseService<TuserLog>{
	
	@ Resource
	private TuserLogDao tuserLogDao;
	
	protected IEntityDao<TuserLog, Long> getEntityDao()
	{
		return this.tuserLogDao;
	}
	
	/**
	 * 日志添加方法
	 * @param userId_当前操作的用户id
	 * @param modelId_用户操作的模块名称id ,如我要理财
	 * @param actionName 操作的功能名称,如果充值
	 * @param platformId,操作的平台,1 pc,或 2 微信
	 * @param result,操作结果,成功失败,1 成功,2.失败.
	 * @param remark, 如果是充值 就填写充值金额,投标就填写投标金额
	 */
	public void recordUserOperation(long userId,int modelId,int actionName,int platformId,int result,String remark,HttpServletRequest request){
		try {
			TuserLog log=new TuserLog();
			log.setLoginLogId(UniqueIdUtil.genId());
			log.setUserId(userId);
			log.setTypeId(3);//操作
			log.setModelId(modelId+"");
			switch (modelId) {
			case 1 :log.setModelName(TSettingParem.ModelName.MONEY_MANAGE);break;
			case 2 :log.setModelName(TSettingParem.ModelName.FIANACIL_MANAGEMENT);break;
			case 3 :log.setModelName(TSettingParem.ModelName.HOUSEHOlDE_FINANCE);break;
			case 4 :log.setModelName(TSettingParem.ModelName.ASSIGNMENT_OF_DEBT);break;
			
			}
			switch (actionName) {
			case 1 :log.setActionName(TSettingParem.ActionName.RECHARGE_MONEY);break;
			case 2 :log.setActionName(TSettingParem.ActionName.DRAW_MONEY);break;
			case 3 :log.setActionName(TSettingParem.ActionName.HANDlE_BID);break;
			case 4 :log.setActionName(TSettingParem.ActionName.AUTO_BID);break;
			case 5 :log.setActionName(TSettingParem.ActionName.ASSIGNMENT_OF_DEBT);break;
			
			}
			log.setPlatformId(platformId+"");
			log.setClientIpdeviceId(getIpAddr(request));
			log.setActionTime(new Date());
			log.setResultId(result+"");
			log.setRemarks(remark);
			tuserLogDao.add(log);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
	}
	
	public static String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getRemoteAddr();
		}
		return ip;
		}

}