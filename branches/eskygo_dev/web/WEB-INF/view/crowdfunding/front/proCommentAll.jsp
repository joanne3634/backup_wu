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
	<title><%=application.getAttribute("PLATFORM_NAME")%> - 更多评论</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/proCommentAll.css" />" type="text/css">
	<script type="text/javascript">
		if (top != this) {
			//当这个窗口出现在iframe里，表示其目前已经timeout，需要把外面的框架窗口也重定向登录页面
			top.location = '${ctx}/index-web.jsp';
		}
	</script>
</head>
<body>
<%@ include file="/crowdfunding/head-v2.jsp"%>
<div id="moreComments" class="ink-grid push-center all-90">
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
			<input type="hidden" id="projectId" name="projectId" value="${tcproject.projectId }">
			<div class="title-count">
				<span>开标时间：<fmt:formatDate value="${tcproject.popenDate }" pattern="yyyy-MM-dd HH:mm"/></span>
			</div>
			<div class="comment-title">
				<p><i class="fa fa-list"></i> 项目评论<span>共<em> ${Num } </em>条评论</span></p>
			</div>
			<div class="commentsList">
				<textarea class="commentsTextarea"  rows="3" id="commentConten_id"></textarea>
				<div class="commentText">
					<em id="_pinglunjinggao" style="color:red;display:none;">请在上面输入你要评论的文字内容！</em>
					<span id="sendComment" class="commentsSpan ink-button blue btn-median push-right" >发表评论</span>
				</div>
				<iframe src="${ctx }/crowdfunding/front/toProCommentAllIframe.ht?projectId=${tcproject.projectId}"  marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height=100% id="iframepage" name="iframepage" onLoad="iFrameHeight()" ></iframe>
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

		</div>
	</div>
</div>

<%@ include file="/crowdfunding/footer-v2.jsp"%>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/proCommentAll.js" />"></script>
<script>
//	$(function(){
//		$(".innovationTagContent .TagContentList").eq(0).css("display","block");
//		$(".InPrtag li").click(function(){
//			$(this).addClass('InPrtagLichecked').siblings().removeClass('InPrtagLichecked');
//			var _index=$(this).index();
//			$(".innovationTagContent .TagContentList").css("display","none");
//			$(".innovationTagContent .TagContentList").eq(_index).css("display","block");
//		});
//		$(".commentsTime span").click(function(){
//			$(this).parent().find(".commentsText").toggle();
//		});
//	})
	<%--$(function(){--%>
		<%--$(".InPruserlist a").click(function(){--%>
			<%--$.dialog.open('./detailsIframe.html', {--%>
				<%--title: '详细资料',lock:true});--%>
		<%--});--%>
		<%--$(".InPruser span,.InPruserimg div").click(function(){--%>
			<%--valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面--%>

			<%--var _val=$(this).parent().find("input[name='creator']").val();--%>
			<%--var _id=$(this).parent().find("input[name='creator']").attr("id");--%>
			<%--var projectId=$("#projectId").val();--%>
			<%--var url='${ctx}/crowdfunding/front/openSendInfoWin.ht?receiverId='+_val+'&projectId='+projectId;--%>

			<%--$.dialog.open(url, {--%>
				<%--title: '发私信',lock:true});--%>
		<%--});--%>
	<%--});--%>

	<%--function favorite(proId,creator){--%>

		<%--$.ajax({--%>
			<%--url : "${ctx}/crowdfunding/front/favorite.ht",--%>
			<%--type : 'post',--%>
			<%--data : 'projectId=' + proId + '&Creator=' + creator--%>
			<%--,--%>
			<%--dataType : 'html',--%>
			<%--success : function(data, status) {--%>
				<%--if(eval(data)==eval('0')){--%>
					<%--window.location = "${ctx }/loginWeb.jsp";--%>
				<%--}else if(eval(data)==eval('1')){--%>
					<%--openDialog("<div style=\"font-size: 15px; color:#666; margin-left: 30px;margin-top: 35px;\">收藏成功!</div>",'40%','25%','2');--%>
				<%--}else if(eval(data)==eval('2')){--%>
					<%--openDialog("<div style=\"font-size: 15px; color:#666; margin-left: 30px;margin-top: 35px;\">你已经收藏过该项目了!</div>",'40%','25%','2');--%>
				<%--}--%>
			<%--},--%>
			<%--error : function(xhr, textStatus, errorThrown) {--%>
			<%--}--%>
		<%--});--%>
	<%--}--%>

