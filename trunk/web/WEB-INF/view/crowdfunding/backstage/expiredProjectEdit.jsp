<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>延期</title>
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
			var pbreakRemark=$("#pbreakRemark").val();
			var extensionDays=$("#extensionDays").val();
			
			if(extensionDays==''){
				 $.ligerDialog.warn("请输入延期天数!");
				 return ;
			}
			
			if(pbreakRemark==''){
				 $.ligerDialog.warn("请输入延期原因!");
				 return ;
			}
			
			var projectId=$("#projectId").val();
			
			$.ligerDialog.confirm("确认执行延期操作吗？","提示信息",function(rtn){
				if(rtn){
			
				var rep=$.ajax({  
			        type: "POST",  
			        url:"${ctx}/crowdfunding/backstage/expiredProject/updateExtension.ht" ,
			        data: { pbreakRemark:pbreakRemark,projectId:projectId,extensionDays:extensionDays}  
			        });  
			      
			    rep.done(function( data ){  
			       		var obj=new com.deelon.form.ResultMessage(data);
						if(obj.isSuccess()){
							$.ligerDialog.success("延迟操作成功!","提示信息",function(rtn){
								location.href="${ctx}/crowdfunding/backstage/expiredProject/list.ht";
							});
						}else{
							$.ligerDialog.err("提示信息","延迟操作失败!",obj.getMessage());
						}
			      
			        });  
			      
			    rep.fail(function( jqXHR, textStatus ) {  
			        $.ligerDialog.warn(textStatus);
			    }); 
			    
			    
			    
				} 
			});
			
			    
	 }
		 

	
	function backList(){
		//location.href="list.ht";
		closewin();
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
 
 .required{ 
   color:red;
 }

</style>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">
					延期
				</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save"  id="dataFormSave" href="javascript:saveDatas();"><span></span>保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="${ctx}/crowdfunding/backstage/expiredProject/list.ht"><span></span>返回</a></div>
				</div>
			</div>
		</div>
	   <form id="tSetHomepageForm" method="post" action="save.ht">
						
			         
			           		<table class="table-detail"  cellpadding="0" cellspacing="0" border="0">
								<tr>
									
									<th width="18%">项目名称:</th>
									<td >
									<input type="text"  readonly="readonly" value="${projectName}" style="width:240px !important" class="inputText"/> 
									</td>
								</tr>
								<tr>
									
									<th width="18%">原来融资天数:</th>
									<td >
									<input type="text"  readonly="readonly" value=" ${pfinancingDays}" style="width:240px !important" class="inputText"/> 
									</td>
								</tr>
								
								<tr>
									
									<th width="18%">延期天数: <span class="required">*</span></th>
									<td >
									 <input type="text"  name="popenDays" style="width:240px" class="inputText" id="extensionDays"/> 
								</tr>
								<tr height="100">
								   <th>延期说明: <span class="required">*</span></th>
								   <td >
								   	<textarea rows="6" cols="20" name="pbreakRemark" id="pbreakRemark" ></textarea>
								   </td>
								</tr>
														
							</table>
							<input type="hidden" id="projectId" name="projectId" value="${projectId}" />
	          
	  </form>
</div>
</body>
</html>
