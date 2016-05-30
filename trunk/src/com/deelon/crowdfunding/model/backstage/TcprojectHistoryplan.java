/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.crowdfunding.model.backstage;
import java.util.List;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.deelon.core.model.BaseModel;

public class TcprojectHistoryplan extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "TcprojectHistoryplan";
	public static final String ALIAS_HISTORY_PLAN_ID = "历史情况未来计划ID";
	public static final String ALIAS_PROJECT_ID = "项目ID";
	public static final String ALIAS_PHPTYPE_ID = "类型：1历史情况 2未来计划";
	public static final String ALIAS_PHPNAME = "阶段名称";
	public static final String ALIAS_PHPSTART_YEAR = "起止时间（年）";
	public static final String ALIAS_PHPSTART_MONTH = "起止时间（月）";
	public static final String ALIAS_PHPEND_YEAR = "结束时间（年）";
	public static final String ALIAS_PHPEND_MONTH = "结束时间（月）";
	public static final String ALIAS_PHPTARGET_DESC = "阶段达成目标描述";
	public static final String ALIAS_PHPTARGET_WAY = "完成阶段目标的主要措施、方法、手段";
	public static final String ALIAS_PHPORDER_ID = "排序";
	public static final String ALIAS_IS_DEL = "是否删除";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long historyPlanId;
	private java.lang.Long projectId;
	private java.lang.String phptypeId;
	private java.lang.String phpname;
	private java.lang.Integer phpstartYear;
	private java.lang.Integer phpstartMonth;
	private java.lang.Integer phpendYear;
	private java.lang.Integer phpendMonth;
	private java.lang.String phptargetDesc;
	private java.lang.String phptargetWay;
	private java.lang.Integer phporderId;
	private Integer isDel;
	private List<TcprojectHpPayments> listHpPayMent;
	//columns END

	public TcprojectHistoryplan(){
	}

	public TcprojectHistoryplan(
		java.lang.Long historyPlanId
	){
		this.historyPlanId = historyPlanId;
	}

	public void setHistoryPlanId(java.lang.Long value) {
		this.historyPlanId = value;
	}
	
	public java.lang.Long getHistoryPlanId() {
		return this.historyPlanId;
	}
	public void setProjectId(java.lang.Long value) {
		this.projectId = value;
	}
	
	public java.lang.Long getProjectId() {
		return this.projectId;
	}
	public void setPhptypeId(java.lang.String value) {
		this.phptypeId = value;
	}
	
	public java.lang.String getPhptypeId() {
		return this.phptypeId;
	}
	public void setPhpname(java.lang.String value) {
		this.phpname = value;
	}
	
	public java.lang.String getPhpname() {
		return this.phpname;
	}
	public void setPhpstartYear(java.lang.Integer value) {
		this.phpstartYear = value;
	}
	
	public java.lang.Integer getPhpstartYear() {
		return this.phpstartYear;
	}
	public void setPhpstartMonth(java.lang.Integer value) {
		this.phpstartMonth = value;
	}
	
	public java.lang.Integer getPhpstartMonth() {
		return this.phpstartMonth;
	}
	public void setPhpendYear(java.lang.Integer value) {
		this.phpendYear = value;
	}
	
	public java.lang.Integer getPhpendYear() {
		return this.phpendYear;
	}
	public void setPhpendMonth(java.lang.Integer value) {
		this.phpendMonth = value;
	}
	
	public java.lang.Integer getPhpendMonth() {
		return this.phpendMonth;
	}
	public void setPhptargetDesc(java.lang.String value) {
		this.phptargetDesc = value;
	}
	
	public java.lang.String getPhptargetDesc() {
		return this.phptargetDesc;
	}
	public void setPhptargetWay(java.lang.String value) {
		this.phptargetWay = value;
	}
	
	public java.lang.String getPhptargetWay() {
		return this.phptargetWay;
	}
	public void setPhporderId(java.lang.Integer value) {
		this.phporderId = value;
	}
	
	public java.lang.Integer getPhporderId() {
		return this.phporderId;
	}
	public void setIsDel(Integer value) {
		this.isDel = value;
	}
	
	public Integer getIsDel() {
		return this.isDel;
	}
	
	

	public List<TcprojectHpPayments> getListHpPayMent() {
		return listHpPayMent;
	}

	public void setListHpPayMent(List<TcprojectHpPayments> listHpPayMent) {
		this.listHpPayMent = listHpPayMent;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("HistoryPlanId",getHistoryPlanId())
			.append("ProjectId",getProjectId())
			.append("PhptypeId",getPhptypeId())
			.append("Phpname",getPhpname())
			.append("PhpstartYear",getPhpstartYear())
			.append("PhpstartMonth",getPhpstartMonth())
			.append("PhpendYear",getPhpendYear())
			.append("PhpendMonth",getPhpendMonth())
			.append("PhptargetDesc",getPhptargetDesc())
			.append("PhptargetWay",getPhptargetWay())
			.append("PhporderId",getPhporderId())
			.append("IsDel",getIsDel())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getHistoryPlanId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TcprojectHistoryplan == false) return false;
		if(this == obj) return true;
		TcprojectHistoryplan other = (TcprojectHistoryplan)obj;
		return new EqualsBuilder()
			.append(getHistoryPlanId(),other.getHistoryPlanId())
			.isEquals();
	}
}

