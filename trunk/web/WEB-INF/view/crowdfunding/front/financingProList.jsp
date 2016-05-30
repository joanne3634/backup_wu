<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
  <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/innovationProject.css">
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
		<form id="pageForm" name="pageForm" action="${ctx}/crowdfunding/front/tofinancingProList.ht">
	<%-- <c:if test="${pro_type_name ne '3' }"> --%>
	 			<input type="hidden" value="${DescList}" name="DescList"/>
	 			<input type="hidden" value="${pisRecommended}" name="pisRecommended"/>
	 			<input type="hidden" value="${DescType}" name="DescType"/>
		        <div class="innovationProjectList" id="innovationProjectList">
		        	<ul>
		        		<c:forEach items="${ListVo}" var="vo">
			        		<li>
			        		<div  class="innovationimg">
			        			<a href="${ctx}/crowdfunding/front/toProDetails.ht?projectId=${vo.projectId }" target="_blank">
				        			<%-- <img src="${ctx }/crowdfunding/Skin/Default/images/case.png" class="innovationimg">
				        			<img src="${ctx}/platform/system/sysFile/getFileById.ht?fileId=${vo.fileId}" width="104" height="107" alt=""> --%>
				        			
				        			<c:choose>
										<c:when test="${empty vo.ppic}">
											<img src="${ctx }/crowdfunding/Skin/Default/images/case3.png" class="innovationimg">
										</c:when>
										<c:otherwise>
											<pageTag:projectPic menupath="${vo.projectId }"/>
										</c:otherwise>
									</c:choose> 
			        			</a>
			        			</div>
			        			<div class="f_l">
			        				<h4><a href='${ctx}/crowdfunding/front/toProDetails.ht?projectId=${vo.projectId }' target="_blank" >${vo.pname }</a></h4>
			        				<div class="money">
			        					<p>融资金额<span>${vo.pfinancingAmount }万</span>出让股份<span>${vo.psharesPercent }%</span></p>
			        					<div>认投金额<span class="moneyspan1">${vo.pinvestAmount }万</span></div><div>认投完成率<span class="moneyspan2">${vo.pcomplete }%</span></div>
			        				</div>
			        			</div>
			        			<div class="clear character">
			        			<div><img src="${ctx }/crowdfunding/Skin/Default/images/toptriangle.png">地区：${vo.pcityIname }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行业：
			        			<f:description nodeKey="PIND"  itemValue="${vo.pindustry }"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
			        			阶段：<f:description nodeKey="PTYPE"  itemValue="${vo.pstage }"/> </div>
			        			<div>${vo.pdetail}</div>
			        			<div><img src="${ctx }/crowdfunding/Skin/Default/images/time.png">发布时间：${vo.popenDateStr }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;最新更新时间：<fmt:formatDate value="${vo.updateTime }" pattern="yyyy-MM-dd HH:mm"/></div>
			        			</div>
			        		</li>
		        		</c:forEach>
		        		
		        	</ul>
		        </div>
					     <pageTag:pagingToTop form="pageForm"/>
		<%--  </c:if> --%>
		<input type="hidden" id="_pro_type_name" value="${pro_type_name }"/>
			 </form>
		
		<%--   <!-- 成功案例 -->
		 <form id="pageForm_1" name="pageForm_1" action="">
	<c:if test="${pro_type_name eq '3' }">
			<div class="innovationRight f_r">
	        <!-- <h3 class="clear">成功案例
	       </h3> -->
	        <div class="innovationProjectList">
	        	<ul>
	        	<c:forEach items="${ListVo }" var="vo">
		        		<li>
		        			<div class="innovationimg">
		        			<img src="${ctx }/crowdfunding/Skin/Default/images/case1.png">
		        			<div></div>
		        			</div>
		        			<div class="f_l">
		        				<h4><a onclick="toProdetailsPage('${ctx}/crowdfunding/front/toProDetails.ht?projectId=${vo.projectId }');" href="">${vo.pname }++++++++++</a></h4>
		        				<div class="money">
		        					<p>项目发起人：<label>${vo.loginName }</label><label>${vo.pcompanyName }</label>领投人：<label>${vo.leaderLoginName }</p>
		        					<div>认投金额<span class="moneyspan1">${vo.pinvestAmount }万</span></div><div>认投完成率<span class="moneyspan2">${vo.pcomplete }%</span></div>
		        				</div>
		        			</div>
		        			<div class="clear character">
			        			<div class="clear characterLeft">
			        				<div class="characterLeft1"><span>融资金额</span><p>${vo.pfinancingAmount }万</p></div>
			        				<div class="characterLeft2"><span>出让股份</span><p>${vo.psharesPercent }%</p></div>
			        			</div>
			        			<div class="characterRight">
				        			<div><img src="${ctx }/crowdfunding/Skin/Default/images/toptriangle.png">地区：${vo.pcityIname }    行业：<f:description nodeKey="PIND"  itemValue="${vo.pindustry }"/>    阶段：<f:description nodeKey="PTYPE"  itemValue="${vo.pstage }"/></div>
				        			<div>${fn:substring("${vo.pdetail }",0,60) }</div>
				        			<div><img src="${ctx }/crowdfunding/Skin/Default/images/time.png">发布时间：${vo.popenDateStr }   融资完成时间：${vo.pfullTimeStr }</div>
			        			</div>
		        			</div>
		        		</li>
	        	</c:forEach>
	        		
	        	</ul>
	        </div>
	        
		</div>
		 <pageTag:paging form="pageForm_1"/>
	 </c:if>
		<!-- 成功案例 end-->
		</form> --%>
	 
	 <script type="text/javascript">
		$(function(){
			var _pro_type_name= $("#_pro_type_name").val();
				 /* if(${pro_type_name}=='3'){
					 window.parent.document.getElementById('showHide').style.display='none';
					 window.parent.document.getElementById('rank').style.display='none';
				window.parent.document.body.scrollTop=0;	
		
					  $('#pro_type_name', window.parent.document).html("成功案例 ");
				 } */ if(_pro_type_name=='2'){
				//	 parent.location.reload();
					 window.parent.document.getElementById('showHide').style.display='block';
					 window.parent.document.getElementById('rank').style.display='block';
					 $('#pro_type_name', window.parent.document).html("实体经营项目");
				 } if(_pro_type_name=='1'){
				//	 parent.location.reload();
					 window.parent.document.getElementById('showHide').style.display='block';
					 window.parent.document.getElementById('rank').style.display='block';
					 $('#pro_type_name', window.parent.document).html("科技创新项目 ");
				 }if(_pro_type_name=='3'){
				//	 parent.location.reload();
				window.parent.document.getElementById('showHide').style.display='block';
				window.parent.document.getElementById('rank').style.display='block';
				$('#pro_type_name', window.parent.document).html("地产投资项目 ");
			}
		});


</script>