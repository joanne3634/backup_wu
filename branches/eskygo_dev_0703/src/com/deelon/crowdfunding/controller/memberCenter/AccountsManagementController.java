package com.deelon.crowdfunding.controller.memberCenter;

import com.deelon.core.annotion.Action;
import com.deelon.core.page.PageBean;
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.common.util.TUserUtil;
import com.deelon.crowdfunding.model.backstage.TcprojectInvest;
import com.deelon.crowdfunding.service.backstage.TcprojectInvestService;
import com.deelon.loan.common.TSettingParem;
import com.deelon.loan.model.backstage.TSettings;
import com.deelon.loan.model.front.*;
import com.deelon.loan.model.sysManager.Tbank;
import com.deelon.loan.service.backstage.TSettingsService;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TbankcardService;
import com.deelon.loan.service.front.TmoneymoveService;
import com.deelon.loan.service.front.TuserSafeService;
import com.deelon.loan.service.sysManager.TbankService;
import com.deelon.loan.service.sysManager.TuserFundsService;
import com.deelon.payform.common.PayCommon;
import com.deelon.payform.common.moneymoremore.PayCommonMoney;
import com.deelon.platform.model.system.Dictionary;
import com.deelon.platform.service.system.DictionaryService;
import com.fr.base.core.UUID;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;
/**
 * 会员中心  账户资金管理
 * @author Administrator
 *
 */
@Controller
@RequestMapping({ "/crowdfunding/memberCenter/" })
public class AccountsManagementController extends BaseController {
	
	@Resource
	private TUserService tuserService;
	@Resource
	private TuserFundsService tuserFundsService;
	@Resource
	private TmoneymoveService tmoneymoveService;
	@Resource
	private TbankcardService tbankcardService;
	@Resource
	private TcprojectInvestService tcprojectInvestService;
	@Autowired
	TbankService tbankService;
	@Autowired
	DictionaryService dictionaryService;
	@Resource
	private TSettingsService tsettingsService;
	@ Resource
	private TuserSafeService tuserSafeService;
	
