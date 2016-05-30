package com.deelon.weixinform.controller.aboutus;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.aboutus.TUserMessage;
import com.deelon.loan.model.aboutus.TUserMsgRemind;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.model.sysManager.Temailinformation;
import com.deelon.loan.model.sysManager.Tsmsinformation;
import com.deelon.loan.service.aboutus.TUserMessageService;
import com.deelon.loan.service.aboutus.TUserMsgRemindService;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TuserSafeService;
import com.deelon.loan.service.sysManager.TemailinformationService;
import com.deelon.loan.service.sysManager.TsmsinformationService;

/**
 * 留言管理
 * @author qin
 * @version
 * 
 */
@Controller
@RequestMapping({ "/weixin/wxaboutus" })
public class WxLeaveMessageController extends BaseController {

	@Resource
	private TUserMessageService tusermessageService;

	@Resource
	private TUserService tuserService;

	@Resource
	private TsmsinformationService tsmsinformationService;
	
	@Resource
	private TuserSafeService tuserSafeService;
	
	@Resource
	private TUserMsgRemindService tuserMsgRemindService;
	
	@Resource
	private TemailinformationService temailinformationService;

	@RequestMapping({ "list" })
	// 处理方法url 与控制器url对应 等于/cmsform/site/TUserMessage/list url
	@Action(description = "查看TUserMessage分页列表")
	public ModelAndView list(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List list = this.tusermessageService.getAll(new QueryFilter(request,
				"TUserMessageItempage")); 
		return new ModelAndView("/weixinform/aboutus/TUserMessageList.jsp")
				.addObject("TUserMessageItem", list);// 返回的逻辑视图名
	}

	@RequestMapping({ "del" })
	@Action(description = "删除TUserMessage数据")
	public void del(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage(request);
		String messageIds = request.getParameter("messageId");
		for (int i = 0; i < messageIds.length(); i++) {
			int a = messageIds.indexOf(",");
			if (a < 0) {
				long messageId = Long.parseLong(messageIds);
				this.tusermessageService.del(messageId);
			} else {
				long messageId = Long.parseLong(messageIds.substring(0, a));
				this.tusermessageService.del(messageId);
				messageIds = messageIds.substring(a + 1);
			}
		}
		message = new ResultMessage(1, "删除数据成功");
		addMessage(message, request);
		response.sendRedirect(preUrl);
	}

	@RequestMapping({ "myleave" })
	@Action(description = "编辑TUserMessage数据")
	public ModelAndView LeaveMessage(HttpServletRequest request)
			throws Exception {
		return new ModelAndView("/weixinform/aboutus/myleave.jsp");
	}

	@RequestMapping({ "get" })
	@Action(description = "查看TUserMessage数据")
	public ModelAndView get(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		long pkId = RequestUtil.getLong(request, "messageId");
		TUserMessage tuserMessage = (TUserMessage) this.tusermessageService
				.getById(Long.valueOf(pkId));
		this.Update(tuserMessage);
		TUser user = this.getUserAll(tuserMessage.getUserId());
		return new ModelAndView("weixinform/aboutus/TUserMessageGet.jsp").addObject(
				"TUserMessage", tuserMessage).addObject("user", user);
	}

	@RequestMapping({ "edit" })
	@Action(description = "回复留言")
	public ModelAndView edit(HttpServletRequest request) throws Exception {
		long pkId = RequestUtil.getLong(request, "messageId");
		TUserMessage tuserMessage = (TUserMessage) this.tusermessageService
				.getById(Long.valueOf(pkId));
		TUser user = this.getUserAll(tuserMessage.getUserId());
		this.Update(tuserMessage);
		return new ModelAndView("weixinform/aboutus/TUserMessageReply.jsp")
				.addObject("TUserMessage", tuserMessage)
				.addObject("user", user);
	}

