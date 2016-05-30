package com.deelon.loan.model.sysManager;


import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

import com.deelon.core.model.BaseModel;
import com.deelon.core.util.StringUtil;
import com.deelon.platform.util.SysFileHelper;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class Tbank extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "Tbank";
	public static final String ALIAS_BANK_ID = " 银行ID";
	public static final String ALIAS_BANK_NAME = " 银行名称";
	public static final String ALIAS_PARENT_ID = "上级ID";
	public static final String ALIAS_BANK_PIC = " 银行图片";
	public static final String ALIAS_CREATOR = "创建人";
	public static final String ALIAS_CREATE_TIME = "创建时间";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long bankId;
	private java.lang.String bankName;
	private java.lang.Long parentId;
	private java.lang.String bankPic;
	private java.lang.Long creator;
	private java.util.Date createTime;
	private String bankCode;
	private int isCompanyPay;//区分企业网银和个人
	
	//非持久化
	private Timestamp beginDate;
	private Timestamp endDate;
	private String parentName;
	private String fullName;
	//columns END

	public String getBankCode() {
		return bankCode;
	}

	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}


	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getParentName() {
		return parentName;
	}

	public void setParentName(String parentName) {
		this.parentName = parentName;
	}

	public Timestamp getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Timestamp beginDate) {
		this.beginDate = beginDate;
	}

	public Timestamp getEndDate() {
		return endDate;
	}

	public void setEndDate(Timestamp endDate) {
		this.endDate = endDate;
	}

	public Tbank(){
	}

	public Tbank(
		java.lang.Long bankId
	){
		this.bankId = bankId;
	}

	public void setBankId(java.lang.Long value) {
		this.bankId = value;
	}
	
	public java.lang.Long getBankId() {
		return this.bankId;
	}
	public void setBankName(java.lang.String value) {
		this.bankName = value;
	}
	
	public java.lang.String getBankName() {
		return this.bankName;
	}

	public java.lang.Long getParentId() {
		return parentId;
	}

	public void setParentId(java.lang.Long parentId) {
		this.parentId = parentId;
	}

	public void setBankPic(java.lang.String value) {
		this.bankPic = value;
	}
	
	public java.lang.String getBankPic() {
		if ( StringUtil.isNotEmpty( bankPic ) )
		{
			SysFileHelper.getByIdsFileInfo( bankPic, this );
		}
		return this.bankPic;
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
	
	

	

	public int getIsCompanyPay() {
		return isCompanyPay;
	}

	public void setIsCompanyPay(int isCompanyPay) {
		this.isCompanyPay = isCompanyPay;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("BankId",getBankId())
			.append("BankName",getBankName())
			.append("ParentId",getParentId())
			.append("BankPic",getBankPic())
			.append("Creator",getCreator())
			.append("CreateTime",getCreateTime())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getBankId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof Tbank == false) return false;
		if(this == obj) return true;
		Tbank other = (Tbank)obj;
		return new EqualsBuilder()
			.append(getBankId(),other.getBankId())
			.isEquals();
	}
}

