<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang=""> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title><%=application.getAttribute("PLATFORM_NAME")%> - 搜索页面</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/likeInvestorProList.css" />" type="text/css">
	<script type="text/javascript">
		<%--if (top != this) {--%>
		<%--//当这个窗口出现在iframe里，表示其目前已经timeout，需要把外面的框架窗口也重定向登录页面--%>
		<%--top.location = '${ctx}/index-web.jsp';--%>
		<%--}--%>
	</script>
</head>
<body>
<%@ include file="/crowdfunding/head-v2.jsp"%>
<div class="ink-grid push-center all-90">
		<div id="content">
				<h3>项目信息</h3>
			<c:if test="${not empty ListVo }">
			<ul id="financingProList">
				<c:forEach items="${ListVo}" var="vo">
					<li>
						<div class="item">
				<span class="img-container">
					<a href="${ctx}/crowdfunding/front/toProDetails.ht?projectId=${vo.projectId}" target="_blank">
						<c:choose>
							<c:when test="${empty vo.ppic}">
								<img src="${ctx }/crowdfunding/Skin/Default/images/case3.png">
							</c:when>
							<c:otherwise>
								<pageTag:projectPic menupath="${vo.projectId}"/>
							</c:otherwise>
						</c:choose>
					</a>
				</span>
							<div class="project-info">
								<p class="title"><a href="${ctx}/crowdfunding/front/toProDetails.ht?projectId=${vo.projectId}" target="_blank">${vo.pname}</a></p>
								<p>融资金额：<em>${vo.pfinancingAmount }</em>万</p>
								<p>出让股份：<em>${vo.psharesPercent }%</em></p>
								<c:choose>
									<c:when test="${vo.pneedWarmUp==0}">
										<p>认投金额：<em>${vo.pinvestAmount }</em>万</p>
										<p>认投完成率：<em>${vo.pcomplete }%</em></p>
									</c:when>
								</c:choose>
							</div>
						</div>
						<div class="filter-info">
							<span class="all-33"><i class="fa fa-map-marker"></i> ${vo.pprovincesName }${vo.pcityIname }</span>
							<span class="all-33 align-center"><i class="fa fa-list-ul"></i> <f:description nodeKey="PIND"  itemValue="${vo.pindustry }"/></span>
				<span class="all-33 align-right"><i class="fa fa-sun-o">
					<input type="hidden" value="${vo.pstateId}" />
				</i>
					<c:if test="${vo.pneedWarmUp==0}">
						<c:choose>
							<c:when test="${vo.pstateId==3}">
								众筹中
							</c:when>
							<c:when test="${vo.pstateId==4 ||vo.pstateId==5||vo.pstateId==6}">
								融资成功
							</c:when>
							<c:when test="${vo.pstateId==1}">
								已提交
							</c:when>
						</c:choose>
					</c:if>
					<c:if test="${vo.pneedWarmUp==1}"> 预热中</c:if>
				</span>
						</div>
						<div class="desc" title="${vo.pdetail}">项目简介：${vo.pdetail}</div>
						<div class="date">
							<span class="release">开标时间：${vo.popenDateStr}</span>
							<span class="new">最新更新时间：<fmt:formatDate value="${vo.updateTime }" pattern="yyyy-MM-dd HH:mm"/></span>
						</div>
					</li>
				</c:forEach>
			</ul>
			</c:if>
			<c:if test="${empty ListVo}"><div class="hint">没有搜索到项目信息 </div></c:if>
				<h3>投资人信息</h3>

			<c:if test="${not empty investorList}">
				<ul id="investorList">
					<c:forEach items="${investorList }" var="list">
						<li class="investorInfo">
							<div class="item">
								<div class="img-container all-20">
										<%--<img src="${ctx }/crowdfunding/Skin/Default/images/headportrait3.png">--%>

									<c:if test="${not empty list.myPhoto }">
										<img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${list.myPhoto}">
									</c:if>
									<c:if test="${empty list.myPhoto }">
										<img src="${ctx }/crowdfunding/resources/img/head_blank.png">
									</c:if>
								</div>
								<div class="detailInfo all-60">
									<c:if test="${list.isCompany eq 0 }">
										<c:set value="${list.realName }" var="name_set" property="name_set"/>
									</c:if>
									<c:if test="${list.isCompany eq 1 }">
										<c:set value="${list.contactName }" var="name_set" property="name_set"/>
									</c:if>
									<p title="${list.loginName}" <c:if test="${list.isLeader == 1 }">style="cursor: pointer;" onclick="window.parent.loadPagesDetails('${list.userId }','${list.loginName }')"</c:if>>
											${list.loginName }

										<c:if test="${list.isLeader eq 1 }">  <!-- 是否领投人 -->
											<img src="${ctx }/images/lingtouren.png" title="领投人"/>
										</c:if>
										<c:if test="${list.isCompany eq 1 }">
											<img title="投资机构" src="${ctx }/crowdfunding/Skin/Default/images/touzijigou.png">
										</c:if>
										<c:if test="${list.isAskPrice eq 1 }">  <!-- 是否询价 -->
											<img src="${ctx }/images/xunjia.jpg" title="询价认证资格"/>
										</c:if>
										<c:if test="${list.bindIdno eq 1 }">  <!-- 是否实名认证 -->
											<img src="${ctx }/images/shimingyanzheng.png" title="实名认证会员"/>
										</c:if>
									</p>
									<p title="${list.remarks}">
											${list.remarks}
									</p>
									<p>
										<h:getArea areaId="${list.provincesId }"></h:getArea>
										<h:getArea areaId="${list.cityId }"></h:getArea>
									</p>
								</div>
								<div class="operations all-20">
									<ul>
										<li>
											<button onclick="window.parent.loadPagesSendMsgremind('${list.userId}')" class="ink-button blue-dark btn-median">发私信</button>
										</li>
										<li>
											<c:if test="${list.isLeader == 1 }">  <!-- 领头人才有详细显示 -->
												<button onclick="window.parent.loadPagesDetails('${list.userId }','${name_set }')" class="ink-button blue-dark btn-median">详细资料</button>
											</c:if>
										</li>
										<li>
												<button onclick="window.parent.loadPageszijianMyProject('${list.userId }')" class="ink-button blue-dark btn-median">自荐项目</button>
										</li>
									</ul>
								</div>
							</div>
						</li>
					</c:forEach>
				</ul>
			</c:if>
			<c:if test="${empty investorList}"><div class="hint">没有搜索到投资人信息 </div></c:if>
		</div>
</div>
<%@ include file="/crowdfunding/footer-v2.jsp"%>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/likeInvestorProList.js" />"></script>
</body>
</html>

