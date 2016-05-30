package com.deelon.loan.model.backstage;

/**
 * TSettings entity. @author MyEclipse Persistence Tools
 */

public class TSettings implements java.io.Serializable {

	// Fields

	private Long settingsId;
	private Integer typeId;
	private String setCode;
	private String setValue;
	private String setDesc;
	private Integer orderId;

	// Constructors

	/** default constructor */
	public TSettings() {
	}

	/** full constructor */
	public TSettings(Integer typeId, String setCode, String setValue,
			String setDesc,Integer orderId) {
		this.typeId = typeId;
		this.setCode = setCode;
		this.setValue = setValue;
		this.setDesc = setDesc;
		this.orderId = orderId;
	}

	// Property accessors

	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public Long getSettingsId() {
		return this.settingsId;
	}

	public void setSettingsId(Long settingsId) {
		this.settingsId = settingsId;
	}

	public Integer getTypeId() {
		return this.typeId;
	}

	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}

	public String getSetCode() {
		return this.setCode;
	}

	public void setSetCode(String setCode) {
		this.setCode = setCode;
	}

	public String getSetValue() {
		return this.setValue;
	}

	public void setSetValue(String setValue) {
		this.setValue = setValue;
	}

	public String getSetDesc() {
		return this.setDesc;
	}

	public void setSetDesc(String setDesc) {
		this.setDesc = setDesc;
	}

}