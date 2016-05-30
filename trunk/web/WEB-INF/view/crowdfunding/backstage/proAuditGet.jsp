<%--
	time:2011-11-28 10:17:09
	desc:edit the 用户表
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>

<html>
<head>
	<title>审核不通过说明</title>
	<%@include file="/commons/include/form.jsp" %>
	<f:link href="Aqua/css/ligerui-all.css"></f:link>
	
	<f:link href="tree/zTreeStyle.css"></f:link>
	<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerTab.js" ></script>
	<script type="text/javascript" src="${ctx}/js/deelon/displaytag.js" ></script>
	<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerWindow.js" ></script>
   <script type="text/javascript"  src="${ctx}/js/deelon/platform/system/SysDialog.js"></script>
   <script type="text/javascript" src="${ctx}/js/deelon/platform/system/FlexUploadDialog.js"></script>
	<script type="text/javascript">
	
	
	
 
	function saveDatas(){
		var pcheckRemark=$("#pcheckRemark").val();
		if(pcheckRemark==''){
			 $.ligerDialog.warn("请输入不通过原因!");
			 return ;
		}
		var projectId=$("#projectId").val();
		
		 var rep=$.ajax({  
		        type: "POST",  
		        url: "${ctx}/crowdfunding/backstage/proAudit/saveCheckRemark_.ht",
		        data: { pcheckRemark:pcheckRemark,projectId:projectId }  
		        });  
		      
		    rep.done(function( data ){  
		       	//	 $.ligerDialog.warn(data.msg);
		       		 
		       		var obj=new com.deelon.form.ResultMessage(data);
					if(obj.isSuccess()){
						$.ligerDialog.success("操作成功!","提示信息",function(rtn){
							location.href="list.ht";
						
						});
					}else{
						$.ligerDialog.err("提示信息","操作失败!",obj.getMessage());
					}
		      
		        });  
		      
		    rep.fail(function( jqXHR, textStatus ) {  
		        $.ligerDialog.warn(textStatus);
		    });  
	}
	
	function backList(){
		location.href="list.ht";
	}
	function closewin(){
		this.window.close();
		
	}
	
	
	</script>
<style type="text/css">
	html{height:100%}
	body {overflow:auto;}
div.panel-body {
    margin: 0px;
}
</style>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">
					备注说明
				</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save"  id="dataFormSave" href="javascript:saveDatas();"><span></span>保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link " id="backList_id" href="javascript:backList();"><span></span>返回</a></div>
					<div class="l-bar-separator"></div>
				</div>
			</div>
		</div>
	   <form id="tSetHomepageForm" method="post" action="save.ht">
						
			         
			           		<table class="table-detail"  cellpadding="0" cellspacing="0" border="0">
								<tr>
									
									<th width="18%">项目名称: <span class="required">*</span></th>
									<td >
									<%-- <input type="text"  readonly="readonly" value="${TProject.pname}" style="width:240px !important" class="inputText"/> --%>
									<label>${tproject.pname}</label>
									</td>
								</tr>
							
								
							
														
								<tr height="100">
								   <th>说明: </th>
								   <td >
								   	<textarea rows="6" cols="20" name="pcheckRemark" id="pcheckRemark" ></textarea>
								   </td>
								</tr>
														
							</table>
							<input type="hidden" id="projectId" name="projectId" value="${tproject.projectId}" />
					
	          
	  </form>
</div>
</body>
</html>
