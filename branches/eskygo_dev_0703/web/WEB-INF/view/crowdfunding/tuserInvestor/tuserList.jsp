<%@page import="com.deelon.loan.model.front.TUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>项目方管理</title>
	<%@include file="/commons/include/get.jsp" %>
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
})




	function groupActions(p){
		var d = $("input[type='checkbox'][disabled!='disabled'][class='pk']:checked");
		if (d.length == 0) {
			$.ligerDialog.warn("请选择记录！");
			return false;
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
		if(p=='1'){//解锁
			unclockAccount(f);
		}
		if(p=='2'){//锁定
			lockAccount(f);
		}
		if(p=='3'){//激活
			activateAccount(f);
		}
		if(p=='4'){//删除
			delAccount(f);
		}
		
	}
	//解锁
	function unclockAccount(pamrm){
		 $.ajax({  
		        type: "POST",  
		        url: "updateUser.ht",
		        data: {arrayIds:pamrm ,isLock:'0' },
		 		success:function( data ){
				if(data == 0){
					$.ligerDialog.success("解锁成功");
					window.setTimeout("location='list.ht?groupId=1'",1500);
				}else{
					$.ligerDialog.err("解锁失败",function(){
						window.setTimeout("location='list.ht?groupId=1'",1500);
					});
				}
			}
		 }); 
	}
	//锁定
	function lockAccount(pamrm){
		 $.ajax({  
		        type: "POST",  
		        url: "updateUser.ht",
		        data: {arrayIds:pamrm ,isLock:'1' },
		 		success:function( data ){
				if(data == 0){
					$.ligerDialog.success("锁定成功");
						window.setTimeout("location='list.ht?groupId=1'",1500);
				}else{
					$.ligerDialog.err("锁定失败",function(){
						window.setTimeout("location='list.ht?groupId=1'",1500);
					});
				}
			}
		 });
	}
	//激活
	function activateAccount(pamrm){
		 $.ajax({  
		        type: "POST",  
		        url: "updateUser.ht",
		        data: {arrayIds:pamrm ,isActive:'1'},
		 		success:function( data ){
				if(data == 0){
					$.ligerDialog.success("激活成功！");
					window.setTimeout("location='list.ht?groupId=1'",1500);
				}else{
					$.ligerDialog.err("激活失败",function(){
						window.setTimeout("location='list.ht?groupId=1'",1500);
					});
				}
			}
		 });
	}
	//删除
	function delAccount(pamrm){
		 $.ajax({  
			type: "POST",  
			url: "del.ht",
			data: {arrayIds:pamrm},
			success:function( data ){
				if(data == 0){
					$.ligerDialog.success("删除成功");
					window.setTimeout("location='list.ht?groupId=1'",1500);
				}else{
					$.ligerDialog.err("删除失败",function(){
						window.setTimeout("location='list.ht?groupId=1'",1500);
					});
				}
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
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">项目方管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><!-- <f:a alias="search_tuser" css="link search" id="btnSearch" >查询</f:a> -->
							<a class="link search" href="javascript:void(0);" onclick="$('#searchForm').submit();"><span></span>查询</a>
							</div>
							<%-- 
							<div class="l-bar-separator"></div><f:a alias="del_tuser" css="link del" action="del.ht">批量删除</f:a>
							<div class="group"><a class="link search" href="javascript:void(0);" onclick="groupActions('4');"><span></span>批量删除</a></div>
							 --%>
							<div class="l-bar-separator"></div>
 							<div class="group">
								<a class="link search" href="javascript:void(0);" onclick="groupActions('1');"><span></span>批量解锁</a>
							</div>
							<div class="l-bar-separator"></div>
							<div class="group">
								<a class="link search" href="javascript:void(0);" onclick="groupActions('2');"><span></span>批量锁定</a>
							</div>
							<div class="l-bar-separator"></div>
							<div class="group">
								<a class="link search" href="javascript:void(0);" onclick="groupActions('3');"><span></span>批量激活</a>
							</div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht" style="display: block;">
							<div class="row">
									<span class="label">会员名:</span><input type="text" name="Q_loginName_S" value="${param['Q_loginName_S']}" maxlength="20" class="inputText" />
									<span class="label">真实姓名:</span><input type="text" name="Q_realName_S" value="${param['Q_realName_S']}" maxlength="20" class="inputText" />
									<span class="label">手机号码:</span><input type="text" name="Q_mobile_S" value="${param['Q_mobile_S']}" maxlength="20" class="inputText" />
									<span class="label">身份证:</span><input type="text" name="Q_idNo_S" value="${param['Q_idNo_S']}" maxlength="20" class="inputText" />
							</div>
							<div class="row">	
								<span class="label">锁定状态:</span><f:select nodeKey="sf" id="Q_isLock_S" name="Q_isLock_S" defaultValue="${param['Q_isLock_S']}" showBlankOnTop="true"></f:select>
								<span class="label">激活状态:</span><f:select nodeKey="sf" id="Q_isActive_S" name="Q_isActive_S" defaultValue="${param['Q_isActive_S']}" showBlankOnTop="true"></f:select>
							</div>
							<input type="hidden" value="1" name="Q_groupID_S">
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tuserList" id="tuserItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="userId" id="userId" value="${tuserItem.userId}"/>
							</display:column>
							<display:column property="loginName" title="会员名" sortable="false" sortName="loginName" style="text-align:center"/> 
							<display:column property="realName" title="真实姓名" sortable="false" sortName="realName" style="text-align:center"/>
							<display:column property="idNo" title="身份证" sortable="false" sortName="id_no" style="text-align:center;width:15%;"/>  
							<display:column property="mobile" title="手机号码" sortable="false" sortName="Mobile" style="text-align:center;width:13%;"/>  
							<display:column title="锁定状态" sortable="false" sortName="isLock" style="text-align:center">
								<f:description nodeKey="sf"  itemValue="${tuserItem.isLock }"/>
							</display:column> 
							<display:column title="激活状态" sortable="false" sortName="isActive" style="text-align:center">
								<f:description nodeKey="sf"  itemValue="${tuserItem.isActive }"/>
							</display:column>  
							<display:column title="最后登录时间" sortable="false" sortName="LastLoginTime" style="text-align:center;width:12%;">
								<fmt:formatDate value="${tuserItem.lastLoginTime}" pattern="yyyy-MM-dd HH:mm"/>
							</display:column>
							<display:column title="注册时间" sortable="false" sortName="RegisterTime" style="text-align:center;width:12%;">
								<fmt:formatDate value="${tuserItem.registerTime}" pattern="yyyy-MM-dd HH:mm"/>
							</display:column>
							<display:column title="操作" media="html" style="width:80px;text-align:center;">
								<a href='edit.ht?userId=${tuserItem.userId}' class="link edit">编辑</a>	
								<%--<a href='javascript:;' onclick="delAccount('${tuserItem.userId}');"  class='link del'>删除</a> --%>														
							</display:column>
						</display:table>
						<deelon:paging tableId="tuserItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
