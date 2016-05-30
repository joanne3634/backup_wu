/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.crowdfunding.model.backstage;
import java.util.HashSet;
import java.util.Set;
import com.deelon.core.model.BaseModel;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class TcprojectPayplan extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "TcprojectPayplan";
	public static final String ALIAS_PAY_PLAN_ID = "放款计划ID";
	public static final String ALIAS_PROJECT_ID = "项目ID";
	public static final String ALIAS_PPPPAY = "应放款金额（万）";
	public static final String ALIAS_PPPREAL_PAY = "实际放款金额（万）";
	public static final String ALIAS_PPPPLAN_PAY_TIME = "计划放款时间";
	public static final String ALIAS_PPPREAL_PAY_TIME = "实际放款时间";
	public static final String ALIAS_PPPCURRENT_OF_ALL = "当前期数/总期数";
	public static final String ALIAS_PPPCURRENT = "当前期数";
	public static final String ALIAS_PPPIS_PAY_OFF = "是否放清全部";
	public static final String ALIAS_PPPIS_DONE = "已经执行";
	public static final String ALIAS_PPPPAYER = "放款人";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long payPlanId;
	private java.lang.Long projectId;
	private Double ppppay;
	private Double ppprealPay;
	private java.util.Date pppplanPayTime;
	private java.util.Date ppprealPayTime;
	private java.lang.String pppcurrentOfAll;
	private java.lang.Integer pppcurrent;
	private Integer pppisPayOff;
	private Integer pppisDone;
	private java.lang.Long ppppayer;
	//columns END

	public TcprojectPayplan(){
	}

	public TcprojectPayplan(
		java.lang.Long payPlanId
	){
		this.payPlanId = payPlanId;
	}

	public void setPayPlanId(java.lang.Long value) {
		this.payPlanId = value;
	}
	
	public java.lang.Long getPayPlanId() {
		return this.payPlanId;
	}
	public void setProjectId(java.lang.Long value) {
		this.projectId = value;
	}
	
	public java.lang.Long getProjectId() {
		return this.projectId;
	}
	public void setPpppay(Double value) {
		this.ppppay = value;
	}
	
	public Double getPpppay() {
		return this.ppppay;
	}
	public void setPpprealPay(Double value) {
		this.ppprealPay = value;
	}
	
	public Double getPpprealPay() {
		return this.ppprealPay;
	}
	public void setPppplanPayTime(java.util.Date value) {
		this.pppplanPayTime = value;
	}
	
	public java.util.Date getPppplanPayTime() {
		return this.pppplanPayTime;
	}
	public void setPpprealPayTime(java.util.Date value) {
		this.ppprealPayTime = value;
	}
	
	public java.util.Date getPpprealPayTime() {
		return this.ppprealPayTime;
	}
	public void setPppcurrentOfAll(java.lang.String value) {
		this.pppcurrentOfAll = value;
	}
	
	public java.lang.String getPppcurrentOfAll() {
		return this.pppcurrentOfAll;
	}
	public void setPppcurrent(java.lang.Integer value) {
		this.pppcurrent = value;
	}
	
	public java.lang.Integer getPppcurrent() {
		return this.pppcurrent;
	}
	public void setPppisPayOff(Integer value) {
		this.pppisPayOff = value;
	}
	
	public Integer getPppisPayOff() {
		return this.pppisPayOff;
	}
	public void setPppisDone(Integer value) {
		this.pppisDone = value;
	}
	
	public Integer getPppisDone() {
		return this.pppisDone;
	}
	public void setPpppayer(java.lang.Long value) {
		this.ppppayer = value;
	}
	
	public java.lang.Long getPpppayer() {
		return this.ppppayer;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("PayPlanId",getPayPlanId())
			.append("ProjectId",getProjectId())
			.append("Ppppay",getPpppay())
			.append("PpprealPay",getPpprealPay())
			.append("PppplanPayTime",getPppplanPayTime())
			.append("PpprealPayTime",getPpprealPayTime())
			.append("PppcurrentOfAll",getPppcurrentOfAll())
			.append("Pppcurrent",getPppcurrent())
			.append("PppisPayOff",getPppisPayOff())
			.append("PppisDone",getPppisDone())
			.append("Ppppayer",getPpppayer())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getPayPlanId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TcprojectPayplan == false) return false;
		if(this == obj) return true;
		TcprojectPayplan other = (TcprojectPayplan)obj;
		return new EqualsBuilder()
			.append(getPayPlanId(),other.getPayPlanId())
			.isEquals();
	}
}

