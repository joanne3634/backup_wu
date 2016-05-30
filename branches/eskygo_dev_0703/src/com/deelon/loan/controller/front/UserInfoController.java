package com.deelon.loan.controller.front;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.crowdfunding.common.util.TAreaUtil;
import com.deelon.crowdfunding.common.util.TUserUtil;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserAuditMat;
import com.deelon.loan.model.front.TUserAuditMatUpload;
import com.deelon.loan.model.front.TUserCompany;
import com.deelon.loan.model.front.TUserContact;
import com.deelon.loan.model.front.TUserFamily;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.model.front.Tarea;
import com.deelon.loan.model.front.TuserCredit;
import com.deelon.loan.model.sysManager.Tauditmaterials;
import com.deelon.loan.service.front.TUserAuditMatService;
import com.deelon.loan.service.front.TUserAuditMatUploadService;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TuserCompanyService;
import com.deelon.loan.service.front.TuserContactService;
import com.deelon.loan.service.front.TuserCreditService;
import com.deelon.loan.service.front.TuserFamilyService;
import com.deelon.loan.service.front.TuserSafeService;
import com.deelon.loan.service.front.UserInfoService;
import com.deelon.loan.service.sysManager.TauditmaterialsService;
import com.deelon.loan.service.sysManager.TuserFundsService;
import com.deelon.platform.model.system.SysAuditModelType;


@Controller
@RequestMapping({ "/user/" })
@Action(ownermodel = SysAuditModelType.USER_MANAGEMENT)
public class UserInfoController extends BaseController{

	@Autowired
	private UserInfoService userInfoService;
	
	@Autowired
	private TauditmaterialsService tauditmaterialsService;
	
	@Autowired
	private TUserAuditMatService tUserAuditMatService;
	
	@Autowired
	private TUserAuditMatUploadService tUserAuditMatUploadService;
	
	@Autowired
	private TAreaUtil tareaUtil;
	//信誉度添加记录
	@Autowired
	private TuserCreditService tuserCreditService;
	@Autowired
	private TuserSafeService tuserSafeService;
	@Autowired
	private TuserFamilyService tuserFamilyService;
	@Autowired
	private TuserContactService tuserContactService;
	@Autowired
	private TuserCompanyService tuserCompanyService;
	@Autowired
	private TuserFundsService tuserFundsService;
	
	private static Logger logger = LoggerFactory.getLogger(TUserService.class);
	
	//跳转到编辑个人资料
	@RequestMapping({ "editUserInfoInit" })
	public ModelAndView editUserInfoInit(HttpServletRequest request,
			HttpServletResponse response) {
		TUser sessionUser = (TUser) request.getSession().getAttribute("user");
		if(sessionUser == null){
			return new ModelAndView("/loginWeb.jsp");
		}
		
		TUserSafe userSafe = userInfoService.getUserSafe(sessionUser.getUserId());
		TUserFamily userFamily = userInfoService.getUserFamilyByUserId(sessionUser.getUserId());
		TUserCompany userCompany = userInfoService.getUserCompanyByUserId(sessionUser.getUserId());
		TUserContact userContact = userInfoService.getUserContactByUserId(sessionUser.getUserId());
		

		//获取最高等级级联
		List<Tarea> list = tareaUtil.getAreaByParentId(1);
		
		
		return new ModelAndView("/loan/front/editUserInfo.jsp").addObject("userSafe", userSafe).addObject("userFamily", userFamily).addObject("userCompany", userCompany).addObject("userContact", userContact).addObject("user", sessionUser).addObject("list", list);
	}
	//获取级联省市
	@RequestMapping({ "ajaxGetJilian" })
	@ResponseBody
	public void ajaxGetJilian(HttpServletRequest request,
			HttpServletResponse response, 	@RequestParam("areaId") Long areaId) throws IOException {

		List<Tarea> list = tareaUtil.getAreaByParentId(areaId);
		
		this.writeObjectToClient(list, response);
	}
	
