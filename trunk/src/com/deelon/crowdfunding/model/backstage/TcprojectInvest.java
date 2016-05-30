/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.crowdfunding.model.backstage;
import java.math.BigDecimal;
import java.util.Date;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.deelon.core.model.BaseModel;

public class TcprojectInvest extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "TcprojectInvest";
	public static final String ALIAS_INVEST_ID = "认投ID";
	public static final String ALIAS_PROJECT_ID = "项目ID";
	public static final String ALIAS_USER_ID = "投资人ID";
	public static final String ALIAS_PIIS_LEADER = "是否是领投人";
	public static final String ALIAS_PITYPE_ID = "认投类型：1领投全部  2领投部分 3跟投";
	public static final String ALIAS_PIVALUATION = "估值（万元）";
	public static final String ALIAS_PIINVEST = "认投金额（万元）";
	public static final String ALIAS_PIINVEST_TIME = "认投时间 ";
	public static final String ALIAS_PIREASONS = "投资理由";
	public static final String ALIAS_PIMY_HELP = "我能为创业都提供非资金的帮助";
	public static final String ALIAS_PIIS_GENERAL_PARTNER = "是否愿意担任有限合伙企业普通合伙人";
	public static final String ALIAS_PIIS_PAY = "是否放款";
	public static final String ALIAS_PIPAY_TIME = "放款时间";
	public static final String ALIAS_PIIS_ASK_PRICE = "是否询价";
	public static final String ALIAS_PIHAVED_PAY = "已放款金额";
	public static final String ALIAS_PIIS_CHECK = "是否通过审核";
	public static final String ALIAS_PICHECKER = "审核人";
	public static final String ALIAS_PICHECK_TIME = "审核时间";
	public static final String ALIAS_PIDENY_REASON = "拒绝理由";
	public static final String ALIAS_PIIS_CANCEL = "取消认投（反悔）";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long investId;
	private java.lang.Long projectId;
	private java.lang.Long userId;
	private Integer piisLeader;
	private Integer pitypeId;
	private BigDecimal pivaluation;
	private BigDecimal piinvest;
	private java.util.Date piinvestTime;
	private java.lang.String pireasons;
	private java.lang.String pimyHelp;
	private Integer piisGeneralPartner;
	private Integer piisPay;
	private java.util.Date pipayTime;
	private Integer piisAskPrice;
	private Double pihavedPay;
	private Integer piisCheck;
	private java.lang.Long pichecker;
	private java.util.Date picheckTime;
	private java.lang.String pidenyReason;
	private Integer piisCancel;
	private String picancelReason;
	private Integer piaskPriceTimes;
	private Integer piisLoans;
	private java.util.Date piLoansTime;
	private String PI_DueDoc;
	private String PI_EvaluationTeam;
	private String PI_EvaluationProject;

	private String piinvestTimeS;
	private String fileId;
	private String loginName;
	private String myPhoto;
	
	//columns END
	private String realName;
	private String pname;//项目名称
	private BigDecimal pvaluationFinal;
	private java.util.Date piCancelTime;
	private String piinvestTotal="0";
	private Date pcloseDate;
	
	private String resultCode;//
	

	public TcprojectInvest(){
	}

	public Integer getPiisLoans() {
		return piisLoans;
	}

	public void setPiisLoans(Integer piisLoans) {
		this.piisLoans = piisLoans;
	}

	public java.util.Date getPiLoansTime() {
		return piLoansTime;
	}

	public void setPiLoansTime(java.util.Date piLoansTime) {
		this.piLoansTime = piLoansTime;
	}

	public TcprojectInvest(
		java.lang.Long investId
	){
		this.investId = investId;
	}

	public void setInvestId(java.lang.Long value) {
		this.investId = value;
	}
	
	public java.lang.Long getInvestId() {
		return this.investId;
	}
	public void setProjectId(java.lang.Long value) {
		this.projectId = value;
	}
	
	public java.lang.Long getProjectId() {
		return this.projectId;
	}
	public void setUserId(java.lang.Long value) {
		this.userId = value;
	}
	
	public java.lang.Long getUserId() {
		return this.userId;
	}
	public void setPiisLeader(Integer value) {
		this.piisLeader = value;
	}
	
	public Integer getPiisLeader() {
		return this.piisLeader;
	}
	public void setPitypeId(Integer value) {
		this.pitypeId = value;
	}
	
	public Integer getPitypeId() {
		return this.pitypeId;
	}
	public void setPivaluation(BigDecimal value) {
		this.pivaluation = value;
	}
	
	public BigDecimal getPivaluation() {
		return this.pivaluation;
	}
	public void setPiinvest(BigDecimal value) {
		this.piinvest = value;
	}
	
	public BigDecimal getPiinvest() {
		return this.piinvest;
	}
	public void setPiinvestTime(java.util.Date value) {
		this.piinvestTime = value;
	}
	
	public java.util.Date getPiinvestTime() {
		return this.piinvestTime;
	}
	public void setPireasons(java.lang.String value) {
		this.pireasons = value;
	}
	
	public java.lang.String getPireasons() {
		return this.pireasons;
	}
	public void setPimyHelp(java.lang.String value) {
		this.pimyHelp = value;
	}
	
	public java.lang.String getPimyHelp() {
		return this.pimyHelp;
	}
	public void setPiisGeneralPartner(Integer value) {
		this.piisGeneralPartner = value;
	}
	
	public Integer getPiisGeneralPartner() {
		return this.piisGeneralPartner;
	}
	public void setPiisPay(Integer value) {
		this.piisPay = value;
	}
	
	public Integer getPiisPay() {
		return this.piisPay;
	}
	public void setPipayTime(java.util.Date value) {
		this.pipayTime = value;
	}
	
	public java.util.Date getPipayTime() {
		return this.pipayTime;
	}
	public void setPiisAskPrice(Integer value) {
		this.piisAskPrice = value;
	}
	
	public Integer getPiisAskPrice() {
		return this.piisAskPrice;
	}
	public void setPihavedPay(Double value) {
		this.pihavedPay = value;
	}
	
	public Double getPihavedPay() {
		return this.pihavedPay;
	}
	public void setPiisCheck(Integer value) {
		this.piisCheck = value;
	}
	
	public Integer getPiisCheck() {
		return this.piisCheck;
	}
	public void setPichecker(java.lang.Long value) {
		this.pichecker = value;
	}
	
	public java.lang.Long getPichecker() {
		return this.pichecker;
	}
	public void setPicheckTime(java.util.Date value) {
		this.picheckTime = value;
	}
	
	public java.util.Date getPicheckTime() {
		return this.picheckTime;
	}
	public void setPidenyReason(java.lang.String value) {
		this.pidenyReason = value;
	}
	
	public java.lang.String getPidenyReason() {
		return this.pidenyReason;
	}
	public void setPiisCancel(Integer value) {
		this.piisCancel = value;
	}
	
	public Integer getPiisCancel() {
		return this.piisCancel;
	}

	public String getPicancelReason() {
		return picancelReason;
	}

	public void setPicancelReason(String picancelReason) {
		this.picancelReason = picancelReason;
	}

	public Integer getPiaskPriceTimes() {
		return piaskPriceTimes;
	}

	public void setPiaskPriceTimes(Integer piaskPriceTimes) {
		this.piaskPriceTimes = piaskPriceTimes;
	}

	public String getPiinvestTimeS() {
		return piinvestTimeS;
	}

	public void setPiinvestTimeS(String piinvestTimeS) {
		this.piinvestTimeS = piinvestTimeS;
	}
	
	

	public String getPI_DueDoc() {
		return PI_DueDoc;
	}

	public void setPI_DueDoc(String pI_DueDoc) {
		PI_DueDoc = pI_DueDoc;
	}

	public String getPI_EvaluationTeam() {
		return PI_EvaluationTeam;
	}

	public void setPI_EvaluationTeam(String pI_EvaluationTeam) {
		PI_EvaluationTeam = pI_EvaluationTeam;
	}

	public String getPI_EvaluationProject() {
		return PI_EvaluationProject;
	}

	public void setPI_EvaluationProject(String pI_EvaluationProject) {
		PI_EvaluationProject = pI_EvaluationProject;
	}

	
	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	
	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getMyPhoto() {
		return myPhoto;
	}

	public void setMyPhoto(String myPhoto) {
		this.myPhoto = myPhoto;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public BigDecimal getPvaluationFinal() {
		return pvaluationFinal;
	}

	public void setPvaluationFinal(BigDecimal pvaluationFinal) {
		this.pvaluationFinal = pvaluationFinal;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public java.util.Date getPiCancelTime() {
		return piCancelTime;
	}

	public void setPiCancelTime(java.util.Date piCancelTime) {
		this.piCancelTime = piCancelTime;
	}
	
	

	public String getResultCode() {
		return resultCode;
	}

	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}
	
	

	public String getPiinvestTotal() {
		return piinvestTotal;
	}

	public void setPiinvestTotal(String piinvestTotal) {
		this.piinvestTotal = piinvestTotal;
	}

	public Date getPcloseDate() {
		return pcloseDate;
	}

	public void setPcloseDate(Date pcloseDate) {
		this.pcloseDate = pcloseDate;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("InvestId",getInvestId())
			.append("ProjectId",getProjectId())
			.append("UserId",getUserId())
			.append("PiisLeader",getPiisLeader())
			.append("PitypeId",getPitypeId())
			.append("Pivaluation",getPivaluation())
			.append("Piinvest",getPiinvest())
			.append("PiinvestTime",getPiinvestTime())
			.append("Pireasons",getPireasons())
			.append("PimyHelp",getPimyHelp())
			.append("PiisGeneralPartner",getPiisGeneralPartner())
			.append("PiisPay",getPiisPay())
			.append("PipayTime",getPipayTime())
			.append("PiisAskPrice",getPiisAskPrice())
			.append("PihavedPay",getPihavedPay())
			.append("PiisCheck",getPiisCheck())
			.append("Pichecker",getPichecker())
			.append("PicheckTime",getPicheckTime())
			.append("PidenyReason",getPidenyReason())
			.append("PiisCancel",getPiisCancel())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getInvestId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TcprojectInvest == false) return false;
		if(this == obj) return true;
		TcprojectInvest other = (TcprojectInvest)obj;
		return new EqualsBuilder()
			.append(getInvestId(),other.getInvestId())
			.isEquals();
	}

	 
}

