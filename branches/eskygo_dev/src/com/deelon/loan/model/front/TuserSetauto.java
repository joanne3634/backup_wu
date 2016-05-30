/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.model.front;
import java.math.BigDecimal;
import java.util.Date;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.deelon.core.model.BaseModel;

public class TuserSetauto extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "TuserSetauto";
	public static final String ALIAS_SET_AUTO_ID = "自动投标ID";
	public static final String ALIAS_USER_ID = "用户ID";
	public static final String ALIAS_AMOUNT_TYPE = "投标金额类型";
	public static final String ALIAS_AMOUNT_TYPE_VALUE = "投标金额类型值";
	public static final String ALIAS_AMOUNT = "投标金额";
	public static final String ALIAS_IS_REPAY_WAY = "是否还款方式限制";
	public static final String ALIAS_REPAY_WAY = "还款方式";
	public static final String ALIAS_IS_DEADLINE = "是否还款期限限制";
	public static final String ALIAS_DEADLINE = "还款期限";
	public static final String ALIAS_IS_RATE_OUT = "是否借款利率限制";
	public static final String ALIAS_RATE_OUT = "借款利率";
	public static final String ALIAS_PRODUCTS_LOAN_ID = "借款类型";
	public static final String ALIAS_IS_LESS_THAN = "是否投资金额限制";
	public static final String ALIAS_LESS_THAN = "投资金额<=";
	public static final String ALIAS_IS_AUTO_DATE = "是否限制自动投标时间段";
	public static final String ALIAS_AUTO_DATE_START = "自动投标开始日期";
	public static final String ALIAS_AUTO_DATE_END = "自动投标结束日期";
	public static final String ALIAS_UPDATE_TIME = "最后更新时间";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long setAutoId;
	private java.lang.Long userId;
	private java.lang.String amountType;
	private java.lang.String amountTypeValue;
	private BigDecimal amount;
	private Integer isRepayWay;
	private java.lang.String repayWay;
	private Integer isDeadline;
	private java.lang.Integer deadline;
	private Integer isRateOut;
	private BigDecimal rateOut;
	private java.lang.Long productsLoanId;
	private Integer isLessThan;
	private BigDecimal lessThan;
	private Integer isAutoDate;
	private java.util.Date autoDateStart;
	private java.util.Date autoDateEnd;
	private java.util.Date updateTime;
	
	//非持久化
	private String amountType_1;
	private String amountType_2;
	private String amountType_3;
	private String amountTypeValue_1;
	private String amountTypeValue_2;
	private String beginDate;
	private String endDate;
	//columns END

	public TuserSetauto(){
	}

	public TuserSetauto(
		java.lang.Long setAutoId
	){
		this.setAutoId = setAutoId;
	}

	public void setSetAutoId(java.lang.Long value) {
		this.setAutoId = value;
	}
	
	public java.lang.Long getSetAutoId() {
		return this.setAutoId;
	}
	public void setUserId(java.lang.Long value) {
		this.userId = value;
	}
	
	public java.lang.Long getUserId() {
		return this.userId;
	}
	public void setAmountType(java.lang.String value) {
		this.amountType = value;
	}
	
	public java.lang.String getAmountType() {
		return this.amountType;
	}
	public void setAmountTypeValue(java.lang.String value) {
		this.amountTypeValue = value;
	}
	
	public java.lang.String getAmountTypeValue() {
		return this.amountTypeValue;
	}
	
	public void setIsRepayWay(Integer value) {
		this.isRepayWay = value;
	}
	
	public Integer getIsRepayWay() {
		return this.isRepayWay;
	}
	public void setRepayWay(java.lang.String value) {
		this.repayWay = value;
	}
	
	public java.lang.String getRepayWay() {
		return this.repayWay;
	}
	public void setIsDeadline(Integer value) {
		this.isDeadline = value;
	}
	
	public Integer getIsDeadline() {
		return this.isDeadline;
	}
	public void setDeadline(java.lang.Integer value) {
		this.deadline = value;
	}
	
	public java.lang.Integer getDeadline() {
		return this.deadline;
	}
	public void setIsRateOut(Integer value) {
		this.isRateOut = value;
	}
	
	public Integer getIsRateOut() {
		return this.isRateOut;
	}
	
	public void setProductsLoanId(java.lang.Long value) {
		this.productsLoanId = value;
	}
	
	public java.lang.Long getProductsLoanId() {
		return this.productsLoanId;
	}
	public void setIsLessThan(Integer value) {
		this.isLessThan = value;
	}
	
	public Integer getIsLessThan() {
		return this.isLessThan;
	}
	
	public void setIsAutoDate(Integer value) {
		this.isAutoDate = value;
	}
	
	public Integer getIsAutoDate() {
		return this.isAutoDate;
	}
	public void setAutoDateStart(java.util.Date value) {
		this.autoDateStart = value;
	}
	
	public java.util.Date getAutoDateStart() {
		return this.autoDateStart;
	}
	public void setAutoDateEnd(java.util.Date value) {
		this.autoDateEnd = value;
	}
	
	public java.util.Date getAutoDateEnd() {
		return this.autoDateEnd;
	}
	public void setUpdateTime(java.util.Date value) {
		this.updateTime = value;
	}
	
	public java.util.Date getUpdateTime() {
		return this.updateTime;
	}
	
	

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public BigDecimal getRateOut() {
		return rateOut;
	}

	public void setRateOut(BigDecimal rateOut) {
		this.rateOut = rateOut;
	}

	public BigDecimal getLessThan() {
		return lessThan;
	}

	public void setLessThan(BigDecimal lessThan) {
		this.lessThan = lessThan;
	}
	
	

	public String getAmountType_1() {
		return amountType_1;
	}

	public void setAmountType_1(String amountType_1) {
		this.amountType_1 = amountType_1;
	}

	public String getAmountType_2() {
		return amountType_2;
	}

	public void setAmountType_2(String amountType_2) {
		this.amountType_2 = amountType_2;
	}

	public String getAmountType_3() {
		return amountType_3;
	}

	public void setAmountType_3(String amountType_3) {
		this.amountType_3 = amountType_3;
	}

	public String getAmountTypeValue_1() {
		return amountTypeValue_1;
	}

	public void setAmountTypeValue_1(String amountTypeValue_1) {
		this.amountTypeValue_1 = amountTypeValue_1;
	}

	

	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	
	

	public String getAmountTypeValue_2() {
		return amountTypeValue_2;
	}

	public void setAmountTypeValue_2(String amountTypeValue_2) {
		this.amountTypeValue_2 = amountTypeValue_2;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("SetAutoId",getSetAutoId())
			.append("UserId",getUserId())
			.append("AmountType",getAmountType())
			.append("AmountTypeValue",getAmountTypeValue())
			.append("Amount",getAmount())
			.append("IsRepayWay",getIsRepayWay())
			.append("RepayWay",getRepayWay())
			.append("IsDeadline",getIsDeadline())
			.append("Deadline",getDeadline())
			.append("IsRateOut",getIsRateOut())
			.append("RateOut",getRateOut())
			.append("ProductsLoanId",getProductsLoanId())
			.append("IsLessThan",getIsLessThan())
			.append("LessThan",getLessThan())
			.append("IsAutoDate",getIsAutoDate())
			.append("AutoDateStart",getAutoDateStart())
			.append("AutoDateEnd",getAutoDateEnd())
			.append("UpdateTime",getUpdateTime())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getSetAutoId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TuserSetauto == false) return false;
		if(this == obj) return true;
		TuserSetauto other = (TuserSetauto)obj;
		return new EqualsBuilder()
			.append(getSetAutoId(),other.getSetAutoId())
			.isEquals();
	}
}

