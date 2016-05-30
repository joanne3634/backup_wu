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
	<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/proCommentAllIframe.css" />" type="text/css">
	<script type="text/javascript">
		var _ctx="${ctx}", isLogin,  groupId = '${user.groupId}';
	</script>
</head>
<body>
<form id="pageForm" name="pageForm" action="">
<div id="proComment" class="all-100">
	<c:if test="${not empty listC }">
		<ul class="commentsList">
			<c:forEach items="${listC }" var="vo" varStatus="i">
				<li>
					<div>
						<div class="imgContainer all-20">
							<img src="${ctx }/crowdfunding/resources/img/head_blank.png">
								<%--<c:if test="${not empty listC.myPhoto }">--%>
								<%--<img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${listC.myPhoto}">--%>
								<%--</c:if>--%>
								<%--<c:if test="${empty listC.myPhoto }">--%>
								<%--<img src="${ctx }/crowdfunding/resources/img/head_blank.png">--%>
								<%--</c:if>--%>
						</div>
						<div class="infos all-80">
							<div class="commentsDetail">
								<p title="${vo.pccontent}"><span>${vo.creatorLoginName }:</span>  ${vo.pccontent }</p>
								<p class="commentsTime">评论于  ${vo.creteTimeStr } <span class="replyIcon">    <i class="fa fa-share-square-o"></i>  回复 </span></p>
							</div>
							<div id="commentsText">
								<textarea class="commentsTextarea2" id="commentConten_id_${i.count }"></textarea>
								<div><em id="_pinglunjinggao" style="color:red;display:none;">请在上面输入你要回复的文字内容！</em></div>
								<span class="commentsSpan ink-button blue btn-small" onclick="replyMsg('${vo.commentsId }','${i.count }');">回 复</span>
							</div>
							<ul>
								<c:forEach items="${vo.listProComments }" var="bac">
									<li>
										<div class="commentsReply">
											<div class="imgContainer all-20">
												<img src="${ctx }/crowdfunding/resources/img/head_blank.png">
											</div>
											<div class="desc all-80">
												<p title="${bac.pccontent}"><span>${bac.writeBackCreator }:</span>  ${bac.pccontent }</p>
												<p class="replyTime">回复于  ${bac.writeBackDateStr }</p>

											</div>
										</div>
									</li>
								</c:forEach>

							</ul>
						</div>
					</div>
				</li>
			</c:forEach>
		</ul>
	</c:if>
	<input type="hidden" id="projectId"  name="projectId" value="${projectId }">
	<pageTag:pagination form="pageForm"/>
</div>
</form>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script type="text/javascript">
	$(function(){

		$(".commentsTime").click(function(){
			$("#commentsText").toggle();
		});
	});

	function replyMsg(commentsId,num){
		var commentConten_id_=$("#commentConten_id_"+num).val();
		if(commentConten_id_==''){
			$("#_pinglunjinggao").show();
			return;
		}
		if(commentConten_id_.length>1000)
		{
			window.top.$.Dialog.toast({content:"回复评论长度不能超过1000个字符!"});
			return;
		}
		$.ajax({
			url : "${ctx}/crowdfunding/front/replyMsg.ht",
			type : 'post',
			data : 'projectId=' + $("#projectId").val() + '&commentConten=' + commentConten_id_+'&commentsId='+commentsId
			,
			dataType : 'html',
			success : function(data, status) {
				if(eval(data)==eval('0')){
					window.location = "${ctx }/loginWeb.jsp";
				}else if(eval(data)==eval('1')){

					window.parent.successFun($("#projectId").val());
					//openDialog("回复成功!");
					//		 var url="${ctx }/crowdfunding/front/toProComment.ht?projectId="+$("#projectId").val();
					//	  $("#iframepage").attr("src", url);
					//	  window.parent.document.getElementById('iframepage').url=url;
					//	  $('#iframepage', window.parent.document).attr("src", url);
				}else {
					window.top.$.Dialog.toast({content:"操作异常!"});
//					openDialog("<div style=\"font-size: 15px; color:#666; margin-left: 30px;margin-top: 35px;\">操作异常!</div>",'40%','25%','2');
				}
			},
			error : function(xhr, textStatus, errorThrown) {
			}
		});

	}
</script>
</body>
</html>

