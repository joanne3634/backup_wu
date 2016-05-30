<%@page import="com.deelon.cmsform.model.site.CmsSiteConfig"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title><%=CmsSiteConfig.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="${ctx}/loan/front/userFunds/grid.ht?userId=${userId}">
							<div class="row">
									<%-- <span >会员:</span>
									<input type="text" id="applyName" name="applyName" maxlength="200" class="inputText" value="${param['applyName']}"> --%>
									
									<span >结果:</span>
									<f:select nodeKey="JG" id="Q_resultId_S" showBlankOnTop="true" defaultValue="${param['Q_resultId_S']}"></f:select> 
									<label style="width: 80px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> 
									<span >类型:</span>
									<f:select nodeKey="zjld" id="Q_typeId_S" showBlankOnTop="true" defaultValue="${param['Q_typeId_S']}"></f:select>
								<label style="width: 80px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> 
									<f:a alias="search_cmsSiteConfig" css="link search" id="btnSearch" ><span></span>查询</f:a>
							</div>
						</form>
					</div>
					<div class="panel-data" title="会员资金流动列表">
				    	<%-- <c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set> --%>
					    <display:table name="list" id="item"  requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid" >
							<%-- <display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="tmoneymoveId" id="moneyMoveId" value="${item.moneyMoveId}"}>
							</display:column> --%>
							<display:column   title="会员" style="text-align:center; width:8%"  sortProperty="${item.userId }" sortable="felse" sortName="userId" > 
								<f:description modelCode="t_user"  modelPropertyName="realName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${item.userId }"/>
							</display:column>
							<display:column title="类型" style="text-align:center; width:8%"  sortable="felse"  sortName="typeId" >
								<f:description nodeKey="zjld" itemValue="${item.typeId }"></f:description>
							</display:column>
							<display:column title="金额(支出-/收入+)"  style="text-align:center; width:10%"  sortable="felse"  sortName="moneyInOut"> 
								<fmt:formatNumber value="${item.moneyInOut }" pattern="###,###.##"  minFractionDigits="2"  ></fmt:formatNumber>
							</display:column>
							<display:column title="手续费"  style="text-align:center; width:8%"  sortable="felse"  sortName="getFee" >  
								<fmt:formatNumber value="${item.getFee }" pattern="###,###.##"  minFractionDigits="2"  ></fmt:formatNumber>
							</display:column>
							<display:column title="当前账户余额"  style="text-align:center; width:8%"  sortable="felse"  sortName="getFee" >  
								<fmt:formatNumber value="${item.moneyCurrent }" pattern="###,###.##"  minFractionDigits="2"  ></fmt:formatNumber>
							</display:column>  
							<display:column property="createTime" format="{0,date,yyyy-MM-dd HH:mm}" title="操作时间"  style="text-align:center; width:15%"  sortable="felse"  sortName="createTime" />
							<display:column title="结果"  style="text-align:center; width:5%"  sortable="felse"  sortName="resultId" >
								<f:description nodeKey="JG" itemValue="${item.resultId }"></f:description>
							</display:column>
							<display:column property="remark" title="备注"  style="text-align:center; width:20%"  sortable="felse"  sortName="remark" />  
							<display:column property="flowCode" title="对账流水号"  style="text-align:left">
							</display:column> 
							<display:column title="操作" media="html" style="text-align:center;">
								<a href='javascript:void(0)' onclick="doStatement('${item.typeId}','${item.flowCode}')" class="link edit">对账</a>
								<c:if test="${item.resultId eq '2' && empty item.serialNo }">
								<a href='javascript:void(0)' onclick="updateFundsOfUser('${item.resultId }','${item.remark }','${item.moneyMoveId}')" class="link setting ">修正资金</a>													
								</c:if>
								<c:if test="${not empty item.serialNo }">
								<a href='javascript:void(0)' onclick="rollBackFundsOfUser('${item.resultId }','${item.remark }','${item.moneyMoveId}','${item.serialNo}')" class="link back">撤销修正</a>
								</c:if>
							</display:column>
						</display:table>
						<deelon:paging tableId="item"/>
						<input id="payMark" name="payMark" type="hidden" value="${payMark }">
						<input id="fundsId" name="fundsId" type="hidden" value="${fundsId }">
					</div>
				</div>			
	</div>
	<script type="text/javascript">
		function doStatement(typeId,flowCode){
			var action="";
			if(typeId=='1'){
				action='1';
			}
			if(typeId=='2'){
				action="2";
			}
		    var url="${ctx}/loan/front/userFunds/doStatement.ht?flowCode="+flowCode+"&Action="+action ;
			window.parent.parent.openDialog(url,'第三方托管对账数据','','300','600');
		}
		
		function updateFundsOfUser(resultId,remark,id){
			if(resultId=='2'&&remark!=''&&remark.search("失败")>=0){
				$.ligerDialog.confirm("确认执行该操作吗？","提示信息",function(rtn){
					if(rtn){
						var rep=$.ajax({  
					        type: "GET",  
					        url: "${ctx}/loan/front/userFunds/updateFundsOfUser.ht?tmoneymoveId="+id 
					        });  
						rep.done(function( data ){  
								if(data=='1'){
									$.ligerDialog.warn("操作成功");
									window.location.reload();
								//	location.href="statement.ht?payMark="+$("#payMark").val()+"&fundsId="+$("#fundsId").val();
								}else{
									$.ligerDialog.warn("操作失败");
								}
					       		 
					        });  
					      
					    rep.fail(function( jqXHR, textStatus ) {  
					        $.ligerDialog.warn(textStatus);
					    });
					}
				});
			}
		}
		
		function rollBackFundsOfUser(resultId,remark,id,serialNo){
			if(serialNo.search('对账后已修正会员资金')>=0){
				$.ligerDialog.confirm("确认执行回滚操作吗？","提示信息",function(rtn){
					if(rtn){
						var rep=$.ajax({  
					        type: "GET",  
					        url: "${ctx}/loan/front/userFunds/rollBackFundsOfUser.ht?tmoneymoveId="+id 
					        });  
						rep.done(function( data ){  
								if(data=='1'){
									$.ligerDialog.warn("操作成功");
									window.location.reload();
								//	location.href="statement.ht?payMark="+$("#payMark").val()+"&fundsId="+$("#fundsId").val();
								}else{
									$.ligerDialog.warn("操作失败");
								}
					       		 
					        });  
					      
					    rep.fail(function( jqXHR, textStatus ) {  
					        $.ligerDialog.warn(textStatus);
					    });
					}
				});
			}
		}
		
	</script>
</body>
</html>
