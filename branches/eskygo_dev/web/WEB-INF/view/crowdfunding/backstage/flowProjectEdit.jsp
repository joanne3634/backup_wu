<%--
	time:2011-11-28 10:17:09
	desc:edit the 用户表
--%>
<%@page language="java" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>流标的项目</title>
	<%@include file="/commons/include/form.jsp" %>
	<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/public.css">
	<f:link href="tree/zTreeStyle.css"></f:link>
	<script type="text/javascript" src="${ctx}/js/tree/jquery.ztree.js"></script>
	<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerTab.js" ></script>
	<script type="text/javascript" src="${ctx}/js/deelon/displaytag.js" ></script>
	<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerWindow.js" ></script>
   <script type="text/javascript"  src="${ctx}/js/deelon/platform/system/SysDialog.js"></script>
   <script type="text/javascript" src="${ctx}/js/deelon/platform/system/FlexUploadDialog.js"></script>
	<script type="text/javascript">
/* 	 $(function () { 
			    	h=$('body').height();
			    	$("#tabMyInfo").ligerTab({         	
			            	//height:h-80
			          });
	 });	    	
			    */ 	
	</script>
<style type="text/css">
	html{height:100%}
	body {overflow:auto;}
div.panel-body {
    margin: 0px;
}

.inputText1{
border: 1px solid #adadad;
padding: 2px;
width: 180px;
}
</style>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				  流标的项目
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<!-- <div class="group"><a class="link save" id="dataFormSave" href="#"><span></span>保存</a></div> -->
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht"><span></span>返回</a></div>
				</div>
			</div>
		</div>
	   <form id="sysUserForm" method="post" action="save.ht">
						
            <div  id="tabMyInfo" class="panel-nav" style="overflow:hidden; position:relative;">  
            <div title="项目详情" tabid="userdetail" icon="${ctx}/styles/default/images/resicon/user.gif">
			         <table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="25%">项目名称:</th>	
								<td>										 
									<input readonly="readonly"  readonly="readonly" type="text" id="pname" name="pname" value="${tcproject.pname}" class="inputText1" />
								</td>
								<th width="25%">项目状态:</th>	
								<td>	
								<f:select styleClass="inputText" disabled="true" nodeKey="xmzt" id="pstateId" idName="pstateId" defaultValue="${tcproject.pstateId}" showBlankOnTop="true" ></f:select>									 
									
									
								</td>
							</tr>
							<tr>
								<th width="25%">项目类别</th>	
								<td>										 
									
									<f:select disabled="true" styleClass="inputText" nodeKey="XMLX" id="ptypeId" idName="ptypeId" defaultValue="${tcproject.ptypeId}" showBlankOnTop="true" ></f:select>
								</td>
								<th width="25%">项目所属行业:</th>	
								<td>										 
									<f:select disabled="true" styleClass="inputText" nodeKey="PIND" id="pindustry" idName="pindustry" defaultValue="${tcproject.pindustry}" showBlankOnTop="true" ></f:select>
								</td>
							</tr>
							<tr>
								<th width="25%">所在城市:</th>	
								<td>										 
									<input readonly="readonly"  readonly="readonly" type="text" id="pcityId" name="pcityId" value="${tcproject.pcityIname}" class="inputText" />
								</td>
								<th width="25%">融资金额（万元）:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pfinancingAmount" name="pfinancingAmount" value="<fmt:formatNumber value="${tcproject.pfinancingAmount/10000 }" pattern="###,###.##"  minFractionDigits="0" /> " class="inputText" />
								</td>
							</tr>
							 
							<tr>
								<th width="25%">认投金额（万元）:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pinvestAmount" name="pinvestAmount" value="<fmt:formatNumber value="${tcproject.pinvestAmount/10000 }" pattern="###,###.##"  minFractionDigits="0" />" class="inputText" />
								</td>
								<th width="25%">完成比(%):</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pcomplete" name="pcomplete" value="${tcproject.pcomplete}" class="inputText" />
								</td>
								
							</tr>
							<tr>
								<th width="25%">开标时间:</th>	
								<td>										 
									<input  disabled="disabled" type="text"  name="popenDate" value="<fmt:formatDate value='${tcproject.popenDate}' />" class="inputText date" style="width:110px;"/>
								</td>
								<th width="25%">结束时间:</th>	
								<td>										 
									<input disabled="disabled"  type="text" name="pcloseDate" value="<fmt:formatDate value='${tcproject.pcloseDate}' />" class="inputText date" style="width:110px;"/>
								</td>
							</tr>
							<tr>
								<th width="25%">流标说明:</th>	
								<td colspan="3">										 
									<textarea rows="2" cols="3" readonly="readonly" id="pbreakRemark" name="pbreakRemark" class="inputText1">${tcproject.pbreakRemark}</textarea>
								</td>
							</tr>
					</table>
					<input   type="hidden" name="projectId" value="${tcproject.projectId}" />
			           		
					
	           </div>
	  
	  </form>
</div>
</body>
</html>
