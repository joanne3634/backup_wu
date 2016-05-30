package com.deelon.loan.model.front;

import java.math.BigDecimal;
import java.util.Date;

import com.deelon.core.model.BaseModel;

/**
 * TProjectInvest entity. @author MyEclipse Persistence Tools
 */

public class TProjectInvest extends BaseModel {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3750029550321163545L;
	// Fields

	private long investId;
	private long projectId;
	private long piInvestors;
	private BigDecimal piAmount;
	private BigDecimal piEffectAmount;
	private Date piBidTime;
	private int piHavedPay;
	private Date piHavedPayTime;//PI_HavedPayTime打款时间
	private int piIsCancel;//PI_IsCancel是否取消投标   
	private String pitypeID;
	
	private Date popenDate;
	private int prCurrent;
	
	private BigDecimal piGetSum;//已收金额
	private BigDecimal piBeGetSum;//待收金额
	private BigDecimal piGetRateSum;//已收利息
	private BigDecimal piBeGetRateSum;//待收利息
	private BigDecimal piGetPrincipalSum;//已收本金
	private BigDecimal piBeGetPrincipalSum;//待收本金
	private BigDecimal piGetLate;//已收罚金
	private int piIsPayoff;//PI_IsPayoff是否取消投标   
	private int piTransferStateId;//PI_TransferStateId
	private int piTransferCount;//PI_TransferCount是否取消投标   
	private long transferId;
	private String offerName;//债权转让投标出价人
	private BigDecimal upsetPrice;//转让低价
	private BigDecimal hieghtestPrice;//转让目前最高价
	private Date closeDate;//转让债权截止日
	private String transferorIdName;
	private String myPrice;//债权转让我的出价
	private String isCancel;//债权转让是否取消
	
	//非持久化
	private String pname;
	private String piBidTimeStr;
	private String prateOut;
	private String piHavedPayStr;
	
	private String sm_t_PA_Interest;//已转利息
	private String sm_t_PA_Late;//以赚罚息
	private String sm_benxi;//已回收本息
	private String sm_Balance;//资金总计
	private String sm_PI_EffectAmount;/*总借出金额*/
	private String sm_totOutnum;/*总借出笔数*/
	private String sm_totIn; /*已收回笔数*/
	private String sm_applying;/*申请中*/
	private String sm_expect;/*预期*/
	private String sm_daichang;/*代偿*/
	private String sm_Natural_repayMent;/*正常还款*/
	private String sm_compleate_repayMent;/*已完成*/
	private String sm_yidaichang;/*已代偿*/
	private String sm_zhengchangPayment;/*正常还款(还清)*/
	private String sm_tiqianPayMent;/*提前还款*/
	private String sm_benjin;//本金 已还款(包含已经还完的)金额
	private String sm_daihuanbenxi;//待还本息
	private String sm_waitInBenxi;
	private String sm_totIn_ing;//待收回,持有中
	private String waitInNum;
//	 pa.PA_PayBackTime,u.RealName,p.P_Deadline, ,pa.PA_Interest
	 private String paPayBackTime;
	 private String realName;
	 private String loginName;
	 private int pDeadline;
	 private BigDecimal paInterest;
	 private String deadlineNum;
	 
	 private Date beginDate1;
	 private Date endDate1;
	 private String beginDateS1;
	 private String endDateS1;
	 private Date beginDate2;
	 private Date endDate2;
	 private String beginDateS2;
	 private String endDateS2;
	 private Date beginDate3;
	 private Date endDate3;
	 private String beginDateS3;
	 private String endDateS3;
	 
	 private Long userId;
	 
	 private TProject project; //投资对应贷款
	// Constructors

	/** default constructor */
	public TProjectInvest() {
	}

	public TProjectInvest(long projectId, long piInvestors) {
		this.projectId=projectId;
		this.piInvestors=piInvestors;
	}

	/** full constructor */
	public TProjectInvest(long projectId, long piInvestors, BigDecimal piAmount,
			BigDecimal piEffectAmount, Date piBidTime, int piHavedPay,
			Date piHavedPayTime) {
		this.projectId = projectId;
		this.piInvestors = piInvestors;
		this.piAmount = piAmount;
		this.piEffectAmount = piEffectAmount;
		this.piBidTime = piBidTime;
		this.piHavedPay = piHavedPay;
		this.piHavedPayTime = piHavedPayTime;
	}

