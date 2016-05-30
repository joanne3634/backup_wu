/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.service.sysManager;

import java.math.BigDecimal;
import java.net.InetAddress;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.encrypt.EncryptUtil;
import com.deelon.core.service.BaseService;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.dao.sysManager.TprojectTransferDao;
import com.deelon.loan.model.front.TProjectAccept;
import com.deelon.loan.model.front.TProjectInvest;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.sysManager.TprojectAuction;
import com.deelon.loan.model.sysManager.TprojectTransfer;
import com.deelon.loan.service.front.TprojectAcceptService;
import com.deelon.loan.service.front.TprojectInvestService;
import com.deelon.loan.service.front.UserInfoService;
import com.deelon.loan.service.operationLog.TuserLogService;

@ Service
public class TprojectTransferService extends BaseService<TprojectTransfer>{
	
	@ Resource
	private TprojectTransferDao tprojectTransferDao;
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private TprojectInvestService tprojectInvestService;
	@Autowired
	private TprojectAcceptService tprojectAcceptService;
	@Autowired
	private TprojectAuctionService tprojectAuctionService;
	@Resource
	private TprojectService TprojectService;
	@Resource
	private TuserFundsService TuserFundsService;
	@Resource
	private TuserLogService tuserLogService;
	protected IEntityDao<TprojectTransfer, Long> getEntityDao()
	{
		return this.tprojectTransferDao;
	}
	/**
	 * 添加或者修改债权转让的申请记录
	 * @param transferpwd
	 * @param projectTransfer
	 * @param user
	 * @return
	 */
	public Object addTransferApply(String transferpwd, TprojectTransfer projectTransfer, TUser user) {
		JSONObject json = new JSONObject();
		try{
			//验证支付密码是否正确
			if (user.getTradingPwdErrCount() >= 3) {
				logger.error("交易密码输入错误次数3次!");
				json.put("result", "交易密码输入错误次数3次!请稍候再操作，或者联系客服人员。");
				return json;
			}
			if(!EncryptUtil.encryptSha256(transferpwd).equals(userInfoService.getTUserByLoginName(user.getLoginName()).getTradingPwd())){
				user.setTradingPwdErrCount(user.getTradingPwdErrCount()+1);
				userInfoService.editUserInfo(user);
				json.put("result", "交易密码输入错误，如果忘记交易密码请联系客服人员。");
				return json;
			}
			projectTransfer.setAuctionCount(0);
			projectTransfer.setViewCount(0);
			projectTransfer.setBidPrice(new BigDecimal(0));
			projectTransfer.setBidder(new Long(0));
			projectTransfer.setIsCancel(0);
			projectTransfer.setStateId("1");//初始化申请转让中但是未审核setIsCheck=0
			projectTransfer.setIsCheck(0);
			projectTransfer.setChecker(new Long(0));
			//更新申请之后的债权投资记录为待审核中
		    TProjectInvest invest = tprojectInvestService.getById(projectTransfer.getInvestId());
		    invest.setPiTransferStateId(5);//增加债权转让待审核的状态 到投资表记录
		    if(projectTransfer.getClaimsSum().compareTo(invest.getPiBeGetSum())!=0){
		    	json.put("result", "有还款已经产生收益，债权总值发生改变。申请转让失败成功，请刷新后再发起转让。");
		    	return json;
		    }
		    tprojectInvestService.update(invest);
			if(null!=projectTransfer.getTransferId()&&projectTransfer.getTransferId()>0){
				update(projectTransfer);
			}else{
				projectTransfer.setTransferId(UniqueIdUtil.genId());
				add(projectTransfer);
			}
		    
			json.put("success", "1");
			json.put("result", "保存债权转让申请信息成功，请等候平台审核。");
		}catch(Exception e){
			json.put("result", "保存数据异常，请稍后操作。");
			throw new RuntimeException();
		}
		return json;
	}
	/**
	 * 撤销投资债权转让中的记录为不转让的处理
	 * @param investId
	 * @return
	 */
	public boolean cancelTransfering(TProjectInvest invest){
		try{
			QueryFilter queryFilter = new QueryFilter();
			queryFilter.addFilter("investId", invest.getInvestId());
			List<TProjectAccept> accepts = tprojectAcceptService.getAll(queryFilter);
			for(TProjectAccept a:accepts){
				if(0==a.getPaHavePay()&&1==a.getPaTransfering()){//如果撤销前，正在转让中且有还款记录则结算之后才撤销记录
					//更新投资表的已收金额和待收金额
					TprojectService.dealRepaymentAcceptAndInvests(invest, a);
					
					//更新为接收还款的情况为已支付
					a.setPaOldinvestors(0);
					a.setPaHavePay(1);
					tprojectAcceptService.update(a);
				}
			}
			return true;
		}catch(Exception e){
			logger.error("撤销转让记录时，处理支付的过程中异常，业务数据处理失败。");
			throw new RuntimeException(e);
		}
	}

