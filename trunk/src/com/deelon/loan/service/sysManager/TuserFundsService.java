/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.service.sysManager;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.common.TSettingParem;
import com.deelon.loan.dao.front.TbankcardDao;
import com.deelon.loan.dao.front.TmoneymoveDao;
import com.deelon.loan.dao.sysManager.TuserFundsDao;
import com.deelon.loan.model.backstage.TSettings;
import com.deelon.loan.model.front.TBankcard;
import com.deelon.loan.model.front.TMoneymove;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.service.backstage.TSettingsService;
import com.deelon.loan.service.front.TuserTaskcompleteService;
import com.deelon.loan.service.front.UserInfoService;
import com.deelon.payform.common.PayCommon;

@ Service
public class TuserFundsService extends BaseService<TUserFunds>{
	
	@ Resource
	private TuserFundsDao tuserFundsDao;
	@ Resource
	private TbankcardDao tbankcardDao;
	@ Resource
	private TmoneymoveDao tmoneymoveDao;
	@ Resource
	private TuserTaskcompleteService userTaskcompleteService;
	@ Resource
	private UserInfoService userInfoService;
	@Resource
	private TSettingsService tsettingsService;
	
	protected IEntityDao<TUserFunds, Long> getEntityDao()
	{
		return this.tuserFundsDao;
	}
	
	public TUserFunds getTUserFundsByUserId(Long id){
		return tuserFundsDao.getTUserFundsByUserId(id);
	}
	
	public void saveOrUpdateTUserFunds(TUserFunds tu){
		tuserFundsDao.saveOrUpdateTUserFunds(tu);
	}
	
	public TUserFunds getByUserId(Long id){
		return tuserFundsDao.getByUserId(id);
	}
	
	/**
	 * 获取用户的理财资产 借款资产 账户余额
	 * @param userId
	 * @return
	 */
	public TUserFunds getPersonalAssetsByUserId(Long userId){
		return tuserFundsDao.getPersonalAssetsByUserId(userId);
	}
	
	/**
	 * 充值
	 */
	
	public void rechargeMoney(long currentUserId,String rechargeMoey,String chargeMoney_id,String bankCardId,String flowCode) throws Exception{
			//先校验用户有没有绑定银行卡
			
			List<TBankcard> list=tbankcardDao.getTBankcardByUserId(currentUserId);
			if(list.size()==0){
				throw new Exception("请先绑定银行卡!");
			}
			try {
				//调用银行接口
				//bankReturnCode 为银行接口返回的 付款信息..这里先模拟,
				//模拟bankReturnCode=Pay_Success
				
				
				String bankReturnCode="Pay_Success";
				
				if(bankReturnCode.equals("Pay_Success")){//付款成功
					//更新t_user_funds表
					userFundsChangeFunction(list, null, currentUserId, new BigDecimal(rechargeMoey),new BigDecimal(chargeMoney_id), "1",bankCardId,flowCode);//充值
					//userTaskcompleteService.viweAddcredit(currentUserId, 2);    //p2p的任务，众筹先注释掉
					
				}
			} catch (Exception e) {
				e.printStackTrace();
				// TODO: handle exception
				logger.error(e.getMessage());
				e.printStackTrace();
				throw new Exception("操作出现异常,请联系管理员!");
			}
			
				
				
				
			
		
		
	}
	
