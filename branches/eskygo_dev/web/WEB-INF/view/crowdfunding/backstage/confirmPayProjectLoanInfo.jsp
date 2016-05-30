<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>项目放款登记</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<script type="text/javascript">
	function saveData(){
		var loanAmout=$("#loanAmout").val();
		var loanDate=$("#loanDate").val();
		var loanPerson=$("#loanPerson").val();
		var loanFlowCode=$("#loanFlowCode").val();
		var projectId=$("#projectId").val();
		if(loanAmout==''||loanDate==''||loanPerson==''||loanFlowCode==''){
			$.ligerDialog.warn("必填项不能为空!");
			return;
		}
		var url="${ctx}/crowdfunding/backstage/confirmPayProject/saveLoanInfo.ht";
		var rep=$.ajax({  
	        type: "POST",  
	        url:url ,
	        data: { loanAmout:loanAmout,loanDate:loanDate,loanPerson:loanPerson,loanFlowCode:loanFlowCode,projectId:projectId }  
	        });  
	      
	    rep.done(function( data ){  
	       	//	 $.ligerDialog.warn(data.msg);
	       		
	       		var obj=new com.deelon.form.ResultMessage(data);
				if(obj.isSuccess()){
					$.ligerDialog.alertExt("操作成功!","提示信息",function(rtn){
					//	location.href="${ctx}/crowdfunding/backstage/fullTenderAudit/list.ht";
						window.location.reload();
					});
				}else{
					$.ligerDialog.err("提示信息","操作失败!",obj.getMessage());
				}
	      
	        });  
	      
	    rep.fail(function( jqXHR, textStatus ) {  
	        $.ligerDialog.warn(textStatus);
	    }); 
	 //   document.tcprojectLoanRecordsForm.submit();
	  //  $.ligerDialog.warn("保存成功!");
	//    setTimeout(relodfun, 3000);
	}
	function relodfun(){
		
		window.location.reload();
	}
</script>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">项目放款登记</span>
					</div>
					<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#" onclick="saveData()"><span></span>保存</a></div>
					<div class="l-bar-separator"></div>
					
				</div>
				</div>
					
				</div>
				<div class="panel-body">
					<form id="tcprojectLoanRecordsForm" method="post" action="">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="25%">放款金额<a style="color: red">*</a>:</th>	
								<td>										 
									<input type="text" id="loanAmout" name="loanAmout" value="${tcprojectLoanRecords.loanAmout}" class="inputText" />
								</td>
								<th width="25%">放款日期<a style="color: red">*</a>:</th>	
								<td>										 
									<input type="text" id="loanDate" name="loanDate" value="${tcprojectLoanRecords.loanDate}" class="inputText date" />
								</td>
							</tr>
							<tr>
								<th width="25%">放款人<a style="color: red">*</a>:</th>	
								<td>										 
									<input type="text" id="loanPerson" name="loanPerson" value="${tcprojectLoanRecords.loanPerson}" class="inputText" />
								</td>
								<th width="25%">放款流水号<a style="color: red">*</a>:</th>	
								<td>										 
									<input type="text" id="loanFlowCode" name="loanFlowCode" value="${tcprojectLoanRecords.loanFlowCode}" class="inputText" />
								</td>
							</tr>
							
					</table>
					<input type="hidden" name="projectId" id="projectId" value="${projectId}" />
				</form>
					<div class="panel-data">
				    	
					    <display:table name="tcprojectLoanRecordsList" id="tcprojectLoanRecordsItem" requestURI="list.html" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
					    	
					    	<%-- <display:column property="pcurrent" title="当前期数" sortable="false" sortName="pcurrent" style="text-align:left"/> --%>
							<display:column property="pname" title="项目名称" sortable="false" sortName="pname" style="text-align:left"/> 
							<display:column title="本次线下放款金额" sortable="false" sortName="loanAmout" style="text-align:left">
							<fmt:formatNumber value="${tcprojectLoanRecordsItem.loanAmout }" pattern="###,###.##"  minFractionDigits="2"  />
							</display:column> 
							<display:column  title="本次放款时间" sortable="false" sortName="loanDate" style="text-align:left">
							<fmt:formatDate value="${tcprojectLoanRecordsItem.loanDate}" pattern="yyyy-MM-dd"/> 
							</display:column>
							 
							<display:column property="loanPerson" title="放款人" sortable="false" sortName="loanPerson" style="text-align:left"/> 
							<display:column property="loanFlowCode" title="放款的交易流水" sortable="false" sortName="loanFlowCode" style="text-align:left"/> 
							<display:column property="creatPerson" title="登记人" sortable="false" sortName="creatPerson" style="text-align:left"/> 
							<display:column  title="登记时间" sortable="false" sortName="createtime" style="text-align:left">
							<fmt:formatDate value="${tcprojectLoanRecordsItem.createtime}" pattern="yyyy-MM-dd"/> 
							</display:column> 
						</display:table>
						<deelon:paging tableId="tcprojectLoanRecordsItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
