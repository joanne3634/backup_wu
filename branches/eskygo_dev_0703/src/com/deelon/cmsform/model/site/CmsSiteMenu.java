/*
 * Powered By [Allen]
 * Since 2013 - 2013
 */


package com.deelon.cmsform.model.site;
import java.util.HashSet;
import java.util.Set;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.deelon.core.model.BaseModel;

public class CmsSiteMenu extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "站点栏目设置";
	public static final String ALIAS_SITE_MENU_ID = "主键";
	public static final String ALIAS_SITE_CONFIG_ID = "站点外键";
	public static final String ALIAS_MENU_SUP_ID = "上级id";
	public static final String ALIAS_MENU_PATH = "全路径";
	public static final String ALIAS_MENU_NAME = "栏目名称";
	public static final String ALIAS_MENU_FILE_PATH = "访问路径";
	public static final String ALIAS_MENU_TEMPLET = "栏目模板";
	public static final String ALIAS_MENU_CONTENT_TEMPLET = "内容模板";
	public static final String ALIAS_MENU_SORT = "排序号";
	public static final String ALIAS_MENU_URL = "外部链接";
	
	//date formats
	
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long siteMenuId;
	private java.lang.Long siteConfigId;
	private java.lang.Long menuSupId;
	private java.lang.String menuPath;
	private java.lang.String menuName;
	private java.lang.String menuFilePath;
	private java.lang.String menuTemplet;
	private java.lang.String menuContentTemplet;
	private java.lang.Integer menuSort;
	private java.lang.String menuUrl;
	//columns END
	


	public CmsSiteMenu(){
	}

	public CmsSiteMenu(
		java.lang.Long siteMenuId
	){
		this.siteMenuId = siteMenuId;
	}

	public void setSiteMenuId(java.lang.Long value) {
		this.siteMenuId = value;
	}
	
	public java.lang.Long getSiteMenuId() {
		return this.siteMenuId;
	}
	public void setSiteConfigId(java.lang.Long value) {
		this.siteConfigId = value;
	}
	
	public java.lang.Long getSiteConfigId() {
		return this.siteConfigId;
	}
	public void setMenuSupId(java.lang.Long value) {
		this.menuSupId = value;
	}
	
	public java.lang.Long getMenuSupId() {
		return this.menuSupId;
	}
	public void setMenuPath(java.lang.String value) {
		this.menuPath = value;
	}
	
	public java.lang.String getMenuPath() {
		return this.menuPath;
	}
	public void setMenuName(java.lang.String value) {
		this.menuName = value;
	}
	
	public java.lang.String getMenuName() {
		return this.menuName;
	}
	public void setMenuFilePath(java.lang.String value) {
		this.menuFilePath = value;
	}
	
	public java.lang.String getMenuFilePath() {
		return this.menuFilePath;
	}
	public void setMenuTemplet(java.lang.String value) {
		this.menuTemplet = value;
	}
	
	public java.lang.String getMenuTemplet() {
		return this.menuTemplet;
	}
	public void setMenuContentTemplet(java.lang.String value) {
		this.menuContentTemplet = value;
	}
	
	public java.lang.String getMenuContentTemplet() {
		return this.menuContentTemplet;
	}
	public void setMenuSort(java.lang.Integer value) {
		this.menuSort = value;
	}
	
	public java.lang.Integer getMenuSort() {
		return this.menuSort;
	}
	public void setMenuUrl(java.lang.String value) {
		this.menuUrl = value;
	}
	
	public java.lang.String getMenuUrl() {
		return this.menuUrl;
	}
	
	private Set cmsSiteMenuContents = new HashSet(0);
	public void setCmsSiteMenuContents(Set<CmsSiteMenuContent> cmsSiteMenuContent){
		this.cmsSiteMenuContents = cmsSiteMenuContent;
	}
	
	public Set<CmsSiteMenuContent> getCmsSiteMenuContents() {
		return cmsSiteMenuContents;
	}
	
	private CmsSiteConfig cmsSiteConfig;
	
	public void setCmsSiteConfig(CmsSiteConfig cmsSiteConfig){
		this.cmsSiteConfig = cmsSiteConfig;
	}
	
	public CmsSiteConfig getCmsSiteConfig() {
		return cmsSiteConfig;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("SiteMenuId",getSiteMenuId())
			.append("SiteConfigId",getSiteConfigId())
			.append("MenuSupId",getMenuSupId())
			.append("MenuPath",getMenuPath())
			.append("MenuName",getMenuName())
			.append("MenuFilePath",getMenuFilePath())
			.append("MenuTemplet",getMenuTemplet())
			.append("MenuContentTemplet",getMenuContentTemplet())
			.append("MenuSort",getMenuSort())
			.append("MenuUrl",getMenuUrl())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getSiteMenuId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof CmsSiteMenu == false) return false;
		if(this == obj) return true;
		CmsSiteMenu other = (CmsSiteMenu)obj;
		return new EqualsBuilder()
			.append(getSiteMenuId(),other.getSiteMenuId())
			.isEquals();
	}
	
	//非持久化对象
	protected String checked = "false";



	public String getChecked() {
		return checked;
	}

	public void setChecked(String checked) {
		this.checked = checked;
	}
	
}