	public String getIsCancel() {
		return isCancel;
	}

	public void setIsCancel(String isCancel) {
		this.isCancel = isCancel;
	}

	// Property accessors
	public long getTransferId() {
		return transferId;
	}

	public void setTransferId(long transferId) {
		this.transferId = transferId;
	}
	
	public String getTransferorIdName() {
		return transferorIdName;
	}

	public void setTransferorIdName(String transferorIdName) {
		this.transferorIdName = transferorIdName;
	}

	public String getMyPrice() {
		return myPrice;
	}

	public void setMyPrice(String myPrice) {
		this.myPrice = myPrice;
	}

	public Date getCloseDate() {
		return closeDate;
	}

	public void setCloseDate(Date closeDate) {
		this.closeDate = closeDate;
	}

	public String getOfferName() {
		return offerName;
	}

	public void setOfferName(String offerName) {
		this.offerName = offerName;
	}

	public BigDecimal getUpsetPrice() {
		return upsetPrice;
	}

	public void setUpsetPrice(BigDecimal upsetPrice) {
		this.upsetPrice = upsetPrice;
	}

	public BigDecimal getHieghtestPrice() {
		return hieghtestPrice;
	}

	public void setHieghtestPrice(BigDecimal hieghtestPrice) {
		this.hieghtestPrice = hieghtestPrice;
	}

	public Date getPopenDate() {
		return popenDate;
	}

	public void setPopenDate(Date popenDate) {
		this.popenDate = popenDate;
	}

	public int getPrCurrent() {
		return prCurrent;
	}

	public void setPrCurrent(int prCurrent) {
		this.prCurrent = prCurrent;
	}
	public BigDecimal getPiGetSum() {
		return piGetSum;
	}

	public void setPiGetSum(BigDecimal piGetSum) {
		this.piGetSum = piGetSum;
	}

	public BigDecimal getPiBeGetSum() {
		return piBeGetSum;
	}

	public void setPiBeGetSum(BigDecimal piBeGetSum) {
		this.piBeGetSum = piBeGetSum;
	}

	public BigDecimal getPiGetRateSum() {
		return piGetRateSum;
	}

	public void setPiGetRateSum(BigDecimal piGetRateSum) {
		this.piGetRateSum = piGetRateSum;
	}

	public BigDecimal getPiBeGetRateSum() {
		return piBeGetRateSum;
	}

	public void setPiBeGetRateSum(BigDecimal piBeGetRateSum) {
		this.piBeGetRateSum = piBeGetRateSum;
	}

	public BigDecimal getPiGetPrincipalSum() {
		return piGetPrincipalSum;
	}

	public void setPiGetPrincipalSum(BigDecimal piGetPrincipalSum) {
		this.piGetPrincipalSum = piGetPrincipalSum;
	}

	public BigDecimal getPiBeGetPrincipalSum() {
		return piBeGetPrincipalSum;
	}

	public void setPiBeGetPrincipalSum(BigDecimal piBeGetPrincipalSum) {
		this.piBeGetPrincipalSum = piBeGetPrincipalSum;
	}

	public BigDecimal getPiGetLate() {
		return piGetLate;
	}

	public void setPiGetLate(BigDecimal piGetLate) {
		this.piGetLate = piGetLate;
	}

	public int getPiIsPayoff() {
		return piIsPayoff;
	}

	public void setPiIsPayoff(int piIsPayoff) {
		this.piIsPayoff = piIsPayoff;
	}

	public int getPiTransferStateId() {
		return piTransferStateId;
	}

	public void setPiTransferStateId(int piTransferStateId) {
		this.piTransferStateId = piTransferStateId;
	}

	public int getPiTransferCount() {
		return piTransferCount;
	}

	public void setPiTransferCount(int piTransferCount) {
		this.piTransferCount = piTransferCount;
	}

	public long getInvestId() {
		return this.investId;
	}

	public void setInvestId(long investId) {
		this.investId = investId;
	}

	public long getProjectId() {
		return this.projectId;
	}

	public void setProjectId(long projectId) {
		this.projectId = projectId;
	}

	public long getPiInvestors() {
		return this.piInvestors;
	}

	public void setPiInvestors(long piInvestors) {
		this.piInvestors = piInvestors;
	}

	public BigDecimal getPiAmount() {
		return this.piAmount;
	}

