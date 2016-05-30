package com.deelon.loan.controller.aboutus;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.page.PageBean;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.servlet.ValidCode;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.common.util.TUserUtil;
import com.deelon.loan.model.aboutus.TUserMsgRemind;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.service.aboutus.TUserMsgRemindService;
import com.deelon.loan.service.front.TUserService;

/**
 * @author Administrator
 * @version我的通知与服务
 * 
 */
@Controller
@RequestMapping({ "/loan/tuserMsgRemind" })
public class TUserMsgRemindController  extends BaseController{
	
	@Resource
	private TUserMsgRemindService tuserMsgRemindService;
	
	@Resource
	private TUserService tUserService;
	
	@RequestMapping({ "list" })
	// 处理方法url 与控制器url对应 等于/cmsform/site/TUserMessage/list url
	@Action(description = "查看TUserMessage分页列表")
	public ModelAndView list(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List list = this.tuserMsgRemindService.getAllMsgRemind(new QueryFilter(request,
				"tuserMsgRemindpage")); 
		return new ModelAndView("/loan/aboutus/TuserMsgRemindList.jsp")
				.addObject("tuserMsgRemindItem", list);// 返回的逻辑视图名
	}
	
	@RequestMapping({ "listToSelect" })
	@Action(description = "系统消息的分页列表")
	public ModelAndView listToSelect(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Integer typeID = RequestUtil.getInt( request, "typeID" );//接受页面返回的Id
		System.out.println("--->"+typeID);
		QueryFilter queryFilter = new QueryFilter(request, "tuserMsgRemindpage");
		queryFilter.addFilter("typeID", typeID);
		List list = this.tuserMsgRemindService.getAll(queryFilter); 
		return new ModelAndView("/loan/aboutus/TuserMsgRemindList.jsp").addObject("tuserMsgRemindItem", list);// 返回的逻辑视图名
	}
	
	@RequestMapping({ "del" })
	@Action(description = "删除TUserMsgRemind数据")
	public void del(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage(request);
		String messageIds = request.getParameter("msgRemindId");
		for (int i = 0; i < messageIds.length(); i++) {
			int a = messageIds.indexOf(",");
			if (a < 0) {
				long messageId = Long.parseLong(messageIds);
				this.tuserMsgRemindService.del(messageId);
			} else {
				long messageId = Long.parseLong(messageIds.substring(0, a));
				this.tuserMsgRemindService.del(messageId);
				messageIds = messageIds.substring(a + 1);
			}
		}
		message = new ResultMessage(1, "删除数据成功");
		addMessage(message, request);
		response.sendRedirect(preUrl);
	}
	
	@RequestMapping({ "delTUserMsgRemind" })
	@Action(description = "删除TUserMsgRemind数据")
	@ResponseBody
	public String delTUserMsgRemind(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String result="1";
		//flag =1表示发送者者删除信息,flag =2表示接收者删除信息
		String flag = request.getParameter("flag")+"";
		String msgRemindId = request.getParameter("msgRemindId");
		if(msgRemindId.contains(",")){
			String messageId = msgRemindId.substring(0,request.getParameter("msgRemindId").length()-1);
			String[] messageIds = messageId.split(",");
			for (int i = 0; i < messageIds.length; i++) {
				
					//this.tuserMsgRemindService.del(Long.parseLong(messageIds[i].trim()));
					TUserMsgRemind tuserMsgRemind=tuserMsgRemindService.getById(Long.parseLong(messageIds[i].trim()));
				   // tuserMsgRemind.setIsDel(Long.valueOf(1));
					if(StringUtils.isNotEmpty(flag)){
						if("1".equals(flag.trim())){//发送者者删除信息
							tuserMsgRemind.setIsDel(Long.valueOf(1));
						}else if("2".equals(flag.trim())){//接收者删除信息
							tuserMsgRemind.setIsDelReceive(1);
						}
					}
					this.tuserMsgRemindService.update(tuserMsgRemind); 
			}
		}else{
			TUserMsgRemind tuserMsgRemind=tuserMsgRemindService.getById(Long.parseLong(msgRemindId.trim()));
			//tuserMsgRemind.setIsDel(Long.valueOf(1));
			if(StringUtils.isNotEmpty(flag)){
				if("1".equals(flag.trim())){//发送者者删除信息
					tuserMsgRemind.setIsDel(Long.valueOf(1));
				}else if("2".equals(flag.trim())){//接收者删除信息
					tuserMsgRemind.setIsDelReceive(1);
				}
			}
			this.tuserMsgRemindService.update(tuserMsgRemind); 
		}
		//message = new ResultMessage(1, "删除数据成功");
		return result;
		//addMessage(message, request);
		//response.sendRedirect(preUrl);
	}
	
	
	
