<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags/helpers"%>
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang=""> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title><%=application.getAttribute("PLATFORM_NAME")%> - 项目详情</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/innovationProjectDetails.css" />" type="text/css">
	<script type="text/javascript">
		if (top != this) {
			//当这个窗口出现在iframe里，表示其目前已经timeout，需要把外面的框架窗口也重定向登录页面
			top.location = '${ctx}/index-web.jsp';
		}
	</script>
</head>
<body>
<%@ include file="/crowdfunding/head-v2.jsp"%>
<div id="innovationProjectDetails" class="ink-grid push-center all-90">
	<div class="column-group horizontal-gutters">
		<div class="xlarge-70 large-65 medium-65 small-65 tiny-100">
			<div class="title">
				<h3>${tcproject.pname }</h3>
                <span>
                <c:choose>
					<c:when test="${tcproject.pcomplete >= RECRUITMENT_LIMIT_FINANCING}">
						已停止融资
					</c:when>
					<c:when test="${tcproject.pneedWarmUp == 1}">
						预热中
					</c:when>
					<c:otherwise>
						<f:description nodeKey="xmzt" itemValue="${tcproject.pstateId }"/>
					</c:otherwise>
				</c:choose>
                </span>
			</div>
			<div class="title-count">
				<span>开标时间：<fmt:formatDate value="${tcproject.popenDate }" pattern="yyyy-MM-dd HH:mm"/></span>
				<span>浏览次数：${tcproject.pviewCount }</span>
				<span>被收藏次数：${tcproject.pfavoritesCount }</span>
			</div>
			<div class="project-table">
				<table>
					<tbody>
					<tr>
						<td class="td-label">项目所属类别</td>
						<td class="td-text"><f:description nodeKey="XMLX" itemValue="${tcproject.ptypeId }"/></td>
						<td class="td-label">项目所属行业</td>
						<td class="td-text"><f:description nodeKey="PIND" itemValue="${tcproject.pindustry }"/></td>
					</tr>
					<tr>
						<td class="td-label">企业所在城市</td>
						<td class="td-text">${tcproject.pprovincesName }${tcproject.pcityIname }</td>
						<td class="td-label">企业成立时间</td>
						<td class="td-text">${tcproject.yearmonth }</td>
					</tr>
					<tr>
						<td class="td-label">企业员工人数</td>
						<td class="td-text">${tcproject.pemployeesCount }人</td>
						<td class="td-label">项目标签描述</td>
						<td class="td-text">${tcproject.plabel }</td>
					</tr>
					<tr>
						<td class="td-label">项目所属阶段</td>
						<td class="td-text"><f:description nodeKey="PTYPE" itemValue="${tcproject.pstage }"/></td>
						<td class="td-label">是否有其他项目</td>
						<td class="td-text"><f:description nodeKey="sf" itemValue="${tcproject.pisHaveOther }"/></td>
					</tr>
					<tr>
						<td class="td-label">项目办公地址：</td>
						<td colspan="3" class="td-text">${tcproject.paddress }</td>
					</tr>
					</tbody>
				</table>
			</div>
			<div class="introduction-title">
				<h3>企业项目简介</h3>
			</div>
			<div class="introduction">
				<c:if test="${tcproject.pviewLimit==0}">
					${tcproject.pdetail }
				</c:if>
			</div>
			<c:if test="${tcproject.pviewLimit==0}">
				<c:choose>
					<c:when test="${not empty tcproject.pvideo }">
						<embed src="${tcproject.pvideo }" width="100%" height="380"  wmode="transparent" onerror="暂无视频信息。"></embed>
					</c:when>
				</c:choose>
			</c:if>

			<div id="detailTabs" class="ink-tabs top">
				<ul class="tabs-nav">
					<li><a class="tabs-tab" href="#business-model">商业模式</a></li>
					<%--<li><a class="tabs-tab" href="#entrepreneurial-teams">创业团队</a></li>--%>
					<%--<li><a class="tabs-tab" href="#history">历史情况</a></li>--%>
					<%--<li><a class="tabs-tab" href="#future-plans">未来计划</a></li>--%>
					<li><a class="tabs-tab" href="#attachment">项目附件</a></li>
					<li><a class="tabs-tab" href="#project-dynamic">项目动态</a></li>
					<li><a class="tabs-tab" href="#project-comment">项目评论</a></li>
				</ul>
				<c:if test="${tcproject.pviewLimit==1}">
					<div class="ink-alert block info" role="alert">
						<h4>提示</h4>
						<p>
							<c:if test="${empty user}">您未登录或者</c:if>
							该创业项目设置了查看权限！你可以
							<a id="apply-view" style="color:red;" data-project-id="${tcproject.projectId }">申请查看</a>
							<c:if test="${ empty user }">或 <a style="color:red;" href="${ctx }/loginWeb.jsp">登陆试试</a></c:if>
						</p>
					</div>
				</c:if>
				<div id="business-model" class="tabs-content">
					<c:if test="${tcproject.pviewLimit==0}">
						<c:if test="${ not empty user }">
							<c:if test="${not empty tcprojectModel.pmtargeted }">
								<div class="content-title">1、目标用户或客户群体定位</div>
								<div class="content-text">${tcprojectModel.pmtargeted }</div>
							</c:if>
							<c:if test="${not empty tcprojectModel.pmcurrentlyPlaguing }">
								<div class="content-title">2、市场行业分析</div>
								<div class="content-text">${tcprojectModel.pmcurrentlyPlaguing }</div>
							</c:if>
							<c:if test="${not empty tcprojectModel.pmservicesMode }">
								<div class="content-title">3、产品或服务分析</div>
								<div class="content-text">${tcprojectModel.pmservicesMode }</div>
							</c:if>
							<c:if test="${not empty tcprojectModel.pmprofitableDesc }">
								<div class="content-title">4、项目赢利模式说明</div>
								<div class="content-text">${tcprojectModel.pmprofitableDesc }</div>
							</c:if>
							<c:if test="${not empty tcprojectModel.pmcompetitors }">
								<div class="content-title">5、项目主要核心竞争力说明</div>
								<div class="content-text">${tcprojectModel.pmcompetitors }</div>
							</c:if>
							<c:if test="${not empty tcprojectModel.pmcoreCompetitiveness }">
								<div class="content-title">6、投资回报说明</div>
								<div class="content-text">${tcprojectModel.pmcoreCompetitiveness }</div>
							</c:if>
						</c:if>
						<c:if test="${ empty user}">
							<div class="ink-alert block info" role="alert">
								<h4>提示</h4>
								<p>
									您需要登录才可以查看项目详细信息！ 你可以<a style="color: red;" href="${ctx}/loginWeb.jsp">登录</a> 或 <a style="color: red" href="${ctx}/user/registerInit.ht">注册成为投资人</a>
								</p>
							</div>
						</c:if>
					</c:if>
				</div>
				<div id="attachment" class="tabs-content">
					<c:if test="${tcproject.pviewLimit==0}">
						<c:if test="${ not empty user }">
							<ul>
								<c:if test="${not empty listA }">
									<c:forEach items="${listA }" var="vo" varStatus="i">
										<li>
											<a href="${ctx}/crowdfunding/front/downloadFile.ht?fileId=${vo.attachmentId}" target="_blank">${vo.pafileName}</a>
										</li>
									</c:forEach>
								</c:if>
								<c:if test="${empty listA }">
									<div>暂无内容!</div>
								</c:if>
							</ul>
						</c:if>
						<c:if test="${ empty user}">
							<div class="ink-alert block info" role="alert">
								<h4>提示</h4>
								<p>
									您需要登录才可以查看项目详细信息！ 你可以<a style="color: red;" href="${ctx}/loginWeb.jsp">登录</a> 或 <a style="color: red" href="${ctx}/user/registerInit.ht">注册成为投资人</a>
								</p>
							</div>
						</c:if>
					</c:if>
				</div>
				<div id="project-dynamic" class="tabs-content">
					<c:if test="${not empty listN }">
						<ul>
							<c:forEach items="${listN }" var="vo" begin="0" end="5">
								<li>
									<div class="item">
										<div class="all-25">
											<a href="${ctx }/tcproject/ProjectDynamic/edit.ht?newsId=${vo.newsId }" target="_blank">
												<pageTag:ProjectDynamic menupath="${vo.fileId}"/>
											</a>
										</div>
										<div class="all-75">
											<p class="title">
												<a title="${vo.pntitle }" href="${ctx }/tcproject/ProjectDynamic/edit.ht?newsId=${vo.newsId }" target="_blank">${vo.pntitle }</a>
											</p>
											<p>
												项目:【<a href="${ctx}/crowdfunding/front/toProDetails.ht?projectId=${vo.projectId }" target="_Blank">${vo.pname }</a>】
											</p>
											<p class="publisher">
												<span class="time"><i class="fa fa-clock-o"></i> 开标时间：<fmt:formatDate value="${vo.createTime }" pattern="yyyy-MM-dd HH:mm"/></span>
												<span class="author"><i class="fa fa-user"></i> 发布者：<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${vo.creator }"/></span>
											</p>
											<p>
												<a class="push-right" href="${ctx }/tcproject/ProjectDynamic/ProjectNewList.ht?projectId=${vo.projectId }" target="_Blank">>>本项目所有动态</a>
											</p>
										</div>
									</div>
								</li>
							</c:forEach>
						</ul>
					</c:if>
					<c:if test="${empty listN }">
						<div  class="hint">暂无内容!</div>
					</c:if>
				</div>
				<div id="project-comment" class="tabs-content ink-form">
					<c:if test="${tcproject.pviewLimit==0}">
						<c:if test="${ not empty user }">
							<textarea class="commentsTextarea" id="commentConten_id" placeholder="请输入评论内容"></textarea>
							<p class="push-left">温馨提示：发表评论长度不能超过1000个字符！</p>
							<button id="sendComment" class="ink-button blue push-right">发表评论</button>
							<iframe src="${ctx }/crowdfunding/front/toProComment.ht?projectId=${tcproject.projectId}" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height=100% id="iframepage" name="iframepage" onLoad="iFrameHeight()" ></iframe>
						</c:if>
						<c:if test="${ empty user}">
							<div class="ink-alert block info" role="alert">
								<h4>提示</h4>
								<p>
									您尚未登录，暂时不能发表评论！ 你可以<a style="color: red;" href="${ctx}/loginWeb.jsp">登录</a> 或 <a style="color: red" href="${ctx}/user/registerInit.ht">注册成为投资人</a>
								</p>
							</div>
						</c:if>
					</c:if>
				</div>
			</div>
		</div>
		<div class="xlarge-30 large-35 medium-35 small-35 tiny-0">
			<div class="entrepreneur">
				<div class="title">
					<h3>项目方</h3>
				</div>
				<div class="detail">
					<section class="avatar">
						<a href="#">
							<c:choose>
								<c:when test="${empty tcproject.myPhoto}">
									<img src="/crowdfunding/resources/img/head_blank.png">
								</c:when>
								<c:otherwise>
									<img src="${ctx}/crowdfunding/upload/getFileById.ht?path=${tcproject.myPhoto}">
								</c:otherwise>
							</c:choose>
						</a>
						<h4>${tcproject.realName } <i class="fa fa-envelope-o" data-id="creator_1" data-value="${tcproject.creator}"></i></h4>
					</section>
					<div class="project-info">
						<section class="all-50">融资金额：${tcproject.pfinancingAmount }万</section>
						<section class="all-50 align-right">出让股份：<fmt:formatNumber value="${tcproject.psharesPercent}" pattern="###,###.##"   minFractionDigits="2" />%</section>
						<section class="all-100">单笔最少投资额：<fmt:formatNumber value="${tcproject.pinvestMinFollow/10000}" pattern="###,###"   minFractionDigits="0" />万</section>
						<section class="all-100">款项拨付方式：<f:description nodeKey="TZKPT" itemValue="${tcproject.ppayWay }"/></section>
						<section class="all-50">认投金额：<fmt:formatNumber value="${tcproject.pinvestAmount }" pattern="###,###.##"   minFractionDigits="0" />万</section>
						<section class="all-50 align-right">跟投人数：<a href="${ctx}/crowdfunding/front/toInvestPersonList.ht?projectId=${tcproject.projectId }">${tcproject.pinvestCount }人</a></section>
						<section class="all-100">
							<div class="progress-bar"><span class="progress" style="width: ${tcproject.pcomplete > 100?100:tcproject.pcomplete }%;">${tcproject.pcomplete }%</span></div>
						</section>
						<section class="all-50">认投完成率：${tcproject.pcomplete }%</section>
						<section class="all-50 align-right">剩余天数：${tcproject.lastDays }天</section>
					</div>
				</div>
			</div>
			<c:if test="${empty user ||  user.groupId eq '2'}">
				<div class="button-groups">
					<c:if test="${tcproject.pneedWarmUp==0}">
						<section class="all-25">
							<button class="ink-button blue" onclick="applyLeader11('${isleader}','${isaskPrice}','${tcproject.pleaderId }','${listInvest }','${tcproject.projectId }','${tcproject.pisFull }');">
								<i class="fa fa-users"></i>我要领投
							</button>
						</section>
						<section class="all-25">
							<button class="ink-button blue" onclick="applyLeader12('${isaskPrice}','${tcproject.pisFull }','${listInvest }','${alreadyLingtou }');">
								<i class="fa fa-money"></i>我要跟投
							</button>
						</section>
					</c:if>
					<section class="all-25">
						<button id="interviews-with-entrepreneurs" class="ink-button blue" data-creator="${tcproject.creator}" data-project-id="${tcproject.projectId}">
							<i class="fa fa-comments"></i>约谈创业者
						</button>
					</section>
					<section class="all-25">
						<button id="favorite-project" class="ink-button blue"<c:if test="${isCollected}"> disabled</c:if> data-creator="${tcproject.creator}" data-project-id="${tcproject.projectId}">
							<i class="fa fa-heart"></i>收藏该项目
						</button>
					</section>
				</div>
			</c:if>
			<c:if test="${tcprojectInvest.piisCheck==1}">
				<div class="with-investor">
					<div class="title">
						<h3>项目领投人</h3>
					</div>
					<div class="detail">
						<section class="avatar">
							<a href="#">
								<c:choose>
									<c:when test="${empty tcprojectInvest.myPhoto}">
										<img src="/crowdfunding/resources/img/head_blank.png">
									</c:when>
									<c:otherwise>
										<img src="${ctx}/crowdfunding/upload/getFileById.ht?path=${tcprojectInvest.myPhoto}">
									</c:otherwise>
								</c:choose>
							</a>
                        <span>
                            <c:choose>
								<c:when test="${empty tcprojectInvest.loginName}">
									<h4>没有领投人</h4>
								</c:when>
								<c:otherwise>
									<h4>${tcprojectInvest.loginName } <i class="fa fa-envelope-o" data-id="creator_2" data-value="${tcprojectInvest.userId}"></i></h4>
									<p>投资达人</p>
									<p>领投金额：<fmt:formatNumber value="${tcprojectInvest.piinvest }" pattern="###,###.##"   minFractionDigits="0" />万</p>
									<p>认投时间：${tcprojectInvest.piinvestTimeS }</p>
									<p><a class="more" href="javascript:window.top.$.Dialog.modalIframe({title: '详细资料',url:'${ctx}/crowdfunding/tcuserInvestor/tcuserInvestorPageDetails.ht?userId=${tcprojectInvest.userId}'});">>>详细资料</a></p>
								</c:otherwise>
							</c:choose>
                        </span>
						</section>
						<div class="introduce">
							<section class="all-100">领投人担任有限合伙企业普通合伙人</section>
							<section class="all-100">尽职调查和条款清单报告：
								<c:choose>
									<c:when test="${not empty tcprojectInvest.PI_DueDoc and  not empty tcprojectInvest.PI_EvaluationTeam and not empty tcprojectInvest.PI_EvaluationProject}">
										<a href="javascript:void(0);" onclick="uploadfileDoc(${tcprojectInvest.PI_DueDoc})" class="ink-button blue btn-median">我要下载</a>
									</c:when>
									<c:otherwise>
										<a href="${ctx }/loan/aboutus/ZYXZDetails.ht"  target="_blank" class="ink-button blue btn-median">模板下载</a>
									</c:otherwise>
								</c:choose>
									<%--<c:if test="${empty tcprojectInvest.PI_DueDoc}">--%>

									<%--</c:if>--%>
									<%--<c:if test="${not empty tcprojectInvest.PI_DueDoc and  not empty tcprojectInvest.PI_EvaluationTeam and not empty tcprojectInvest.PI_EvaluationProject}">--%>
									<%--<a href="javascript:void(0);" onclick="uploadfileDoc(${tcprojectInvest.PI_DueDoc})" class="ink-button blue btn-median">我要下载</a>--%>
									<%--</c:if>--%>
							</section>
							<section class="all-100">对创业团队评价：</section>
							<section class="all-100">${tcprojectInvest.PI_EvaluationTeam }</section>
							<section class="all-100">对创业项目评价：</section>
							<section class="all-100">${tcprojectInvest.PI_EvaluationProject }</section>
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${not empty listInV}">
				<div class="invest-list">
					<div class="title">
						<h3>跟投记录</h3>
					</div>
					<div class="list">
						<ul>
							<c:forEach items="${listInV }" var="vo" begin="0" end="3" varStatus="status">
								<c:if test="${vo.piisCheck==1 }">
									<li>
										<section class="avatar">
											<a href="#">
												<c:choose>
													<c:when test="${empty vo.myPhoto}">
														<img src="/crowdfunding/resources/img/head_blank.png">
													</c:when>
													<c:otherwise>
														<img src="${ctx}/crowdfunding/upload/getFileById.ht?path=${vo.myPhoto}">
													</c:otherwise>
												</c:choose>
											</a>
                                   <span>
                                       <h4>${vo.loginName } <i class="fa fa-envelope-o" data-id="creator_${status.count }_${status.count }" data-value="${vo.userId}"></i></h4>
                                       <p>认投金额：${vo.piinvest }万</p>
                                       <p>认投时间：${vo.piinvestTimeS }</p>
                                   </span>
										</section>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
					<div class="all-invest align-right">
						<a href="${ctx}/crowdfunding/front/toInvestPersonList.ht?projectId=${tcproject.projectId }">>>全部跟投人</a>
					</div>
				</div>
			</c:if>
		</div>
	</div>
