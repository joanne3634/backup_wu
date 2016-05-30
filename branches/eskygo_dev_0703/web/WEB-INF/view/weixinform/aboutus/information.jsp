<%@page import="java.util.List"%>
<%@page import="com.deelon.core.util.AppUtil"%>
<%@page import="com.deelon.cmsform.service.site.CmsSiteMenuContentService"%>
<%@page import="com.deelon.cmsform.model.site.CmsSiteMenuContent"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>行业资讯</title>
	  	<link rel="stylesheet" href="${ctx}/styles/dlweixin/css/style.css">
		<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
		<script type="text/javascript" src="${ctx}/js/dlweixin/jquery-1.8.3.js"></script>
	</head>

	<body>
		<div class="messageList text-gray">
		<ul>
			
			<c:forEach items="${cms}" var="cms">
            <li class="borderdashed"> 
               <div class="messageName text-black2 textoverflow" onclick="viewInfo(${cms.siteMenuContentId})">${cms.contentTitle }
               </div>
                <p class="mediaReport-p">
                   ${cms.contentSummary}
                </p>
                <div>${cms.contentCreateDate}
                <span class="text-orange2" onclick="viewInfo(${cms.siteMenuContentId});">查看</span></div>
            </li>
            </c:forEach>
			
		</ul>
		</div>
		<script type="text/javascript">
		$(function(){
			$(".messageList").find("p").each(function(e,index){
				var val=$(this).html();
				var _length=val.length;
				var val2 =null; 
				if(_length>80){
          			for(var   i=0;   i<75;   i++)   val2   +=   val[i];   
      				val2 = val2+"..."; 
      				$(this).html(val2);
				}
			});
		});
		
		//查看完整资讯
		function viewInfo(infoId){
			window.location.href = "${ctx}/weixin/wxaboutus/industryInformationDetails.ht?id="+infoId;
		}
		</script>
	</body>
</html>