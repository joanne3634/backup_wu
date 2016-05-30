/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.crowdfunding.model.backstage;
import java.math.BigDecimal;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.deelon.core.model.BaseModel;

public class TcprojectHpPayments extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "TcprojectHpPayments";
	public static final String ALIAS_PAYMENTS_ID = "收支ID";
	public static final String ALIAS_PROJECT_ID = "项目ID";
	public static final String ALIAS_HISTORY_PLAN_ID = "历史情况未来计划ID";
	public static final String ALIAS_HPPTYPE_ID = "类型：1收入 2支出";
	public static final String ALIAS_HPPKIND_NAME = "类型(人工输入)";
	public static final String ALIAS_HPPPAYMENT = "金额";
	public static final String ALIAS_HPPREMARKS = "备注";
	public static final String ALIAS_HPPORDER_ID = "排序";
	public static final String ALIAS_IS_DEL = "是否删除";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long paymentsId;
	private java.lang.Long projectId;
	private java.lang.Long historyPlanId;
	private java.lang.String hpptypeId;
	private java.lang.String hppkindName;
	private BigDecimal hpppayment;
	private java.lang.String hppremarks;
	private java.lang.Integer hpporderId;
	private Integer isDel;
	private TcprojectHistoryplan tcprojectHistoryplan;
	//columns END

	public TcprojectHpPayments(){
	}

	public TcprojectHpPayments(
		java.lang.Long paymentsId
	){
		this.paymentsId = paymentsId;
	}

	public void setPaymentsId(java.lang.Long value) {
		this.paymentsId = value;
	}
	
	public java.lang.Long getPaymentsId() {
		return this.paymentsId;
	}
	public void setProjectId(java.lang.Long value) {
		this.projectId = value;
	}
	
	public java.lang.Long getProjectId() {
		return this.projectId;
	}
	public void setHistoryPlanId(java.lang.Long value) {
		this.historyPlanId = value;
	}
	
	public java.lang.Long getHistoryPlanId() {
		return this.historyPlanId;
	}
	public void setHpptypeId(java.lang.String value) {
		this.hpptypeId = value;
	}
	
	public java.lang.String getHpptypeId() {
		return this.hpptypeId;
	}
	public void setHppkindName(java.lang.String value) {
		this.hppkindName = value;
	}
	
	public java.lang.String getHppkindName() {
		return this.hppkindName;
	}
	public void setHpppayment(BigDecimal value) {
		this.hpppayment = value;
	}
	
	public BigDecimal getHpppayment() {
		return this.hpppayment;
	}
	public void setHppremarks(java.lang.String value) {
		this.hppremarks = value;
	}
	
	public java.lang.String getHppremarks() {
		return this.hppremarks;
	}
	public void setHpporderId(java.lang.Integer value) {
		this.hpporderId = value;
	}
	
	public java.lang.Integer getHpporderId() {
		return this.hpporderId;
	}
	public void setIsDel(Integer value) {
		this.isDel = value;
	}
	
	public Integer getIsDel() {
		return this.isDel;
	}
	
	

	public TcprojectHistoryplan getTcprojectHistoryplan() {
		return tcprojectHistoryplan;
	}

	public void setTcprojectHistoryplan(TcprojectHistoryplan tcprojectHistoryplan) {
		this.tcprojectHistoryplan = tcprojectHistoryplan;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("PaymentsId",getPaymentsId())
			.append("ProjectId",getProjectId())
			.append("HistoryPlanId",getHistoryPlanId())
			.append("HpptypeId",getHpptypeId())
			.append("HppkindName",getHppkindName())
			.append("Hpppayment",getHpppayment())
			.append("Hppremarks",getHppremarks())
			.append("HpporderId",getHpporderId())
			.append("IsDel",getIsDel())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getPaymentsId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TcprojectHpPayments == false) return false;
		if(this == obj) return true;
		TcprojectHpPayments other = (TcprojectHpPayments)obj;
		return new EqualsBuilder()
			.append(getPaymentsId(),other.getPaymentsId())
			.isEquals();
	}
}

