<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript">
	
	function saveDatas(){
		var pvaluationFinalNew=$("#pvaluationFinalNew").val();
		if(pvaluationFinalNew==''){
			 $.ligerDialog.warn("请填写运营方对项目的新的估值!");
			 return ;
		}
		var projectId=$("#projectId").val();
		var url="${ctx}/crowdfunding/backstage/proAudit/updateValution.ht";
		
	
			var rep=$.ajax({  
		        type: "POST",  
		        url:url ,
		        data: { pvaluationFinalNew:pvaluationFinalNew,projectId:projectId }  
		        });  
		      
		    rep.done(function( data ){  
		       	//	 $.ligerDialog.warn(data.msg);
		       		
		       		var obj=new com.deelon.form.ResultMessage(data);
					if(obj.isSuccess()){
						$.ligerDialog.alertExt("操作成功!","提示信息",function(rtn){
						//	location.href="${ctx}/crowdfunding/backstage/fullTenderAudit/list.ht";
							setTimeout(closewin, 2000);
					//		location.href="${ctx}/crowdfunding/backstage/proAudit/list.ht";
						});
						/* $("#_waningInfo").show();
						$("#_panel-body").hide();
						
						$("#_waningInfo2").html("保存成功!"); */
					//	closewin();
					}else{
						$.ligerDialog.err("提示信息","操作失败!",obj.getMessage());
					}
		      
		        });  
		      
		    rep.fail(function( jqXHR, textStatus ) {  
		        $.ligerDialog.warn(textStatus);
		    }); 
		}
	 
	function closewin(){
		
		window.parent.parent.openDialog('','','1','','');
		
	}
	   
	</script>
</head>
<body>
 <div class="panel">
		
		<div class="panel-body" id="_panel-body" style="margin-top: 1px;">
		<div class="panel-toolbar">
						<div class="toolBar">
							<div class="l-bar-separator"></div>
							 <div class="group"><f:a alias="add_tproject" css="link save" href="javascript:void(0);" onclick="saveDatas()"><span></span>保存</f:a></div>
							<div class="l-bar-separator"></div>
							
							<%-- <div class="group"><f:a alias="del_tproject" css="link del" action="del.ht">删除</f:a></div> --%>
						</div>	
					</div>
		<form id="tUserFundsForm1" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="9%">项目方的最初估值:</th>	
								<td width="15%">
								<c:choose>
									<c:when test="${empty tproject.pvaluationFinalNew || tproject.pvaluationFinalNew eq '0.000'}">
									<input readonly="readonly" id="" value="<fmt:formatNumber value="${tproject.pvaluationFinal}" pattern="###,###"  minFractionDigits="0"  />">万
									</c:when>
									<c:otherwise>
									<input readonly="readonly" id="" value="<fmt:formatNumber value="${tproject.pvaluationFinalNew}" pattern="###,###"  minFractionDigits="0"  />">万
									</c:otherwise>
								</c:choose>
								
								</td>
								
								
							</tr>
							<tr>
								<th width="9%">运营方重新估值:</th>	
								<td>
									<input 
									onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" 
				onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"
									type="text" id="pvaluationFinalNew"  name="pvaluationFinalNew" value="">万
								</td>
							</tr>
							
					</table>
						<input type="hidden" name="projectId" id="projectId" value="${tproject.projectId }">
				</form> 
		
		</div>
		<div id="_waningInfo" style="display: none;">
		<span style="font-size: 16px;color: #666;margin-right: 200px;" id="_waningInfo2"></span>
		</div>
</div>
</body>
</html>