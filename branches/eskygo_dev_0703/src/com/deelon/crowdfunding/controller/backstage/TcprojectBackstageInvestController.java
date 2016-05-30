/*
 * Powered By [Allen]
 * Since 1011 - 1011
 */


package com.deelon.crowdfunding.controller.backstage;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.common.constants.WuyouchouErrorCode;
import com.deelon.crowdfunding.common.exception.CrowdFundException;
import com.deelon.crowdfunding.model.backstage.Tcproject;
import com.deelon.crowdfunding.model.backstage.TcprojectInvest;
import com.deelon.crowdfunding.service.backstage.TcprojectAttachmentService;
import com.deelon.crowdfunding.service.backstage.TcprojectInvestService;
import com.deelon.crowdfunding.service.backstage.TcprojectService;
import com.deelon.loan.model.front.TMoneymove;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TmoneymoveService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@ Controller
@ RequestMapping( { "/crowdfunding/backstage/userinvest/" } )
public class TcprojectBackstageInvestController extends BaseController{
	@ Resource
	private TcprojectInvestService tcprojectInvestService;
	@ Resource
	private TcprojectService tcprojectService;
	@Resource
	private TmoneymoveService tmoneymoveService;
	@ Resource
	private TUserService tuserService;
	@Autowired
	TcprojectAttachmentService tcprojectAttachmentService;


	@ RequestMapping( { "investorASKAdd" } )
	@ Action( description = "新增线下支付诚意金额" )
	public ModelAndView investorASKAdd( HttpServletRequest request ) throws Exception
	{
			Long pkId = Long.valueOf(RequestUtil.getLong(request, "userId"));
			TUser tuser = null;
			TMoneymove t =null;
		try {
			if (pkId.longValue() != 0L) {
				tuser = (TUser) this.tuserService.getById(pkId);
				if (tuser == null) {
					throw new CrowdFundException("用户信息为空异常");
				}
			} else {
				throw new CrowdFundException("用户ID为空异常");
			}
			String enquiryMoney = (String) AppUtil.getServletContext().getAttribute("ASK_PRICE_SINCERITY");
			if (StringUtil.isEmpty(enquiryMoney)) {
				throw new CrowdFundException("线下支付意向金配置异常");
			}
			t = new TMoneymove();
			t.setUserId(pkId);
			t.setMoneyInOut(new BigDecimal(enquiryMoney));
			t.setRemark("诚意金支付成功");
		}catch (Exception e){
			logger.error("investorASKAdd() error:errorCode = "+WuyouchouErrorCode.INVEST_TOASKPAY_BACKSTAGE_ERROR.getErrorCode(),e);
			throw new CrowdFundException(WuyouchouErrorCode.INVEST_TOASKPAY_BACKSTAGE_ERROR.getErrorCode(),
					WuyouchouErrorCode.INVEST_TOASKPAY_BACKSTAGE_ERROR.getErrorMsg(),e);
		}
		return new ModelAndView("/crowdfunding/tuserInvestor/investorASKAdd.jsp").addObject("tMoneyMove",t).addObject("tuser",tuser);
	}

