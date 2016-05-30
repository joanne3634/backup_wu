package com.deelon.loan.job;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.quartz.JobExecutionContext;

import com.deelon.core.scheduler.BaseJob;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.dao.sysManager.TsettingsSmsDao;
import com.deelon.loan.dao.sysManager.TsmsinformationDao;
import com.deelon.loan.model.sysManager.TsettingsSms;
import com.deelon.loan.model.sysManager.Tsmsinformation;

/**
 * @author MyLiao
 * @category 短信发送服务JOB
 */
public class SmsSendJob extends BaseJob{
	@ Resource
	private TsettingsSmsDao smsSetInfoDao;
	@ Resource
	private TsmsinformationDao smsInfoDao;
	
	/*** 发送待发送短信*/
	@Override
	public void executeJob(JobExecutionContext jec) throws Exception {
		//从短信设置表中找到已经开启的短信账号(只能有一条)
		TsettingsSms smsSetInfo=null;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("isOpen", "1");
		QueryFilter queryFilter = new QueryFilter();
		queryFilter.setFilters(map);
		List<TsettingsSms> smsSetInfoList = smsSetInfoDao.getAll(queryFilter);
		if(smsSetInfoList.size()>0){//
			smsSetInfo=(TsettingsSms)smsSetInfoList.get(0);
			String sUID=smsSetInfo.getAccount();//用户名
			String sPWD=smsSetInfo.getPwd();//密码
			String sINF=smsSetInfo.getInterfaceUrl();//发送接口
			
			//获得待发送短信：未发送或者发送次数小于2次
			List<Tsmsinformation> smsInfoList = smsInfoDao.getSmsInfo(queryFilter);
			if(smsSetInfoList.size()>0){
				for(Tsmsinformation si: smsInfoList){
					String sNum=si.getMobileNum();
					String sMsg=java.net.URLEncoder.encode(si.getMessasge(),"UTF-8");;
					String sURL=sINF+"?userid="+sUID+"&password="+sPWD+"&destnumbers="+sNum+"&msg="+sMsg+"&sendtime=";
					HttpClient client = new HttpClient(); 
					HttpMethod method=new PostMethod(sURL);
					String sTmp="";
					try {
						client.executeMethod(method);
						//更新发送次数，未实现
						//si.setSendTimes(si.getSendTimes+1);
						//this.smsInfoDao.update(si);
						if(method.getStatusCode() == HttpStatus.SC_OK) { 
							sTmp = method.getResponseBodyAsString(); 
							if(!"".equals(sTmp) && sTmp!=null){
								Document doc = null;
								try {
									doc = DocumentHelper.parseText(sTmp);
									Element root = doc.getRootElement();
									if(root.attributeValue("return").equals("0")){
										//更新短信的发送状态为成功
										si.setStatus(1);
										this.smsInfoDao.update(si);
									}
								} catch (DocumentException e) {
									e.printStackTrace();
								} catch (Exception e) {
									e.printStackTrace();
								}
							}
						}
					} catch (HttpException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					} finally { 
			            method.releaseConnection(); 
			        } 
				}
			}
		}
	}
}
