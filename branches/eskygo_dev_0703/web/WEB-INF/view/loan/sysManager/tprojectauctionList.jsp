<%@page import="com.deelon.loan.model.sysManager.TprojectAuction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title><%=TprojectAuction.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label"><%=TprojectAuction.TABLE_ALIAS%>管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_tprojectAuction" css="link search" id="btnSearch" >查询</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="add_tprojectAuction" css="link add" href="edit.ht">添加</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="upd_tprojectAuction" css="link update" action="edit.ht">修改</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_tprojectAuction" css="link del" action="del.ht">删除</f:a></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.html">
							<div class="row">
									<span class="label">转让ID:</span><input type="text" name="Q_transferId_S" value="${tprojectAuction.transferId}" maxlength="19" class="inputText" />
									<span class="label">报价人:</span><input type="text" name="Q_userId_S" value="${tprojectAuction.userId}" maxlength="19" class="inputText" />
									<span class="label">已出最高价:</span><input type="text" name="Q_highestPrice_S" value="${tprojectAuction.highestPrice}" maxlength="32" class="inputText" />
									<span class="label">我的报价:</span><input type="text" name="Q_offerPrice_S" value="${tprojectAuction.offerPrice}" maxlength="32" class="inputText" />
							</div>
							<div class="row">
									<span class="label">报价时间:</span><input type="text" name="Q_beginofferTime_DL" value="" class="inputText date" style="width:9%"/>
									<span class="label">至</span><input type="text" name="Q_endofferTime_DG" value="" class="inputText date" style="width:9%"/>
									<span class="label">中标:</span><input type="text" name="Q_isBid_S" value="${tprojectAuction.isBid}" maxlength="3" class="inputText" />
									<span class="label">中标时间:</span><input type="text" name="Q_beginbidTime_DL" value="" class="inputText date" style="width:9%"/>
									<span class="label">至</span><input type="text" name="Q_endbidTime_DG" value="" class="inputText date" style="width:9%"/>
									<span class="label">撤销竞拍:</span><input type="text" name="Q_isCancel_S" value="${tprojectAuction.isCancel}" maxlength="3" class="inputText" />
							</div>
								
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tprojectAuctionList" id="tprojectAuctionItem" requestURI="list.html" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="auctionId" id="auctionId" value="${tprojectAuctionItem.auctionId}"}>
							</display:column>
							<display:column property="transferId" title="转让ID" sortable="true" sortName="transferId" style="text-align:left"/> 
							<display:column property="userId" title="报价人" sortable="true" sortName="userId" style="text-align:left"/> 
							<display:column property="highestPrice" title="已出最高价" sortable="true" sortName="highestPrice" style="text-align:left"/> 
							<display:column property="offerPrice" title="我的报价" sortable="true" sortName="offerPrice" style="text-align:left"/> 
							<display:column property="offerTime" title="报价时间" sortable="true" sortName="offerTime" style="text-align:left"/> 
							<display:column property="isBid" title="中标" sortable="true" sortName="isBid" style="text-align:left"/> 
							<display:column property="bidTime" title="中标时间" sortable="true" sortName="bidTime" style="text-align:left"/> 
							<display:column property="isCancel" title="撤销竞拍" sortable="true" sortName="isCancel" style="text-align:left"/> 
							<display:column title="管理" media="html" style="width:120px;">
								<a href='edit.ht?auctionId=${tprojectAuctionItem.auctionId}' class="link edit">编辑</a>	
								<a href='del.ht?auctionId=${tprojectAuctionItem.auctionId}'  class='link del'>删除</a>														
							</display:column>
						</display:table>
						<deelon:paging tableId="tprojectAuctionItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