	@RequestMapping({ "MsgReminds" })
	@Action(description = "我的服务与通知")
	public ModelAndView getReceiverId(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
	    int ReceiverId=Integer.parseInt(request.getParameter("ReceiverId")); 
		QueryFilter filter = new QueryFilter();
		filter.addFilter("ReceiverId", ReceiverId); 
		int page = RequestUtil.getInt(request, "current_page", 1);
		int pageSize = RequestUtil.getInt(request, "pageSize",5);
		PageBean pb=new  PageBean(page, pageSize); 
		filter.setPageBean(pb);
		List<TUserMsgRemind>  list = tuserMsgRemindService.getBySqlKeyAll(filter, TUserMsgRemind.class, "getReceiverId");
		 request.setAttribute( "page_bean", pb );
		return new ModelAndView("/loan/aboutus/MsgReminds.jsp").addObject("list",list).addObject( "page_bean", pb );
	}
	
	@RequestMapping({ "MsgRemindDetails" })
	@Action(description = "我的服务与通知详情")
	public ModelAndView MsgRemindDetails(HttpServletRequest request, HttpServletResponse response,long MsgRemindId)
			throws Exception {  
		TUserMsgRemind tuserMsgRemind=tuserMsgRemindService.getById(MsgRemindId);
		tuserMsgRemind.setStateId(1);
		tuserMsgRemind.setReadTime(new Date());
		this.tuserMsgRemindService.update(tuserMsgRemind); 
		return new ModelAndView("/loan/aboutus/MsgRemindDetails.jsp").addObject("tuserMsgRemind",tuserMsgRemind);
	}
	
	@RequestMapping({ "PriInfoRemindDetails" })
	@Action(description = "私信详情")
	public ModelAndView PriInfoRemindDetails(HttpServletRequest request, HttpServletResponse response)
			throws Exception { 
		TUser user = TUserUtil.getLogUser(request);//获取登陆用户
		String MsgRemindId = request.getParameter("MsgRemindId");
		TUserMsgRemind tuserMsgRemind=tuserMsgRemindService.getById(Long.valueOf(MsgRemindId));
		tuserMsgRemind.setStateId(1);
		tuserMsgRemind.setIsDel(Long.valueOf(0));
		tuserMsgRemind.setReadTime(new Date());
		this.tuserMsgRemindService.update(tuserMsgRemind); 
		//查询回复的信息
		List<TUserMsgRemind>     replyInfos = tuserMsgRemindService.getReplyInfos(Long.valueOf(MsgRemindId));
		
		
		return new ModelAndView("/crowdfunding/front/newsCenter/PivInfoRemindDetails.jsp")
		.addObject("tuserMsgRemind",tuserMsgRemind)
		.addObject("replyInfos",replyInfos);
	}
	
	@RequestMapping({ "msgRemindSave" })
	@Action(description = "保存服务与通知")
	public void msgRemindSave(HttpServletRequest request, HttpServletResponse response,TUserMsgRemind tuserMsgRemind)
			throws Exception {
		tuserMsgRemindService.add(tuserMsgRemind);
	}
	
	@RequestMapping({ "get" })
	@Action(description = "查看TUsermsgRemind数据")
	public ModelAndView get(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		long pkId = RequestUtil.getLong(request, "msgRemindId");
		TUserMsgRemind tuserMsgRemind = this.tuserMsgRemindService.getById(pkId);//(TUserMsgRemind) this.TUserMsgRemindService.getById(Long.valueOf(pkId));
		//tuserMsgRemind.setStateId(1);
		//this.tuserMsgRemindService.update(tuserMsgRemind); 
		return new ModelAndView("loan/aboutus/TUserMsgRemindGet.jsp").addObject(
				"tuserMsgRemind", tuserMsgRemind);
	}
	
