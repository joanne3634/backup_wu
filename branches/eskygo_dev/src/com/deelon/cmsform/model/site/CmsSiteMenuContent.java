/*
 * Powered By [Allen]
 * Since 2013 - 2013
 */

package com.deelon.cmsform.model.site;

import java.sql.Timestamp;
import java.util.List;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.deelon.core.model.BaseModel;
import com.deelon.core.util.StringUtil;
import com.deelon.platform.util.SysFileHelper;
//import com.deelon.platform.util.SysFileHelper;

public class CmsSiteMenuContent extends BaseModel
{

	// alias
	public static final String TABLE_ALIAS = "栏目内容设置";
	public static final String ALIAS_SITE_MENU_CONTENT_ID = "siteMenuContentId";
	public static final String ALIAS_SITE_MENU_ID = "站点栏目外键";
	public static final String ALIAS_CONTENT_TITLE = "标题";
	public static final String ALIAS_CONTENT_ISURL = "是否是外部链接";
	public static final String ALIAS_CONTENT_URL = "外部连接URL";
	public static final String ALIAS_CONTENT_MIN_TITLE = "简短标题";
	public static final String ALIAS_CONTENT_TAG = "Tag标签";
	public static final String ALIAS_CONTENT_SUMMARY = "摘要";
	public static final String ALIAS_CONTENT_AUTHOR = "来源";
	public static final String ALIAS_CONTENT_SORT = "排序号";
	public static final String ALIAS_CONTENT_CREATE_DATE = "开标时间";
	public static final String ALIAS_CONTENT_UPDATE_DATE = "更新时间";
	public static final String ALIAS_CONTENT_TEMPLET = "指定模板";
	public static final String ALIAS_CONTENT_TEXT = "发布内容";
	public static final String ALIAS_CONTENT_NOTICE_OBJECT = "通知对象";
	public static final String ALIAS_CONTENT_NOTICE_TYPE = "通知对象类型";
	public static final String ALIAS_CONTENT_IF_PUBLISH = "是否发布";

	// 可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	// columns START
	private java.lang.Long siteMenuContentId;
	private java.lang.Long siteMenuId;
	private java.lang.String contentTitle;
	private java.lang.Integer contentIsurl;
	private java.lang.String contentUrl;
	private java.lang.String contentMinTitle;
	private java.lang.String contentTag;
	private java.lang.String contentSummary;
	private java.lang.String contentAuthor;
	private java.lang.Integer contentSort;
	private Timestamp contentCreateDate;
	private Timestamp contentUpdateDate;
	private java.lang.String contentTemplet;
	private java.lang.String contentText;
	private String contentFileIds;
	private List<Long> tContentFileIdsList;
	private java.lang.String contentNoticeObject;
	private java.lang.Integer contentNoticeType;
	private java.lang.Integer contentIfPublish;

	// columns END

	public CmsSiteMenuContent()
	{
	}

	public CmsSiteMenuContent( java.lang.Long siteMenuContentId )
	{
		this.siteMenuContentId = siteMenuContentId;
	}

	public String getContentFileIds()
	{
		if ( StringUtil.isNotEmpty( contentFileIds ) )
		{
			SysFileHelper.getByIdsFileInfo( contentFileIds, this );
		}
		return contentFileIds;
	}

	public List<Long> getContentFileIdsList() {
		if (StringUtil.isEmpty(contentFileIds)) {
			return null;
		}
		if ( null != tContentFileIdsList ) {
			return tContentFileIdsList;
		}
		tContentFileIdsList = SysFileHelper.getFileIdsFromPPic(contentFileIds);
		return tContentFileIdsList;
	}
	
	public void setContentFileIds( String contentFileIds )
	{
		this.contentFileIds = contentFileIds;
	}

	public void setSiteMenuContentId( java.lang.Long value )
	{
		this.siteMenuContentId = value;
	}

	public java.lang.Long getSiteMenuContentId()
	{
		return this.siteMenuContentId;
	}

	public void setSiteMenuId( java.lang.Long value )
	{
		this.siteMenuId = value;
	}

	public java.lang.Long getSiteMenuId()
	{
		return this.siteMenuId;
	}

	public void setContentTitle( java.lang.String value )
	{
		this.contentTitle = value;
	}

	public java.lang.String getContentTitle()
	{
		return this.contentTitle;
	}

	public void setContentIsurl( java.lang.Integer value )
	{
		this.contentIsurl = value;
	}

