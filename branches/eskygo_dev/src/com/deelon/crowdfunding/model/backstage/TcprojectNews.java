package com.deelon.crowdfunding.model.backstage;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */




import java.util.HashSet;
import java.util.Set;

import com.deelon.core.model.BaseModel;
import com.deelon.core.util.StringUtil;
import com.deelon.platform.util.SysFileHelper;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class TcprojectNews extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "TcprojectNews";
	public static final String ALIAS_NEWS_ID = "动态ID";
	public static final String ALIAS_PROJECT_ID = "项目ID";
	public static final String ALIAS_PNTYPE_ID = "类型:1项目动态 2项目信息披露";
	public static final String ALIAS_PNTITLE = "标题";
	public static final String ALIAS_PNCONTENT = "内容";
	public static final String ALIAS_CREATOR = "创建人";
	public static final String ALIAS_CREATE_TIME = "创建时间";
	public static final String ALIAS_IS_DEL = "是否删除";
	public static final String ALIAS_FILEID = "上传附件";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long newsId;
	private java.lang.Long projectId;
	private Integer pntypeId;
	private java.lang.String pntitle;
	private java.lang.String pncontent;
	private java.lang.Long creator;
	private java.util.Date createTime;
	private Integer isDel;
	private java.lang.String fileId;
	private Integer viewCount;
	
	//columns END
	private String createTimeStr;
	private String pname;
	private String pic;

	public Integer getViewCount() {
		return viewCount;
	}

	public void setViewCount(Integer viewCount) {
		this.viewCount = viewCount;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}
	
	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}

	public TcprojectNews(){
	}

	public TcprojectNews(
		java.lang.Long newsId
	){
		this.newsId = newsId;
	}

	public void setNewsId(java.lang.Long value) {
		this.newsId = value;
	}
	
	public java.lang.Long getNewsId() {
		return this.newsId;
	}
	public void setProjectId(java.lang.Long value) {
		this.projectId = value;
	}
	
	public java.lang.Long getProjectId() {
		return this.projectId;
	}
	public void setPntypeId(Integer value) {
		this.pntypeId = value;
	}
	
	public Integer getPntypeId() {
		return this.pntypeId;
	}
	public void setPntitle(java.lang.String value) {
		this.pntitle = value;
	}
	
	public java.lang.String getPntitle() {
		return this.pntitle;
	}
	public void setPncontent(java.lang.String value) {
		this.pncontent = value;
	}
	
	public java.lang.String getPncontent() {
		return this.pncontent;
	}
	public void setCreator(java.lang.Long value) {
		this.creator = value;
	}
	
	public java.lang.Long getCreator() {
		return this.creator;
	}
	public void setCreateTime(java.util.Date value) {
		this.createTime = value;
	}
	
	public java.util.Date getCreateTime() {
		return this.createTime;
	}
	public void setIsDel(Integer value) {
		this.isDel = value;
	}
	
	public Integer getIsDel() {
		return this.isDel;
	}
	public void setFileId(java.lang.String value) {
		this.fileId = value;
	}
	
	public java.lang.String getFileId() {
		if ( StringUtil.isNotEmpty( fileId ) )
		{
			SysFileHelper.getByIdsFileInfo( fileId, this );
		}
		return fileId;
	}
	
	

	public String getCreateTimeStr() {
		return createTimeStr;
	}

	public void setCreateTimeStr(String createTimeStr) {
		this.createTimeStr = createTimeStr;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("NewsId",getNewsId())
			.append("ProjectId",getProjectId())
			.append("PntypeId",getPntypeId())
			.append("Pntitle",getPntitle())
			.append("Pncontent",getPncontent())
			.append("Creator",getCreator())
			.append("CreateTime",getCreateTime())
			.append("IsDel",getIsDel())
			.append("FileId",getFileId())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getNewsId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TcprojectNews == false) return false;
		if(this == obj) return true;
		TcprojectNews other = (TcprojectNews)obj;
		return new EqualsBuilder()
			.append(getNewsId(),other.getNewsId())
			.isEquals();
	}
}

