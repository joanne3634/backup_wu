<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="f" uri="http://www.deelon.com/functions" %>
 <style type="text/css">
 	a#online {
		width: 46px;
		height: 94px;
		display: inline-block;
	}
	a#erwei {
		width: 46px;
		height: 40px;
		display: inline-block;
	}
	a.phone_show {
		width: 46px;
		height: 40px;
		display: inline-block;
	}
 	#slayer {
		width: 50px;
		position: fixed;
		right: 0;
		top: 30%;
		z-index: 99;
		background: url(${ctx}/commons/image/mini.gif) no-repeat;
		height: 250px;
	}
	#erwei{
		position: relative;
	}
	#weibox{
		position: absolute;
	}
	#phone_pic {
		position: absolute;
		left: -210px;
		top: -50px;
	}
 </style> 
<c:set var="ctx" value="${pageContext.request.contextPath}" /> 
	<div class="foot"><!-- <span>|</span><a onclick="AddFavorite(window.location,document.title)" href="javascript:void(0)" target="_self">加入收藏</a><span>|</span><a onclick="SetHome(window.location)" href="javascript:void(0)">设为主页</a> -->
		<div class="footTag"><a href="${ctx}/site/AboutUs/AboutUsList.ht?srcurl='site/ContactUs/ContactUsList.ht'&&urlname=5" target="_blank">关于我们</a><span>|</span><a href="${ctx }/loan/aboutus/ZYXZDetails.ht"  target="_blank">资源下载</a><span>|</span><a href="${ctx }/site/CopyrightStatement/CopyrightStatement.ht" target="_blank">法律服务</a></div>
		<div>客服电话:<span><%=application.getAttribute("CUCTOMER_SERVICE_TELEPHONE") %></span> Email：<span><%=application.getAttribute("EMAIL") %></span> 技术支持:<span><a href="http://www.deelon.com" target="_blank"><%=application.getAttribute("TECH_SUPPORT") %></a></span></div>
		<div>All Rights Reserved <span><%=application.getAttribute("ALL-RIGHT-RESERVED") %></span> <span><%=application.getAttribute("PLATFORM_RECORD") %></span></div>
</div>
<div id="slayer">
    <!-- <a id="online" href="http://chat32.live800.com/live800/chatClient/chatbox.jsp?companyID=507015&amp;configID=75201&amp;jid=5207897035" target="_blank" rel="nofollow"></a> -->
 	<a id="online"></a>
    <a id="erwei" onmouseOver="weiMouseOver()" onmouseout="weiMouseOut()">
      <div id="weibox" style="top: -70px; left: -383px; display: none; ">
      	<img src="${ctx}/commons/image/weixin.png" title="">
      </div>
    </a>
    <a href="javascript:void(0);" class="phone_show" onmouseOver="telMouseOver()" onmouseout="telMouseOut()">
       <div id="phone_pic" style="top: -70px; display: none; ">
       	<img src="${ctx}/commons/image/phone.png" title="">
       </div>
    </a>
</div>

<script type="text/javascript" language="javascript">
 	function weiMouseOver(){
 		$("#weibox").attr("style","top: -130px; left: -240px;");
 	}
 	function weiMouseOut(){
 		$("#weibox").attr("style","display: none;");
 	}
 	function telMouseOver(){
 		$("#phone_pic").attr("style","top: 70px; left: -207px;");
 	}
 	function telMouseOut(){
 		$("#phone_pic").attr("style","display: none;");
 	}
      //加入收藏
     function AddFavorite(sURL, sTitle) {
        sURL = encodeURI(sURL); 
        try{   
            window.external.addFavorite(sURL, sTitle);   
        }catch(e) {   
            try{   
                window.sidebar.addPanel(sTitle, sURL, "");   
            }catch (e) {   
                alert("加入收藏失败，请使用Ctrl+D进行添加,或手动在浏览器里进行设置.");
            }   
        }
    }
 
    //设为首页
    function SetHome(url){
        if (document.all) {
            document.body.style.behavior='url(#default#homepage)';
            document.body.setHomePage(url);
        }else{
            alert("您好,您的浏览器不支持自动设置页面为首页功能,请您手动在浏览器里设置该页面为首页!");
        }
    }
 
</script>