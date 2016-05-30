<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>修改担保金比例</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx }/js/deelon/platform/system/IconDialog.js"></script>
	 <script type="text/javascript" src="${ctx}/js/p2p/moneyFormat.js"></script>
	<script type="text/javascript">
		$(function(){
			var prriskRate_id=$("#prriskRate_id").val();//担保金比例
			var loanMoney_id=$("#loanMoney_id").val();//借款金额
			
			var prrisk;
			/*  if(eval(prriskRate_id)<1){
				 $("#prriskRate_id").val(eval(prriskRate_id)*100);
				
				$("#percent_id_").html(monDivide(eval(prriskRate_id)*100));
				prrisk=moneyFormatMUL(loanMoney_id,monDivide(eval(prriskRate_id)*100));
			}else{
				prrisk=prriskRate_id;
			}  */
			prrisk=moneyFormatMUL(loanMoney_id,prriskRate_id/100);
			$("#prrisk_id").val(prrisk);//风险金
			
		
			
	           $("input[id^='prriskRate_id']").keydown(function () {  
				    var e = $(this).event || window.event;  
				    var code = parseInt(e.keyCode);  
				    if (code>=96 && code<=105 || code>=48 && code<=57 || code==8 || code==110|| code==190) {  
				        return true;  
				    } else {  
				        return false;  
				    }  
				});
		});
		
		function saveDate(){
					
					
					var prriskRate_id=$("#prriskRate_id").val();//担保金比例
					var prrisk_id=$("#prrisk_id").val();//借款金额
					var riskId_id=$("#riskId_id").val();
				//	var prriskRate_id=$("#percent_id_").html();
					var pradvice_id=$("#pradvice_id").val();
					var prcompay =$("#prcompay").val();
					var rep=$.ajax({  
				        type: "POST",  
				        url: "${ctx}/loan/sysManager/preliminaryAudit/saveDate.ht",
				        data: {prrisk:prrisk_id,prriskRate:prriskRate_id,riskId_id:riskId_id,pradvice_id:pradvice_id,prcompay:prcompay }  
				        });  
				      
				   	 rep.done(function( data ){  
				   		var obj=new com.deelon.form.ResultMessage(data);
						if(obj.isSuccess()){
							$.ligerDialog.success("操作成功!","提示信息",function(rtn){
									location.href="list.ht";
							/*	if(!rtn){
									
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
		
		function modfiy_loan(){
			
			var prriskRate_id=$("#prriskRate_id").val();//担保金比例
			var loanMoney_id=$("#loanMoney_id").val();//借款金额
		//	alert(parseFloat(prriskRate_id)/100);
			
		//	$("#percent_id_").html(monDivide(prriskRate_id));
		//	var prrisk=moneyFormatMUL(loanMoney_id,monDivide(prriskRate_id));
			var prrisk=moneyFormatMUL(loanMoney_id,prriskRate_id/100);
			$("#prrisk_id").val(prrisk);//风险金
			
			
			
		}
		
	
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
									
									<th width="18%">项目名称: <span class="required">*</span></th>
									<td >
									<%-- <input type="text" id="proName" name="proName" readonly="readonly" value="${TProjectRisk.proName}" style="width:240px !important" class="inputText"/> --%>
									<label>${TProjectRisk.proName}</label>
									</td>
								</tr>						
							
								
								<tr>
								    <th>担保机构: </th>
									<td >
									<%-- <input type="text" id="prcompayName" name="prcompayName" readonly="readonly" value="${TriskCompany.name}" style="width:240px !important" class="inputText"/> --%>
									<label>${TriskCompany.name}</label>
									</td>
								</tr>
								
								<tr>
									<th>借款金额: </th>
									<td >								
										 <input type="hidden" id="loanMoney_id"   name="loanMoney"  value="${loanMoney}" style="width:240px !important" class="inputText"/>
										<label>${loanMoney}元</label>
									</td>				  
								</tr>
								
								<tr>
									<th>担保金比例: </th>
									<td>
									<input type="text" id="prriskRate_id" 
									onchange="modfiy_loan();"
									name="prriskRate"   value="${TProjectRisk.prriskRate}" maxlength="4"
									style="width:140px !important" class="inputText"/><span>%</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<!-- =<span id="percent_id_" style="color: red"></span>		 -->			
									</td>
								</tr>						
								<tr>
									<th>担保金额: </th>
									<td >								
										<input type="text" id="prrisk_id" readonly="readonly" name="prrisk"  value="${TProjectRisk.prrisk}" style="width:240px !important" class="inputText"/>元
									</td>				  
								</tr>
								
													
								<tr>
								   <th>风控意见: </th>
								   <td ><textarea rows="6" cols="" name="pradvice" id="pradvice_id"   style="width:240px !important" class="inputText">${TProjectRisk.pradvice}</textarea>
								   </td>
								</tr>
								
								<input type="hidden" name="riskId" id="riskId_id" value="${TProjectRisk.riskId}"/>
								<input type="hidden" name="prcompay" id="prcompay" value="${TriskCompany.companyId}"/>						
							</table>
					
				</form>
		</div>
</div>
</body>
</html>