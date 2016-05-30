<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<%
	TUser user = TUserUtil.getLogUser(request);
%>
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang=""> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>跟投的项目</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/perCenterTabBase.css" />" type="text/css">
	<script type="text/javascript">
		var _ctx="${ctx}", isLogin,  groupId = '${user.groupId}';
	</script>
</head>
<body class="iframe">
<div id="leadProj" class="all-100">
	<c:if test="${not empty voteProjectInfos }">
		<ul class="projectList">
			<c:forEach var="voteProjectInfo" items="${voteProjectInfos}">
				<li>
					<div class="detail">
						<div class="avatar">
							<c:if test="${empty voteProjectInfo.myPhoto}">
								<img src="${ctx }/crowdfunding/resources/img/head_blank.png">
							</c:if>
							<c:if test="${not empty voteProjectInfo.myPhoto}">
								<img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${voteProjectInfo.myPhoto}">
							</c:if>
							<button onclick="sendMessage('${voteProjectInfo.creator}','${voteProjectInfo.projectId}');" class="ink-button blue"><i class="fa fa-plus"></i> 发私信</button>
						</div>
						<div class="info">
							<h4 class="title"><a href="${ctx }/crowdfunding/front/toProDetails.ht?projectId=${voteProjectInfo.projectId}" target="_blank">${voteProjectInfo.pname}</a></h4>
							<label class="status red"><f:description itemValue="${voteProjectInfo.pstateId}" nodeKey="xmzt" /></label>
							<c:if test="${voteProjectInfo.piisPay == 0 || voteProjectInfo.piisPay == '0'}">
								<label class="status red">未付款</label>
							</c:if>
							<c:if test="${voteProjectInfo.piisPay == 1 || voteProjectInfo.piisPay == '1'}">
								<label class="status red">已付款</label>
							</c:if>
							<c:if test="${voteProjectInfo.piisPay == 2 || voteProjectInfo.piisPay == '2'}">
								<label class="status red">已退款</label>
							</c:if>
							<div class="filter-info">
								<span><i class="fa fa-map-marker"></i> ${voteProjectInfo.pprovincesName }<c:if test="${voteProjectInfo.pcityIname!='市辖区' && voteProjectInfo.pcityIname!='县' }">${voteProjectInfo.pcityIname }</c:if></span>
								<span><i class="fa fa-list-ul"></i> <f:description itemValue="${voteProjectInfo.pindustry}" nodeKey="PIND" /></span>
								<span><i class="fa fa-sun-o"></i> <f:description itemValue="${voteProjectInfo.pstage}" nodeKey="PTYPE" /></span>
								<c:if test="${voteProjectInfo.piisCheck==0}">
									<span><i class="fa fa-circle-o"></i> 审核状态：未审核</span>
								</c:if>
								<c:if test="${voteProjectInfo.piisCheck==1}">
									<span><i class="fa fa-circle-o"></i>审核状态：通过</span>
								</c:if>
								<c:if test="${voteProjectInfo.piisCheck==2}">
									<span><i class="fa fa-circle-o"></i>审核状态：拒绝</span>
								</c:if>
							</div>
							<div class="count">
								<div class="clomn">
									<p>融资金额：<em>${voteProjectInfo.pfinancingAmount} 万</em></p>
									<p>跟投金额：<em>${voteProjectInfo.followAmount} 万</em></p>
								</div>
								<div class="clomn">
									<p>已融金额：<em>${voteProjectInfo.pinvestAmount} 万</em></p>
									<p>项目估值：<em><fmt:formatNumber value="${voteProjectInfo.pvaluationFinal }" pattern="###,###"  minFractionDigits="0"  />万</em></p>
								</div>
								<div class="clomn">
									<p>认投完成率：<em>${voteProjectInfo.pcomplete}%</em></p>
									<p>被投资人约谈数：<em>${voteProjectInfo.aboutNum} 次</em></p>
								</div>
								<div class="clomn">
									<p>我的跟投金额：<em><fmt:formatNumber value="${voteProjectInfo.piinvest/10000}" pattern="###,###"  minFractionDigits="0"  />万</em></p>
									<!-- <p>我的估值：<em>${voteProjectInfo.pivaluation} 万</em></p> -->
								</div>
							</div>
						</div>
					</div>
					<div class="buttons align-right">
						<c:if test="${voteProjectInfo.pstateId != '7' && voteProjectInfo.pstateId != 7}">
							<c:if test="${voteProjectInfo.piisPay == 0 || voteProjectInfo.piisPay == '0'}">
							<c:if test="${voteProjectInfo != null && voteProjectInfo.piisCheck !=1}">
								<button  disabled onclick="payMoney('${voteProjectInfo.projectId}','${voteProjectInfo.investId}');" class="ink-button blue"><i class="fa fa-credit-card"></i> 我要付款</button>
							</c:if>
							<c:if test="${voteProjectInfo.piisCheck==1}">
								<button onclick="payMoney('${voteProjectInfo.projectId}','${voteProjectInfo.investId}');" class="ink-button blue"><i class="fa fa-credit-card"></i> 我要付款</button>
							</c:if>
							<button onclick="aboutEntrepre('${voteProjectInfo.creator}','${voteProjectInfo.projectId}','${voteProjectInfo.createTimestr}');" class="ink-button blue"><i class="fa fa-comments"></i> 再次约谈</button>
							<button onclick="cancelVote('${voteProjectInfo.investId}','${voteProjectInfo.projectId}','${askPrice}');" class="ink-button blue"><i class="fa fa-users"></i>取消跟投</button>
							</c:if>
						</c:if>
					</div>
				</li>
			</c:forEach>
		</ul>
	</c:if>
	<c:if test="${empty voteProjectInfos }">
		<div class="no-content">暂无内容!</div>
	</c:if>
	<form id="pageForm" name="pageForm" action="">
		<pageTag:pagination form="pageForm"/>
	</form>
</div>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/btnCommon.js" />"></script>
<script src="<h:static type="js" src="/crowdfunding/resources/js/voteProj.js" />"></script>

</body>
</html>