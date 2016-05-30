<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>我要理财</title>
<%@ include file="/commons/includeFront/javascripts.jsp"%>

<script type="text/javascript">
function locationPage(p){
	var parent = window.parent;
	parent.window.location = p;
}
//parent.window.l
</script>
</head>
<body>
<form id="pageForm" name="pageForm" action="${ctx }/tenderProjects/getTenderProjectsListPage.ht">
		<ul class="pro-rel">
			<li class="pro-rel-tit"><span class="w240">标题</span> <span
				class="w95">信用等级</span> <span class="w160">借款金额</span> <span
				class="w120">预计年化率</span> <span class="w85">借款期限</span> <span
				class="w135">进度</span> <span class="w120">操作</span></li>
			<c:forEach var="project" items="${projects}">
				<li class="pro-rel-ite"><span class="pro-rel-ite-tit" >
				<a href="javascript:;" onclick="locationPage('${ctx}/project/showProjectDetail.ht?projectId=${project.projectId}&applicationId=${project.papplicant}');">${project.pname}</a></span> <span
					class="pro-rel-ite-huankuanfangshi pro-rel-ite-gg"> <img
						src="${ctx}/images/renzhengdengji-pic.png" alt="">
				</span> <span class="pro-rel-ite-jiekuanjine pro-rel-ite-gg fs16 color-main">${project.ploan}</span>
					<span class="pro-rel-ite-nianhualv pro-rel-ite-gg fs16 color-main">${project.prateOut}%</span>
					<span class="pro-rel-ite-qixian pro-rel-ite-gg">${project.pdeadline}个月</span>
					<span class="w135 pro-rel-ite-jindu pro-rel-ite-gg">
						<div style="position: relative; top: 8px; display: inline-block; width: 90px; height: 10px; margin-right: 10px; border-radius: 5px; background-color: #dadada;">
							<div style="position: relative; top: -9px; display: inline-block; width: ${project.pcomplete}%; height: 10px; border-radius: 5px; background-color: #6db900;"></div>
						</div>${project.pcomplete}%
				</span> <span class="w80 pro-rel-ite-caozuo"><a href="javascript:;" onclick="locationPage('${ctx}/project/showProjectDetail.ht?projectId=${project.projectId}&applicationId=${project.papplicant}');"></a></span></li>
			</c:forEach>
		</ul>
		<input type="hidden" name="lastUpdateTime" id="lastUpdateTime_id" value="${lastUpdateTime }"/>
		<pageTag:paging form="pageForm"/>
</form>
</body>
</html>