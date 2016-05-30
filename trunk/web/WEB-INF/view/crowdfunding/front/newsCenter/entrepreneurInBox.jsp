<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<%@page import="com.deelon.loan.util.TUserUtil"%>
<%@page import="com.deelon.loan.model.front.TUser"%>
<% 
int count=1;
int count1=1;
int count2=1;
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>收件箱</title>
<meta name="renderer" content="webkit"/>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
<%@ include file="/crowdfunding/cssorjs.jsp"%>
<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">

<c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<%
TUser  u=TUserUtil.getLogUser( request );
%>
	<script type="text/javascript">
	$(function(){
		<%if(u!=null){ %>
		$.ajax({
			url:"${ctx}/loan/tuserMsgRemind/getTUserMsgCount.ht?typeId=2",
			dataType:'json',
			type:'post',
			success:function(userMsgCount){
				if(userMsgCount){
					var data = userMsgCount;
					if(data && data>0){
						var msgShow;
						if(data>99){
							msgShow = "99+";
						}else{
							msgShow = data;
						}
						$("#userMsg2").text(msgShow);
						$("#num-box2").show();
					}
				}
			}
		});
        <%}%>
	});
	$(function(){
		<%if(u!=null){ %>
		$.ajax({
			url:"${ctx}/loan/tuserMsgRemind/getTUserMsgCount.ht?typeId=3",
			dataType:'json',
			type:'post',
			success:function(userMsgCount){
				if(userMsgCount){
					var data = userMsgCount;
					if(data && data>0){
						var msgShow;
						if(data>99){
							msgShow = "99+";
						}else{
							msgShow = data;
						}
						$("#userMsg3").text(msgShow);
						$("#num-box3").show();
					}
				}
			}
		});
        <%}%>
	});
	$(function(){
		<%if(u!=null){ %>
		$.ajax({
			url:"${ctx}/loan/tuserMsgRemind/getTUserMsgCount.ht?typeId=5",
			dataType:'json',
			type:'post',
			success:function(userMsgCount){
				if(userMsgCount){
					var data = userMsgCount;
					if(data && data>0){
						var msgShow;
						if(data>99){
							msgShow = "99+";
						}else{
							msgShow = data;
						}
						$("#userMsg5").text(msgShow);
						$("#num-box5").show();
					}
				}
			}
		});
        <%}%>
	});
	
	</script>
