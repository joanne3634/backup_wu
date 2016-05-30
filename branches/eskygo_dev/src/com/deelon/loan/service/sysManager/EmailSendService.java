package com.deelon.loan.service.sysManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.quartz.JobExecutionContext;

import com.deelon.core.scheduler.BaseJob;
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.MailCommon;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.dao.sysManager.TemailinformationDao;
import com.deelon.loan.dao.sysManager.TsettingsEmailDao;
import com.deelon.loan.model.sysManager.Temailinformation;
import com.deelon.loan.model.sysManager.TsettingsEmail;
/**
 * @author MyLiao
 * @category 邮件发送服务(Job)
 */
public class EmailSendService extends BaseJob{
	@Resource
	private TemailinformationService temailinfoService;
	/*** 发送来自邮件通知表中待发送的邮件*/
	@Override
	public void executeJob(JobExecutionContext paramJobExecutionContext) throws Exception {
		//获取发送方
		TsettingsEmailDao setEmailDao=(TsettingsEmailDao)AppUtil.getBean(TsettingsEmailDao.class);
		TsettingsEmail setEmail = null;
		List<TsettingsEmail> sendlist = setEmailDao.getAll();
		if(sendlist.size() > 0)
			setEmail = (TsettingsEmail) sendlist.get(0);
		
		//接受方
		TemailinformationDao emailInfoDao=(TemailinformationDao)AppUtil.getBean(TemailinformationDao.class);
		
		//查询邮件通知表中待发的邮件
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("status", "0");
		QueryFilter queryFilter = new QueryFilter();
		queryFilter.setFilters(map);
		List<Temailinformation> getlist = emailInfoDao.getAll(queryFilter);
		for(Temailinformation emailInfo : getlist){
			MailCommon mail=new MailCommon();
			mail.setAddress(emailInfo.getEmailAddr(), MailCommon.getTo());//接受人 
			mail.setFromAddress(setEmail.getEmail());//发送人
			mail.setSMTPHost(setEmail.getSmtpSer(), setEmail.getPortId(), setEmail.getEmail(), setEmail.getPwd());
			mail.setSubject(emailInfo.getHeader());
			mail.setHtmlBody(emailInfo.getMessasge());
			mail.sendBatch();
			emailInfo.setStatus(1);//发送完后要将状态改成已发送
			this.temailinfoService.update(emailInfo);
		}
	}
}
