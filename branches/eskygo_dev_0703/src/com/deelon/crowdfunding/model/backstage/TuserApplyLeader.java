package com.deelon.crowdfunding.model.backstage;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.deelon.core.model.BaseModel;
/**
 * Powered By [MyLiao]
 * 申请领投资格审核PO
 */
public class TuserApplyLeader extends BaseModel {
	private static final long serialVersionUID = 1L;

	//alias
	public static final String TABLE_ALIAS = "申请领投资格审核";
	public static final String ALIAS_APPLYLEADER_ID = "applyLeaderId";
	public static final String ALIAS_USER_ID = "申请人ID";
	public static final String ALIAS_APPLY_TIME = "申请时间";
	public static final String ALIAS_INDUSTRY_ID = "行业ID";
	public static final String ALIAS_INDUSTRY_DESC = "行业描述";
	public static final String ALIAS_APPLY_INFO = "领投人简介";
	public static final String ALIAS_IS_CHECK = "审核状态";
	public static final String ALIAS_CHECKER = "审核人";
	public static final String ALIAS_CHECK_TIME = "审核时间";
	public static final String ALIAS_CHECK_FAILREASON = "不通过理由";
	
	//申请领投资格表(T_User_ApplyLeader)10个字段
	private java.lang.Long applyLeaderId;
	private java.lang.Long userId;
	private java.util.Date applyTime;
	private java.lang.String industryId;
	private java.lang.String industryDesc;
	private java.lang.String applyInfo;
	private java.lang.Integer isCheck;
	private java.lang.String checker;
	private java.util.Date checkTime;
	private java.lang.String checkFailReason;
	
	//非持久化字段
	private java.lang.String loginName;
	private java.lang.String applyTimeStr;
	private java.lang.String checkTimeStr;
	private java.lang.String checkerName;
	private String realName;
	private String personalRemark;//个人说明
	private String provincesName;
	private String cityName;
	private Integer isLeader;
	private Integer isAskPrice;
	private String bindIdno;    //是否实名验证身份证
	private Integer isCompany;
	private String contactName;
	private String myPhoto;
	
	
	
	public java.lang.Long getApplyLeaderId() {
		return applyLeaderId;
	}
	public void setApplyLeaderId(java.lang.Long applyLeaderId) {
		this.applyLeaderId = applyLeaderId;
	}
	public java.lang.Long getUserId() {
		return userId;
	}
	public void setUserId(java.lang.Long userId) {
		this.userId = userId;
	}
	
	public java.lang.String getIndustryId() {
		return industryId;
	}
	public void setIndustryId(java.lang.String industryId) {
		this.industryId = industryId;
	}
	public java.lang.String getIndustryDesc() {
		return industryDesc;
	}
	public void setIndustryDesc(java.lang.String industryDesc) {
		this.industryDesc = industryDesc;
	}
	public java.lang.String getApplyInfo() {
		return applyInfo;
	}
	public void setApplyInfo(java.lang.String applyInfo) {
		this.applyInfo = applyInfo;
	}
	public Integer getIsCheck() {
		return isCheck;
	}
	public void setIsCheck(Integer isCheck) {
		this.isCheck = isCheck;
	}
	
	public java.lang.String getChecker() {
		return checker;
	}
	public void setChecker(java.lang.String checker) {
		this.checker = checker;
	}
	
	public java.lang.String getCheckFailReason() {
		return checkFailReason;
	}
	public void setCheckFailReason(java.lang.String checkFailReason) {
		this.checkFailReason = checkFailReason;
	}
	
	//非持久化字段
	public java.lang.String getLoginName() {
		return loginName;
	}
	public void setLoginName(java.lang.String loginName) {
		this.loginName = loginName;
	}
	public java.lang.String getApplyTimeStr() {
		return applyTimeStr;
	}
	public void setApplyTimeStr(java.lang.String applyTimeStr) {
		this.applyTimeStr = applyTimeStr;
	}
	public java.lang.String getCheckTimeStr() {
		return checkTimeStr;
	}
	public void setCheckTimeStr(java.lang.String checkTimeStr) {
		this.checkTimeStr = checkTimeStr;
	}
	public java.lang.String getCheckerName() {
		return checkerName;
	}
	public void setCheckerName(java.lang.String checkerName) {
		this.checkerName = checkerName;
	}
	
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	
	public String getProvincesName() {
		return provincesName;
	}
	public void setProvincesName(String provincesName) {
		this.provincesName = provincesName;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	
	
	public Integer getIsLeader() {
		return isLeader;
	}
	public void setIsLeader(Integer isLeader) {
		this.isLeader = isLeader;
	}
	public Integer getIsAskPrice() {
		return isAskPrice;
	}
	public void setIsAskPrice(Integer isAskPrice) {
		this.isAskPrice = isAskPrice;
	}
	public String getBindIdno() {
		return bindIdno;
	}
	public void setBindIdno(String bindIdno) {
		this.bindIdno = bindIdno;
	}
	
	public Integer getIsCompany() {
		return isCompany;
	}
	public void setIsCompany(Integer isCompany) {
		this.isCompany = isCompany;
	}
	
	public String getContactName() {
		return contactName;
	}
	public void setContactName(String contactName) {
		this.contactName = contactName;
	}
	
	public String getMyPhoto() {
		return myPhoto;
	}
	public void setMyPhoto(String myPhoto) {
		this.myPhoto = myPhoto;
	}
	public String getPersonalRemark() {
		return personalRemark;
	}
	public void setPersonalRemark(String personalRemark) {
		this.personalRemark = personalRemark;
	}
	public java.util.Date getApplyTime() {
		return applyTime;
	}
	public void setApplyTime(java.util.Date applyTime) {
		this.applyTime = applyTime;
	}
	public java.util.Date getCheckTime() {
		return checkTime;
	}
	public void setCheckTime(java.util.Date checkTime) {
		this.checkTime = checkTime;
	}
	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("ApplyLeaderId",getApplyLeaderId())
			.append("UserId",getUserId())
			.append("ApplyTime",getApplyTime())
			.append("IndustryId",getIndustryId())
			.append("ApplyInfo",getApplyInfo())
			.append("IsCheck",getIsCheck())
			.append("Checker",getChecker())
			.append("CheckTime",getCheckTime())
			.append("CheckFailReason",getCheckFailReason())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder().append(getApplyLeaderId()).toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TuserApplyLeader == false) return false;
		if(this == obj) return true;
		TuserApplyLeader other = (TuserApplyLeader)obj;
		return new EqualsBuilder().append(getApplyLeaderId(),other.getApplyLeaderId()).isEquals();
	}
}
