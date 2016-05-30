<%@page import="com.deelon.cmsform.model.site.CmsSiteMenuContent"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.deelon.cmsform.model.site.CmsSiteMenu"%>
<%@page import="com.deelon.cmsform.service.site.CmsSiteMenuService"%>
<%@page import="com.deelon.core.util.AppUtil"%>
<html>
<head>
	<title><%=CmsSiteMenuContent.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/form.jsp" %> 	
	<script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor_msg.js"></script>
<%-- 	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=cmsSiteMenuContent"></script> --%>
	<script type="text/javascript"  src="${ctx }/js/deelon/platform/system/SysDialog.js"></script>
	<link href="${ctx}/js/jquery/plugins/attach.css" rel="stylesheet" />
	<link href="${ctx}/js/jquery/plugins/jquery.qtip.min.css" rel="stylesheet" />
	<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.qtip.min.js" ></script>
	<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.attach.js" ></script>
	<script type="text/javascript">
		$(function() {
			valid(showRequestFile,showResponse,1); 
			CKEDITOR.config.toolbar=App.toolbar.Basic;
			CKEDITOR.config.height = 500;
			$("a.save").click(function() {  		
				$('#contentText').val(CKEDITOR.instances.contentText.getData());
				$("#cmsSiteMenuContentForm").submit(); 
			});
			//判断附件必须要传的情况
			function showRequestFile(formData, jqForm, options){
				if("SYGGDT"=="${cmsSiteMenu.menuPath}"){//是附件必须上传的菜单
					var fileVal=$("#contentFileIds").val();
					if(fileVal.indexOf("fileId")==-1){
						alert("请先上传附件后再进行保存！");
						return false;
					}
				}
					return true;
				
			}
			
		}); 
		
		
		function showRequest(formData, jqForm, options) { 	
			return true;
		} 
		var __valid;
		function showResponse(responseText, statusText)  { 
			var self=this;
			var obj=new com.deelon.form.ResultMessage(responseText);
			if(obj.isSuccess()){//成功
				$.ligerDialog.confirm( obj.getMessage()+",是否继续操作","提示信息",function(rtn){
					if(!rtn){
						var returnUrl=$("#returnUrl").val();
						if($("#returnUrl").length>0 && returnUrl!=""){
							location.href=returnUrl;
							return;
						}
						var linkBack=$("a.back");
						if(linkBack.length>0){
							var returnUrl=linkBack.attr("href");
							if(returnUrl!=""){
								location.href=returnUrl;
								return;
							}
						}
					}
					else{  
						var suburl="edit.ht?siteMenuId="+$("#siteMenuId").val()+"&&siteMenuContentId="+$("#siteMenuContentId").val();
						 location.href=suburl;
						/* if(obj.getPkName()&&obj.getPkId()){ 
							$("#"+obj.getPkName()).val(obj.getPkId());
						}
						if(self.isReset==1){
							__valid.resetForm();
						} */
					}
				});
				
		    }else{//失败
		    	$.ligerDialog.error( obj.getMessage(),"出错了");
		    }
		} 
		function valid(showRequest,showResponse,isReset){

		var options={};

		if(showRequest )
			options.beforeSubmit=showRequest;

		if(showResponse )
			options.success=showResponse;

		if(isReset){
			options.isReset=isReset;
		}

		__valid=$("#cmsSiteMenuContentForm").validate({
		   
			rules: {
				siteMenuContentId:{
					digits:true
				},
				siteMenuId:{
				},
				contentTitle:{
					required:true,
					maxlength:500
				},
				contentIsurl:{
					maxlength:10
				},
				contentUrl:{
					maxlength:200
				},
				contentMinTitle:{
					maxlength:200
				},
				contentTag:{
					maxlength:500
				},
				contentSummary:{
					maxlength:2000
				},
				contentAuthor:{
					maxlength:200
				},
				contentSort:{
					maxlength:10
				},
				contentTemplet:{
					maxlength:200
				}
			},
			messages: {
				siteMenuContentId:{
					digits:"siteMenuContentId 必须填写整数."
				},
				siteMenuId:{
				},
				contentTitle:{
					required:"标题 必填",
					maxlength:"标题 最多 500 个字符."
				},
				contentIsurl:{
					maxlength:"是否是外部链接 最多 10 个字符."
				},
				contentUrl:{
					maxlength:"外部连接URL 最多 200 个字符."
				},
				contentMinTitle:{
					maxlength:"简短标题 最多 200 个字符."
				},
				contentTag:{
					maxlength:"Tag标签 最多 500 个字符."
				},
				contentSummary:{
					maxlength:"摘要 最多 2000 个字符."
				},
				contentAuthor:{
					maxlength:"来源 最多 200 个字符."
				},
				contentSort:{
					maxlength:"排序号 最多 10 个字符."
				},
				contentTemplet:{
					maxlength:"指定模板 最多 200 个字符."
				}
			},
			submitHandler:function(form){
				$(form).ajaxSubmit(options);
		    },
		    success: function(label) {
				label.removeClass("error");
			}
			});
		}

		
	</script>
	<script type="text/javascript">
	// 组织框返回数据   
	function dlgOrgCallBack(orgIds, orgNames)
	{ 
		$("#receiverOrgName").val(orgNames);	
		$("#receiverOrgId").val(orgIds);
		document.getElementById("contentNoticeMan").value=orgNames;
		document.getElementById("contentNoticeObject").value=orgIds;
		//$("#receiveType").val(retypes);	
	}
	function dlgCallBack(userIds,fullnames,emails,mobiles,retypes)
	{								
		document.getElementById("contentNoticeMan").value=fullnames;
		document.getElementById("contentNoticeObject").value=userIds;
	};
	function addClick(oName)
	{var selectNotice=document.getElementById("selectNotice");
	//alert(selectNotice.value);
	//1为全部，默认值
	if(1==selectNotice.value){
		document.getElementById("contentNoticeType").value=1;
		document.getElementById("contentNoticeMan").style.display = 'none';
	}
	//2为选择用户
	if(2==selectNotice.value){
		//alert("ok");
		document.getElementById("contentNoticeType").value=2;
		document.getElementById("contentNoticeMan").style.display = '';
		UserDialog({callback:dlgCallBack,isSingle:false});
	}
	//3为选择角色
	if(3==selectNotice.value){
		document.getElementById("contentNoticeType").value=3;
		document.getElementById("contentNoticeMan").style.display = '';
		OrgDialog({callback:dlgOrgCallBack,isSingle:false});
	}
	};
	//重置
	function reSet(){
		document.getElementById("contentNoticeObject").value="";
	}
	function showRole(type){
		//alert(type);
		if(type==1||type==""){
			document.getElementById("contentNoticeMan").style.display = 'none';
		}else{
			document.getElementById("contentNoticeMan").style.display = '';
		}
		
		
	}
	//预览
	function perview() {
		var contentId = $("input[name='siteMenuContentId']").val();
		if("" == contentId || contentId == null || contentId == 'undefined') {
			alert("请先保存再进行预览！");
			return false;
		} else {
			
			window.open("${ctx}/frontpage/detial.jsp?contentId="
					+ contentId +"&menuPath=${cmsSiteMenu.menuPath}");
			
		}
	}
	//设置发布
	function setIfpublish(type){
		$("#contentIfPublish").val(type); 
		$('#contentText').val(CKEDITOR.instances.contentText.getData());
		$("#cmsSiteMenuContentForm").submit(); 
		$("#contentIfPublish").val("0"); 
	}
	</script>
