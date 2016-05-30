package com.deelon.loan.model.sysManager;

import com.thoughtworks.xstream.annotations.XStreamAlias;

@XStreamAlias("policeCheckInfos")
public class XmlPoliceCheckInfos {
	
     private XmlPoliceCheckInfo  policeCheckInfo;

	public XmlPoliceCheckInfo getPoliceCheckInfo() {
		return policeCheckInfo;
	}

	public void setPoliceCheckInfo(XmlPoliceCheckInfo policeCheckInfo) {
		this.policeCheckInfo = policeCheckInfo;
	}
     
}