</div>
<form action="${ctx}/loan/tuserMsgRemind/saveMsgRemind.ht" method="post" id="sendForm">
	<input type="hidden" id="receiverName" name="receiverName" value="${tcproject.loginName}"/>
	<input type="hidden" id="createrId" name="createrId" value="${tcproject.creator}"/>
	<input type="hidden" id="projectId" name="projectId" value="${tcproject.projectId}"/>
	<input type="hidden" id="typeId" name="typeId" value="3"/>
	<input type="hidden" id="pcomplete" name="pcomplete" value="${tcproject.pcomplete}"/>
	<input type="hidden" id="rongzishangxian" value="${RECRUITMENT_LIMIT_FINANCING }"/>
	<!--<input type="hidden" id="IsBindCard" value="${IsBindCard }"/>  -->
	<input type="hidden" id="EnquiryMoney00" value="${EnquiryMoney00 }"/>
	<input type="hidden" id="user-group-id" value="${user.groupId}"/>
	<input type="hidden" id="isPerfectDoc" value="${user.isPerfectDoc }" />
	<input type="hidden" id="sendContent" name="sendContent" value="${tcproject.leaderLoginName}收藏了 ${tcproject.realName}的${tcproject.pname}"/>
</form>

<%@ include file="/crowdfunding/footer-v2.jsp"%>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/innovationProjectDetails.js" />"></script>
<script>
	function applyLeader11(isleader, isaskPrice, leaderId, isgentou, projectId, pisFull) {//我要领投
		//先判断用户是否登录
		valiLoginTimeout('iframe');
		if (isLogin) {
			//判断项目是否已经满标 满标就不能再跟投了
			var isPerfectDoc = $("#isPerfectDoc").val();
            if("1" != isPerfectDoc){
            	window.top.$.Dialog.toast({content:"您尚未完善投资人资料，将无法与项目方约谈、对项目进行投资，请先完善资料！"});
                return;
            }
			if (eval(pisFull) == 1 || pisFull == '1') {
				window.top.$.Dialog.toast({content:"该项目已融资完成，不能再接受投资了!"});
				return;
			}

			//判断项目是否已经有领投人了
			if (leaderId != '0' || leaderId != 0) {
				window.top.$.Dialog.toast({content:"该项目已经有领投人了,一个项目只能有一个领投人!"});
				return;
			}

			//判断项目是否已经超过融资上限
			var rongzishangxian = $("#rongzishangxian").val();
			var pcomplete = $("#pcomplete").val();

			if (rongzishangxian != '') {
				if (eval(pcomplete) >= eval(rongzishangxian)) {
					window.top.$.Dialog.toast({content:"该项目已经到达融资上限，已经停止融资..."});
					return;
				}
			}

			//1：项目方 2：投资者
			if ($('#user-group-id').val() === "1") {
				window.top.$.Dialog.toast({content: "只有投资人才能进行领投!"});
				return;
			}

			//先判断用户有无领投资格.
			if (eval(isleader) == 0) {
				var message_info = "";
				if ($('#user-group-id').val() === "2") {
					message_info = "<li class=\"_libtn\" onclick=\"toApplyLeaderPage()\">申请领投资格</li>";
				}
				//无,发起领投人申请
				window.top.$.Dialog.toast({content: "只有领投人才能进行领投!"+ message_info});
			} else {
				var enquiryMoney = $("#EnquiryMoney00").val();//如果系统设置 认筹诚意金为0，则部收取认筹诚意金
				//判断用户是否有询价认投资格
				//4/17 根据客户要求 去掉询价功能
				//5/11日 将 询价资格 修改成是否有认筹资格
				if (eval(isaskPrice) == 0 && eval(enquiryMoney) != 0) {
					window.top.$.Dialog.confirm("提示", "您需要先支付项目认筹诚意金，现在就去支付吗?", function () {
						window.parent.target = "_blank";
						window.parent.open(_ctx + '/crowdfunding/memberCenter/toApplyEnqPage.ht');
						window.top.$.Dialog.bankConfirm(function () {
							window.location = _ctx + '/loan/myAccount/myaccountPage.ht?forwordUrl=investRecord';
						}, function () {
							window.location = _ctx + '/loan/aboutus/HelpCenterList.ht';
						}, function () {
							window.location.reload(false);
						});
					});
				} else {
					//判断用户是否已经对该项目跟投
					if (isgentou == '1' || isgentou == 1) {//已经跟投过项目,到追加项目资金
						applyLeader12('${isaskPrice}', '${tcproject.pisFull }', '${listInvest }', '${alreadyLingtou }');
					} else {
						var url = _ctx + '/crowdfunding/front/openinquiryIframeNext.ht?piisLeader=' + isleader + "&projectId=" + projectId;
						window.top.ipdIframeDialog = window.top.$.Dialog.modalIframe({
							url: url,
							title: '项目认筹',
							width: '700px',
							height: '500px'
						});
					}
				}
			}
		}
	}

	function applyLeader12(isaskPrice, pisFull, isgentou, alreadyLingtou) {
		//先判断用户是否登录
		valiLoginTimeout('iframe');
		if (isLogin) {
			//1：项目方 2：投资者
			var isPerfectDoc = $("#isPerfectDoc").val();
            if("1" != isPerfectDoc){
            	window.top.$.Dialog.toast({content:"您尚未完善投资人资料，将无法与项目方约谈、对项目进行投资，请先完善资料！"});
                return;
            }
			if ($('#user-group-id').val() === "1") {
				window.top.$.Dialog.toast({content:"只有投资人才能进行跟投!"});
				return;
			}

			//判断项目是否已经满标 满标就不能再跟投了
			if (eval(pisFull) == 1 || pisFull == '1') {
				window.top.$.Dialog.toast({content:"该项目已融资完成，不能再接受投资了！"});
				return;
			}

			//判断项目是否已经超过融资上限
			var rongzishangxian = $("#rongzishangxian").val();
			var pcomplete = $("#pcomplete").val();

			if (rongzishangxian != '') {
				if (eval(pcomplete) >= eval(rongzishangxian)) {
					window.top.$.Dialog.toast({content:"该项目已经到达融资上限，已经停止融资..."});
					return;
				}
			}

			//判断用户是否有询价认投资格
			var enquiryMoney = $("#EnquiryMoney00").val();//如果系统设置 认筹诚意金为0，则部收取认筹诚意金
			if (eval(isaskPrice) == 0 && eval(enquiryMoney) != 0) {//没有询价认投资格 //4/17日 客户要求去掉询价功能 //5/11日 将 询价资格 修改成是否有认筹资格
				window.top.$.Dialog.confirm("提示", "您需要先支付项目认筹诚意金，现在就去支付吗?", function () {
					window.parent.target = "_blank";
					window.parent.open(_ctx + '/crowdfunding/memberCenter/toApplyEnqPage.ht');
					window.top.$.Dialog.bankConfirm(function () {
						window.location = _ctx + '/loan/myAccount/myaccountPage.ht?forwordUrl=investRecord';
					}, function () {
						window.location = _ctx + '/loan/aboutus/HelpCenterList.ht';
					}, function () {
						window.location.reload(false);
					});
				});
			} else {
				//判断用户是否已经跟投过一次(未被项目方拒绝),如果有,则第二次跟投 只能是在第一次跟投基础上,追加 跟投资金
				if (isgentou == '1' || isgentou == 1 || isgentou == '2' || isgentou == 2) {//已经跟投过项目,到追加项目资金
					if (isgentou == 2 || isgentou == '2') {
						window.top.$.Dialog.toast({content:"该项目,您已经打款,不能再跟投了!"});
						return;
					} else {
						var pfinancingAmount = "${tcproject.pfinancingAmount }";
						var url = _ctx + '/crowdfunding/front/addtoInvestMoney.ht?projectId=' + $("#projectId").val() + "&pfinancingAmount=" + pfinancingAmount;
						//有,发起项目跟投申请,

						window.top.ipdIframeDialog = window.top.$.Dialog.modalIframe({
							url: url,
							title: '追加跟投资金',
							height: '210px',
							overflowY: 'hidden'
						});
					}
				} else {
					var url = _ctx + '/crowdfunding/front/openinquiryIframeNext.ht?piisLeader=0' + "&projectId=" + $("#projectId").val();
					//有,发起项目跟投申请,
					window.top.ipdIframeDialog = window.top.$.Dialog.modalIframe({
						url: url,
						title: '项目认筹',
						width: '700px',
						height: '500px'
					});
				}
			}
		}
	}

	function toApplyLeaderPage(){
		window.parent.location= _ctx + '/loan/myAccount/myaccountPage.ht?forwordUrl=applyLeader';
	}
</script>
</body>
</html>