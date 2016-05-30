/*
 * Powered By [Allen]
 * Since 2013 - 2013
 */


package com.deelon.cmsform.model.site;
import com.deelon.core.model.BaseModel;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;


public class CmsSiteConfig extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "站点配置";
	public static final String ALIAS_SITE_CONFIG_ID = "主键";
	public static final String ALIAS_SITE_NAME = "站点名称";
	public static final String ALIAS_SITE_CODE = "站点代码";
	public static final String ALIAS_SITE_DIR_PATH = "根目录物理路径";
	public static final String ALIAS_SITE_INDEX_PATH = "全文索引物理路径";
	public static final String ALIAS_SITE_STATIC_DIR = "生成静态目录";
	public static final String ALIAS_SITE_OWNER = "站点所有者";
	public static final String ALIAS_SITE_MAIL = "站点信箱";
	public static final String ALIAS_SITE_HOME_URL = "主页链接";
	public static final String ALIAS_SITE_TEMPLET_HOME = "首页模板";
	public static final String ALIAS_SITE_COPYRIGHT = "版权信息";
	public static final String ALIAS_SITE_UPLOAD_TYPE = "上传文件类型";
	public static final String ALIAS_SITE_META = "meta关键字";
	public static final String ALIAS_SITE_META_INFO = "Meta描述";
	public static final String ALIAS_SITE_TEMPLET = "模板主题";
	public static final String ALIAS_SITE_ORG_ID = "公司分类";
	
	//date formats
	
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long siteConfigId;
	private java.lang.String siteName;
	private java.lang.String siteCode;
	private java.lang.String siteDirPath;
	private java.lang.String siteIndexPath;
	private java.lang.String siteStaticDir;
	private java.lang.String siteOwner;
	private java.lang.String siteMail;
	private java.lang.String siteHomeUrl;
	private java.lang.String siteTempletHome;
	private java.lang.String siteCopyright;
	private java.lang.String siteUploadType;
	private java.lang.String siteMeta;
	private java.lang.String siteMetaInfo;
	private java.lang.String siteTemplet;
	private java.lang.Long siteOrgId;
	//columns END

	public CmsSiteConfig(){
	}

	public CmsSiteConfig(
		java.lang.Long siteConfigId
	){
		this.siteConfigId = siteConfigId;
	}

	public void setSiteConfigId(java.lang.Long value) {
		this.siteConfigId = value;
	}
	
	public java.lang.Long getSiteConfigId() {
		return this.siteConfigId;
	}
	public void setSiteName(java.lang.String value) {
		this.siteName = value;
	}
	
	public java.lang.String getSiteName() {
		return this.siteName;
	}
	public void setSiteCode(java.lang.String value) {
		this.siteCode = value;
	}
	
	public java.lang.String getSiteCode() {
		return this.siteCode;
	}
	public void setSiteDirPath(java.lang.String value) {
		this.siteDirPath = value;
	}
	
	public java.lang.String getSiteDirPath() {
		return this.siteDirPath;
	}
	public void setSiteIndexPath(java.lang.String value) {
		this.siteIndexPath = value;
	}
	
	public java.lang.String getSiteIndexPath() {
		return this.siteIndexPath;
	}
	public void setSiteStaticDir(java.lang.String value) {
		this.siteStaticDir = value;
	}
	
	public java.lang.String getSiteStaticDir() {
		return this.siteStaticDir;
	}
	public void setSiteOwner(java.lang.String value) {
		this.siteOwner = value;
	}
	
	public java.lang.String getSiteOwner() {
		return this.siteOwner;
	}
	public void setSiteMail(java.lang.String value) {
		this.siteMail = value;
	}
	
	public java.lang.String getSiteMail() {
		return this.siteMail;
	}
	public void setSiteHomeUrl(java.lang.String value) {
		this.siteHomeUrl = value;
	}
	
	public java.lang.String getSiteHomeUrl() {
		return this.siteHomeUrl;
	}
	public void setSiteTempletHome(java.lang.String value) {
		this.siteTempletHome = value;
	}
	
	public java.lang.String getSiteTempletHome() {
		return this.siteTempletHome;
	}
	public void setSiteCopyright(java.lang.String value) {
		this.siteCopyright = value;
	}
	
	public java.lang.String getSiteCopyright() {
		return this.siteCopyright;
	}
	public void setSiteUploadType(java.lang.String value) {
		this.siteUploadType = value;
	}
	
	public java.lang.String getSiteUploadType() {
		return this.siteUploadType;
	}
	public void setSiteMeta(java.lang.String value) {
		this.siteMeta = value;
	}
	
	public java.lang.String getSiteMeta() {
		return this.siteMeta;
	}
	public void setSiteMetaInfo(java.lang.String value) {
		this.siteMetaInfo = value;
	}
	
	public java.lang.String getSiteMetaInfo() {
		return this.siteMetaInfo;
	}
	public void setSiteTemplet(java.lang.String value) {
		this.siteTemplet = value;
	}
	
	public java.lang.String getSiteTemplet() {
		return this.siteTemplet;
	}
	public void setSiteOrgId(java.lang.Long value) {
		this.siteOrgId = value;
	}
	
	public java.lang.Long getSiteOrgId() {
		return this.siteOrgId;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("SiteConfigId",getSiteConfigId())
			.append("SiteName",getSiteName())
			.append("SiteCode",getSiteCode())
			.append("SiteDirPath",getSiteDirPath())
			.append("SiteIndexPath",getSiteIndexPath())
			.append("SiteStaticDir",getSiteStaticDir())
			.append("SiteOwner",getSiteOwner())
			.append("SiteMail",getSiteMail())
			.append("SiteHomeUrl",getSiteHomeUrl())
			.append("SiteTempletHome",getSiteTempletHome())
			.append("SiteCopyright",getSiteCopyright())
			.append("SiteUploadType",getSiteUploadType())
			.append("SiteMeta",getSiteMeta())
			.append("SiteMetaInfo",getSiteMetaInfo())
			.append("SiteTemplet",getSiteTemplet())
			.append("SiteOrgId",getSiteOrgId())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getSiteConfigId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof CmsSiteConfig == false) return false;
		if(this == obj) return true;
		CmsSiteConfig other = (CmsSiteConfig)obj;
		return new EqualsBuilder()
			.append(getSiteConfigId(),other.getSiteConfigId())
			.isEquals();
	}
}

