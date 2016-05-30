<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>项目的跟投人员 打款情况</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<script type="text/javascript">
function doSendMsg(projectId,userId,piisCheck){
	if(piisCheck=='0'){
		$.ligerDialog.warn("该投资人还未通过项目方审核,暂不能短信催款!");
		return;
	}
	var rep=$.ajax({  
        type: "GET",  
        url: "${ctx}/crowdfunding/backstage/fullTenderAudit/doSendMsg.ht?projectId="+projectId+"&investUser="+userId 
        });  
	rep.done(function( data ){  
			if(data=='1'){
				$.ligerDialog.warn("通知短信已经发出!");
			} else{
				$.ligerDialog.warn("通知短信发送失败!");
			}
       		 
        });  
      
    rep.fail(function( jqXHR, textStatus ) {  
        $.ligerDialog.warn(textStatus);
    });
}
function cancelVote(investId,pid,piisCheck){
	if(piisCheck=='0'){
		$.ligerDialog.warn("该投资人还未通过项目方审核,暂不能反悔!");
		return;
	}
    $.ajax({
        url : "${ctx }/crowdfunding/front/tcprojectinvest/cancelVote.ht",
        type : 'post',
        dataType : 'json',
        data:{investId:investId,projectid:pid},
        success : function(data) {
        	$.ligerDialog.warn("处理成功!");
        },
        error:function(data){
        	$.ligerDialog.warn("处理失败!");
        }
    });	
}
</script>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">跟投人员 打款情况</span>
					</div>
					
				</div>
				<div class="panel-body">
					
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tprojectList" id="tprojectItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1"   class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="projectId" id="projectId" value="${tprojectItem.projectId}"}>
							</display:column>
							<display:column property="pname" title="项目名称" sortable="false" sortName="pname" style="text-align:left"/> 
							
							<display:column property="realName" title="跟投会员" sortable="false" sortName="realName" style="text-align:left"/>
							<display:column  title="是否通过<br>项目方审核" sortable="false" sortName="piisCheck" style="text-align:left">
								<c:if test="${tprojectItem.piisCheck eq '1'}">已通过</c:if>
								<c:if test="${tprojectItem.piisCheck eq '0'}"><p style="color: red">待审核</p></c:if>
							</display:column>
							
							 
							<display:column  title="跟投日期" sortable="false" sortName="piinvestTime" style="text-align:left;width:15%;">
								<fmt:formatDate value="${tprojectItem.piinvestTime}" pattern="yyyy-MM-dd"></fmt:formatDate> 
							</display:column>
							
							<display:column title="跟投金额" sortable="false" sortName="piinvest" style="text-align:left;width:19%;"> 
								<fmt:formatNumber value="${tprojectItem.piinvest }" pattern="###,###.##"  minFractionDigits="2"  />
							</display:column>
							<display:column title="是否领投" sortable="false" sortName="piisLeader" style="text-align:left;width:10%;"> 
								<c:if test="${tprojectItem.piisLeader eq '0' }">否</c:if>
								<c:if test="${tprojectItem.piisLeader eq '1' }">是</c:if>
							</display:column>	
							<display:column  title="是否完成打款" sortable="false" sortName="piisPay" style="text-align:left">
								<c:if test="${tprojectItem.piisPay eq '0' }"><span style="color: red;">未打款</span></c:if>
								<c:if test="${tprojectItem.piisPay eq '1' }">已打款</c:if>
							</display:column>
							
							<display:column title="操作" media="html" style="width:14%;">
								<c:if test="${tprojectItem.piisPay eq '0' }">
									<a href='javascript:void(0)' onclick="doSendMsg('${tprojectItem.projectId}','${tprojectItem.userId}','${tprojectItem.piisCheck}')" class="link edit">通知打款</a>
									<a href='javascript:void(0)' onclick="cancelVote('${tprojectItem.investId}','${tprojectItem.projectId}','${tprojectItem.piisCheck}')" class="link edit">反悔</a>
								</c:if>
							 <c:if test="${tprojectItem.piisPay eq '1' }">
							 	已打款
							 </c:if>
								
								<%-- <a href='del.ht?projectId=${tprojectItem.projectId}'  class='link del'>删除</a> --%>														
							</display:column>
						</display:table>
						<deelon:paging tableId="projectId"/>
					</div>
				</div>			
	</div>
</body>
</html>
