package com.deelon.loan.model.front;

import java.util.Date;

/**
 * TUserFamily entity. @author MyEclipse Persistence Tools
 */

public class TUserFamily implements java.io.Serializable {

	// Fields

	private long familyId;
	private long userId;
	private String FMarriage;
	private String FHouse;
	private String FProvincesId;
	private String FCityId;
	private String FAreaId;
	private String FAddress;
	private String FPhone;
	private String FLiveYears;
	private String FIsBuyCar;
	private Date FUpdateTime;
	private short fisCarLoan;
	private short fisHouseLoan;
	private String statusID;
	private Date checkTime;

	// Constructors



	/** default constructor */
	public TUserFamily() {
	}





	public TUserFamily(long familyId, long userId, String fMarriage,
			String fHouse, String fProvincesId, String fCityId, String fAreaId,
			String fAddress, String fPhone, String fLiveYears,
			String fIsBuyCar, Date fUpdateTime, short fisCarLoan,
			short fisHouseLoan, String statusID, Date checkTime) {
		super();
		this.familyId = familyId;
		this.userId = userId;
		FMarriage = fMarriage;
		FHouse = fHouse;
		FProvincesId = fProvincesId;
		FCityId = fCityId;
		FAreaId = fAreaId;
		FAddress = fAddress;
		FPhone = fPhone;
		FLiveYears = fLiveYears;
		FIsBuyCar = fIsBuyCar;
		FUpdateTime = fUpdateTime;
		this.fisCarLoan = fisCarLoan;
		this.fisHouseLoan = fisHouseLoan;
		this.statusID = statusID;
		this.checkTime = checkTime;
	}





	/** full constructor */


	// Property accessors

	public long getFamilyId() {
		return this.familyId;
	}

	public void setFamilyId(long familyId) {
		this.familyId = familyId;
	}

	public long getUserId() {
		return this.userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getFMarriage() {
		return this.FMarriage;
	}

	public void setFMarriage(String FMarriage) {
		this.FMarriage = FMarriage;
	}
	
	public String getFProvincesId() {
		return FProvincesId;
	}



	public void setFProvincesId(String fProvincesId) {
		FProvincesId = fProvincesId;
	}



	public String getFCityId() {
		return FCityId;
	}



	public void setFCityId(String fCityId) {
		FCityId = fCityId;
	}



	public String getFHouse() {
		return this.FHouse;
	}

	public void setFHouse(String FHouse) {
		this.FHouse = FHouse;
	}

	public String getFAreaId() {
		return this.FAreaId;
	}

	public void setFAreaId(String FAreaId) {
		this.FAreaId = FAreaId;
	}

	public String getFAddress() {
		return this.FAddress;
	}

	public void setFAddress(String FAddress) {
		this.FAddress = FAddress;
	}

	public String getFPhone() {
		return this.FPhone;
	}

	public void setFPhone(String FPhone) {
		this.FPhone = FPhone;
	}

	public String getFLiveYears() {
		return this.FLiveYears;
	}

	public void setFLiveYears(String FLiveYears) {
		this.FLiveYears = FLiveYears;
	}

	public String getFIsBuyCar() {
		return this.FIsBuyCar;
	}

	public void setFIsBuyCar(String FIsBuyCar) {
		this.FIsBuyCar = FIsBuyCar;
	}

	public Date getFUpdateTime() {
		return this.FUpdateTime;
	}

	public void setFUpdateTime(Date FUpdateTime) {
		this.FUpdateTime = FUpdateTime;
	}

	public short getFisCarLoan() {
		return fisCarLoan;
	}

	public void setFisCarLoan(short fisCarLoan) {
		this.fisCarLoan = fisCarLoan;
	}

	public short getFisHouseLoan() {
		return fisHouseLoan;
	}

	public void setFisHouseLoan(short fisHouseLoan) {
		this.fisHouseLoan = fisHouseLoan;
	}



	public String getStatusID() {
		return statusID;
	}



	public void setStatusID(String statusID) {
		this.statusID = statusID;
	}



	public Date getCheckTime() {
		return checkTime;
	}



	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}


}