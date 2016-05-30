package com.deelon.loan.model.front;

import java.util.Date;

/**
 * 用户审校材料上传持久类
 * 
 * @author deelon.hejian
 * 
 */
public class TUserAuditMatUpload {
	private long uploadId;
	private long auditMatId;
	private long materialsId;
	private String savePath;
	private Date uploadTime;
	private long userId;
	

	
	public long getUploadId() {
		return uploadId;
	}
	public void setUploadId(long uploadId) {
		this.uploadId = uploadId;
	}
	public long getAuditMatId() {
		return auditMatId;
	}
	public void setAuditMatId(long auditMatId) {
		this.auditMatId = auditMatId;
	}
	public long getMaterialsId() {
		return materialsId;
	}
	public void setMaterialsId(long materialsId) {
		this.materialsId = materialsId;
	}
	public String getSavePath() {
		return savePath;
	}
	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}
	public Date getUploadTime() {
		return uploadTime;
	}
	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public TUserAuditMatUpload(long uploadId, long auditMatId,
			long materialsId, String savePath, Date uploadTime, long userId) {
		super();
		this.uploadId = uploadId;
		this.auditMatId = auditMatId;
		this.materialsId = materialsId;
		this.savePath = savePath;
		this.uploadTime = uploadTime;
		this.userId = userId;
	}
	public TUserAuditMatUpload() {
		super();
	}
	{
		
	}
}
	
	
