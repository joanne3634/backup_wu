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

public class TcprojectContract extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "TcprojectContract";
	public static final String ALIAS_CONTRACT_ID = "合同ID";
	public static final String ALIAS_PROJECT_ID = "项目ID";
	public static final String ALIAS_PC_NO = "合同编号";
	public static final String ALIAS_PCNAME = "合同名称";
	public static final String ALIAS_PCCOMPANY_NAME = "公司名称";
	public static final String ALIAS_PCSTAR_DATE = "开始日期";
	public static final String ALIAS_PCEND_DATE = "结束日期";
	public static final String ALIAS_PCSIGNING_DATE = "签订日期";
	public static final String ALIAS_PCSIGN_PEOPLE = "签订人姓名";
	public static final String ALIAS_PCSIGN_ADDRESS = "签订地点";
	public static final String ALIAS_PCREMARKS = "备注";
	public static final String ALIAS_CREATOR = "创建人";
	public static final String ALIAS_CREATE_TIME = "创建时间";
	public static final String ALIAS_FILE_ID = "附件ID";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long contractId;
	private java.lang.Long projectId;
	private java.lang.String pcNo;
	private java.lang.String pcname;
	private java.lang.String pccompanyName;
	private java.util.Date pcstarDate;
	private java.util.Date pcendDate;
	private java.util.Date pcsigningDate;
	private java.lang.String pcsignPeople;
	private java.lang.String pcsignAddress;
	private java.lang.String pcremarks;
	private java.lang.Long creator;
	private java.util.Date createTime;
	private java.lang.String fileId;
	//columns END

	public TcprojectContract(){
	}

	public TcprojectContract(
		java.lang.Long contractId
	){
		this.contractId = contractId;
	}

	public void setContractId(java.lang.Long value) {
		this.contractId = value;
	}
	
	public java.lang.Long getContractId() {
		return this.contractId;
	}
	public void setProjectId(java.lang.Long value) {
		this.projectId = value;
	}
	
	public java.lang.Long getProjectId() {
		return this.projectId;
	}
	public void setPcNo(java.lang.String value) {
		this.pcNo = value;
	}
	
	public java.lang.String getPcNo() {
		return this.pcNo;
	}
	public void setPcname(java.lang.String value) {
		this.pcname = value;
	}
	
	public java.lang.String getPcname() {
		return this.pcname;
	}
	public void setPccompanyName(java.lang.String value) {
		this.pccompanyName = value;
	}
	
	public java.lang.String getPccompanyName() {
		return this.pccompanyName;
	}
	public void setPcstarDate(java.util.Date value) {
		this.pcstarDate = value;
	}
	
	public java.util.Date getPcstarDate() {
		return this.pcstarDate;
	}
	public void setPcendDate(java.util.Date value) {
		this.pcendDate = value;
	}
	
	public java.util.Date getPcendDate() {
		return this.pcendDate;
	}
	public void setPcsigningDate(java.util.Date value) {
		this.pcsigningDate = value;
	}
	
	public java.util.Date getPcsigningDate() {
		return this.pcsigningDate;
	}
	public void setPcsignPeople(java.lang.String value) {
		this.pcsignPeople = value;
	}
	
	public java.lang.String getPcsignPeople() {
		return this.pcsignPeople;
	}
	public void setPcsignAddress(java.lang.String value) {
		this.pcsignAddress = value;
	}
	
	public java.lang.String getPcsignAddress() {
		return this.pcsignAddress;
	}
	public void setPcremarks(java.lang.String value) {
		this.pcremarks = value;
	}
	
	public java.lang.String getPcremarks() {
		return this.pcremarks;
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
	public void setFileId(java.lang.String value) {
		this.fileId = value;
	}
	
	public java.lang.String getFileId() {
		return this.fileId;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("ContractId",getContractId())
			.append("ProjectId",getProjectId())
			.append("PcNo",getPcNo())
			.append("Pcname",getPcname())
			.append("PccompanyName",getPccompanyName())
			.append("PcstarDate",getPcstarDate())
			.append("PcendDate",getPcendDate())
			.append("PcsigningDate",getPcsigningDate())
			.append("PcsignPeople",getPcsignPeople())
			.append("PcsignAddress",getPcsignAddress())
			.append("Pcremarks",getPcremarks())
			.append("Creator",getCreator())
			.append("CreateTime",getCreateTime())
			.append("FileId",getFileId())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getContractId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TcprojectContract == false) return false;
		if(this == obj) return true;
		TcprojectContract other = (TcprojectContract)obj;
		return new EqualsBuilder()
			.append(getContractId(),other.getContractId())
			.isEquals();
	}
}

