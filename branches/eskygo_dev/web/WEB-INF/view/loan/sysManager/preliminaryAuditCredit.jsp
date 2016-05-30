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
			var prateIn=$("#prateIn").val();
			var prateOut=$("#prateOut").val();
			if(eval(prateOut)>eval(prateIn)){
				$.ligerDialog.warn("投资(借出)利率不能大于贷款(借入)利率!");
				return;
			}
			
					var typeId=$("#typeId").val();//
				//	var prateOut=$("#prateOut").val();//
					var pclerkId=$("#pclerkId").val();
					var projectId=$("#projectId").val();
					
					if(typeId==''){
						 $.ligerDialog.warn("请选择标的类型");
						 return;
					}
					var rep=$.ajax({  
				        type: "POST",  
				        url: "${ctx}/loan/sysManager/preliminaryAudit/savePlateFormDate.ht",
				        data: {typeId:typeId,prateOut:prateOut,pclerkId:pclerkId,projectId:projectId}  
				        });  
				      
				   	 rep.done(function( data ){  
				   		var obj=new com.deelon.form.ResultMessage(data);
						if(obj.isSuccess()){
							$.ligerDialog.success("操作成功!","提示信息",function(rtn){
									location.href="list.ht";
								/* alert(rtn);
								if(!rtn){
									
								}
								else{
									$("#tsettingsForm").submit();
								} */
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
		
		function vali_Values(val){
			var rateout=$("#prateOut").val();
			if(eval(rateout)>eval(val)){
				$.ligerDialog.warn("投资(借出)利率不能大于贷款利率!");
				return;
			}
		}
		
		
		function addClick()
		{
			UserDialog({callback:dlgCallBack,isSingle:true});
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
					<div class="group"><a class="link save" id="dataFormSave" href="javascript:saveDate('${TProject.prateIn}');">保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body" style="margin-top: 1px">
		<form id="riskForm_id" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
								<tr>
									
									<th width="18%">标的认证: <span class="required" style="color:red">*</span></th>
									<td ><f:select nodeKey="CREDIT_TYPE" id="typeId" idName="typeId" defaultValue="${TProject.ptypeId}"  
										
									showBlankOnTop="true" >
									</f:select></td>
								</tr>						
								<tr>
									<th width="18%">贷款利率(借入): <span class="required" style="color: red">*</span></th>
									<td ><input type="text" id="prateIn" readonly="readonly" name="prateIn"  value="${TProject.prateIn}" style="width:240px !important" class="inputText"/></td>
								</tr>
							
								<tr>
									<th width="18%">投资利率(借出): <span class="required" style="color: red">*</span></th>
									<td ><input type="text"
									 onkeypress="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value" 
            onkeyup="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value" 
									id="prateOut" onchange="vali_Values('${TProject.prateIn}');" name="prateOut"  value="${TProject.prateOut}" style="width:240px !important" class="inputText"/></td>
								</tr>
								<tr>
								    <th>跟进业务员: </th>
									<td >
									<input type="text" id="pclerk" name="pclerk" readonly="readonly"  
								
									value="${TProject.applyName }<f:description modelCode="t_user"  modelPropertyName="RealName"  modelPropertyValue="id" nodeKey="MODEL_DATA" itemValue="${TProject.applyName }"/>" style="width:240px !important" class="inputText"/>
									<a href="#" onclick="addClick()" class="link get">选择</a>
						        <a href="#" onclick="reSet()" class="link clean">清空</a>
								<input type="hidden" id="pclerkId" name="pclerkId" value="${TProject.pclerk }"  class="inputText"/>
							<!-- 	<input type="hidden" id="receiveType" name="receiveType" value=""  class="inputText"/> -->
								
								
									<input type="hidden" name="projectId" id="projectId" value="${TProject.projectId}"/>
									<%-- <input type="hidden" name="prateIn" id="prateIn_id" value="${TProject.prateIn}"/> --%>
									</td>
									
								</tr>
								<%-- <tr>
									<th>担保金比例: </th>
									<td>
									<input type="text" id="prriskRate_id" onpropertychange="if(isNaN(value)) value=value.substring(0,value.length-1);" name="prriskRate" onchange="modfiy_loan();"  value="${TProjectRisk.prriskRate}" style="width:140px !important" class="inputText"/>%					
									</td>
								</tr>						
								<tr>
									<th>担保金额: </th>
									<td >								
										<input type="text" id="prrisk_id" readonly="readonly" name="prrisk"  value="${TProjectRisk.prrisk}" style="width:240px !important" class="inputText"/>
										<input type="hidden" name="loanMoney" id="loanMoney_id" value="${loanMoney}"/>
									</td>				  
								</tr>
								
													
								<tr>
								   <th>风控意见: </th>
								   <td ><textarea rows="6" cols="" name="pradvice" id="pradvice_id"   style="width:240px !important" class="inputText">${TProjectRisk.pradvice}</textarea>
								   </td>
								</tr> --%>
								
								
														
							</table>
					
				</form>
		</div>
</div>
</body>
</html>