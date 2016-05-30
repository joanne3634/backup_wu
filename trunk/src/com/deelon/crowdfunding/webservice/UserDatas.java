package com.deelon.crowdfunding.webservice;

import java.util.List;

import com.thoughtworks.xstream.annotations.XStreamImplicit;

public class UserDatas {
	 @XStreamImplicit
	List<UserData> userDataList;

	public List<UserData> getUserDataList() {
		return userDataList;
	}

	public void setUserDataList(List<UserData> userDataList) {
		this.userDataList = userDataList;
	}
	

}