	@RequestMapping({ "saveMsgRemind" })
	@Action(description = "发送消息")
	@ResponseBody
	public String saveMsgRemind(HttpServletRequest request, HttpServletResponse response,TUserMsgRemind tuserMsgRemind)
			throws Exception {
		String result = "1";
		TUser user = (TUser) request.getSession().getAttribute("user");
		String receiverName = request.getParameter("receiverName");
		String sendContent = request.getParameter("sendContent");
		String replyId = request.getParameter("replyId");
		String isReply = request.getParameter("isReply");
		String createrId = request.getParameter("createrId");
		String projectId = request.getParameter("projectId");
		String typeId = request.getParameter("typeId");
		TUser tUser = new TUser();
		tUser.setLoginName(receiverName);
		TUser tUser1 = tUserService.queryTUserByLoginName(tUser);
		if(!("".equals(createrId))&&null!=createrId){
			tuserMsgRemind.setReceiverId(Long.valueOf(createrId));
		}else{
			if(null==tUser1 || "".equals(tUser1)){
				result = "2";
	        	return result;
			}
			tuserMsgRemind.setReceiverId(tUser1.getUserId());
		}
		if(!("".equals(projectId))&&null!=projectId){
			tuserMsgRemind.setProjectId(Long.valueOf(projectId));
		}
		tuserMsgRemind.setMsgRemindId(Long.valueOf(UniqueIdUtil.genId()));
		tuserMsgRemind.setContent(sendContent);
		tuserMsgRemind.setSendTime(new Date());
		tuserMsgRemind.setSenderId(user.getUserId());
		tuserMsgRemind.setStateId(0);//发送的时候默认为0，0代表未读，1代表为已读
		tuserMsgRemind.setTypeId(StringUtils.isEmpty(typeId)?1:Integer.parseInt(typeId));//1私信 2约谈信 3收藏项目的投资人 4、向我推荐项目 5系统通知,需求还不怎么明白，暂时添加私信的
		if("1".equals(isReply)){
			tuserMsgRemind.setIsReply(Long.valueOf(1));
		}else{
			tuserMsgRemind.setIsReply(Long.valueOf(0));
		}
		if(null==replyId ||"".equals(replyId)){
			tuserMsgRemind.setReplyID(Long.valueOf(0));
		}else{
			tuserMsgRemind.setReplyID(Long.valueOf(replyId));
		}
		
		tuserMsgRemindService.add(tuserMsgRemind);
        String code = request.getParameter("validCode");
        String validCode = (String)request.getSession().getAttribute(ValidCode.getSessionName_Randcode());
        if(StringUtils.isNotEmpty(code)){
        	if(!validCode.equalsIgnoreCase(code)){
                result = "0";
                return result;
             }
        }
		return result;
	}
	
	
	@RequestMapping({ "saveAboutInfo" })
	@Action(description = "发送约谈信")
	@ResponseBody
	public String saveAboutInfo(HttpServletRequest request, HttpServletResponse response,TUserMsgRemind tuserMsgRemind)
			throws Exception {
		String result = "1";
		TUser user = (TUser) request.getSession().getAttribute("user");
		String sendContent = request.getParameter("sendContent");
		String isReply = request.getParameter("isReply");
		String createrId = request.getParameter("createrId");
		String projectId = request.getParameter("projectId");
		tuserMsgRemind.setMsgRemindId(Long.valueOf(UniqueIdUtil.genId()));
		tuserMsgRemind.setContent(sendContent);
		tuserMsgRemind.setSendTime(new Date());
		tuserMsgRemind.setSenderId(user.getUserId());
		tuserMsgRemind.setStateId(0);//发送的时候默认为0，0代表未读，1代表为已读
		tuserMsgRemind.setTypeId(2);//1私信 2约谈信 3收藏项目的投资人 4、向我推荐项目 5系统通知,需求还不怎么明白，暂时添加私信的
		tuserMsgRemind.setReceiverId(Long.valueOf(createrId));
		tuserMsgRemind.setReplyID(Long.valueOf(0));
		if("1".equals(isReply)){
			tuserMsgRemind.setIsReply(Long.valueOf(1));
		}else{
			tuserMsgRemind.setIsReply(Long.valueOf(0));
		}
		tuserMsgRemind.setProjectId(Long.valueOf(projectId));
        String code = request.getParameter("validCode");
        String validCode = (String)request.getSession().getAttribute(ValidCode.getSessionName_Randcode());
        if(!code.equalsIgnoreCase(validCode)){
           result = "0";
           return result;
        }
        tuserMsgRemindService.add(tuserMsgRemind);
		return result;
	}
	
