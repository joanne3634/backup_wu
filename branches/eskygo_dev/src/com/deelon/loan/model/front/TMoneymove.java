package com.deelon.loan.model.front;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;

import com.deelon.core.model.BaseModel;

/**
 * TMoneymove entity. @author MyEclipse Persistence Tools
 */

public class TMoneymove extends BaseModel implements java.io.Serializable {

	// Fields

	private long moneyMoveId;
	private Long userId;
	private java.lang.Long projectId;
	private long cardId;
	private String typeId;
	private BigDecimal moneyInOut;
	private BigDecimal moneyCurrent;
	private long audit;
	private long checker;
	private Date checkTime;
	private String remark;
	private Timestamp createTime;
	private BigDecimal getFee;
	private String resultId;
	private String serialNo;
	private Integer isOffLine;//是否线下支付
	//非持久化
	 private BigDecimal chargeMoneyTotal;
	 private BigDecimal drawMoneyTotal;
	 private String createTimeS;
	 private Timestamp beginDate;
	 private Timestamp endDate;
	 private Date createTimeBegin;
	 private Date createTimeEnd;
	 private String realName;
	 private String pname;//项目名称
	private String timeBucket;
	private String moneyType;
	private String currentDate; 
	private String flowCode;//交易流水号
	public String getInCharge() {
		return inCharge;
	}

	public void setInCharge(String inCharge) {
		this.inCharge = inCharge;
	}

	private String inCharge;
	
	public String getMoneyType() {
		return moneyType;
	}

	public void setMoneyType(String moneyType) {
		this.moneyType = moneyType;
	}

	public String getFlowCode() {
		return flowCode;
	}

	public void setFlowCode(String flowCode) {
		this.flowCode = flowCode;
	}

	// Constructors
	 private String applyName;
	 public String getApplyName() {
		return applyName;
	}

	public void setApplyName(String applyName) {
		this.applyName = applyName;
	}

	private String userName;
	 
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	/** default constructor */
	public TMoneymove() {
	}

	/** full constructor */
	public TMoneymove(long cardId, String typeId, BigDecimal moneyInOut, 
			BigDecimal moneyCurrent, short audit, long checker, Timestamp checkTime,
			String remark, Timestamp createTime,String resultId) {
		this.resultId =resultId;
		this.cardId = cardId;
		this.typeId = typeId;
	
		this.audit = audit;
		this.checker = checker;
		this.checkTime = checkTime;
		this.remark = remark;
		this.createTime = createTime;
	}

	// Property accessors

	public String getResultId() {
		return resultId;
	}

	public void setResultId(String resultId) {
		this.resultId = resultId;
	}

	public long getMoneyMoveId() {
		return this.moneyMoveId;
	}

	public void setMoneyMoveId(long moneyMoveId) {
		this.moneyMoveId = moneyMoveId;
	}

	public long getCardId() {
		return this.cardId;
	}

	public void setCardId(long cardId) {
		this.cardId = cardId;
	}

	public String getTypeId() {
		return this.typeId;
	}

	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}

	

	public BigDecimal getMoneyInOut() {
		return moneyInOut;
	}

	public void setMoneyInOut(BigDecimal moneyInOut) {
		this.moneyInOut = moneyInOut;
	}

	public BigDecimal getMoneyCurrent() {
		return moneyCurrent;
	}

	public void setMoneyCurrent(BigDecimal moneyCurrent) {
		this.moneyCurrent = moneyCurrent;
	}

	public long getAudit() {
		return this.audit;
	}

	public void setAudit(long audit) {
		this.audit = audit;
	}

	public long getChecker() {
		return this.checker;
	}

	public void setChecker(long checker) {
		this.checker = checker;
	}

	public Date getCheckTime() {
		return this.checkTime;
	}

	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public BigDecimal getGetFee() {
		return getFee;
	}

	public void setGetFee(BigDecimal getFee) {
		this.getFee = getFee;
	}

	public BigDecimal getChargeMoneyTotal() {
		return chargeMoneyTotal;
	}

	public void setChargeMoneyTotal(BigDecimal chargeMoneyTotal) {
		this.chargeMoneyTotal = chargeMoneyTotal;
	}

	public BigDecimal getDrawMoneyTotal() {
		return drawMoneyTotal;
	}

	public void setDrawMoneyTotal(BigDecimal drawMoneyTotal) {
		this.drawMoneyTotal = drawMoneyTotal;
	}

	public String getCreateTimeS() {
		return createTimeS;
	}

	public void setCreateTimeS(String createTimeS) {
		this.createTimeS = createTimeS;
	}

	public Timestamp getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Timestamp beginDate) {
		this.beginDate = beginDate;
	}

	public Timestamp getEndDate() {
		return endDate;
	}

	public void setEndDate(Timestamp endDate) {
		this.endDate = endDate;
	}

	public Date getCreateTimeBegin() {
		return createTimeBegin;
	}

	public void setCreateTimeBegin(Date createTimeBegin) {
		this.createTimeBegin = createTimeBegin;
	}

	public Date getCreateTimeEnd() {
		return createTimeEnd;
	}

	public void setCreateTimeEnd(Date createTimeEnd) {
		this.createTimeEnd = createTimeEnd;
	}

	public String getTimeBucket() {
		return timeBucket;
	}

	public void setTimeBucket(String timeBucket) {
		this.timeBucket = timeBucket;
	}

	public String getCurrentDate() {
		return currentDate;
	}

	public void setCurrentDate(String currentDate) {
		this.currentDate = currentDate;
	}

	public java.lang.Long getProjectId() {
		return projectId;
	}

	public void setProjectId(java.lang.Long projectId) {
		this.projectId = projectId;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getSerialNo() {
		return serialNo;
	}

	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}

	public Integer getIsOffLine() {
		return isOffLine;
	}

	public void setIsOffLine(Integer isOffLine) {
		this.isOffLine = isOffLine;
	}
	
}