<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="f" uri="http://www.deelon.com/functions" %> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pageTag" tagdir="/WEB-INF/tags/pageTag"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>投资人列表</title>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>

<script type="text/javascript">

/* $(document).ready(function(){
	 $(".Inveslist span").hide();
}); */
	
</script>

  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/investor.css">
</head>
<body>
 <form id="pageForm" name="pageForm" action="${ctx }/crowdfunding/tcuserInvestor/tcuserInvestorPageList.ht">
	        <div class="clear incestorList">
	        	<ul>	        		
	        		<c:forEach items="${investorList }" var="list">
	        			<li>
		        			<div class="Inves">
								<div class="Invesimg"><!-- ${ctx }/crowdfunding/Skin/Default/images/headportrait2.png -->
									<c:if test="${not empty list.myPhoto }">
										<img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${list.myPhoto}">
									</c:if>
									<c:if test="${empty list.myPhoto }">
										<img src="${ctx }/crowdfunding/Skin/Default/images/headportrait3.png">
									</c:if>
									
									<div onclick="window.parent.loadPagesSendMsgremind('${list.userId}')">+发私信</div>
								</div>
								<div class="Inveslist">
								<!-- 									<c:if test="${list.isCompany eq 0 }">
										<c:set value="${list.realName }" var="name_set" property="name_set"/>
									</c:if>
									<c:if test="${list.isCompany eq 1 }">
										<c:set value="${list.contactName }" var="name_set" property="name_set"/>
									</c:if> -->
										<p title="${list.loginName }" <c:if test="${list.isLeader == 1 }">style="cursor: pointer;" onclick="window.parent.loadPagesDetails('${list.userId }','${list.loginName }')"</c:if>>
											<c:if test="${fn:length(list.loginName) > 10 }">
												${fn:substring(list.loginName,0,10) }...
											</c:if>
											<c:if test="${fn:length(list.loginName) <= 10 }">
												${list.loginName }
											</c:if>
									
<!-- 									<c:if test="${list.isCompany eq 1 }">
										<p title="${list.contactName }" <c:if test="${list.isLeader == 1 }">style="cursor: pointer;" onclick="window.parent.loadPagesDetails('${list.userId }','${name_set }')"</c:if>>
											<c:if test="${fn:length(list.contactName) > 5 }">
												${fn:substring(list.contactName,0,5) }...
											</c:if>
											<c:if test="${fn:length(list.contactName) <= 5 }">
												${list.contactName }
											</c:if>
									</c:if> -->
									&nbsp;
									
									<c:if test="${list.isLeader eq 1 }">  <!-- 是否领投人 -->
										<img src="${ctx }/images/lingtouren.png" title="领投人"/>
									</c:if>
									<c:if test="${list.isCompany eq 1 }">
										<img title="投资机构" src="${ctx }/crowdfunding/Skin/Default/images/touzijigou.png">
									</c:if>
									<c:if test="${list.isAskPrice eq 1 }">  <!-- 是否询价 -->
										<img src="${ctx }/images/xunjia.jpg" title="询价认证资格"/>
									</c:if>
									<c:if test="${list.bindIdno eq 1 }">  <!-- 是否实名认证 -->
										<img src="${ctx }/images/shimingyanzheng.png" title="实名认证会员"/>
									</c:if>
									</p>
									<div title="${list.remarks }">
										<c:if test="${fn:length(list.remarks) > 15 }">
											${fn:substring(list.remarks,0,15) }...
										</c:if>
										<c:if test="${fn:length(list.remarks) <= 15 }">
											${list.remarks }
										</c:if></div>
									<div>
									<f:description modelCode="t_area"  modelPropertyName="areaName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${list.provincesId }"></f:description>
									<f:description modelCode="t_area"  modelPropertyName="areaName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${list.cityId }"></f:description> 
									<c:if test="${list.isLeader == 1 }">  <!-- 领头人才有详细显示 -->
										 |  <a href="javascript:;" onclick="window.parent.loadPagesDetails('${list.userId }','${name_set }')">>>详细资料</a>
									</c:if>
									</div>
									<%-- <span onclick="window.parent.loadPageszijianMyProject('${list.userId }')">自荐我的项目</span> --%>
									
                                    <!-- update by nicole  2015/4/22 投资人时隐藏自荐我的项目 -->
									<c:choose>
										<c:when test="${curuser.groupId eq 1}">
										<span onclick="window.parent.loadPageszijianMyProject('${list.userId }')">自荐我的项目</span>
										</c:when>
										<c:otherwise>
										
										</c:otherwise>
									</c:choose>
									
								</div>
							</div>
						</li>	        		
	        		</c:forEach>
	        	</ul>
	        	<div class="clear paging-index-box">
	        	<pageTag:paging form="pageForm"/>
	        	</div>
	        	 <!-- <div class="clear paging-index-box">
				      <a href="javascript:;">首页</a> 
				      <a href="javascript:;">上一页</a> 
				      <a class="pagehover" href="javascript:;">1</a> 
				      <a class="page-num" href="javascript:;">2</a> 
				      <a class="page-num" href="javascript:;">3</a>
				      <a class="page-num" href="javascript:;">4</a> 
				      <a class="page-num" href="javascript:;">5</a> 
				      <a class="page-num" href="javascript:;">6</a> --- 
				      <a href="javascript:;">下一页</a> 
				      <a href="javascript:;">尾页</a>
			    </div> -->
	        </div>
	        </form>
</body>
</html>