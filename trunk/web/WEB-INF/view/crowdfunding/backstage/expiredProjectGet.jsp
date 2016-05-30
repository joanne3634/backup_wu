<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>流标</title>
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
			if(pbreakRemark==''){
				 $.ligerDialog.warn("请输入流标原因!");
				 return ;
			}
			var projectId=$("#projectId").val();
			var ListSize=$("#ListSize").val();
		    var flag = true;
			var url="${ctx}/crowdfunding/backstage/expiredProject/saveBreakRemark_Bak.ht";
			if(eval(ListSize)>0){
				var pbreakRemark = escape(encodeURIComponent(pbreakRemark));
			window.location.href="${ctx}/crowdfunding/backstage/expiredProject/saveBreakRemark_.ht?projectId="+projectId+"&pbreakRemark="+pbreakRemark;
			flag = false;
			}
			if(flag){
				var rep=$.ajax({  
			        type: "POST",  
			        url:url ,
			        data: { pbreakRemark:pbreakRemark,projectId:projectId }  
			        });  
			      
			    rep.done(function( data ){  
			       		
			       		var obj=new com.deelon.form.ResultMessage(data);
						if(obj.isSuccess()){
							$.ligerDialog.success("操作成功!","提示信息",function(rtn){
								/* closewin(); */
								location.href="${ctx}/crowdfunding/backstage/expiredProject/list.ht";
							});
						}else{
							$.ligerDialog.err("提示信息","操作失败!",obj.getMessage());
						}
			      
			        });  
			      
			    rep.fail(function( jqXHR, textStatus ) {  
			        $.ligerDialog.warn(textStatus);
			    }); 
			}
		 
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
</style>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">
					流标
				</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save"  id="dataFormSave" href="javascript:saveDatas();"><span></span>保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link" id="backList_id" href="javascript:backList();"><span></span>返回</a></div>
					<div class="l-bar-separator"></div>
				</div>
			</div>
		</div>
	   <form id="tSetHomepageForm" method="post" action="save.ht">
						
			         
			           		<table class="table-detail"  cellpadding="0" cellspacing="0" border="0">
								<tr>
									
									<th width="18%">项目名称: <span class="required">*</span></th>
									<td >
									<%-- <input type="text"  readonly="readonly" value="${Tcproject.pname}" style="width:240px !important" class="inputText"/> --%>
									<label>${Tcproject.pname}</label>
									</td>
								</tr>
								<tr>
									
									<th width="18%">融资金额: <span class="required">*</span></th>
									<td >
									<%-- <input type="text"  readonly="readonly" value="${Tcproject.ploan}" style="width:240px !important" class="inputText"/> --%>
										<label><fmt:formatNumber value="${Tcproject.pfinancingAmount }" pattern="###,###.##"  minFractionDigits="2"  ></fmt:formatNumber></label>
									</td>
								</tr>
								
								<tr>
									
									<th width="18%">认投金额: <span class="required">*</span></th>
									<td >
									<%-- <input type="text"  readonly="readonly" value="${Tcproject.ploanReal}" style="width:240px !important" class="inputText"/> --%>
									<label><fmt:formatNumber value="${Tcproject.pinvestAmount}" pattern="###,###.##"  minFractionDigits="2"  ></fmt:formatNumber></label>
									</td>
								</tr>
								
								<tr>
									
									<th width="18%">完成进度: <span class="required">*</span></th>
									<td >
									<%-- <input type="text"  readonly="readonly" value="${Tcproject.pcomplete}%" style="width:240px !important" class="inputText"/> --%>
									<label>${Tcproject.pcomplete}</label>
									</td>
								</tr>
														
								<tr height="100">
								   <th>流标说明: </th>
								   <td >
								   	<textarea rows="6" cols="20" name="pbreakRemark" id="pbreakRemark" ></textarea>
								   </td>
								</tr>
														
							</table>
							<input type="hidden" id="projectId" name="projectId" value="${Tcproject.projectId}" />
							<input type="hidden" id="ListSize" name="ListSize" value="${ListSize}" />
					
	          
	  </form>
</div>
</body>
</html>
