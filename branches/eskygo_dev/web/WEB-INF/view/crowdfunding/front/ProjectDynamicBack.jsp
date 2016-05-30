<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>会员后台-项目动态</title>
	<meta name="renderer" content="webkit"/>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
    <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/ProjectDynamic.css">
    <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
</head>

<body>
	<div class="PrDyBack f_l">
		<h2><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">项目动态</h2>
		<form action="${ctx }/tcproject/ProjectDynamic/ProjectDynamicBackList.ht"   name="pageForm" id="pageForm" method="post">
		<div class="PrDyBackList">
		<c:if test="${size == 0}">
			<h4 class="PrDyBackListH4" style="border-bottom:0px;"><em>对不起，你暂时没有参加项目！！！</em></h4>
		</c:if>
		<c:if test="${size != 0}">
		<c:forEach items="${TCPList2 }" var="list">
			<h4 class="PrDyBackListH4"><span class="f_r" onclick="save(${list.projectId})">添加动态</span>项目名称：<em>${list.pname }</em></h4>
			<div class="ProjectDynamicLeft">
			<ul>
			<c:forEach items="${TCPList }" var="list2">
			<c:if test="${list.projectId == list2.projectId}">
				<li><a href="${ctx }/tcproject/ProjectDynamic/edit.ht?newsId=${list2.newsId }" target="_Blank">
					<c:if test="${not empty list.fileId}">
						<pageTag:ProjectDynamic menupath="${list.fileId}"/>   <!-- 项目图片  -->
					</c:if>
					<c:if test="${empty list.fileId}">
						<pageTag:ProjectDynamic menupath="${list2.fileId}"/>   <!-- 项目动态图片  -->
					</c:if>
					<c:if test="${empty list2.fileId &&empty list.fileId}">
						<img class="f_l" style="border: 1px solid #ccc6c6;" width="222" height="130" src="${ctx }/crowdfunding/Skin/Default/images/zwtp1.jpg"/>   <!-- 默认图片 -->
					</c:if>
					</a>
					<div class="ProjectDynamicName f_l">
						<h4><a title="${list2.pntitle }" href="${ctx }/tcproject/ProjectDynamic/edit.ht?newsId=${list2.newsId }" target="_Blank">
							<c:if test="${fn:length(list2.pntitle) > 20 }">
								${fn:substring(list2.pncontent,0,20) }...
							</c:if>
							<c:if test="${fn:length(list2.pntitle) <= 20 }">
								${list2.pntitle }
							</c:if>
						</a></h4>
						<p>
						<c:if test="${fn:length(list2.pncontent) > 105 }">
								${fn:substring(list2.pncontent,0,105) }...
							</c:if>
							<c:if test="${fn:length(list2.pncontent) <= 105 }">
								${list2.pncontent }
							</c:if>
						<a href="${ctx }/tcproject/ProjectDynamic/edit.ht?newsId=${list2.newsId }" target="_Blank">[详细]</a>
						</p>
						<p><img src="${ctx }/crowdfunding/Skin/Default/images/time.png">
						发布时间：<fmt:formatDate value="${list2.createTime }" pattern="yyyy-MM-dd HH:mm"/>
						<span>
						发布者：<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${list2.creator }"/>
						</span>
						</p>
						<p class="itemSettingButton">
							<span class="editSpan" onclick="edit(${list2.newsId },${list2.projectId })">
							修改动态
							</span>
							<span class="deleteSpan" onclick="del(${list2.newsId })">
							删除动态
							</span>
						</p>
					</div>
					<div class="clear"></div>
				</li>
				</c:if>
			</c:forEach>
			</ul>
			
			
			</div>
		</c:forEach>
		</c:if>
		</div>
		<pageTag:paging form="pageForm"/>
		</form>
		
	</div>
</body>
<script type="text/javascript">
function save(id){
	var url='${ctx }/tcproject/ProjectDynamic/editProjectDynamic.ht?projectId='+id;
	$.dialog.open(url, {
	title: '添加动态',lock:true,width:'940px',height:'650px',close:function(){
		window.location.reload(true);
	}
	});
}

function edit(id,pid){
	var url='${ctx }/tcproject/ProjectDynamic/editProjectDynamic.ht?newsId='+id+'&projectId='+pid;
	$.dialog.open(url, {
	title: '修改动态',lock:true,width:'940px',height:'650px',close:function(){
	 window.location.reload(true);
	 }
	});
}

 function del(id) { 
	 art.dialog.confirm("您确定删除吗",function(){
	$.ajax({
			url : "${ctx}/tcproject/ProjectDynamic/delete.ht",
			type : 'post',
			data : {newsId:id},
			success : function(data) {
				if(data=='1'){
					window.parent.openDialog("删除失败");
					//setTimeout(2000);
				}else{
					window.parent.openDialog("删除成功");
					setTimeout('window.location= "${ctx}/tcproject/ProjectDynamic/ProjectDynamicBackList.ht"',2000);
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
			}
	});
	 },function(){});
}
</script>
</html>




