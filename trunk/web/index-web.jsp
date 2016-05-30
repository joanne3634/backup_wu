<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="UTF-8">
<meta name="renderer" content="webkit"/>
<title><%=application.getAttribute("PLATFORM_NAME")%> - 首页</title>
<%@ include file="/crowdfunding/cssorjs.jsp"%>
<script type="text/javascript">
	if (top != this) {//当这个窗口出现在iframe里，表示其目前已经timeout，需要把外面的框架窗口也重定向登录页面
		top.location = '${ctx}/index-web.jsp';
	}
</script>
</head>
<body>
	<%@ include file="/crowdfunding/head.jsp"%>
	<div class="advertisement" >
		<pageTag:AdvertisingPicture menupath="SYGGDT" />
	</div>
	<div class="content">
		<pageTag:hotProjects menupath=""/><!--热门项目  -->
		<pageTag:newProjectsStatus menupath=""/><!-- 最新项目动态 -->
		<pageTag:IndustryInformation menupath="HYZX"/><!--最新资讯 -->
		
		<%-- <pageTag:RecommendProject menupath="projectRecommend"/><!-- 投资推荐 --> --%>
		
		<%-- <pageTag:newProjects menupath=""/><!-- 最新项目 --> --%>
		
		
		
		
		
		<%-- <pageTag:goodProjects menupath=""/><!-- 成功案例 --> --%>
		<div class="case clear">
			<h3><img src="${ctx }/crowdfunding/Skin/Default/images/trianglegray.png">众筹指南<a href="./innovationProject.html">查看更多</a></h3>
			<div class="flow">
				<img src="${ctx }/crowdfunding/Skin/Default/images/News4.png">
				<span><a href="${ctx }/loan/aboutus/HelpCenterList.ht" target="_blank">项目融资规则</a>
					  <span>创业者必看融资攻略</span>
				</span>
				<img src="${ctx }/crowdfunding/Skin/Default/images/indexIcont.png">
				<img src="${ctx }/crowdfunding/Skin/Default/images/user2.png">
				<span><a href="${ctx }/loan/aboutus/HelpCenterList.ht"  target="_blank">投资人投资指南</a>
					  <span>投资人的投资向导 天使投资那些事</span>
				</span>
				<img src="${ctx }/crowdfunding/Skin/Default/images/indexIcont.png">
				<img src="${ctx }/crowdfunding/Skin/Default/images/download.png">
				<span><a href="${ctx }/loan/aboutus/ZYXZDetails.ht"  target="_blank">有限合伙协议模板下载</a>
					  <a href="${ctx }/loan/aboutus/ZYXZDetails.ht"  target="_blank">众筹转让协议模板下载</a>
			</span>
	</div>
		</div>
		
		<pageTag:CooperationUnit menupath="HZJG"/><!-- 合作机构 -->
		
	</div>
	
	<%@ include file="/crowdfunding/foot.jsp"%>
	
	<script type="text/javascript">
		 
		$(function() {
			$("#kinMaxShow").kinMaxShow(
							{
								//设置焦点图高度(单位:像素) 必须设置 否则使用默认值 500
								height : 350,
								intervalTime:2,
								//设置焦点图 按钮效果
								button : {
									showIndex : false,
									normal : {
										background : 'url(${ctx }/crowdfunding/Skin/Default/images/button.png) no-repeat -14px 0',
										marginRight : '8px',
										border : '0',
										right : '50%',
										bottom : '20px'
									},
									focus : {
										background : 'url(${ctx }/crowdfunding/Skin/Default/images/button.png) no-repeat 0 0',
										border : '0'
									}
								}
							});
		});
	</script>
</body>
</html>