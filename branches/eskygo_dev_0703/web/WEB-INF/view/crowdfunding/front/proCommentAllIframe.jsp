<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ include file="/commons/includeFront/taglibs.jsp"%>
 
 <c:set var="ctx" value="${pageContext.request.contextPath}" /> 
 
       	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/innovationProject.css">
	<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
<%-- 	 <script type="text/javascript" src="${ctx }/crowdfunding/js/jquery-1.8.3.js"></script>
   <script type="text/javascript" src="${ctx }/crowdfunding/artdialog/jquery.artDialog.js?skin=default"></script>
   <script type="text/javascript" src="${ctx }/crowdfunding/artdialog/iframeTools.js"></script> --%>
   
  

<form id="pageForm_all" name="pageForm_all" action="">
					<ul>
		<c:forEach items="${listC }" var="vo" varStatus="i">
						
			<div class="commentsListLeft f_l"><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait.png"></div>
			<div class="commentsListRight f_l">
			<div class="commentscontent"><span>${vo.creatorLoginName }：</span>${vo.pccontent }</div>
			<div class="commentsTime">评论于&nbsp;&nbsp;${vo.creteTimeStr }&nbsp;&nbsp;&nbsp;&nbsp;<img src="${ctx }/crowdfunding/Skin/Default/images/replyIcont2.png"><span>回复</span>
				<div class="commentsText">
					
					<textarea class="commentsTextarea2" id="commentConten_id_${i.count }"></textarea>
					<div><em id="_pinglunjinggao_${i.count }" style="color:red;display:none;">请在上面输入你要回复的文字内容！</em></div>
					<span class="commentsSpan" onclick="replyMsg('${vo.commentsId }','${i.count }');">回复</span>
				</div>
			</div>
				<c:forEach items="${vo.listProComments }" var="bac">
					<div class="commentsReply">
						<div class="commentsReplyLeft f_l"><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait.png"></div>
						<div class="commentsReplyRight f_l">
							<div class="commentscontent"><span>${bac.writeBackCreator }：</span>${bac.pccontent }</div>
							<div class="commentsTime">回复于&nbsp;&nbsp;${bac.writeBackDateStr }</div>
						
						</div>
						<div class="clear"></div>
					</div>
				</c:forEach>
			</div>
			<div class="clear"></div>
		</c:forEach>
						
		</ul>
			<input type="hidden" id="projectId" name="projectId" value="${projectId }"/>
			<pageTag:paging form="pageForm_all"/>
			
</form>

 <script type="text/javascript">
 $(function(){
		
		$(".commentsTime span").click(function(){
			$(this).parent().find(".commentsText").toggle();
		});
	});
   function replyMsg(commentsId,num){
		var commentConten_id_=$("#commentConten_id_"+num).val();
		if(commentConten_id_==''){
			$("#_pinglunjinggao_"+num).show();
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
						openDialog("<div style=\"font-size: 15px; color:#666; margin-left: 30px;margin-top: 35px;\">操作异常!</div>",'40%','25%','2');
					}
				},
				error : function(xhr, textStatus, errorThrown) {
				}
			});
		
	}
</script>
