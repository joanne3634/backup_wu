package com.deelon.loan.controller.sysManager;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.model.backstage.TcuserAudit;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserCompany;
import com.deelon.loan.model.front.TUserContact;
import com.deelon.loan.model.front.TUserFamily;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.model.front.Tarea;
import com.deelon.loan.model.front.TuserCredit;
import com.deelon.loan.model.sysManager.TuserAudit;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TareaService;
import com.deelon.loan.service.front.TuserCompanyService;
import com.deelon.loan.service.front.TuserContactService;
import com.deelon.loan.service.front.TuserCreditService;
import com.deelon.loan.service.front.TuserFamilyService;
import com.deelon.loan.service.front.TuserSafeService;
import com.deelon.loan.service.front.UserInfoService;
import com.deelon.loan.service.sysManager.TuserAuditService;
import com.deelon.loan.service.sysManager.TuserFundsService;
import com.deelon.platform.model.system.Demension;
import com.deelon.platform.model.system.SysUser;
import com.deelon.platform.service.system.DemensionService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@ Controller
@ RequestMapping( { "/loan/sysManager/tuseraudit/" } )
public class TuserAuditController extends BaseController{
	
	@ Resource
	private TuserAuditService tuserAuditService;  //自定义审核信息列表
	@ Resource
	private TUserService tuserService;  //用户信息
	@ Resource
	private TuserSafeService tuserSafeService; //个人资料信息
	@ Resource
	private TuserFamilyService tuserFamilyService; //家庭信息
	@ Resource
	private TuserCompanyService tuserCompanyService;  //单位信息
	@ Resource
	private TuserContactService tuserContactService;  //联系信息
	@ Resource
	private UserInfoService userInfoService; //用户信息提交操作service
	
	@ Resource
	private TuserCreditService tuserCreditService;//信誉度功能
	@ Resource
	private TuserFundsService tuserFundsService;
	
	@Autowired
	private TareaService tareaService;


	@ RequestMapping( { "list" } )
	@ Action( description = "查看TuserAudit分页列表" )
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		System.out.println("-----beginfff------");
		QueryFilter queryFilter=new QueryFilter(request, "tuserAuditItem");
		queryFilter.addFilter("groupId", 2);//显示的是投资人
		queryFilter.addFilter("isDel", 0);   //未删除
		List list = this.tuserAuditService.getAll(queryFilter);