	@RequestMapping({ "replyMsgRemind" })
	@Action(description = "回复消息")
	public ModelAndView replyMsgRemind(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String replyId = request.getParameter("replyId");
		String receiverName = new String(request.getParameter("receiverName").getBytes("iso-8859-1"),"utf-8") ;
		return new ModelAndView("/crowdfunding/front/newsCenter/PivInfoRemindReply.jsp").addObject("replyId", replyId).addObject("receiverName", receiverName);
	}
	
	
  /**
   * 我的收件箱
   * @param request
   * @return
   */
	@RequestMapping({ "myInbox" })
	@Action(description = "收件箱")
	public ModelAndView myInbox(HttpServletRequest request) {
		String groupId = request.getParameter("groupId");
		if("1".equals(groupId)){
			return new ModelAndView("/crowdfunding/front/newsCenter/entrepreneurInBox.jsp");
			
		}else if("2".equals(groupId)){
			return new ModelAndView("/crowdfunding/front/newsCenter/investorInBox.jsp");
		}
		return null;
	}
	
	/**
	 * 我的私信
	 * @param request
	 * @return
	 */
	@RequestMapping({ "getMyPrivateInfos" })
	@Action(description = "我的私信")
	public ModelAndView getMyPrivateInfos(HttpServletRequest request) {
		TUser user = TUserUtil.getLogUser(request);// 获取登陆用户
		// 分页加参数
		int page = RequestUtil.getInt(request, "current_page", 1);
		// int pageSize = RequestUtil.getInt(request,
		// "pageSize",PageBean.getDefaultPageSize().intValue());
		int pageSize = RequestUtil.getInt(request, "pageSize", 10);
		PageBean pb = new PageBean(page, pageSize);
		List<TUserMsgRemind> privateInfos = tuserMsgRemindService.getMyPrivateInfos(null, null, "1", user.getUserId(),Long.valueOf(0),pb);
		long UnReadMsgCount = getUnReadMsgCount(request,null);
		long UnReadMsgCur = getUnReadMsgCount(request,"1");
		return new ModelAndView("/crowdfunding/front/newsCenter/privateInfo.jsp").addObject("privateInfos", privateInfos).addObject("page_bean", pb)
				.addObject("UnReadMsgCount", UnReadMsgCount).addObject("UnReadMsgCur", UnReadMsgCur).addObject("userMsgFlag", "1");
	}
	
	/**
	 * 我的项目推荐
	 * @param request
	 * @return
	 */
	@RequestMapping({ "myProjectRecommod" })
	@Action(description = "我的项目推荐")
	public ModelAndView myProjectRecommod(HttpServletRequest request) {
		TUser user = TUserUtil.getLogUser(request);// 获取登陆用户
		// 分页加参数
		int page = RequestUtil.getInt(request, "current_page", 1);
		// int pageSize = RequestUtil.getInt(request,
		// "pageSize",PageBean.getDefaultPageSize().intValue());
		int pageSize = RequestUtil.getInt(request, "pageSize", 4);
		PageBean pb = new PageBean(page, pageSize);
		List<TUserMsgRemind> recommodProInfos = tuserMsgRemindService
				.getMyPrivateInfos(null, null, "4", user.getUserId(), Long.valueOf(0),pb);
		long UnReadMsgCount = getUnReadMsgCount(request,null);
		long UnReadMsgCur = getUnReadMsgCount(request,"4");
		return new ModelAndView("/crowdfunding/front/newsCenter/recommendInfo.jsp").addObject("recommodProInfos", recommodProInfos).addObject("page_bean", pb)
				.addObject("UnReadMsgCount", UnReadMsgCount).addObject("UnReadMsgCur", UnReadMsgCur).addObject("userMsgFlag", "4");
	}	
	
