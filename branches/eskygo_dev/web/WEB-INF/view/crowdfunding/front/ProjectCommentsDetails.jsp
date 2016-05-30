<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>项目评论详情</title>
	<meta name="renderer" content="webkit"/>
	<%@ include file="/commons/includeFront/javascripts.jsp"%>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   	<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
   	<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/innovationProject.css">
</head>
<body>
	<div class="PrReDetails">
		<h3>项目评论详情</h3>
		<div class="commentsList">
					<ul>
						<li>
							<div class="commentsListLeft f_l">
<%-- 							<img src="${ctx }/crowdfunding/Skin/Default/images/headportrait2.png"> --%>
							<c:if test="${not empty user.myPhoto }">
								<img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${user.myPhoto}">
							</c:if>
							<c:if test="${empty user.myPhoto }">
								<img src="${ctx }/crowdfunding/resources/img/head_blank.png">
							</c:if>
							</div>
							<div class="commentsListRight f_l">
								<div class="commentscontent">
								<span>
								<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${tcprojectComments.creator }"/>：
								</span>${tcprojectComments.pccontent }</div>
								<div class="commentsTime">
								评论于&nbsp;&nbsp;<fmt:formatDate value="${tcprojectComments.creteTime }" pattern="yyyy-MM-dd HH:MM"/>&nbsp;&nbsp;|&nbsp;&nbsp;
								<img src="${ctx }/crowdfunding/Skin/Default/images/replyIcont2.png">
								<span class="ProjectReviewReply">回复</span>&nbsp;&nbsp;&nbsp;&nbsp;
<%-- 								<img src="${ctx }/crowdfunding/Skin/Default/images/deleteIcont2.png"> --%>
<%-- 								<span class="ProjectReviewDelete" onclick="del(${tcprojectComments.commentsId })">删除</span> --%>
									<div class="commentsText">
										<textarea class="commentsTextarea2" id="content"></textarea>
										<span class="commentsSpan" onclick="reply(${tcprojectComments.commentsId},${tcprojectComments.projectId})">回复</span>
									</div>
								</div>
								<c:forEach items="${TPCList }" var="list">
								<div class="commentsReply">
									<div class="commentsReplyLeft f_l">
<%-- 									<img src="${ctx }/crowdfunding/Skin/Default/images/headportrait2.png"> --%>
										<pageTag:ProjectCommentsDetail menupath="${list.creator}"/>
									</div>
									<div class="commentsReplyRight f_l">
										<div class="commentscontent"><span>
										<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${list.creator }"/>：
										</span>${list.pccontent }</div>
										<div class="commentsTime">
										回复于&nbsp;&nbsp;<fmt:formatDate value="${list.creteTime }" pattern="yyyy-MM-dd HH:mm"/>&nbsp;&nbsp;&nbsp;&nbsp;
										<img src="${ctx }/crowdfunding/Skin/Default/images/deleteIcont2.png">
										<span class="ProjectReviewDelete" onclick="del(${list.commentsId })">删除</span></div>
									
									</div>
									<div class="clear"></div>
								</div>
								</c:forEach>
<!-- 								<form action="" name="pageForm" id="pageForm"> -->
<%-- 									<pageTag:paging form="pageForm"/> --%>
<!-- 								</form> -->
								</div>
							<div class="clear"></div>
						</li>
					</ul>
				</div>
	</div>
	<script type="text/javascript">
	$(function(){
// 		$('.PrReDetails .ProjectReviewDelete').click(function(){
// 			$(this).parent().parent().parent().remove();
// 		});
		$(".PrReDetails .ProjectReviewReply").click(function(){
			$(this).parent().find(".commentsText").toggle();
		});
	})
	
	function closediv(){
		var list = window.parent.art.dialog.list;
		for (var i in list) {
		    list[i].close();
		};
	}
	
	function reply(id,pid){
		var content=$("#content").val();
		if(content == ""){
			openDialog("请填写回复内容!");
			return ;
		}else{
			var url='${ctx}/tcproject/ProjectComments/ProjectCommentsReply.ht';
			$.ajax({
				url : url,
				type : 'post',
				data : {commentsId:id,projectId:pid,pccontent:content},
				success : function(data) {
					if(data=='1'){
						openDialog("操作失败!");
					}else{
						openDialog("操作成功!");
						closediv();
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
				}
			});
		}
	}
	
	function del(id) { 
		$.ajax({
				url : "${ctx}/tcproject/ProjectComments/delete.ht",
				type : 'post',
				data : {commentsId:id},
				success : function(data) {
					if(data=='1'){
						openDialog("操作失败!","30%","30%");
						setTimeout('window.location.reload(true);',2000);
					}else{
						openDialog("操作成功!","30%","30%");
						setTimeout('window.location.reload(true);',2000);
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
				}
		});
	}
	</script>
</body>
</html>
