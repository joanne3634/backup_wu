<%@page import="com.deelon.core.util.ContextUtil"%>
<%@page import="com.deelon.platform.model.system.SysUser"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.deelon.core.util.AppUtil"%>
<%@include file="/commons/include/html_doctype.html"%>
<%@ taglib prefix="pageTag" tagdir="/WEB-INF/tags/pageTag"%>
<html>
<head>
<title>管理</title>
<%@include file="/commons/include/form.jsp"%>
<script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor_msg.js"></script>
<script type="text/javascript"
	src="${ctx}/servlet/ValidJs?form=tuserSuccessstory"></script>
<script type="text/javascript"
	src="${ctx }/js/deelon/platform/system/SysDialog.js"></script>
<link href="${ctx}/js/jquery/plugins/attach.css" rel="stylesheet" />
<link href="${ctx}/js/jquery/plugins/jquery.qtip.min.css"
	rel="stylesheet" />
<script type="text/javascript"
	src="${ctx}/js/jquery/plugins/jquery.qtip.min.js"></script>
<script type="text/javascript"
	src="${ctx}/js/jquery/plugins/jquery.attach.js"></script>
<script type="text/javascript">
// 	 function Messagesubmit() {   
// 		    var Tix="";
// 			var suburl = $("#subctx").val()+"/loan/aboutus/tUserSuccessstory/tuserSuccessstorysave.ht";
// 			var pam=$('#tuserSuccessstoryForm').serialize(); 
// 			$.ajax({
// 						type:'POST',
// 						data:pam ,
// 						dataType:'json',
// 						url:suburl ,
// 						success:function(pam) { 
// 							if(pam!="1"){
// 								Tix="添加数据成功,是否继续操作";
// 							}else{
// 								Tix="更新数据成功,是否继续操作";
// 							}
// 							$.ligerDialog.confirm(Tix,"提示信息",function(rtn){
// 								if(!rtn){
// 									location.href="list.ht";
// 								}
// 								else{ 
// 								}
// 							});  
// 						},
// 						error:function(XMLHttpRequest, textStatus, errorThrown) {
// 							 /* alert(XMLHttpRequest.statusText);  */
// 						}
// 					});
// 		}  
	 
	 
	 $(function() {
			$("#tuserSuccessstoryForm").validate({
				rules: {//开始声明验证规则
					subject:{
						required:true,
					},
				},
				messages: {
					subject:{
						required:"标题 必填",
					},
				},
			});
			
			$("a.save").click(function() { 
				if($('#tuserSuccessstoryForm').valid()){
				$.ajax({
					url : "tuserSuccessstorysave.ht",
					type : 'post',
					data : $("#tuserSuccessstoryForm").serialize(),
					dataType : 'json',
					success : function(data,textStatus) {
						$.ligerDialog.confirm("数据操作成功，是否继续操作","提示信息",function(rtn){
							if(!rtn){
								location.href="list.ht";
							}
							else{ 
								if($("#successstoryId").val()==""){
									$("#subject").val();
									$("#shareContent").val();
								}else{
									location.href="edit.ht?messageId="+$("#successstoryId").val();
								}
							}
						});	
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
					}
				});
				}
		});
	 });
	</script>
	<input type="hidden" name="subctx" id="subctx" value="${ctx }">
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<a class="link save" id="dataFormSave" href="#"><span></span>保存</a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link back" href="list.ht?siteMenuId=${siteMenuId }"><span></span>返回</a>
					</div>
					<div class="l-bar-separator"></div> 
				</div>
			</div>
		</div>
		<div class="panel-body" style="margin-top: 1px">
			<form id="tuserSuccessstoryForm" method="post" action="tuserSuccessstorysave.ht"> 
			 	<table class="table-detail" cellpadding="0" cellspacing="0"
					border="0">
					<tr>
						<th>标题<font color="red">*</font>:
						</th>
						<td colspan="3"><input type="text" style="width: 200px"
							id="subject" name="subject" value="${tuserSuccessstory.subject}"
							class="inputText" /></td>
					</tr>
					<th>分享人:</th>
					<td>  
					 <pageTag:UserAll menupath="${tuserSuccessstory.userId}"/>
					</td>
					
					</tr>
					<tr>
						<th>创建时间:</th>
						<td><jsp:useBeanid="nowDate" class="java.util.Date"/>						 
						        <input type="text" style="width: 150px"  name="createTime" value='<fmt:formatDate value="${cmsSiteMenuContent.contentCreateDate==null?nowDate:cmsSiteMenuContent.contentCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>' size="25" class="inputText datetime" />
						   </td>
					</tr>
					<tr>
						<td colspan="4"><textarea  name="shareContent" id="shareContent"  style="height: 300px;;width: 98%;">${tuserSuccessstory.shareContent }</textarea>
						</td>
					</tr>
				</table>
				<%
					SysUser sysUser = ContextUtil.getCurrentUser();
				%>
				<input type="hidden" name="creator" id="creator" value="<%=sysUser.getUserId()%>">
				<input type="hidden" name="successstoryId" id="successstoryId" value="${tuserSuccessstory.successstoryId }">
			</form>
		</div>
	</div>
</body>
</html>