	/**
	 * 我的系统通知
	 * @param request
	 * @return
	 */
	@RequestMapping({ "mySystemInfo" })
	@Action(description = "我的系统通知")
	public ModelAndView mySystemInfo(HttpServletRequest request) {
		TUser user = TUserUtil.getLogUser(request);// 获取登陆用户
		// 分页加参数
		int page = RequestUtil.getInt(request, "current_page", 1);
		// int pageSize = RequestUtil.getInt(request,
		// "pageSize",PageBean.getDefaultPageSize().intValue());
		int pageSize = RequestUtil.getInt(request, "pageSize", 4);
		PageBean pb = new PageBean(page, pageSize);
		List<TUserMsgRemind> sysInformInfos = tuserMsgRemindService
				.getMyPrivateInfos(null, null, "5", user.getUserId(), Long.valueOf(0),pb);
		long UnReadMsgCount = getUnReadMsgCount(request,null);
		long UnReadMsgCur = getUnReadMsgCount(request,"5");
		return new ModelAndView("/crowdfunding/front/newsCenter/systemInfo.jsp").addObject("sysInformInfos", sysInformInfos).addObject("page_bean", pb)
				.addObject("UnReadMsgCount", UnReadMsgCount).addObject("UnReadMsgCur", UnReadMsgCur).addObject("userMsgFlag", "5");
	}	
	
	/**
	 * 我的约谈信
	 * @param request
	 * @return
	 */
	@RequestMapping({ "myAboutInfo" })
	@Action(description = "我的约谈信")
	public ModelAndView myAboutInfo(HttpServletRequest request) {
		TUser user = TUserUtil.getLogUser(request);// 获取登陆用户
		// 分页加参数
		int page = RequestUtil.getInt(request, "current_page", 1);
		// int pageSize = RequestUtil.getInt(request,
		// "pageSize",PageBean.getDefaultPageSize().intValue());
		int pageSize = RequestUtil.getInt(request, "pageSize", 4);
		PageBean pb = new PageBean(page, pageSize);
		List<TUserMsgRemind> aboutInformInfos = tuserMsgRemindService
				.getMyPrivateInfos(null, null, "2", user.getUserId(),Long.valueOf(0), pb);
		long UnReadMsgCount = getUnReadMsgCount(request,null);
		long UnReadMsgCur = getUnReadMsgCount(request,"2");
		return new ModelAndView("/crowdfunding/front/newsCenter/aboutInfo.jsp").addObject("aboutInformInfos", aboutInformInfos).addObject("page_bean", pb)
				.addObject("UnReadMsgCount", UnReadMsgCount).addObject("UnReadMsgCur", UnReadMsgCur).addObject("userMsgFlag", "2");
	}
	
	/**
	 * 收藏项目的投资人
	 * @param request
	 * @return
	 */
	@RequestMapping({ "myCollectPro" })
	@Action(description = "收藏项目的投资人")
	public ModelAndView myCollectPro(HttpServletRequest request) {
		TUser user = TUserUtil.getLogUser(request);// 获取登陆用户
		// 分页加参数
		int page = RequestUtil.getInt(request, "current_page", 1);
		// int pageSize = RequestUtil.getInt(request,
		// "pageSize",PageBean.getDefaultPageSize().intValue());
		int pageSize = RequestUtil.getInt(request, "pageSize", 4);
		PageBean pb = new PageBean(page, pageSize);
		List<TUserMsgRemind> myCollectPros = tuserMsgRemindService
				.getMyPrivateInfos(null, null, "3", user.getUserId(),Long.valueOf(0), pb);
		long UnReadMsgCount = getUnReadMsgCount(request,null);
		long UnReadMsgCur = getUnReadMsgCount(request,"3");
		return new ModelAndView("/crowdfunding/front/newsCenter/collectInfo.jsp").addObject("myCollectPros", myCollectPros).addObject("page_bean", pb)
				.addObject("UnReadMsgCount", UnReadMsgCount).addObject("UnReadMsgCur", UnReadMsgCur).addObject("userMsgFlag", "3");
	}
	
