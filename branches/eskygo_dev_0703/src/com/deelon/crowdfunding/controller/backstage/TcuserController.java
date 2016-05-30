/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.crowdfunding.controller.backstage;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.deelon.core.page.PageBean;
import org.apache.cxf.jaxws.JaxWsProxyFactoryBean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.common.util.MD5Util;
import com.deelon.crowdfunding.webservice.SyncUserInterface;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.Tarea;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TareaService;

@ Controller
@ RequestMapping( { "/crowdfunding/tcuser/tcuser/" } )
public class TcuserController extends BaseController{
	@ Resource
	private TUserService tuserService;
	@ Resource
	private TareaService tareaService;

	@ RequestMapping( { "list" } )
	@ Action( description = "会员查询分页列表")
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		Integer groupId = RequestUtil.getInt( request, "groupId" );//接受页面返回的Id
		QueryFilter queryFilter = new QueryFilter(request, "tuserItem");
		groupId=1;
		queryFilter.addFilter("groupId", groupId);
		List<TUser> list = this.tuserService.getAll(queryFilter);
		return new ModelAndView("/crowdfunding/tuserInvestor/tuserList.jsp").addObject( "tuserList", list );
	}
	
	@ RequestMapping( { "listToSelect" } )
	@ Action( description = "投资人查询分页列表")
	public ModelAndView listToSelect( HttpServletRequest request, HttpServletResponse response,String type) throws Exception
	{ 
		Integer groupId = RequestUtil.getInt( request, "groupId" );//接受页面返回的Id
		Integer iscompany = RequestUtil.getInt( request, "isCompany" );//接受页面返回的Id
		QueryFilter queryFilter = new QueryFilter(request, "tuserItem");
		if(StringUtil.isEmpty(type)){
			type="0";
		}
		request.setAttribute("type", type);
		queryFilter.addFilter("groupId", groupId);
		queryFilter.addFilter("isCompany", iscompany);
		List list = this.tuserService.getAll(queryFilter);
		
		//获取省级地区
		QueryFilter query = new QueryFilter();
		query.addFilter("parentId", 1);
		query.addFilter("orderField", "order_code");
		query.addFilter("orderSeq", "desc");
		List<Tarea> arealist = tareaService.getAll(query);
		
		return new ModelAndView("/crowdfunding/tuserInvestor/ttuserList.jsp")
			.addObject( "tuserList", list ).addObject( "arealist", arealist ).addObject("iscompany", iscompany);
	}

	@RequestMapping({ "investorASKList" })
	@ Action( description = "认筹金额线下付款分页列表")
	public ModelAndView investorASKList(HttpServletRequest request, HttpServletResponse response) {
		Integer groupId = RequestUtil.getInt(request, "groupId");//接受页面返回的Id
		QueryFilter queryFilter = new QueryFilter(request, "tuserItem");
		queryFilter.addFilter("groupId", groupId);
		List<TUser> investorList=tuserService.getAllASKInvestorList(queryFilter);

		return new ModelAndView("/crowdfunding/tuserInvestor/investorASKList.jsp")
				.addObject("tuserList", investorList);

	}

	@RequestMapping( { "listToAudit" } )
	@ Action( description = "投资人查询分页列表")
	public ModelAndView listToAudit( HttpServletRequest request, HttpServletResponse response,String type) throws Exception
	{ 
		Integer groupID = RequestUtil.getInt( request, "groupID" );//接受页面返回的Id
		Integer iscompany = RequestUtil.getInt( request, "isCompany" );//接受页面返回的Id
		System.out.println("--->"+groupID+"--->"+iscompany+"--->"+type);
		QueryFilter queryFilter = new QueryFilter(request, "tuserItem");
		if(StringUtil.isEmpty(type)){
			type="0";
		}
		request.setAttribute("type", type);
		queryFilter.addFilter("groupID", groupID);
		queryFilter.addFilter("isCompany", iscompany);
		List list = this.tuserService.getAll(queryFilter);
		return new ModelAndView("/crowdfunding/tuserInvestor/tuserAuditList.jsp").addObject( "tuserList", list );
	}
	
	@ RequestMapping( { "del" } )
	@ Action( description = "删除Tuser数据")
	 @ResponseBody
	public String del( HttpServletRequest request, HttpServletResponse response,String arrayIds) throws Exception
	{	
		//ResultMessage message = null;
//		/String preUrl = RequestUtil.getPrePage( request );
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr(arrayIds);
			for (int i = 0; i < lAryId.length; i++) {
				System.out.println("--->"+lAryId[i]);
				TUser tcuser = tuserService.getById(lAryId[i]);
				tcuser.setIsDel(1);
				this.tuserService.update(tcuser);
			}
			//message = new ResultMessage( 1, "删除数据成功" );
			return "0";
			
		}
		catch ( Exception e )
		{
			return "1";	
			//message = new ResultMessage( 0, "删除数据失败" );
		}
		//addMessage( message, request );
		//response.sendRedirect( preUrl );
	}
	
	@Action(description="保存修改操作")
	 @RequestMapping({"updateUser"})
	 @ResponseBody
	 public String updateUserInfo(HttpServletRequest request, HttpServletResponse response,String arrayIds){
		 Map<String,String> map=new HashMap<String,String>();
		 try {
			 String isLock=request.getParameter("isLock");
			 String isActive=request.getParameter("isActive");
			 String isRecommended=request.getParameter("isRecommended");
			 System.out.println("------>"+isLock+"------->"+isActive+"------->"+isRecommended);
			Long[] larrId=RequestUtil.getLongAryByStr(arrayIds);
			
			for (Long id : larrId) {
				TUser tcuser = tuserService.getById(id);
				if(StringUtil.isNotEmpty(isLock)){
					tcuser.setLoginPwdErrCount(0);
					tcuser.setIsLock(Integer.valueOf(isLock));
				}
				if(StringUtil.isNotEmpty(isActive)){
					tcuser.setIsActive(Integer.valueOf(isActive));
				}
				if(StringUtil.isNotEmpty(isRecommended)){
					tcuser.setIsRecommended(Integer.valueOf(isRecommended));
					tcuser.setRecommendedTime(new Date());
				}
				this.tuserService.update(tcuser);
			}
			return "0";
		} catch (Exception e) {
			e.printStackTrace();
			return "1";
		}
		 
	 }

	@ RequestMapping( { "edit" } )
	@ Action( description = "编辑Tuser数据" )
	public ModelAndView edit( HttpServletRequest request ) throws Exception
	{
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "userId" ) );
		TUser tuser = null;
		if ( pkId.longValue() != 0L )
			tuser = (TUser) this.tuserService.getById( pkId );
		else
		{
			tuser = new TUser();
		}
		return new ModelAndView("/crowdfunding/tuserInvestor/tuserEdit.jsp").addObject( "tuser", tuser ).addObject( "userId", pkId );
	}
	
	@ RequestMapping( { "tedit" } )
	@ Action( description = "编辑Tuser数据" )
	public ModelAndView tedit( HttpServletRequest request ) throws Exception
	{
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "userId" ) );
		TUser tuser = null;
		if ( pkId.longValue() != 0L )
			tuser = (TUser) this.tuserService.getById( pkId );
		else
		{
			tuser = new TUser();
		}
		return new ModelAndView("/crowdfunding/tuserInvestor/ttuserEdit.jsp").addObject( "tuser", tuser ).addObject( "userId", pkId );
	}

	@ RequestMapping( { "get" } )
	@ Action( description = "查看Tuser数据")
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "userId" );
		TUser tuser = (TUser) this.tuserService.getById( Long.valueOf( pkId ) );
		return getAutoView().addObject( "tuser", tuser );
	}
	
	//webservice同步用户数据
	@ RequestMapping( { "syncUser" } )
	@ Action( description = "同步用户数据")
	public ModelAndView syncUser( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		return new ModelAndView("/crowdfunding/tuserInvestor/syncUser.jsp");
	}
	
	//webservice同步用户数据
		@ RequestMapping( { "syncInsertUser" } )
		@ Action( description = "同步插入用户数据")
		@ResponseBody
		public String syncInsertUser( HttpServletRequest request, HttpServletResponse response )
		{
			String result = "";
			try{		
				String loginName = RequestUtil.getString( request, "loginName" );
				String loginPwd = RequestUtil.getString( request, "loginPwd" );
				String realName = RequestUtil.getString( request, "realName" );
				String email = RequestUtil.getString( request, "email" );
				String mobile = RequestUtil.getString( request, "mobile" );
				String idNumber = RequestUtil.getString( request, "idNumber" );
				String groupId = RequestUtil.getString( request, "groupId" );
				String registerTime = RequestUtil.getString( request, "registerTime" );
				
				String path = request.getContextPath();
				String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
				
				//同步数据测试类
				JaxWsProxyFactoryBean svr = new JaxWsProxyFactoryBean();
				svr.setServiceClass(SyncUserInterface.class);
				svr.setAddress(basePath+"service/syncUserService?wsdl");
				SyncUserInterface hw = (SyncUserInterface) svr.create();
				String syncUserDatas = "<?xml version='1.0' encoding='UTF-8'?>"+
						"<userDatas>"+
						"<userData>"+
						"<loginName>"+loginName+"</loginName>"+
						"<loginPwd>"+MD5Util.MD5(loginPwd)+"</loginPwd>"+
						"<realName>"+realName+"</realName>"+
						"<email>"+email+"</email>"+
						"<mobile>"+mobile+"</mobile>"+
						"<idNumber>"+idNumber+"</idNumber>"+
						"<groupId>"+groupId+"</groupId>"+
						"<registerTime>"+registerTime+"</registerTime>"+
						"</userData>"+
						"</userDatas>";
				result = hw.insertUserInfo(syncUserDatas);
			}catch(Exception e){
				e.printStackTrace();
				result = e.getMessage();
			}

			return result;
		}
}

