package com.deelon.loan.model.front;

import java.math.BigDecimal;
import java.util.Date;

import com.deelon.core.model.BaseModel;

/**
 * TProject entity. @author MyEclipse Persistence Tools
 */

public class TProject extends BaseModel {

	/**
	 * 
	 */
	private static final long serialVersionUID = -67415324545181043L;
	// Fields
	private BigDecimal psumHavedPayPrincipal;        
	private BigDecimal psumHavedPayInterest;
	private BigDecimal psumFee;//总费用
	private BigDecimal pfee;//已付费用
	private BigDecimal pprepay;//提前还款违约金
	private long projectId;
	private long productsLoanId;
	private String pname;
	private String pstatusId;
	private String ptypeId;
	private java.lang.String pcertifiLevel;
	private java.lang.String pclerk;
	private BigDecimal ploan;
	private BigDecimal ploanReal;
	private BigDecimal prate;
	private BigDecimal prateIn;
	private BigDecimal prateOut;
//	private String pCertifiLevel;
	private Integer pdeadline;
	private String prepayWay;
	private Integer pcomplete;
	private Integer pbided;
	private Integer pminInvest;
	private java.lang.Integer pmaxInvest;
	private Integer pviewed;
	private String pdesc;
	private long papplicant;
	private Date papplicationTime;
	private Date popenDate;
	private Date pcloseDate;
	private short phavedPay;
	private Date phavedPayTime;
	private long phavedPayer;//放款人
//	private String priskRate;
//	private BigDecimal prisk;
//	private short pauditGuarantee;
	private short pauditPlatform;
	private short pisFull;
	private short pisBreak;
	private int pbreakTimes;
	private short pisSetup;
	private short pisLate;//P_IsLate
	private Integer plateDays;//P_LateDays
	private short pisPayOff;//P_IsPayOff
//	private BigDecimal preplacePay;
//	private short pisRepayCompleted;
	private BigDecimal psumPayBack;
	private BigDecimal psumInterest;
	private BigDecimal psumHavedPay;
	private BigDecimal psumLateHavedPay;
	private BigDecimal psumLate;
	private short pdel;
	private String pbreakRemark;//流标说明
	private Date pupdateTime;
	private int popenDays;
	private int currentNum;//当前已还期数
	
	// 非持久化
	private String applyName;
	private String alinkAction;
	private String auditStatus;
	private Date beginDate;
	private Date endDate;
	
	private String appleyTime;
	
	private String Invitation;
	private String timeRemaining;
	private String popenDateStr;
	private String pComplateStr;
	private String pcloaseDateStr;
	
	private int pihavedPay;// 
	private BigDecimal pieffectAmount;
	private Date pibidTime;
	private String pcNo;//项目合同编号
	private String fileId;// 图片附件id 附件表
	
	private String havedPayTimeStr;
	private int counts;
	private BigDecimal sumLoan;
	private Long userId;
	
	
	private String contractNo;
	
	private String successNum;
	private String isbreakNum;
	
	private BigDecimal pieffectAmountTotal;
	private BigDecimal psumHavedPayInterestTotal;//已赚还利息
	private BigDecimal psumHavedPaytotalInterest;//总的待还本息
	private BigDecimal piBeGetRateSum;//待收回利息
	private BigDecimal prateOutavg;
	private int countNum;
	private String produ_name;
	private BigDecimal psumHavedPayTotal;//待还本金
	//private BigDecimal psumHavedPayInterestTotal;
	private BigDecimal psumLateTotal;
	private BigDecimal payMoneyTotal;
	private String userCreditInfo;
	
	//risk
	private BigDecimal prrisk;
	private BigDecimal prriskRate;//担保金比例
	private String prriskRateStr;//担保金比例
	private long prcompay;
	private int praudit;
	private int prisReplacePay;
	private BigDecimal prreplacePay;
	private java.sql.Timestamp prreplacePayTime;
	private String riskName;//担保公司名称
	private String pradvice;
	private String pdeadlineS;
	// Constructors

	/** default constructor */
	public TProject() {
	}