	public void setPiAmount(BigDecimal piAmount) {
		this.piAmount = piAmount;
	}

	public BigDecimal getPiEffectAmount() {
		return this.piEffectAmount;
	}

	public void setPiEffectAmount(BigDecimal piEffectAmount) {
		this.piEffectAmount = piEffectAmount;
	}

	public Date getPiBidTime() {
		return this.piBidTime;
	}

	public void setPiBidTime(Date piBidTime) {
		this.piBidTime = piBidTime;
	}

	public int getPiHavedPay() {
		return this.piHavedPay;
	}

	public void setPiHavedPay(int piHavedPay) {
		this.piHavedPay = piHavedPay;
	}

	public Date getPiHavedPayTime() {
		return this.piHavedPayTime;
	}

	public void setPiHavedPayTime(Date piHavedPayTime) {
		this.piHavedPayTime = piHavedPayTime;
	}

	public int getPiIsCancel() {
		return piIsCancel;
	}

	public void setPiIsCancel(int piIsCancel) {
		this.piIsCancel = piIsCancel;
	}

	public String getPitypeID() {
		return pitypeID;
	}

	public void setPitypeID(String pitypeID) {
		this.pitypeID = pitypeID;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getPiBidTimeStr() {
		return piBidTimeStr;
	}

	public void setPiBidTimeStr(String piBidTimeStr) {
		this.piBidTimeStr = piBidTimeStr;
	}

	public String getPrateOut() {
		return prateOut;
	}

	public void setPrateOut(String prateOut) {
		this.prateOut = prateOut;
	}

	public String getPiHavedPayStr() {
		return piHavedPayStr;
	}

	public void setPiHavedPayStr(String piHavedPayStr) {
		this.piHavedPayStr = piHavedPayStr;
	}

	public String getSm_t_PA_Interest() {
		return sm_t_PA_Interest;
	}

	public void setSm_t_PA_Interest(String sm_t_PA_Interest) {
		this.sm_t_PA_Interest = sm_t_PA_Interest;
	}

	public String getSm_t_PA_Late() {
		return sm_t_PA_Late;
	}

	public void setSm_t_PA_Late(String sm_t_PA_Late) {
		this.sm_t_PA_Late = sm_t_PA_Late;
	}

	public String getSm_benxi() {
		return sm_benxi;
	}

	public void setSm_benxi(String sm_benxi) {
		this.sm_benxi = sm_benxi;
	}

	

	public String getSm_Balance() {
		return sm_Balance;
	}

	public void setSm_Balance(String sm_Balance) {
		this.sm_Balance = sm_Balance;
	}

	public String getSm_PI_EffectAmount() {
		return sm_PI_EffectAmount;
	}

	public void setSm_PI_EffectAmount(String sm_PI_EffectAmount) {
		this.sm_PI_EffectAmount = sm_PI_EffectAmount;
	}

	public String getSm_totOutnum() {
		return sm_totOutnum;
	}

	public void setSm_totOutnum(String sm_totOutnum) {
		this.sm_totOutnum = sm_totOutnum;
	}

	public String getSm_totIn() {
		return sm_totIn;
	}

	public void setSm_totIn(String sm_totIn) {
		this.sm_totIn = sm_totIn;
	}

	public String getSm_applying() {
		return sm_applying;
	}

	public void setSm_applying(String sm_applying) {
		this.sm_applying = sm_applying;
	}

	public String getSm_expect() {
		return sm_expect;
	}

	public void setSm_expect(String sm_expect) {
		this.sm_expect = sm_expect;
	}

	public String getSm_daichang() {
		return sm_daichang;
	}

	public void setSm_daichang(String sm_daichang) {
		this.sm_daichang = sm_daichang;
	}

	public String getSm_Natural_repayMent() {
		return sm_Natural_repayMent;
	}

	public void setSm_Natural_repayMent(String sm_Natural_repayMent) {
		this.sm_Natural_repayMent = sm_Natural_repayMent;
	}

	public String getSm_compleate_repayMent() {
		return sm_compleate_repayMent;
	}

	public void setSm_compleate_repayMent(String sm_compleate_repayMent) {
		this.sm_compleate_repayMent = sm_compleate_repayMent;
	}

	public String getSm_yidaichang() {
		return sm_yidaichang;
	}

	public void setSm_yidaichang(String sm_yidaichang) {
		this.sm_yidaichang = sm_yidaichang;
	}

	public String getSm_zhengchangPayment() {
		return sm_zhengchangPayment;
	}

	public void setSm_zhengchangPayment(String sm_zhengchangPayment) {
		this.sm_zhengchangPayment = sm_zhengchangPayment;
	}

	public String getSm_tiqianPayMent() {
		return sm_tiqianPayMent;
	}

	public void setSm_tiqianPayMent(String sm_tiqianPayMent) {
		this.sm_tiqianPayMent = sm_tiqianPayMent;
	}

	public String getSm_waitInBenxi() {
		return sm_waitInBenxi;
	}

	public void setSm_waitInBenxi(String sm_waitInBenxi) {
		this.sm_waitInBenxi = sm_waitInBenxi;
	}

	public String getWaitInNum() {
		return waitInNum;
	}

	public void setWaitInNum(String waitInNum) {
		this.waitInNum = waitInNum;
	}

	public String getPaPayBackTime() {
		return paPayBackTime;
	}

	public void setPaPayBackTime(String paPayBackTime) {
		this.paPayBackTime = paPayBackTime;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public int getpDeadline() {
		return pDeadline;
	}

	public void setpDeadline(int pDeadline) {
		this.pDeadline = pDeadline;
	}

	public BigDecimal getPaInterest() {
		return paInterest;
	}

	public void setPaInterest(BigDecimal paInterest) {
		this.paInterest = paInterest;
	}

	public String getDeadlineNum() {
		return deadlineNum;
	}

	public void setDeadlineNum(String deadlineNum) {
		this.deadlineNum = deadlineNum;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Date getBeginDate1() {
		return beginDate1;
	}

	public void setBeginDate1(Date beginDate1) {
		this.beginDate1 = beginDate1;
	}

	public Date getEndDate1() {
		return endDate1;
	}

	public void setEndDate1(Date endDate1) {
		this.endDate1 = endDate1;
	}

	

	public Date getBeginDate2() {
		return beginDate2;
	}

	public void setBeginDate2(Date beginDate2) {
		this.beginDate2 = beginDate2;
	}

	public Date getEndDate2() {
		return endDate2;
	}

	public void setEndDate2(Date endDate2) {
		this.endDate2 = endDate2;
	}

	

	public Date getBeginDate3() {
		return beginDate3;
	}

	public void setBeginDate3(Date beginDate3) {
		this.beginDate3 = beginDate3;
	}

	public Date getEndDate3() {
		return endDate3;
	}

	public void setEndDate3(Date endDate3) {
		this.endDate3 = endDate3;
	}

	public String getBeginDateS1() {
		return beginDateS1;
	}

	public void setBeginDateS1(String beginDateS1) {
		this.beginDateS1 = beginDateS1;
	}

	public String getEndDateS1() {
		return endDateS1;
	}

	public void setEndDateS1(String endDateS1) {
		this.endDateS1 = endDateS1;
	}

	public String getBeginDateS2() {
		return beginDateS2;
	}

	public void setBeginDateS2(String beginDateS2) {
		this.beginDateS2 = beginDateS2;
	}

	public String getEndDateS2() {
		return endDateS2;
	}

	public void setEndDateS2(String endDateS2) {
		this.endDateS2 = endDateS2;
	}

	public String getBeginDateS3() {
		return beginDateS3;
	}

	public void setBeginDateS3(String beginDateS3) {
		this.beginDateS3 = beginDateS3;
	}

	public String getEndDateS3() {
		return endDateS3;
	}

	public void setEndDateS3(String endDateS3) {
		this.endDateS3 = endDateS3;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getSm_benjin() {
		return sm_benjin;
	}

	public void setSm_benjin(String sm_benjin) {
		this.sm_benjin = sm_benjin;
	}

	public String getSm_daihuanbenxi() {
		return sm_daihuanbenxi;
	}

	public void setSm_daihuanbenxi(String sm_daihuanbenxi) {
		this.sm_daihuanbenxi = sm_daihuanbenxi;
	}

	public TProject getProject() {
		return project;
	}

	public void setProject(TProject project) {
		this.project = project;
	}

	public String getSm_totIn_ing() {
		return sm_totIn_ing;
	}

	public void setSm_totIn_ing(String sm_totIn_ing) {
		this.sm_totIn_ing = sm_totIn_ing;
	}

	
	
	
	
	

}