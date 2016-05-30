package com.deelon.crowdfunding.model.backstage;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */



import java.util.HashSet;
import java.util.Set;
import com.deelon.core.model.BaseModel;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class TcuserAudit extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "Tuser";
	public static final String ALIAS_USER_ID = "userId";
	public static final String ALIAS_LOGIN_NAME = "鐧诲綍鍚";
	public static final String ALIAS_LOGIN_PWD = "鐧诲綍瀵嗙爜";
	public static final String ALIAS_LOGIN_PWD_ERR_COUNT = "鐧诲綍瀵嗙爜閿欒娆℃暟";
	public static final String ALIAS_TRADING_PWD = "浜ゆ槗瀵嗙爜";
	public static final String ALIAS_TRADING_PWD_ERR_COUNT = "浜ゆ槗瀵嗙爜閿欒娆℃暟";
	public static final String ALIAS_REAL_NAME = "鐪熷疄濮撳悕";
	public static final String ALIAS_GENDER = "鎬у埆";
	public static final String ALIAS_AGE = "骞撮緞";
	public static final String ALIAS_EDU = "瀛﹀巻";
	public static final String ALIAS_SCHOOL = "瀛︽牎";
	public static final String ALIAS_GROUP_ID = "鐢ㄦ埛缁�";
	public static final String ALIAS_IS_LOCK = "鏄惁閿佸畾";
	public static final String ALIAS_IS_ACTIVE = "鏄惁婵�椿";
	public static final String ALIAS_REGISTER_TIME = "娉ㄥ唽鏃堕棿";
	public static final String ALIAS_LOGIN_COUNT = "鎬诲叡鐧诲綍娆℃暟";
	public static final String ALIAS_CHECKER = "璺熻繘瀹℃牳浜�";
	public static final String ALIAS_PROVINCES_ID = "鎵�湪鐪佷唤ID";
	public static final String ALIAS_CITY_ID = "鎵�湪鍩庡競ID";
	public static final String ALIAS_REMARKS = "涓汉/鍏徃璇存槑";
	public static final String ALIAS_PERSONAL_ADDRESS = "涓汉浣忓潃";
	public static final String ALIAS_IS_LEADER = "鏄惁棰嗘姇浜�";
	public static final String ALIAS_IS_COMPANY = "鏄惁鏈烘瀯锛堝叕鍙革級";
	public static final String ALIAS_CONTACT_NAME = "鑱旂郴浜哄鍚�";
	public static final String ALIAS_BUSINESS_LICENSE = "钀ヤ笟鎵х収鍙风爜";
	public static final String ALIAS_IS_ASK_PRICE = "鏄惁鏈夎浠疯鎶曡祫鏍�";
	public static final String ALIAS_ASK_TIMES = "褰撳墠璇环娆℃暟";
	public static final String ALIAS_LAST_LOGIN_TIME = "鏈�悗鐧诲綍鏃堕棿";
	public static final String ALIAS_IS_DEL = "鏄惁鍒犻櫎";
	public static final String ALIAS_IS_CHECK = "鏄惁瀹℃牳";
	public static final String ALIAS_CHECK_TIME = "瀹℃牳鏃堕棿";
	 
	//鍙互鐩存帴浣跨敤: @Length(max=50,message="鐢ㄦ埛鍚嶉暱搴︿笉鑳藉ぇ浜�0")鏄剧ず閿欒娑堟伅
	//columns START
	private java.lang.Long userId;
	private java.lang.String loginName;
	private java.lang.String loginPwd;
	private java.lang.Integer loginPwdErrCount;
	private java.lang.String tradingPwd;
	private java.lang.Integer tradingPwdErrCount;
	private java.lang.String realName;
	private java.lang.String gender;
	private java.lang.Integer age;
	private java.lang.String edu;
	private java.lang.String school;
	private java.lang.String groupId;
	private Integer isLock;
	private Integer isActive;
	private java.util.Date registerTime;
	private java.lang.Integer loginCount;
	private java.lang.Long checker;
	private java.lang.Long provincesId;
	private java.lang.Long cityId;
	private java.lang.String remarks;
	private java.lang.String personalAddress;
	private Integer isLeader;
	private Integer isCompany;
	private java.lang.String contactName;
	private java.lang.String businessLicense;
	private Integer isAskPrice;
	private java.lang.Integer askTimes;
	private java.util.Date lastLoginTime;
	private Integer isDel;
	private Integer isCheck;
	private java.util.Date checkTime;
	//columns END
	
	
	

	public TcuserAudit(){
	}

	public TcuserAudit(
		java.lang.Long userId
	){
		this.userId = userId;
	}

	public void setUserId(java.lang.Long value) {
		this.userId = value;
	}
	
	public java.lang.Long getUserId() {
		return this.userId;
	}
	public void setLoginName(java.lang.String value) {
		this.loginName = value;
	}
	
	public java.lang.String getLoginName() {
		return this.loginName;
	}
	public void setLoginPwd(java.lang.String value) {
		this.loginPwd = value;
	}
	
	public java.lang.String getLoginPwd() {
		return this.loginPwd;
	}
	public void setLoginPwdErrCount(java.lang.Integer value) {
		this.loginPwdErrCount = value;
	}
	
	public java.lang.Integer getLoginPwdErrCount() {
		return this.loginPwdErrCount;
	}
	public void setTradingPwd(java.lang.String value) {
		this.tradingPwd = value;
	}
	
	public java.lang.String getTradingPwd() {
		return this.tradingPwd;
	}
	public void setTradingPwdErrCount(java.lang.Integer value) {
		this.tradingPwdErrCount = value;
	}
	
	public java.lang.Integer getTradingPwdErrCount() {
		return this.tradingPwdErrCount;
	}
	public void setRealName(java.lang.String value) {
		this.realName = value;
	}
	
	public java.lang.String getRealName() {
		return this.realName;
	}
	public void setGender(java.lang.String value) {
		this.gender = value;
	}
	
	public java.lang.String getGender() {
		return this.gender;
	}
	public void setAge(java.lang.Integer value) {
		this.age = value;
	}
	
	public java.lang.Integer getAge() {
		return this.age;
	}
	public void setEdu(java.lang.String value) {
		this.edu = value;
	}
	
	public java.lang.String getEdu() {
		return this.edu;
	}
	public void setSchool(java.lang.String value) {
		this.school = value;
	}
	
	public java.lang.String getSchool() {
		return this.school;
	}
	public void setGroupId(java.lang.String value) {
		this.groupId = value;
	}
	
	public java.lang.String getGroupId() {
		return this.groupId;
	}
	public void setIsLock(Integer value) {
		this.isLock = value;
	}
	
	public Integer getIsLock() {
		return this.isLock;
	}
	public void setIsActive(Integer value) {
		this.isActive = value;
	}
	
	public Integer getIsActive() {
		return this.isActive;
	}
	public void setRegisterTime(java.util.Date value) {
		this.registerTime = value;
	}
	
	public java.util.Date getRegisterTime() {
		return this.registerTime;
	}
	public void setLoginCount(java.lang.Integer value) {
		this.loginCount = value;
	}
	
	public java.lang.Integer getLoginCount() {
		return this.loginCount;
	}
	public void setChecker(java.lang.Long value) {
		this.checker = value;
	}
	
	public java.lang.Long getChecker() {
		return this.checker;
	}
	public void setProvincesId(java.lang.Long value) {
		this.provincesId = value;
	}
	
	public java.lang.Long getProvincesId() {
		return this.provincesId;
	}
	public void setCityId(java.lang.Long value) {
		this.cityId = value;
	}
	
	public java.lang.Long getCityId() {
		return this.cityId;
	}
	public void setRemarks(java.lang.String value) {
		this.remarks = value;
	}
	
	public java.lang.String getRemarks() {
		return this.remarks;
	}
	public void setPersonalAddress(java.lang.String value) {
		this.personalAddress = value;
	}
	
	public java.lang.String getPersonalAddress() {
		return this.personalAddress;
	}
	public void setIsLeader(Integer value) {
		this.isLeader = value;
	}
	
	public Integer getIsLeader() {
		return this.isLeader;
	}
	public void setIsCompany(Integer value) {
		this.isCompany = value;
	}
	
	public Integer getIsCompany() {
		return this.isCompany;
	}
	public void setContactName(java.lang.String value) {
		this.contactName = value;
	}
	
	public java.lang.String getContactName() {
		return this.contactName;
	}
	public void setBusinessLicense(java.lang.String value) {
		this.businessLicense = value;
	}
	
	public java.lang.String getBusinessLicense() {
		return this.businessLicense;
	}
	public void setIsAskPrice(Integer value) {
		this.isAskPrice = value;
	}
	
	public Integer getIsAskPrice() {
		return this.isAskPrice;
	}
	public void setAskTimes(java.lang.Integer value) {
		this.askTimes = value;
	}
	
	public java.lang.Integer getAskTimes() {
		return this.askTimes;
	}
	public void setLastLoginTime(java.util.Date value) {
		this.lastLoginTime = value;
	}
	
	public java.util.Date getLastLoginTime() {
		return this.lastLoginTime;
	}
	public void setIsDel(Integer value) {
		this.isDel = value;
	}
	
	public Integer getIsDel() {
		return this.isDel;
	}
	public void setIsCheck(Integer value) {
		this.isCheck = value;
	}
	
	public Integer getIsCheck() {
		return this.isCheck;
	}
	public void setCheckTime(java.util.Date value) {
		this.checkTime = value;
	}
	
	public java.util.Date getCheckTime() {
		return this.checkTime;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("UserId",getUserId())
			.append("LoginName",getLoginName())
			.append("LoginPwd",getLoginPwd())
			.append("LoginPwdErrCount",getLoginPwdErrCount())
			.append("TradingPwd",getTradingPwd())
			.append("TradingPwdErrCount",getTradingPwdErrCount())
			.append("RealName",getRealName())
			.append("Gender",getGender())
			.append("Age",getAge())
			.append("Edu",getEdu())
			.append("School",getSchool())
			.append("GroupId",getGroupId())
			.append("IsLock",getIsLock())
			.append("IsActive",getIsActive())
			.append("RegisterTime",getRegisterTime())
			.append("LoginCount",getLoginCount())
			.append("Checker",getChecker())
			.append("ProvincesId",getProvincesId())
			.append("CityId",getCityId())
			.append("Remarks",getRemarks())
			.append("PersonalAddress",getPersonalAddress())
			.append("IsLeader",getIsLeader())
			.append("IsCompany",getIsCompany())
			.append("ContactName",getContactName())
			.append("BusinessLicense",getBusinessLicense())
			.append("IsAskPrice",getIsAskPrice())
			.append("AskTimes",getAskTimes())
			.append("LastLoginTime",getLastLoginTime())
			.append("IsDel",getIsDel())
			.append("IsCheck",getIsCheck())
			.append("CheckTime",getCheckTime())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getUserId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TcuserAudit == false) return false;
		if(this == obj) return true;
		TcuserAudit other = (TcuserAudit)obj;
		return new EqualsBuilder()
			.append(getUserId(),other.getUserId())
			.isEquals();
	}
}