</head>
<body  >
<div class="panel">
		<div class="panel-top"> 
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#"><span></span>保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link update"  id="saveAndPublish" onclick="setIfpublish(1);" href="#" ><span></span>发布</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link update" onclick="setIfpublish(0);" href="#" ><span></span>取消发布</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht?siteMenuId=${siteMenuId }"><span></span>返回</a></div>
<!-- 					<div class="l-bar-separator"></div> -->
<!-- 					<div class="group"><a class="link search" onclick="perview();"><span></span>预览</a></div> -->
				</div>
			</div>
		</div>
		<div class="panel-body" style="margin-top: 1px">
		<form id="cmsSiteMenuContentForm" method="post" action="save.ht">
		<input type="hidden" id="siteMenuId" name="siteMenuId" value="${siteMenuId}"  class="inputText" />
		<input type="hidden" id="returnUrl" name="returnUrl" value="list.ht?siteMenuId=${siteMenuId }"  class="inputText" />
		<%-- <input type="hidden" id="returnUrl" name="returnUrl" value="edit.ht?siteMenuId=${siteMenuId }&siteMenuContentId=${cmsSiteMenuContent.siteMenuContentId}"  class="inputText" /> --%>
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr> <th >标题<font color="red">*</font>:</th> 
								<td colspan="3">										 
									<input type="text" style="width: 400px" id="contentTitle" name="contentTitle" value="${cmsSiteMenuContent.contentTitle}" class="inputText" />
								</td> 								
							</tr>
							<tr><th >简短标题:</th>
								<td colspan="3">										 
									<input type="text" style="width: 300px" id="contentMinTitle" name="contentMinTitle" value="${cmsSiteMenuContent.contentMinTitle}" onClick="document.getElementById('contentMinTitleMsg').innerHTML=''" class="inputText" /><span id="contentMinTitleMsg"></span>
								</td> 
							</tr>
							<tr> <th >摘要:</th> 
								<td colspan="3">										 
									<input type="text" style="width: 300px" id="contentSummary" name="contentSummary" value="${cmsSiteMenuContent.contentSummary}" onClick="document.getElementById('contentSummaryMsg').innerHTML=''"  class="inputText" /><span id="contentSummaryMsg"></span>
								</td>  
							</tr> 
							
							<tr>
								<th > 链接:</th>	
								<td >	
									<%-- <f:select  nodeKey="whether" id="contentIsurl" defaultValue="${cmsSiteMenuContent.contentIsurl}" showBlankOnTop="true" styleValue="width:50px"  />						 
 									URL: --%><input type="text" style="width: 200px" id="contentUrl" name="contentUrl" value="${cmsSiteMenuContent.contentUrl}" class="inputText" />
								</td>
								
								<th>来源:</th>
								<td>										 
									<input type="text" style="width: 200px" id="contentAuthor" name="contentAuthor" value="${cmsSiteMenuContent.contentAuthor}" class="inputText" />
								</td>
							</tr>	 
							<tr>								
								<th >创建时间:</th>	
								<td>	
									<jsp:useBeanid="nowDate" class="java.util.Date"/>						 
									<input type="text" style="width: 150px"  name="contentCreateDate" value='<fmt:formatDate value="${cmsSiteMenuContent.contentCreateDate==null?nowDate:cmsSiteMenuContent.contentCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>' size="25" class="inputText datetime" />
								</td>
								<th >发布时间:</th>	
								<td>										
									<input type="text" style="width: 150px" name="contentUpdateDate" value='<fmt:formatDate value="${cmsSiteMenuContent.contentUpdateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>' size="25" class="inputText datetime" />
								</td>
							</tr>
							<tr>
								
								<th >排序号:</th>	
								<td>										 
									<input type="text" style="width: 50px" id="contentSort" name="contentSort" value="${cmsSiteMenuContent.contentSort}" class="inputText" />
								</td>
								<th >发布状态:</th>	
								<td>										 
									<f:description itemValue="${cmsSiteMenuContent.contentIfPublish}" nodeKey="sf" />
								</td>
							</tr>
							<%--<tr>
							 <th >通知对象: </th>
							<td colspan="3">
							<input id="contentNoticeMan" name="contentNoticeMan" style="display:none;"  size="80" readonly="readonly" value="" />
							<input type="hidden" id="contentNoticeObject" name="contentNoticeObject" style="display:none;"  size="80" readonly="readonly" value="${cmsSiteMenuContent.contentNoticeObject}" />
							<select id="selectNotice" class="select" onchange="addClick()">
										    <option value="1" <c:if test="${cmsSiteMenuContent.contentNoticeType == '1'}"> selected="selected"</c:if>>全部</option>
											<option value="2" <c:if test="${cmsSiteMenuContent.contentNoticeType == '2'}"> selected="selected"</c:if>>指定查看人</option>
											<option value="3" <c:if test="${cmsSiteMenuContent.contentNoticeType == '3'}"> selected="selected"</c:if>>指定查看人角色</option>
							</select>
					        <a href="#" onclick="reSet()" class="link clean">清空</a>
							<input type="hidden" id="contentNoticeType" name="contentNoticeType"<c:if test="${cmsSiteMenuContent.contentNoticeType==null}">value="1"</c:if><c:if test="${cmsSiteMenuContent.contentNoticeType!=null}">value="${cmsSiteMenuContent.contentNoticeType}"</c:if>  class="inputText"/>
							</td>
							
							</tr> --%>
							<tr>
									<th width="15%">附件: </th>
									<td colspan="3"><input type="text" name="contentFileIds" id="contentFileIds" class="attach" attachType="2" value="${cmsSiteMenuContent.contentFileIds}" /></td>
								</tr>
							<tr> 
								<td colspan="4">
									<textarea class="ckeditor"  name="contentText" id="contentText">${cmsSiteMenuContent.contentText }</textarea> 
								</td>
							</tr>
					</table>
					<input type="hidden" name="contentIfPublish" id="contentIfPublish" value="${cmsSiteMenuContent.contentIfPublish}" />
					
					<input type="hidden" name="siteMenuContentId" id="siteMenuContentId" value="${cmsSiteMenuContent.siteMenuContentId}" />
				</form>
		</div>
</div>
</body>
</html>