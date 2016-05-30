package com.deelon.loan.util;

import java.io.IOException;
import java.util.List;

import com.deelon.core.util.AppUtil;
import com.deelon.core.util.MailCommon;
import com.deelon.loan.model.sysManager.TsettingsEmail;
import com.deelon.loan.service.sysManager.TsettingsEmailService;


/**
* Classname    :SendEmailUtil.java
* Description  :发邮件的工具类
* Author       :huangqixiang
* Date         :创建日期： 2014-09-29
* 
* Last Update  : 最后修改日期： 2015-02-27
* Author       : xiaox
*/

public class SendEmailUtil {
	
	/**
	 * 发送邮件
	 * 
	 * @param toEmail 接收邮件的邮箱地址
	 * @param title 邮件的标题
	 * @param htmlBody   邮件的主体内容 
	 * @return boolean
	 * @throws IOException
	 */
	public static boolean sendEmail(String toEmail,String title,String htmlBody){
		TsettingsEmailService tsettingsEmailService = (TsettingsEmailService)
				AppUtil.getBean(TsettingsEmailService.class);//获得邮箱设置的业务逻辑对象
		try {
			TsettingsEmail tsettingsEmail = null;//初始化邮箱设置实体
			List list = tsettingsEmailService.getAll();//获得全部的邮箱实体信息
			if(list.size() > 0){//判断邮箱实体集合是否有数据
				tsettingsEmail = (TsettingsEmail) list.get(0);//有数据，获得第一条邮箱的数据信息
			}else{
				return false;//没有数据，则中断方法的执行
			}
			
			MailCommon mail = new MailCommon();//邮箱执行通用类   
			mail.setAddress(toEmail, MailCommon.getTo());  //设置收件邮箱的邮箱地址和发送人
			mail.setFromAddress(tsettingsEmail.getEmail());//设置发件箱的邮箱地址
			mail.setSMTPHost(tsettingsEmail.getSmtpSer(), tsettingsEmail.getPortId(), 
					tsettingsEmail.getEmail(), tsettingsEmail.getPwd());//设置简单邮件传输的服务器、端口、发件人、密码
			mail.setSubject(title);//设置发送邮件的主题
			mail.setHtmlBody(htmlBody);//设置发送邮件的内容
			mail.sendBatch();//发送邮件的执行方法
		} catch (Exception e) {
			return false;
		}
		return true;
	}
}
