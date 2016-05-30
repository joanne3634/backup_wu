/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.model.sysManager;
import java.util.HashSet;
import java.util.Set;
import com.deelon.core.model.BaseModel;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class Tinfotemplatparam extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "Tinfotemplatparam";
	public static final String ALIAS_INFO_TEMPLAT_PARAM_ID = "模板ID";
	public static final String ALIAS_INFO_TEMPLAT_ID = "模板ID";
	public static final String ALIAS_PARAM_NAME = "参数名称";
	public static final String ALIAS_COMMENTS = "参数说明";
	public static final String ALIAS_CREATOR = "创建人ID";
	public static final String ALIAS_CREATE_TIME = "创建时间";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long infoTemplatParamId;
	private java.lang.Long infoTemplatId;
	private java.lang.String paramName;
	private java.lang.String comments;
	private java.lang.Long creator;
	private java.util.Date createTime;
	//private Tinfotemplat tinfotemplat;
	private java.lang.String templateName;
	//columns END

	
	public Tinfotemplatparam(){
	}

	public java.lang.String getTemplateName() {
	return templateName;
}

	public void setTemplateName(java.lang.String templateName) {
		this.templateName = templateName;
	}

	public Tinfotemplatparam(
		java.lang.Long infoTemplatParamId
	){
		this.infoTemplatParamId = infoTemplatParamId;
	}

	public void setInfoTemplatParamId(java.lang.Long value) {
		this.infoTemplatParamId = value;
	}
	
	public java.lang.Long getInfoTemplatParamId() {
		return this.infoTemplatParamId;
	}
	public void setInfoTemplatId(java.lang.Long value) {
		this.infoTemplatId = value;
	}
	
	public java.lang.Long getInfoTemplatId() {
		return this.infoTemplatId;
	}
	public void setParamName(java.lang.String value) {
		this.paramName = value;
	}
	
	public java.lang.String getParamName() {
		return this.paramName;
	}
	public void setComments(java.lang.String value) {
		this.comments = value;
	}
	
	public java.lang.String getComments() {
		return this.comments;
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

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("InfoTemplatParamId",getInfoTemplatParamId())
			.append("InfoTemplatId",getInfoTemplatId())
			.append("ParamName",getParamName())
			.append("Comments",getComments())
			.append("Creator",getCreator())
			.append("CreateTime",getCreateTime())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getInfoTemplatParamId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof Tinfotemplatparam == false) return false;
		if(this == obj) return true;
		Tinfotemplatparam other = (Tinfotemplatparam)obj;
		return new EqualsBuilder()
			.append(getInfoTemplatParamId(),other.getInfoTemplatParamId())
			.isEquals();
	}

	/*public Tinfotemplat getTinfotemplat() {
		return tinfotemplat;
	}

	public void setTinfotemplat(Tinfotemplat tinfotemplat) {
		this.tinfotemplat = tinfotemplat;
	}*/
	
}

