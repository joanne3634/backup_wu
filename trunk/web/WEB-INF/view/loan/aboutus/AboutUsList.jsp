<%@page import="com.deelon.loan.model.front.TUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
		<title><%=application.getAttribute("PLATFORM_NAME")%> - 关于我们</title>
<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/public1.css">
  <%@ include file="/crowdfunding/cssorjs.jsp"%>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
    <style>
      #body {
        margin-bottom: 30px;
        overflow: hidden;
      }
      #bodyleft {
        float: left;
        width: 173px;
      }
      #CorInf-sidebar {
        overflow: hidden;
        border: 1px solid #f9d682;
      }
      #CorInf-sidebar .hover {
        color: #fff;
        background-color: #fd8f59;
      }
      #CorInf-sidebar>ul>li {
        margin-bottom: 1px;
      }
      #CorInf-sidebar>ul>li>a {
        display: block;
        height: 35px;
        line-height: 35px;
        color: #545454;
        font-size: 15px;
        text-align: center;
        background-color: #fef9e1;
      }
      #CorInf-sidebar>ul>li>a:hover {
        text-decoration: none;
        color: #fff;
        background-color: #fd8f59;
      }
      #bodyright {
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
      .con p {
        margin-top: 20px;
        margin-bottom: 20px;
        line-height: 25px;
        font-size: 14px;
        text-indent: 2em;
        text-align: justify;
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
      .t-c { text-align: center; }
    </style>
    <script type="text/javascript">
  function srcurl(srcurl){   
	   if(srcurl==null){ 
	  }else{
		  if("${urlname}"!=null && "${urlname}"!= ""){
				 if("${urlname}"=='1'){
					 $("#toptitle").html("公司简介");  
				     $("#title").html("公司简介");  
				 }else if("${urlname}"=='2'){
					 $("#toptitle").html("团队介绍");  
				     $("#title").html("团队介绍");  
				 }else if("${urlname}"=='3'){
					 $("#toptitle").html("媒体报道");  
				     $("#title").html("媒体报道");  
				 }else if("${urlname}"=='4'){
					 $("#toptitle").html("诚聘英才");  
				     $("#title").html("诚聘英才");  
				 }else if("${urlname}"=='5'){
					 $("#toptitle").html("联系我们");  
				     $("#title").html("联系我们");  
				 }
				 else if("${urlname}"=='6'){
					 $("#toptitle").html("合作机构");  
				     $("#title").html("合作机构");  
				 }
				 else if("${urlname}"=='7'){
					 $("#toptitle").html("友情链接");  
				     $("#title").html("友情链接");  
				 }
			 } 
		 var uri=$("#uri").val(); 
		 var srcu=uri+"/"+srcurl; 
		 loadPages(srcu);
	  }
  } 
  </script>
</head>
<body  onload="srcurl(${srcurl})"> 
  <%@ include file="/crowdfunding/head.jsp"%>
  <div class="container">
  <input type="hidden" value="<%=request.getParameter("urlname")%>" id="urlname"/>
    <div class="weizhi-lianjie" align="left">
      <a href="${ctx}/index-web.jsp">首页</a> > <a href="${ctx}/site/AboutUs/AboutUsList.ht">关于我们</a> > <span id="toptitle">公司简介 </span>
    </div> 
    <div id="aboutus-body">
      <div id="bodyleft">
        <div class="bd-color-main" id="CorInf-sidebar">
          <ul>
          <input type="hidden" id="uri" value="${ctx }">
            <li><a href="javascript:void(0)" onclick="loadPages('${ctx}/site/AboutUs/AboutUs.ht')" style="background-color:#ff5704;color:#fff;font-size:18px;">关于我们</a></li>
            <li><a href="javascript:void(0)" onclick="loadPages('${ctx}/site/AboutUs/AboutUs.ht')" <c:if test="${urlname!=6}"> class="hover" </c:if>>公司简介</a></li>
            <li><a href="javascript:void(0)" onclick="loadPages('${ctx }/site/CompanyNews/CompanyNewsList.ht')">公司新闻</a></li>
             <li><a href="javascript:void(0)" onclick="loadPages('${ctx }/site/IndustryInformation/IndustryInformationList.ht')">投资资讯</a></li>
            <li><a href="javascript:void(0)" onclick="loadPages('${ctx }/loan/aboutus/NoticeList.ht')">通知公告</a></li>  
             <li><a href="javascript:void(0)" onclick="loadPages('${ctx}/site/TeamIntroduction/TeamIntroductionList.ht')" >团队介绍</a></li> 
             <li><a href="javascript:void(0)" onclick="loadPages('${ctx}/site/CooperatingAgency/CooperatingAgencyList.ht')" <c:if test="${urlname==6}"> class="hover" </c:if>>合作机构</a></li> 
             <li><a href="javascript:void(0)" onclick="loadPages('${ctx}/loan/aboutus/LinksList.ht')" >友情链接</a></li>
             <li><a href="javascript:void(0)" onclick="loadPages('${ctx}/site/MediaReport/MediaReportList.ht')">媒体报道</a></li> 
<%--              <li><a href="javascript:void(0)" onclick="loadPages('${ctx}/loan/aboutus/tUserSuccessstory/fontlist.ht')">成功故事</a></li>  --%>
            <li><a href="javascript:void(0)" onclick="loadPages('${ctx}/site/JoinUs/JoinUsList.ht')">诚聘英才</a></li> 
            <li><a href="javascript:void(0)" onclick="loadPages('${ctx}/site/ContactUs/ContactUsList.ht')">联系我们</a></li>
<%--             <li><a href="javascript:void(0)" onclick="loadPages('${ctx}/site/CopyrightStatement/CopyrightStatementList.ht')">法律服务</a></li>  --%>
            	<%
			TUser user =	(TUser)session.getAttribute("user");
			if(user==null){ 
			%> 
			<%} else{%>
			 <!-- <li class="bg-color-s" style="margin-bottom:0;"><a href="javascript:void(0)" onclick="loadPages('${ctx}/loan/aboutus/LeaveMessage.ht')">我要留言</a></li>  -->
			<%} %> 
          </ul>
        </div>
      </div>
      <div  id="bodyright" class="bodyRightBorder">
        <div class="tit"><span class="shuxian"></span><em id="title">公司简介</em></div>
       
    <div class="con">
<%--           <div class="t-c"><img src="${ctx }/crowdfunding/Skin/default/images/CorInf_pic.png" alt=""></div> --%>
          <iframe src="${ctx }/site/AboutUs/AboutUs.ht" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height=100% id="iframepage" name="iframepage" onLoad="iFrameHeight()" ></iframe>
        </div>
     </div>
      </div>
    </div>
  
  

  <script>
  $(function(){
	    $("#CorInf-sidebar>ul>li:not(:first)>a").click(function(){
	      $("#CorInf-sidebar>ul>li:not(:first)>a").removeClass("hover");
	      $(this).addClass("hover");
	      $(".tit em").text($(this).text());
	      });
	  })
  </script>
  <script type="text/javascript">
	
	    function iFrameHeight() {
	
	        var ifm= document.getElementById("iframepage");
	
	        var subWeb = document.frames ? document.frames["iframepage"].document :
	
				ifm.contentDocument;
	
	            if(ifm != null && subWeb != null) {
	
	            ifm.height = subWeb.body.scrollHeight;
	
	            }
	
	    }

		function loadPages(url) { 
			$("#iframepage").attr("src", url);
		}
	</script>
	<div class="clear"></div>
    <%@ include file="/crowdfunding/foot.jsp"%>
</body>
</html>