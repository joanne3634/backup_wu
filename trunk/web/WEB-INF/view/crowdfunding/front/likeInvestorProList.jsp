<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title><%=application.getAttribute("PLATFORM_NAME")%>-查询</title>
	<meta name="renderer" content="webkit"/>
  	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
  	 <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/ProjectDynamic.css">
    <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/investor.css">
    <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/innovationProject.css">
    <style type="text/css">
    	.centerdiv{
			width: 920px;
			margin: 25px 20px 0px 300px;
		}
		.centerdiv h3{
			width: 920px;
			height: 50px;
			line-height: 50px;
			color: #ff5200;
			font-size: 24px;
			text-align: left;
			border-bottom: 2px solid #cbcbcb;
		}
    </style>
<script type="text/javascript">
//私信详情显示层
function loadPagesSendMsgremind(p){
	valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
	if(p ==""){
		return;
	}	
	$.dialog.open('${ctx}/crowdfunding/front/openSendInfoWin.ht?receiverId='+p, {
		title: '发私信',lock:true});
}
//显示投资人详情显示层
function loadPagesDetails(p,d){
	if(p ==""){
		return;
	}
	$.dialog.open('${ctx}/crowdfunding/tcuserInvestor/tcuserInvestorPageDetails.ht?userId='+p, {
		title: d + '详细资料',lock:true});
}

//自荐项目显示层
function loadPageszijianMyProject(p){
	valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
	if(p ==""){
		return;
	}
	$.dialog.open('${ctx}/crowdfunding/tcuserInvestor/zijianMyProjectPage.ht?receiverId='+p, {
		title: '推荐我的项目',lock:true});
}
$(function(){
	$(".cl").each(function(e,index){
		var val=$(this).html().trim();
		var _length=val.length;
		var val2 =""; 
		if(_length>80){
  			for(var   i=0;   i<90;   i++)   val2   +=   val[i];   
				val2 = val2+"..."; 
				$(this).html(val2);
		}
	});
})
</script>
</head>
<body>
	<!-- <div style="height:191px;overflow: hidden;">
	</div> -->
		<%@ include file="/crowdfunding/head.jsp"%>
	<div class="centerdiv">
		<div class="innovationProjectList f_l">
			<h3 class="clear"><img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont.png">项目信息</h3>
			<ul>
			<c:if test="${empty ListVo}"><div class="hint">没有搜索到项目信息 </div></c:if>
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
			        					<p>融资金额<span>${vo.pfinancingAmount }万</span></p>
			        					<div>认投金额<span class="moneyspan1">${vo.pinvestAmount }万</span></div><div>认投完成率<span class="moneyspan2">${vo.pcomplete }%</span></div>
			        				</div>
			        			</div>
			        			<div class="clear character">
			        			<div><img src="${ctx }/crowdfunding/Skin/Default/images/toptriangle.png">地区：${vo.pcityIname }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行业：
			        			<f:description nodeKey="PIND"  itemValue="${vo.pindustry }"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
			        			阶段：<f:description nodeKey="PTYPE"  itemValue="${vo.pstage }"/> </div>
			        			<div>${vo.pdetail}</div>
			        			<div><img src="${ctx }/crowdfunding/Skin/Default/images/time.png">发布时间：${vo.popenDateStr }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;最新更新时间：${vo.updateTimeStr }</div>
			        			</div>
			        		</li>
		        		</c:forEach>
			</ul>
			 
			<h3 class="clear"><img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont.png">投资人信息</h3>
			<ul>
			<c:if test="${empty investorList}"><div class="hint">没有搜索到投资人信息 </div></c:if>
				<c:forEach items="${investorList }" var="list">
	        			<li>
		        			<div class="Inves">
								<div class="Invesimg"><!-- ${ctx }/crowdfunding/Skin/Default/images/headportrait2.png -->
									<c:if test="${not empty list.fileId }">
										<img src="${ctx}/platform/system/sysFile/getFileById.ht?fileId=${list.fileId}">
									</c:if>
									<c:if test="${empty list.fileId }">
										<img src="${ctx }/crowdfunding/Skin/Default/images/headportrait3.png">
									</c:if>
									
									<div onclick="loadPagesSendMsgremind('${list.userId}')">+发私信</div>
								</div>
								<div class="Inveslist">
									<c:if test="${list.isCompany eq 0 }">
										<c:set value="${list.loginName }" var="name_set" property="name_set"/>
									</c:if>
									<c:if test="${list.isCompany eq 1 }">
										<c:set value="${list.contactName }" var="name_set" property="name_set"/>
									</c:if>
									<a <c:if test="${list.isLeader == 1 }">href="javascript:;" onclick="loadPagesDetails('${list.userId }','${name_set }')"</c:if>>
									<c:if test="${list.isCompany eq 0 }">
										<p title="${list.loginName }">
											<c:if test="${fn:length(list.loginName) > 12 }">
												${fn:substring(list.loginName,0,5) }...
											</c:if>
											<c:if test="${fn:length(list.loginName) <= 12 }">
												${list.loginName }
											</c:if>
									</c:if>
									<c:if test="${list.isCompany eq 1 }">
										<p title="${list.contactName }">
											<c:if test="${fn:length(list.contactName) > 5 }">
												${fn:substring(list.contactName,0,5) }...
											</c:if>
											<c:if test="${fn:length(list.contactName) <= 5 }">
												${list.contactName }
											</c:if>
									</c:if>
										</a>
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
										 |  <a href="javascript:;" onclick="loadPagesDetails('${list.userId }','${name_set }')">>>详细资料</a>
									</c:if>
									</div>
									<span onclick="loadPageszijianMyProject('${list.userId }')">自荐我的项目</span>
								</div>
							</div>
						</li>	        		
	        		</c:forEach>
			</ul>
		</div>
		<div class="clear" ></div>
</div>
	<div class="clear" style="height:130px;overflow: hidden;">
		<%@ include file="/crowdfunding/foot.jsp"%>
	</div>
</body>
</html>