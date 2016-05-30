/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.model.productsloan;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import com.deelon.core.model.BaseModel;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class Tproductsloan extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "Tproductsloan";
	public static final String ALIAS_PRODUCTS_LOAN_ID = "产品ID";
	public static final String ALIAS_PNAME = "产品名称";
	public static final String ALIAS_PAMOUNT_MIN = "额度(最小)";
	public static final String ALIAS_PAMOUNT_MAX = "额度(最大)";
	public static final String ALIAS_PRATE_MIN = "贷款利率(最小)";
	public static final String ALIAS_PRATE_MAX = "贷款利率(最大)";
	public static final String ALIAS_PDEADLINE_MIN = "贷款期限(最小)";
	public static final String ALIAS_PDEADLINE_MAX = "贷款期限(最大)";
	public static final String ALIAS_PAUDIT_DAYS_MIN = "投注时间(最小)";
	public static final String ALIAS_PAUDIT_DAYS_MAX = "投注时间(最大)";
	public static final String ALIAS_PVOTING_DAYS_MIN = "审核时间(最小)";
	public static final String ALIAS_PVOTING_DAYS_MAX = "审核时间(最大)";
	public static final String ALIAS_PREPAY_WAY = "还款方式";
	public static final String ALIAS_PFEE = "手续费";
	public static final String ALIAS_PGOOD = "亮点";
	public static final String ALIAS_PRECOMMEND = "推荐人群";
	public static final String ALIAS_PREPAY_GUIDE = "还款指南";
	public static final String ALIAS_CREATOR = "创建者";
	public static final String ALIAS_CREATE_TIME = "创建时间";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long productsLoanId;
	private java.lang.String pname;
	private Long pamountMin;
	private Long pamountMax;
	private Long prateMin;
	private Long prateMax;
	private Long pdeadlineMin;
	private Long pdeadlineMax;
	private java.lang.Integer pauditDaysMin;
	private java.lang.Integer pauditDaysMax;
	private java.lang.Integer pvotingDaysMin;
	private java.lang.Integer pvotingDaysMax;
	private java.lang.String prepayWay;
	private java.lang.String pfee;
	private java.lang.String pgood;
	private java.lang.String precommend;
	private java.lang.String prepayGuide;
	private java.lang.Long creator;
	private java.util.Date createTime;
	
	//columns END

	//关联表属性
	private String appGuides;//申请指南
	private String prepareDatas;//准备材料
	
	public Tproductsloan(){
	}

	public Tproductsloan(
		java.lang.Long productsLoanId
	){
		this.productsLoanId = productsLoanId;
	}

	public String getAppGuides() {
		return appGuides;
	}

	public void setAppGuides(String appGuides) {
		this.appGuides = appGuides;
	}

	public String getPrepareDatas() {
		return prepareDatas;
	}

	public void setPrepareDatas(String prepareDatas) {
		this.prepareDatas = prepareDatas;
	}

	public void setProductsLoanId(java.lang.Long value) {
		this.productsLoanId = value;
	}
	
	public java.lang.Long getProductsLoanId() {
		return this.productsLoanId;
	}
	public void setPname(java.lang.String value) {
		this.pname = value;
	}
	
	public java.lang.String getPname() {
		return this.pname;
	}
	public void setPamountMin(Long value) {
		this.pamountMin = value;
	}
	
	public Long getPamountMin() {
		return this.pamountMin;
	}
	public void setPamountMax(Long value) {
		this.pamountMax = value;
	}
	
	public Long getPamountMax() {
		return this.pamountMax;
	}
	public void setPrateMin(Long value) {
		this.prateMin = value;
	}
	
	public Long getPrateMin() {
		return this.prateMin;
	}
	public void setPrateMax(Long value) {
		this.prateMax = value;
	}
	
	public Long getPrateMax() {
		return this.prateMax;
	}
	public void setPdeadlineMin(Long value) {
		this.pdeadlineMin = value;
	}
	
	public Long getPdeadlineMin() {
		return this.pdeadlineMin;
	}
	public void setPdeadlineMax(Long value) {
		this.pdeadlineMax = value;
	}
	
	public Long getPdeadlineMax() {
		return this.pdeadlineMax;
	}
	public void setPauditDaysMin(java.lang.Integer value) {
		this.pauditDaysMin = value;
	}
	
	public java.lang.Integer getPauditDaysMin() {
		return this.pauditDaysMin;
	}
	public void setPauditDaysMax(java.lang.Integer value) {
		this.pauditDaysMax = value;
	}
	
	public java.lang.Integer getPauditDaysMax() {
		return this.pauditDaysMax;
	}
	public void setPvotingDaysMin(java.lang.Integer value) {
		this.pvotingDaysMin = value;
	}
	
	public java.lang.Integer getPvotingDaysMin() {
		return this.pvotingDaysMin;
	}
	public void setPvotingDaysMax(java.lang.Integer value) {
		this.pvotingDaysMax = value;
	}
	
	public java.lang.Integer getPvotingDaysMax() {
		return this.pvotingDaysMax;
	}
	public void setPrepayWay(java.lang.String value) {
		this.prepayWay = value;
	}
	
	public java.lang.String getPrepayWay() {
		return this.prepayWay;
	}
	public void setPfee(java.lang.String value) {
		this.pfee = value;
	}
	
	public java.lang.String getPfee() {
		return this.pfee;
	}
	public void setPgood(java.lang.String value) {
		this.pgood = value;
	}
	
	public java.lang.String getPgood() {
		return this.pgood;
	}
	public void setPrecommend(java.lang.String value) {
		this.precommend = value;
	}
	
	public java.lang.String getPrecommend() {
		return this.precommend;
	}
	public void setPrepayGuide(java.lang.String value) {
		this.prepayGuide = value;
	}
	
	public java.lang.String getPrepayGuide() {
		return this.prepayGuide;
	}
	public void setCreator(java.lang.Long value) {
		this.creator = value;
	}
	
	public java.lang.Long getCreator() {
		return this.creator;
	}
	public void setCreateTime(java.util.Date value) {
		this.createTime = value;
	}
	
	public java.util.Date getCreateTime() {
		return this.createTime;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("ProductsLoanId",getProductsLoanId())
			.append("Pname",getPname())
			.append("PamountMin",getPamountMin())
			.append("PamountMax",getPamountMax())
			.append("PrateMin",getPrateMin())
			.append("PrateMax",getPrateMax())
			.append("PdeadlineMin",getPdeadlineMin())
			.append("PdeadlineMax",getPdeadlineMax())
			.append("PauditDaysMin",getPauditDaysMin())
			.append("PauditDaysMax",getPauditDaysMax())
			.append("PvotingDaysMin",getPvotingDaysMin())
			.append("PvotingDaysMax",getPvotingDaysMax())
			.append("PrepayWay",getPrepayWay())
			.append("Pfee",getPfee())
			.append("Pgood",getPgood())
			.append("Precommend",getPrecommend())
			.append("PrepayGuide",getPrepayGuide())
			.append("Creator",getCreator())
			.append("CreateTime",getCreateTime())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getProductsLoanId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof Tproductsloan == false) return false;
		if(this == obj) return true;
		Tproductsloan other = (Tproductsloan)obj;
		return new EqualsBuilder()
			.append(getProductsLoanId(),other.getProductsLoanId())
			.isEquals();
	}
}