	//编辑会员基本信息
	@RequestMapping({ "editBaseInfo" })
	@ResponseBody
	public String editBaseInfo(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String realName = request.getParameter("realName");
		String gender = request.getParameter("gender");
		String mobile = request.getParameter("mobile");
		String qqNo = request.getParameter("qqNo");
		String edu = request.getParameter("edu");
		String idNo = request.getParameter("idNo");
		String school = request.getParameter("school");

		TUser sessionUser = (TUser) request.getSession().getAttribute("user");
		if(sessionUser == null){
			logger.info("登录已失效，");
		}
		
		long userId = sessionUser.getUserId();

		TUser user = userInfoService.getUserByUserId(userId);
		user.setSchool(school);
		user.setUserId(userId);
		user.setEdu(edu);
		user.setGender(gender);
		user.setRealName(realName);
		userInfoService.editUserInfo(user);	
		request.getSession().setAttribute("user", user);
		

		TUserSafe userSafe = tuserSafeService.getUserSafeByUserId(userId);
		userSafe.setUserId(userId);
		userSafe.setMobile(mobile);
		userSafe.setIdNo(idNo);
		userSafe.setQqNo(qqNo);
		//userSafe.setBindMobile((short) 0);
		userSafe.setStatusID("1");//编辑资料后，将审核状态变为未审核
		userInfoService.editUserInfo(userSafe);

		//信誉度问题
		String status =request.getParameter("status");
		if("2".equals(status)){
		//在信誉记录表中有数据添加
			TUserSafe tUserSafe =tuserSafeService.getUserSafeByUserId(userId);
			TuserCredit tuserCredit =new TuserCredit();
			tuserCredit.setUserId(userId);
			tuserCredit.setTypeId(4);
			tuserCredit.setKeyId(tUserSafe.getSafeId());
			tuserCredit.setCreditAdd(-5);
			tuserCredit.setDescription("重新编辑个人基本资料");
			Date date =new Date();
			tuserCredit.setCreateTime(date);
			tuserCreditService.saveTuserCredit(tuserCredit);
			//t_userFunds表中添加信誉度
			TUserFunds tuserFunds=tuserFundsService.getfundsCredit(userId);
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

		//PrintWriter out = response.getWriter();
		//out.print("添加成功");

		return "0";
	}
	//编辑会员家庭情况
	@RequestMapping({ "editFamilyInfo" })
	@ResponseBody
	public String editFamilyInfo(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
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
		
		//System.out.println(marriage);
		//System.out.println(area);

		TUser sessionUser = (TUser) request.getSession().getAttribute("user");
		if(sessionUser == null){
			logger.info("登录已失效，");
			response.sendRedirect(request.getContextPath() + "/index-web.jsp"); //登录已失效，请重新登录
		}
		
		
		long userId = sessionUser.getUserId();
		TUserFamily userFamily = new TUserFamily();
		userFamily.setUserId(userId);
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
		userFamily.setStatusID("1");//编辑资料后，将审核状态变为未审核
		userInfoService.editUserInfo(userFamily);

		//信誉度问题
		String status =request.getParameter("status");
		if("2".equals(status)){
		//在信誉记录表中有数据添加
			TUserFamily tUserFamily=tuserFamilyService.queryTUserFamilyByuserId(Long.toString(userId));
			TuserCredit tuserCredit =new TuserCredit();
			tuserCredit.setUserId(userId);
			tuserCredit.setTypeId(4);
			tuserCredit.setKeyId(tUserFamily.getFamilyId());
			tuserCredit.setCreditAdd(-5);
			tuserCredit.setDescription("重新编辑个人家庭资料");
			Date date =new Date();
			tuserCredit.setCreateTime(date);
			tuserCreditService.saveTuserCredit(tuserCredit);
			//t_userFunds表中添加信誉度
			TUserFunds tuserFunds=tuserFundsService.getfundsCredit(userId);
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

		//PrintWriter out = response.getWriter();
		//out.print("添加成功");
		return "0";
	}
	//编辑会员联系方式
	@RequestMapping({ "editContactInfo" })
	@ResponseBody
	public String editContactInfo(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String cName = request.getParameter("cName");
		String cRelation = request.getParameter("cRelation");
		String cMobile = request.getParameter("cMobile");
		String cOtherName = request.getParameter("cOtherName");
		String cOtherRelation = request.getParameter("cOtherRelation");
		String cOtherMobile = request.getParameter("cOtherMobile");
		
		System.out.println(cName);
		System.out.println(cRelation);
		System.out.println(cMobile);
		System.out.println(cOtherName);
		System.out.println(cOtherMobile);
		System.out.println(cOtherRelation);

		TUser sessionUser = (TUser) request.getSession().getAttribute("user");
		if(sessionUser == null){
			logger.info("登录已失效，");
			response.sendRedirect(request.getContextPath() + "/index-web.jsp"); //登录已失效，请重新登录
		}
		long userId = sessionUser.getUserId();

		TUserContact userContact = new TUserContact();
		userContact.setUserId(userId);
		userContact.setCName(cName);
		userContact.setCRelation(cRelation);
		userContact.setCMobile(cMobile);
		userContact.setCOtherName(cOtherName);
		userContact.setCOtherRelation(cOtherRelation);
		userContact.setCOtherMobile(cOtherMobile);
		userContact.setStatusID("1");//编辑资料后，将审核状态变为未审核
		userInfoService.editUserInfo(userContact);

		//信誉度问题
		String status =request.getParameter("status");
		if("2".equals(status)){
		//在信誉记录表中有数据添加
			TUserContact tUserContact =tuserContactService.queryTUserContactByuserId(Long.toString(userId));
			TuserCredit tuserCredit =new TuserCredit();
			tuserCredit.setUserId(userId);
			tuserCredit.setTypeId(4);
			tuserCredit.setKeyId(tUserContact.getContactId());
			tuserCredit.setCreditAdd(-5);
			tuserCredit.setDescription("重新编辑个人联系资料");
			Date date =new Date();
			tuserCredit.setCreateTime(date);
			tuserCreditService.saveTuserCredit(tuserCredit);
			//t_userFunds表中添加信誉度
			TUserFunds tuserFunds=tuserFundsService.getfundsCredit(userId);
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

		//PrintWriter out = response.getWriter();
		//out.print("添加成功");

		return "0";
	}
	//编辑会员单位情况
	@RequestMapping({ "editCompanyInfo" })
	@ResponseBody
	public String editCompanyInfo(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String jobsStatus = request.getParameter("jobsStatus");
		String incomePayWay = request.getParameter("incomePayWay");
		String nature = request.getParameter("nature");
		String workYears = request.getParameter("workYears");
		String companyName = request.getParameter("companyName");
		String deptName = request.getParameter("deptName");
		String companyAddress = request.getParameter("companyAddress");
		String companyPhone = request.getParameter("companyPhone");
		String cPost = request.getParameter("CPost");
		String cIncomeScope = request.getParameter("CIncomeScope");
		String cSize = request.getParameter("cSize");
		String cIndustry = request.getParameter("CIndustry");
		String cAreaid = request.getParameter("CAreaid");
		
		TUser sessionUser = (TUser) request.getSession().getAttribute("user");
		if(sessionUser == null){
			logger.info("登录已失效，");
			response.sendRedirect(request.getContextPath() + "/index-web.jsp"); //登录已失效，请重新登录
		}
		long userId = sessionUser.getUserId();

		TUserCompany userCompany = new TUserCompany();
		userCompany.setUserId(userId);
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
		userCompany.setStatusID("1");//编辑资料后，将审核状态变为未审核
		
		userInfoService.editUserInfo(userCompany);

		//信誉度问题
		String status =request.getParameter("status");
		if("2".equals(status)){
		//在信誉记录表中有数据添加
			TUserCompany tUserCompany =tuserCompanyService.queryTUserCompanyByuserId(Long.toString(userId));
			TuserCredit tuserCredit =new TuserCredit();
			tuserCredit.setUserId(userId);
			tuserCredit.setTypeId(4);
			tuserCredit.setKeyId(tUserCompany.getCompanyId());
			tuserCredit.setCreditAdd(-5);
			tuserCredit.setDescription("重新编辑个人公司资料");
			Date date =new Date();
			tuserCredit.setCreateTime(date);
			tuserCreditService.saveTuserCredit(tuserCredit);
			//t_userFunds表中添加信誉度
			TUserFunds tuserFunds=tuserFundsService.getfundsCredit(userId);
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

		//PrintWriter out = response.getWriter();
		//out.print("添加成功");
		return "0";
	}
	/**
	 * 新用户认证资料
	 * @param request
	 * @return
	 */
	@RequestMapping({ "xyhrzziliaoInfo" })
	public ModelAndView xyhrzziliaoInfo(HttpServletRequest request,
			HttpServletResponse response) {

		return new ModelAndView("/loan/front/xinyonghurenzhengziliao.jsp");
	}
	
	/**
	 * 上传资料
	 * @param request
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping({ "uploadInfo" })
	public ModelAndView uploadInfo(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		TUser user = TUserUtil.getLogUser(request);
		
		String groupId = user.getGroupId(); 
		if(user == null){
			response.sendRedirect(request.getContextPath() + "/index-web.jsp");
		}
		
		List<Tauditmaterials> tlist = tauditmaterialsService.getAll();
		for (int i = 0; i < tlist.size(); i++) {//user.getUserId(), tlist.get(i).getMaterialsId()
			QueryFilter query = new QueryFilter(request);
			query.addFilter("userId", user.getUserId());
			query.addFilter("materialsId", tlist.get(i).getMaterialsId());
			List list = tUserAuditMatService.getAll(query);
			TUserAuditMat ta = null;
			if(list.size() > 0){
				ta = (TUserAuditMat) list.get(0);
			}
			if(ta != null){
				tlist.get(i).setReasons(ta.getReasons());
				tlist.get(i).setIsPass(ta.getIsPass());
				List<TUserAuditMatUpload> tmlist = tUserAuditMatUploadService.getUserAuditMatUploadByUserAndauditMatId(user.getUserId(), ta.getAuditMatId());
				if(tmlist.size() > 0 ){
					tlist.get(i).setCount(tmlist.size());
					tlist.get(i).setLastTime(tmlist.get(0).getUploadTime());
				}
			}
		}
		
		return new ModelAndView("/loan/front/uploadInfo.jsp").addObject("tlist", tlist).addObject("groupId", groupId);
	}
	/**
	 * 获取Session中的用户信息(判断是否登录超时)
	 * @param request
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping({ "valiLoginTimeout" })
	public void valiLoginTimeout(HttpServletRequest request,HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		if( TUserUtil.getLogUser(request) == null){
			out.print(false);
		}else{
			out.print(true);
		}
	}
	
	
}
