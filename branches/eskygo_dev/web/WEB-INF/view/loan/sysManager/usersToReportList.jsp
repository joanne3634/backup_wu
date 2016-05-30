<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>用户举报</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">用户举报管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="yhjbSerch" css="link search" id="btnSearch" >查询</f:a></div>
							<div class="l-bar-separator"></div>
							<%-- <div class="group"><f:a alias="add_tsettings" css="link add" href="edit.ht">联系举报方</f:a></div> --%>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="upd_tsettings" css="link close" action="closeReport.ht">关闭问题</f:a></div>
							
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht?${queryParam }">
							<ul class="row">
								<%-- 	<li>
										<span class="label">举报用户:</span><input type="text" name="Q_creator_S" id="Q_creator_S" value="${param['Q_creator_S']}" maxlength="50" class="inputText" />
										</li> --%>
									<li>
									<span class="label">处理情况:</span>
<%-- 										<select name="Q_stateId_S" class="select"  value="${param['Q_stateId_S']}"> --%>
<!-- 											<option value="">--选择--</option> -->
<%-- 											<option value="1" <c:if test="${param['Q_stateId_S']==1}">selected</c:if>>未处理</option> --%>
<%-- 											<option value="2" <c:if test="${param['Q_stateId_S']==2}">selected</c:if>>处理中</option> --%>
<%-- 											<option value="3" <c:if test="${param['Q_stateId_S']==3}">selected</c:if>>已关闭</option> --%>
<!-- 										</select> -->
										<f:select nodeKey="TSZT" id="Q_stateId_S" name="Q_stateId_S" showBlankOnTop="true" defaultValue="${param['Q_stateId_S']}"></f:select> 					 
									</li>
									<li>
									<span class="label">举报时间从:</span><input type="text" id="Q_beginDate_DL" name="Q_beginDate_DL"  class="inputText date" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'Q_beginDate_DL\');}'})" value="${param['Q_beginDate_DL']}"/>
									至:<input type="text" id="Q_endDate_DG" name="Q_endDate_DG"  class="inputText date" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'Q_endDate_DG\');}'})"  value="${param['Q_endDate_DG']}"/>
									</li>
							</ul>
							</div>
								
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="ListVo" id="vo" requestURI="list.html" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="reportId" id="settingsId" value="${vo.reportId}">
							</display:column> 
							<display:column   title="举报用户" sortable="false" sortName="creator" style="text-align:center;width:8%;"> 
								<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${vo.creator }"/>
							</display:column> 
							<display:column property="personHands2" title="被举报用户"  style="text-align:center;width:8%;"/> 
							<display:column property="proname" title="相关项目"  style="text-align:center;width:8%;"/>
							<display:column property="reportReason" title="举报原因"  style="text-align:center;width:20%;"/>
<%-- 							<display:column property="remarks" title="备注说明"  style="text-align:center;width:15%;"/> --%>
							<display:column title="举报时间"  style="text-align:center;width:12%;">
								<fmt:formatDate value="${vo.createTime }" pattern="yyyy-MM-dd HH:mm"/>
							</display:column>
							<display:column  title="是否处理"  sortName="StateId" style="text-align:center;width:10%;">
								<f:description itemValue="${vo.stateId}" nodeKey="TSZT" />
							</display:column>  
							<%-- <display:column property="setDesc" title="处理人"  style="text-align:center;width:10%;"/> --%>
							<display:column title="处理时间"  style="text-align:center;width:12%;">
								<fmt:formatDate value="${vo.endTimes }" pattern="yyyy-MM-dd HH:mm"/>
							</display:column>
							<display:column  title="处理方式"  sortName="linkWay" style="text-align:center;width:10%;">
								<f:description itemValue="${vo.linkWay}" nodeKey="HFFS3" />
							</display:column>  
						 <display:column title="操作" media="html" style="text-align:center;">
							<f:a alias="updateUserInfo" css="link edit" href="FollowUpReport.ht?userId=${vo.reportId}&&stateId=${vo.stateId}" >举报跟进</f:a>
						</display:column>
							<%-- <display:column title="管理" media="html" style="width:120px;">
								<a href='edit.ht?settingsId=${vo.settingsId}' class="link edit">编辑</a>	
								<a href='del.ht?settingsId=${vo.settingsId}'  class='link del'>删除</a>														
							</display:column> --%>
						</display:table>
						<deelon:paging tableId="reportId"/>
					</div>
				</div>			
	</div>
</body>
<script type="text/javascript">
	$(function(){
		$("a.link.close").click(function(){
			var input = $(".pk:checked");
			var len = input.length;
			if(len==0){
				$.ligerDialog.warn('请选择要关闭的举报信息');
				return;
			}
			var url = $(this).attr("action");
			var name = input.attr("name");
			$.ligerDialog.confirm("你已选择"+len+"条举报信息，确认关闭？",function(flag){
				if(flag){
					var values = "[";
					input.each(function(i){
						if(i>0){
							values +=",";
						}
						values += $(this).attr("value");
					});
					values += "]";
					$.ajax({
						url:url,
						data:"reportIds="+values,
						dataType:'json',
						type:'post',
						success:function(rsp){
							if(rsp.result==1){
								$.ligerDialog.success(rsp.message,function(){
									window.location.reload();
								});
							}else{
								$.ligerDialog.error(rsp.message);
							}
							
						}
					});
				}
				
			});
		});
	});
</script>
</html>