	/**
	 * 投资债权转让成功，如果其中有还款记录的处理
	 * @param investId
	 * @return
	 */
	public boolean successTransfering(TProjectInvest newInvest,TProjectInvest oldInvest){
		try{
			QueryFilter queryFilter = new QueryFilter();
			queryFilter.addFilter("investId", oldInvest.getInvestId());
			List<TProjectAccept> accepts = tprojectAcceptService.getAll(queryFilter);
			for(TProjectAccept a:accepts){
				if(0==a.getPaHavePay()&&1==a.getPaTransfering()){//转让成功后，正在转让中有还款记录的结算
					//更新投资表的已收金额和待收金额
					TprojectService.dealRepaymentAcceptAndInvests(newInvest, a);
					a.setPaOldinvestors(oldInvest.getPiInvestors());//修改接收表的前投资人
					a.setPainvestors(newInvest.getPiInvestors());//修改还款接收人为新的债权人
					//更新为接收还款的情况为已支付
					a.setPaHavePay(1);
					tprojectAcceptService.update(a);
				}
			}
			return true;
		}catch(Exception e){
			logger.error("成功转让记录，处理支付的过程中异常，业务数据处理失败。");
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 
	 * @param transferId
	 * @param type 1：审核转让申请通过 2：审核转让申请不通过 3：审核竞标成功 4：撤回
	 * @throws Exception
	 */
	public String doAction(Long transferId,String type) throws Exception{	
		String retMsg = "操作成功！";
		if(StringUtil.isEmpty(type) || !type.matches("^[1-4]$")){
			throw new Exception("参数不正确！");
		}
		TprojectTransfer transfer = this.getById(transferId);
		if(transfer==null){
			throw new Exception("根据ID"+transferId+"查询不到转让信息");
		}
		TProjectInvest invest = tprojectInvestService.getById(transfer.getInvestId());
		if(invest==null){
			throw new Exception("找不到关联的投资信息！");
		}
		if(transfer.getIsCancel()==1){
			throw new Exception("该笔转让已撤消！");
		}
		if(type.equals("1") || type.equals("2")){ //审核通过/不通过
			if(transfer.getIsCheck()==1){
				throw new Exception("该笔转让已经审核，不能再次审核！");
			}
			if("2".equals(transfer.getStateId())){
				throw new Exception("该笔转让已经完成，不能再审核！");
			}
			if("3".equals(transfer.getStateId())){
				throw new Exception("该笔转让已经失败，不能再审核！");
			}
			if("4".equals(transfer.getStateId())||transfer.getIsCancel()==1){
				throw new Exception("该笔转让已经撤回，不能再审核！");
			}
			Date now = new Date();

			if (type.equals("1")) {
				transfer.setRemarks("审核通过");
				transfer.setStateId("1"); // 转让中
				transfer.setIsCheck(1); // 已审核(通过)
				invest.setPiTransferStateId(1); // 转让中
				Calendar nowCalendar = Calendar.getInstance();
				transfer.setOpenDate(nowCalendar.getTime()); // 竞标开放时间
				nowCalendar.add(Calendar.DAY_OF_MONTH, transfer.getOpenDays());
				transfer.setCloseDate(nowCalendar.getTime()); // 竞标关闭时间
			} else{
				transfer.setStateId("3"); //失败
				transfer.setIsCheck(1); //已审核(不通过)
				invest.setPiTransferStateId(3); //失败
				transfer.setRemarks("审核不通过转失败");
				//相当于转让债权失败，处理其中有还款的记录情况
				cancelTransfering(invest);
			}
			
			transfer.setUpdatetime(now);
			transfer.setChecker(ContextUtil.getCurrentUserId());
			transfer.setCheckTime(now);
			
			this.update(transfer);	
			tprojectInvestService.update(invest);
		}else if(type.equals("3")){ //立标，确认中标人
			if(transfer.getCloseDate().after(new Date())){
				throw new Exception("该笔转让未到关闭时间！");
			}
			if(transfer.getIsCheck()==0){
				throw new Exception("该笔转让未经审核！");
			}
			if("2".equals(transfer.getStateId())){
				throw new Exception("该笔转让已经完成，不能再审核中标！");
			}
			if("3".equals(transfer.getStateId())){
				throw new Exception("该笔转让已经失败，不能再审核中标！");
			}
			if("4".equals(transfer.getStateId())||transfer.getIsCancel()==1){
				throw new Exception("该笔转让已经撤回，不能再审核中标！");
			}
			TprojectAuction hightestAuction = tprojectAuctionService.getHightestAuction(transferId);
			
			if(hightestAuction==null){ //没有竞拍者，则操失败
				invest.setPiTransferStateId(3); //失败
				transfer.setStateId("3"); //失败
				transfer.setRemarks("无竞拍者转失败");
				retMsg = "操作成功，因无竞拍者，该笔转让已转到失败列表。";
				tprojectInvestService.update(invest);
			} else {
				// 取消之前的投标记录 撤销未中标其他指定用户的竞标记录
				List<TprojectAuction> olds = getTprojectAuctionExsit(
						transferId, null);
				for (TprojectAuction o : olds) {
					if (o.getUserId().compareTo(hightestAuction.getUserId())!=0) {
						cacelTransferAciton(transferId, o.getUserId());
					}
				}

				Date now = new Date();
				transfer.setStateId("2"); // 交易成功
				transfer.setBidder(hightestAuction.getUserId()); // 中标人
				transfer.setBidPrice(hightestAuction.getOfferPrice());// 中标价格
				transfer.setBidTime(hightestAuction.getOfferTime()); // 设置为报价时间
				transfer.setTurnoverTime(now);

				invest.setPiTransferStateId(2); // 交易成功
				invest.setPiIsCancel(1);// 设置转让后的投标为取消状态
				hightestAuction.setBidTime(now); // 中标人的中标时间为当前时间
				hightestAuction.setIsBid(1); // 已中标
				tprojectInvestService.update(invest); //更新投资表债权转让人记录	
				TProjectInvest newInvest = new TProjectInvest();
				BeanUtils.copyProperties(invest, newInvest);

				newInvest.setInvestId(UniqueIdUtil.genId());
				newInvest.setPiHavedPayTime(now);
				newInvest.setPiGetSum(new BigDecimal(0));//清空已得本息
				newInvest.setPiGetPrincipalSum(new BigDecimal(0));//清空已得本金
				newInvest.setPiGetRateSum(new BigDecimal(0));//清空已得利息
				newInvest.setPiGetLate(new BigDecimal(0));//清空已得逾期金额
				newInvest.setPiTransferStateId(0);
				newInvest.setPiIsCancel(0);
				newInvest.setPiInvestors(hightestAuction.getUserId());
				// 将冻结资金解冻打入转让成功债权人账户 投资成功减少投资人的冻结资金
				TuserFundsService.userFundsChangeFunction(null, null,
						hightestAuction.getUserId(),
						hightestAuction.getOfferPrice(), null, "9",null,"");

				// 获取债权转让人的账户信息,收入债权转让成功金额
				TuserFundsService.userFundsChangeFunction(null, null,
						transfer.getTransferorId(),
						hightestAuction.getOfferPrice(), null, "5",null,"");

				tprojectInvestService.saveTProjectInvest(newInvest);
				this.successTransfering(newInvest, invest); // 债权转移处理
				
				tprojectAuctionService.update(hightestAuction); //更新投标（竞拍）表
			}
			this.update(transfer); //更改转让表
		}else if(type.equals("4")){ //撤回操作
			if("2".equals(transfer.getStateId())){
				throw new Exception("该笔转让已经完成，不能撤回！");
			}
			if("3".equals(transfer.getStateId())){
				throw new Exception("该笔转让已经失败，不能再撤回！");
			}
			if("4".equals(transfer.getStateId())){
				throw new Exception("该笔转让已经撤回，不能再次撤回！");
			}
			//取消之前的投标记录,不指定特定的用户  撤销所有竞标记录
			cacelTransferAciton(transferId,null);
			
			transfer.setStateId("4"); //撤回
			transfer.setIsCancel(1);  //已撤销
			invest.setPiTransferStateId(4); //撤回
			
			this.cancelTransfering(invest); //其它业务处理
			this.update(transfer);	
			tprojectInvestService.update(invest);
		}
		return retMsg;
	}
	/**
	 * 新增或者修改债权转让竞标信息
	 * @param transferAction
	 * @param trancferPwd
	 */
	public Object addorupdateTprojectAction(HttpServletRequest request,TprojectAuction transferAction, String trancferPwd, TUser user, String type,int modelName,int actionName) {
		JSONObject json = new JSONObject();
		try {
			
			if (user.getTradingPwdErrCount() >= 3) {
				logger.error("交易密码输入错误次数3次!");
				json.put("result", "交易密码输入错误次数3次!请稍候再操作，或者联系客服人员。");
				return json;
			}
			//验证支付密码是否正确
			if(!EncryptUtil.encryptSha256(trancferPwd).equals(userInfoService.getTUserByLoginName(user.getLoginName()).getTradingPwd())){
				user.setTradingPwdErrCount(user.getTradingPwdErrCount()+1);
				userInfoService.editUserInfo(user);
				json.put("result", "交易密码输入错误，如果忘记交易密码请联系客服人员。");
				return json;
			}
			transferAction.setUserId(user.getUserId());
			transferAction.setOfferTime(new Date());
			transferAction.setIsBid(0);
			transferAction.setIsCancel(0);
			transferAction.setHighestPrice(new BigDecimal(0));//竞标未结束，初始化最高价0
			//取消之前的投标记录  撤销指定用户的竞标记录
			cacelTransferAciton(transferAction.getTransferId(),user.getUserId());
			//获取用户的资金记录进行冻结 操作
			TuserFundsService.userFundsChangeFunction(null, null,user.getUserId(), transferAction.getOfferPrice(), null, "3",null,"");//3投资 竞标的类型资金变动
			//新增用户竞标信息
			transferAction.setAuctionId(UniqueIdUtil.genId());
			tprojectAuctionService.add(transferAction);
			
			//如果竞标成功 则 插入竞标的操作记录
			tuserLogService.recordUserOperation(user.getUserId(), modelName, actionName, 1, 1, transferAction.getOfferPrice()+"",request);
			json.put("result", "竞标成功，请等待审核。");
		}catch(Exception e){
			json.put("result", "保存数据异常，请稍后操作。");
			//竞标失败也插入操作记录
			tuserLogService.recordUserOperation(user.getUserId(), modelName, actionName, 1, 2, "竞标操作失败",request);
			throw new RuntimeException();
		}
		return json;
	}
	/**
	 * 当撤销转让债权记录，或者竞标者主动撤销竞标，或者审核竞标成功的时候要处理相应的竞标记录为取消状态，解冻其他投资用户竞标的资金
	 * @param transferId
	 * @throws Exception 
	 */
	public void cacelTransferAciton(Long transferId,Long userId) throws Exception{
		List<TprojectAuction> olds = getTprojectAuctionExsit(transferId,userId);
		for(TprojectAuction old:olds){//如果存在用户的竞标记录则撤销竞标记录
			//获取用户的资金记录进行冻结和解冻操作
			old.setIsCancel(1);//撤销原有的投标记录
			tprojectAuctionService.update(old);
			TuserFundsService.userFundsChangeFunction(null, null, old.getUserId(), old.getOfferPrice(), null, "",null,"");//解冻资金
		}
	}
	
	/**
	 * 暗标时候获取用户是否存在已竞标的记录
	 * @return TprojectAuction
	 */
	public List<TprojectAuction> getTprojectAuctionExsit(Long transferId, Long userId){
		QueryFilter qf = new QueryFilter();
		qf.addFilter("transferId", transferId);
		qf.addFilter("userId", userId);
		qf.addFilter("isCancel", 0);
		List<TprojectAuction> as = tprojectAuctionService.getAll(qf);
		 
		return as;
	}
	/**
	 * 查询债权转让信息For竞标页面控制
	 * @param parameter
	 */
	public TprojectTransfer getTprojectTransferInfo(String transferId) {
		QueryFilter qf = new QueryFilter();
		qf.addFilter("transferId", Long.parseLong(transferId));
		List<TprojectTransfer> as = tprojectTransferDao.getAll(qf);
		if(null!=as&&as.size()>0&&as.get(0).getTransferId()>0){
			return as.get(0);
		}
		return null;
	}
}