	@RequestMapping({ "getEntrepreneurInBox" })
	@Action(description = "根据消息类型获取相应的消息(创业者)")
	public ModelAndView getEntrepreneurInBox(HttpServletRequest request) {
		TUser user = TUserUtil.getLogUser(request);//获取登陆用户
		//分页加参数
		int page = RequestUtil.getInt(request, "current_page", 1);
		//int pageSize = RequestUtil.getInt(request, "pageSize",PageBean.getDefaultPageSize().intValue());
		int pageSize = RequestUtil.getInt(request, "pageSize",2);
		PageBean pb=new  PageBean(page, pageSize);
		request.setAttribute( "page_bean", pb );//分页参数传入页面
		List<TUserMsgRemind>     entrepreneurInBox = tuserMsgRemindService.getMyPrivateInfos(null,null,"1",user.getUserId(),Long.valueOf(0),pb);
		//List<TUserMsgRemind>     aboutInfos = tuserMsgRemindService.getMyPrivateInfos(null,null,"2",user.getUserId(),pb);
		//List<TUserMsgRemind>     collectProInfos = tuserMsgRemindService.getMyPrivateInfos(null,null,"3",user.getUserId(),pb);
		//List<TUserMsgRemind>     recommodProInfos = tuserMsgRemindService.getMyPrivateInfos(null,null,"4",user.getUserId(),pb);
		//List<TUserMsgRemind>     sysInformInfos = tuserMsgRemindService.getMyPrivateInfos(null,null,"5",user.getUserId(),pb);
		//request.setAttribute("aboutInfos", aboutInfos);//查询约谈信
		//request.setAttribute("collectProInfos", collectProInfos);//查询收藏项目的投资人
		//request.setAttribute("recommodProInfos", recommodProInfos);//查询向我推荐项目
		//request.setAttribute("sysInformInfos", sysInformInfos);//查询系统通知
		//request.setAttribute("status", request.getParameter("status"));状态暂时不做，当点击查看收件箱记录详情的时候，改变记录的状态
		request.setAttribute("entrepreneurInBox", entrepreneurInBox);//查询私信
		return new ModelAndView("/crowdfunding/front/newsCenter/entrepreneurInBox.jsp");
	}
	
	@RequestMapping({ "getOutBoxData" })
	@Action(description = "获得发件箱的数据")
	public ModelAndView getOutBoxData(HttpServletRequest request) {
		TUser user = TUserUtil.getLogUser(request);//获取登陆用户
		//分页加参数
		int page = RequestUtil.getInt(request, "current_page", 1);
		int pageSize = RequestUtil.getInt(request, "pageSize",3);
		PageBean pb=new  PageBean(page, pageSize);
		request.setAttribute( "page_bean", pb );//分页参数传入页面
		List<TUserMsgRemind>     outBoxData = tuserMsgRemindService.getOutBoxData(null,null,null,user.getUserId(),pb);
		request.setAttribute("outBoxData", outBoxData);//查询私信
		return new ModelAndView("/crowdfunding/front/newsCenter/outBox.jsp");
	}
	
