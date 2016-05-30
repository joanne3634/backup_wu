<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>流标的项目</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">初审项目列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_tproject" css="link search" id="btnSearch" ><span></span>查询</f:a></div>
							 
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
									<span class="label">项目名称:</span><input type="text" name="Q_pname_S" value="${param['Q_pname_S']}" maxlength="100" class="inputText" />
									<%-- <span class="label">融资金额:</span><input type="text" name="Q_pfinancingAmount_S" value="${param['Q_pfinancingAmount_S']}" maxlength="32" class="inputText" /> --%>
									
									<span class="label">融资金额:</span>
									<input type="text" style="width: 75px;" id="Q_pfinancingAmount1_S" name="Q_pfinancingAmount1_S" value="${param['Q_pfinancingAmount1_S']}" maxlength="6" class="inputText" />-
									<input type="text" style="width: 75px;" id="Q_pfinancingAmount2_S" name="Q_pfinancingAmount2_S" value="${param['Q_pfinancingAmount2_S']}" maxlength="6" class="inputText" />万元
									<span class="label">项目状态:</span><f:select nodeKey="xmzt" id="Q_pstateId_S" showBlankOnTop="true" defaultValue="${param['Q_pstateId_S']}"></f:select>
									<%-- <span class="label">所属阶段:</span><f:select nodeKey="PTYPE" id="Q_pstage_S" defaultValue="${param['Q_pstage_S']}"></f:select> --%> 
									<span class="label">项目类别:</span><f:select nodeKey="XMLX" id="Q_ptypeId_S" showBlankOnTop="true" defaultValue="${param['Q_ptypeId_S']}"></f:select>
									<br/>
									<span class="label">所属行业:</span><f:select nodeKey="PIND" id="Q_pindustry_S" showBlankOnTop="true" defaultValue="${param['Q_pindustry_S']}"></f:select>
							</div>
							<div class="row">
									 
									<%-- <span class="label">所在省份:</span><select id="FProvincesId" name="Q_pprovincesId_S" style="width:100px;" >
					                    	<option value=""></option>
					                    	<c:forEach items="${list }" var="list">
					                    		<option value="${list.areaId }" <c:if test="${param['Q_pprovincesId_S'] == list.areaId }">selected</c:if>>${list.areaName }</option>				                    	
					                    	</c:forEach>
					                    </select>  --%>
									<%-- <span class="label">公司名称:</span><input type="text" name="Q_pcompanyName_S" value="${param['Q_pcompanyName_S']}" maxlength="100" class="inputText" />
									<span class="label">成立年份:</span><input type="text" name="Q_pfoundedYear_S" value="${param['Q_pfoundedYear_S']}" maxlength="10" class="inputText" /> --%>
							</div>
					                    
						</form>
					</div>
					<div class="panel-data">
				    	<%-- <c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set> --%>
					    <display:table name="tprojectList" id="tprojectItem" requestURI="list.html" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<%-- <display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="projectId" id="projectId" value="${tprojectItem.projectId}"/>
							</display:column>
							<display:column title="会员" sortable="false"   style="text-align:left">
								<f:description modelCode="t_user"  modelPropertyName="realName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${tprojectItem.creator }"/> 
							</display:column>   --%>
							<display:column title="项目名称" sortable="false" sortName="pname" style="text-align:left">
							<a title="点击查看" href="edit.ht?projectId=${tprojectItem.projectId}" >${tprojectItem.pname }</a>
							</display:column> 
							<display:column title="项目<br/>状态" sortable="false" sortName="pstateId" style="text-align:left">
								<f:description nodeKey="xmzt"  itemValue="${tprojectItem.pstateId }"/>
							</display:column>   
							<display:column title="项目<br/>类别" sortable="false" sortName="ptypeId" style="text-align:left">
								<f:description nodeKey="XMLX"  itemValue="${tprojectItem.ptypeId }"/>
							</display:column>   
							<display:column title="所属<br/>行业" sortable="false" sortName="pindustry" style="text-align:left">
								<f:description nodeKey="PIND"  itemValue="${tprojectItem.pindustry }"/>
							</display:column>   
							<display:column title="所在<br/>城市" sortable="false" sortName="pcityId" style="text-align:left">
								<h:getArea areaId="${tprojectItem.pcityId }"></h:getArea>
							</display:column> 
							<display:column title="融资金<br/>额(万元)" sortable="false" sortName="pfinancingAmount" style="text-align:left">
								<fmt:formatNumber value="${tprojectItem.pfinancingAmount/10000 }" pattern="###,###.##"  minFractionDigits="0"  ></fmt:formatNumber>
							</display:column> 
							<display:column title="认投金<br/>额(万元)" sortable="false" sortName="pinvestAmount" style="text-align:left">
								<fmt:formatNumber value="${tprojectItem.pinvestAmount/10000 }" pattern="###,###.##"  minFractionDigits="0"  ></fmt:formatNumber>
							</display:column> 
							<display:column property="pcomplete" title="完成<br/>比(%)" sortable="false" sortName="pcomplete" style="text-align:left"/> 
							<display:column title="开标<br/>日期" style="text-align:left">
								<fmt:formatDate value="${tprojectItem.popenDate}" pattern="yyyy-MM-dd"></fmt:formatDate>
							</display:column>  
							<display:column title="结束<br/>日期" style="text-align:left">
								<fmt:formatDate value="${tprojectItem.pcloseDate}" pattern="yyyy-MM-dd"></fmt:formatDate>
							</display:column> 
							<display:column property="pbreakRemark" title="流标说明" sortable="false" sortName="pbreakRemark" style="text-align:left"/> 
							<%-- display:column title="管理" media="html" style="width:120px;">
								<a href='editPay.ht?projectId=${tprojectItem.projectId}' class="link edit">放款</a>	
								<a href='cacelPay.ht?projectId=${tprojectItem.projectId}'  class='link edit'>确认</a>														
							</display:column>--%>
						</display:table>
						<deelon:paging tableId="projectId"/>
					</div>
				</div>			
	</div>
	 
</body>
 
</html>
