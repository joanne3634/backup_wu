package com.deelon.loan.model.front;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */



import com.deelon.core.model.BaseModel;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class TUserAuditMat extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "TuserAuditmat";
	public static final String ALIAS_AUDIT_MAT_ID = "瀹℃牳ID";
	public static final String ALIAS_USER_ID = "鐢ㄦ埛ID";
	public static final String ALIAS_MATERIALS_ID = "鏉愭枡ID";
	public static final String ALIAS_IS_PASS = "鏄惁瀹℃牳閫氳繃";
	public static final String ALIAS_CHECKER = "瀹℃牳浜�";
	public static final String ALIAS_CHECK_TIME = "瀹℃牳鏃堕棿";
	public static final String ALIAS_REASONS = "鏈�杩囩悊鐢�";
	public static final String ALIAS_IS_RE_PASS = "鏄惁閲嶆柊瀹℃牳";
	 
	//鍙互鐩存帴浣跨敤: @Length(max=50,message="鐢ㄦ埛鍚嶉暱搴︿笉鑳藉ぇ浜�0")鏄剧ず閿欒娑堟伅
	//columns START
	private java.lang.Long auditMatId;
	private java.lang.Long userId;
	private java.lang.Long materialsId;
	private Integer isPass;
	private java.lang.Long checker;
	private java.util.Date checkTime;
	private java.lang.String reasons;
	private Integer isRePass;
	
	//非持久化
	private String fileName;
	private String checkTimeS;
	//columns END

	public TUserAuditMat(){
	}

	public TUserAuditMat(
		java.lang.Long auditMatId
	){
		this.auditMatId = auditMatId;
	}

	public void setAuditMatId(java.lang.Long value) {
		this.auditMatId = value;
	}
	
	public java.lang.Long getAuditMatId() {
		return this.auditMatId;
	}
	public void setUserId(java.lang.Long value) {
		this.userId = value;
	}
	
	public java.lang.Long getUserId() {
		return this.userId;
	}
	public void setMaterialsId(java.lang.Long value) {
		this.materialsId = value;
	}
	
	public java.lang.Long getMaterialsId() {
		return this.materialsId;
	}
	public void setIsPass(Integer value) {
		this.isPass = value;
	}
	
	public Integer getIsPass() {
		return this.isPass;
	}
	public void setChecker(java.lang.Long value) {
		this.checker = value;
	}
	
	public java.lang.Long getChecker() {
		return this.checker;
	}
	public void setCheckTime(java.util.Date value) {
		this.checkTime = value;
	}
	
	public java.util.Date getCheckTime() {
		return this.checkTime;
	}
	public void setReasons(java.lang.String value) {
		this.reasons = value;
	}
	
	public java.lang.String getReasons() {
		return this.reasons;
	}
	public void setIsRePass(Integer value) {
		this.isRePass = value;
	}
	
	public Integer getIsRePass() {
		return this.isRePass;
	}

	
	
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	
	public String getCheckTimeS() {
		return checkTimeS;
	}

	public void setCheckTimeS(String checkTimeS) {
		this.checkTimeS = checkTimeS;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("AuditMatId",getAuditMatId())
			.append("UserId",getUserId())
			.append("MaterialsId",getMaterialsId())
			.append("IsPass",getIsPass())
			.append("Checker",getChecker())
			.append("CheckTime",getCheckTime())
			.append("Reasons",getReasons())
			.append("IsRePass",getIsRePass())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getAuditMatId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TUserAuditMat == false) return false;
		if(this == obj) return true;
		TUserAuditMat other = (TUserAuditMat)obj;
		return new EqualsBuilder()
			.append(getAuditMatId(),other.getAuditMatId())
			.isEquals();
	}
}

