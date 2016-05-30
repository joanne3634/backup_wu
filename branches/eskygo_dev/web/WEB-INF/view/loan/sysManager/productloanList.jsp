<%@page import="com.deelon.loan.model.productsloan.Tproductsloan"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title><%=Tproductsloan.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label"><%=Tproductsloan.TABLE_ALIAS%>管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_tproductsloan" css="link search" id="btnSearch" >查询</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="add_tproductsloan" css="link add" href="edit.ht">添加</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="upd_tproductsloan" css="link update" action="edit.ht">修改</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_tproductsloan" css="link del" action="del.ht">删除</f:a></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
									<span class="label">产品名称:</span><input type="text" name="Q_pname_S" value="${param['Q_pname_S']}" maxlength="10" class="inputText" />
									<span class="label">额度(最小):</span><input type="text" name="Q_pamountMin_S" value="${param['Q_pamountMin_S']}" maxlength="32" class="inputText" />
									<span class="label">额度(最大):</span><input type="text" name="Q_pamountMax_S" value="${param['Q_pamountMax_S']}" maxlength="32" class="inputText" />
									<span class="label">贷款利率(最小):</span><input type="text" name="Q_prateMin_S" value="${param['Q_prateMin_S']}" maxlength="32" class="inputText" />
							</div>
							<div class="row">
									<span class="label">贷款利率(最大):</span><input type="text" name="Q_prateMax_S" value="${param['Q_prateMax_S']}" maxlength="32" class="inputText" />
									<span class="label">贷款期限(最小):</span><input type="text" name="Q_pdeadlineMin_S" value="${param['Q_pdeadlineMin_S']}" maxlength="32" class="inputText" />
									<span class="label">贷款期限(最大):</span><input type="text" name="Q_pdeadlineMax_S" value="${param['Q_pdeadlineMax_S']}" maxlength="32" class="inputText" />
									<span class="label">投注时间(最小):</span><input type="text" name="Q_pauditDaysMin_S" value="${param['Q_pauditDaysMin_S']}" maxlength="10" class="inputText" />
							</div>
							<div class="row">
									<span class="label">投注时间(最大):</span><input type="text" name="Q_pauditDaysMax_S" value="${param['Q_pauditDaysMax_S']}" maxlength="10" class="inputText" />
									<span class="label">审核时间(最小):</span><input type="text" name="Q_pvotingDaysMin_S" value="${param['Q_pvotingDaysMin_S']}" maxlength="10" class="inputText" />
									<span class="label">审核时间(最大):</span><input type="text" name="Q_pvotingDaysMax_S" value="${param['Q_pvotingDaysMax_S']}" maxlength="10" class="inputText" />
									<span class="label">还款方式:</span>
									<f:select nodeKey="hkfs" id="Q_prepayWay_S" showBlankOnTop="true" defaultValue="${param['Q_prepayWay_S']}"></f:select>
							</div>
							<div class="row">
									<span class="label">手续费:</span><input type="text" name="Q_pfee_S" value="${param['Q_pfee_S']}" maxlength="100" class="inputText" />
									<span class="label">亮点:</span><input type="text" name="Q_pgood_S" value="${param['Q_pgood_S']}" maxlength="200" class="inputText" />
									<span class="label">推荐人群:</span><input type="text" name="Q_precommend_S" value="${param['Q_precommend_S']}" maxlength="100" class="inputText" />
									<span class="label">还款指南:</span><input type="text" name="Q_prepayGuide_S" value="${param['Q_prepayGuide_S']}" maxlength="150" class="inputText" />
							</div>
							<!-- div class="row">
									<span class="label">创建者:</span><input type="text" name="Q_creator_S" value="${tproductsloan.creator}" maxlength="19" class="inputText" />
									<span class="label">创建时间:</span><input type="text" name="Q_begincreateTime_DL" class="inputText date" style="width:9%"/>
									<span class="label">至</span><input type="text" name="Q_endcreateTime_DG" class="inputText date" style="width:9%"/>
							</div> -->
								
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tproductsloanList" id="tproductsloanItem" requestURI="list.html" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:left;">
								  <input type="checkbox" class="pk" name="productsLoanId" id="productsLoanId" value="${tproductsloanItem.productsLoanId}"}>
							</display:column>
							<display:column property="pname" title="产品名称"  sortName="pname" style="text-align:left;width:13%;"/> 
							<display:column property="pamountMin" title="额度<br/>(最小)"  sortName="pamountMin" style="text-align:left;width:6%;"/> 
							<display:column property="pamountMax" title="额度<br/>(最大)"  sortName="pamountMax" style="text-align:left;width:6%;"/> 
							<display:column property="prateMin" title="贷款利率<br/>(最小)%"  sortName="prateMin" style="text-align:left;width:6%;"/> 
							<display:column property="prateMax" title="贷款利率<br/>(最大)%"  sortName="prateMax" style="text-align:left;width:6%;"/> 
							<display:column property="pdeadlineMin" title="贷款期限<br/>(最小)"  sortName="pdeadlineMin" style="text-align:left;width:6%;"/> 
							<display:column property="pdeadlineMax" title="贷款期限<br/>(最大)"  sortName="pdeadlineMax" style="text-align:left;width:6%;"/> 
							<display:column property="pauditDaysMin" title="投注时间<br/>(最小)"  sortName="pauditDaysMin" style="text-align:left;width:6%;"/> 
							<display:column property="pauditDaysMax" title="投注时间<br/>(最大)"  sortName="pauditDaysMax" style="text-align:left;width:6%;"/> 
							<display:column property="pvotingDaysMin" title="审核时间<br/>(最小)"  sortName="pvotingDaysMin" style="text-align:left;width:6%;"/> 
							<display:column property="pvotingDaysMax" title="审核时间<br/>(最大)"  sortName="pvotingDaysMax" style="text-align:left;width:6%;"/> 
							<display:column title="还款方式"  sortName="prepayWay" style="text-align:left;width:12%;">
								<f:description nodeKey="hkfs" itemValue="${tproductsloanItem.prepayWay }"></f:description>
							</display:column> 
							<%-- display:column property="pfee" title="手续费"  sortName="pfee" style="text-align:left"/> 
							<display:column property="pgood" title="亮点"  sortName="pgood" style="text-align:left"/> 
							<display:column property="precommend" title="推荐人群"  sortName="precommend" style="text-align:left"/> 
							<display:column property="prepayGuide" title="还款指南"  sortName="prepayGuide" style="text-align:left"/>  
							<display:column property="creator" title="创建者"  sortName="creator" style="text-align:left"/> 
							<display:column property="createTime" title="创建时间"  sortName="createTime" style="text-align:left"/> --%>
							<display:column title="操作" media="html" style="text-align:left;">
								<a href='edit.ht?productsLoanId=${tproductsloanItem.productsLoanId}' class="link edit">编辑</a>	
								<a href='del.ht?productsLoanId=${tproductsloanItem.productsLoanId}'  class='link del'>删除</a>														
							</display:column>
						</display:table>
						<deelon:paging tableId="tproductsloanItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
