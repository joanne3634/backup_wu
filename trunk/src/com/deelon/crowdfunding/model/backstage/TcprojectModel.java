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

public class TcprojectModel extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "TcprojectModel";
	public static final String ALIAS_MODEL_ID = "模式ID";
	public static final String ALIAS_PROJECT_ID = "项目ID";
	public static final String ALIAS_PMTARGETED = "目标用户或客户群体定位";
	public static final String ALIAS_PMCURRENTLY_PLAGUING = "目标用户或客户群体目前困扰或需求定位";
	public static final String ALIAS_PMSERVICES_MODE = "满足目标用户或客户需求的产品或服务模式说明";
	public static final String ALIAS_PMPROFITABLE_DESC = "项目赢利模式说明";
	public static final String ALIAS_PMCOMPETITORS = "市场主要同行或竞争对手概述";
	public static final String ALIAS_PMCORE_COMPETITIVENESS = "项目主要核心竞争力说明";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long modelId;
	private java.lang.Long projectId;
	private java.lang.String pmtargeted;//目标用户或客户群体定位&&众筹产品
	private java.lang.String pmcurrentlyPlaguing;//目标用户或客户群体目前困扰或需求定位&&总体规划
	private java.lang.String pmservicesMode;//满足目标用户或客户需求的产品或服务模式说明&&地理位置
	private java.lang.String pmprofitableDesc;//项目赢利模式说明&&建设进度
	private java.lang.String pmcompetitors;//市场主要同行或竞争对手概述&&价格走势
	private java.lang.String pmcoreCompetitiveness;//项目主要核心竞争力说明&&公司介绍
	//columns END

	public TcprojectModel(){
	}

	public TcprojectModel(
		java.lang.Long modelId
	){
		this.modelId = modelId;
	}

	public void setModelId(java.lang.Long value) {
		this.modelId = value;
	}
	
	public java.lang.Long getModelId() {
		return this.modelId;
	}
	public void setProjectId(java.lang.Long value) {
		this.projectId = value;
	}
	
	public java.lang.Long getProjectId() {
		return this.projectId;
	}
	public void setPmtargeted(java.lang.String value) {
		this.pmtargeted = value;
	}
	
	public java.lang.String getPmtargeted() {
		return this.pmtargeted;
	}
	public void setPmcurrentlyPlaguing(java.lang.String value) {
		this.pmcurrentlyPlaguing = value;
	}
	
	public java.lang.String getPmcurrentlyPlaguing() {
		return this.pmcurrentlyPlaguing;
	}
	public void setPmservicesMode(java.lang.String value) {
		this.pmservicesMode = value;
	}
	
	public java.lang.String getPmservicesMode() {
		return this.pmservicesMode;
	}
	public void setPmprofitableDesc(java.lang.String value) {
		this.pmprofitableDesc = value;
	}
	
	public java.lang.String getPmprofitableDesc() {
		return this.pmprofitableDesc;
	}
	public void setPmcompetitors(java.lang.String value) {
		this.pmcompetitors = value;
	}
	
	public java.lang.String getPmcompetitors() {
		return this.pmcompetitors;
	}
	public void setPmcoreCompetitiveness(java.lang.String value) {
		this.pmcoreCompetitiveness = value;
	}
	
	public java.lang.String getPmcoreCompetitiveness() {
		return this.pmcoreCompetitiveness;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("ModelId",getModelId())
			.append("ProjectId",getProjectId())
			.append("Pmtargeted",getPmtargeted())
			.append("PmcurrentlyPlaguing",getPmcurrentlyPlaguing())
			.append("PmservicesMode",getPmservicesMode())
			.append("PmprofitableDesc",getPmprofitableDesc())
			.append("Pmcompetitors",getPmcompetitors())
			.append("PmcoreCompetitiveness",getPmcoreCompetitiveness())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getModelId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TcprojectModel == false) return false;
		if(this == obj) return true;
		TcprojectModel other = (TcprojectModel)obj;
		return new EqualsBuilder()
			.append(getModelId(),other.getModelId())
			.isEquals();
	}
}

