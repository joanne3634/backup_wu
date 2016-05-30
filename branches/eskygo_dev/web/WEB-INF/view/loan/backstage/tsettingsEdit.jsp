<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>系统设置管理</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx }/js/deelon/platform/system/IconDialog.js"></script>
	<script type="text/javascript">
		$(function() {
			//valid(showRequest,showResponse);
		});
		function selectIcon(){
			IconDialog({callback:function(src){
				$("#setValue").val(src);
				$("#logoImg").attr("src",src);
				$("#logoImg").show();
			},params:"iconType=1"})
		};
		
		function savetproductsloan(){
				var input_cart=document.getElementsByTagName("INPUT");
				var input_all=0;
				for   (var   i=0;   i<input_cart.length;   i++)   { 
					if   (input_cart[i].type=="text"   &&   input_cart[i].value=="")   {
						var num = i+1;
						input_all=input_all+1;
						$("#div_"+num).html("<font color='red'>请输入相关信息！！！</font>");
					}
				}  
				if (input_all!=0)   { 
// 					$.ligerDialog.error("您有信息没有输入");
				}else{
					$.ligerDialog.confirm("添加数据成功！是否继续操作？","提示信息",function(rtn){
						$("#tsettingsForm").submit();
						if(!rtn){
							location.href="list.ht?typeId=${typeId }";
						}
						else{
							$("input:text").val("");
						}
					});
				}
			}
	</script>
	<style type="text/css">
	.inputText{
	width:300px;
	}
	</style>
</head>
<bod>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
			    <c:choose>
			        <c:when test="${tsettings.settingsId!=null}">
			            <span class="tbar-label">编辑系统设置</span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加系统设置</span>
			        </c:otherwise>
			    </c:choose>
				
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="javascript:savetproductsloan();"><span></span>保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht?typeId=${typeId }"><span></span>返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body" style="margin-top: 1px">
		<form id="tsettingsForm" method="post" action="save.ht">
					<%--<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="25%">类型:</th>	
								<td>										 
									<f:select nodeKey="xtszlx" id="typeId" defaultValue="${typeId}"></f:select>
								</td>
								<th width="25%">设置项代码:</th>	
								<td>										 
									<input type="text" id="setCode" name="setCode" value="${tsettings.setCode}" class="inputText" /><font color="red">(系统代码不可随意修改，如需修改请联系管理员)</font>
									<div id="div_1" style="display: inline;"></div>
								</td>
							</tr>
							<tr>
								<th width="25%">设置项值:</th>	
								<td>										 
									<input type="text" id="setValue" name="setValue" value="${tsettings.setValue}" class="inputText" r/>
									 <c:if test="${tsettings.setCode=='PLATFORM_LOGO'}" ><a class="link detail" href="javascript:selectIcon();">选择</a>
									 <font color="green"> 规格（宽305~418）X（高48~55）的图片</font>
									 <img id="logoImg" alt="" src="${ctx}${tsettings.setValue}">
									 </c:if>
									 <c:if test="${tsettings.setCode=='WEIXIN-LOGO'}" ><a class="link detail" href="javascript:selectIcon();">选择</a>
									 <font color="green"> 规格（宽85~88）X（高85~88）的图片</font>
									 <img id="logoImg" alt="" src="${ctx}${tsettings.setValue}">
									 </c:if>
									 <div id="div_2" style="display: inline;"></div>
								</td>
								<th width="25%">设置项描述:</th>	
								<td>										 
									<input type="text" id="setDesc" name="setDesc" value="${tsettings.setDesc}" class="inputText" />
									<div id="div_3" style="display: inline;"></div>
								</td>
							</tr>
					</table>--%>
					
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
					<tr>
								<th width="30%">设置项名称:</th>	
								<td>	
								<c:if test="${!empty tsettings.settingsId}">
									<input type="text" id="setDesc" name="setDesc" value="${tsettings.setDesc}" class="inputText" readonly="readonly" />		
								</c:if>
								<c:if test="${empty tsettings.settingsId}">
									<input type="text" id="setDesc" name="setDesc" value="${tsettings.setDesc}" class="inputText" />		
								</c:if>									 
									
									<div id="div_3" style="display: inline;"></div>
								</td>
							</tr>
							<tr>
								<th width="30%">设置项代码:</th>	
								<td>
								<c:if test="${!empty tsettings.settingsId}">										 
									<input type="text" id="setCode" name="setCode" value="${tsettings.setCode}" class="inputText" readonly="readonly" />
								</c:if>
								<c:if test="${empty tsettings.settingsId}">										 
									<input type="text" id="setCode" name="setCode" value="${tsettings.setCode}" class="inputText" />
								</c:if>
									<%--<font color="red">(系统代码不可随意修改，如需修改请联系管理员)</font>--%>
									<div id="div_1" style="display: inline;"></div>
								</td>
							</tr>
							<tr>
								<th width="25%">设置项值:</th>	
								<td>										 
									<input type="text" id="setValue" name="setValue" value="${tsettings.setValue}" class="inputText" r/>
									 <c:if test="${tsettings.setCode=='PLATFORM_LOGO'}" ><a class="link detail" href="javascript:selectIcon();">选择</a>
									 <font color="green"> 规格（宽305~418）X（高48~55）的图片</font>
									 <img id="logoImg" alt="" src="${ctx}${tsettings.setValue}">
									 </c:if>
									 <c:if test="${tsettings.setCode=='WEIXIN-LOGO'}" ><a class="link detail" href="javascript:selectIcon();">选择</a>
									 <font color="green"> 规格（宽85~88）X（高85~88）的图片</font>
									 <img id="logoImg" alt="" src="${ctx}${tsettings.setValue}">
									 </c:if>
									 <div id="div_2" style="display: inline;"></div>
								</td>
								
							</tr>
							
					</table>
					
					<input type="hidden" name='typeId' value="${typeId}">
					<input type="hidden" name="settingsId" value="${tsettings.settingsId}" />
				</form>
		</div>
</div>
</body>
</html>