package com.deelon.loan.model.front;

import java.util.Date;

import com.deelon.core.model.BaseModel;

public class TProjectApplyView extends BaseModel {
	
	private long applyViewId;
	private long projectId;
	private long userId;
	private int  pavIsAgree;
	private Date pavAgreeTime;
	private Date applyTime;
	
	 private String realName;
	 private String loginName;
	
	public long getApplyViewId() {
		return applyViewId;
	}
	public void setApplyViewId(long applyViewId) {
		this.applyViewId = applyViewId;
	}
	public long getProjectId() {
		return projectId;
	}
	public void setProjectId(long projectId) {
		this.projectId = projectId;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public int getPavIsAgree() {
		return pavIsAgree;
	}
	public void setPavIsAgree(int pavIsAgree) {
		this.pavIsAgree = pavIsAgree;
	}
	public Date getPavAgreeTime() {
		return pavAgreeTime;
	}
	public void setPavAgreeTime(Date pavAgreeTime) {
		this.pavAgreeTime = pavAgreeTime;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public Date getApplyTime() {
		return applyTime;
	}
	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}
	
	
	
	
	
	
	

}
