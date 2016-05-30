<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript">
	
		
	    function iFrameHeight() {
	    	
	        var ifm= document.getElementById("iframepage");
	
	        var subWeb = document.frames ? document.frames["iframepage"].document :
	
				ifm.contentDocument;
	
	            if(ifm != null && subWeb != null) {
	
	            ifm.height = subWeb.body.scrollHeight;
	
	            }
	
	    }
	</script>
</head>
<body>
 <div class="panel">
		<div class="panel-top">
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><%-- <a class="link save" id="dataFormSave" href="javascript:formSubmit(${tUserFunds.fundsId});"><span></span>保存</a> --%></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht"><span></span>返回</a></div>
				</div>
			</div>
		</div> 
		<div class="panel-body" style="margin-top: 1px">
		<form id="tUserFundsForm" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="9%">会员:</th>	
								<td colspan="5" width="15%">	
									<f:description modelCode="t_user"  modelPropertyName="realName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${tUserFunds.userId }"/>
								</td>
							</tr>
							<tr>
								<th width="9%">账户余额:</th>	
								<td width="15%">										 
									${tUserFunds.balance}
								</td>
								
								
								<th width="9%">可用金额:</th>	
								<td width="15%"> 	
								${tUserFunds.available}									 
								</td>
								
								
								<th width="9%">冻结金额:</th>	
								<td width="15%">	
									${tUserFunds.freeze}									 
								</td>
								
								
							</tr>
							<tr>
								<th width="9%">托管账户余额:</th>	
								<td width="15%">										 
									${balance0}
								</td>
								
								
								<th width="9%">总可用余额:</th>	
								<td width="15%"> 	
								${balance1}									 
								</td>
								
								
								<th width="9%">子账户冻结余额:</th>	
								<td width="15%">	
									${balance2}									 
								</td>
								
								
							</tr>
					</table>
					<input id="payMark" name="payMark" type="hidden" value="${payMark }">
						<input id="fundsId" name="fundsId" type="hidden" value="">
					
					<iframe src="${ctx}/loan/front/userFunds/grid.ht?userId=${tUserFunds.userId}&payMark=${payMark}&fundsId=${tUserFunds.fundsId}" id="iframepage" name="iframepage" width="100%" frameborder="0" scrolling="no" onLoad="iFrameHeight()"></iframe>
				</form> 
				
		
		</div>
</div>
</body>
</html>