	public TProject(long projectId, long productsLoanId, String pname,
			String pstatusId, BigDecimal ploan, BigDecimal ploanReal,
			BigDecimal prate, BigDecimal prateIn, BigDecimal prateOut,
			Integer pdeadline, String prepayWay, Integer pcomplete,
			Integer pbided, Integer pminInvest, Integer pviewed, String pdesc,
			long papplicant, Date papplicationTime, Date popenDate,
			Date pcloseDate, short phavedPay, Date phavedPayTime,
			String priskRate, BigDecimal prisk, short pauditGuarantee,
			short pauditPlatform, short pisFull, short pisSetup,
			short pisOverdue, Integer poverdueDays, short pisReplacePay,
			BigDecimal preplacePay, short pisRepayCompleted,
			BigDecimal psumPayBack, BigDecimal psumInterest,
			BigDecimal psumHavedPay, short pdel) {
		super();
		this.projectId = projectId;
		this.productsLoanId = productsLoanId;
		this.pname = pname;
		this.pstatusId = pstatusId;
		this.ploan = ploan;
		this.ploanReal = ploanReal;
		this.prate = prate;
		this.prateIn = prateIn;
		this.prateOut = prateOut;
		this.pdeadline = pdeadline;
		this.prepayWay = prepayWay;
		this.pcomplete = pcomplete;
		this.pbided = pbided;
		this.pminInvest = pminInvest;
		this.pviewed = pviewed;
		this.pdesc = pdesc;
		this.papplicant = papplicant;
		this.papplicationTime = papplicationTime;
		this.popenDate = popenDate;
		this.pcloseDate = pcloseDate;
		this.phavedPay = phavedPay;
		this.phavedPayTime = phavedPayTime;
//		this.priskRate = priskRate;
//		this.prisk = prisk;
//		this.pauditGuarantee = pauditGuarantee;
		this.pauditPlatform = pauditPlatform;
		this.pisFull = pisFull;
		this.pisSetup = pisSetup;
//		this.preplacePay = preplacePay;
//		this.pisRepayCompleted = pisRepayCompleted;
		this.psumPayBack = psumPayBack;
		this.psumInterest = psumInterest;
		this.psumHavedPay = psumHavedPay;
		this.pdel = pdel;
	}
	
	public long getPhavedPayer() {
		return phavedPayer;
	}

	public void setPhavedPayer(long phavedPayer) {
		this.phavedPayer = phavedPayer;
	}

	public BigDecimal getPrrisk() {
		return prrisk;
	}

	public void setPrrisk(BigDecimal prrisk) {
		this.prrisk = prrisk;
	}

	public long getPrcompay() {
		return prcompay;
	}

	public void setPrcompay(long prcompay) {
		this.prcompay = prcompay;
	}

	public int getPraudit() {
		return praudit;
	}

	public void setPraudit(int praudit) {
		this.praudit = praudit;
	}

	public int getPrisReplacePay() {
		return prisReplacePay;
	}

	public void setPrisReplacePay(int prisReplacePay) {
		this.prisReplacePay = prisReplacePay;
	}

	public BigDecimal getPrreplacePay() {
		return prreplacePay;
	}

	public void setPrreplacePay(BigDecimal prreplacePay) {
		this.prreplacePay = prreplacePay;
	}

	public java.sql.Timestamp getPrreplacePayTime() {
		return prreplacePayTime;
	}

	public void setPrreplacePayTime(java.sql.Timestamp prreplacePayTime) {
		this.prreplacePayTime = prreplacePayTime;
	}

	public String getPradvice() {
		return pradvice;
	}

	public void setPradvice(String pradvice) {
		this.pradvice = pradvice;
	}

	public int getCounts() {
		return counts;
	}

	public void setCounts(int counts) {
		this.counts = counts;
	}

	public BigDecimal getSumLoan() {
		return sumLoan;
	}

	public void setSumLoan(BigDecimal sumLoan) {
		this.sumLoan = sumLoan;
	}

	public BigDecimal getPsumHavedPayPrincipal() {
		return psumHavedPayPrincipal;
	}

	public void setPsumHavedPayPrincipal(BigDecimal psumHavedPayPrincipal) {
		this.psumHavedPayPrincipal = psumHavedPayPrincipal;
	}

	public BigDecimal getPsumHavedPayInterest() {
		return psumHavedPayInterest;
	}

	public void setPsumHavedPayInterest(BigDecimal psumHavedPayInterest) {
		this.psumHavedPayInterest = psumHavedPayInterest;
	}