	@ RequestMapping( { "investorMoneyAdd" } )
	@ Action( description = "新增线下支付投资金额" )
	public ModelAndView investorMoneyAdd( HttpServletRequest request ) throws Exception
	{
		String investId =  request.getParameter("investId");
		TUser tuser = null;
		Tcproject tcp = null;
		TMoneymove t=new TMoneymove();
		try {
			if(StringUtil.isEmpty(investId)){
				throw new CrowdFundException("投资信息ID为空异常");
			}
			TcprojectInvest ivest = tcprojectInvestService.getById(Long.valueOf(investId));
			if(ivest==null){
				throw new CrowdFundException("投资信息为空异常");
			}
			if(ivest.getProjectId()==0l||ivest.getUserId()==0l){
				throw new CrowdFundException("投资信息异常");
			}
			tuser = tuserService.getById(ivest.getUserId());
			tcp  = tcprojectService.getById(ivest.getProjectId());
			/**
			* *插入一条自己记录，记录用户的 资金流动/这里起始 设为 支付成功
			*/
			t.setUserId(ivest.getUserId());
			t.setProjectId(ivest.getProjectId());
			t.setMoneyInOut(ivest.getPiinvest());//认投金额
			t.setRemark("投资金额支付成功");
			request.setAttribute("investId",investId);
		}catch (Exception e){
			logger.error("investorMoneyAdd() error:errorCode = " + WuyouchouErrorCode.INVEST_ADDPAY_BACKSTAGE_ERROR.getErrorCode(), e);
			throw new CrowdFundException(WuyouchouErrorCode.INVEST_ADDPAY_BACKSTAGE_ERROR.getErrorCode(),
					WuyouchouErrorCode.INVEST_ADDPAY_BACKSTAGE_ERROR.getErrorMsg(),e);
		}
		return new ModelAndView("/crowdfunding/backstage/toPayInvestMoneyAdd.jsp").addObject("tMoneyMove",t).addObject("tuser", tuser).addObject("tcproject",tcp);
	}
    @RequestMapping({ "toPayASKMoney" })
   	@Action(description = "线下确认支付认筹诚意金")
   	public void toPayASKMoney(HttpServletRequest request,HttpServletResponse response,TMoneymove tMoneyMove) throws Exception {

		TUser tuser = null;
		//插入一条线下资金流动记录，记录用户的 设为 支付成功
		String message =null;
		try {
			if(tMoneyMove!=null){
				Long userId = tMoneyMove.getUserId();
				if (userId.longValue() != 0L) {
					tuser = (TUser) this.tuserService.getById(userId);
					if (tuser == null) {
						throw new CrowdFundException("用户信息为空异常");
					}
				} else {
					throw new CrowdFundException("用户ID为空异常");
				}
				TMoneymove t = new TMoneymove();
				t.setMoneyMoveId(UniqueIdUtil.genId());
				t.setUserId(tMoneyMove.getUserId());//
				//	t.setProjectId();
				t.setTypeId("12");
				t.setMoneyInOut(new BigDecimal("-" + tMoneyMove.getMoneyInOut()));
				t.setGetFee(new BigDecimal(0));
				t.setMoneyCurrent(new BigDecimal(0));
				t.setCreateTime(new Timestamp(System.currentTimeMillis()));
				t.setResultId("1");//成功
				t.setAudit(0l);
				t.setRemark(tMoneyMove.getRemark());
				t.setSerialNo("");
				t.setFlowCode(tMoneyMove.getFlowCode());
				t.setIsOffLine(1);//线下支付
				tmoneymoveService.addNewMoneyMove(t);
				tuser.setIsAskPrice(1);//设置认筹资格
				tuserService.update(tuser);
				message = getText("成功", new Object[] { "数据" });
				writeResultMessage(response.getWriter(), message, 1);

			}else{
				throw new CrowdFundException("线下支付认筹金额失败");
			}
		}
		catch(Exception e){
			logger.error("toPayASKMoney() error:errorCode = " + WuyouchouErrorCode.INVEST_ASKPAY_BACKSTAGE_ERROR.getErrorCode(), e);
			throw new CrowdFundException(WuyouchouErrorCode.INVEST_ASKPAY_BACKSTAGE_ERROR.getErrorCode(),
					WuyouchouErrorCode.INVEST_ASKPAY_BACKSTAGE_ERROR.getErrorMsg(),e);
		}
    }


