<%@page import="com.deelon.loan.model.sysManager.TprojectTransfer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title><%=TprojectTransfer.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label"><%=TprojectTransfer.TABLE_ALIAS%>管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_tprojectTransfer" css="link search" id="btnSearch" >查询</f:a></div>
							<div class="l-bar-separator"></div>
						</div>	
					</div>
				</div>
		
				<div class="panel-body"  tabid="requesting" title="请求中" lselected="${type eq '1'}">
					<div class="panel-search">
						<form id="searchForm"  method="post" action="list.ht">
							<div class="row">
									<span class="label">借款人:</span><input type="text" name="Q_pApplicantName_S" value="${param['Q_pApplicantName_S']}" maxlength="19" class="inputText" />
									<span class="label">转让人:</span><input type="text" name="Q_transferorName_S" value="${param['Q_transferorName_S']}" maxlength="19" class="inputText" />
									<c:if test="${type eq '3'}">
									<span class="label">中标人:</span><input type="text" name="Q_bidderName_S" value="${param['Q_bidderName_S']}" maxlength="19" class="inputText" />
									</c:if>
									<span class="label">货款项目名:</span><input type="text" name="Q_pname_SL" value="${param['Q_pname_S']}" maxlength="19" class="inputText" />
							</div>
							<input type="hidden" value="${type}" name="type">
							
							<c:if test='${param["Q_isCancel_S"]==null}'>
							<input type="hidden" name="Q_isCancel_S" value="${isCancel}">
							<input type="hidden" name="Q_stateId_S" value="${stateId}">
							<input type="hidden" name="Q_isCheck_S" value="${isCheck}">
							</c:if>
							<c:if test='${param["Q_isCancel_S"]!=null}'>
							<input type="hidden" name="Q_isCancel_S" value="${param['Q_isCancel_S']}">
							<input type="hidden" name="Q_stateId_S" value="${param['Q_stateId_S']}">
							<input type="hidden" name="Q_isCheck_S" value="${param['Q_isCheck_S']}">
							</c:if>
						</form>
					</div>
				<div id="ligerTab">
					<div tabid="requesting" title="请求中" lselected="${type eq '1'}">
						<c:if test="${type eq '1'}">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tprojectTransferList" id="tprojectTransferItem" requestURI="list.html" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="transferId" id="transferId" value="${tprojectTransferItem.transferId}">
							</display:column>
							<display:column property="lenderName" title="借款者" sortable="false" sortName="" style="text-align:center;width:6%;"/> 
							<display:column property="transferorName" title="转让者" sortable="false" sortName="transferorId" style="text-align:center;width:6%;"/> 
							<display:column property="project.pname" title="标题" sortable="false" sortName="pname" style="text-align:center;width:10%;"/> 
							<display:column title="借款类型" sortable="false" sortName="ptypeId" style="text-align:center;width:8%;">
								<f:description itemValue="${tprojectTransferItem.project.ptypeId}" nodeKey="CREDIT_TYPE" />
							</display:column> 
							<display:column title="还款方式" sortable="false" sortName="prepayWay" style="text-align:center;width:12%;">
								<f:description itemValue="${tprojectTransferItem.project.prepayWay}" nodeKey="hkfs" />
							</display:column> 
							<display:column property="project.prateOut" title="年利率(%)" sortable="false" sortName="prateOut" style="text-align:center;width:8%;"/>
							<display:column property="project.pdeadline" title="期限" sortable="false" sortName="pdeadline" style="text-align:center;width:5%;"/>
							<display:column property="projectInvest.piEffectAmount" title="投资金额" sortable="false" sortName="sm_PI_EffectAmount" style="text-align:center;width:7%;"/>
							<display:column property="claimsSum" title="转让金额" sortable="false" sortName="claimsSum" style="text-align:center;width:7%;"/>
							<display:column property="upsetPrice" title="竞拍底价" sortable="false" sortName="upsetPrice" style="text-align:center;width:7%;"/>
							<display:column property="recentPayDate" title="最近还款日" sortable="false"  style="text-align:center;width:8%;" format="{0,date,yyyy-MM-dd}"/>
							<display:column title="有无逾期" sortable="false"  style="text-align:center;width:8%;">
								<f:description itemValue="${tprojectTransferItem.project.pisLate}" nodeKey="sf" />
							</display:column> 
							<display:column title="操作" media="html" style="text-align:center;width">
								<a href='javascript:void(0);' class="link edit" onclick="doAction('${tprojectTransferItem.transferId}',1);">审核</a>														
							</display:column>
						</display:table>
						<deelon:paging tableId="tprojectTransferItem"/>
						</c:if>
					</div>
					<div tabid="transfering" title="转让中" lselected="${type eq '2'}">
						<c:if test="${type eq '2'}">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
						
					    <display:table name="tprojectTransferList" id="tprojectTransferItem" requestURI="list.html" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="transferId" id="transferId" value="${tprojectTransferItem.transferId}">
							</display:column>
							<display:column property="lenderName" title="借款者" sortable="false" sortName="" style="text-align:center;width:5%;"/> 
							<display:column property="transferorName" title="转让者" sortable="false" sortName="transferorId" style="text-align:center;width:5%;"/> 
							<display:column property="project.pname" title="标题" sortable="false" sortName="pname" style="text-align:center;width:7%;"/> 
							<display:column title="借款类型" sortable="false" sortName="ptypeId" style="text-align:center;width:8%;">
								<f:description itemValue="${tprojectTransferItem.project.ptypeId}" nodeKey="CREDIT_TYPE" />
							</display:column> 
							<display:column title="还款方式" sortable="false" sortName="prepayWay" style="text-align:center;width:6%;">
								<f:description itemValue="${tprojectTransferItem.project.prepayWay}" nodeKey="hkfs" />
							</display:column> 
							<display:column property="project.prateOut" title="年利率(%)" sortable="false" sortName="prateOut" style="text-align:center;width:8%;"/>
							<display:column property="project.pdeadline" title="期限" sortable="false" sortName="pdeadline" style="text-align:center;width:4%;"/>
							<display:column property="projectInvest.piEffectAmount" title="投资金额" sortable="false" sortName="sm_PI_EffectAmount" style="text-align:center;width:7%;"/>
							<display:column property="claimsSum" title="转让金额" sortable="false" sortName="claimsSum" style="text-align:center;width:7%;"/>
							<display:column property="upsetPrice" title="竞拍底价" sortable="false" sortName="upsetPrice" style="text-align:center;width:7%;"/>
							<display:column property="hightestPrice" title="竞拍最高价" sortable="false"  style="text-align:center;width:8%;"/>
							<display:column property="bidderName" title="竞拍者" sortable="false"  style="text-align:center;width:5%;"/>
							<display:column property="remainTime" title="剩余时间" sortable="false"  style="text-align:center;width:8%;"/>
							<display:column title="操作" media="html" style="text-align:center;width:20%;">
								<a href='javascript:void(0);' class="link edit" onclick="doAction('${tprojectTransferItem.transferId}',3);">成交</a>	
								<a href='${ctx}/myAccount/transferDetails.ht?transferId=${tprojectTransferItem.transferId}' class="link edit" target="_blank">查看</a>
								<a href='javascript:void(0);' class="link edit" onclick="doAction('${tprojectTransferItem.transferId}',4);">撤回</a>													
							</display:column>
						</display:table>
						<deelon:paging tableId="tprojectTransferItem"/>
						</c:if>
					</div>
					<div tabid="success" title="转让成功" lselected="${type eq '3'}">
						<c:if test="${type eq '3'}">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
						
					    <display:table name="tprojectTransferList" id="tprojectTransferItem" requestURI="list.html" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="transferId" id="transferId" value="${tprojectTransferItem.transferId}">
							</display:column>
							<display:column property="lenderName" title="借款者" sortable="false" sortName="" style="text-align:center;width:5%;"/> 
							<display:column property="transferorName" title="转让者" sortable="false" sortName="transferorId" style="text-align:center;width:5%;"/> 
							<display:column property="project.pname" title="标题" sortable="false" sortName="pname" style="text-align:center;width:7%;"/> 
							<display:column title="借款类型" sortable="false" sortName="ptypeId" style="text-align:center;width:8%;">
								<f:description itemValue="${tprojectTransferItem.project.ptypeId}" nodeKey="CREDIT_TYPE" />
							</display:column> 
							<display:column title="还款方式" sortable="false" sortName="prepayWay" style="text-align:center;width:6%;">
								<f:description itemValue="${tprojectTransferItem.project.prepayWay}" nodeKey="hkfs" />
							</display:column> 
							<display:column property="project.prateOut" title="年利率(%)" sortable="false" sortName="prateOut" style="text-align:center;width:8%;"/>
							<display:column property="project.pdeadline" title="期限" sortable="false" sortName="pdeadline" style="text-align:center;width:4%;"/>
							<display:column property="projectInvest.piEffectAmount" title="投资金额" sortable="false" sortName="sm_PI_EffectAmount" style="text-align:center;width:7%;"/>
							<display:column property="claimsSum" title="转让金额" sortable="false" sortName="claimsSum" style="text-align:center;width:7%;"/>
							<display:column property="upsetPrice" title="竞拍底价" sortable="false" sortName="upsetPrice" style="text-align:center;width:7%;"/>
							<display:column property="bidPrice" title="竞拍最高价" sortable="false"  style="text-align:center;width:8%;"/>
							<display:column property="finalBidderName" title="竞拍者" sortable="false"  style="text-align:center;width:5%;"/>
							<display:column property="turnoverTime" title="结束时间" sortable="false"  style="text-align:center;width:8%;" format="{0,date,yyyy-MM-dd}"/>
							<display:column title="状态" sortable="false"  style="text-align:center;width:10%;">
								<f:description itemValue="${tprojectTransferItem.projectInvest.piTransferStateId}" nodeKey="TRANSFER_STATUS" />
							</display:column>
							<display:column title="操作" media="html" style="text-align:center;">	
								<a href='${ctx}/myAccount/transferDetails.ht?transferId=${tprojectTransferItem.transferId}' class="link edit" target="_blank">查看</a>											
							</display:column>
						</display:table>
						<deelon:paging tableId="tprojectTransferItem"/>
						</c:if>
					</div>
					<div tabid="fail" title="转让失败" lselected="${type eq '4'}">
						<c:if test="${type eq '4'}">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
						
					    <display:table name="tprojectTransferList" id="tprojectTransferItem" requestURI="list.html" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="transferId" id="transferId" value="${tprojectTransferItem.transferId}">
							</display:column>
							<display:column property="lenderName" title="借款者" sortable="false" sortName="" style="text-align:center;width:6%;"/> 
							<display:column property="transferorName" title="转让者" sortable="false" sortName="transferorId" style="text-align:center;width:6%;"/> 
							<display:column property="project.pname" title="标题" sortable="false" sortName="pname" style="text-align:center;width:10%;"/> 
							<display:column title="借款类型" sortable="false" sortName="ptypeId" style="text-align:center;width:8%;">
								<f:description itemValue="${tprojectTransferItem.project.ptypeId}" nodeKey="CREDIT_TYPE" />
							</display:column> 
							<display:column title="还款方式" sortable="false" sortName="prepayWay" style="text-align:center;width:12%;">
								<f:description itemValue="${tprojectTransferItem.project.prepayWay}" nodeKey="hkfs" />
							</display:column> 
							<display:column property="project.prateOut" title="年利率(%)" sortable="false" sortName="prateOut" style="text-align:center;width:8%;"/>
							<display:column property="project.pdeadline" title="期限" sortable="false" sortName="pdeadline" style="text-align:center;width:5%;"/>
							<display:column property="projectInvest.piEffectAmount" title="投资金额" sortable="false" sortName="sm_PI_EffectAmount" style="text-align:center;width:7%;"/>
							<display:column property="claimsSum" title="转让金额" sortable="false" sortName="claimsSum" style="text-align:center;width:7%;"/>
							<display:column property="upsetPrice" title="竞拍底价" sortable="false" sortName="upsetPrice" style="text-align:center;width:7%;"/>
							<display:column property="turnoverTime" title="结束时间" sortable="false"  style="text-align:center;width:8%;" format="{0,date,yyyy-MM-dd}"/>
							<display:column title="状态" sortable="false"  style="text-align:center;width:8%;">
								<f:description itemValue="${tprojectTransferItem.projectInvest.piTransferStateId}" nodeKey="TRANSFER_STATUS" />
							</display:column>
							<display:column title="操作" media="html" style="text-align:center;">	
								<a href='${ctx}/myAccount/transferDetails.ht?transferId=${tprojectTransferItem.transferId}' class="link edit" target="_blank">查看</a>											
							</display:column>
						</display:table>
						<deelon:paging tableId="tprojectTransferItem"/>
						</c:if>
					</div>
					<div tabid="cancel" title="转让撤回" lselected="${type eq '5'}">
						<c:if test="${type eq '5'}">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
						
					    <display:table name="tprojectTransferList" id="tprojectTransferItem" requestURI="list.html" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="transferId" id="transferId" value="${tprojectTransferItem.transferId}">
							</display:column>
							<display:column property="lenderName" title="借款者" sortable="false" sortName="" style="text-align:center;width:6%;"/> 
							<display:column property="transferorName" title="转让者" sortable="false" sortName="transferorId" style="text-align:center;width:6%;"/> 
							<display:column property="project.pname" title="标题" sortable="false" sortName="pname" style="text-align:center;width:10%;"/> 
							<display:column title="借款类型" sortable="false" sortName="ptypeId" style="text-align:center;width:8%;">
								<f:description itemValue="${tprojectTransferItem.project.ptypeId}" nodeKey="CREDIT_TYPE" />
							</display:column> 
							<display:column title="还款方式" sortable="false" sortName="prepayWay" style="text-align:center;width:12%;">
								<f:description itemValue="${tprojectTransferItem.project.prepayWay}" nodeKey="hkfs" />
							</display:column> 
							<display:column property="project.prateOut" title="年利率(%)" sortable="false" sortName="prateOut" style="text-align:center;width:8%;"/>
							<display:column property="project.pdeadline" title="期限" sortable="false" sortName="pdeadline" style="text-align:center;width:10%;"/>
							<display:column property="projectInvest.piEffectAmount" title="投资金额" sortable="false" sortName="sm_PI_EffectAmount" style="text-align:center;width:5%;"/>
							<display:column property="claimsSum" title="转让金额" sortable="false" sortName="claimsSum" style="text-align:center;width:7%;"/>
							<display:column property="upsetPrice" title="竞拍底价" sortable="false" sortName="upsetPrice" style="text-align:center;width:7%;"/>
							<display:column property="turnoverTime" title="结束时间" sortable="false"  style="text-align:center;width:7%;" format="{0,date,yyyy-MM-dd}"/>
							<display:column title="状态" sortable="false"  style="text-align:center;width:8%;">
								<f:description itemValue="${tprojectTransferItem.projectInvest.piTransferStateId}" nodeKey="TRANSFER_STATUS" />
							</display:column>
							<display:column title="操作" media="html" style="text-align:center;">	
								<a href='${ctx}/myAccount/transferDetails.ht?transferId=${tprojectTransferItem.transferId}' class="link edit" target="_blank">查看</a>												
							</display:column>
						</display:table>
						<deelon:paging tableId="tprojectTransferItem"/>
						</c:if>
					</div>
				</div>			
		</div>	
	</div>