	public java.lang.Integer getContentIsurl()
	{
		return this.contentIsurl;
	}

	public void setContentUrl( java.lang.String value )
	{
		this.contentUrl = value;
	}

	public java.lang.String getContentUrl()
	{
		return this.contentUrl;
	}

	public void setContentMinTitle( java.lang.String value )
	{
		this.contentMinTitle = value;
	}

	public java.lang.String getContentMinTitle()
	{
		return this.contentMinTitle;
	}

	public void setContentTag( java.lang.String value )
	{
		this.contentTag = value;
	}

	public java.lang.String getContentTag()
	{
		return this.contentTag;
	}

	public void setContentSummary( java.lang.String value )
	{
		this.contentSummary = value;
	}

	public java.lang.String getContentSummary()
	{
		return this.contentSummary;
	}

	public void setContentAuthor( java.lang.String value )
	{
		this.contentAuthor = value;
	}

	public java.lang.String getContentAuthor()
	{
		return this.contentAuthor;
	}

	public void setContentSort( java.lang.Integer value )
	{
		this.contentSort = value;
	}

	public java.lang.Integer getContentSort()
	{
		return this.contentSort;
	}

	public Timestamp getContentCreateDate()
	{
		return contentCreateDate;
	}

	public void setContentCreateDate( Timestamp contentCreateDate )
	{
		this.contentCreateDate = contentCreateDate;
	}

	public Timestamp getContentUpdateDate()
	{
		return contentUpdateDate;
	}

	public void setContentUpdateDate( Timestamp contentUpdateDate )
	{
		this.contentUpdateDate = contentUpdateDate;
	}

	public void setContentTemplet( java.lang.String value )
	{
		this.contentTemplet = value;
	}

	public java.lang.String getContentTemplet()
	{
		return this.contentTemplet;
	}

	private CmsSiteMenu cmsSiteMenu;

	public void setCmsSiteMenu( CmsSiteMenu cmsSiteMenu )
	{
		this.cmsSiteMenu = cmsSiteMenu;
	}

	public CmsSiteMenu getCmsSiteMenu()
	{
		return cmsSiteMenu;
	}

	public java.lang.String getContentText()
	{
		return contentText;
	}

	public void setContentText( java.lang.String contentText )
	{
		this.contentText = contentText;
	}
	

	public java.lang.String getContentNoticeObject() {
		return contentNoticeObject;
	}

	public void setContentNoticeObject(java.lang.String contentNoticeObject) {
		this.contentNoticeObject = contentNoticeObject;
	}

	public java.lang.Integer getContentNoticeType() {
		return contentNoticeType;
	}

	public void setContentNoticeType(java.lang.Integer contentNoticeType) {
		this.contentNoticeType = contentNoticeType;
	}

	public String toString()
	{
		return new ToStringBuilder( this, ToStringStyle.MULTI_LINE_STYLE )
				.append( "SiteMenuContentId", getSiteMenuContentId() ).append( "SiteMenuId", getSiteMenuId() )
				.append( "ContentTitle", getContentTitle() ).append( "ContentIsurl", getContentIsurl() )
				.append( "ContentUrl", getContentUrl() ).append( "ContentMinTitle", getContentMinTitle() )
				.append( "ContentTag", getContentTag() ).append( "ContentSummary", getContentSummary() )
				.append( "ContentAuthor", getContentAuthor() ).append( "ContentSort", getContentSort() )
				.append( "ContentCreateDate", getContentCreateDate() )
				.append( "ContentUpdateDate", getContentUpdateDate() ).append( "ContentTemplet", getContentTemplet() )
				.append("ContentNoticeObject",getContentNoticeObject()).append("ContentNoticeType",getContentNoticeType())
				.append("ContentIfPublish",getContentIfPublish())
				.toString();
	}

	public int hashCode()
	{
		return new HashCodeBuilder().append( getSiteMenuContentId() ).toHashCode();
	}

	public boolean equals( Object obj )
	{
		if ( obj instanceof CmsSiteMenuContent == false )
			return false;
		if ( this == obj )
			return true;
		CmsSiteMenuContent other = (CmsSiteMenuContent) obj;
		return new EqualsBuilder().append( getSiteMenuContentId(), other.getSiteMenuContentId() ).isEquals();
	}

	public java.lang.Integer getContentIfPublish() {
		return contentIfPublish;
	}

	public void setContentIfPublish(java.lang.Integer contentIfPublish) {
		this.contentIfPublish = contentIfPublish;
	}
	
	
}
