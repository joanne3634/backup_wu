/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.crowdfunding.model.backstage;
import java.util.Date;

import com.deelon.core.model.BaseModel;

public class TcprojectAfter extends BaseModel {
	
	public static final String TABLE_ALIAS = "TcprojectAfter";
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	
	private Long afterId;
	private Long projectId;
	private Long userId;
	private Integer paTypeId;
	private String paTitle;
	private String paContent;
	private Long creator;
	private Date createTime;
	private String fileId;
	private Integer viewCount;
	private Integer isDel;
	
	private String creatorName;
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	private String projectName;
	
	private String fileName;
	private String filePath;
	
	public Long getAfterId() {
		return afterId;
	}
	public void setAfterId(Long afterId) {
		this.afterId = afterId;
	}
	public Long getProjectId() {
		return projectId;
	}
	public void setProjectId(Long projectId) {
		this.projectId = projectId;
	}
	public Integer getPaTypeId() {
		return paTypeId;
	}
	public void setPaTypeId(Integer paTypeId) {
		this.paTypeId = paTypeId;
	}
	public String getPaTitle() {
		return paTitle;
	}
	public void setPaTitle(String paTitle) {
		this.paTitle = paTitle;
	}
	public String getPaContent() {
		return paContent;
	}
	public void setPaContent(String paContent) {
		this.paContent = paContent;
	}
	public Long getCreator() {
		return creator;
	}
	public void setCreator(Long creator) {
		this.creator = creator;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getFileId() {
		return fileId;
	}
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	public Integer getViewCount() {
		return viewCount;
	}
	public void setViewCount(Integer viewCount) {
		this.viewCount = viewCount;
	}
	public Integer getIsDel() {
		return isDel;
	}
	public void setIsDel(Integer isDel) {
		this.isDel = isDel;
	}
	
	public String getCreatorName() {
		return creatorName;
	}
	public void setCreatorName(String creatorName) {
		this.creatorName = creatorName;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
	
	
	

	
	
	
	
	

	 
}