	public BigDecimal getPsumFee() {
		return psumFee;
	}

	public void setPsumFee(BigDecimal psumFee) {
		this.psumFee = psumFee;
	}

	public BigDecimal getPfee() {
		return pfee;
	}

	public void setPfee(BigDecimal pfee) {
		this.pfee = pfee;
	}

	public BigDecimal getPprepay() {
		return pprepay;
	}

	public void setPprepay(BigDecimal pprepay) {
		this.pprepay = pprepay;
	}

	public String getHavedPayTimeStr() {
		return havedPayTimeStr;
	}

	public void setHavedPayTimeStr(String havedPayTimeStr) {
		this.havedPayTimeStr = havedPayTimeStr;
	}
	public String getPcNo() {
		return pcNo;
	}

	public void setPcNo(String pcNo) {
		this.pcNo = pcNo;
	}

	public long getProjectId() {
		return projectId;
	}

	public void setProjectId(long projectId) {
		this.projectId = projectId;
	}

	public long getProductsLoanId() {
		return productsLoanId;
	}

	public void setProductsLoanId(long productsLoanId) {
		this.productsLoanId = productsLoanId;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getPstatusId() {
		return pstatusId;
	}

	public void setPstatusId(String pstatusId) {
		this.pstatusId = pstatusId;
	}

	public BigDecimal getPloan() {
		return ploan;
	}

	public void setPloan(BigDecimal ploan) {
		this.ploan = ploan;
	}

	public BigDecimal getPloanReal() {
		return ploanReal;
	}

	public void setPloanReal(BigDecimal ploanReal) {
		this.ploanReal = ploanReal;
	}

	public BigDecimal getPrate() {
		return prate;
	}

	public void setPrate(BigDecimal prate) {
		this.prate = prate;
	}

	public BigDecimal getPrateIn() {
		return prateIn;
	}

	public void setPrateIn(BigDecimal prateIn) {
		this.prateIn = prateIn;
	}

	public BigDecimal getPrateOut() {
		return prateOut;
	}

	public void setPrateOut(BigDecimal prateOut) {
		this.prateOut = prateOut;
	}

	public Integer getPdeadline() {
		return pdeadline;
	}

	public void setPdeadline(Integer pdeadline) {
		this.pdeadline = pdeadline;
	}

	public String getPrepayWay() {
		return prepayWay;
	}

	public void setPrepayWay(String prepayWay) {
		this.prepayWay = prepayWay;
	}

	public Integer getPcomplete() {
		return pcomplete;
	}

	public void setPcomplete(Integer pcomplete) {
		this.pcomplete = pcomplete;
	}

	public Integer getPbided() {
		return pbided;
	}

	public void setPbided(Integer pbided) {
		this.pbided = pbided;
	}

	public Integer getPminInvest() {
		return pminInvest;
	}

	public void setPminInvest(Integer pminInvest) {
		this.pminInvest = pminInvest;
	}

	public Integer getPviewed() {
		return pviewed;
	}

	public void setPviewed(Integer pviewed) {
		this.pviewed = pviewed;
	}

	public String getPdesc() {
		return pdesc;
	}

	public void setPdesc(String pdesc) {
		this.pdesc = pdesc;
	}

	public long getPapplicant() {
		return papplicant;
	}

	public void setPapplicant(long papplicant) {
		this.papplicant = papplicant;
	}

	public Date getPapplicationTime() {
		return papplicationTime;
	}

	public void setPapplicationTime(Date papplicationTime) {
		this.papplicationTime = papplicationTime;
	}

	public Date getPopenDate() {
		return popenDate;
	}

	public void setPopenDate(Date popenDate) {
		this.popenDate = popenDate;
	}

	public Date getPcloseDate() {
		return pcloseDate;
	}

	public void setPcloseDate(Date pcloseDate) {
		this.pcloseDate = pcloseDate;
	}

	public short getPhavedPay() {
		return phavedPay;
	}

	public void setPhavedPay(short phavedPay) {
		this.phavedPay = phavedPay;
	}

	public Date getPhavedPayTime() {
		return phavedPayTime;
	}

	public void setPhavedPayTime(Date phavedPayTime) {
		this.phavedPayTime = phavedPayTime;
	}

	/*public String getPriskRate() {
		return priskRate;
	}

	public void setPriskRate(String priskRate) {
		this.priskRate = priskRate;
	}

	public BigDecimal getPrisk() {
		return prisk;
	}

	public void setPrisk(BigDecimal prisk) {
		this.prisk = prisk;
	}

	public short getPauditGuarantee() {
		return pauditGuarantee;
	}

	public void setPauditGuarantee(short pauditGuarantee) {
		this.pauditGuarantee = pauditGuarantee;
	}*/

	public short getPauditPlatform() {
		return pauditPlatform;
	}

	public void setPauditPlatform(short pauditPlatform) {
		this.pauditPlatform = pauditPlatform;
	}

	public short getPisFull() {
		return pisFull;
	}

	public void setPisFull(short pisFull) {
		this.pisFull = pisFull;
	}

	public short getPisBreak() {
		return pisBreak;
	}

	public void setPisBreak(short pisBreak) {
		this.pisBreak = pisBreak;
	}

	public short getPisSetup() {
		return pisSetup;
	}

	public int getPbreakTimes() {
		return pbreakTimes;
	}

	public void setPbreakTimes(int pbreakTimes) {
		this.pbreakTimes = pbreakTimes;
	}

	public void setPisSetup(short pisSetup) {
		this.pisSetup = pisSetup;
	}
	
	

	public short getPisLate() {
		return pisLate;
	}

	public void setPisLate(short pisLate) {
		this.pisLate = pisLate;
	}

	public Integer getPlateDays() {
		return plateDays;
	}

	public void setPlateDays(Integer plateDays) {
		this.plateDays = plateDays;
	}



	/*public BigDecimal getPreplacePay() {
		return preplacePay;
	}

	public void setPreplacePay(BigDecimal preplacePay) {
		this.preplacePay = preplacePay;
	}

	public short getPisRepayCompleted() {
		return pisRepayCompleted;
	}

	public void setPisRepayCompleted(short pisRepayCompleted) {
		this.pisRepayCompleted = pisRepayCompleted;
	}*/

	public short getPisPayOff() {
		return pisPayOff;
	}

	public void setPisPayOff(short pisPayOff) {
		this.pisPayOff = pisPayOff;
	}

	public BigDecimal getPsumPayBack() {
		return psumPayBack;
	}

	public void setPsumPayBack(BigDecimal psumPayBack) {
		this.psumPayBack = psumPayBack;
	}

	public BigDecimal getPsumInterest() {
		return psumInterest;
	}

	public void setPsumInterest(BigDecimal psumInterest) {
		this.psumInterest = psumInterest;
	}

	

	public BigDecimal getPsumHavedPay() {
		return psumHavedPay;
	}

	public void setPsumHavedPay(BigDecimal psumHavedPay) {
		this.psumHavedPay = psumHavedPay;
	}

	public short getPdel() {
		return pdel;
	}

	public void setPdel(short pdel) {
		this.pdel = pdel;
	}

	public String getApplyName() {
		return applyName;
	}

	public void setApplyName(String applyName) {
		this.applyName = applyName;
	}

	

	/*public String getpCertifiLevel() {
		return pCertifiLevel;
	}

	public void setpCertifiLevel(String pCertifiLevel) {
		this.pCertifiLevel = pCertifiLevel;
	}
	*/
	

	public String getPtypeId() {
		return ptypeId;
	}

	public void setPtypeId(String ptypeId) {
		this.ptypeId = ptypeId;
	}

	public String getAlinkAction() {
		return alinkAction;
	}

	public void setAlinkAction(String alinkAction) {
		this.alinkAction = alinkAction;
	}

	
	public String getAuditStatus() {
		return auditStatus;
	}

	public void setAuditStatus(String auditStatus) {
		this.auditStatus = auditStatus;
	}
	
	

	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	

	public java.lang.String getPcertifiLevel() {
		return pcertifiLevel;
	}

	public void setPcertifiLevel(java.lang.String pcertifiLevel) {
		this.pcertifiLevel = pcertifiLevel;
	}

	public java.lang.String getPclerk() {
		return pclerk;
	}

	public void setPclerk(java.lang.String pclerk) {
		this.pclerk = pclerk;
	}

	public java.lang.Integer getPmaxInvest() {
		return pmaxInvest;
	}

	public void setPmaxInvest(java.lang.Integer pmaxInvest) {
		this.pmaxInvest = pmaxInvest;
	}

	public BigDecimal getPsumLateHavedPay() {
		return psumLateHavedPay;
	}

	public void setPsumLateHavedPay(BigDecimal psumLateHavedPay) {
		this.psumLateHavedPay = psumLateHavedPay;
	}

	public BigDecimal getPsumLate() {
		return psumLate;
	}

	public void setPsumLate(BigDecimal psumLate) {
		this.psumLate = psumLate;
	}
	
	

	public String getAppleyTime() {
		return appleyTime;
	}

	public void setAppleyTime(String appleyTime) {
		this.appleyTime = appleyTime;
	}
	
	

	public String getInvitation() {
		return Invitation;
	}

	public void setInvitation(String invitation) {
		Invitation = invitation;
	}

	public String getTimeRemaining() {
		return timeRemaining;
	}

	public void setTimeRemaining(String timeRemaining) {
		this.timeRemaining = timeRemaining;
	}
	
	

	public String getPopenDateStr() {
		return popenDateStr;
	}

	public void setPopenDateStr(String popenDateStr) {
		this.popenDateStr = popenDateStr;
	}

	
	public String getpComplateStr() {
		return pComplateStr;
	}

	public void setpComplateStr(String pComplateStr) {
		this.pComplateStr = pComplateStr;
	}
	
	

	public String getPbreakRemark() {
		return pbreakRemark;
	}

	public void setPbreakRemark(String pbreakRemark) {
		this.pbreakRemark = pbreakRemark;
	}
	

	public String getPcloaseDateStr() {
		return pcloaseDateStr;
	}

	public void setPcloaseDateStr(String pcloaseDateStr) {
		this.pcloaseDateStr = pcloaseDateStr;
	}
	
	

	public int getPihavedPay() {
		return pihavedPay;
	}

	public void setPihavedPay(int pihavedPay) {
		this.pihavedPay = pihavedPay;
	}

	public BigDecimal getPieffectAmount() {
		return pieffectAmount;
	}

	public void setPieffectAmount(BigDecimal pieffectAmount) {
		this.pieffectAmount = pieffectAmount;
	}

	public Date getPibidTime() {
		return pibidTime;
	}

	public void setPibidTime(Date pibidTime) {
		this.pibidTime = pibidTime;
	}
	
	

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}
	
	

