<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>项目评论</title>
	<meta name="renderer" content="webkit"/>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   	<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
   	<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/innovationProject.css">
</head>
<body>
	<div class="PrDyBack f_l">
		<div class="ProjectReview">
		<h2><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">项目评论</h2>
		<form action="" name="pageForm" id="pageForm">
				<div class="commentsList">
				<c:if test="${size == 0}">
					<h3 class="ProjectReviewH3">对不起，你暂时没有项目。</h3>
				</c:if>
				<c:if test="${size != 0}">
				<c:forEach items="${TPCList }" var="list">
					<h3 class="ProjectReviewH3">${list.pname }</h3>
					<ul>
						<pageTag:ProjectComments menupath="${list.projectId}"/>
					</ul>
				</c:forEach>
				<pageTag:paging form="pageForm"/>
				</c:if>
				</div>
				
				</form>
		</div>
	</div>
	<script type="text/javascript">
	function reply(id){
		var url='${ctx}/tcproject/ProjectComments/ProjectCommentsDetails.ht?commentsId='+id;
		$.dialog.open(url, {
			title: '评论详情',lock:true,width:'800px',height:'600px',close:function(){
				 window.location.reload(true);
			 }
		});
	}
	function del(id) { 
		$.ajax({
				url : "${ctx}/tcproject/ProjectComments/delete.ht",
				type : 'post',
				data : {commentsId:id},
				success : function(data) {
					if(data=='1'){
						window.parent.openDialog("操作失败!","30%","30%");
						setTimeout('window.location= "${ctx}/tcproject/ProjectComments/ProjectCommentsicList.ht";',2000);
					}else{
						window.parent.openDialog("操作成功!","30%","30%");
						setTimeout('window.location= "${ctx}/tcproject/ProjectComments/ProjectCommentsicList.ht";',2000);
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
				}
		});
	}
	</script>
</body>
</html>
