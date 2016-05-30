


package com.deelon.loan.model.front;
import java.math.BigDecimal;
import java.util.Date;



public class TProjectRisk implements java.io.Serializable  {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1849486098276833675L;
	//alias
	public static final String TABLE_ALIAS = "TprojectRisk";
	public static final String ALIAS_RISK_ID = "担保记录ID";
	public static final String ALIAS_PROJECT_ID = "贷款项目ID";
	public static final String ALIAS_PRRISK_RATE = "风险金(担保金额)比例";
	public static final String ALIAS_PRRISK = "风险金(担保金额)";
	public static final String ALIAS_PRCOMPAY = "担保机构";
	public static final String ALIAS_PRAUDIT = "担保审核";
	public static final String ALIAS_PRIS_REPLACE_PAY = "是否担保机构代还款";
	public static final String ALIAS_PRREPLACE_PAY = "担保机构代还款金额";
	public static final String ALIAS_PRREPLACE_PAY_TIME = "代还时间";
	public static final String ALIAS_PRADVICE = "风控意见";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long riskId;
	private long projectId;
	private BigDecimal prriskRate;
	private BigDecimal prrisk;
	private Long prcompay;
	private int praudit;
	private int prisReplacePay;
	private BigDecimal prreplacePay;
	private Date prreplacePayTime;
	private String pradvice;
	//columns END
	
	 private Date beginDate;
	 private Date endDate;
	//非持久化
	 private String prcompayName;//担保机构名称
	 private String proName;//项目名称
	public java.lang.Long getRiskId() {
		return riskId;
	}
	public void setRiskId(java.lang.Long riskId) {
		this.riskId = riskId;
	}
	public long getProjectId() {
		return projectId;
	}
	public void setProjectId(long projectId) {
		this.projectId = projectId;
	}
	public BigDecimal getPrriskRate() {
		return prriskRate;
	}
	public void setPrriskRate(BigDecimal prriskRate) {
		this.prriskRate = prriskRate;
	}
	public BigDecimal getPrrisk() {
		return prrisk;
	}
	public void setPrrisk(BigDecimal prrisk) {
		this.prrisk = prrisk;
	}
	public Long getPrcompay() {
		return prcompay;
	}
	public void setPrcompay(Long prcompay) {
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
	
	public Date getPrreplacePayTime() {
		return prreplacePayTime;
	}
	public void setPrreplacePayTime(Date prreplacePayTime) {
		this.prreplacePayTime = prreplacePayTime;
	}
	public String getPradvice() {
		return pradvice;
	}
	public void setPradvice(String pradvice) {
		this.pradvice = pradvice;
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
	public String getPrcompayName() {
		return prcompayName;
	}
	public void setPrcompayName(String prcompayName) {
		this.prcompayName = prcompayName;
	}
	public String getProName() {
		return proName;
	}
	public void setProName(String proName) {
		this.proName = proName;
	}
	
	
}

