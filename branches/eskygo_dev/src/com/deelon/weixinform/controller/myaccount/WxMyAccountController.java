package com.deelon.weixinform.controller.myaccount;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.page.PageBean;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TMoneymove;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.model.front.TProjectInvest;
import com.deelon.loan.model.front.TTask;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.model.front.TuserTaskcomplete;
import com.deelon.loan.service.front.TmoneymoveService;
import com.deelon.loan.service.front.TprojectInvestService;
import com.deelon.loan.service.front.TuserSafeService;
import com.deelon.loan.service.front.TuserTaskcompleteService;
import com.deelon.loan.service.sysManager.TprojectService;
import com.deelon.loan.service.sysManager.TtaskService;
import com.deelon.loan.service.sysManager.TuserFundsService;
import com.deelon.platform.util.ParamHelper;

/**
 * 我的账户
 * @author qin
 *
 */
@Controller
@RequestMapping({"/weixin/wxmyaccount/"})
public class WxMyAccountController {
	
	@Resource
	private TuserFundsService tuserFundsService;
	@Resource
	private TtaskService ttaskService;
	@Resource
	private TprojectService tprojectService;
	@Resource
	private TuserTaskcompleteService userTaskcompleteService; 
	@Autowired
	private TuserSafeService tuserSafeService;
	@Autowired
	private TmoneymoveService tmoneymoveService;
	
	@Resource
	private TprojectInvestService tprojecInvestService;
	
