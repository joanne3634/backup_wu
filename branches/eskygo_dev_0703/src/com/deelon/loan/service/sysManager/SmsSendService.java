package com.deelon.loan.service.sysManager;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.dao.sysManager.TsettingsSmsDao;
import com.deelon.loan.model.sysManager.TsettingsSms;

/**
 * @author MyLiao
 * @category 短信发送服务
 */
@ Service
public class SmsSendService extends BaseService<TsettingsSms>{
	@ Resource
	private TsettingsSmsDao smsSetInfoDao;

	protected IEntityDao<TsettingsSms, Long> getEntityDao() {
		return this.smsSetInfoDao;
	}
	
	/**
	 * 1获得用户所发短信的统计
	 */
	public String[] getCusStat(){
		String[] arrRet = null;
		String sTmp="";
		//从短信设置表中找到已经开启的短信账号(只能有一条)
		TsettingsSms smsSetInfo=null;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("isOpen", "1");
		QueryFilter queryFilter = new QueryFilter();
		queryFilter.setFilters(map);
		List<TsettingsSms> smsSetInfoList = smsSetInfoDao.getAll(queryFilter);
		if(smsSetInfoList.size()>0){//
			smsSetInfo=(TsettingsSms)smsSetInfoList.get(0);
			String sUserID=smsSetInfo.getAccount();//用户名
			String sPwd=smsSetInfo.getPwd();//密码
			String sURL=smsSetInfo.getInterfaceUrl()+"?userid="+sUserID+"&password="+sPwd;
			HttpClient client = new HttpClient(); 
			HttpMethod method = new PostMethod(sURL);;
			try {
				client.executeMethod(method);//执行请求
				if(method.getStatusCode() == HttpStatus.SC_OK) { 
					sTmp = method.getResponseBodyAsString(); //返回请求结果
				}
			} catch (HttpException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} finally { 
	            method.releaseConnection(); 
	        } 
			if(!"".equals(sTmp)){
				Document doc = null;
				try {
					doc = DocumentHelper.parseText(sTmp);
					Element root = doc.getRootElement();
					String sRet=root.attributeValue("return")+"@"+root.attributeValue("info");//返回的标志与结果
					arrRet=sRet.split("@");
				} catch (DocumentException e) {
					e.printStackTrace();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return arrRet;
	}
	/**
	 * 2用户修改密码
	 */
	public String[] getCusModPwd(String sNewPwd){
		String[] arrRet = null;
		return arrRet;
	}
	/**
	 * 3用户发送短信服务
	 * @param sNumbers 发送号码，多个以逗号隔开，比如： 13911223344,13800998877
	 * @param sContent 发送内容，最大250个字符,不分区中英文
	 * @param sSendTime 发送时间
	 * @param sReqSty 请求方式：G为get；P为post
	 * @return 字符串数组：String[0]为返回值；String[1]为返回提示；String[2]短信批号；String[3]总计号码个数；String[4]总计短信条数；
	 */
	public String[] getSendSmsInfoResult(String sNumbers,String sContent,String sSendTime,String sReqSty){
		String[] arrRet = null;
		String sTmp="";
		//从短信设置表中找到已经开启的短信账号(只能有一条)
		TsettingsSms smsSetInfo=null;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("isOpen", "1");
		QueryFilter queryFilter = new QueryFilter();
		queryFilter.setFilters(map);
		List<TsettingsSms> smsSetInfoList = smsSetInfoDao.getAll(queryFilter);
		if(smsSetInfoList.size()>0){//只有存在开启的账号，才可以发短信
			smsSetInfo=(TsettingsSms)smsSetInfoList.get(0);
			String sUserID=smsSetInfo.getAccount();//用户名
			String sPwd=smsSetInfo.getPwd();//密码
			String sMsg="";
			try {
				sMsg = java.net.URLEncoder.encode(sContent,"UTF-8");
			} catch (UnsupportedEncodingException e1) {
				logger.error("", e1);
			}
			//旧版本的短息接口拼装
//			String sURL=smsSetInfo.getInterfaceUrl()+"?userid="+sUserID+"&password="+sPwd+"&destnumbers="+sNumbers+"&msg="+sMsg+"&sendtime=";
			//新版本的短息接口拼装
			String sURL=smsSetInfo.getInterfaceUrl()+"&account="+sUserID+"&password="+sPwd+"&mobile="+sNumbers+"&content="+sMsg+"&sendtime=&extno=";
			HttpClient client = new HttpClient(); 
			HttpMethod method=null;
			if(sReqSty.equals("G")){
				method = new GetMethod(sURL); 
			}else if(sReqSty.equals("P")){
				method = new PostMethod(sURL); 
			}else{
				method = new PostMethod(sURL); //默认post
			}
			try {
				client.executeMethod(method);
				if(method.getStatusCode() == HttpStatus.SC_OK) { 
					sTmp = method.getResponseBodyAsString(); 
				}
			} catch (HttpException e) {
				logger.error("httpException",e);
			} catch (IOException e) {
				logger.error("IOException",e);
			} finally { 
	            method.releaseConnection(); 
	        } 
			if(!"".equals(sTmp)){
				try {
					  String[] i=sTmp.split("<message>");  
					  sTmp=i[1];
					  arrRet=sTmp.split("</message>");
					  if(arrRet[0].equals("ok")){
						  arrRet[0]="0";
						  arrRet[1]="短信发送成功";
					  }else{
						  arrRet[0]="1";
						  arrRet[1]="短信发送失败";
					  }
					} catch (Exception e) {
						logger.error("汇禾新接口处理接口返回参数异常,短信内容为："+sContent);
					}
			}
		}
		return arrRet;
	}
	/**
	 * 5获得发送的接收状态
	 */
	public String[] getSendSmsStatus(){
		String[] arrRet = null;
		return arrRet;
	}
	/**
	 * 6获得发送的接收状态
	 */
	public String[] qrySendReport(){
		String[] arrRet = null;
		return arrRet;
	}
}