</body>
<script type="text/javascript">
	$(function(){
		$("#ligerTab").ligerTab({onBeforeSelectTabItem:selectTabItem});
	});
	function selectTabItem(itemId){
		if(itemId=="requesting"){
			$("input[name='type']").val(1);
			$("input[name='Q_isCancel_S']").val(0);
			$("input[name='Q_stateId_S']").val(1);
			$("input[name='Q_isCheck_S']").val(0);
			$("input[name='Q_bidderName_S']").val("");
		}else if(itemId=="transfering"){
			$("input[name='type']").val(2);
			$("input[name='Q_isCancel_S']").val(0);
			$("input[name='Q_stateId_S']").val(1);
			$("input[name='Q_isCheck_S']").val(1);
		}else if(itemId=="success"){
			$("input[name='type']").val(3);
			$("input[name='Q_isCancel_S']").val(0);
			$("input[name='Q_stateId_S']").val(2);
			$("input[name='Q_isCheck_S']").val(1);
			$("input[name='Q_bidderName_S']").val("");
		}else if(itemId=="fail"){
			$("input[name='type']").val(4);
			$("input[name='Q_isCancel_S']").val(0);
			$("input[name='Q_stateId_S']").val(3);
			$("input[name='Q_isCheck_S']").val(1);
			$("input[name='Q_bidderName_S']").val("");
		}else if(itemId=="cancel"){
			$("input[name='type']").val(5);
			$("input[name='Q_isCancel_S']").val(1);
			$("input[name='Q_stateId_S']").val(4);
			$("input[name='Q_isCheck_S']").val("");
			$("input[name='Q_bidderName_S']").val("");
		}
		$("#searchForm").submit();
		return false;
	}
	
	function doAction(transferId,type){
		if(type==1){
			$.ligerDialog.warning("点击[是]审核通过，点击[否]审核不通过，点击[取消]不作操作！",function(flag){
				if(flag=='yes'){
					type = 1;
				}else if(flag=='no'){
					type = 2;
				}else{
					return;
				}
				exeAction(transferId,type);
			});
		}else{
			var msg = "";
			if(type==3){
				msg = "是否确定审核中标成立？";
			}else if(type==4){
				msg = "是否确定撤回该笔转让？";
			}
			$.ligerDialog.confirm(msg,function(flag){
				if(flag){
					exeAction(transferId,type);
				}
			});
		}
		
	}
	function exeAction(transferId,type){
		var param = {transferId:transferId,type:type};
		var url = "${ctx}/loan/sysManager/tprojecttransfer/doAction.ht";
		$.ajax({
			url:url,
			data:param,
			dataType:'json',
			type:'post',
			success:function(rsp){
				if(rsp.result){
					$.ligerDialog.success(rsp.message,function(){
						$("#searchForm").submit();
					});
				}else{
					$.ligerDialog.warn(rsp.message,function(){
						$("#searchForm").submit();
					});
				}
			}
		});
	}
</script>
</html>