	/**
	 * 跳转到我的账户界面
	 * @return
	 */
	@RequestMapping({ "wxmyaccountPage" })
	public ModelAndView wxmyaccountPage(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			TUser u=(TUser)request.getSession().getAttribute("user");
			if(null == u){
				response.sendRedirect(request.getContextPath() + "/loginWeixin.jsp");
				return null;
			}
			TUserFunds sf=tuserFundsService.getTUserFundsByUserId(u.getUserId());
			String filePath="";
			
			//账户资产
			TUserFunds usf=tuserFundsService.getPersonalAssetsByUserId(u.getUserId());
			List<TProject> listVo=null;
			List<TProject> listVo1=null;
			if(StringUtil.isNotEmpty(u.getGroupId())){
				if(u.getGroupId().equals("2")||u.getGroupId().equals("3")){
					//理财账户
					float payMoney=0;
					
					listVo=tprojectService.getPersonalFinanceByUserId(u.getUserId());
					if(listVo!=null&&listVo.size()>0){
						for (TProject t : listVo) {
							if(t.getPieffectAmountTotal()!=null){
								
								t.setPieffectAmountTotal(t.getPieffectAmountTotal().setScale(2, BigDecimal.ROUND_HALF_UP));
							}else{
								t.setPieffectAmountTotal(new BigDecimal(0.00));
							}
							if(t.getPsumHavedPayInterestTotal()!=null){
								
								t.setPsumHavedPayInterestTotal(t.getPsumHavedPayInterestTotal().setScale(2, BigDecimal.ROUND_HALF_UP));
							}else{
								t.setPsumHavedPayInterestTotal(new BigDecimal(0.00));
							}
//							payMoneyTotal.add(t.getPsumHavedPayInterestTotal());
							payMoney+=t.getPsumHavedPayInterestTotal().floatValue();
//							payMoney=payMoneyTotal;
//							t.setPayMoneyTotal(payMoneyTotal);
						}
					}
					BigDecimal payMoneyTotal=new BigDecimal(payMoney).setScale(2, BigDecimal.ROUND_HALF_UP) ;
					request.setAttribute("payMoneyTotal", payMoneyTotal);
				}else if(u.getGroupId().equals("1")||u.getGroupId().equals("3")){
					//借款账户
					 listVo1=tprojectService.getPersnalLoanByUserId(u.getUserId());
					float payMoney1=0;
					
					if(listVo1!=null&&listVo1.size()>0){
						for (TProject t : listVo1) {
							if(t.getPsumHavedPayTotal()!=null){
								t.setPsumHavedPayTotal(t.getPsumHavedPayTotal().setScale(2, BigDecimal.ROUND_HALF_UP));
							}else{
								t.setPsumHavedPayTotal(new BigDecimal(0.00));
							}
							if(t.getPsumHavedPayInterestTotal()!=null){
								
								t.setPsumHavedPayInterestTotal(t.getPsumHavedPayInterestTotal().setScale(2, BigDecimal.ROUND_HALF_UP));
							}else{
								t.setPsumHavedPayInterestTotal(new BigDecimal(0.00));
							}
							if(t.getPsumLateTotal()!=null){
								
								t.setPsumLateTotal(t.getPsumLateTotal().setScale(2, BigDecimal.ROUND_HALF_UP));
							}else{
								t.setPsumLateTotal(new BigDecimal(0.00));
							}
							payMoney1+=t.getPsumHavedPayTotal().add(t.getPsumHavedPayInterestTotal()).floatValue();
							
//							t.setPayMoneyTotal(payMoneyTotal);
						}
					}
					BigDecimal payMoneyTotal1=new BigDecimal(payMoney1).setScale(2, BigDecimal.ROUND_HALF_UP);
					request.setAttribute("payMoneyTotal1", payMoneyTotal1);
				}
			}
			
			List<TTask> tTask = ttaskService.getTaskByGroupId(Long.valueOf(u.getGroupId()),u.getUserId());  //根据角色获取角色任务
			int count = 0;
			for (TTask t :tTask) {
				TuserTaskcomplete tuserTaskcomplete = userTaskcompleteService.gettuserTaskcomplete(u.getUserId(),t.getTaskId());
				if(tuserTaskcomplete != null){
					t.setIsComplete(tuserTaskcomplete.getIsComplete());
				}else{
					t.setIsComplete(0);
					count++;   //累计未完成的任务
				}
		
				
			}
			//根据是否绑定手机 邮箱 身份证 和 交易密码来计算 安全等级的长度
			//总长度125 每绑定绑定一个 增加31.25个长度  百分比增加25%
			double safeLang=0.0;
			int safePercentum=0;
			if(sf!=null){
				if(StringUtil.isNotEmpty(sf.getBindCard())&&sf.getBindCard().equals("1")){//身份证
					safeLang+=31.25;
					safePercentum+=25;
				}
				if(StringUtil.isNotEmpty(sf.getBindEmail())&&sf.getBindEmail().equals("1")){//邮箱
					safeLang+=31.25;
					safePercentum+=25;
				}
				if(StringUtil.isNotEmpty(sf.getBindMobile())&&sf.getBindMobile().equals("1")){//手机
					safeLang+=31.25;
					safePercentum+=25;
				}
				if(StringUtil.isNotEmpty(sf.getTradingPwd())){//交易密码
					safeLang+=31.25;
					safePercentum+=25;
				}
				
				sf.setSafebar(safeLang+"");
				sf.setSafePercentum(safePercentum+"");
				
				sf.setBalance((sf.getAvailable().add(sf.getFreeze())));
			}else{
				sf=new TUserFunds();
				sf.setSafebar(safeLang+"");
				sf.setSafePercentum(safePercentum+"");
			}
			if(usf!=null){
				if(usf.getPiEffectAmountTotal()!=null){
					
					usf.setPiEffectAmountTotal(usf.getPiEffectAmountTotal().setScale(2, BigDecimal.ROUND_HALF_UP));
				}else{
					usf.setPiEffectAmountTotal(new BigDecimal(0.00));
				}
				if(usf.getPloanRealTotal()!=null){
					
					usf.setPloanRealTotal(usf.getPloanRealTotal().setScale(2, BigDecimal.ROUND_HALF_UP));
				}else{
					usf.setPloanRealTotal(new BigDecimal(0.00));
				}
				if(usf.getAvailable()!=null){
					
					usf.setAvailable(usf.getAvailable().setScale(2, BigDecimal.ROUND_HALF_UP));
				}else{
					usf.setAvailable(new BigDecimal(0.00));
				}
					usf.setBalance(usf.getPiEffectAmountTotal()
							.add(usf.getPloanRealTotal()).add(usf.getAvailable()));
//					usf.setAvailable(usf.getAvailable().add(usf.getFreeze()));
					
			}
			request.setAttribute("TUserFunds1", usf);
			
			//判断用户安全等级
			int currentUserSafeLevel = tuserSafeService.getUserSafeLevel(u);
			String level = "低";
			if(currentUserSafeLevel==2){
				level = "中";
			}else if(currentUserSafeLevel==3){
				level = "高";
			}
			
			TUserSafe tuserSafe = tuserSafeService.getUserSafeByUserId(u.getUserId());
			
			//进入我的账户，我的资料界面判断
			String dataMsg = request.getParameter("dataMsg");
			String jspUrl = "/weixinform/myaccount/myaccount.jsp";
			if(null != dataMsg && !"".equals(dataMsg)){
				jspUrl = "/weixinform/myaccount/mydata.jsp";
			}
			return new ModelAndView(jspUrl).addObject("TUserFunds", sf)
					.addObject("tTask", tTask).addObject("count", count).addObject("ListVo", listVo)
					.addObject("ListVo1", listVo1).addObject("TUser", u).addObject("level", level).addObject("tuserSafe", tuserSafe);//addObject("ImageId", sf.getFileId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 跳转到我的资料界面
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping({"myDataMsg"})
	public ModelAndView myDataMsg(HttpServletRequest request,HttpServletResponse response) throws Exception{
		TUser u=(TUser)request.getSession().getAttribute("user");
		if(null == u){
			response.sendRedirect(request.getContextPath() + "/loginWeixin.jsp");
			return null;
		}
		return new ModelAndView("/weixinform/myaccount/mydata.jsp").addObject("tuser", u);
	}
	
	/**
	 * 我的资产
	 * @return
	 */
	@RequestMapping("wxMyFunds")
	public ModelAndView wxMyFunds(HttpServletRequest request,HttpServletResponse response) throws Exception{
		TUser user = (TUser) request.getSession().getAttribute("user");
		
		if(null == user){
			response.sendRedirect(request.getContextPath() + "/loginWeixin.jsp");
			return null;
		}
		
		TUserFunds tUserFunds = null;
		if(user!=null){
			tUserFunds = tuserFundsService.getTUserFundsByUserId(user.getUserId());
		}
		int currentUserSafeLevel = tuserSafeService.getUserSafeLevel(user);
		String level = "低";
		if(currentUserSafeLevel==2){
			level = "中";
		}else if(currentUserSafeLevel==3){
			level = "高";
		}
		return new ModelAndView("weixinform/myaccount/myFunds.jsp").addObject("userFunds", tUserFunds).addObject("tUser", user).addObject("level", level);
	}
	/**
	 * 资产记录
	 * @param request
	 * @return
	 */
	@RequestMapping("myFundsRecord")
	public ModelAndView myFundsRecord(){		
		return new ModelAndView("weixinform/myaccount/myFundsrecord.jsp");
	}
	
	/**
	 * 分页查询资产变动记录
	 * @param request
	 * @return
	 */
	@RequestMapping(value="getMyFundsRecord",method=RequestMethod.POST)
	@ResponseBody
	public Object getMyFundsRecord(HttpServletRequest request){
		Map<String,Object> result = new HashMap<String,Object>();
		TUser user = (TUser) request.getSession().getAttribute("user");
		int recentDays = RequestUtil.getInt(request, "recentDays", 0);
		long userId = user==null?0:user.getUserId();
		QueryFilter queryFilter = new QueryFilter();
		queryFilter.addFilter("userId", userId); //用户
		queryFilter.addFilter("resultId", 1); //成功
		
		if(recentDays>0)	{
			Calendar cal = Calendar.getInstance();
			cal.set(Calendar.HOUR_OF_DAY, 0);
			cal.set(Calendar.MINUTE, 0);
			cal.set(Calendar.SECOND, 0);
			cal.add(Calendar.DAY_OF_MONTH, -recentDays);
			queryFilter.addFilter("createTimeBegin", cal.getTime());
		}
		
		int page = RequestUtil.getInt(request, "page", 1);
		int pageSize = RequestUtil.getInt(request, "pageSize", 10);
		
		PageBean bean = new PageBean(page,pageSize);
		queryFilter.setPageBean(bean);
		List<TMoneymove> list = tmoneymoveService.getAll(queryFilter);
		
		ParamHelper paramHelper = ParamHelper.getInstance();
		for(TMoneymove moneymove:list){
			String typeName = paramHelper.getDecItemName("zjld", moneymove.getTypeId());
			moneymove.setApplyName(typeName); //将入支类型名存在在applyName属性中
		}
		result.put("list", list);
		result.put("pageCount", bean.getTotalPage());
		return result;
	}
	
	/**
	 * 我的账户，项目状态，申请中，持有中，已转让，已结束
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getTProjectInvestByUserIdAndWhere")
	public ModelAndView getTProjectInvestByUserIdAndWhere(HttpServletRequest request, HttpServletResponse response) throws Exception{
		TUser u=(TUser)request.getSession().getAttribute("user");
		if(null == u){
			response.sendRedirect(request.getContextPath() + "/loginWeixin.jsp");
			return null;
		}
		
		String projectStatus = request.getParameter("projectStatus");
		String platform = request.getParameter("platform");//平台审核，0=未审核，1=已审核
		String havedPay = request.getParameter("havedPay");//平台放款，0=未放款，1=已放款
		String isPayOff = request.getParameter("isPayOff");//是否还清，0=未还清，1=已还清
		String transferStateID = request.getParameter("transferStateID");//转让状态，0未转让 1转让中 2成功 3失败
		
		QueryFilter queryFilter = new QueryFilter();
		queryFilter.addFilter("userId", u.getUserId());
		//projectStatus：0=申请中，1=持有中，2=已转让，3=已结束
		if("0".equals(projectStatus)){
			queryFilter.addFilter("P_Audit_Platform", platform);
			queryFilter.addFilter("P_HavedPay", havedPay);
		}else if("1".equals(projectStatus)){
			queryFilter.addFilter("P_HavedPay", havedPay);
			queryFilter.addFilter("PI_IsPayOff", isPayOff);
		}else if("2".equals(projectStatus)){
			queryFilter.addFilter("PI_TransferStateID", transferStateID);
		}else if("3".equals(projectStatus)){
			queryFilter.addFilter("PI_IsPayOff", isPayOff);
		}
		queryFilter.addFilter("P_Del", 0);//未删除
		queryFilter.addFilter("P_IsBreak", 0);//未流标
		List<TProjectInvest> tpojectInvestList = tprojecInvestService.getBySqlKeyAll(queryFilter, TProjectInvest.class, "getTProjectInvestByUserIdAndWhere");
		return new ModelAndView("/weixinform/myaccount/myInvest.jsp").addObject("tpojectInvestList", tpojectInvestList).addObject("projectStatus", projectStatus);
	}
	
	/**
	 * 跳转到认证准备界面
	 * @return
	 */
	@RequestMapping({"authentication"})
	public ModelAndView authentication(){
		return new ModelAndView("/weixinform/myaccount/prepare.jsp");
	}
}