	/**
	 * 修改user funds 和资金记录
	 * 
	 * TMoneymove t 资金记录 可以为空
	 * @return
	 */
	public synchronized boolean saveOrUpdateToFunds(TUserFunds tuserFunds,TMoneymove tmoneymove) throws Exception{
		
		try {
			 tuserFundsDao.update(tuserFunds);
			 
				if(tmoneymove!=null){
					tmoneymoveDao.add(tmoneymove);	
				}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		 
			
	}
	/**
	 * 用户资金变动同步公共方法
	 * @param list 银行卡list，充值时需要，其他情况可为空
	 * @param userFunds 如果调用时已经获取到用户的资金对象则直接传入，否则必须传入用户id获取用户资金信息对象处理
	 * @param userId 必须传入用户id用于处理用户账户信息的依据
	 * @param change 接口重要参数，必须传入，用于用户资金变动的参数信息
	 * @param fee 如果有手续费需要传入交易的手续费
	 * @param type 记录用户资金变动的类型
	 * @return boolean
	 * @throws Exception
	 */
	public synchronized boolean userFundsChangeFunction(List<TBankcard> list, TUserFunds userFunds, Long userId,BigDecimal change,BigDecimal fee,String type,String bankCardId,String flowCode) throws Exception{
		boolean flag = false;
		TMoneymove t = null; 
		String bankCardNo = null;
		//是否打开在线支付开关(1：打开)
		String openOnlinePayment = (String)AppUtil.getServletContext().getAttribute("INTERVIEWS_TIMESPAN");
		if(null==userFunds){//如果参数传过来没有用户资金对象，则通过用户id查询用户资金对象
			userFunds = userInfoService.getUserFundsInfo(userId);
			
		}
		if(StringUtils.isNotEmpty(openOnlinePayment) && StringUtils.isNotBlank(openOnlinePayment)){
			if(StringUtil.isNotEmpty(bankCardId)){
				bankCardNo = bankCardId.trim();
			}else{
				bankCardNo = list.get(0).getBankCardId()+"";
			}
		}else{
			bankCardNo = list.get(0).getBankCardId()+"";
		}
		if("1".equals(type)){//充值
			//userFunds.setAvailable(userFunds.getAvailable().add(change));需通过审核才可用金额
			userFunds.setFundsIn(userFunds.getFundsIn().add(change));//充值总额(扣除手续费)
		    userFunds.setAvailable(userFunds.getAvailable().add(change));//可用金额 = 可用金额 + 充值金额(扣除手续费)
			userFunds.setBalance(userFunds.getBalance().add(change));//账户余额=账户余额+充值金额(扣除手续费)
				
			//t_money_move 资金记录
			t=new TMoneymove(); 
			t.setMoneyMoveId(UniqueIdUtil.genId());
			t.setUserId(userFunds.getUserId());
			t.setCardId(Long.valueOf(bankCardNo));//这里 如果有多个银行卡的话，就先取第一个
			t.setTypeId(type);//充值
			
			if(StringUtils.isNotEmpty(openOnlinePayment) && StringUtils.isNotBlank(openOnlinePayment)){
				//先注释allen 需要在线支付通过后才回写进
				//t.setChecker(userFunds.getUserId());//在线支付默认审批通过
				//t.setCheckTime(new Timestamp(System.currentTimeMillis()));
			}
			t.setMoneyInOut(change);
			t.setMoneyCurrent(userFunds.getBalance().subtract(change));//t_user_funds表的账户余额
			t.setCreateTime(new Timestamp(System.currentTimeMillis()));
			t.setGetFee(fee);//手续费	
			t.setResultId("2");//默认是不通过的 allen
			t.setRemark("充值失败");//allen
			t.setAudit(0);//默认是不通过的allen
			t.setFlowCode(flowCode);//加入充值流水号后期对帐可以allen
			if(StringUtils.isNotEmpty(openOnlinePayment) && StringUtils.isNotBlank(openOnlinePayment)){
				//先注释allen 需要在线支付通过后才回写进
				//t.setAudit(1);
				//t.setRemark("充值成功");
			}
			t.setSerialNo("");	
		}else if("3".equals(type)){//投标
			userFunds.setAvailable(userFunds.getAvailable().subtract(change));
			userFunds.setFreeze(userFunds.getFreeze().add(change));//冻结资金++
			userFunds.setBalance(userFunds.getAvailable().add(userFunds.getFreeze()));
				
			t = new TMoneymove(); 
			t.setMoneyMoveId(UniqueIdUtil.genId());
			t.setUserId(userFunds.getUserId());
			t.setCardId(Long.valueOf(bankCardNo));//这里 如果有多个银行卡的话，就先取第一个
			t.setTypeId(type);//投资/投标
			t.setMoneyInOut(change);
			t.setMoneyCurrent(userFunds.getBalance());//t_user_funds表的账户余额
			t.setCreateTime(new Timestamp(System.currentTimeMillis()));
			t.setGetFee(new BigDecimal(0));//手续费
			t.setResultId("1");
			t.setAudit(0);
			t.setChecker(0);
			t.setRemark("");
			t.setSerialNo("");
		}else if("4".equals(type)){//还款
			userFunds.setAvailable(userFunds.getAvailable().subtract(change));
			userFunds.setBalance(userFunds.getAvailable().add(userFunds.getFreeze()));
				
			t=new TMoneymove(); 
			t.setMoneyMoveId(UniqueIdUtil.genId());
			t.setUserId(userFunds.getUserId());
			t.setCardId(Long.valueOf(bankCardNo));//这里 如果有多个银行卡的话，就先取第一个（ 无银行卡）
			t.setTypeId(type);//还款
			t.setRemark("还款");
			t.setResultId("1");
			t.setMoneyInOut(change);
			t.setMoneyCurrent(userFunds.getAvailable());//t_user_funds表的账户余额
			t.setCreateTime(new Timestamp(System.currentTimeMillis()));
			t.setGetFee(new BigDecimal(0));//手续费
			t.setSerialNo("");	
		}else if("5".equals(type)){//收益
			userFunds.setAvailable(userFunds.getAvailable().add(change));
			userFunds.setBalance(userFunds.getAvailable().add(userFunds.getFreeze()));
				
			t = new TMoneymove(); 
			t.setMoneyMoveId(UniqueIdUtil.genId());
			t.setUserId(userFunds.getUserId());
			t.setCardId(Long.valueOf(bankCardNo));//这里 如果有多个银行卡的话，就先取第一个（ 无银行卡）
			t.setTypeId(type);//收益
			t.setRemark("收益");
			t.setResultId("1");
			t.setMoneyInOut(change);
			t.setMoneyCurrent(userFunds.getBalance());//t_user_funds表的账户余额
			t.setCreateTime(new Timestamp(System.currentTimeMillis()));
			t.setGetFee(new BigDecimal(0));//手续费
			t.setSerialNo("");	
		}else if("9".equals(type)){//交易成功，减少投资人冻结资金
			userFunds.setFreeze(userFunds.getFreeze().subtract(change));//解冻资金减少，交易成功
			userFunds.setBalance(userFunds.getAvailable().add(userFunds.getFreeze()));
				
			t=new TMoneymove(); 
			t.setMoneyMoveId(UniqueIdUtil.genId());
			t.setUserId(userFunds.getUserId());
			t.setCardId(Long.valueOf(bankCardNo));//这里 如果有多个银行卡的话，就先取第一个
			t.setTypeId(type);//解冻资金
			t.setMoneyInOut(change);
			
			t.setMoneyCurrent(userFunds.getBalance());//t_user_funds表的账户余额
			t.setCreateTime(new Timestamp(System.currentTimeMillis()));
			t.setGetFee(new BigDecimal(0));//手续费
			t.setResultId("1");
			t.setAudit(0);
			t.setChecker(0);
			t.setRemark("");
			t.setSerialNo("");	
		}else if("10".equals(type)){//平台利率差收入
			 
			t=new TMoneymove(); 
			t.setMoneyMoveId(UniqueIdUtil.genId());
			t.setUserId(userFunds.getUserId());
			t.setCardId(Long.valueOf(bankCardNo));//这里 如果有多个银行卡的话，就先取第一个
			t.setTypeId(type);//平台利率差收益  类型值为10
			t.setResultId("1");
			t.setMoneyInOut(change);
			t.setMoneyCurrent((null==t.getMoneyCurrent()? new BigDecimal(0):t.getMoneyCurrent()).add(change));//平台记录收入后金额
			t.setCreateTime(new Timestamp(System.currentTimeMillis()));
			t.setGetFee(new BigDecimal(0));//手续费
			t.setRemark("平台利率收入");
			t.setSerialNo("");	
		}else if("12".equals(type)){//询价诚意金
			userFunds.setFreeze(userFunds.getFreeze().add(change));//冻结资金++
			userFunds.setBalance(userFunds.getAvailable().add(userFunds.getFreeze()));
			t=new TMoneymove(); 
			t.setMoneyMoveId(UniqueIdUtil.genId());
			t.setUserId(userFunds.getUserId());
			t.setCardId(Long.valueOf(bankCardNo));//这里 如果有多个银行卡的话，就先取第一个
			t.setTypeId(type);//询价诚意金  类型值为12
			t.setResultId("1");
			t.setMoneyInOut(change);
			t.setMoneyCurrent((null==t.getMoneyCurrent()? new BigDecimal(0):t.getMoneyCurrent()).add(change));//平台记录收入后金额
			t.setCreateTime(new Timestamp(System.currentTimeMillis()));
			t.setGetFee(new BigDecimal(0));//手续费
			t.setRemark("询价诚意金");
			t.setSerialNo("");	
		}
		else{//撤销投资，用户投资时冻结的资金解冻
			userFunds.setAvailable(userFunds.getAvailable().add(change));
			userFunds.setFreeze(userFunds.getFreeze().subtract(change));//解冻资金++
			userFunds.setBalance(userFunds.getAvailable().add(userFunds.getFreeze()));
		}
			
		
		flag = saveOrUpdateToFunds(userFunds, t);
		
		return flag;
		
	}
	/**
	 * 
	 * @param userId//用户id
	 * @param typeId 资金类型 
	 * @param moneyIn //金额
	 * @param currentMoney 当前账户余额
	 * @param getFee 手续费
	 */
	public void inMoneyMove(long userId,String typeId,BigDecimal moneyIn,BigDecimal currentMoney,BigDecimal getFee){
		//资金记录 资金记录表插入一条记录
		TMoneymove t=new TMoneymove(); 
		t.setMoneyMoveId(UniqueIdUtil.genId());
		t.setUserId(userId);
		t.setCardId(0);//这里 如果有多个银行卡的话，就先取第一个
		t.setTypeId(typeId);//充值
		t.setResultId("1");
		t.setMoneyInOut(moneyIn);//实际招标金额-平台手续费-担保金
		t.setMoneyCurrent(currentMoney);//t_user_funds表的账户余额
		t.setCreateTime(new Timestamp(System.currentTimeMillis()));
		t.setGetFee(getFee);//手续费
		t.setRemark("");
		t.setSerialNo("");
		tmoneymoveDao.add(t);
	}
	public TUserFunds getfundsCredit(Long userId){
		return tuserFundsDao.getfundsCredit(userId);
	}

	public void drawBackMoney(long userId,String backMoney,String cardid,boolean flag,String flowCode) {
		// TODO Auto-generated method stub
		//取得提现手续费
		
		//体现手续费 这里不设置,手续费交给第三方托管来处理,
	/*	TSettings setting =tsettingsService.getTSettingsBySetCode(TSettingParem.HandingCharge.drawMoney);
		String setValue = "";
		if(setting.getSetValue().contains("%")){
			String percent = setting.getSetValue().substring(0,setting.getSetValue().length()-1);
			if(StringUtils.isNotEmpty(percent) && StringUtils.isNotBlank(percent)){
				Double pc  = Double.parseDouble(setting.getSetValue())/100;
				setValue = (new BigDecimal(backMoney).doubleValue()*pc)+""; 
			}
		}else{
			Double pc  = Double.parseDouble(setting.getSetValue())/100;
			Double setValue2 = new BigDecimal(backMoney).doubleValue() * pc;
			setValue = setValue2.toString();
		}*/
		
		TUserFunds sf=tuserFundsDao.getTUserFundsByUserId(userId);
		if(sf!=null){
			/*sf.setAvailable(sf.getAvailable().subtract(new BigDecimal(backMoney)));//可用金额- 提现金额元
			sf.setBalance(sf.getBalance().subtract(new BigDecimal(backMoney)));//账户余额 - 提现金额元
			if(sf.getFundsOut()!=null){// 提现总额
				sf.setFundsOut(sf.getFundsOut().add(new BigDecimal(backMoney).multiply(new BigDecimal(-1))));
			}else{
				sf.setFundsOut(new BigDecimal(backMoney).multiply(new BigDecimal(-1)));//
			}*/
			if(flag){
				tuserFundsDao.update(sf);//提现成功后才更新
				TMoneymove m=tmoneymoveDao.getByIdFlowCode(flowCode);
				m.setAudit(1);// 
				m.setResultId("1");//默认先失败
				m.setMoneyCurrent(sf.getBalance());
				m.setRemark("提现成功");
				m.setChecker(userId);
				m.setCheckTime(new Timestamp(System.currentTimeMillis()));
				tmoneymoveDao.update(m);
			}else{
				TMoneymove m=new TMoneymove();
				long tcardid = new Long(cardid).longValue();
				m.setMoneyMoveId(UniqueIdUtil.genId());
				m.setUserId(userId);
				m.setCardId(tcardid);
				m.setMoneyInOut(new BigDecimal(backMoney).multiply(new BigDecimal(-1)));
				m.setGetFee(new BigDecimal(0));//在这里 手续费有 双乾这边负责扣除,当提现成功后返回扣除的手续费
				m.setMoneyCurrent(sf.getBalance()/*.add(new BigDecimal(backMoney))*/ );//当前金额 等体现成功后 再加上去
				m.setCreateTime(new java.sql.Timestamp(System.currentTimeMillis()));
				m.setAudit(0);//默认提现是失败的
				m.setTypeId("2");//提现
				m.setChecker(0L);
				m.setSerialNo("");
				m.setCheckTime(new Timestamp(System.currentTimeMillis()));
				m.setResultId("2");//默认先失败
				m.setRemark("提现失败");
				m.setFlowCode(flowCode);//提前流水号
				tmoneymoveDao.add(m);
			}
			 
		}
	}
	
	/**
	 * 查询用户资金信息
	 * @param queryFilter
	 * @return
	 */
	public List<TUserFunds> getUserFundsList(QueryFilter queryFilter){
		return tuserFundsDao.getUserFundsList(queryFilter);
	}
}