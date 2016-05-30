<%@page import="com.deelon.cmsform.model.site.CmsSiteMenu"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>

<html>
<head>
	<title><%=CmsSiteMenu.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=cmsSiteMenu&formSave=Y"></script>
	<script type="text/javascript">
		$(function() {
			valid(showRequest,showResp);
		});
		function showResp(responseText, statusText,isReset)  { 
			var obj=new com.deelon.form.ResultMessage(responseText);
			if(obj.isSuccess()){//成功
				$.ligerMessageBox.confirm('提示信息',obj.getMessage()+',继续操作吗?',function(rtn){
					if(!rtn){
							window.parent.reFresh(true);
					}else{
							window.parent.reFresh();
					}					
				});
				
		    }else{//失败
		    	$.ligerMessageBox.error('出错了',obj.getMessage());
		    }
		} 
		
		
		
		
		$().ready(function(){
			$("#cmsSiteMenuForm").validate({
		        rules: {
		  
		        	menuName: {
		    required: true,
		    remote : "${ctx}/cmsform/site/cmssitemenu/checkIsExist.ht"
		   }
		  },
		        messages: {
		  
		     menuName: {
		//    required: "请输入验证码",
		    remote : "栏目名称已经存在"
		   }
		        }
		  });
		
	    });
		
		function checkIsExist(){
			var menuName= $("#menuName").val();
			var rep=$.ajax({  
		        type: "GET",  
		        url: "${ctx}/cmsform/site/cmssitemenu/checkIsExist.ht" ,
		        data:{menuName:menuName}
		        });  
			rep.done(function( data ){  
					if(data=='1'){//已存在
					$("#generated_").show();
					}else{
						$.ligerDialog.warn("操作失败");
					}
		       		 
		        });  
		      
		    rep.fail(function( jqXHR, textStatus ) {  
		        $.ligerDialog.warn(textStatus);
		    });
			
		}
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
			    <c:choose>
			        <c:when test="${cmsSiteMenu.siteMenuId!=null}">
			            <span class="tbar-label">编辑<%=CmsSiteMenu.TABLE_ALIAS%></span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加<%=CmsSiteMenu.TABLE_ALIAS%></span>
			        </c:otherwise>
			    </c:choose>
				
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#"><span></span>保存</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body" style="margin-top: 1px">
		<form id="cmsSiteMenuForm" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">										
							<input type="hidden" id="siteConfigId" name="siteConfigId" value="${siteConfigId}" class="inputText"  /> 
							 
							
							
							<tr>
								<th  >栏目名称<font color="red">*</font>:</th>	
								<td colspan="3">										 
									<input type="text" style="width: 250px;"  id="menuName" name="menuName" value="${cmsSiteMenu.menuName}" class="inputText" /><label for="menuName" generated="true" id="generated_" style="display: none;" class="error">栏目名称 已经存在</label>
									
								</td>
															
							</tr>
							<tr>
								<th >访问路径:</th>	
								<td colspan="3">										 
									<input type="text" style="width: 250px;" id="menuFilePath" name="menuFilePath" value="${cmsSiteMenu.menuFilePath}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th>内部链接:</th>	
								<td colspan="3">										 
									<input type="text" style="width: 250px;" id="menuUrl" name="menuUrl" value="${cmsSiteMenu.menuUrl}" class="inputText" />
								</td>
								
							</tr>
							<tr>
								<th>栏目代码<font color="red">*</font>:</th>	
								<td>										 
									<input type="text" id="menuPath" name="menuPath" value="${cmsSiteMenu.menuPath}" class="inputText" />
								</td>
								<th>排序号:</th>	
								<td>										 
									<input type="text" id="menuSort" size="8" name="menuSort" value="${cmsSiteMenu.menuSort}" class="inputText" />
								</td>
							</tr>
							<%-- <tr>								
								<th width="25%">栏目内容类型<font color='red'>*</font>:</th>	
								<td>										 
										<param:select paramType="MENU_CONTENT_TYPE" id="menuTemplet" defaultValue="${cmsSiteMenu.menuTemplet}"  showBlankOnTop="true" styleValue="width:137px"  />		
								</td>
								<th width="25%">首页是否显示<font color="red">*</font>:</th>	
								<td>						
								<param:select paramType="whether" id="menuContentTemplet" defaultValue="${cmsSiteMenu.menuContentTemplet}" styleValue="width:137px"  />					 
									
								</td>
							</tr> --%>
							<tr>
								<th  >栏目ID:</th>	
								<td  >										 
									<input type="text" name="siteMenuId" value="${cmsSiteMenu.siteMenuId}" />
								</td>
								<th  >栏目上级ID:</th>	
								<td  >										 
									<input type="text" id="menuSupId" name="menuSupId" value="${menuSupId}" class="inputText" />
								</td>							
							</tr>
							
					</table>
					
				</form>
		</div>
</div>
</body>
</html>