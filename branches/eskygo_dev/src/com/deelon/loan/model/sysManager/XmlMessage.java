package com.deelon.loan.model.sysManager;

import com.thoughtworks.xstream.annotations.XStreamAlias;

@XStreamAlias("message")
public class XmlMessage {
    private String status;
    private String value;
   
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
    
    
}