	@RequestMapping({ "Messagesave" })
	@Action(description = "添加或更新TUserMessage")
	@ResponseBody
	public String save(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		TUser u=(TUser)request.getSession().getAttribute("user");
		if(null == u){
			response.sendRedirect(request.getContextPath() + "/loginWeixin.jsp");
			return null;
		}
		
		TUserMessage tuserMessage = new TUserMessage();
		String messageTitle = request.getParameter("messageTitle");
		int uid = Integer.parseInt(request.getParameter("userId"));
		String messageId = request.getParameter("messageId");
		if (messageId == null || "".equals(messageId)) {
			tuserMessage.setMessageIsReply(1);
		} else {
			int messageIsReply = Integer.parseInt(request
					.getParameter("messageIsReply"));
			int messageReplyWay = Integer.parseInt(request
					.getParameter("messageReplyWay"));
			String messageReplyAbout = request
					.getParameter("messageReplyAbout");
			String messageEmail = request.getParameter("messageEmail");
			String messageMobile = request.getParameter("messageMobile");
			tuserMessage.setMessageIsReply(messageIsReply);
			tuserMessage.setMessageReplyWay(messageReplyWay);
			tuserMessage.setMessageReplyAbout(messageReplyAbout);
			tuserMessage.setMessageMobile(messageMobile);
			tuserMessage.setMessageEmail(messageEmail);
		}
		String messageType = request.getParameter("messageType");
		if(messageType==null||"".equals(messageType)){
			messageType="0";
		}
		String messageContent = request.getParameter("messageContent");
		tuserMessage.setMessageContent(messageContent);
		tuserMessage.setMessageType(Integer.parseInt(messageType));
		tuserMessage.setUserId(uid);
		tuserMessage.setMessageTitle(messageTitle);
		tusermessageService.add(tuserMessage);
		return "留言成功!";
	}

	@RequestMapping({ "Replysave" })
	@Action(description = "添加或更新TUserMessage")
	public void Replysave(HttpServletRequest request,
			HttpServletResponse response, TUserMessage tuserMessage,
			BindingResult bindResult) throws Exception { 
		long creator=Long.parseLong(request.getParameter("creator"));
    	tuserMessage.setMessageIsReply(2); 
    	this.Update(tuserMessage);
    	TUserSafe tuserSafe=tuserSafeService.getUserSafeByUserId(tuserMessage.getUserId());   
    	//MessageReplyWay=1 说明是短信回复存入短信表
    	if(tuserMessage.getMessageReplyWay()==1){ 
    		Tsmsinformation tsmsinformation = new Tsmsinformation();  
    		tsmsinformation.setServiceType(1);
    		tsmsinformation.setMobileNum(tuserSafe.getMobile());
    		tsmsinformation.setMessasge(tuserMessage.getMessageReplyAbout());
    		tsmsinformation.setCreator(creator);
    		tsmsinformation.setStatus(0);
    		this.tsmsinformationService.add(tsmsinformation); 
    		this.Update(tuserMessage); 
    	} 
    	else{
    		//MessageReplyWay=2 说明是邮件回复存入邮件表，邮件接口待提供
    		Temailinformation temailinformation=new Temailinformation(); 
			temailinformation.setServiceType(1);
			temailinformation.setEmailAddr(tuserSafe.getEmail());
			String header=tuserMessage.getMessageReplyAbout();
			if(header.length()<10){
				temailinformation.setHeader(header);
			}else{
				temailinformation.setHeader(header.substring(0, 9));
			}
			temailinformation.setMessasge(tuserMessage.getMessageReplyAbout());
			temailinformation.setStatus(0);
			temailinformation.setCreator(creator); 
			temailinformation.setCreateTime(new Date());
			temailinformationService.add(temailinformation);
    	}
    	TUserMsgRemind tuserMsgremind=new TUserMsgRemind();
    	tuserMsgremind.setSenderId(creator);
    	tuserMsgremind.setContent(tuserMessage.getMessageReplyAbout());
    	tuserMsgremind.setStateId(0);
    	tuserMsgRemindService.add(tuserMsgremind); 
	}
	
	@RequestMapping({ "CheckTheRecords" })
	@Action(description = "我的留言列表") 
	public ModelAndView CheckTheRecords(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		int userid=Integer.parseInt(request.getParameter("userid"));
		List<TUserMessage> list=tusermessageService.getMessageUserId(userid);
		return new ModelAndView("/weixinform/aboutus/CheckTheRecords.jsp").addObject("list",list);
	}
	
	@RequestMapping({ "CheckTheRecordsDetails" })
	@Action(description = "我的留言详情") 
	public ModelAndView CheckTheRecordsDetails(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		long messageid=Long.parseLong(request.getParameter("messageid"));
		 TUserMessage  list=tusermessageService.getById(messageid);
		return new ModelAndView("/weixinform/aboutus/CheckTheRecordsDetails.jsp").addObject("tuserMessage",list);
	}
	
	/*
	 * 更新留言
	 */
	public void Update(TUserMessage tuserMessage) {
		if (tuserMessage.getMessageState() == 0) {
			tuserMessage.setMessageState(1);
		}
		tusermessageService.update(tuserMessage);
	}

	/*
	 * 更具前台用户ID取出前台用户
	 */
	public TUser getUserAll(int userid) {
		TUser user = tuserService.getuserInfoByUserId(Long.parseLong(String
				.valueOf(userid)));
		return user;
	}

}
