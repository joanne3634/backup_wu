package com.deelon.loan.model.project;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 贷款项目T_Project
 * @author qvn
 *
 */
public class LoanProject implements java.io.Serializable{

	private long projectId;//Project_id贷款项目ID
	private String pName;//P_Name项目名称
	private long productsLoanId;//ProductsLoan_id贷款产品ID
	private String pStatusId;//P_StatusID项目状态
	private BigDecimal pLoan;//P_Loan贷款金额
	private BigDecimal pLoanReal;//P_LoanReal实际贷款金额	
	private BigDecimal pRateIn;//P_Rate_In利率（借入）
	private BigDecimal pRateOut;//P_Rate_Out	利率(借出)
	private int pDeadline;//P_Deadline期限(月)
	private String pRepayWay;//P_RepayWay	还款方式
	private int pComplete;//P_Complete完成进度
	private int pBided;//P_Bided总投标数	
	private int pMinInvest;//P_MinInvest最小投资额
	private int pViewed;//P_Viewed浏览量	
	private String pDesc;//P_Desc借款详情
	private int pApplicant;//P_Applicant申请人	
	private Date pApplicationTime;//P_ApplicationTime申请时间
	private Date pOpenDate;//P_OpenDate开放投标时间	
	private Date pCloseDate;//P_CloseDate结束投标时间
	private int pHavedPay;//P_HavedPay平台放款
	private Date pHavedPayTime;//Project_id平台放款时间
	private String pRiskRate;//P_RiskRate风险金(担保金额)比例	
	private BigDecimal pRisk;//P_Risk风险金(担保金额)
	private int pAuditGuarantee;//ProductsLoan_id担保审核
	private int pAuditPlatform;//P_Audit_Platform平台审核
	private int pIsFull;//P_MinInvest是否满标
	private int pIsSetup;//P_IsSetup是否借款成立	
	private int pIsOverdue;//P_IsOverdue是否逾期
	private int pOverdueDays;//P_OverdueDays逾期天数	
	private int pIsReplacePay;//P_IsReplacePay是否担保机构代还款
	private BigDecimal pReplacePay;//P_ReplacePay担保机构代还款金额	
	private int pIsRepayCompleted;//P_IsRepayCompleted是否完成还款
	private BigDecimal pSumPayBack;//P_SumPayBack应偿还总额
	private BigDecimal pSumInterest;//P_SumInterest利息总额
	private BigDecimal pSumHavedPayBack;//P_SumHavedPayBack已偿还总额	
	private int PDel;//P_Del删除
	public long getProjectId() {
		return projectId;
	}
	public void setProjectId(long projectId) {
		this.projectId = projectId;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public long getProductsLoanId() {
		return productsLoanId;
	}
	public void setProductsLoanId(long productsLoanId) {
		this.productsLoanId = productsLoanId;
	}
	public String getpStatusId() {
		return pStatusId;
	}
	public void setpStatusId(String pStatusId) {
		this.pStatusId = pStatusId;
	}
	public BigDecimal getpLoan() {
		return pLoan;
	}
	public void setpLoan(BigDecimal pLoan) {
		this.pLoan = pLoan;
	}
	public BigDecimal getpLoanReal() {
		return pLoanReal;
	}
	public void setpLoanReal(BigDecimal pLoanReal) {
		this.pLoanReal = pLoanReal;
	}
	public BigDecimal getpRateIn() {
		return pRateIn;
	}
	public void setpRateIn(BigDecimal pRateIn) {
		this.pRateIn = pRateIn;
	}
	public BigDecimal getpRateOut() {
		return pRateOut;
	}
	public void setpRateOut(BigDecimal pRateOut) {
		this.pRateOut = pRateOut;
	}
	public int getpDeadline() {
		return pDeadline;
	}
	public void setpDeadline(int pDeadline) {
		this.pDeadline = pDeadline;
	}
	public String getpRepayWay() {
		return pRepayWay;
	}
	public void setpRepayWay(String pRepayWay) {
		this.pRepayWay = pRepayWay;
	}
	public int getpComplete() {
		return pComplete;
	}
	public void setpComplete(int pComplete) {
		this.pComplete = pComplete;
	}
	public int getpBided() {
		return pBided;
	}
	public void setpBided(int pBided) {
		this.pBided = pBided;
	}
	public int getpMinInvest() {
		return pMinInvest;
	}
	public void setpMinInvest(int pMinInvest) {
		this.pMinInvest = pMinInvest;
	}
	public int getpViewed() {
		return pViewed;
	}
	public void setpViewed(int pViewed) {
		this.pViewed = pViewed;
	}
	public String getpDesc() {
		return pDesc;
	}
	public void setpDesc(String pDesc) {
		this.pDesc = pDesc;
	}
	public int getpApplicant() {
		return pApplicant;
	}
	public void setpApplicant(int pApplicant) {
		this.pApplicant = pApplicant;
	}
	public Date getpApplicationTime() {
		return pApplicationTime;
	}
	public void setpApplicationTime(Date pApplicationTime) {
		this.pApplicationTime = pApplicationTime;
	}
	public Date getpOpenDate() {
		return pOpenDate;
	}
	public void setpOpenDate(Date pOpenDate) {
		this.pOpenDate = pOpenDate;
	}
	public Date getpCloseDate() {
		return pCloseDate;
	}
	public void setpCloseDate(Date pCloseDate) {
		this.pCloseDate = pCloseDate;
	}
	public int getpHavedPay() {
		return pHavedPay;
	}
	public void setpHavedPay(int pHavedPay) {
		this.pHavedPay = pHavedPay;
	}
	public Date getpHavedPayTime() {
		return pHavedPayTime;
	}
	public void setpHavedPayTime(Date pHavedPayTime) {
		this.pHavedPayTime = pHavedPayTime;
	}
	public String getpRiskRate() {
		return pRiskRate;
	}
	public void setpRiskRate(String pRiskRate) {
		this.pRiskRate = pRiskRate;
	}
	public BigDecimal getpRisk() {
		return pRisk;
	}
	public void setpRisk(BigDecimal pRisk) {
		this.pRisk = pRisk;
	}
	public int getpAuditGuarantee() {
		return pAuditGuarantee;
	}
	public void setpAuditGuarantee(int pAuditGuarantee) {
		this.pAuditGuarantee = pAuditGuarantee;
	}
	public int getpAuditPlatform() {
		return pAuditPlatform;
	}
	public void setpAuditPlatform(int pAuditPlatform) {
		this.pAuditPlatform = pAuditPlatform;
	}
	public int getpIsFull() {
		return pIsFull;
	}
	public void setpIsFull(int pIsFull) {
		this.pIsFull = pIsFull;
	}
	public int getpIsSetup() {
		return pIsSetup;
	}
	public void setpIsSetup(int pIsSetup) {
		this.pIsSetup = pIsSetup;
	}
	public int getpIsOverdue() {
		return pIsOverdue;
	}
	public void setpIsOverdue(int pIsOverdue) {
		this.pIsOverdue = pIsOverdue;
	}
	public int getpOverdueDays() {
		return pOverdueDays;
	}
	public void setpOverdueDays(int pOverdueDays) {
		this.pOverdueDays = pOverdueDays;
	}
	public int getpIsReplacePay() {
		return pIsReplacePay;
	}
	public void setpIsReplacePay(int pIsReplacePay) {
		this.pIsReplacePay = pIsReplacePay;
	}
	public BigDecimal getpReplacePay() {
		return pReplacePay;
	}
	public void setpReplacePay(BigDecimal pReplacePay) {
		this.pReplacePay = pReplacePay;
	}
	public int getpIsRepayCompleted() {
		return pIsRepayCompleted;
	}
	public void setpIsRepayCompleted(int pIsRepayCompleted) {
		this.pIsRepayCompleted = pIsRepayCompleted;
	}
	public BigDecimal getpSumPayBack() {
		return pSumPayBack;
	}
	public void setpSumPayBack(BigDecimal pSumPayBack) {
		this.pSumPayBack = pSumPayBack;
	}
	public BigDecimal getpSumInterest() {
		return pSumInterest;
	}
	public void setpSumInterest(BigDecimal pSumInterest) {
		this.pSumInterest = pSumInterest;
	}
	public BigDecimal getpSumHavedPayBack() {
		return pSumHavedPayBack;
	}
	public void setpSumHavedPayBack(BigDecimal pSumHavedPayBack) {
		this.pSumHavedPayBack = pSumHavedPayBack;
	}
	public int getPDel() {
		return PDel;
	}
	public void setPDel(int pDel) {
		PDel = pDel;
	}
	 	
}