<script>
function iFrameHeight() {
    var ifm= document.getElementById("iframepage");
    var subWeb = document.frames == null && typeof(document.frames) != "undefined"? document.frames["iframepage"].document : ifm.contentDocument; 
    if(ifm != null && subWeb != null) { 
        ifm.height = subWeb.body.scrollHeight; 
    } 
}
function iFrameHeight2() {
    var ifm= document.getElementById("iframepage_2");
    var subWeb = document.frames == null && typeof(document.frames) != "undefined"? document.frames["iframepage_2"].document : ifm.contentDocument; 
    if(ifm != null && subWeb != null) { 
        ifm.height = subWeb.body.scrollHeight; 
    } 
}
function iFrameHeight3() {
	var ifm= document.getElementById("iframepage_3");
	var subWeb = document.frames == null && typeof(document.frames) != "undefined" ? document.frames["iframepage_3"].document : ifm.contentDocument; 
	if(ifm != null && subWeb != null) { 
	    ifm.height = subWeb.body.scrollHeight; 
	} 
}
</script>
</head>
<body style="min-height:650px; ">
<div class="PrDyBack f_l">
		<h2><img src="${ctx}/crowdfunding/Skin/Default/images/headportrait4.png">收件箱</h2>
		<div class="patternPaymentNav">
				<ul>
					<li  id="huankuaning" class="PaPaNavChecked" onclick="loadDates1();">私信  <div style="float:right;display:none;cursor:pointer; position: relative;;" id="num-box1" title="未读信息"  >
        	<div style="float: left;background-image:url(${ctx}/crowdfunding/Skin/Default/images/zuobanyuan.png);height: 18px;width: 8px;background-repeat: no-repeat;"></div>
        	<div style="float: left;height: 18px; line-height: 18px; background-color: #ff5704; color: #fff;" id="userMsg1"></div>
        	<div style="float: left;background-image:url(${ctx}/crowdfunding/Skin/Default/images/youbianyuan.png);height: 18px;width: 8px;background-repeat: no-repeat;"></div>
        </div></li>
					<li id="huankuaned"  onclick="loadDates2();">约谈信
					<div style="float:right;display:none;cursor:pointer; position: relative;;" id="num-box2" title="未读信息"  >
        	<div style="float: left;background-image:url(${ctx}/crowdfunding/Skin/Default/images/zuobanyuan.png);height: 18px;width: 8px;background-repeat: no-repeat;"></div>
        	<div style="float: left;height: 18px; line-height: 18px; background-color: #ff5704; color: #fff;" id="userMsg2"></div>
        	<div style="float: left;background-image:url(${ctx}/crowdfunding/Skin/Default/images/youbianyuan.png);height: 18px;width: 8px;background-repeat: no-repeat;"></div>
        </div></li>
					<li id="huankuaned"  onclick="loadDates3();">收藏项目的投资人
					<div style="float:right;display:none;cursor:pointer; position: relative;;" id="num-box3" title="未读信息"  >
        	<div style="float: left;background-image:url(${ctx}/crowdfunding/Skin/Default/images/zuobanyuan.png);height: 18px;width: 8px;background-repeat: no-repeat;"></div>
        	<div style="float: left;height: 18px; line-height: 18px; background-color: #ff5704; color: #fff;" id="userMsg3"></div>
        	<div style="float: left;background-image:url(${ctx}/crowdfunding/Skin/Default/images/youbianyuan.png);height: 18px;width: 8px;background-repeat: no-repeat;"></div>
        </div></li>
					<li id="huankuaned1" onclick="loadDates4();">系统通知
					<div style="float:right;display:none;cursor:pointer; position: relative;;" id="num-box5" title="未读信息"  >
        	<div style="float: left;background-image:url(${ctx}/crowdfunding/Skin/Default/images/zuobanyuan.png);height: 18px;width: 8px;background-repeat: no-repeat;"></div>
        	<div style="float: left;height: 18px; line-height: 18px; background-color: #ff5704; color: #fff;" id="userMsg5"></div>
        	<div style="float: left;background-image:url(${ctx}/crowdfunding/Skin/Default/images/youbianyuan.png);height: 18px;width: 8px;background-repeat: no-repeat;"></div>
        </div></li>
				</ul>
			</div>
			<!--私信列表-->
			<div >
			 <iframe src="${ctx}/loan/tuserMsgRemind/getMyPrivateInfos.ht" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height=100% id="iframepage" name="iframepage" onLoad="iFrameHeight()" ></iframe>
			</div>
	</div>
	<script type="text/javascript">
	
   function loadDates1(){
		 var url='${ctx}/loan/tuserMsgRemind/getMyPrivateInfos.ht';
		  $("#iframepage").attr("src", url);
	  }
   
   function loadDates2(){
		 var url='${ctx}/loan/tuserMsgRemind/myAboutInfo.ht';
		  $("#iframepage").attr("src", url);
	  }
   
   function loadDates3(){
		 var url='${ctx}/loan/tuserMsgRemind/myCollectPro.ht';
		  $("#iframepage").attr("src", url);
	  }
   
   function loadDates4(){
		 var url='${ctx}/loan/tuserMsgRemind/mySystemInfo.ht';
		  $("#iframepage").attr("src", url);
	  }
   function unReadMsgSet(userMsgCount,num){
		if(userMsgCount!='0'){
			var data = userMsgCount;
			if(data && data>0){
				var msgShow;
				if(data>99){
					msgShow = "99+";
				}else{
					msgShow = data;
				}
				$("#userMsg"+num).text(msgShow);
				$("#num-box"+num).show();
			}
		}else{
			$("#num-box"+num).hide();
		}
	}
   
  
	 $(function(){
		 /**全选复选框单击事件**/
         $("#chkAll").click(function() {
             if (this.checked) {//如果自己被选中
                 $("table tr td input[type=checkbox]").attr("checked", true);
             }
             else {//如果自己没有被选中
                 $("table tr td input[type=checkbox]").attr("checked", false);
             }
         });
         $(".patternPaymentNav li").click(function(){
			  $(this).addClass('PaPaNavChecked').siblings().removeClass('PaPaNavChecked');
		});
		  //tab切换
//			$(".con-tabname").click(function() {
//				$(".con-tabname span").removeClass("color-main");
//				$(this).find("span").addClass("color-main");
//				$(".con-tabname").removeClass("tab-on");
//				$(this).addClass("tab-on");
//				$(".con-box").css("display", "none");
//				$(".con-box-" + $(this).attr("id")).css("display", "block");
//			});
	  })
	</script>
</body>
</html>