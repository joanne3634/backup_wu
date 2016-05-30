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
	<title><%=application.getAttribute("PLATFORM_NAME")%> - 投资人</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/tuserInvestor.css" />" type="text/css">

	<%--<meta charset="UTF-8">
	<meta name="renderer" content="webkit"/>
	<title>投资人</title>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
	<meta name="renderer" content="webkit"/>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/investor.css">--%>
</head>
<script type="text/javascript">

</script>
<body>
<%@ include file="/crowdfunding/head-v2.jsp"%>
<div id="wholeContent" class="ink-grid push-center all-90">
	<div class="column-group horizontal-gutters">
		<div class="leftInvestor all-70">
			<div class="upInvestor all-100">
				<dl>
					<dt>投资人类型</dt>
					<dd><a class="active" href="javascript:;" onclick="loadPages('quanbu',1)">全部</a>
						<a href="javascript:;" onclick="loadPages('isCompanyAndLeader',1)">机构</a>
						<a href="javascript:;" onclick="loadPages('isLeader_yes',1)">领投人</a>
						<a href="javascript:;" onclick="loadPages('isLeader_no',1)">跟投人</a>
					</dd>
					<dt>按所属城市</dt>
					<dd>
						<a class="active" href="javascript:;" onclick="loadPages('quanbu',2)">全部</a>
						<c:forEach items="${areaisRecommendedlist }" var="list" begin="0" end="6">
							<a href="javascript:;" onclick="xuanzeCity(this,'${list.areaId}',2)">${list.areaName }</a>
						</c:forEach>
						<!--
                                        <a href="javascript:void(0);">广州市</a>
                                        <a href="javascript:void(0);">北京市</a>
                                        <a href="javascript:void(0);">上海市</a>
                                        <a href="javascript:void(0);">杭州市</a>
                                        <a href="javascript:void(0);">苏州市</a>
                                        <a href="javascript:void(0);">厦门市</a> -->
						<a href="javascript:;" onclick="$('#a3').val('');loadPages('quanbu',4);">其他</a>
						<select id="FProvincesId">
							<option value="请选择省">请选择省</option>
							<c:forEach items="${arealist }" var="list">
								<option value="${list.areaId }">${list.areaName }</option>
							</c:forEach>
						</select >
						<select id="FCityId" onchange="loadPages('FCityId',4)"><option>请选择市</option></select>
					</dd>
				</dl>
				<input type="hidden" id="a1">
				<input type="hidden" id="a2">
				<input type="hidden" id="a3">
				<input type="hidden" id="a4">
			</div>
			<div id="iframe-container" class="all-100">
				<iframe src="${ctx }/crowdfunding/tcuserInvestor/tcuserInvestorPageList.ht"  marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height=100% id="iframepage" name="iframepage" onLoad="iFrameHeight()" ></iframe>
			</div>
		</div>
		<div class="rightInvestor all-30">
			<h4>推荐投资人</h4>
			<ul>
				<c:forEach items="${tuserisRecommendedlist }" var="list" varStatus="i">
				<c:if test="${i.index < 1 }">
				<li>
					<div class="item">
						<div class="img_container all-30">
							<%--<img src="${ctx }/crowdfunding/resources/img/head_blank.png">--%>
							<c:if test="${not empty list.myPhoto }">
								<img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${list.myPhoto}">
							</c:if>
							<c:if test="${empty list.myPhoto }">
								<img src="${ctx }/crowdfunding/resources/img/head_blank.png">
							</c:if>
						</div>
						<div class="info  all-70">
							<p title="${list.loginName}">
								${list.loginName}


								<c:if test="${list.isLeader == 1 }">  <!-- 是否领投人 -->
									<img src="${ctx }/images/lingtouren.png" title="领投人"/>
								</c:if>
								<c:if test="${list.isCompany eq 1 }">
									<img title="投资机构" src="${ctx }/crowdfunding/Skin/Default/images/touzijigou.png">
								</c:if>
								<c:if test="${list.isAskPrice == 1 }">  <!-- 是否询价 -->
									<img src="${ctx }/images/xunjia.jpg" title="询价认证资格"/>
								</c:if>
								<c:if test="${list.bindIdno == 1 }">  <!-- 是否实名认证 -->
									<img src="${ctx }/images/shimingyanzheng.png" title="实名认证会员"/>
								</c:if>
							</p>
							<p title="${list.remarks}">
								${list.remarks}
							</p>
							<p>
								<button onclick="loadPagesSendMsgremind('${list.userId}')" class="ink-button blue-dark btn-small">发私信</button>
								<c:choose>
									<c:when test="${curuser.groupId eq 1}">
										<button onclick="window.parent.loadPageszijianMyProject('${list.userId }')" class="ink-button blue-dark btn-small">自荐项目
											</button>
									</c:when>
									<c:otherwise>

									</c:otherwise>
								</c:choose>
							</p>
						</div>
					</div>
				</li>
				</c:if>
				</c:forEach>
			</ul>

			<h4>最新投资人</h4>
			<ul>
				<c:forEach items="${tuserList }" var="list" varStatus="i">
				<c:if test="${i.index < 6 }">
				<li>
					<div class="item">
						<div class="img_container all-30">
							<%--<img src="${ctx }/crowdfunding/resources/img/head_blank.png">--%>
							<c:if test="${not empty list.myPhoto }">
								<img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${list.myPhoto}">
							</c:if>
							<c:if test="${empty list.myPhoto }">
								<img src="${ctx }/crowdfunding/resources/img/head_blank.png">
							</c:if>
						</div>
						<div class="info  all-70">
							<p title="${list.loginName}">
									${list.loginName}
							</p>
							<p title="${list.remarks}">
									${list.remarks}
							</p>
							<p>
								<button onclick="loadPagesSendMsgremind('${list.userId}')" class="ink-button blue-dark btn-small">发私信</button>
								<c:choose>
									<c:when test="${curuser.groupId eq 1}">
										<button onclick="window.parent.loadPageszijianMyProject('${list.userId }')" class="ink-button blue-dark btn-small">自荐项目
											</button>
									</c:when>
									<c:otherwise>

									</c:otherwise>
								</c:choose>
							</p>
						</div>
					</div>
				</li>
				</c:if>
				</c:forEach>
			</ul>
		</div>
	</div>
</div>
<%@ include file="/crowdfunding/footer-v2.jsp"%>
<%@ include file="/crowdfunding/globaljs.jsp"%>
	<script src="<h:static type="js" src="/crowdfunding/resources/js/tuserInvestor.js" />"></script>
</body>
</html>
