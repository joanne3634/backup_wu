<%@page import="java.util.List"%>
<%@page import="com.deelon.core.util.AppUtil"%>
<%@page import="com.deelon.cmsform.service.site.CmsSiteMenuContentService"%>
<%@page import="com.deelon.cmsform.model.site.CmsSiteMenuContent"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title><%=application.getAttribute("PLATFORM_NAME")%> - 帮助中心</title>
<%-- <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/reset.css"> --%>
  <link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
  <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/public1.css">  
	  <%@ include file="/crowdfunding/cssorjs.jsp"%>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
</head>
<body onload="javascript:srcurl(${srcurl})"> 
   <%@ include file="/crowdfunding/head.jsp"%>
  <div class="container">
    <div class="weizhi-lianjie"  align="left" >
      <a href="${ctx }/index-web.jsp">首页</a> > <span>帮助中心</span>
    </div> 
    <style>
      #hyht-bodyright {
        float: right;
        width: 888px;
        color: #555;
      }
      .bodyRightBorder {
        border: 1px solid #f9d682;
      }
      .tit {
        height: 38px;
        line-height: 38px;
        font-size: 16px;
        border-bottom: 1px solid #f9d682;
        background-color: #fef9e1;
      }
      .con {
        padding: 20px 25px;
      }
      .shuxian {
        display: inline-block;
        float: left;
        position: relative;
        top: 9px;
        height: 20px;
        width: 0;
        border-left: 3px solid #ff5704;
        margin-left: 11px;
        margin-right: 11px;
      }
      .con .search-box>div {
        float: left;
        width: 250px;
        height: 33px;
        margin-right: 10px;
        padding-left: 35px;
        line-height: 32px;
        background-color: #fff;
        background-image: url(${ctx}/crowdfunding/Skin/Default/images/fangdajing-pic.png);
        background-repeat: no-repeat;
        background-position: 6px 8px;
        border: 1px solid #ccc;
      }
      .con .search-box {
        padding: 30px 10px;
        line-height: 35px;
        font-size: 12px;
        border-bottom: 1px dashed #999;
      }
      .con .search-box a {
        color: #ff5200;
        padding-left: 10px;
        padding-right: 10px;
      }
      .con .search-box>div input {
      	height:32px;
        width: 243px;
        color: #666;
        border: none;
      }
      .con .search-box>input {
        float: left;
        height: 35px;
        margin-right: 30px;
        padding-left: 25px;
        padding-right: 25px;
        color: #fff;
        font-size: 14px;
        background-color: #ff5200;
        border-radius: 5px;
        border: none;
        cursor: pointer;
      }
      .P2Pdai-con {
        margin-top: 20px;
        margin-bottom: 20px;
      }
      .P2Pdai-con dt {
        padding-left: 10px;
        line-height: 64px;
        font-size: 16px;
        border-bottom: 1px solid #ccc;
        cursor: pointer;
      }
      .P2Pdai-con dd {
        padding-top: 10px;
        padding-bottom: 10px;
        padding-left: 22px;
        display: none;
      }
      .dian {
        display: inline-block;
        position: relative;
        top: -2px;
        height: 6px;
        width: 6px;
        margin-right: 8px;
        border-radius: 3px;
        background-color: #333;
        vertical-align: middle;
      }
       #sidebar ul li a.hover{
        background-color:#fd8f59;
        color: #fff;
      }
    </style>
    <div class="hyht-body">
      <div id="hyht-bodyleft">
        <div id="sidebar">
        <input type="hidden" id="uri" value="${ctx }">
          <ul>
            <li><a style="background-color:#ff5704;color:#fff;font-size:18px;" href="${ctx }/loan/aboutus/HelpCenterList.ht?flag=1">帮助中心</a></li>
              <c:forEach items="${list }" var="list">
                 <li><a href="javascript:void(0);" id="ul_${list.siteMenuId }" onclick="loadPages('/loan/aboutus/HelpCenterDetails.ht?menupath=${list.menuPath }',${list.siteMenuId },'${list.menuPath}')">${list.menuName }</a>
