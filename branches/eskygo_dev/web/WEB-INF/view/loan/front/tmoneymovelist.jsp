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
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label"><%=CmsSiteConfig.TABLE_ALIAS%>管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group">							
							<c:if test="${empty autid }"><f:a alias="search_cmsSiteConfig" css="link search" id="btnSearch" ><span></span>查询</f:a></c:if><c:if test="${not empty autid }"><a class="link search" id="btnSearch" href="listToAutid.ht?Q_inCharge_S=1" ><span></span>查询</a> </c:if> </div></div>
							<%-- <div class="l-bar-separator"></div>
							<div class="group"><f:a alias="add_cmsSiteConfig" css="link add" href="edit.ht"><span></span>添加</f:a></div>--%>
							<div class="l-bar-separator"></div>
							<%-- <div class="group"><c:if test="${empty autid }"><f:a alias="upd_cmsSiteConfig" css="link update"   action="edit.ht"><span></span>修改</f:a> </c:if><c:if test="${not empty autid }"><f:a alias="upd_cmsSiteConfig" css="link update"   action="edit.ht?audit=1"><span></span>修改</f:a> </c:if> </div> --%>
							<%-- <div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_cmsSiteConfig" css="link del" action="del.ht"><span></span>删除</f:a></div>  --%>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
									<span >会员:</span>
									<input type="text" id="applyName" name="applyName" maxlength="200" class="inputText" value="${param['applyName']}">
									<span class="label" style="width: 40px">&nbsp;</span>
									<span >结果:</span>
									<f:select nodeKey="JG" id="Q_resultId_S" showBlankOnTop="true" defaultValue="${param['Q_resultId_S']}"></f:select>
									<span class="label" style="width: 40px">&nbsp;</span> 
									<span >业务时间:</span>
									<input type="text" id="beginDate" name="Q_beginDate_S" value="${param['Q_beginDate_S']}" class="inputText date" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'beginDate\')||\'2020-10-01\'}'})" />
									<span  style="width: 40px">至:</span>
									<input type="text" id="endDate" name="Q_endDate_DG" value="${param['Q_endDate_DG']}" class="inputText date" onclick="WdatePicker({minDate:'#F{$dp.$D(\'endDate\')}',maxDate:'2020-10-01'})" />
							</div>
						</form>
					</div>
					<div class="panel-data">
				    	<%-- <c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set> --%>
					    <display:table name="list" id="item" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid" >
							<%--<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="tmoneymoveId" id="moneyMoveId" value="${item.moneyMoveId}"}>
							</display:column>
							--%><display:column   title="会员" style="text-align:center; width:8%"  sortProperty="${item.userId }" sortable="felse" sortName="userId" > 
								<f:description modelCode="t_user"  modelPropertyName="realName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${item.userId }"/>
							</display:column>
							<display:column title="类型" style="text-align:center; width:8%"  sortable="felse"  sortName="typeId" >
								<f:description nodeKey="zjld" itemValue="${item.typeId }"></f:description>
							</display:column>
							<display:column title="金额"  style="text-align:right; width:10%"  sortable="felse"  sortName="moneyInOut"> 
								<fmt:formatNumber value="${item.moneyInOut }" pattern="###,###.##"  minFractionDigits="2"  ></fmt:formatNumber>
							</display:column>
							<display:column title="手续费"  style="text-align:center; width:8%"  sortable="felse"  sortName="getFee" >  
								<fmt:formatNumber value="${item.getFee }" pattern="###,###.##"  minFractionDigits="2"  ></fmt:formatNumber>
							</display:column> 
							<display:column property="createTime" format="{0,date,yyyy-MM-dd HH:mm}" title="业务时间"  style="text-align:center; width:10%"  sortable="felse"  sortName="createTime" />
							<display:column title="结果"  style="text-align:center; width:5%"  sortable="felse"  sortName="resultId" >
								<f:description nodeKey="JG" itemValue="${item.resultId }"></f:description>
							</display:column>
							<display:column property="remark" title="备注"  style="text-align:center; width:45%"  sortable="felse"  sortName="remark" />  
							<%-- <display:column title="公司分类"  style="text-align:left">
								<f:entityComBo valueFieldVal="${cmsSiteConfigItem.siteOrgId}" entityFiledId="orgId" entityFiledName="orgName" entityCode="sys_org" />
							</display:column>  --%>
							<%-- <display:column title="操作" media="html" style="text-align:center;">
								<c:if test="${ empty autid }"><a href='edit.ht?tmoneymoveId=${item.moneyMoveId}' class="link edit">编辑</a></c:if>	
								<c:if test="${not empty autid }"><c:if test="${item.audit==0 }"><a href='javascript:auditRecord("${item.moneyMoveId}")'  class="link update">审核通过</a></c:if><c:if test="${item.audit==1 }">已审核</c:if>	</c:if>	
								<a href='del.ht?siteConfigId=${cmsSiteConfigItem.siteConfigId}'  class='link del'>删除</a>														
							</display:column> --%>
						</display:table>
						<deelon:paging tableId="item"/>
					</div>
				</div>			
	</div>
	<script type="text/javascript">
		
		function auditRecord(id){
			$.ligerDialog.confirm("确认执行该操作吗？","提示信息",function(rtn){
				if(!rtn){
				}else{
			var rep=$.ajax({  
		        type: "GET",  
		        url: "${ctx}/loan/front/tmoneymove/update.ht?tmoneymoveId="+id 
		        });  
			rep.done(function( data ){  
					if(data=='1'){
						$.ligerDialog.warn("操作成功");
						window.location.reload();
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
	</script>
</body>
</html>