	@RequestMapping({ "toPayInvestMoney" })
	@Action(description = "线下确认支付投资金额")
	public void toPayInvestMoney(HttpServletRequest request,HttpServletResponse response,TMoneymove tMoneyMove) throws Exception {
		String investId =  request.getParameter("investId");
		String userId = request.getParameter("userId");
		String projectId = request.getParameter("projectId");
		TcprojectInvest ivest = null;
		String message =null;
		try {

			if(StringUtil.isEmpty(investId)){
				throw new CrowdFundException("投资信息ID为空异常");
			}
			ivest = tcprojectInvestService.getById(Long.valueOf(investId));
			if(ivest==null){
				throw new CrowdFundException("投资信息为空异常");
			}
			if(ivest.getProjectId()==0l||ivest.getUserId()==0l){
				throw new CrowdFundException("投资信息异常");
			}

			if(tMoneyMove==null){
				throw new CrowdFundException("线下支付投资金额失败");
			}else{
				TMoneymove t = new TMoneymove();
				t.setMoneyMoveId(UniqueIdUtil.genId());
				t.setUserId(tMoneyMove.getUserId());//
				t.setProjectId(tMoneyMove.getProjectId());
				t.setTypeId("3");
				t.setMoneyInOut(new BigDecimal("-" + tMoneyMove.getMoneyInOut()));
				t.setGetFee(new BigDecimal(0));
				t.setMoneyCurrent(new BigDecimal(0));
				t.setCreateTime(new Timestamp(System.currentTimeMillis()));
				t.setResultId("1");//成功
				t.setAudit(0l);
				t.setRemark(tMoneyMove.getRemark());
				t.setSerialNo("");
				t.setFlowCode(tMoneyMove.getFlowCode());
				t.setIsOffLine(1);//线下支付
				tmoneymoveService.addNewMoneyMove(t);
				ivest.setPiisPay(1);// 已付款
				ivest.setPipayTime(new Date());
				tcprojectInvestService.update(ivest);

				message = getText("修改成功", new Object[] { "数据" });
				writeResultMessage(response.getWriter(), message, 1);
			}
		}
		catch(Exception e){
			logger.error("toPayInvestMoney() error:errorCode = "+WuyouchouErrorCode.INVEST_TOPAY_BACKSTAGE_ERRORTO.getErrorCode(),e);
			throw new CrowdFundException(WuyouchouErrorCode.INVEST_TOPAY_BACKSTAGE_ERRORTO.getErrorCode(),
					WuyouchouErrorCode.INVEST_TOPAY_BACKSTAGE_ERRORTO.getErrorMsg(),e);
		}

	}

	@ RequestMapping( { "toTMoneyMoveDetail" } )
	@ Action( description = "获取付款详情" )
	public ModelAndView toTMoneyMoveDetail( HttpServletRequest request ) throws Exception
	{
		String investId =  request.getParameter("investId");
		TMoneymove t=new TMoneymove();
		try {
			if(StringUtil.isEmpty(investId)){
				throw new CrowdFundException("投资信息ID为空异常");
			}
			TcprojectInvest ivest = tcprojectInvestService.getById(Long.valueOf(investId));
			if(ivest==null){
				throw new CrowdFundException("投资信息为空异常");
			}
			if(ivest.getProjectId()==0l||ivest.getUserId()==0l){
				throw new CrowdFundException("投资信息异常");
			}
			//查询 项目下 已经成功付款的投资信息
			Map<String,Object> map2=new HashMap<String,Object>();
			map2.put("projectId", ivest.getProjectId());
			map2.put("typeId", "3");
			map2.put("userId", ivest.getUserId());
			map2.put("resultId", "1");
			t=tmoneymoveService.getByProIdAndUserIdAnd(map2);

		}catch (Exception e){
			logger.error("toTMoneyMoveDetail() error:errorCode = " + WuyouchouErrorCode.INVEST_GETDETAIL_BACKSTAGE_ERROR.getErrorCode(), e);
			throw new CrowdFundException(WuyouchouErrorCode.INVEST_GETDETAIL_BACKSTAGE_ERROR.getErrorCode(),
					WuyouchouErrorCode.INVEST_GETDETAIL_BACKSTAGE_ERROR.getErrorMsg(),e);
		}
		return new ModelAndView("/crowdfunding/backstage/toTMoneyMoveDetail.jsp").addObject("tMoneyMove",t);
	}




}

