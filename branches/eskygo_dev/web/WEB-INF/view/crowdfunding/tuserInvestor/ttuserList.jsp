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
	
	if('${param["Q_provincesId_S"]}' != ""){
		$.ajax({
			url : "${ctx}/user/ajaxGetJilian.ht",
			type : 'post',
			data : "areaId=" + '${param["Q_provincesId_S"]}',
			dataType : 'json',
			success : function(data) {
				var html = "<option value=''></option>";
				if(data.length > 0){
					for ( var i = 0; i < data.length; i++) {
						if('${param["Q_cityId_S"]}' == data[i].areaId){
							html += "<option selected value='" + data[i].areaId + "'>" + data[i].areaName + "</option>";
						}else{
							html += "<option value='" + data[i].areaId + "'>" + data[i].areaName + "</option>";
						}
						
					}		
				}
				$("#FCityId").html(html);

			},
			error : function(xhr, textStatus, errorThrown) {
				alert('异步获取数据出现异常');
			}
		});
		
	}
	
	
	$("#FProvincesId").change(function(){	

		if($(this).val() ==""){return;}		
		$.ajax({
			url : "${ctx}/user/ajaxGetJilian.ht",
			type : 'post',
			data : "areaId=" + $(this).val(),
			dataType : 'json',
			success : function(data) {
				var html = "<option value=''></option>";
				if(data.length > 0){
					for ( var i = 0; i < data.length; i++) {
						html += "<option value='" + data[i].areaId + "'>" + data[i].areaName + "</option>";
					}		
				}
				$("#FCityId").html(html);

			},
			error : function(xhr, textStatus, errorThrown) {
				alert('异步获取数据出现异常');
			}
		});
	});	
	
});
function selectTabItem(itemId){
	$("#searchForm").find("input[name='Q_idNo_S']").val('');
	$("#FProvincesId option:first").prop("selected", 'selected');
	$("#FCityId option:first").prop("selected", 'selected');
	if(itemId=="personal"){
		$("input[name='type']").val(0);
		$("input[name='isCompany']").val(0);
	}else{
		$("input[name='type']").val(1);
		$("input[name='isCompany']").val(1);
	}
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
	if(p=='1'){//推荐
		unclockAccount(f);
	}
	if(p=='2'){//锁定
		lockAccount(f);
	}
	if(p=='3'){//激活
		activateAccount(f);
	}
	if(p=='4'){//解锁
		unlockAccount(f);
	}
	if(p=='5'){//删除
		delAccount(f);
	}
}
//推荐
function unclockAccount(pamrm){
	 $.ajax({  
		type: "POST",  
		url: "updateUser.ht",
		data: {arrayIds:pamrm ,isRecommended:'1'}, 
		success:function( data ){
			if(data == "0"){
				$.ligerDialog.success("推荐成功");
				setTimeout("location='listToSelect.ht?groupId=2';",1500);
				//window.setTimeout("listToSelect.ht?groupId=2&isCompany="+$("input[name='isCompany']").val(),3000);
			}else{
				$.ligerDialog.err("推荐失败",function(){
				setTimeout("location='listToSelect.ht?groupId=2';",1500);
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
		dataType : 'json',
	 	success:function( data ){
			if(data == 0){
				$.ligerDialog.success("锁定成功");
				setTimeout("location='listToSelect.ht?groupId=2';",1500);
			}else{
				$.ligerDialog.err("锁定失败",function(){
				setTimeout("location='listToSelect.ht?groupId=2';",1500);
				});
			}
		}
	});   
}
//解锁
function unlockAccount(pamrm){
	 $.ajax({  
		type: "POST",  
		url: "updateUser.ht",
		data: {arrayIds:pamrm ,isLock:'0' },
		dataType : 'json',
	 	success:function( data ){
			if(data == 0){
				$.ligerDialog.success("解锁成功");
				setTimeout("location='listToSelect.ht?groupId=2';",1500);
			}else{
				$.ligerDialog.err("解锁失败",function(){
				setTimeout("location='listToSelect.ht?groupId=2';",1500);
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
				$.ligerDialog.success("激活成功");
				setTimeout("location='listToSelect.ht?groupId=2';",1500);
				//window.setTimeout("listToSelect.ht?groupId=2&isCompany="+$("input[name='isCompany']").val(),3000);
			}else{
				$.ligerDialog.err("激活失败",function(){
				setTimeout("location='listToSelect.ht?groupId=2';",1500);
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
				setTimeout("location='listToSelect.ht?groupId=2';",1500);
			}else{
				$.ligerDialog.err("删除失败",function(){
				setTimeout("location='listToSelect.ht?groupId=2';",1500);
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
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">投资人管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><!-- <f:a alias="search_tuser" css="link search" id="btnSearch" >查询</f:a> -->
							<a class="link search" href="javascript:void(0);" onclick="$('#searchForm').submit();"><span></span>查询</a>
							</div>
<!-- 							<div class="l-bar-separator"></div> -->
<%-- 							<div class="group"><f:a alias="add_tuser" css="link add" href="edit.ht">添加</f:a></div> --%>
<!-- 							<div class="l-bar-separator"></div> -->
<%-- 							<div class="group"><f:a alias="upd_tuser" css="link update" action="edit.ht">修改</f:a></div> --%>
<%--
							<div class="l-bar-separator"></div><f:a alias="del_tuser" css="link del" action="del.ht">批量删除</f:a></div>
							<div class="group"><a class="link search" href="javascript:void(0);" onclick="groupActions('5');"><p class="img"></p>批量删除</a>
							 --%>
							<div class="l-bar-separator"></div>
							<div class="group">
								<a class="link search" href="javascript:void(0);" onclick="groupActions('1');"><span></span>批量推荐</a>
							</div>
							<div class="l-bar-separator"></div>
							<div class="group">
								<a class="link search" href="javascript:void(0);" onclick="groupActions('2');"><span></span>批量锁定</a>
							</div>
							<div class="l-bar-separator"></div>
							<div class="group">
								<a class="link search" href="javascript:void(0);" onclick="groupActions('4');"><span></span>批量解锁</a>
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
						<form id="searchForm" method="post" action="listToSelect.ht" style="display: block;">
							<div class="row">
									<span class="label">会员名:</span><input type="text" name="Q_loginName_S" value="${param['Q_loginName_S']}" maxlength="20" class="inputText" />
									<span class="label">真实姓名:</span><input type="text" name="Q_realName_S" value="${param['Q_realName_S']}" maxlength="20" class="inputText" />
									<%-- <span class="label">手机号码:</span><input type="text" name="Q_mobile_S" value="${param['Q_mobile_S']}" maxlength="20" class="inputText" /> --%>
									<c:if test="${type eq 0}">
										<span class="label">身份证:</span><input type="text" name="Q_idNo_S" value="${param['Q_idNo_S']}" maxlength="20" class="inputText" />
									</c:if>
									<c:if test="${type eq 1}">
										<span class="label">营业执照:</span><input type="text" name="Q_businessLicense_S" value="${param['Q_businessLicense_S']}" maxlength="20" class="inputText" />
									</c:if>
									<span class="label">领投人:</span><f:select nodeKey="sf" id="Q_isLeader_S" name="Q_isLeader_S" defaultValue="${param['Q_isLeader_S']}" showBlankOnTop="true"></f:select>
							</div>
							<div class="row">
<!-- 									<span class="label">注册时间从:</span><input type="text" id="Q_registerTimeBegin_S" name="Q_registerTimeBegin_S"  class="inputText date" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'Q_registerTimeBegin_S\')||\'2020-10-01\'}'})" value="${param['Q_registerTimeBegin_S']}"/>
									<span class="label" style="text-align:center;width:40px;">至</span><input type="text" id="Q_registerTimeEnd_DG" name="Q_registerTimeEnd_DG"  class="inputText date" onclick="WdatePicker({minDate:'#F{$dp.$D(\'Q_registerTimeEnd_DG\')}',maxDate:'2020-10-01'})"  value="${param['Q_registerTimeEnd_DG']}"/> -->
								<%--<c:if test="${type eq 0}">
								<span class="label">省份:</span>
								<select id="FProvincesId" name="Q_provincesId_S">
		        					<option value=""></option>
		        						<c:forEach items="${arealist }" var="list">
		        							<option value="${list.areaId }" <c:if test="${param['Q_provincesId_S'] eq list.areaId}">selected</c:if>>${list.areaName }</option>
		        						</c:forEach>
		        				</select >
		        											
								<span class="label" >市:</span><select id="FCityId" name="Q_cityId_S"></select>
								</c:if>
								
								--%><span class="label">锁定状态:</span><f:select nodeKey="sf" id="Q_isLock_S" name="Q_isLock_S" defaultValue="${param['Q_isLock_S']}" showBlankOnTop="true"></f:select>
								<span class="label">激活状态:</span><f:select nodeKey="sf" id="Q_isActive_S" name="Q_isActive_S" defaultValue="${param['Q_isActive_S']}" showBlankOnTop="true"></f:select>
							</div>
							<input type="hidden" value="0" name="type">
							<input type="hidden" value="0" name="isCompany">
							<input type="hidden" value="2" name="groupId">
						</form>
					</div>
					<div id="ligerTab">
						<div tabid="personal" title="个人投资" lselected="${iscompany eq 0}">
							<c:if test="${iscompany eq 0}">
					    	<c:set var="checkAll">
								<input type="checkbox" id="chkall" onclick=""/>
							</c:set>
						    <display:table name="tuserList" id="tuserItem" requestURI="listToSelect.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
								<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
									  <input type="checkbox" class="pk" name="userId" id="userId" value="${tuserItem.userId}"/>
								</display:column>
								<display:column property="loginName" title="会员名" sortable="false" sortName="loginName" style="text-align:center"/> 
								<display:column property="realName" title="真实姓名" sortable="false" sortName="realName" style="text-align:center"/>
								<display:column property="idNo" title="身份证" sortable="false" sortName="id_no" style="text-align:center"/>  
								<%--<display:column title="机构（公司）" sortable="false" sortName="isCompany" style="text-align:center">
									<f:description nodeKey="sf"  itemValue="${tuserItem.isCompany }"/>
								</display:column>
--%><%-- 								<display:column property="businessLicense" title="营业执照" sortable="false" sortName="BusinessLicense" style="text-align:center"/>   --%>
								<display:column title="领投人状态" sortable="false" sortName="isLeader" style="text-align:center">
									<f:description nodeKey="sf"  itemValue="${tuserItem.isLeader }"/>
								</display:column>  
								<display:column title="询价资格状态" sortable="false" sortName="isCompany" style="text-align:center">
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
									<a href='tedit.ht?userId=${tuserItem.userId}' class="link edit">编辑</a>	
									<%-- <a href='javascript:;' onclick="delAccount('${tuserItem.userId}');"  class='link del'>删除</a>	 --%>													
								</display:column>
							</display:table>
							<deelon:paging tableId="tuserItem"/>
							</c:if>
						</div>
						<div tabid="company" title="机构投资" lselected="${iscompany eq 1}">
							<c:if test="${iscompany eq 1}">
					    	<c:set var="checkAll">
								<input type="checkbox" id="chkall"/>
							</c:set>
						    <display:table name="tuserList" id="tuserItem" requestURI="listToSelect.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
								<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
									  <input type="checkbox" class="pk" name="userId" id="userId" value="${tuserItem.userId}"/>
								</display:column>
								<display:column property="loginName" title="会员名" sortable="false" sortName="loginName" style="text-align:center"/> 
								<display:column property="contactName" title="联系人名称" sortable="false" sortName="contactName" style="text-align:center"/>
								<display:column title="机构（公司）" sortable="false" sortName="isCompany" style="text-align:center">
									<f:description nodeKey="sf"  itemValue="${tuserItem.isCompany }"/>
								</display:column>
								<display:column property="businessLicense" title="营业执照" sortable="false" sortName="BusinessLicense" style="text-align:center"/>  
<%-- 								<display:column title="领投人" sortable="false" sortName="isLeader" style="text-align:center"> --%>
<%-- 									<f:description nodeKey="sf"  itemValue="${tuserItem.isLeader }"/> --%>
<%-- 								</display:column>   --%>
<%-- 								<display:column title="询价资格" sortable="false" sortName="isCompany" style="text-align:center"> --%>
<%-- 									<f:description nodeKey="sf"  itemValue="${tuserItem.isAskPrice }"/> --%>
<%-- 								</display:column> --%>
								<display:column title="锁定" sortable="false" sortName="isLock" style="text-align:center">
									<f:description nodeKey="sf"  itemValue="${tuserItem.isLock }"/>
								</display:column> 
								<display:column title="激活" sortable="false" sortName="isActive" style="text-align:center">
									<f:description nodeKey="sf"  itemValue="${tuserItem.isActive }"/>
								</display:column>  
								<display:column title="注册时间" sortable="false" sortName="RegisterTime" style="text-align:center;width:12%;">
									<fmt:formatDate value="${tuserItem.registerTime}" pattern="yyyy-MM-dd HH:mm"/>
								</display:column>
								<display:column title="操作" media="html" style="width:120px;">
									<a href='tedit.ht?userId=${tuserItem.userId}' class="link edit">编辑</a>	
									<%-- <a href='javascript:;' onclick="delAccount('${tuserItem.userId}');" class='link del'>删除</a>		 --%>												
								</display:column>
							</display:table>
							<deelon:paging tableId="tuserItem"/>
							</c:if>
						</div>
				</div>			
	</div>
</body>
</html>
