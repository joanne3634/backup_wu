package com.deelon.loan.model.front;

import java.math.BigDecimal;
import java.util.Date;

import com.deelon.core.model.BaseModel;

/**
 * TUser entity. @author MyEclipse Persistence Tools
 */

public class TUser extends BaseModel  {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1135297621448785467L;
	// Fields

	private long userId;
	private String loginName;
	private String loginPwd;
	private int loginPwdErrCount;
	private String tradingPwd;
	private int tradingPwdErrCount;
	private String realName;
	private int age;
	private String gender;
	private String edu;
	private String school;
	private String groupId;
	private Integer isLock;
	private Integer isActive;
	private Date lastLoginTime;
	private int isDel;
	private Date registerTime;
	private int loginCount;
	private long checker;
	private Long provincesId;
	private Long cityId;
	private java.lang.String remarks;
	private java.lang.String personalAddress;
	private Integer isLeader;
	private Integer isCompany;
	private java.lang.String contactName;
	private java.lang.String businessLicense;
	private Integer isAskPrice;
	private java.lang.Integer askTimes;
	private Integer isCheck;
	private Date checkTime;
	private Integer isRecommended;
	private Date recommendedTime;
	private String myPhoto;
	private Integer isPerfectDoc;
	private String inviterCode;
	private String ownCode;
	
	
	//非持久化字段
			private String fileId;// 图片附件id 附件表
			private String idNo;
			private String email;
			private String mobile;
			private String bindIdno;    //是否实名验证身份证
			
			
			//非持久化
			private int creditOut;//借出信用
			private int creditIn;//借入信用

			private String idCard;//身份证号
			private String filedId;//用户图像id
			private String alinkAction;//操作链接
			
			//
			private String FMarriage;
			private String FIsBuyCar;
			private short FisCarLoan;
			private String FHouse;
			private short FisHouseLoan;
			 private String CIndustry;
			 private String CSize;
			 private String CDeptName;
			 private String CAddress;
			 private String CWorkYears;
			 private String CIncomeScope;
			 private BigDecimal piInvest;
			 private Date piInvestTime;
			 private int piTypeID;
			// Constructors
			 
				public TUser(long userId, String loginName, String loginPwd,
						int loginPwdErrCount, String tradingPwd, int tradingPwdErrCount,
						String realName, int age, String gender, String edu, String school,
						String groupId, int isLock, int isActive, Date lastLoginTime,
						int isDel, Date registerTime) {
					super();
					this.userId = userId;
					this.loginName = loginName;
					this.loginPwd = loginPwd;
					this.loginPwdErrCount = loginPwdErrCount;
					this.tradingPwd = tradingPwd;
					this.tradingPwdErrCount = tradingPwdErrCount;
					this.realName = realName;
					this.age = age;
					this.gender = gender;
					this.edu = edu;
					this.school = school;
					this.groupId = groupId;
					this.isLock = isLock;
					this.isActive = isActive;
					this.lastLoginTime = lastLoginTime;
					this.isDel = isDel;
					this.registerTime = registerTime;
				}
	
	public Integer getIsRecommended() {
		return isRecommended;
	}

	public void setIsRecommended(Integer isRecommended) {
		this.isRecommended = isRecommended;
	}

	public Date getRecommendedTime() {
		return recommendedTime;
	}

	public void setRecommendedTime(Date recommendedTime) {
		this.recommendedTime = recommendedTime;
	}


	public String getMyPhoto() {
		return myPhoto;
	}

	public void setMyPhoto(String myPhoto) {
		this.myPhoto = myPhoto;
	}

	public int getLoginCount() {
		return loginCount;
	}