	public Date getPupdateTime() {
		return pupdateTime;
	}

	public void setPupdateTime(Date pupdateTime) {
		this.pupdateTime = pupdateTime;
	}
	
	

	public String getContractNo() {
		return contractNo;
	}

	public void setContractNo(String contractNo) {
		this.contractNo = contractNo;
	}

	public String getSuccessNum() {
		return successNum;
	}

	public void setSuccessNum(String successNum) {
		this.successNum = successNum;
	}

	public String getIsbreakNum() {
		return isbreakNum;
	}

	public void setIsbreakNum(String isbreakNum) {
		this.isbreakNum = isbreakNum;
	}
	
	

	public BigDecimal getPieffectAmountTotal() {
		return pieffectAmountTotal;
	}

	public void setPieffectAmountTotal(BigDecimal pieffectAmountTotal) {
		this.pieffectAmountTotal = pieffectAmountTotal;
	}

	public BigDecimal getPsumHavedPayInterestTotal() {
		return psumHavedPayInterestTotal;
	}

	public void setPsumHavedPayInterestTotal(BigDecimal psumHavedPayInterestTotal) {
		this.psumHavedPayInterestTotal = psumHavedPayInterestTotal;
	}

	

	public BigDecimal getPrateOutavg() {
		return prateOutavg;
	}