$('#sendComment').on('click', function(e) {
	var commentContent = $("#commentConten_id").val();
	if($.trim(commentContent) == ""){
		window.top.$.Dialog.toast({content:"评论内容不能为空"});
		return;
	}
	if(commentContent.length>1000)
	{
		window.top.$.Dialog.toast({content:"发表评论长度不能超过1000个字符!"});
		return;
	}
	$.ajax({
		url : _ctx + "/crowdfunding/front/sendTalkmsg.ht",
		type : 'post',
		data : {
			projectId: $('#projectId').val(),
			commentConten: commentContent
		},
		dataType : 'json',
		success : function(data, status) {
			if(data == "0"){
				window.location = _ctx + "/loginWeb.jsp";
			}else if(data == "1"){
				window.top.$.Dialog.toast({content:"发表成功!"});
				var url= _ctx + "/crowdfunding/front/toProCommentAllIframe.ht?projectId=" + $('#projectId').val();
				$("#iframepage").attr("src", url);
				$("#commentConten_id").val("");
				window.parent.window.location = '${ctx}/crowdfunding/front/toProCommentAll.ht?projectId='+$('#projectId').val();
			}else {
				window.top.$.Dialog.toast({content:"操作异常!"});
			}
		},
		error : function(xhr, textStatus, errorThrown) {
		}
	});
});

	<%--function sendTalkmsg(proId){--%>
		<%--var commentConten_id=$("#commentConten_id").val();--%>
		<%--if(commentConten_id==''){--%>
			<%--$("#_pinglunjinggao").show();--%>
			<%--return;--%>
		<%--}--%>
		<%--$.ajax({--%>
			<%--url : "${ctx}/crowdfunding/front/sendTalkmsg.ht",--%>
			<%--type : 'post',--%>
			<%--data : 'projectId=' + proId + '&commentConten=' + commentConten_id--%>
			<%--,--%>
			<%--dataType : 'html',--%>
			<%--success : function(data, status) {--%>
				<%--if(eval(data)==eval('0')){--%>
					<%--window.location = "${ctx }/loginWeb.jsp";--%>
				<%--}else if(eval(data)==eval('1')){--%>
					<%--openDialog("<div style=\"font-size: 15px; color:#666; margin-left: 30px;margin-top: 35px;\">发表成功!</div>",'40%','25%','6');--%>
					<%--var url="${ctx }/crowdfunding/front/toProCommentAllIframe.ht?projectId="+proId;--%>

					<%--$("#iframepage").attr("src", url);--%>
					<%--window.parent.window.location = '${ctx}/crowdfunding/front/toProCommentAll.ht?projectId='+proId;--%>
				<%--}else {--%>
					<%--openDialog("<div style=\"font-size: 15px; color:#666; margin-left: 30px;margin-top: 35px;\">操作异常!</div>",'40%','25%','2');--%>
				<%--}--%>
			<%--},--%>
			<%--error : function(xhr, textStatus, errorThrown) {--%>
			<%--}--%>
		<%--});--%>
	<%--}--%>

	function successFun(proId){
		window.top.$.Dialog.toast({content:"回复成功!"});
		var url="${ctx }/crowdfunding/front/toProCommentAllIframe.ht?projectId="+proId;
		$("#iframepage").attr("src", url);
	}
</script>
</body>
</html>