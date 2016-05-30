package com.deelon.loan.controller.myAccount;

import java.math.BigDecimal;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.crowdfunding.common.util.TUserUtil;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.model.front.TTask;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.model.front.Tarea;
import com.deelon.loan.model.front.TuserTaskcomplete;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TareaService;
import com.deelon.loan.service.front.TprojectInvestService;
import com.deelon.loan.service.front.TuserSafeService;
import com.deelon.loan.service.front.TuserTaskcompleteService;
import com.deelon.loan.service.sysManager.TprojectService;
import com.deelon.loan.service.sysManager.TtaskService;
import com.deelon.loan.service.sysManager.TuserFundsService;

@SuppressWarnings("unused")
@Controller
@RequestMapping({ "/loan/myAccount/" })
public class MyAccountController extends BaseController {

	@Resource
	private TuserFundsService tuserFundsService;
	@Resource
	private TtaskService ttaskService;
	@Resource
	private TprojectService tprojectService;
	@Resource
	private TuserTaskcompleteService userTaskcompleteService;
	
	@Resource
	private TprojectInvestService tprojectInvestService;
	
	@Resource
	private TUserService tUserService;
	
	@Resource
	private TuserSafeService tuserSafeService;
	
	@ Resource
	private TareaService tareaService;
	
	@Action(description="个人中心 账户资产详情 理财 借贷 详情记录统计")
	@RequestMapping({ "toMyaccount" })
	public ModelAndView toMyaccount(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			TUser u=(TUser)request.getSession().getAttribute("user");
			//用户头像,账户余额,安全等级
			TUserFunds sf=tuserFundsService.getTUserFundsByUserId(u.getUserId());
			
			//账户资产 余额 理财资产 借款负债
			TUserFunds usf=tuserFundsService.getPersonalAssetsByUserId(u.getUserId());
			
			List<TProject> listVo=null;
			List<TProject> listVo1=null;
			//根据用户角色 groupId 1.借款账户,2.未理财账户,3为 借款 理财账户
			if(StringUtil.isNotEmpty(u.getGroupId())){//start
				if(u.getGroupId().equals("2")||u.getGroupId().equals("3")){
					//理财账户
					BigDecimal payMoneyTotal=new BigDecimal(0).setScale(2, BigDecimal.ROUND_HALF_UP) ;
					listVo=tprojectService.getPersonalFinanceByUserId(u.getUserId());
					if(listVo!=null&&listVo.size()>0){
						for (TProject t : listVo) {
							if(t.getPieffectAmountTotal()!=null){
								t.setPieffectAmountTotal(t.getPieffectAmountTotal().setScale(2, BigDecimal.ROUND_HALF_UP));
							}		
							if(t.getPsumHavedPayInterestTotal()!=null){
								t.setPsumHavedPayInterestTotal(t.getPsumHavedPayInterestTotal().setScale(2, BigDecimal.ROUND_HALF_UP));
								payMoneyTotal=payMoneyTotal.add(t.getPsumHavedPayInterestTotal());
							}
							t.setPrateOutavg(t.getPsumHavedPayInterestTotal().add(t.getPiBeGetRateSum()).divide(t.getPieffectAmountTotal(),3, BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(100)));
						}
					}
					request.setAttribute("payMoneyTotal", payMoneyTotal);
				}//end
				if(u.getGroupId().equals("1")||u.getGroupId().equals("3")){//start 
					//借款账户
					 listVo1=tprojectService.getPersnalLoanByUserId(u.getUserId());
					
					BigDecimal totalMoneyPay=new BigDecimal(0);
					if(listVo1!=null&&listVo1.size()>0){
						for (TProject t : listVo1) {
							if(t.getPsumHavedPayTotal()!=null){
								t.setPsumHavedPayTotal(t.getPsumHavedPayTotal().setScale(2, BigDecimal.ROUND_HALF_UP).abs());
							}		
							if(t.getPsumHavedPayInterestTotal()!=null){
								t.setPsumHavedPayInterestTotal(t.getPsumHavedPayInterestTotal().setScale(2, BigDecimal.ROUND_HALF_UP).abs());
							}
							if(t.getPsumLateTotal()!=null){
								t.setPsumLateTotal(t.getPsumLateTotal().setScale(2, BigDecimal.ROUND_HALF_UP).abs());
							}
							if(t.getPsumHavedPaytotalInterest()!=null)
							 totalMoneyPay=totalMoneyPay.add(t.getPsumHavedPaytotalInterest().abs()).setScale(2, BigDecimal.ROUND_HALF_UP);
						}
					}
					request.setAttribute("totalMoneyPay", totalMoneyPay);
				}//end
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
				sf.setAvailable(sf.getAvailable().setScale(2, BigDecimal.ROUND_HALF_UP));
				sf.setFreeze(sf.getFreeze().setScale(2, BigDecimal.ROUND_HALF_UP));
				sf.setBalance(sf.getAvailable().add(sf.getFreeze()).setScale(2, BigDecimal.ROUND_HALF_UP));
			}else{
				sf=new TUserFunds();
				sf.setSafebar(safeLang+"");
				sf.setSafePercentum(safePercentum+"");
			}
			if(usf!=null){
				BigDecimal blance=new BigDecimal(0);
				if(usf.getPiEffectAmountTotal()!=null){
					
					usf.setPiEffectAmountTotal(usf.getPiEffectAmountTotal().setScale(2, BigDecimal.ROUND_HALF_UP));
					blance=blance.add(usf.getPiEffectAmountTotal());
				}
			
				if(usf.getAvailable()!=null){
					
					usf.setAvailable(usf.getAvailable().setScale(2, BigDecimal.ROUND_HALF_UP));
					blance=blance.add(usf.getAvailable());
				}
				if(usf.getPloanRealTotal()!=null){
					
					usf.setPloanRealTotal(usf.getPloanRealTotal().setScale(2, BigDecimal.ROUND_HALF_UP));
					blance=blance.subtract(usf.getPloanRealTotal());
				}
					/*if(blance.compareTo(new BigDecimal(0))<0){//负数 
						usf.setBalanceStr("待还"+blance.abs());
					}else{
						usf.setBalanceStr(""+blance);
					}*/
					usf.setBalance(blance);
//					usf.setAvailable(usf.getAvailable().add(usf.getFreeze()));
					
			}
			request.setAttribute("TUserFunds1", usf);
			return new ModelAndView("/loan/myAccount/myAccount.jsp").addObject("TUserFunds", sf).addObject("tTask", tTask).addObject("count", count).addObject("ListVo", listVo).addObject("ListVo1", listVo1).addObject("TUser", u);//addObject("ImageId", sf.getFileId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
