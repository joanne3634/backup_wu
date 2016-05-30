<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ include file="/commons/includeFront/taglibs.jsp"%>
 
 <c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>更多评论</title>
	<meta name="renderer" content="webkit"/>
      	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/innovationProject.css">
	<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
	<%--  <script type="text/javascript" src="${ctx }/crowdfunding/js/jquery-1.8.3.js"></script> --%>
   <%-- <script type="text/javascript" src="${ctx }/crowdfunding/artdialog/jquery.artDialog.js?skin=default"></script> --%>
   <%-- <script type="text/javascript" src="${ctx }/crowdfunding/artdialog/iframeTools.js"></script> --%>
   
   
</head>
<body>
	<!-- <div style="height:191px;overflow: hidden;">
	</div> -->
	<%@ include file="/crowdfunding/head.jsp"%>
	<div class="window">
		<div class="InPrcontentleft f_l">
			<div class="InPrcontentleft_top">
				<h3>${tcproject.pname }<span><f:description nodeKey="xmzt" itemValue="${tcproject.pstateId }"/></span></h3>
				<input type="hidden" id="projectId" name="projectId" value="${tcproject.projectId }">
				<div>开标时间：<span><fmt:formatDate value="${tcproject.popenDate }" pattern="yyyy-MM-dd HH:MM"/></span></div>
				<p><img src="${ctx }/crowdfunding/Skin/Default/images/commentIcont.png">项目评论<span>共<em>${Num }</em>条评论</span></p>
			</div>
			<div class="innovationTagContent">

			<div class="comments TagContentList">
				<textarea class="commentsTextarea" id="commentConten_id"></textarea>
				<div class="commentsprompt"><em id="_pinglunjinggao" style="color:red;display:none;">请在上面输入你要评论的文字内容！</em><span class="commentsSpan f_r" onclick="sendTalkmsg(${tcproject.projectId});">发表评论</span></div>
				<div class="commentsList">
				<iframe src="${ctx }/crowdfunding/front/toProCommentAllIframe.ht?projectId=${tcproject.projectId}" style="min-height: 500px;" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" id="iframepage" name="iframepage" onLoad="iFrameHeight()" ></iframe>
				</div>
			</div>
			</div>

		</div>
		<div class="InPrcontentright f_l">
		<h3><img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont.png">项目方</h3>
		<div class="InPruser">
			<img src="${ctx }/crowdfunding/Skin/Default/images/headportrait.png">
			<div>
			<input type="hidden" id="creator_1" name="creator" value="${tcproject.creator}">
				<input type="hidden" id="creatorName_1" name="creatorName" value="${tcproject.realName }">
			<p>${tcproject.realName }</p>
			<span>+发私信</span>
			</div>
		</div>
		<div class="clear plan">
		<h3><img src="${ctx }/crowdfunding/Skin/Default/images/toptriangle.png">融资金额及进度</h3>
			<div class="plantext">
				<h5>融资金额</h5>
				<span>${tcproject.pfinancingAmount }万</span>
			</div>
			<div class="plantext">
				<h5>出让股份</h5>
				<span>
				<c:choose>
					<c:when test="${tcproject.psharesPercent eq '0.00'}">
						议价中
					</c:when>
					<c:otherwise>
						${tcproject.psharesPercent } >
					</c:otherwise>
				</c:choose>
				</span>
			</div>
			<div class="clear plantext2">
				<h5>款项拨付方式</h5>
				<span><f:description nodeKey="TZKPT" itemValue="${tcproject.ppayWay }"/></span>
			</div>
			<div class="planUl">
			<ul>
				<li>
					<img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont6.png">
					<div>认投金额</div>
					<span>${tcproject.pinvestAmount }万</span>
				</li>
				<li>
					<img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont7.png">
					<div>跟投人数</div>
					<span>
						<a href="${ctx}/crowdfunding/front/toInvestPersonList.ht?projectId=${tcproject.projectId }" 
					style="text-decoration:;"><span>${tcproject.pinvestCount }人</span></a>
					</span>
				</li>
				<!--<li>
					<img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont8.png">
					<div>咨询人数</div>
					<span>${tcproject.paskPriceCount }人</span>
				</li>-->
			</ul>
			</div>
			<div class="clear planNum">
				<div>认投完成率：<span>${tcproject.pcomplete }%</span></div>
			</div>
			<div class="planImg"><div style="width:94%;"></div></div>

			<div class="planButton">
				<ul>
					<li><img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont2.png">我要领投</li>
					<li><img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont3.png">约谈项目方</li>
					<li><img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont4.png">我要跟投</li>
					<li onclick="favorite(${tcproject.projectId},${tcproject.creator})">
						<img  src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont5.png">
						收藏该项目
					</li>
				</ul>
			</div>
		</div>
		</div>
	</div>
	<div class="clear" style="height:130px;overflow: hidden;">
	<%@ include file="/crowdfunding/foot.jsp"%>
	</div>
	<script type="text/javascript">
	$(function(){
		$(".innovationTagContent .TagContentList").eq(0).css("display","block");
		$(".InPrtag li").click(function(){
			  $(this).addClass('InPrtagLichecked').siblings().removeClass('InPrtagLichecked');
			   var _index=$(this).index();
			  $(".innovationTagContent .TagContentList").css("display","none");
			  $(".innovationTagContent .TagContentList").eq(_index).css("display","block");
		});
		$(".commentsTime span").click(function(){
			$(this).parent().find(".commentsText").toggle();
		});
	})
	$(function(){ 
		$(".InPruserlist a").click(function(){ 
			$.dialog.open('./detailsIframe.html', {
    			title: '详细资料',lock:true});
		}); 
		$(".InPruser span,.InPruserimg div").click(function(){ 
			valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面

			var _val=$(this).parent().find("input[name='creator']").val();
			var _id=$(this).parent().find("input[name='creator']").attr("id");
			var projectId=$("#projectId").val();
			var url='${ctx}/crowdfunding/front/openSendInfoWin.ht?receiverId='+_val+'&projectId='+projectId;
			
			$.dialog.open(url, {
    			title: '发私信',lock:true});
		}); 
	});
	
	function favorite(proId,creator){
	    
	    $.ajax({
			url : "${ctx}/crowdfunding/front/favorite.ht",
			type : 'post',
			data : 'projectId=' + proId + '&Creator=' + creator
			,
			dataType : 'html',
			success : function(data, status) {
				if(eval(data)==eval('0')){
					window.location = "${ctx }/loginWeb.jsp";
				}else if(eval(data)==eval('1')){
					openDialog("<div style=\"font-size: 15px; color:#666; margin-left: 30px;margin-top: 35px;\">收藏成功!</div>",'40%','25%','2');
				}else if(eval(data)==eval('2')){
					openDialog("<div style=\"font-size: 15px; color:#666; margin-left: 30px;margin-top: 35px;\">你已经收藏过该项目了!</div>",'40%','25%','2');
				}
			},
			error : function(xhr, textStatus, errorThrown) {
			}
		});
	}
	
	
	
	function sendTalkmsg(proId){
		var commentConten_id=$("#commentConten_id").val();
		if(commentConten_id==''){
			$("#_pinglunjinggao").show();
			return;
		}
		  $.ajax({
				url : "${ctx}/crowdfunding/front/sendTalkmsg.ht",
				type : 'post',
				data : 'projectId=' + proId + '&commentConten=' + commentConten_id
				,
				dataType : 'html',
				success : function(data, status) {
					if(eval(data)==eval('0')){
						window.location = "${ctx }/loginWeb.jsp";
					}else if(eval(data)==eval('1')){
						openDialog("<div style=\"font-size: 15px; color:#666; margin-left: 30px;margin-top: 35px;\">发表成功!</div>",'40%','25%','6');
						 var url="${ctx }/crowdfunding/front/toProCommentAllIframe.ht?projectId="+proId;
										 	
						  $("#iframepage").attr("src", url);
						window.parent.window.location = '${ctx}/crowdfunding/front/toProCommentAll.ht?projectId='+proId;
					}else {
						openDialog("<div style=\"font-size: 15px; color:#666; margin-left: 30px;margin-top: 35px;\">操作异常!</div>",'40%','25%','2');
					}
				},
				error : function(xhr, textStatus, errorThrown) {
				}
			});
	}
	
	function successFun(proId){
		openDialog("<div style=\"font-size: 15px; color:#666; margin-left: 30px;margin-top: 35px;\">回复成功!</div>",'40%','25%','2');
		var url="${ctx }/crowdfunding/front/toProCommentAllIframe.ht?projectId="+proId;
		  $("#iframepage").attr("src", url);
	}
	
	function iFrameHeight() {
			
		    var ifm= document.getElementById("iframepage");
	
		    var subWeb = document.frames ? document.frames["iframepage"].document :
	
				ifm.contentDocument;
	
		        if(ifm != null && subWeb != null) {
	
		        ifm.height = subWeb.body.scrollHeight;
	
		        }
	
		}
	</script>
</body>
</html>