	public void setLoginCount(int loginCount) {
		this.loginCount = loginCount;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getBindIdno() {
		return bindIdno;
	}

	public void setBindIdno(String bindIdno) {
		this.bindIdno = bindIdno;
	}

	

	/** default constructor */
	public TUser() {
	}

	public String getSchool() {
		return school;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	public Long getProvincesId() {
		return provincesId;
	}

	public void setProvincesId(Long provincesId) {
		this.provincesId = provincesId;
	}

	public Long getCityId() {
		return cityId;
	}

	public void setCityId(Long cityId) {
		this.cityId = cityId;
	}

	public java.lang.String getRemarks() {
		return remarks;
	}

	public void setRemarks(java.lang.String remarks) {
		this.remarks = remarks;
	}

	public java.lang.String getPersonalAddress() {
		return personalAddress;
	}

	public void setPersonalAddress(java.lang.String personalAddress) {
		this.personalAddress = personalAddress;
	}

	public Integer getIsLeader() {
		return isLeader;
	}

	public void setIsLeader(Integer isLeader) {
		this.isLeader = isLeader;
	}

	public Integer getIsCompany() {
		return isCompany;
	}

	public void setIsCompany(Integer isCompany) {
		this.isCompany = isCompany;
	}

	public java.lang.String getContactName() {
		return contactName;
	}

	public void setContactName(java.lang.String contactName) {
		this.contactName = contactName;
	}

	public java.lang.String getBusinessLicense() {
		return businessLicense;
	}

	public void setBusinessLicense(java.lang.String businessLicense) {
		this.businessLicense = businessLicense;
	}

	public Integer getIsAskPrice() {
		return isAskPrice;
	}

	public void setIsAskPrice(Integer isAskPrice) {
		this.isAskPrice = isAskPrice;
	}

	public java.lang.Integer getAskTimes() {
		return askTimes;
	}

	public void setAskTimes(java.lang.Integer askTimes) {
		this.askTimes = askTimes;
	}

	public Integer getIsCheck() {
		return isCheck;
	}

	public void setIsCheck(Integer isCheck) {
		this.isCheck = isCheck;
	}

	public Date getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}

	public String getIdNo() {
		return idNo;
	}

	public void setIdNo(String idNo) {
		this.idNo = idNo;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getLoginPwd() {
		return loginPwd;
	}

	public void setLoginPwd(String loginPwd) {
		this.loginPwd = loginPwd;
	}

	public int getLoginPwdErrCount() {
		return loginPwdErrCount;
	}

	public void setLoginPwdErrCount(int loginPwdErrCount) {
		this.loginPwdErrCount = loginPwdErrCount;
	}

	public String getTradingPwd() {
		return tradingPwd;
	}

	public void setTradingPwd(String tradingPwd) {
		this.tradingPwd = tradingPwd;
	}

	public int getTradingPwdErrCount() {
		return tradingPwdErrCount;
	}

	public void setTradingPwdErrCount(int tradingPwdErrCount) {
		this.tradingPwdErrCount = tradingPwdErrCount;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getEdu() {
		return edu;
	}

	public void setEdu(String edu) {
		this.edu = edu;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public Integer getIsLock() {
		return isLock;
	}

	public void setIsLock(Integer isLock) {
		this.isLock = isLock;
	}

	public Integer getIsActive() {
		return isActive;
	}

	public void setIsActive(Integer isActive) {
		this.isActive = isActive;
	}

	public Date getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public int getIsDel() {
		return isDel;
	}

	public void setIsDel(int isDel) {
		this.isDel = isDel;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}



	


	public int getCreditOut() {
		return creditOut;
	}

	public void setCreditOut(int creditOut) {
		this.creditOut = creditOut;
	}

	public int getCreditIn() {
		return creditIn;
	}

	public void setCreditIn(int creditIn) {
		this.creditIn = creditIn;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getFiledId() {
		return filedId;
	}

	public void setFiledId(String filedId) {
		this.filedId = filedId;
	}
	
	

	public String getAlinkAction() {
		return alinkAction;
	}

	public void setAlinkAction(String alinkAction) {
		this.alinkAction = alinkAction;
	}

	
	
	public String getFMarriage() {
		return FMarriage;
	}

	public void setFMarriage(String fMarriage) {
		FMarriage = fMarriage;
	}

	public String getFIsBuyCar() {
		return FIsBuyCar;
	}

	public void setFIsBuyCar(String fIsBuyCar) {
		FIsBuyCar = fIsBuyCar;
	}

	public short getFisCarLoan() {
		return FisCarLoan;
	}

	public void setFisCarLoan(short fisCarLoan) {
		FisCarLoan = fisCarLoan;
	}

	public String getFHouse() {
		return FHouse;
	}

	public void setFHouse(String fHouse) {
		FHouse = fHouse;
	}

	public short getFisHouseLoan() {
		return FisHouseLoan;
	}

	public void setFisHouseLoan(short fisHouseLoan) {
		FisHouseLoan = fisHouseLoan;
	}

	public String getCIndustry() {
		return CIndustry;
	}

	public void setCIndustry(String cIndustry) {
		CIndustry = cIndustry;
	}

	public String getCSize() {
		return CSize;
	}

	public void setCSize(String cSize) {
		CSize = cSize;
	}

	public String getCDeptName() {
		return CDeptName;
	}

	public void setCDeptName(String cDeptName) {
		CDeptName = cDeptName;
	}

	public String getCAddress() {
		return CAddress;
	}

	public void setCAddress(String cAddress) {
		CAddress = cAddress;
	}

	public String getCWorkYears() {
		return CWorkYears;
	}

	public void setCWorkYears(String cWorkYears) {
		CWorkYears = cWorkYears;
	}

	public String getCIncomeScope() {
		return CIncomeScope;
	}

	public void setCIncomeScope(String cIncomeScope) {
		CIncomeScope = cIncomeScope;
	}
	public Date getRegisterTime() {
		return registerTime;
	}

	public void setRegisterTime(Date registerTime) {
		this.registerTime = registerTime;
	}

	public long getChecker() {
		return checker;
	}

	public void setChecker(long checker) {
		this.checker = checker;
	}
	

	public BigDecimal getPiInvest() {
		return piInvest;
	}

	public void setPiInvest(BigDecimal piInvest) {
		this.piInvest = piInvest;
	}

	public Date getPiInvestTime() {
		return piInvestTime;
	}

	public void setPiInvestTime(Date piInvestTime) {
		this.piInvestTime = piInvestTime;
	}

	public int getPiTypeID() {
		return piTypeID;
	}

	public void setPiTypeID(int piTypeID) {
		this.piTypeID = piTypeID;
	}

	
	public Integer getIsPerfectDoc() {
		return isPerfectDoc;
	}

	public void setIsPerfectDoc(Integer isPerfectDoc) {
		this.isPerfectDoc = isPerfectDoc;
	}

	public String getInviterCode() {
		return inviterCode;
	}

	public void setInviterCode(String inviterCode) {
		this.inviterCode = inviterCode;
	}

	public String getOwnCode() {
		return ownCode;
	}

	public void setOwnCode(String ownCode) {
		this.ownCode = ownCode;
	}

	@Override
	public String toString() {
		return "TUser [userId=" + userId + ", loginName=" + loginName
				+ ", loginPwd=" + loginPwd + ", loginPwdErrCount="
				+ loginPwdErrCount + ", tradingPwd=" + tradingPwd
				+ ", tradingPwdErrCount=" + tradingPwdErrCount + ", realName="
				+ realName + ", age=" + age + ", gender=" + gender + ", edu="
				+ edu + ", groupId=" + groupId + ", isLock=" + isLock
				+ ", isActive=" + isActive + ", lastLoginTime=" + lastLoginTime
				+ ", isDel=" + isDel + "]";
	}

}