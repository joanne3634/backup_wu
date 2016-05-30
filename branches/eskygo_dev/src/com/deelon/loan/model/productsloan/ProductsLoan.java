package com.deelon.loan.model.productsloan;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 贷款产品实体
 * @author qvr
 *
 */
public class ProductsLoan implements java.io.Serializable {

	private String styleStr;//前台展现样式需要
	// Fields

	private long productsLoanId;//ProductsLoan_id贷款产品ID
	private String pName;//P_Name贷款产品名称
	private BigDecimal pAmountMin;//P_Amount_Min最小数额
	private BigDecimal pAmountMax;//P_Amount_Max最大数额
	private BigDecimal pRateMin;//P_Rate_Min最小利率
	private BigDecimal pRateMax;//P_Rate_Max最大利率
	private BigDecimal pDeadlineMin;//P_Deadline_Min贷款期限(最小)
	private BigDecimal pDeadlineMax;//P_Deadline_Max贷款期限(最大)
	private Integer pAuditDaysMin;//P_AuditDays_Min审核天数（最小）
	private Integer pAuditDaysMax;//P_AuditDays_Max审核时间（最大）
	private Integer pVotingDaysMin;//P_VotingDays_Min投注时间(最大)
	private Integer pVotingDaysMax;//P_VotingDays_Max投注时间(最大)
	private String pRepayWay;//P_RepayWay还款方式
	private String pFee;//P_Fee手续费
	private String pGood;//P_good亮点
	private String pRecommend;//P_Recommend推荐人群
	private String pRepayGuide;//P_RepayGuide还款指南
	private Integer creator;//Creator创建者
	private Date createTime;//CreateTime创建时间
	private List<ProductsLoanAppGuide> appGuides;//申请指南
	private List<ProductsLoanPrepareData> prepareDatas;//准备材料
	
	public String getStyleStr() {
		return styleStr;
	}
	public void setStyleStr(String styleStr) {
		this.styleStr = styleStr;
	}
	public List<ProductsLoanPrepareData> getPrepareDatas() {
		return prepareDatas;
	}
	public void setPrepareDatas(List<ProductsLoanPrepareData> prepareDatas) {
		this.prepareDatas = prepareDatas;
	}
	public List<ProductsLoanAppGuide> getAppGuides() {
		return appGuides;
	}
	public void setAppGuides(List<ProductsLoanAppGuide> appGuides) {
		this.appGuides = appGuides;
	}
	public long getProductsLoanId() {
		return productsLoanId;
	}
	public void setProductsLoanId(long productsLoanId) {
		this.productsLoanId = productsLoanId;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public BigDecimal getpAmountMin() {
		return pAmountMin;
	}
	public void setpAmountMin(BigDecimal pAmountMin) {
		this.pAmountMin = pAmountMin;
	}
	public BigDecimal getpAmountMax() {
		return pAmountMax;
	}
	public void setpAmountMax(BigDecimal pAmountMax) {
		this.pAmountMax = pAmountMax;
	}
	public BigDecimal getpRateMin() {
		return pRateMin;
	}
	public void setpRateMin(BigDecimal pRateMin) {
		this.pRateMin = pRateMin;
	}
	public BigDecimal getpRateMax() {
		return pRateMax;
	}
	public void setpRateMax(BigDecimal pRateMax) {
		this.pRateMax = pRateMax;
	}
	public BigDecimal getpDeadlineMin() {
		return pDeadlineMin;
	}
	public void setpDeadlineMin(BigDecimal pDeadlineMin) {
		this.pDeadlineMin = pDeadlineMin;
	}
	public BigDecimal getpDeadlineMax() {
		return pDeadlineMax;
	}
	public void setpDeadlineMax(BigDecimal pDeadlineMax) {
		this.pDeadlineMax = pDeadlineMax;
	}
	public Integer getpAuditDaysMin() {
		return pAuditDaysMin;
	}
	public void setpAuditDaysMin(Integer pAuditDaysMin) {
		this.pAuditDaysMin = pAuditDaysMin;
	}
	public Integer getpAuditDaysMax() {
		return pAuditDaysMax;
	}
	public void setpAuditDaysMax(Integer pAuditDaysMax) {
		this.pAuditDaysMax = pAuditDaysMax;
	}
	public Integer getpVotingDaysMin() {
		return pVotingDaysMin;
	}
	public void setpVotingDaysMin(Integer pVotingDaysMin) {
		this.pVotingDaysMin = pVotingDaysMin;
	}
	public Integer getpVotingDaysMax() {
		return pVotingDaysMax;
	}
	public void setpVotingDaysMax(Integer pVotingDaysMax) {
		this.pVotingDaysMax = pVotingDaysMax;
	}
	public String getpRepayWay() {
		return pRepayWay;
	}
	public void setpRepayWay(String pRepayWay) {
		this.pRepayWay = pRepayWay;
	}
	public String getpFee() {
		return pFee;
	}
	public void setpFee(String pFee) {
		this.pFee = pFee;
	}
	public String getpGood() {
		return pGood;
	}
	public void setpGood(String pGood) {
		this.pGood = pGood;
	}
	public String getpRecommend() {
		return pRecommend;
	}
	public void setpRecommend(String pRecommend) {
		this.pRecommend = pRecommend;
	}
	public String getpRepayGuide() {
		return pRepayGuide;
	}
	public void setpRepayGuide(String pRepayGuide) {
		this.pRepayGuide = pRepayGuide;
	}
	public Integer getCreator() {
		return creator;
	}
	public void setCreator(Integer creator) {
		this.creator = creator;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
		
}
