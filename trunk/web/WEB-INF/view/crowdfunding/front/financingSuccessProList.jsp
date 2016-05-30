<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
  <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html lang="en">
<head>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/innovationProject.css">
</head>
<script type="text/javascript">

	function toProdetailsPage(url){
		var parent = window.parent;
		parent.window.location.target="_blank";
		parent.window.location = url;
	}	
	
	function externallinks() { 
		if (!document.getElementsByTagName) return; 
		var anchors = document.getElementsByTagName("a"); 
		for (var i=0; i<anchors.length; i++) { 
		    var anchor = anchors[i]; 
		   if (anchor.getAttribute("href") && 
		        anchor.getAttribute("rel") == "external") 
		      anchor.target = "_blank"; 
		} 
	} 
		window.onload = externallinks;
</script>
<body>
		<div class="innovationRight f_r">
		  <!-- 成功案例 -->
		 <form id="pageForm_1" name="pageForm_1" action="">
			
	        <!-- <h3 class="clear">成功案例
	       </h3> -->
	        <div class="innovationProjectList">
	        	<ul>
	        	<c:forEach items="${ListVo }" var="vo">
		        		<li>
		        		<div  class="innovationimg">
		        			<a href="${ctx}/crowdfunding/front/toProDetails.ht?projectId=${vo.projectId }" target="_blank">
		        			<c:choose>
										<c:when test="${empty vo.ppic}">
											<img src="${ctx }/crowdfunding/Skin/Default/images/case3.png" class="innovationimg">
										<div></div>
										</c:when>
										<c:otherwise>
											<pageTag:projectPic menupath="${vo.projectId }"/>
											<div></div>
										</c:otherwise>
									</c:choose> </a>
						</div>			
		        			<div class="f_l">
		        				<h4><a href='${ctx}/crowdfunding/front/toProDetails.ht?projectId=${vo.projectId }' target="_blank">${vo.pname }</a></h4>
		        				<div class="money">
		        					<p>项目发起人：<label>${vo.loginName }</label><label>${vo.pcompanyName }</label>领投人：<label><c:if test="${empty vo.leaderLoginName }">无</c:if>
		        					<c:if test="${not empty vo.leaderLoginName }">${vo.leaderLoginName }</c:if>
		        					</p>
		        					<div>认投金额<span class="moneyspan1">${vo.pinvestAmount }万</span></div><div>认投完成率<span class="moneyspan2">${vo.pcomplete }%</span></div>
		        				</div>
		        			</div>
		        			<div class="clear character">
			        			<div class="clear characterLeft">
			        				<div class="characterLeft1"><span>融资金额</span><p>${vo.pfinancingAmount }万</p></div>
			        				<div class="characterLeft2"><span>出让股份</span>
			        				<c:choose>
			        				<c:when test="${vo.psharesPercent gt 100 }">
			        				<p>100.00%</p>
			        				</c:when>
			        				<c:otherwise>
			        				<p><fmt:formatNumber value="${vo.psharesPercent }" pattern="###,###.##"   minFractionDigits="2" />%</p>
			        				</c:otherwise>
			        				</c:choose>
			        				</div>
			        			</div>
			        			<div class="characterRight">
				        			<div><img src="${ctx }/crowdfunding/Skin/Default/images/toptriangle.png">地区：${vo.pcityIname }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 行业：<f:description nodeKey="PIND"  itemValue="${vo.pindustry }"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 阶段：<f:description nodeKey="PTYPE"  itemValue="${vo.pstage }"/></div>
				        			<div>${fn:substring(vo.pdetail,0,60) }</div>
				        			<div><img src="${ctx }/crowdfunding/Skin/Default/images/time.png">发布时间：${vo.popenDateStr }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 融资完成时间：${vo.pfullTimeStr }</div>
			        			</div>
		        			</div>
		        		</li>
	        	</c:forEach>
	        		
	        	</ul>
	        </div>
	        <input type="hidden" id="DescType" name="DescType" value="${DescType }"/>
		
		 <pageTag:paging form="pageForm_1"/>
		<!-- 成功案例 end-->
		</form>
	 </div>
	 <script type="text/javascript">
		$(function(){
				 if('${pro_type_name}'=='4'){
					 window.parent.document.getElementById('showHide').style.display='none';
					 window.parent.document.getElementById('rank').style.display='none';
				window.parent.document.body.scrollTop=0;	
		
					  $('#pro_type_name', window.parent.document).html("成功案例 ");
				 }
		});


</script>
</body>
</html>