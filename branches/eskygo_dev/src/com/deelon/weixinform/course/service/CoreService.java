package com.deelon.weixinform.course.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.deelon.weixinform.course.message.resp.Article;
import com.deelon.weixinform.course.message.resp.NewsMessage;
import com.deelon.weixinform.course.message.resp.TextMessage;
import com.deelon.weixinform.course.util.MessageUtil;
import com.deelon.weixinform.weixin.main.MenuManager;

/**
 * 核心服务类
 * 
 */
public class CoreService {
	/**
	 * 处理微信发来的请求
	 * 
	 * @param request
	 * @return
	 */
	public static String processRequest(HttpServletRequest request) {
		String respMessage = null;
		String picurl = MenuManager.rootUrl + "/styles/dlweixin/image/advertisement.png";
		try {
			// 默认返回的文本消息内容
			String respContent = "请求处理异常，请稍候尝试！";

			// xml请求解析
			Map<String, String> requestMap = MessageUtil.parseXml(request);

			// 发送方帐号（open_id）
			String fromUserName = requestMap.get("FromUserName");
			// 公众帐号
			String toUserName = requestMap.get("ToUserName");
			// 消息类型
			String msgType = requestMap.get("MsgType");

			// 回复文本消息
			TextMessage textMessage = new TextMessage();
			textMessage.setToUserName(fromUserName);
			textMessage.setFromUserName(toUserName);
			textMessage.setCreateTime(new Date().getTime());
			textMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
			textMessage.setFuncFlag(0);

			// 创建图文消息  
			NewsMessage newsMessage = new NewsMessage();
			newsMessage.setToUserName(fromUserName);
			newsMessage.setFromUserName(toUserName);
			newsMessage.setCreateTime(new Date().getTime());
			newsMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_NEWS);
			newsMessage.setFuncFlag(0);

			List<Article> articleList = new ArrayList<Article>();

			// 文本消息
			if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_TEXT)) {

				respContent = "灰常欢迎您来到全球最智能的-" + "\n" + "IT解决方案与服务提供" + "\n"
						+ "商帝隆科技的咨询平台！" + "\n" + "-----------------" + "\n"
						+ "点击下方菜单查询您的相" + "\n" + "关业务内容。回复“项目" + "\n"
						+ "合作”进入合作洽谈" + "\n" + "-----------------" + "\n"
						+ "帝隆云移动办公与报报的" + "\n" + "用户可以在解决方案菜单" + "\n"
						+ "中登陆后台管理或下载最" + "\n" + "新版本。" + "\n"
						+ "-----------------" + "\n" + "需要帮助请拨客服电话：" + "\n"
						+ "400--882--3186" + "\n" + "官方网站：" + "\n"
						+ "www.deelon.com" + "\n" + "www.DLyun.com";

				String content = requestMap.get("Content").trim();
				String StrContent = "尊敬的客户您好！" + "\n" + "我是帝隆科技项目管理员" + "\n"
						+ "，非常荣幸能为您服务！" + "\n" + "请您将以下信息以邮件的" + "\n"
						+ "形式发送到我的邮箱：" + "\n" + "survice@deelon.com" + "\n"
						+ "或QQ：" + "\n" + "2489783135" + "\n" + "我们将在2个工作日内联"
						+ "\n" + "系您进行项目的跟进。" + "\n" + "-----------------"
						+ "\n" + "公司名称：" + "\n" + "公司地址：" + "\n" + "联系人："
						+ "\n" + "联系电话：" + "\n" + "邮箱地址：" + "\n" + "项目名称："
						+ "\n" + "项目简述：";
				if (content.startsWith("你好")) {
					respContent = "你好！";
				}
				if (content.startsWith("hello")) {
					respContent = "你好！";
				}
				if (content.startsWith("项目")) {
					respContent = StrContent;
				}
				if (content.startsWith("合作")) {
					respContent = StrContent;
				}
				textMessage.setContent(respContent);
				respMessage = MessageUtil.textMessageToXml(textMessage);
			}
			// 图片消息
			else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_IMAGE)) {
				//				respContent = "您发送的是图片消息！";
			}
			// 地理位置消息
			else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_LOCATION)) {
				//				respContent = "您发送的是地理位置消息！";
			}
			// 链接消息
			else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_LINK)) {
				//				respContent = "您发送的是链接消息！";
			}
			// 音频消息
			else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_VOICE)) {
				//				respContent = "您发送的是音频消息！";
			}
			// 事件推送
			else if (msgType.equals(MessageUtil.REQ_MESSAGE_TYPE_EVENT)) {
				// 事件类型
				String eventType = requestMap.get("Event");
				// 订阅
				if (eventType.equals(MessageUtil.EVENT_TYPE_SUBSCRIBE)) {
					respContent = "灰常欢迎您来到全球最智能的-" + "\n" + "IT解决方案与服务提供" + "\n"
							+ "商帝隆科技的咨询平台！" + "\n" + "-----------------" + "\n"
							+ "点击下方菜单查询您的相" + "\n" + "关业务内容。回复“项目" + "\n"
							+ "合作”进入合作洽谈" + "\n" + "-----------------" + "\n"
							+ "帝隆云移动办公与报报的" + "\n" + "用户可以在解决方案菜单" + "\n"
							+ "中登陆后台管理或下载最" + "\n" + "新版本。" + "\n"
							+ "-----------------" + "\n" + "需要帮助请拨客服电话：" + "\n"
							+ "400--882--3186" + "\n" + "官方网站：" + "\n"
							+ "www.deelon.com" + "\n" + "www.DLyun.com";
					textMessage.setContent(respContent);
					respMessage = MessageUtil.textMessageToXml(textMessage);
				}
				// 取消订阅
				else if (eventType.equals(MessageUtil.EVENT_TYPE_UNSUBSCRIBE)) {
					// TODO 取消订阅后用户再收不到公众号发送的消息，因此不需要回复消息
				}
				// 自定义菜单点击事件
				else if (eventType.equals(MessageUtil.EVENT_TYPE_CLICK)) {

					// 事件KEY值，与创建自定义菜单时指定的KEY值对应  
					String eventKey = requestMap.get("EventKey");
					if (eventKey.equals("35")) {
						Article article = new Article();
						article.setTitle("关于我们");

						article.setDescription("关于我们");
						article.setPicUrl(MenuManager.rootUrl + "/styles/dlweixin/image/about_03.jpg");
						article.setUrl("");
						
						Article article1 = new Article();
						article1.setTitle("公司简介");

						article1.setDescription("公司简介");
						article1.setPicUrl(MenuManager.rootUrl + "/styles/dlweixin/image/about_07.jpg");
						article1.setUrl(MenuManager.rootUrl +"/weixin/wxaboutus/companySynopsis.ht");
						
						Article article2 = new Article();
						article2.setTitle("通知公告");

						article2.setDescription("通知公告");
						article2.setPicUrl(MenuManager.rootUrl + "/styles/dlweixin/image/about_10.jpg");
						article2.setUrl(MenuManager.rootUrl +"/weixin/wxaboutus/noticeList.ht");
						
						Article article3 = new Article();
						article3.setTitle("公司新闻");

						article3.setDescription("公司新闻");
						article3.setPicUrl(MenuManager.rootUrl + "/styles/dlweixin/image/about_12.jpg");
						article3.setUrl(MenuManager.rootUrl +"/weixin/wxaboutus/companyNewsList.ht");
						
						Article article4 = new Article();
						article4.setTitle("行业资讯");

						article4.setDescription("行业资讯");
						article4.setPicUrl(MenuManager.rootUrl + "/styles/dlweixin/image/about_14.jpg");
						article4.setUrl(MenuManager.rootUrl +"/weixin/wxaboutus/industryInformationList.ht");
						
						Article article5 = new Article();
						article5.setTitle("联系我们");

						article5.setDescription("联系我们");
						article5.setPicUrl(MenuManager.rootUrl + "/styles/dlweixin/image/about_16.jpg");
						article5.setUrl(MenuManager.rootUrl +"/weixin/wxaboutus/contactUsList.ht");
						
						Article article6 = new Article();
						article6.setTitle("我的留言");

						article6.setDescription("我的留言");
						article6.setPicUrl(MenuManager.rootUrl + "/styles/dlweixin/image/about_18.jpg");
						article6.setUrl(MenuManager.rootUrl +"/weixin/wxaboutus/myleave.ht");
						
						articleList.add(article);
						articleList.add(article1);
						articleList.add(article2);
						articleList.add(article3);
						articleList.add(article4);
						articleList.add(article5);
						articleList.add(article6);
						// 设置图文消息个数  
						newsMessage.setArticleCount(articleList.size());
						// 设置图文消息包含的图文集合  
						newsMessage.setArticles(articleList);
						// 将图文消息对象转换成xml字符串  
						respMessage = MessageUtil.newsMessageToXml(newsMessage);
					}
				}
			}

			//			textMessage.setContent(respContent);
			//			respMessage = MessageUtil.textMessageToXml(textMessage);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return respMessage;
	}
}