<!--                    <ul class="subsidebar"> -->
<%--                    <pageTag:HelpCenterList menupath="${list.menuPath }"/> --%>
<!--                    </ul> -->
                  </li>
              </c:forEach> 
          </ul>
        </div>
        <div style="height:293px;margin-top:10px;"><img src="${ctx }/crowdfunding/Skin/Default/images/hyht_pic.png" alt=""></div> 
      </div>    
      <div id="hyht-bodyright" class="bodyRightBorder">
        <div class="tit"><span class="shuxian"></span><em id="TopTitle">帮助中心</em></div>
        <div class="con">  
           <div class="search-box"  style=" display:none"> 
            <div>
              <input type="text" id="query">
            </div>
            <input type="hidden" id="ctx" value="${ctx}">
              <input type="button" value="立即搜索" onclick="submit()"> <a href="javascript:;" > </a>
           </div> 
       <iframe src="${ctx }/loan/aboutus/toHelpCenter.ht" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height=100% id="iframepage" name="iframepage" onLoad="iFrameHeight()" ></iframe>
        </div> 
      </div>
    </div>
  </div>
  <script type="text/javascript">
  function srcurl(srcurl){ 
	  if(srcurl==null){
		  
	  }else{
	// var uri=$("#uri").val();
	 var s="/loan/aboutus/HelpCenterDetails.ht?menupath="; 
	 var srcu=s+srcurl; 
	 var num = '';
	 if(srcurl=='CYZ'){
		 num=10000003770006;
	 } else if(srcurl=='TZR'){
		 num=10000003770007;
	 }else if(srcurl == 'XSZN'){
		 num=10000003740003;
	 }else if(srcurl == 'TFB'){
		 num=10000003770008;
	 }
	 loadPages(srcu,num,'');
  }
  } 
  </script>
 <script>
//   $(function(){ 
//     $("#sidebar>ul>li:not(:first)>a").hover(function(){
//       $(this).css("background-color","#fd8f59");
//     },function(){
//       $(this).css("background-color","#fff9d9");
//     }).bind("click",function(){
//       $(".subsidebar").hide();
//       if ($(this).next().css("display")=="none") {
//         $(this).next().show();
//       }else{
//         $(this).next().hide();
//       };
//     }); 
//   })
  
  
  $(function(){
    $("#sidebar>ul>li:not(:first)>a").bind("click",function(){
      $("#sidebar>ul>li:not(:first)>a").removeClass("hover");
      $(this).addClass("hover");
      $(".tit em").text($(this).text());
    });
  })
  </script>
  <script type="text/javascript">
  var menuPath = "";
	    function iFrameHeight() {
	
	        var ifm= document.getElementById("iframepage");
	
	        var subWeb = document.frames ? document.frames["iframepage"].document :
	
				ifm.contentDocument;
	
	            if(ifm != null && subWeb != null) {
	
	            ifm.height = subWeb.body.scrollHeight;
	
	            }
	    }
	    function iFrameHeightSub(ht) {
	        var ifm= document.getElementById("iframepage");
	
	        var subWeb = document.frames ? document.frames["iframepage"].document :
	
				ifm.contentDocument;
	
	            if(ifm != null && subWeb != null) {
	            ifm.height = ht;
	
	            }
	    }
		function loadPages(url,num,menu_path) { 
			menuPath= menu_path;
			var ctx=$("#ctx").val();
			var ul=ctx+url;
			if(num!=0){
				$("#TopTitle").text($("#ul_"+num).text());
			}
			$("#iframepage").attr("src", ul);
		}
		function submit() { 
			var ctx=$("#ctx").val();
			var query=$("#query").val(); 
			var url=ctx+"/loan/aboutus/HelpCenterQuery.ht?Queryconditions="+query+"&menupath="+menuPath;  
			$("#iframepage").attr("src", url);
		}
	</script>
    <%@ include file="/crowdfunding/foot.jsp"%>
</body>
</html>