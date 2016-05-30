package com.deelon.loan.model.front;

import java.math.BigDecimal;

import com.deelon.core.model.BaseModel;

/**
 * TUserFunds entity. @author MyEclipse Persistence Tools
 */

public class TUserFunds extends BaseModel {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -8393609789432822212L;
	private long fundsId;
	private long userId;
	private BigDecimal balance;
	private BigDecimal freeze;
	private BigDecimal available;
	private BigDecimal fundsIn;
	private BigDecimal fundsOut;
	private Integer creditOut;
	private Integer creditIn;
	private BigDecimal limitMaxIn;
	private BigDecimal limitMaxOut;
	private String payMark;//支付平台标识号
	private String userName;
	
	private TUser user;

	
	
	/**
	 *
	 *
	 * @return
	 */
	public String getPayMark() {
		return payMark;
	}

	/**
	 *
	 *
	 * @param payMark
	 */
	public void setPayMark( String payMark ) {
		this.payMark = payMark;
	}

	public TUser getUser() {
		return user;
	}

	public void setUser(TUser user) {
		this.user = user;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	// 非持久化
	private String fileId;// 图片附件id 附件表

	private String realName;// 用户名字 用户表
	private String loginName;// 登录账号 用户表
	private String tradingPwd;// 交易密码

	private String bindMobile;// 是否绑定手机 用户安全表
	private String bindEmail;// 是否绑定邮箱 ..
	private String bindCard;// 是否绑定身份证

	private double balanceS;
	private String balanceStr;
	private String safebar;// 安全进度条
	private String safePercentum;// 安静进度条百分比
	private BigDecimal rechargeMoney;// 充值费用
	private BigDecimal actualPayMent;// 实际支付金额

	private BigDecimal chargeMoneyProportion;
	
	private BigDecimal piEffectAmountTotal;//投资总额
	private BigDecimal ploanRealTotal;//贷款总额

	// Constructors

	/** default constructor */
	public TUserFunds() {
	}

	/** full constructor */
	public TUserFunds(long userId, BigDecimal balance, BigDecimal freeze,
			BigDecimal available, BigDecimal fundsIn, BigDecimal fundsOut,
			Integer creditOut, Integer creditIn, String userName) {
		this.userId = userId;
		this.balance = balance;
		this.freeze = freeze;
		this.available = available;
		this.fundsIn = fundsIn;
		this.fundsOut = fundsOut;
		this.creditOut = creditOut;
		this.creditIn = creditIn;
		this.userName = userName;
	}

	// Property accessors

	public long getFundsId() {
		return this.fundsId;
	}

	public void setFundsId(long fundsId) {
		this.fundsId = fundsId;
	}

	public long getUserId() {
		return this.userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public BigDecimal getBalance() {
		return this.balance;
	}

	public void setBalance(BigDecimal balance) {
		this.balance = balance;
	}

	public BigDecimal getFreeze() {
		if(freeze==null){
			this.freeze=new BigDecimal(0.0);
		}
		return this.freeze;
	}

	public void setFreeze(BigDecimal freeze) {
		this.freeze = freeze;
	}

	public BigDecimal getAvailable() {
		if(available==null){
			this.available=new BigDecimal(0.0);
		}
		return this.available;
	}

	public void setAvailable(BigDecimal available) {
		this.available = available;
	}

	public BigDecimal getFundsIn() {
		return this.fundsIn;
	}

	public void setFundsIn(BigDecimal fundsIn) {
		this.fundsIn = fundsIn;
	}

	public BigDecimal getFundsOut() {
		return this.fundsOut;
	}

	public void setFundsOut(BigDecimal fundsOut) {
		this.fundsOut = fundsOut;
	}

	public Integer getCreditOut() {
		return this.creditOut;
	}

	public void setCreditOut(Integer creditOut) {
		this.creditOut = creditOut;
	}

	public Integer getCreditIn() {
		return this.creditIn;
	}

	public void setCreditIn(Integer creditIn) {
		this.creditIn = creditIn;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public double getBalanceS() {
		return balanceS;
	}

	public void setBalanceS(double balanceS) {
		this.balanceS = balanceS;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getTradingPwd() {
		return tradingPwd;
	}

	public void setTradingPwd(String tradingPwd) {
		this.tradingPwd = tradingPwd;
	}

	public String getBindMobile() {
		return bindMobile;
	}

	public void setBindMobile(String bindMobile) {
		this.bindMobile = bindMobile;
	}

	public String getBindEmail() {
		return bindEmail;
	}

	public void setBindEmail(String bindEmail) {
		this.bindEmail = bindEmail;
	}

	public String getBindCard() {
		return bindCard;
	}

	public void setBindCard(String bindCard) {
		this.bindCard = bindCard;
	}

	public String getSafebar() {
		return safebar;
	}

	public void setSafebar(String safebar) {
		this.safebar = safebar;
	}

	public String getSafePercentum() {
		return safePercentum;
	}

	public void setSafePercentum(String safePercentum) {
		this.safePercentum = safePercentum;
	}

	public BigDecimal getRechargeMoney() {
		return rechargeMoney;
	}

	public void setRechargeMoney(BigDecimal rechargeMoney) {
		this.rechargeMoney = rechargeMoney;
	}

	public BigDecimal getActualPayMent() {
		return actualPayMent;
	}

	public void setActualPayMent(BigDecimal actualPayMent) {
		this.actualPayMent = actualPayMent;
	}

	public BigDecimal getChargeMoneyProportion() {
		return chargeMoneyProportion;
	}

	public void setChargeMoneyProportion(BigDecimal chargeMoneyProportion) {
		this.chargeMoneyProportion = chargeMoneyProportion;
	}
	
	

	public BigDecimal getPiEffectAmountTotal() {
		return piEffectAmountTotal;
	}

	public void setPiEffectAmountTotal(BigDecimal piEffectAmountTotal) {
		this.piEffectAmountTotal = piEffectAmountTotal;
	}

	public BigDecimal getPloanRealTotal() {
		return ploanRealTotal;
	}

	public void setPloanRealTotal(BigDecimal ploanRealTotal) {
		this.ploanRealTotal = ploanRealTotal;
	}
	
	

	

	public String getBalanceStr() {
		return balanceStr;
	}

	public void setBalanceStr(String balanceStr) {
		this.balanceStr = balanceStr;
	}

	@Override
	public String toString() {
		return "TUserFunds [fundsId=" + fundsId + ", userId=" + userId
				+ ", balance=" + balance + ", freeze=" + freeze
				+ ", available=" + available + ", fundsIn=" + fundsIn
				+ ", fundsOut=" + fundsOut + ", creditOut=" + creditOut
				+ ", creditIn=" + creditIn + ", fileId=" + fileId
				+ ", realName=" + realName + ", loginName=" + loginName
				+ ", tradingPwd=" + tradingPwd + ", bindMobile=" + bindMobile
				+ ", bindEmail=" + bindEmail + ", bindCard=" + bindCard
				+ ", balanceS=" + balanceS + ", safebar=" + safebar
				+ ", safePercentum=" + safePercentum + ", rechargeMoney="
				+ rechargeMoney + ", actualPayMent=" + actualPayMent
				+ ", chargeMoneyProportion=" + chargeMoneyProportion + "]";
	}

	public BigDecimal getLimitMaxIn() {
		return limitMaxIn;
	}

	public void setLimitMaxIn(BigDecimal limitMaxIn) {
		this.limitMaxIn = limitMaxIn;
	}

	public BigDecimal getLimitMaxOut() {
		return limitMaxOut;
	}

	public void setLimitMaxOut(BigDecimal limitMaxOut) {
		this.limitMaxOut = limitMaxOut;
	}
}