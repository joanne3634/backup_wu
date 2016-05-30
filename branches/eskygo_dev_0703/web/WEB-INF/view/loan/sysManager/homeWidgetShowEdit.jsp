<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>平台主页设置</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=tsetHomepage&formSave=Y"></script>
		<script type="text/javascript">
		$(function() {
			valid(showRequest,showResponse,1);
		});
	</script>
<style type="text/css">
	html{height:100%}
	body {overflow:auto;}
div.panel-body {
    margin: 0px;
}
</style>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">
				<c:if test="${TSetHomepage.homePageId==null }">添加用户信息</c:if>
				<c:if test="${TSetHomepage.homePageId!=null }">编辑【${TSetHomepage.rdesc_name}】信息</c:if>  
				</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#"><span></span>保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht"><span></span>返回</a></div>
				</div>
			</div>
		</div>
	   <form id="tsetHomepageForm" method="post" action="save.ht">
						
			         
			           		<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
								<tr>
									
									<th width="18%">模块名称: <span class="required">*</span></th>
									<td ><input type="text" id="rdesc_name" name="rdesc_name" value="${TSetHomepage.rdesc_name}" style="width:240px !important" class="inputText"/>
									<label id="rdesc_ts"></label>
									</td>
									
								</tr>						
																				
								<tr >
									<th>模块代码: <span class="required">*</span></th>
									<td>
									<c:if test="${empty TSetHomepage}">
									<input type="text" id="code_num" name="code_num" value="${TSetHomepage.code_num}" style="width:240px !important" class="inputText"/>								
									</c:if>
									<c:if test="${!empty TSetHomepage}">
									<input type="text" id="code_num" name="code_num" value="${TSetHomepage.code_num}" style="width:240px !important" class="inputText" readonly="readonly"/>
									</c:if>
									
									<label id="code_ts"></label>
									</td>
								</tr>
								
								<tr>
								    <th>显示记录数:<span class="required">*</span> </th>
									<td ><input type="text" id="records" name="records" value="${TSetHomepage.records}" style="width:240px !important" class="inputText"/>
									<label id="recodesT"></label>
									</td>
								</tr>
								<tr>
									<th>是否可见: </th>
									<td>
<!-- 									<select name="isVisiable" class="select" style="width:245px !important"> -->
<%-- 											<option value="1" <c:if test="${TSetHomepage.isVisiable==1}">selected</c:if> >显示</option> --%>
<%-- 											<option value="0" <c:if test="${TSetHomepage.isVisiable==0}">selected</c:if> >隐藏</option> --%>
<!-- 									</select>						 -->
										<f:select nodeKey="sf" id="isVisiable" name="isVisiable" defaultValue="${TSetHomepage.isVisiable}" ></f:select>
									</td>
								</tr>						
								
								
								<tr>
								    <th>对齐方式: </th>
									<td >
<!-- 										<select name="alignID" class="select" style="width:245px !important"> -->
<%-- 											<option value="1" <c:if test="${TSetHomepage.alignID==1}">selected</c:if> >左</option> --%>
<%-- 											<option value="2" <c:if test="${TSetHomepage.alignID==2}">selected</c:if> >中</option> --%>
<%-- 											<option value="3" <c:if test="${TSetHomepage.alignID==3}">selected</c:if> >右</option> --%>
<!-- 										</select> -->
										<f:select nodeKey="dqfs" id="alignID" name="alignID" defaultValue="${TSetHomepage.alignID}" ></f:select>
									</td>
								</tr>
								
													
								<tr>
								   <th>排序: </th>
								   <td ><input type="text" id="sortID_id" name="sortID" value="${TSetHomepage.sortID}" style="width:240px !important" class="inputText"/></td>
								</tr>
														
							</table>
							<input type="hidden" name="homePageId" value="${TSetHomepage.homePageId}" />
					
	          
	  </form>
</div>
</body>
</html>
