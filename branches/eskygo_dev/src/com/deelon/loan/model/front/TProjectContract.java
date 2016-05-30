package com.deelon.loan.model.front;

import java.math.BigDecimal;
import java.util.Date;

import com.deelon.core.model.BaseModel;

/**
 * TProjectContract entity. @author MyEclipse Persistence Tools
 */

public class TProjectContract extends BaseModel implements java.io.Serializable {

	// Fields

	private long contractId;
	private long projectId;
	private String pcNo;
	private Date pcstarDate;
	private Date pcendDate;
	private long creator;
	private Date createTime;
	
	//非持久化
	private String proName;
	private BigDecimal ploanReal;//实际借款金额
	private int pdeadline;//贷款期限
//	private BigDecimal prateIn;//借款利率
	

	// Constructors

	/** default constructor */
	public TProjectContract() {
	}

	/** full constructor */
	public TProjectContract(long projectId, String pcNo, Date pcstarDate,
			Date pcendDate, long creator, Date createTime) {
		this.projectId = projectId;
		this.pcNo = pcNo;
		this.pcstarDate = pcstarDate;
		this.pcendDate = pcendDate;
		this.creator = creator;
		this.createTime = createTime;
	}

	// Property accessors

	public long getContractId() {
		return this.contractId;
	}

	public void setContractId(long contractId) {
		this.contractId = contractId;
	}

	public long getProjectId() {
		return this.projectId;
	}

	public void setProjectId(long projectId) {
		this.projectId = projectId;
	}

	public String getPcNo() {
		return this.pcNo;
	}

	public void setPcNo(String pcNo) {
		this.pcNo = pcNo;
	}

	

	public Date getPcstarDate() {
		return pcstarDate;
	}

	public void setPcstarDate(Date pcstarDate) {
		this.pcstarDate = pcstarDate;
	}

	public Date getPcendDate() {
		return pcendDate;
	}

	public void setPcendDate(Date pcendDate) {
		this.pcendDate = pcendDate;
	}

	public long getCreator() {
		return this.creator;
	}

	public void setCreator(long creator) {
		this.creator = creator;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getProName() {
		return proName;
	}

	public void setProName(String proName) {
		this.proName = proName;
	}

	public BigDecimal getPloanReal() {
		return ploanReal;
	}

	public void setPloanReal(BigDecimal ploanReal) {
		this.ploanReal = ploanReal;
	}

	public int getPdeadline() {
		return pdeadline;
	}

	public void setPdeadline(int pdeadline) {
		this.pdeadline = pdeadline;
	}

	
	
	

}