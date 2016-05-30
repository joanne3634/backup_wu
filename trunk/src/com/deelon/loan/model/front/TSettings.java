package com.deelon.loan.model.front;

/**
 * TSettings entity. @author MyEclipse Persistence Tools
 */

public class TSettings implements java.io.Serializable {

	// Fields

	private long settingsId;
	private Integer typeId;
	private String setCode;
	private String setValue;
	private String setDesc;

	// Constructors

	/** default constructor */
	public TSettings() {
	}

	/** full constructor */
	public TSettings(Integer typeId, String setCode, String setValue,
			String setDesc) {
		this.typeId = typeId;
		this.setCode = setCode;
		this.setValue = setValue;
		this.setDesc = setDesc;
	}

	// Property accessors

	public long getSettingsId() {
		return this.settingsId;
	}

	public void setSettingsId(long settingsId) {
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