	@RequestMapping({ "getRecommodProInfos" })
	@Action(description = "根据向我推荐的项目信息")
	public ModelAndView getRecommodProInfos(HttpServletRequest request) {
		TUser user = TUserUtil.getLogUser(request);//获取登陆用户
		//分页加参数
		int page = RequestUtil.getInt(request, "current_page", 1);
		//int pageSize = RequestUtil.getInt(request, "pageSize",PageBean.getDefaultPageSize().intValue());
		int pageSize = RequestUtil.getInt(request, "pageSize",3);
		PageBean pb=new  PageBean(page, pageSize);
		request.setAttribute( "page_bean", pb );//分页参数传入页面
		//List<TUserMsgRemind>     privateInfos = tuserMsgRemindService.getMyPrivateInfos(null,null,"1",user.getUserId(),pb);
		//List<TUserMsgRemind>     aboutInfos = tuserMsgRemindService.getMyPrivateInfos(null,null,"2",user.getUserId(),pb);
		//List<TUserMsgRemind>     collectProInfos = tuserMsgRemindService.getMyPrivateInfos(null,null,"3",user.getUserId(),pb);
		List<TUserMsgRemind>     recommodProInfos = tuserMsgRemindService.getMyPrivateInfos(null,null,"4",user.getUserId(),Long.valueOf(0),pb);
		//List<TUserMsgRemind>     sysInformInfos = tuserMsgRemindService.getMyPrivateInfos(null,null,"5",user.getUserId(),pb);
		//request.setAttribute("aboutInfos", aboutInfos);//查询约谈信
		//request.setAttribute("collectProInfos", collectProInfos);//查询收藏项目的投资人
		request.setAttribute("recommodProInfos", recommodProInfos);//查询向我推荐项目
		//request.setAttribute("sysInformInfos", sysInformInfos);//查询系统通知
		//request.setAttribute("status", request.getParameter("status"));状态暂时不做，当点击查看收件箱记录详情的时候，改变记录的状态
		//request.setAttribute("privateInfos", privateInfos);//查询私信
		return new ModelAndView("/crowdfunding/front/newsCenter/investorInBox.jsp");
	}
	
	@RequestMapping({ "sendMessage" })
	@Action(description = "发送私信跳转页面")
	public ModelAndView sendMessage(HttpServletRequest request)
			throws Exception {
		return new ModelAndView("/crowdfunding/front/newsCenter/sendNewMessage.jsp");
	}
	
	@RequestMapping({ "sendProjectPrivateInfo" })
	@Action(description = "发送项目私信")
	public ModelAndView sendProjectPrivateInfo(HttpServletRequest request)
			throws Exception {
		String createrId = request.getParameter("createrId");
		String projectId = request.getParameter("projectId");
		return new ModelAndView("/crowdfunding/front/newsCenter/projectPirvateInfo.jsp")
		.addObject("createrId", createrId).addObject("projectId", projectId);
	}
	
	
	@RequestMapping({ "sendSuccess" })
	@Action(description = "发送私信成功跳转界面")
	public ModelAndView sendSuccess(HttpServletRequest request)
			throws Exception {
		return new ModelAndView("/crowdfunding/front/newsCenter/sendSuccess.jsp");
	}
	
	
	@RequestMapping({ "sendFail" })
	@Action(description = "发送私信成功跳转界面")
	public ModelAndView sendFail(HttpServletRequest request)
			throws Exception {
		return new ModelAndView("/crowdfunding/front/newsCenter/sendFail.jsp");
	}
	
	
	@RequestMapping({ "delConfirm" })
	@Action(description = "删除确认跳转页面")
	public ModelAndView delConfirm(HttpServletRequest request)
			throws Exception {
		String messageId = request.getParameter("msgRemindId");
		return new ModelAndView("/crowdfunding/front/newsCenter/confirmDel.jsp").addObject("messageId",messageId);
	}
	
	
	@RequestMapping("getTUserMsgCount")
	@ResponseBody
	
	
	public Object getTUserMsgCount(HttpServletRequest request){

		String typeId = request.getParameter("typeId");
		TUser user = TUserUtil.getLogUser(request);//获取登陆用户
		Long userId = user.getUserId();
		
		if(userId==null){
			return 0;
		}
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("receiverId", userId);
		map.put("stateId", 0);
		
		if(typeId!=null){
			map.put("typeId", typeId);
		}
		
		long userMsgCount = tuserMsgRemindService.getUserMsgCount(map);
		return userMsgCount;
		
			
			
	}
	public long getUnReadMsgCount(HttpServletRequest request,String typeId){

		TUser user = TUserUtil.getLogUser(request);//获取登陆用户
		Long userId = user.getUserId();
		if(userId==null){
			return 0;
		}
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("receiverId", userId);
		map.put("stateId", 0);
		
		if(typeId!=null){
			map.put("typeId", typeId);
		}
		
		long userMsgCount = tuserMsgRemindService.getUserMsgCount(map);
		return userMsgCount;		
	}
	
	
}