	public void setPrateOutavg(BigDecimal prateOutavg) {
		this.prateOutavg = prateOutavg;
	}

	public int getCountNum() {
		return countNum;
	}

	public void setCountNum(int countNum) {
		this.countNum = countNum;
	}

	public String getProdu_name() {
		return produ_name;
	}

	public void setProdu_name(String produ_name) {
		this.produ_name = produ_name;
	}
	
	

	public BigDecimal getPsumHavedPayTotal() {
		return psumHavedPayTotal;
	}

	public void setPsumHavedPayTotal(BigDecimal psumHavedPayTotal) {
		this.psumHavedPayTotal = psumHavedPayTotal;
	}

	public BigDecimal getPsumLateTotal() {
		return psumLateTotal;
	}

	public void setPsumLateTotal(BigDecimal psumLateTotal) {
		this.psumLateTotal = psumLateTotal;
	}

	
	public BigDecimal getPayMoneyTotal() {
		return payMoneyTotal;
	}

	public void setPayMoneyTotal(BigDecimal payMoneyTotal) {
		this.payMoneyTotal = payMoneyTotal;
	}
	
	

	public String getUserCreditInfo() {
		return userCreditInfo;
	}

	public void setUserCreditInfo(String userCreditInfo) {
		this.userCreditInfo = userCreditInfo;
	}

	
	public int getPopenDays() {
		return popenDays;
	}

