<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>修改担保金比例</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx }/js/deelon/platform/system/IconDialog.js"></script>
	 <script type="text/javascript" src="${ctx}/js/p2p/moneyFormat.js"></script>
	 <script type="text/javascript"  src="${ctx}/js/deelon/platform/system/SysDialog.js"></script>
	<script type="text/javascript">
		
		
		function saveDate(){
					var userId =$("#userId").val();
					var pclerkId=$("#pclerkId").val();
					var rep=$.ajax({  
				        type: "POST",  
				        url: "${ctx}/loan/sysManager/usersToAudit/update.ht",
				        data: {userId:userId,pclerkId:pclerkId}  
				        });  
				      
				   	 rep.done(function( data ){  
				   		var obj=new com.deelon.form.ResultMessage(data);
						if(obj.isSuccess()){
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
									if(obj.getPkName()&&obj.getPkId()){ 
										$("#"+obj.getPkName()).val(obj.getPkId());
									}
									if(self.isReset==1){
										__valid.resetForm();
									}
								}
							});
						}else{
							$.ligerDialog.err("提示信息","操作失败!",obj.getMessage());
						}
				       		/*  $.ligerDialog.warn(data.msg);
				       		///closewin();
				       		location.href=location.href.getNewUrl(); */
				        });  
				      
				    rep.fail(function( jqXHR, textStatus ) {  
				        $.ligerDialog.warn(textStatus);
				    });  
			}
		
		
		
		function addClick()
		{
			UserDialog({callback:dlgCallBack,isSingle:false});
		};
		//清空
		function reSet(obj)
		{
			$("#pclerk").val("");	
			$("#pclerkId").val("");	
		//	$("#receiveType").val("");				
		}
		function dlgCallBack(userIds,fullnames,emails,mobiles,retypes)
		{								
			$("#pclerk").val(fullnames);	
			$("#pclerkId").val(userIds);	
		//	$("#receiveType").val(retypes);	
			
		};
	</script>
</head>
<bod>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
			   
			            <span class="tbar-label">修改担保金比例</span>
			      
				
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="javascript:saveDate();">保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body" style="margin-top: 1px">
		<form id="riskForm_id" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
								<tr>
									
									<th width="18%">用户名: </th>
									<td >
										${TUser.loginName }
									</td>
								</tr>						
							
								<tr>
									<th width="18%">真实姓名: </th>
									<td >
										${TUser.realName }
									</td>
								</tr>
								<tr>
								    <th>跟进业务员: </th>
									<td >
									<input type="text" id="pclerk" name="pclerk" readonly="readonly"  value="" style="width:240px !important" class="inputText"/>
									<a href="#" onclick="addClick()" class="link get">选择</a>
							        <a href="#" onclick="reSet()" class="link clean">清空</a>
									<input type="hidden" id="pclerkId" name="pclerkId" value=""  class="inputText"/>
									<input type="hidden" name="userId" id="userId" value="${TUser.userId}"/>
									</td>
								</tr>
							</table>
					
				</form>
		</div>
</div>
</body>
</html>