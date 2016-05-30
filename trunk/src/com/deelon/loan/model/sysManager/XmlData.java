package com.deelon.loan.model.sysManager;

import java.util.List;

import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamImplicit;

/**
 * 解析国政通实名认证接口xml节点
 * @author ZJJ
 *
 */
@XStreamAlias("data")
public class XmlData {
    private XmlMessage message;
    @XStreamImplicit
    private List<XmlPoliceCheckInfos>  policeCheckInfos;
	public XmlMessage getMessage() {
		return message;
	}
	
	public void setMessage(XmlMessage message) {
		this.message = message;
	}

	public List<XmlPoliceCheckInfos> getPoliceCheckInfos() {
		return policeCheckInfos;
	}

	public void setPoliceCheckInfos(List<XmlPoliceCheckInfos> policeCheckInfos) {
		this.policeCheckInfos = policeCheckInfos;
	}
   
}