		ModelAndView mv = new ModelAndView("/crowdfunding/tuserInvestor/tuserAuditList.jsp").addObject( "tuserAuditList", list );
		System.out.println("-----end------");
		return mv;
	}

	@ RequestMapping( { "del" } )
	@ Action( description = "删除TuserAudit数据" )
	public void del( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request );
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "userId" );
			this.tuserAuditService.delByIds( lAryId );
			message = new ResultMessage( 1, "删除数据成功" );
		}
		catch ( Exception e )
		{
			message = new ResultMessage( 0, "删除数据失败" );
		}
		addMessage( message, request );
		response.sendRedirect( preUrl );
	}

	@ RequestMapping( { "edit" } )
	@ Action( description = "编辑TuserAudit数据" )
	public ModelAndView edit( HttpServletRequest request ) throws Exception
	{
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "userId" ) );
		TcuserAudit tuserAudit = null;
		TUserSafe userSafe = null;
		if ( pkId.longValue() != 0L ){
			tuserAudit = (TcuserAudit) this.tuserAuditService.getById( pkId );
		 	userSafe = this.tuserSafeService.getUserSafeByUserId(pkId);
		}else
		{
			tuserAudit = new TcuserAudit();
			userSafe = new TUserSafe();
		}

			
					
		return new ModelAndView("/crowdfunding/tuserInvestor/tuserauditEdit.jsp").addObject( "tuserAudit", tuserAudit ).addObject("userSafe", userSafe).addObject( "userId", pkId );
	}

	@ RequestMapping( { "get" } )
	@ Action( description = "查看TuserAudit数据" )
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "userId" );
		//获取审核基本信息列表
		TcuserAudit tuserAudit = (TcuserAudit) this.tuserAuditService.getById( Long.valueOf( pkId ) );
		//通过用户ID获取该用户基本表中的信息
		TUser tUser = this.userInfoService.getUserByUserId(pkId);
		//通过用户ID获取该用户个人资料
		TUserSafe tuserSafe = this.userInfoService.getUserSafe(pkId);
		//通过用户ID获取该用户家庭信息
		TUserFamily tuserFamily = this.userInfoService.getUserFamilyByUserId(pkId);
		//通过用户ID获取该用户单位信息
		TUserCompany tuserCompany = this.userInfoService.getUserCompanyByUserId(pkId);
		//通过用户ID获取该用户联系信息
		TUserContact tuserContact = this.userInfoService.getUserContactByUserId(pkId);
		//审核状态
		String safeFlag = tuserSafe==null?"0":tuserSafe.getStatusID();
		System.out.println(safeFlag);
		String familyFlag = tuserFamily==null?"0":tuserFamily.getStatusID();
		System.out.println(familyFlag);
		String companyFlag = tuserCompany==null?"0":tuserCompany.getStatusID();
		System.out.println(companyFlag);
		String contactFlag = tuserContact==null?"0":tuserContact.getStatusID();
		System.out.println(contactFlag);
		
		//获取最高等级级联
		List<Tarea> list = tareaService.getbyParentId(1);
		
		return getAutoView().addObject( "tuserAudit", tuserAudit ).addObject( "tUser", tUser ).addObject("tuserSafe", tuserSafe)
				.addObject( "tuserFamily", tuserFamily ).addObject( "tuserCompany", tuserCompany ).addObject( "tuserContact", tuserContact )
				.addObject("safeFlag", safeFlag).addObject("familyFlag", familyFlag)
				.addObject("companyFlag", companyFlag).addObject("contactFlag", contactFlag).addObject("list", list);
	}
	
	//获取级联省市
	@RequestMapping({ "ajaxGetJilian" })
	@ResponseBody
	public void ajaxGetJilian(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String areaId = request.getParameter("areaId");
		//获取最高等级级联
		List<Tarea> list = tareaService.getbyParentId(Long.valueOf(areaId));
		this.writeObjectToClient(list, response);
	}
	
	
	@RequestMapping({ "editBaseInfo" })
	@ Action( description = "编辑会员基本信息" )
	@ResponseBody
	public String editBaseInfo(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		long tuserID = Long.parseLong(request.getParameter("tuserID")); //前台会员
		String realName = request.getParameter("realName");
		String gender = request.getParameter("gender");
		String mobile = request.getParameter("mobile");
		String qqNo = request.getParameter("qqNo");
		String edu = request.getParameter("edu");
		String idNo = request.getParameter("idNo");
		String school = request.getParameter("school");
		String baseFlag = request.getParameter("baseFlag");
		
		//信誉度功能，判断baseFlag的数值
		if("2".equals(baseFlag)){
			//审核通过加信誉5
			TUserSafe tUserSafe =tuserSafeService.getUserSafeByUserId(tuserID);
			TuserCredit tuserCredit =new TuserCredit();
			tuserCredit.setUserId(tuserID);
			tuserCredit.setTypeId(4);
			tuserCredit.setKeyId(tUserSafe.getSafeId());
			tuserCredit.setCreditAdd(5);
			tuserCredit.setDescription("审核通过个人基本资料");
			Date date =new Date();
			tuserCredit.setCreateTime(date);
			tuserCreditService.saveTuserCredit(tuserCredit);
			//t_userFunds表
			TUserFunds tuserFunds=tuserFundsService.getfundsCredit(tuserID);
			String groupId =tuserFunds.getUser().getGroupId();
			int creditOut =tuserFunds.getCreditOut();
			int creditIn =tuserFunds.getCreditIn();
			//1.out 2.in
			if("1".equals(groupId)){
				tuserFunds.setCreditOut(creditOut+5);
				tuserFundsService.update(tuserFunds);
			}else if("2".equals(groupId)){
				tuserFunds.setCreditIn(creditIn+5);
				tuserFundsService.update(tuserFunds);
			}

		}else if("1".equals(baseFlag)){
			//需要审核信誉度-5
			TUserSafe tUserSafe =tuserSafeService.getUserSafeByUserId(tuserID);
			TuserCredit tuserCredit =new TuserCredit();
			tuserCredit.setUserId(tuserID);
			tuserCredit.setTypeId(4);
			tuserCredit.setKeyId(tUserSafe.getSafeId());
			tuserCredit.setCreditAdd(-5);
			tuserCredit.setDescription("取消审核个人基本资料");
			Date date =new Date();
			tuserCredit.setCreateTime(date);
			tuserCreditService.saveTuserCredit(tuserCredit);
			//t_userFunds表
			TUserFunds tuserFunds=tuserFundsService.getfundsCredit(tuserID);
			String groupId =tuserFunds.getUser().getGroupId();
			int creditOut =tuserFunds.getCreditOut();
			int creditIn =tuserFunds.getCreditIn();
			//1.out 2.in
			if("1".equals(groupId)){
				tuserFunds.setCreditOut(creditOut-5);
				tuserFundsService.update(tuserFunds);
			}else if("2".equals(groupId)){
				tuserFunds.setCreditIn(creditIn-5);
				tuserFundsService.update(tuserFunds);

			}
		}

		System.out.println("tuserID----------"+tuserID);
		SysUser sessionUser = (SysUser) ContextUtil.getCurrentUser();
		if(sessionUser == null){
			return "请先登录再提交";
		}
		
		long userId = sessionUser.getUserId(); //后台管理员用户
		System.out.println("userId----------"+userId);
		//修改前台会员t_user表
		TUser user = userInfoService.getUserByUserId(tuserID);
		user.setSchool(school);
		user.setUserId(tuserID);
		user.setEdu(edu);
		user.setGender(gender);
		user.setRealName(realName);
		user.setChecker(userId);
		userInfoService.editUserInfo(user);	
		request.getSession().setAttribute("user", user);
		
		//修改用户个人资料表
		TUserSafe userSafe = new TUserSafe();
		userSafe.setUserId(tuserID);
		userSafe.setMobile(mobile);
		userSafe.setIdNo(idNo);
		userSafe.setQqNo(qqNo);
		//userSafe.setBindMobile((short) 0);
		//如果是点击保存修改按钮，则不修改审核状态
		if(!"0".equals(baseFlag)){
			userSafe.setStatusID(baseFlag);
			userSafe.setCheckTime(new Date());
		}
		//由于数据库绑定信息字段默认为0，在此保证绑定信息不变
		TUserSafe userSafe2 = new TUserSafe();
		userSafe2 = tuserSafeService.getUserSafeByUserId(tuserID);
		if(null != userSafe2){
			userSafe.setBindEmail(userSafe2.getBindEmail());
			userSafe.setBindIdNo(userSafe2.getBindIdNo());
			userSafe.setBindMobile(userSafe2.getBindMobile());
			userSafe.setA1(userSafe2.getA1());
			userSafe.setA2(userSafe2.getA2());
			userSafe.setA3(userSafe2.getA3());
			userSafe.setQ1(userSafe2.getQ1());
			userSafe.setQ2(userSafe2.getQ2());
			userSafe.setQ3(userSafe2.getQ3());
			userSafe.setOutDate(userSafe2.getOutDate());
			userSafe.setValidataKey(userSafe2.getValidataKey());
		}
		
		userInfoService.editUserInfo(userSafe);

		//PrintWriter out = response.getWriter();
		//out.print("添加成功");

		return "0";
	}

	@RequestMapping({ "editFamilyInfo" })
	@ Action( description = "编辑会员家庭信息" )
	@ResponseBody
	public String editFamilyInfo(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		long tuserID = Long.parseLong(request.getParameter("tuserID")); //前台会员
		String marriage = request.getParameter("marriage");   //婚姻状况
		String fHouse = request.getParameter("fHouse");       //住宅状况
		String FProvincesId = request.getParameter("FProvincesId");    //省份
		String FCityId = request.getParameter("FCityId");    //市
		String FAreaId = request.getParameter("FAreaId");    //区，县
		String FAddress = request.getParameter("FAddress");   //住宅地址
		String phone = request.getParameter("phone");
		String liveYears = request.getParameter("liveYears");
		String isBuyCar = request.getParameter("isBuyCar");
		String fisCarLoan = request.getParameter("fisCarLoan");
		String fisHouseLoan = request.getParameter("fisHouseLoan");
		String familyFlag = request.getParameter("familyFlag");
		
		//信誉度
		if("2".equals(familyFlag)){
			TUserFamily tUserFamily=tuserFamilyService.queryTUserFamilyByuserId(Long.toString(tuserID));
			TuserCredit tuserCredit =new TuserCredit();
			tuserCredit.setUserId(tuserID);
			tuserCredit.setTypeId(4);
			tuserCredit.setKeyId(tUserFamily.getFamilyId());
			tuserCredit.setCreditAdd(5);
			tuserCredit.setDescription("审核通过个人家庭资料");
			Date date =new Date();
			tuserCredit.setCreateTime(date);
			tuserCreditService.saveTuserCredit(tuserCredit);
			//t_userFunds表
			TUserFunds tuserFunds=tuserFundsService.getfundsCredit(tuserID);
			String groupId =tuserFunds.getUser().getGroupId();
			int creditOut =tuserFunds.getCreditOut();
			int creditIn =tuserFunds.getCreditIn();
			//1.out 2.in
			if("1".equals(groupId)){
				tuserFunds.setCreditOut(creditOut+5);
				tuserFundsService.update(tuserFunds);
			}else if("2".equals(groupId)){
				tuserFunds.setCreditIn(creditIn+5);
				tuserFundsService.update(tuserFunds);
			}

		}else if("1".equals(familyFlag)){
			TUserFamily tUserFamily=tuserFamilyService.queryTUserFamilyByuserId(Long.toString(tuserID));
			TuserCredit tuserCredit =new TuserCredit();
			tuserCredit.setUserId(tuserID);
			tuserCredit.setTypeId(4);
			tuserCredit.setKeyId(tUserFamily.getFamilyId());
			tuserCredit.setCreditAdd(-5);
			tuserCredit.setDescription("取消审核个人家庭资料");
			Date date =new Date();
			tuserCredit.setCreateTime(date);
			tuserCreditService.saveTuserCredit(tuserCredit);
			//t_userFunds表
			TUserFunds tuserFunds=tuserFundsService.getfundsCredit(tuserID);
			String groupId =tuserFunds.getUser().getGroupId();
			int creditOut =tuserFunds.getCreditOut();
			int creditIn =tuserFunds.getCreditIn();
			//1.out 2.in
			if("1".equals(groupId)){
				tuserFunds.setCreditOut(creditOut-5);
				tuserFundsService.update(tuserFunds);
			}else if("2".equals(groupId)){
				tuserFunds.setCreditIn(creditIn-5);
				tuserFundsService.update(tuserFunds);
			}

		}


		System.out.println("tuserID----------"+tuserID);
		SysUser sessionUser = (SysUser) ContextUtil.getCurrentUser();
		if(sessionUser == null){
			return "请先登录再提交";
		}
		
		long userId = sessionUser.getUserId(); //后台管理员用户
		System.out.println("userId----------"+userId);
		System.out.println(familyFlag);
		//修改用户家庭信息
		TUserFamily userFamily = new TUserFamily();
		userFamily.setUserId(tuserID);
		userFamily.setFMarriage(marriage);
		userFamily.setFHouse(fHouse);
		userFamily.setFProvincesId(FProvincesId);
		userFamily.setFCityId(FCityId);
		userFamily.setFAreaId(FAreaId);
		userFamily.setFAddress(FAddress);
		userFamily.setFPhone(phone);
		userFamily.setFLiveYears(liveYears);
		userFamily.setFIsBuyCar(isBuyCar);
		userFamily.setFUpdateTime(new Date());
		userFamily.setFisCarLoan(Short.valueOf(fisCarLoan));
		userFamily.setFisHouseLoan(Short.valueOf(fisHouseLoan));
		//如果是点击保存修改按钮，则不修改审核状态
		if(!"0".equals(familyFlag)){
			userFamily.setStatusID(familyFlag);
			//userFamily.setCheckTime(new Date());
		}
		userInfoService.editUserInfo(userFamily);
		
		//修改前台会员t_user表
		TUser user = userInfoService.getUserByUserId(tuserID);
		user.setUserId(tuserID);
		user.setChecker(userId);
		userInfoService.editUserInfo(user);	
		request.getSession().setAttribute("user", user);

		//PrintWriter out = response.getWriter();
		//out.print("添加成功");
		return "0";
	}

	@RequestMapping({ "editContactInfo" })
	@ Action( description = "编辑会员联系信息" )
	@ResponseBody
	public String editContactInfo(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		long tuserID = Long.parseLong(request.getParameter("tuserID")); //前台会员
		String cName = request.getParameter("cName");
		String cRelation = request.getParameter("cRelation");
		String cMobile = request.getParameter("cMobile");
		String cOtherName = request.getParameter("cOtherName");
		String cOtherRelation = request.getParameter("cOtherRelation");
		String cOtherMobile = request.getParameter("cOtherMobile");
		String contactFlag = request.getParameter("contactFlag");
		
		//信誉度
		if("2".equals(contactFlag)){
			TUserContact tUserContact =tuserContactService.queryTUserContactByuserId(Long.toString(tuserID));
			TuserCredit tuserCredit =new TuserCredit();
			tuserCredit.setUserId(tuserID);
			tuserCredit.setTypeId(4);
			tuserCredit.setKeyId(tUserContact.getContactId());
			tuserCredit.setCreditAdd(5);
			tuserCredit.setDescription("审核通过个人联系资料");
			Date date =new Date();
			tuserCredit.setCreateTime(date);
			tuserCreditService.saveTuserCredit(tuserCredit);
			//t_userFunds表
			TUserFunds tuserFunds=tuserFundsService.getfundsCredit(tuserID);
			String groupId =tuserFunds.getUser().getGroupId();
			int creditOut =tuserFunds.getCreditOut();
			int creditIn =tuserFunds.getCreditIn();
			//1.out 2.in
			if("1".equals(groupId)){
				tuserFunds.setCreditOut(creditOut+5);
				tuserFundsService.update(tuserFunds);
			}else if("2".equals(groupId)){
				tuserFunds.setCreditIn(creditIn+5);
				tuserFundsService.update(tuserFunds);
			}

		}else if("1".equals(contactFlag)){
			TUserContact tUserContact =tuserContactService.queryTUserContactByuserId(Long.toString(tuserID));
			TuserCredit tuserCredit =new TuserCredit();
			tuserCredit.setUserId(tuserID);
			tuserCredit.setTypeId(4);
			tuserCredit.setKeyId(tUserContact.getContactId());
			tuserCredit.setCreditAdd(-5);
			tuserCredit.setDescription("取消审核个人联系资料");
			Date date =new Date();
			tuserCredit.setCreateTime(date);
			tuserCreditService.saveTuserCredit(tuserCredit);
			//t_userFunds表
			TUserFunds tuserFunds=tuserFundsService.getfundsCredit(tuserID);
			String groupId =tuserFunds.getUser().getGroupId();
			int creditOut =tuserFunds.getCreditOut();
			int creditIn =tuserFunds.getCreditIn();
			//1.out 2.in
			if("1".equals(groupId)){
				tuserFunds.setCreditOut(creditOut-5);
				tuserFundsService.update(tuserFunds);
			}else if("2".equals(groupId)){
				tuserFunds.setCreditIn(creditIn-5);
				tuserFundsService.update(tuserFunds);
			}

		}


		System.out.println("tuserID----------"+tuserID);
		SysUser sessionUser = (SysUser) ContextUtil.getCurrentUser();
		if(sessionUser == null){
			return "请先登录再提交";
		}
		
		long userId = sessionUser.getUserId(); //后台管理员用户
		System.out.println("userId----------"+userId);
		System.out.println(contactFlag);
		//修改用户联系信息
		TUserContact userContact = new TUserContact();
		userContact.setUserId(tuserID);
		userContact.setCName(cName);
		userContact.setCRelation(cRelation);
		userContact.setCMobile(cMobile);
		userContact.setCOtherName(cOtherName);
		userContact.setCOtherRelation(cOtherRelation);
		userContact.setCOtherMobile(cOtherMobile);
		//如果是点击保存修改按钮，则不修改审核状态
		if(!"0".equals(contactFlag)){
			userContact.setStatusID(contactFlag);
			userContact.setCheckTime(new Date());
		}
		userInfoService.editUserInfo(userContact);
		
		//修改前台会员t_user表
		TUser user = userInfoService.getUserByUserId(tuserID);
		user.setUserId(tuserID);
		user.setChecker(userId);
		userInfoService.editUserInfo(user);	
		request.getSession().setAttribute("user", user);

		return "0";
	}

	@RequestMapping({ "editCompanyInfo" })
	@ Action( description = "编辑会员单位信息" )
	@ResponseBody
	public String editCompanyInfo(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		long tuserID = Long.parseLong(request.getParameter("tuserID")); //前台会员
		String jobsStatus = request.getParameter("jobsStatus")==null?"":request.getParameter("jobsStatus");
		String incomePayWay = request.getParameter("incomePayWay")==null?"":request.getParameter("incomePayWay");
		String nature = request.getParameter("nature")==null?"":request.getParameter("nature");
		String workYears = request.getParameter("workYears")==null?"":request.getParameter("workYears");
		String companyName = request.getParameter("companyName")==null?"":request.getParameter("companyName");
		String deptName = request.getParameter("deptName")==null?"":request.getParameter("deptName");
		String companyAddress = request.getParameter("companyAddress")==null?"":request.getParameter("companyAddress");
		String companyPhone = request.getParameter("companyPhone")==null?"":request.getParameter("companyPhone");
		String cPost = request.getParameter("CPost")==null?"":request.getParameter("CPost");
		String cIncomeScope = request.getParameter("CIncomeScope")==null?"":request.getParameter("CIncomeScope");
		String cSize = request.getParameter("cSize")==null?"":request.getParameter("cSize");
		String cIndustry = request.getParameter("CIndustry")==null?"":request.getParameter("CIndustry");
		String cAreaid = request.getParameter("CAreaid")==null?"":request.getParameter("CAreaid");
		String companyFlag = request.getParameter("companyFlag")==null?"":request.getParameter("companyFlag");

		//信誉度
		if("2".equals(companyFlag)){
			TUserCompany tUserCompany =tuserCompanyService.queryTUserCompanyByuserId(Long.toString(tuserID));
			TuserCredit tuserCredit =new TuserCredit();
			tuserCredit.setUserId(tuserID);
			tuserCredit.setTypeId(4);
			tuserCredit.setKeyId(tUserCompany.getCompanyId());
			tuserCredit.setCreditAdd(-5);
			tuserCredit.setDescription("审核通过个人公司资料");
			Date date =new Date();
			tuserCredit.setCreateTime(date);
			tuserCreditService.saveTuserCredit(tuserCredit);
			//t_userFunds表
			TUserFunds tuserFunds=tuserFundsService.getfundsCredit(tuserID);
			String groupId =tuserFunds.getUser().getGroupId();
			int creditOut =tuserFunds.getCreditOut();
			int creditIn =tuserFunds.getCreditIn();
			//1.out 2.in
			if("1".equals(groupId)){
				tuserFunds.setCreditOut(creditOut+5);
				tuserFundsService.update(tuserFunds);
			}else if("2".equals(groupId)){
				tuserFunds.setCreditIn(creditIn+5);
				tuserFundsService.update(tuserFunds);
			}
		}else if("1".equals(companyFlag)){
			TUserCompany tUserCompany =tuserCompanyService.queryTUserCompanyByuserId(Long.toString(tuserID));
			TuserCredit tuserCredit =new TuserCredit();
			tuserCredit.setUserId(tuserID);
			tuserCredit.setTypeId(4);
			tuserCredit.setKeyId(tUserCompany.getCompanyId());
			tuserCredit.setCreditAdd(-5);
			tuserCredit.setDescription("取消审核个人公司资料");
			Date date =new Date();
			tuserCredit.setCreateTime(date);
			tuserCreditService.saveTuserCredit(tuserCredit);
			//t_userFunds表
			TUserFunds tuserFunds=tuserFundsService.getfundsCredit(tuserID);
			String groupId =tuserFunds.getUser().getGroupId();
			int creditOut =tuserFunds.getCreditOut();
			int creditIn =tuserFunds.getCreditIn();
			//1.out 2.in
			if("1".equals(groupId)){
				tuserFunds.setCreditOut(creditOut-5);
				tuserFundsService.update(tuserFunds);
			}else if("2".equals(groupId)){
				tuserFunds.setCreditIn(creditIn-5);
				tuserFundsService.update(tuserFunds);
			}

		}

		System.out.println("tuserID----------"+tuserID);
		SysUser sessionUser = (SysUser) ContextUtil.getCurrentUser();
		if(sessionUser == null){
			return "请先登录再提交";
		}
		
		long userId = sessionUser.getUserId(); //后台管理员用户
		System.out.println("userId----------"+userId);
		System.out.println(companyFlag);

		TUserCompany userCompany = new TUserCompany();
		userCompany.setUserId(tuserID);
		userCompany.setCJobsStatus(jobsStatus);
		userCompany.setCIncomePayWay(incomePayWay);
		userCompany.setCNature(nature);
		userCompany.setCWorkYears(workYears);
		userCompany.setCName(companyName);
		userCompany.setCDeptName(deptName);
		userCompany.setCAddress(companyAddress);
		userCompany.setCPhone(companyPhone);
		userCompany.setCPost(cPost);
		userCompany.setCIncomeScope(cIncomeScope);
		userCompany.setcSize(cSize);
		userCompany.setCIndustry(cIndustry);
		userCompany.setCAreaid(cAreaid);
		userCompany.setCUpdateTime(new Date());
		//如果是点击保存修改按钮，则不修改审核状态
		if(!"0".equals(companyFlag)){
			userCompany.setStatusID(companyFlag);
			userCompany.setCheckTime(new Date());
		}
		userInfoService.editUserInfo(userCompany);

		//修改前台会员t_user表
		TUser user = userInfoService.getUserByUserId(tuserID);
		user.setUserId(tuserID);
		user.setChecker(userId);
		userInfoService.editUserInfo(user);	
		request.getSession().setAttribute("user", user);
		
		return "0";
	}
	
	
	/**
	 * jq验证框架  验证身份证是否唯一
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "validateidNo" })
	public void validateidNo(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("UTF-8");
		String idNo = request.getParameter("idNo");
		String id = request.getParameter("id");
		//TUser user = getSessionUser(request);
		
		TUserSafe userSafe = tuserSafeService.getById(Long.valueOf(id));
		
		Boolean tag = tuserSafeService.existIdNo(idNo);
		if(userSafe.getIdNo().equals(idNo)){
			tag = false;
		}
		
		PrintWriter out = response.getWriter();
		if (tag) {
			out.print("false");
		}else{
			out.print("true");
		}
		

	}
	
	/**
	 * jq验证框架  验证手机号码是否唯一
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "validatePhone" })
	public void validatePhone(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("UTF-8");
		String mobile = request.getParameter("mobile");
		String id = request.getParameter("id");
		//TUser user = getSessionUser(request);
		
		TUserSafe userSafe = tuserSafeService.getById(Long.valueOf(id));
		
		Boolean tag = tuserSafeService.existPhone(mobile);
		if(userSafe.getMobile().equals(mobile)){
			tag = false;
		}
		
		PrintWriter out = response.getWriter();
		if (tag) {
			out.print("false");
		}else{
			out.print("true");
		}
		

	}
	
	/**
	 * jq验证框架  验证手机号码是否唯一
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping({ "validateEmail" })
	public void validateEmail(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("UTF-8");
		String email = request.getParameter("email");
		String id = request.getParameter("id");
		//TUser user = getSessionUser(request);
		
		TUserSafe userSafe = tuserSafeService.getById(Long.valueOf(id));
		
		Boolean tag = tuserSafeService.existEmail(email);
		if(userSafe.getEmail().equals(email)){
			tag = false;
		}
		
		PrintWriter out = response.getWriter();
		if (tag) {
			out.print("false");
		}else{
			out.print("true");
		}
		

	}
	
}

