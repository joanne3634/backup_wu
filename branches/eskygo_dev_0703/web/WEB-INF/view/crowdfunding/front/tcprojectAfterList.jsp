<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>会员后台-投后管理</title>
	<meta name="renderer" content="webkit"/>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
</head>
<body>
	<div class="PrDyBack f_l">
		<h2><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">投后管理</h2>
		<form action=""   name="pageForm" id="pageForm">
		<div class="PrDyBackDelebutton">
 			<!--  <div><a href="javascript:void(0);" onclick="add()">添加</a></div>-->
 			
 项目名称：<input type="text" id="projectName" name="projectName"	value="${projectName }" />	 标题： <input type="text" id="paTitle" name="paTitle"	value="${paTitle }" />	
 类型：<select id="paTypeId" name="paTypeId">
  <option value=""></option>
 <option value="1" <c:if test="${paTypeId==1 }">selected</c:if>>年度报表</option>
 <option value="2" <c:if test="${paTypeId==2 }">selected</c:if>>季度报表</option>
 <option value="3" <c:if test="${paTypeId==3 }">selected</c:if>>重大事件披露</option>
 </select>		
 <input type="button" id="clear_btn" value="清空"  onclick="clearForm()"/>
 <input type="button" id="query_btn" value="查询"  onclick="queryForm()"/>
 		</div> 
		<table  border="0" cellspacing="1" cellpadding="0" class="PrDyBackTable">
		<tr>
			<th width="15%">项目名称</th>
			<th width="15%">类型</th>
			<th width="15%">标题</th>
			<th width="15%">创建人</th>
			<th width="15%">创建时间</th>
			<th width="15%">文件名</th>
			<th width="15%">操作</th>
		</tr>
			<c:forEach items="${tcprojectAfterList }" var="pa">
				<tr>
					<td>${pa.projectName }</td>
					<td>
					<c:if test="${pa.paTypeId ==1}">年度报表</c:if>
					<c:if test="${pa.paTypeId ==2}">季度报表</c:if>
					<c:if test="${pa.paTypeId ==3}">重大事件披露</c:if>
					</td>
					<td>${pa.paTitle }</td>
					<td>${pa.creatorName }</td>
					<td>
					<fmt:formatDate value="${pa.createTime}" pattern="yyyy-MM-dd HH:mm" />
					</td>
					<td>
					<a href="${ctx}/servlet/DowFileByName?filePath=${pa.filePath}&fileName=${pa.fileName}" >
							${pa.fileName}
					</a>
						</td>
					<td>
						
						
						<a href="${ctx}/crowdfunding/tcprojectAfter/projectAfterEdit.ht?afterId=${pa.afterId }">
							<img src="${ctx }/crowdfunding/Skin/Default/images/editIcont3.png">
						</a>
						<a href="javascript:void(0);" onclick="del(${pa.afterId })">
							<img id="img_del" src="${ctx }/crowdfunding/Skin/Default/images/deleteIcont.png">
						</a>
					</td>
				</tr>
			</c:forEach>

		</table>
		
		<pageTag:paging form="pageForm"/>
	</div>
</body>
<script type="text/javascript">

			//function add(){
			//	window.location.href="${ctx}/crowdfunding/tcprojectAfter/projectAfterForm.ht";
			//}
			
			function queryForm(){
				
				$("#pageForm").submit();
			}
			function clearForm(){
				
				$("#projectName").val("");
				$("#paTitle").val("");
				$("#paTypeId").val("");
			}
	  		function del(afterId) { 
	  			if(confirm("你确定要删除")){
			$.ajax({
					url : "${ctx}/crowdfunding/tcprojectAfter/projectAfterDel.ht?afterId="+afterId,
					type : 'post',
					success : function(data) {
						alert(data);
						window.location.reload();
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
					}
			});
	  			}
		}
</script>
</html>