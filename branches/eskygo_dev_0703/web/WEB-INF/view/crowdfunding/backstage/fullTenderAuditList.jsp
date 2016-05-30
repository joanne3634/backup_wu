<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>满标审核</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<script type="text/javascript">
	
	
	
function audits(ab){
	
	
	
	
	var d = $("input[type='checkbox'][disabled!='disabled'][class='pk']:checked");
	if (d.length == 0) {
		$.ligerDialog.warn("请选择记录！");
		return false;
	}
	
	var f = "";
	var c = "";
	var a = d.length;
	var flag=true;
	d.each(function(g) {
		var h = $(this);
		
		if (g < a - 1) {
			f += h.val() + ",";
		} else {
			c = h.attr("name");
			f += h.val();
		}
	});
	
		agreeApply(f,ab);
	
}
function agreeApply(pamrm,agOrdisag){
	
	if(agOrdisag=='agree'){
		//做满标操作前先判断 项目投资人员 是否已经给投资打款,如果没有打款则发信息通知
		var rep=$.ajax({  
		        type: "GET",  
		        url: "${ctx}/crowdfunding/backstage/fullTenderAudit/viewInvestOfPro.ht?projectId="+pamrm 
		        });  
			rep.done(function( data ){  
					if(data=='1'){
						$.ligerDialog.warn("该项目还有投资人未打款,或还有投资人未获项目方审核处理,暂时不能做满标操作,详情请【查看项目跟投人】!");
					
					}else{
						$.ligerDialog.confirm("确认执行该操作吗？","提示信息",function(rtn){
							if(rtn){
								var rep=$.ajax({  
							        type: "POST",  
							        url: "${ctx}/crowdfunding/backstage/fullTenderAudit/updates.ht",
							        data: {applyIds:pamrm,agOrdisag:agOrdisag }  
							        });  
							      
							   	 rep.done(function( data ){  
							       		 $.ligerDialog.warn(data.msg);
							       		///closewin();
							       		location.href=location.href.getNewUrl();
							        });  
							      
							    rep.fail(function( jqXHR, textStatus ) {  
							        $.ligerDialog.warn(textStatus);
							    });
							} 
						});
					}
		       		 
		        });  
		      
		    rep.fail(function( jqXHR, textStatus ) {  
		        $.ligerDialog.warn(textStatus);
		    });
		
		
	}else{
		window.location.target="_blank";
		location.href="get.ht?projectId="+pamrm;
	//	openWdin(pamrm,this);
	}
	   
	
}
function doOpenInvestWin(projectId){
	var url="${ctx}/crowdfunding/backstage/fullTenderAudit/invest.ht?projectId="+projectId;
	window.parent.openDialog(url,'项目跟投人员记录','','400','750');
}
</script>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">满标审核列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_tproject" css="link search" id="btnSearch" ><span></span>查询</f:a></div>
							<div class="l-bar-separator"></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
									<span class="label">项目名称:</span><input type="text" name="Q_pname_S" value="${param['Q_pname_S']}" maxlength="100" class="inputText" />
									
									 <span class="label">审核状态:</span>
											<select name="pstatus" class="select" value="${pstatus}">
												<option value="0"  <c:if test="${pstatus eq '0' || empty pstatus}">selected="selected"</c:if>></option>
												<option value="1" <c:if test="${pstatus eq '1' }">selected="selected"</c:if>>未审核</option>
												<option value="2" <c:if test="${pstatus eq '2' }">selected="selected"</c:if>>已满标</option>
												<option value="3" <c:if test="${pstatus eq '3' }">selected="selected"</c:if>>已流标</option>
									</select>
									
									
									 <%-- <span class="label">所属阶段:</span>	
									 <f:select nodeKey="PTYPE" id="Q_pstage_S" defaultValue="${param['Q_pstage_S']}"  showBlankOnTop="true"></f:select> 								 
									<span class="label">项目类别</span>
									<f:select  styleClass="inputText" nodeKey="XMLX" id="ptypeId" idName="ptypeId" defaultValue="${param['ptypeId']}" showBlankOnTop="true" ></f:select>
									<span class="label">项目所属行业:</span>
									<f:select  styleClass="inputText" nodeKey="PIND" id="pindustry" idName="pindustry" defaultValue="${param['pindustry']}" showBlankOnTop="true" ></f:select>
									 --%>
							</div>
								
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tprojectList" id="tprojectItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1"   class="table-grid">
							<%-- <display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="projectId" id="projectId" value="${tprojectItem.projectId}"}>
							</display:column> --%>
							<display:column  title="项目名称" sortable="false" sortName="pname" style="text-align:left;width:16%;">
							<%-- <a title="点击查看项目跟投人" href='javascript:void(0)' onclick="doOpenInvestWin('${tprojectItem.projectId}')" >${tprojectItem.pname }</a> --%>
							<a title="点击查看" href="${ctx }/crowdfunding/backstage/proAudit/edit.ht?projectId=${tprojectItem.projectId}&IsShowBtn=${ctx}/crowdfunding/backstage/fullTenderAudit/list.ht" >${tprojectItem.pname }</a>
							</display:column> 
							<display:column  title="项目状态" sortable="false" sortName="pstateId" style="text-align:left;width:6%;">
								<f:description nodeKey="xmzt" itemValue="${tprojectItem.pstateId}"></f:description>
							</display:column> 
							<display:column property="realName" title="项目方" sortable="false" sortName="realName" style="text-align:left"/> 
							<display:column property="createTimestr" title="创建日期" sortable="false" sortName="createTimestr" style="text-align:left;width:10%;"/> 
							 <%--  <display:column title="项目类别" sortable="false" sortName="ptypeId" style="text-align:left;width:10%;">
								
								<f:description nodeKey="XMLX" itemValue="${tprojectItem.ptypeId}"></f:description>
							</display:column> 
							<display:column  title="所属行业" sortable="false" sortName="pindustry" style="text-align:left">
							<f:description nodeKey="PIND" itemValue="${tprojectItem.pindustry}"></f:description>
							</display:column>  
							
							<display:column  title="所属阶段" sortable="false" sortName="pstage" style="text-align:left">
								<f:description nodeKey="PTYPE" itemValue="${tprojectItem.pstage}"></f:description>
							</display:column>   --%>
							 
							<display:column title="融资金额" sortable="false" sortName="pfinancingAmount" style="text-align:left;width:10%;"> 
								<fmt:formatNumber value="${tprojectItem.pfinancingAmount }" pattern="###,###.##"  minFractionDigits="2"  ></fmt:formatNumber>
							</display:column>
							<display:column title="认投金额" sortable="false" sortName="pinvestAmount" style="text-align:left;width:10%;"> 
								<fmt:formatNumber value="${tprojectItem.pinvestAmount }" pattern="###,###.##"  minFractionDigits="2"  ></fmt:formatNumber>
							</display:column>	
							<display:column  title="完成比例" sortable="false" sortName="pcomplete" style="text-align:left">
								${tprojectItem.pcomplete }%
							</display:column>
							 
							<display:column property="pinvestCount" title="跟投人数" sortable="false" sortName="pinvestCount" style="text-align:left"/> 
							
							 <display:column property="popenDateStr" title="开标日期" sortable="false" sortName="popenDateStr" style="text-align:left;width:10%;"/> 
							<display:column property="pcloseDateStr" title="结束日期" sortable="false" sortName="pcloseDateStr" style="text-align:left;width:10%;"/> 
							
							<display:column title="操作" media="html" style="width:20%;">
								<c:if test="${tprojectItem.linkedAction ne '已审核' }">
									 <a href='javascript:void(0)' onclick="doOpenInvestWin('${tprojectItem.projectId}')" class="link edit">查看项目跟投人</a> 
								</c:if>
								${tprojectItem.linkedAction }
								
								<%-- <a href='del.ht?projectId=${tprojectItem.projectId}'  class='link del'>删除</a> --%>														
							</display:column>
						</display:table>
						<deelon:paging tableId="projectId"/>
					</div>
				</div>			
	</div>
</body>
</html>