	@RequestMapping({ "toPayRegisterPage" })
	@Action( description = "进入支付绑定页面" )
	public ModelAndView toPayRegisterPage(HttpServletRequest request,HttpServletResponse response) throws IOException {
		TUser tuser= TUserUtil.getLogUser(request);   
		if(null == tuser){
			try {
				response.sendRedirect(request.getContextPath()+"/loginWeb.jsp");
				return null;
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		TUserSafe userSafe = tuserSafeService.getUserSafeByUserId(tuser.getUserId());  //安全
		TUserFunds tuserFunds = tuserFundsService.getByUserId(tuser.getUserId()); //资金
		ModelAndView mv=	new ModelAndView("/crowdfunding/memberCenter/toPayRegisterPage.jsp");
		mv.addObject( "tuser", tuser ).addObject( "userSafe", userSafe).addObject( "tuserFunds", tuserFunds );
	 
			//注册第三方支付系统接口
			HashMap   hm=new HashMap();
			hm.put( "TUserSafe", userSafe );
			hm.put( "TUser", tuser );
			hm.put( "RegisterType","2" );//1表示全自动，2表示半自动全自动会生成随机的登录密码和支付密码发送到用户的手机，安保问题需要登录乾多多后台设置
			PayCommon.register( hm );   
			return mv.addObject( "hm", hm ).addObject( "hmData", hm.get( PayCommonMoney.payDataKey ) );
		
	}
	@RequestMapping({ "toRechargePage" })
	@Action( description = "进入账户充值页面" )
	public ModelAndView toRechargePage(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			//是否打开在线支付开关(1：打开)
			String openOnlinePayment = (String)AppUtil.getServletContext().getAttribute("INTERVIEWS_TIMESPAN");
			TUser u=TUserUtil.getLogUser(request);
			if(u==null){
				response.sendRedirect(request.getContextPath()+"/loginWeb.jsp");
				return null;
			}
			Long userId = u.getUserId();
			String flag = request.getParameter("flag");//如果flag=1表示账号单纯充值，提现按钮隐藏
			if(flag==null || "null".equals(flag))
				flag = "";
			//用户头像,账户余额,安全等级
			TUserFunds sf=tuserFundsService.getTUserFundsByUserId(userId);
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
				sf.setAvailable(sf.getAvailable().setScale(2, BigDecimal.ROUND_HALF_UP));
				sf.setFreeze(sf.getFreeze().setScale(2, BigDecimal.ROUND_HALF_UP));
				sf.setBalance(sf.getAvailable().add(sf.getFreeze()).setScale(2, BigDecimal.ROUND_HALF_UP));
			}else{
				sf=new TUserFunds();
				sf.setSafebar(safeLang+"");
				sf.setSafePercentum(safePercentum+"");
			}
			request.getSession().setAttribute("token", UUID.randomUUID().toString());
			String forwod = "";
			if(StringUtils.isNotEmpty(openOnlinePayment) && StringUtils.isNotBlank(openOnlinePayment)){
				return new ModelAndView("redirect:/crowdfunding/onlinePayment/rechargePage.ht?flag="+flag);
			}
			return new ModelAndView("/crowdfunding/memberCenter/recharge.jsp").addObject("TUserFunds", sf);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
		
	}
	
	@RequestMapping({ "toRechargeRecords" })
	@Action( description = "进入账户充值记录页面" )
	public ModelAndView toRechargeRecords(HttpServletRequest request,
			HttpServletResponse response) {
		Long userId = TUserUtil.getLogUser(request).getUserId();
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userId",userId);				
		map.put("typeId","1");//充值 
		
		//分页加参数
		int page = RequestUtil.getInt(request, "current_page", 1);
		int pageSize = RequestUtil.getInt(request, "pageSize",10);
		PageBean pb=new  PageBean(page, pageSize);
		
		List<TMoneymove> listvo=tmoneymoveService.getUserMoneyList(map, pb);
		
		if(listvo!=null&&listvo.size()>0){
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			for (TMoneymove m : listvo) {
				if(m.getCreateTime()!=null){
					m.setCreateTimeS(sdf.format(m.getCreateTime()));
				}
			}
		}
		request.setAttribute( "page_bean", pb );//分页参数传入页面
		request.setAttribute("listvo", listvo);
		return new ModelAndView("/crowdfunding/memberCenter/rechargeRecords.jsp");
	}
	
	@RequestMapping({ "toinvestList" })
	@Action( description = "进入资金明细查询页面" )
	public ModelAndView toinvestList(HttpServletRequest request,
			HttpServletResponse response,String selalltypeIds) {
		TUser u=(TUser)request.getSession().getAttribute("user");
		Long userId=u.getUserId();//当前用户id;
		TMoneymove tmoneymove =new TMoneymove();
		tmoneymove.setUserId(userId);//暂时
		List<Dictionary> zjld = new ArrayList<Dictionary>();
		//获取资金类型
		if(null != dictionaryService) {
			List<Dictionary> zjldlist = dictionaryService.getByNodeKey("zjld");
			if(null != zjldlist && zjldlist.size() >0){
				for(Dictionary data : zjldlist){
					//data.getItemName().equals("提现") 
					//|| data.getItemName().equals("充值") 
					//|| data.getItemName().equals("收益")
					//|| data.getItemName().equals("平台放款")
					//|| data.getItemName().contains("流标")
					if( data.getItemValue().equals("3") //投資
						|| data.getItemValue().equals("12") ) { // 誠意金 
						zjld.add(data);
						if(StringUtils.isEmpty(selalltypeIds)){
							selalltypeIds = "'"+data.getItemValue()+"'";
						}else{
							selalltypeIds += ",'"+data.getItemValue()+"'";
						}
					}
				}
			}
		}
		try {
			//已充值总额 ,已体现总额 这里统计 历史 的 充值 和体现 总额
			BigDecimal chargeMoneyTotal=new BigDecimal(0.0);
			BigDecimal drawMoneyTotal=new BigDecimal(0.0);
			TMoneymove tm=new TMoneymove();
			tm.setChargeMoneyTotal(chargeMoneyTotal);
			tm.setDrawMoneyTotal(drawMoneyTotal);
			
			//账户余额 ,可用资金,冻结资金
			TUserFunds sf=tuserFundsService.getTUserFundsByUserId(userId);//
			sf.setAvailable(sf.getAvailable().setScale(2, BigDecimal.ROUND_HALF_UP));
			sf.setFreeze(sf.getFreeze().setScale(2, BigDecimal.ROUND_HALF_UP));
			sf.setBalance(sf.getAvailable().add(sf.getFreeze()).setScale(2, BigDecimal.ROUND_HALF_UP));
			
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			//查询条件
			 		String typeId=request.getParameter("typeId");//
			 		if(StringUtils.isEmpty(typeId))
			 			typeId = selalltypeIds;//查询所有
					String timeBucket=request.getParameter("timeBucket");
					GregorianCalendar gc=new GregorianCalendar(); 
					Date tb=null;
					 if(StringUtil.isNotEmpty(timeBucket)){
						 gc.setTime(new Date());
						if(timeBucket.equals("1")){//1周内
							gc.add(3, -1);
							tb=gc.getTime();
						}else if(timeBucket.equals("2")){//2周内
							gc.add(3, -3);
							tb=gc.getTime();
						}else if(timeBucket.equals("3")){
							gc.add(2, -1);
							tb=gc.getTime();
						}else if(timeBucket.equals("4")){//
							gc.add(2, -2);
							tb=gc.getTime();
						}else if(timeBucket.equals("5")){
							gc.add(2, -3);
							tb=gc.getTime();
						}else if(timeBucket.equals("6")){
							gc.add(2, -6);
							tb=gc.getTime();
						}else if(timeBucket.equals("7")){
							gc.add(1, -1);
							tb=gc.getTime();
						}
					 }else{
						 tb=null;
					 }
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("userId", userId);  
			
			//查询条件
			if(StringUtil.isNotEmpty(typeId)){
				map.put("typeId", typeId);
			}
			if(StringUtil.isNotEmpty(timeBucket)){
				map.put("timeBucket", sdf.format(tb)+" 00:00:00");
			}
			map.put("currentDate", sdf.format(new Date()));
			
			//分页加参数
			int page = RequestUtil.getInt(request, "current_page", 1);//PageBean.getDefaultPageSize().intValue()
		    int pageSize = RequestUtil.getInt(request, "pageSize",10);
			PageBean pb=new  PageBean(page, pageSize);
			
			List<TMoneymove> listVo=tmoneymoveService.getUserMoneyList(map,pb);
			request.setAttribute( "page_bean", pb );//分页参数传入页面
			request.setAttribute( "typeId", typeId );
			request.setAttribute( "selectEd", timeBucket );
			return new ModelAndView("/crowdfunding/memberCenter/investList.jsp")
			.addObject("TUserFunds", sf)
			.addObject("listVo",listVo)
			.addObject("typeId",typeId)
			.addObject("timeBucket",timeBucket)
			.addObject("TMoneymove", tm).addObject("zjldlist",zjld);
		} catch (Exception e) {
			logger.error("进入资金明细查询异常", e);
		}
		return null;
	}
	@RequestMapping({ "getUserInverstList" })
	@Action( description = "进入用户账户概览" )
	public ModelAndView getUserInverstList(HttpServletRequest request,
			HttpServletResponse response) {
		TUser u=(TUser)request.getSession().getAttribute("user");
		try {
			if(u==null){
				response.sendRedirect(request.getContextPath() + "/index-web.jsp"); // 登录已失效，请重新登录
				return null;
			}
			//分页加参数
			int page = RequestUtil.getInt(request, "current_page", 1);//PageBean.getDefaultPageSize().intValue()
		    int pageSize = RequestUtil.getInt(request, "pageSize",10);
			PageBean pb=new  PageBean(page, pageSize);
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("userId", u.getUserId());
			List<TcprojectInvest> list=tcprojectInvestService.getUserInvestList(map, pb);
			TcprojectInvest tcprojectInvest=tcprojectInvestService.getUserInvestSum(u.getUserId());
			if(tcprojectInvest==null){
				tcprojectInvest=new TcprojectInvest();
			}
			String askPricesincerity="0";
			TUser user = tuserService.getById(u.getUserId());
			if(user.getIsAskPrice()==1){
				 //取得最近一次诚意金缴纳的数额
				map.put("typeId", 12);//诚意金
				map.put("resultId", 2);//成功的
				List<TMoneymove> listvo=tmoneymoveService.getListByMap(map);
				String actualPay = configproperties.getProperty("actualPay");
				askPricesincerity = listvo.get(0).getMoneyInOut().abs().toString();
			}
			request.setAttribute( "page_bean", pb );//分页参数传入页面
			return new ModelAndView("/crowdfunding/front/accountAllView.jsp")
			.addObject("list", list).addObject("tcprojectInvest", tcprojectInvest).addObject("askPricesincerity", askPricesincerity);
		} catch (Exception e) {
			logger.error("",e);
		}
		return null;
	}
	
	
	
	@RequestMapping({ "todrawBack" })
	@Action( description = "进入申请退款页面" )
	public ModelAndView todrawBack(HttpServletRequest request,
			HttpServletResponse response) {
		Long userId = TUserUtil.getLogUser(request).getUserId();
		//用户账户
		TUserFunds sf=tuserFundsService.getTUserFundsByUserId(userId);
		//用户的所有银行卡
		List<TBankcard> listBkc=tbankcardService.getTBankcardByUserId(userId);
		request.setAttribute("TUserFunds", sf);
		request.setAttribute("listBkc", listBkc);
		return new ModelAndView("/crowdfunding/memberCenter/applicationDrawBack.jsp");
	}
	@RequestMapping({ "getDrawBack" })
	@Action( description = "切换银行卡号，自动显示相应银行到信息" )
	@ResponseBody
	public Map<String,Object> getDrawBack(HttpServletRequest request,
			HttpServletResponse response,String bankCardId,String cardId) {
		 Map<String,Object> result = new HashMap<String,Object>();
		Long userId = TUserUtil.getLogUser(request).getUserId();
		//用户账户
		TUserFunds sf=tuserFundsService.getTUserFundsByUserId(userId);
		if(StringUtils.isNotEmpty(bankCardId) && StringUtils.isNotBlank(bankCardId)){
			try {
				
				long id = Long.valueOf(bankCardId);
				//用户的所有银行卡
				TBankcard listBkc =tbankcardService.getById(id);
				result.put("listBkc", listBkc);
				if(null != listBkc && listBkc.getBankId() != null ){
					id = listBkc.getBankId().longValue();
					Tbank tbank = tbankService.getById(id);
					result.put("tbank", tbank);
				}
			} catch (Exception e) {
				logger.error("切换银行卡异常", e);
			}
		}
		
		return result;
	}
	@RequestMapping({ "todrawBackRecords" })
	@Action( description = "进入我的申请退款记录页面" )
	public ModelAndView todrawBackRecords(HttpServletRequest request,
			HttpServletResponse response) {
		Long userId = TUserUtil.getLogUser(request).getUserId();
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userId",userId);				
		map.put("typeId","2");//提现
		map.put("audit","1");//审核通过的
		String maxNum ="";
		//分页加参数
		int page = RequestUtil.getInt(request, "current_page", 1);
		int pageSize = RequestUtil.getInt(request, "pageSize",10);
		PageBean pb=new  PageBean(page, pageSize);
		if(StringUtils.isEmpty(maxNum)){
			maxNum = ((page-1)*pageSize)+"";
		}
		List<TMoneymove> listvo=tmoneymoveService.getUserMoneyList(map, pb);
		
		if(listvo!=null&&listvo.size()>0){
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			for (TMoneymove m : listvo) {
				if(m.getCreateTime()!=null){
					m.setCreateTimeS(sdf.format(m.getCreateTime()));
				}
			}
		}
		request.setAttribute( "page_bean", pb );//分页参数传入页面
		request.setAttribute("listvo", listvo);
		return new ModelAndView("/crowdfunding/memberCenter/drawBackRecords.jsp").addObject("maxNum",maxNum);
	}
	
	@RequestMapping({ "toinquiryRecogniz" })
	@Action( description = "进入询价认投资格页面" )
	public ModelAndView toinquiryRecogniz(HttpServletRequest request,
			HttpServletResponse response) {
		int isaskPrice=0;
		TUser user = (TUser) request.getSession().getAttribute("user");
		
		if(null != user){
			TUser tuser = this.tuserService.getById(user.getUserId());
			isaskPrice = tuser.getIsAskPrice();
		}
		 //系统设置的询价次数
		String askPriceMaxTimes="2";
		 try {
			 askPriceMaxTimes=(String)AppUtil.getServletContext().getAttribute("ASK_PRICE_MAX_TIMES");
		} catch (Exception e) {
			logger.error("获取询价次数异常", e);
		}
		return new ModelAndView("/crowdfunding/memberCenter/inquiryRecogniz.jsp").addObject("isAskPrice",isaskPrice).addObject("askPriceMaxTimes", askPriceMaxTimes);
	}
	
	@RequestMapping({ "toApplyEnqPage" })
	@Action( description = "进入询价认投付款页面" )
	public ModelAndView toApplyEnqPage(HttpServletRequest request,
			HttpServletResponse response) {
		TUser u=(TUser)request.getSession().getAttribute("user");
		Long userId=u.getUserId();//当前用户id;
		//取得系统设置的询价资格 金额
		String enquiryMoney ="";
		TUserFunds tf = null;
		List<TBankcard> bankcardlist = null;
		 //系统设置的询价次数
		String askPriceMaxTimes="2";
		String htmlStr="";
		List<Tbank> list = null;
		String contentUrl="";
		String iscompany="";
		try {
			enquiryMoney=(String)AppUtil.getServletContext().getAttribute("ASK_PRICE_SINCERITY");
			if(StringUtil.isEmpty(enquiryMoney)){
				enquiryMoney="1000";
			}
			if(StringUtil.isNotEmpty(userId+"")){
				 tf=tuserFundsService.getTUserFundsByUserId(userId);
			}
			//先取到用户的银行卡信息 1.如果没取到 页面提示先绑定银行卡,取到则显示
			 bankcardlist=tbankcardService.getBankCardAndTransactionPwd(u.getUserId());
			 askPriceMaxTimes=(String)AppUtil.getServletContext().getAttribute("ASK_PRICE_MAX_TIMES");
			//根据当前登录人的 isCompany字段判断，是否为机构投资
			 Map<String,Object> map = new HashMap<String,Object>();

				if(u!=null){
					if(u.getIsCompany()==1){
						iscompany="_B2B";
						map.put("isCompanyPay", 1);
					}else{
						map.put("isCompanyPay", 0);
					}
				}
				
			contentUrl=(String)AppUtil.getServletContext().getAttribute("PLATFORM-SYSTEM-URL");
		   		
		   			//取得客户 支持的银行
		   			list=tbankService.getAllByWhere(map);
//		   			for (int i = 0; i < list.size(); i++) {
//		   				Tbank k0=list.get(i);
//						k0.getBankPic();
//						String fileId0=k0.getFilesIds();
//						Tbank k1=null;
//						String fileId1="";
//						if(i+1<list.size()){
//							k1=list.get(i+1);
//							k1.getBankPic();
//							 fileId1=k1.getFilesIds();
//						}
//
//						Tbank k2=null;
//						String fileId2="";
//						if(i+2<list.size()){
//							 k2=list.get(i+2);
//							k2.getBankPic();
//							 fileId2=k2.getFilesIds();
//						}
//
//						Tbank k3=null;
//						String fileId3="";
//						if(i+3<list.size()){
//							 k3=list.get(i+3);
//							k3.getBankPic();
//							 fileId3=k3.getFilesIds();
//						}
//
//						htmlStr+="<tr>";
//						if(k0!=null){
//							int n0=i+1;
//							htmlStr+="<td width=\"5%\" height=\"85\" align=\"right\"><input type=\"radio\" name=\"defaultbank3\" id=\"defaultbank"+n0+"\" onclick=\"setvalueFun('"+n0+"')\" value=\""+k0.getBankCode()+iscompany+"\"/></td>"
//									+" <td width=\"6%\"><img src=\""+contentUrl+"/wuyouchou/system/sysFile/getFileById.ht?fileId="+fileId0+"\"/></td>";
//						}
//						if(k1!=null){
//							int n1=i+2;
//							htmlStr+=" <td width=\"5%\" height=\"85\" align=\"right\"><input type=\"radio\" name=\"defaultbank3\" id=\"defaultbank"+n1+"\" onclick=\"setvalueFun('"+n1+"')\" value=\""+k1.getBankCode()+iscompany+"\"/></td>"
//									+" <td width=\"6%\"><img src=\""+contentUrl+"/wuyouchou/system/sysFile/getFileById.ht?fileId="+fileId1+"\"/></td>";
//						}
//						if(k2!=null){
//							int n2=i+3;
//							htmlStr+=" <td width=\"5%\" height=\"85\" align=\"right\"><input type=\"radio\" name=\"defaultbank3\" id=\"defaultbank"+n2+"\" onclick=\"setvalueFun('"+n2+"')\"  value=\""+k2.getBankCode()+iscompany+"\"/></td>"
//									+" <td width=\"6%\" align=\"left\"><img src=\""+contentUrl+"/wuyouchou/system/sysFile/getFileById.ht?fileId="+fileId2+"\"/></td>";
//						}
//						if(k3!=null){
//							int n3=i+4;
//							htmlStr+=" <td width=\"5%\" height=\"85\" align=\"right\"><input type=\"radio\" name=\"defaultbank3\" id=\"defaultbank"+n3+"\" onclick=\"setvalueFun('"+n3+"')\"  value=\""+k3.getBankCode()+iscompany+"\"/></td>"
//									+" <td width=\"6%\" align=\"left\"><img src=\""+contentUrl+"/wuyouchou/system/sysFile/getFileById.ht?fileId="+fileId3+"\"/></td>";
//						}
//						htmlStr+="  </tr>";
//						i=i+3;
//					}
			 
		} catch (Exception e) {
			logger.error("认投页面异常", e);
		}
		return new ModelAndView("/crowdfunding/memberCenter/applyEnquiry.jsp")
		.addObject("askPrice",enquiryMoney).addObject("userfund",tf).addObject("askPriceMaxTimes", askPriceMaxTimes)
		.addObject("bankcardlist", bankcardlist == null ? new ArrayList<TBankcard>() : bankcardlist).addObject("htmlStr", htmlStr)
				.addObject("list", list).addObject("iscompany", iscompany).addObject("contentUrl",contentUrl);
	}
	
	@RequestMapping({ "toEnquiryRecords" })
	@Action( description = "进入诚意金缴纳记录页面" )
	public ModelAndView toEnquiryRecords(HttpServletRequest request,
			HttpServletResponse response) {
		Long userId = TUserUtil.getLogUser(request).getUserId();
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userId",userId);				
		map.put("typeId","12");//询价认投诚意金
		//分页加参数
		int page = RequestUtil.getInt(request, "current_page", 1);
		int pageSize = RequestUtil.getInt(request, "pageSize",10);
		PageBean pb=new  PageBean(page, pageSize);
		
		List<TMoneymove> listvo=tmoneymoveService.getUserMoneyList(map, pb);
		
		if(listvo!=null&&listvo.size()>0){
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			for (TMoneymove m : listvo) {
				if(m.getCreateTime()!=null){
					m.setCreateTimeS(sdf.format(m.getCreateTime()));
				}
			}
		}
		
		request.setAttribute("listvo", listvo);
		request.setAttribute( "page_bean", pb );//分页参数传入页面
		
		return new ModelAndView("/crowdfunding/memberCenter/enquiryRecords.jsp");
	}
	
	@RequestMapping({ "toPullBackRecords" })
	@Action( description = "进入反悔记录页面" )
	public ModelAndView toPullBackRecords(HttpServletRequest request,
			HttpServletResponse response) {
		
		Long userId = TUserUtil.getLogUser(request).getUserId();
		try {
			//分页加参数
			int page = RequestUtil.getInt(request, "current_page", 1);
			int pageSize = RequestUtil.getInt(request, "pageSize",10);
			PageBean pb=new  PageBean(page, pageSize);
			
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("userId",userId);				
			map.put("piisCancel",1);//反悔
			List<TcprojectInvest> listv=tcprojectInvestService.getPullBackRecords(map, pb);
			if(listv!=null&&listv.size()>0){
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
				for (TcprojectInvest p : listv) {
					if(p.getPiinvestTime()!=null){
						p.setPiinvestTimeS(sdf.format(p.getPiinvestTime()));
					}
				}
			}
			
			request.setAttribute( "page_bean", pb );//分页参数传入页面
			request.setAttribute("listv",listv );
			return new ModelAndView("/crowdfunding/memberCenter/pullBackRecords.jsp");
		} catch (Exception e) {
			logger.error("查询反悔记录异常", e);
		}
		return null;
	}
	
	
	 @Action(description="申请退款")
	 @RequestMapping({"drawBackMoney"})
	 @ResponseBody
	  public String drawBackMoney(HttpServletRequest request, HttpServletResponse response)
	    throws Exception {
		 String backMoney=request.getParameter("backMoney");//
		 String cardid=request.getParameter("cardid");//
		 TUser u=(TUser)request.getSession().getAttribute("user");
		 if(u == null){
				return "0";
		  }
		 
		try{
			String flowCode=String.valueOf(UniqueIdUtil.genId());
			tuserFundsService.drawBackMoney(u.getUserId(),backMoney,cardid,false,flowCode);
			return flowCode;
			
		   } catch (Exception e){
			   logger.error("申请退款异常", e);
		        throw e;
	      } 
	 }
	 
	 
	 @RequestMapping({ "withdraws" })
	 @Action( description = "进入支付提现绑定页面" )
	 public ModelAndView withdraws(HttpServletRequest request,HttpServletResponse response) throws IOException {
			String flowCode=request.getParameter("flowCode"); 
			TUser tuser= TUserUtil.getLogUser(request);   
			TUserSafe userSafe = tuserSafeService.getUserSafeByUserId(tuser.getUserId());  //安全
			TUserFunds tuserFunds = tuserFundsService.getByUserId(tuser.getUserId()); //资金
			ModelAndView mv=	new ModelAndView("/crowdfunding/memberCenter/withdraws.jsp");
			mv.addObject( "tuser", tuser ).addObject( "userSafe", userSafe).addObject( "tuserFunds", tuserFunds );
			//平台承担的提现手续费率
			TSettings setting =tsettingsService.getTSettingsBySetCode(TSettingParem.HandingCharge.FeePercent);
			String setVal="0";
			if(setting!=null){
				setVal=setting.getSetValue();
			}
			//用户的所有银行卡
			List<TBankcard> listBkc=tbankcardService.getTBankcardByUserId(tuser.getUserId());
			TBankcard  tbk=new TBankcard();
			if(listBkc!=null&&listBkc.size()>0){
				tbk=listBkc.get(0);
			} 
			TMoneymove tm=	tmoneymoveService.getByIdFlowCode(flowCode); 
			//提现第三方支付系统接口
				HashMap hm=new HashMap();
				hm.put( "TUserFunds", tuserFunds );
				hm.put( "TUser", tuser );
				hm.put( "TMoneymove", tm );
				hm.put( "FeePercent", setVal);
				hm.put("TBankcard", tbk);
				PayCommon.withdraws( hm );   
		     return mv.addObject( "hm", hm ).addObject( "hmData", hm.get( PayCommonMoney.payDataKey ) );
			
		}
	 /**
	  * 临时方法,实际中要等用户资金到账后 才操作
	  * @param request
	  * @param response
	  * @return
	  * @throws Exception
	  */
	 
	 @Action(description="赋予用户询价资格")
	 @RequestMapping({"askpriceForUser"})
	 @ResponseBody
	  public String askpriceForUser(HttpServletRequest request, HttpServletResponse response)
	    throws Exception {
		 TUser u=(TUser)request.getSession().getAttribute("user");
		 if(u == null){
				return "0";
		  }
		try{
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("audit", 0);
			map.put("userId",u.getUserId());				
			map.put("typeId","12");//询价认投诚意金
			List<TMoneymove> listvo=tmoneymoveService.getUserMoneyList(map, null);
			if(listvo!=null&&listvo.size()>0){//如果存在未审核的诚意金提交记录则返回 2 ，不需要重复提交诚意金记录
				return "2";
			}
			String enquiryMoney=(String)AppUtil.getServletContext().getAttribute("ASK_PRICE_SINCERITY");
			if(StringUtil.isEmpty(enquiryMoney)){
				enquiryMoney="1000";
			}
			//修改用户支付询价诚意金记录 ,需要审核之后才通过询价资格
			tuserFundsService.userFundsChangeFunction(null, null, u.getUserId(), new BigDecimal(enquiryMoney), null, "12",null,"");
			//u.setIsAskPrice(1);//1为有询价资格
			//tuserService.update(u);
			return "1";
			
		   } catch (Exception e){
		        logger.error("询价资格异常", e);
	      }
		 return null;
	 }
}
