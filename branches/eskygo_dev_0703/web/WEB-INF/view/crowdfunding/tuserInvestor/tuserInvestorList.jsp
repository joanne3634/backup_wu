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
	<title><%=application.getAttribute("PLATFORM_NAME")%> - 投资人列表</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/tuserInvestorList.css" />" type="text/css">

	<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
</head>
<body>
 <form id="pageForm" name="pageForm" action="${ctx }/crowdfunding/tcuserInvestor/tcuserInvestorPageList.ht">
	        <div class="all-100">
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
											<c:if test="${curuser.groupId eq 1}">
												<button onclick="window.parent.loadPageszijianMyProject('${list.userId }')" class="ink-button blue-dark btn-median">自荐项目</button>
											</c:if>
										</li>
									</ul>
								</div>
							</div>
						</li>	        		
	        		</c:forEach>
	        	</ul>
					<pageTag:pagination form="pageForm"/>
	        </div>
	        </form>
</body>
</html>