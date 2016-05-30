<%@page import="com.deelon.loan.model.front.TUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>投资人管理</title>
		<%@include file="/commons/include/get.jsp" %>
	<style type="text/css">
    .img{
    background: url("../images/icons/icons_del.png") no-repeat scroll 0 0 transparent;
    }
	
	
	</style>
</head>
<script type="text/javascript" src="${ctx}/js/deelon/displaytag.js" ></script>
<script type="text/javascript">
$(function(){
	$('#chkall').click(function(){
		if($(this).is(":checked")){
			$('input[name=userId]').each(function(i){		
				$(this).attr("checked",true);
			
			});
		}else{
			$('input[name=userId]').each(function(i){		
				$(this).attr("checked",false);
			
			});
		}
	})	
	
	
	
	$("#ligerTab").ligerTab({onBeforeSelectTabItem:selectTabItem});
	

	
});
function selectTabItem(itemId){
	$("#searchForm").submit();
	return false;
}

function groupActions(p){
	var d = $("input[type='checkbox'][disabled!='disabled'][class='pk']:checked");
	if (d.length == 0) {
			$.ligerDialog.warn("请选择记录！");
		return ;
	}
	
	var f = "";
	var c = "";
	var a = d.length;
	d.each(function(g) {
		var h = $(this);
		if (g < a - 1) {
			f += h.val() + ",";
		} else {
			c = h.attr("name");
			f += h.val();
		}
	});

}


//add by nicole 2015/3/10 取消回车事件
function handleSearchKeyPress() {
	$(".panel-search :input").keypress(function(b) {
		if (b.keyCode == 13) {
			/* $("a.link.search").click(); */
			b.keyCode = 0;
		} else {
			if (b.keyCode == 27) {
				var a = $("#searchForm");
				if (a) {
					a[0].reset();
				}
			}
		}
	});
}

</script>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">投资人管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group">
							<a class="link search" href="javascript:void(0);" onclick="$('#searchForm').submit();"><span></span>查询</a>
							</div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="investorASKList.ht" style="display: block;">
							<div class="row">
									<span class="label">注册名:</span><input type="text" name="Q_loginName_S" value="${param['Q_loginName_S']}" maxlength="20" class="inputText" />
									<span class="label">真实姓名:</span><input type="text" name="Q_realName_S" value="${param['Q_realName_S']}" maxlength="20" class="inputText" />
							</div>
							<input type="hidden" value="2" name="groupId">
						</form>
					</div>
					<div id="ligerTab">
						<div tabid="personal" title="个人投资" >
					    	<c:set var="checkAll">
								<input type="checkbox" id="chkall" onclick=""/>
							</c:set>
						    <display:table name="tuserList" id="tuserItem" requestURI="listToSelect.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
								<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
									  <input type="checkbox" class="pk" name="userId" id="userId" value="${tuserItem.userId}"/>
								</display:column>
								<display:column property="loginName" title="会员名" sortable="false" sortName="loginName" style="text-align:center"/> 
								<display:column property="realName" title="真实姓名" sortable="false" sortName="realName" style="text-align:center"/>
								<display:column title="是否投资机构" sortable="false" sortName="isCompany" style="text-align:center">
									<f:description nodeKey="sf"  itemValue="${tuserItem.isCompany }"/>
								</display:column>
								<display:column title="领投人状态" sortable="false" sortName="isLeader" style="text-align:center">
									<f:description nodeKey="sf"  itemValue="${tuserItem.isLeader }"/>
								</display:column>  
								<display:column title="询价资格状态" sortable="false" sortName="isAskPrice" style="text-align:center">
									<f:description nodeKey="sf"  itemValue="${tuserItem.isAskPrice }"/>
								</display:column>
								<display:column title="锁定状态" sortable="false" sortName="isLock" style="text-align:center">
									<f:description nodeKey="sf"  itemValue="${tuserItem.isLock }"/>
								</display:column> 
								<display:column title="激活状态" sortable="false" sortName="isActive" style="text-align:center">
									<f:description nodeKey="sf"  itemValue="${tuserItem.isActive }"/>
								</display:column>  
								<display:column title="推荐状态" sortable="false" sortName="isRecommended" style="text-align:center">
									<f:description nodeKey="sf"  itemValue="${tuserItem.isRecommended }"/>
								</display:column>  
								<display:column title="注册时间" sortable="false" sortName="RegisterTime" style="text-align:center;width:12%;">
									<fmt:formatDate value="${tuserItem.registerTime}" pattern="yyyy-MM-dd HH:mm"/>
								</display:column>
								<display:column title="操作" media="html" style="width:80px;text-align:center;">
									<a href='${ctx }/crowdfunding/backstage/userinvest/investorASKAdd.ht?userId=${tuserItem.userId}' class="link edit">添加支付</a>
									<%-- <a href='javascript:;' onclick="delAccount('${tuserItem.userId}');"  class='link del'>删除</a>	 --%>													
								</display:column>
							</display:table>
							<deelon:paging tableId="tuserItem"/>
						</div>

				</div>			
	</div>
</body>
</html>
