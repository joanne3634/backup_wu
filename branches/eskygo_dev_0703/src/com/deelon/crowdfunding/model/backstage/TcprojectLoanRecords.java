/*
 * Powered By [Allen]
 * Since 2013 - 2015
 */


package com.deelon.crowdfunding.model.backstage;
import java.math.BigDecimal;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.deelon.core.model.BaseModel;

public class TcprojectLoanRecords extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "TcprojectLoanRecords";
	public static final String ALIAS_LOAN_RECORD_ID = "放款记录id";
	public static final String ALIAS_PROJECT_ID = "项目id";
	public static final String ALIAS_LOAN_AMOUT = "本次线下放款金额";
	public static final String ALIAS_LOAN_DATE = "本次线下放款时间";
	public static final String ALIAS_LOAN_PERSON = "线下放款人";
	public static final String ALIAS_LOAN_FLOW_CODE = "线下放款的交易流水号";
	public static final String ALIAS_CREAT_PERSON = "本条信息创建人";
	public static final String ALIAS_CREATETIME = "createtime";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long loanRecordId;
	private java.lang.Long projectId;
	private BigDecimal loanAmout;
	private java.util.Date loanDate;
	private java.lang.String loanPerson;
	private java.lang.String loanFlowCode;
	private java.lang.Long creatPerson;
	private java.util.Date createtime;
	

	//columns END
	private String pname;
	private String pcurrent;

	

	public void setLoanRecordId(java.lang.Long value) {
		this.loanRecordId = value;
	}
	
	public java.lang.Long getLoanRecordId() {
		return this.loanRecordId;
	}
	public void setProjectId(java.lang.Long value) {
		this.projectId = value;
	}
	
	public java.lang.Long getProjectId() {
		return this.projectId;
	}
	public void setLoanAmout(BigDecimal value) {
		this.loanAmout = value;
	}
	
	public BigDecimal getLoanAmout() {
		return this.loanAmout;
	}
	public void setLoanDate(java.util.Date value) {
		this.loanDate = value;
	}
	
	public java.util.Date getLoanDate() {
		return this.loanDate;
	}
	public void setLoanPerson(java.lang.String value) {
		this.loanPerson = value;
	}
	
	public java.lang.String getLoanPerson() {
		return this.loanPerson;
	}
	public void setLoanFlowCode(java.lang.String value) {
		this.loanFlowCode = value;
	}
	
	public java.lang.String getLoanFlowCode() {
		return this.loanFlowCode;
	}
	public void setCreatPerson(java.lang.Long value) {
		this.creatPerson = value;
	}
	
	public java.lang.Long getCreatPerson() {
		return this.creatPerson;
	}
	public void setCreatetime(java.util.Date value) {
		this.createtime = value;
	}
	
	public java.util.Date getCreatetime() {
		return this.createtime;
	}

	
	
	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	
	public String getPcurrent() {
		return pcurrent;
	}

	public void setPcurrent(String pcurrent) {
		this.pcurrent = pcurrent;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("LoanRecordId",getLoanRecordId())
			.append("ProjectId",getProjectId())
			.append("LoanAmout",getLoanAmout())
			.append("LoanDate",getLoanDate())
			.append("LoanPerson",getLoanPerson())
			.append("LoanFlowCode",getLoanFlowCode())
			.append("CreatPerson",getCreatPerson())
			.append("Createtime",getCreatetime())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TcprojectLoanRecords == false) return false;
		if(this == obj) return true;
		TcprojectLoanRecords other = (TcprojectLoanRecords)obj;
		return new EqualsBuilder()
			.isEquals();
	}
}

