<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>项目动态</title>
	<meta name="renderer" content="webkit"/>
  	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/ProjectDynamic.css">
<script type="text/javascript">
$(function(){
	$(".cl").each(function(e,index){
		var val=$(this).html().trim();
		var _length=val.length;
		var val2 =""; 
		if(_length>80){
  			for(var   i=0;   i<90;   i++)   val2   +=   val[i];   
				val2 = val2+"..."; 
				$(this).html(val2);
		}
	});
})
</script>
</head>
<body>
	<!-- <div style="height:191px;overflow: hidden;">
	</div> -->
		<%@ include file="/crowdfunding/head.jsp"%>
	<div class="window">
	<div class="PrDyLeft">
		<div class="ProjectDynamicLeft f_l">
			<h3 class="clear"><img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont.png">项目动态</h3>
			<form action="${ctx }/tcproject/ProjectDynamic/ProjectDynamicList.ht" name="pageForm" id="pageForm">
			<ul>
			<c:forEach items="${TCPList}" var="list">
            	<li>
            		<a href="${ctx }/tcproject/ProjectDynamic/edit.ht?newsId=${list.newsId }" target="_Blank" style="color:red;">
<%-- 						<pageTag:ProjectDynamic menupath="${list.fileId}"/> --%>
						<c:if test="${not empty list.fileId}">
							<pageTag:ProjectDynamicDetail menupath="${list.fileId}"/>
						</c:if>
						<c:if test="${empty list.fileId && not empty list.pic}">
							<pageTag:ProjectDynamicDetail menupath="${list.pic}"/>
						</c:if>
						<c:if test="${empty list.fileId && empty list.pic}">
							<img class="f_l PrDyImg"  src="${ctx }/crowdfunding/Skin/Default/images/zwtp1.jpg"/>
						</c:if>
					</a>
					<div class="ProjectDynamicName f_l">
						<h4><a title="${list.pntitle }" href="${ctx }/tcproject/ProjectDynamic/edit.ht?newsId=${list.newsId }" target="_Blank" style="color:red;">
							<c:if test="${fn:length(list.pntitle) > 17 }">
								${fn:substring(list.pntitle,0,17) }...
							</c:if>
							<c:if test="${fn:length(list.pntitle) <= 17 }">
								${list.pntitle }
							</c:if>
						</a></h4>
						<div>
							<img src="${ctx }/crowdfunding/Skin/Default/images/trianglegray.png">
							项目:【<a href="${ctx}/crowdfunding/front/toProDetails.ht?projectId=${list.projectId }" target="_Blank" style="color:red;">${list.pname }</a>】
							<span>
							<c:if test="${empty projectId}">
							    <a href="${ctx }/tcproject/ProjectDynamic/ProjectNewList.ht?projectId=${list.projectId }" target="_Blank" style="color:red;">&gt;&gt;本项目所有动态</a>
							</c:if>
							</span>
						</div>
						<p style="line-height: 25px;">
							<span class="cl">
							<c:if test="${fn:length(list.pncontent) > 60}">
								${fn:substring(list.pncontent,0,60) }...
							</c:if>
							<c:if test="${fn:length(list.pncontent) <= 60 }">
								${list.pncontent }
							</c:if>
							</span>
						<a href="${ctx }/tcproject/ProjectDynamic/edit.ht?newsId=${list.newsId }" target="_Blank" style="color:red;">[详细]</a>
						</p>
						<p>
						<img src="${ctx }/crowdfunding/Skin/Default/images/time.png">
						发布时间：<fmt:formatDate value="${list.createTime }" pattern="yyy-MM-dd HH:mm"/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						发布者：<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${list.creator }"/></p>
					</div>
					<div class="clear"></div>
				</li>
            </c:forEach>
			</ul>
			
			<pageTag:paging form="pageForm"/>
			</form>
		</div>
</div>
		<div class="investmessageRight f_l">
			<div class="clear ">
				<h4><span>热门项目动态</span></h4>
				<ul>
					<c:forEach items="${TCPList2}" var="list" varStatus="i">
						<c:if test="${i.index < 10 }">
							<li><img src="${ctx }/crowdfunding/Skin/Default/images/go.png">
								<a title="${list.pntitle }" href="${ctx }/tcproject/ProjectDynamic/edit.ht?newsId=${list.newsId }" target="_Blank" style="color:red;">
									${list.pntitle }
								</a>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	<div class="clear" style="height:130px;overflow: hidden;">
		<%@ include file="/crowdfunding/foot.jsp"%>
	</div>
</body>
</html>