package com.deelon.loan.model.sysManager;

import com.thoughtworks.xstream.annotations.XStreamAlias;

@XStreamAlias("policeCheckInfo")
public class XmlPoliceCheckInfo {
	private XmlMessage message;
	private String name;
	private String identitycard;
	private String compStatus;
	private String compResult;

	public XmlMessage getMessage() {
		return message;
	}
	
	public void setMessage(XmlMessage message) {
		this.message = message;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIdentitycard() {
		return identitycard;
	}

	public void setIdentitycard(String identitycard) {
		this.identitycard = identitycard;
	}

	public String getCompStatus() {
		return compStatus;
	}

	public void setCompStatus(String compStatus) {
		this.compStatus = compStatus;
	}

	public String getCompResult() {
		return compResult;
	}

	public void setCompResult(String compResult) {
		this.compResult = compResult;
	}
	
	
}
