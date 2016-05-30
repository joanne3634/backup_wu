<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>平台主页显示设置</title>
	<%@include file="/commons/include/get.jsp" %>
	<script type="text/javascript">
	
	
	function syncToLdap(obj){
		
		var v=$(obj);
		
		if(v.hasClass("disabled")){
			$.ligerDialog.error('没有权限!');
			return;
		}
		var confirmContent="<font color='red'>与AD服务器同步会将AD的用户同步到系统数据库，您确定要进行同步吗？</font>";
		$.ligerDialog.confirm(confirmContent,function(data){
			if(data){
				sync();
			}else{
				return false;
			}
		});
		sync=function(conf){
			var url=__ctx + "/platform/system/sysUser/syncUser.ht";
			$.ligerDialog.waitting('正在同步AD用户，请等待...');
			$.post(url,function(data){
				$.ligerDialog.closeWaitting();
				var obj=new com.deelon.form.ResultMessage(data);
				if(obj.isSuccess()){
					$.ligerDialog.success("同步用户成功!","提示信息",function(){
						location.href=location.href.getNewUrl();
					});
				}
				else{
					$.ligerDialog.err("提示信息","同步用户失败!",obj.getMessage());
				}
			})
		};
	}
	
	</script>
</head>
<body>

	<div class="panel">

			<div class="panel-top">
				<div class="tbar-title">
					<span class="tbar-label">平台首页区域列表</span>
				</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<%--div class="group">
						<f:a alias="searchUser" css="link search" id="btnSearch"><span></span>查询</f:a>
					</div--%>
					<div class="l-bar-separator"></div>
					<div class="group">
						<f:a alias="addUser" css="link add" href="edit.ht"><span></span>添加</f:a>
					</div>
					<%--div class="l-bar-separator"></div>
					
					<div class="group">
						<f:a alias="editModel" css="link update" href="edit.ht?HomePageId=${entity.homePageId}" >编辑</f:a>
					</div--%>
					<div class="l-bar-separator"></div>
					<div class="group">
						<f:a alias="delModel" css="link del" action="del.ht"><span></span>删除</f:a>
					</div>
					
					<div class="l-bar-separator"></div>
					<%--div class="l-bar-separator"></div>
					<div class="group">
						<f:a alias="syncToLdap" css="link reload" showNoRight="false" onclick="syncToLdap(this)"><span></span>同步</f:a>
					</div--%>
				</div>	
			</div>
		

		</div>
		<div class="panel-body">
		    	<c:set var="checkAll">
					<input type="checkbox" id="chkall"/>
				</c:set>
			    <display:table name="ListVo" id="entity" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1"   class="table-grid">
					<display:column title="${checkAll}" media="html" style="text-align:left;width:30px;">
						  	<input type="checkbox" class="pk" name="HomePageId" value="${entity.homePageId}">
					</display:column>
					<display:column property="rdesc_name" title="模块名称" sortable="false" sortName="rdesc_name" style="text-align:left;width:25%;"></display:column>
					<display:column property="code_num" title="模块编号" sortable="false" sortName="code_num" style="text-align:left;width:15%;"></display:column>
				
					<display:column title="是否可见" sortable="false" sortName="isVisiable" style="text-align:left;width:10%;">
<%-- 						<c:choose> --%>
<%-- 							<c:when test="${entity.isVisiable==1}"> --%>
<!-- 								<span class="red">是</span> -->
<%-- 						   	</c:when> --%>
<%-- 					       	<c:otherwise> --%>
<!-- 						    	<span class="green">否</span> -->
<%-- 						   	</c:otherwise> --%>
<%-- 						</c:choose> --%>
						<f:description itemValue="${entity.isVisiable}" nodeKey="sf" />
					</display:column>
	               <display:column property="records" title="显示记录数" sortable="false" sortName="records" style="text-align:left;width:10%;"></display:column>
					<display:column property="sortID" title="排序" sortable="false" sortName="sortID" style="text-align:left;width:10%;"></display:column>
					
					<display:column title="对齐(左/中/右)" sortable="false" sortName="alignID" style="text-align:left;width:10%;">
<%-- 						<c:choose> --%>
<%-- 							<c:when test="${entity.alignID==1}"> --%>
<!-- 								<span class="red">左</span> -->
<%-- 						   	</c:when> --%>
<%-- 						   	<c:when test="${entity.alignID==2}"> --%>
<!-- 								<span class="red">中</span> -->
<%-- 						   	</c:when> --%>
<%-- 					       	<c:otherwise> --%>
<!-- 						    	<span class="green">右</span> -->
<%-- 						   	</c:otherwise> --%>
<%-- 						</c:choose> --%>
						<f:description itemValue="${entity.alignID}" nodeKey="dqfs" />
					</display:column>	
					<display:column title="操作" media="html" style="text-align:left;">
					    <%--f:a alias="userUnder" css="link primary" href="#" onclick="openUserUnder('${entity.userId}',this)">下属管理</f:a--%>
						<a href='edit.ht?HomePageId=${entity.homePageId}' class="link edit">编辑</a>	
						<a href='del.ht?HomePageId=${entity.homePageId}'  class='link del'>删除</a>		
						<%--f:a alias="userInfo" css="link detail" href="get.ht?userId=${entity.userId}">明细</f:a>
						<f:a alias="setParams" css="link parameter" href="${ctx}/platform/system/sysUserParam/editByUserId.ht?userId=${entity.userId}" >参数属性</f:a>
						<f:a alias="resetPwd" css="link resetPwd" href="resetPwdView.ht?userId=${entity.userId}">重置密码</f:a>
						<f:a alias="setStatus" css="link setting" href="editStatusView.ht?userId=${entity.userId}">设置状态</f:a>
						<c:if test="${cookie.origSwitch==null}">
							<f:a alias="switch" css="link switchuser" target="_top" href="${ctx}/j_spring_security_switch_user?j_username=${entity.account}" >切换用户</f:a>
						</c:if --%>
					</display:column>
				</display:table>
					<deelon:paging tableId="homePageId"/>
			
		</div>
	</div>
</body>
</html>