	public void setPopenDays(int popenDays) {
		this.popenDays = popenDays;
	}
	
	

	public String getRiskName() {
		return riskName;
	}

	public void setRiskName(String riskName) {
		this.riskName = riskName;
	}
	
	

	public BigDecimal getPrriskRate() {
		return prriskRate;
	}

	public void setPrriskRate(BigDecimal prriskRate) {
		this.prriskRate = prriskRate;
	}
	

	public String getPdeadlineS() {
		return pdeadlineS;
	}

	public void setPdeadlineS(String pdeadlineS) {
		this.pdeadlineS = pdeadlineS;
	}
	
	

	
	public BigDecimal getPsumHavedPaytotalInterest() {
		return psumHavedPaytotalInterest;
	}

	public void setPsumHavedPaytotalInterest(BigDecimal psumHavedPaytotalInterest) {
		this.psumHavedPaytotalInterest = psumHavedPaytotalInterest;
	}
	
	

	public String getPrriskRateStr() {
		return prriskRateStr;
	}

	public void setPrriskRateStr(String prriskRateStr) {
		this.prriskRateStr = prriskRateStr;
	}
	
	

	public BigDecimal getPiBeGetRateSum() {
		return piBeGetRateSum;
	}

	public void setPiBeGetRateSum(BigDecimal piBeGetRateSum) {
		this.piBeGetRateSum = piBeGetRateSum;
	}

	@Override
	public String toString() {
		return "TProject [projectId=" + projectId + ", productsLoanId="
				+ productsLoanId + ", pname=" + pname + ", pstatusId="
				+ pstatusId + ", pTypeID=" + ptypeId + ", ploan=" + ploan
				+ ", ploanReal=" + ploanReal + ", prate=" + prate
				+ ", prateIn=" + prateIn + ", prateOut=" + prateOut
				+ ","
				// pCertifiLevel=" + pCertifiLevel + ", "
						+ "pdeadline="
				+ pdeadline + ", prepayWay=" + prepayWay + ", pcomplete="
				+ pcomplete + ", pbided=" + pbided + ", pminInvest="
				+ pminInvest + ", pviewed=" + pviewed + ", pdesc=" + pdesc
				+ ", papplicant=" + papplicant + ", papplicationTime="
				+ papplicationTime + ", popenDate=" + popenDate
				+ ", pcloseDate=" + pcloseDate + ", phavedPay=" + phavedPay
				+ ", phavedPayTime=" + phavedPayTime + ", "
					/*	+ "priskRate="
				+ priskRate + ", prisk=" + prisk + ", pauditGuarantee="
				+ pauditGuarantee + ","*/
						+ " pauditPlatform=" + pauditPlatform
				+ ", pisFull=" + pisFull + ", pisSetup=" + pisSetup
				+ ", pisOverdue=" + ", "
					/*	+ "preplacePay=" + preplacePay + ", pisRepayCompleted="
				+ pisRepayCompleted + ","*/
						+ " psumPayBack=" + psumPayBack
				+ ", psumInterest=" + psumInterest + ", psumHavedPayBack="
				+ psumHavedPay + ", pdel=" + pdel + ", applyName="
				+ applyName + "]";
	}

	public int getCurrentNum() {
		return currentNum;
	}

	public void setCurrentNum(int currentNum) {
		this.currentNum = currentNum;
	}
	
	
	
	
	// Property accessors
}