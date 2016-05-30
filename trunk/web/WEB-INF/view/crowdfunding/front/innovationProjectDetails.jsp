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
	<title>创业项目详情</title>
	<meta name="renderer" content="webkit"/>
   	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/innovationProject.css">
	<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
	<link href="${ctx}/js/jquery/plugins/attach.css" rel="stylesheet" />
   <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
<style type="text/css">
    	h4 {
    		text-align: left;
			color: #ff5500;
			font-size: 16px;
			border-bottom: 1px dashed #bcbcbc;
			line-height: 40px;
			margin-bottom: 20px;
    	}
   </style>
<style type="text/css">
._libtn{
		float: left;
		width: 155px;
		height: 35px;
		background: #329900;
		margin: 10px 0px 0px 10px;
		line-height: 35px;
		color: #fff;
		font-size: 17px;
		cursor: pointer;
		text-align: center
}
._warning{
	font-size: 16px;
	color: #666;
	text-align: center
}


.f_l.PrDyImg {
    width: 220px;
    height: 130px;
}

</style>

</head>

<body>
	<!-- <div style="height:191px;overflow: hidden;">
	</div> -->
	<%@ include file="/crowdfunding/head.jsp"%>
	<div class="window">
	<div class="InPrcontentleft f_l">
			<div class="InPrcontentleft_top">
				<h3>${tcproject.pname }
				<input type="hidden" id="projectId" name="projectId" value="${tcproject.projectId }">
				<span>
				<c:choose>
					<c:when test="${tcproject.pcomplete >= RECRUITMENT_LIMIT_FINANCING}">
						已停止融资
					</c:when>
					<c:otherwise>
						<f:description nodeKey="xmzt" itemValue="${tcproject.pstateId }"/>
					</c:otherwise>
				</c:choose>
				</span></h3>
				<div>发布时间：<span><fmt:formatDate value="${tcproject.popenDate }" pattern="yyyy-MM-dd HH:mm"/></span></div>
			</div>
			<div class="InPrNum">
				浏览次数<span>${tcproject.pviewCount }</span>被收藏次数 <span>${tcproject.pfavoritesCount }</span>
			</div>
			<table class="tableContent"   border="0px" cellspacing="1px" cellpadding="0">
				<tr>
					<td class="tableContentTD1">项目所属类别：</td><td class="tableContentTD2">
					<f:description nodeKey="XMLX" itemValue="${tcproject.ptypeId }"/>
					</td><td class="tableContentTD1">项目所属行业：</td><td class="tableContentTD2">
					<f:description nodeKey="PIND" itemValue="${tcproject.pindustry }"/></td>
				</tr>
				<tr><td class="tableContentTD1">企业所在城市：</td><td class="tableContentTD2">${tcproject.pcityIname }</td><td class="tableContentTD1">企业成立时间：</td><td class="tableContentTD2">${tcproject.yearmonth }</td></tr>
				<tr><td class="tableContentTD1">企业员工人数：</td><td class="tableContentTD2">${tcproject.pemployeesCount }人</td>
				<td class="tableContentTD1">项目标签描述：</td>
				<td class="tableContentTD2">${tcproject.plabel }</td></tr>
				<tr>
					<td class="tableContentTD1">项目所属阶段：</td>
					<td class="tableContentTD2"><f:description nodeKey="PTYPE" itemValue="${tcproject.pstage }"/></td>
					<td class="tableContentTD1">是否有其他项目：</td><td class="tableContentTD2"><f:description nodeKey="sf" itemValue="${tcproject.pisHaveOther }"/></td>
				</tr>
				<tr><td class="tableContentTD1">项目办公地址：</td><td colspan="3" class="tableContentTD2">${tcproject.paddress }</td></tr>
			</table>
			
			<div class="InPrdescribe">
				<h4><img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont.png">企业项目简介</h4>
				<c:if test="${tcproject.pviewLimit==0}">
				<p>${tcproject.pdetail }</p>
				</c:if>
				
			</div>
				<c:if test="${tcproject.pviewLimit==0}">
				<c:choose>
					<c:when test="${not empty tcproject.pvideo }">
					<%-- <a href="<c:out value="${tcproject.pvideo }"></c:out>"><c:out value="${tcproject.pvideo }"></c:out></a> --%>
						<embed src="${tcproject.pvideo }" 
				width="730" height="480"  wmode="transparent" style="margin:50px 20px 0px 0px;" onerror="暂无视频信息。"></embed>
					</c:when>
					<c:when test="${empty tcproject.pvideo }">
						<div  class="hint"><span style="color:red">暂无视频信息。</span> </div>
					</c:when>
				</c:choose>
				</c:if>
				
				
			<div class="InPrtag">
				<ul>
					<li class="InPrtagLichecked">商业模式</li>
					<li >创业团队</li>
					<li>历史情况</li>
					<li>未来计划</li>
					<li>项目附件</li>
					<li>项目动态</li>
					<li>项目评论</li>
				</ul>
			</div>
			<c:if test="${tcproject.pviewLimit==1}">
				<div  class="hint"><span style="color:red"> <c:if test="${ empty TUser }">您未登录或者</c:if>该创业项目设置了 查看权限！ 你可以</span><a href="javascript:applyView('${tcproject.projectId }')"><span style="color:#09f">>>申请查看</span></a> <c:if test="${ empty TUser }">或 <a href="${ctx }/loginWeb.jsp"> <span style="color:#09f">>>登陆试试</span></a></c:if></div>
			</c:if>
			<c:if test="${tcproject.pviewLimit==0}">
	<div class="innovationTagContent">
		<div class="clear addyourprojectList TagContentList">
		
		<c:if test="${ not empty TUser }">
			<c:if test="${not empty tcprojectModel.pmtargeted }">
				<div class="InPrlist">
					<h3><span>1</span>目标用户或客户群体定位</h3>
					<p>${tcprojectModel.pmtargeted }</p>
					
				</div>
			</c:if>
			<c:if test="${not empty tcprojectModel.pmcurrentlyPlaguing }">
				<div class="InPrlist">
					<h3><span>2</span>目标用户或客户群体目前困扰或需求定位</h3>
					<div><p>${tcprojectModel.pmcurrentlyPlaguing }</p></div>
					
					
				</div>
			</c:if>
			<c:if test="${not empty tcprojectModel.pmservicesMode }">
				<div class="InPrlist">
					<h3><span>3</span>满足目标用户或客户需求的产品或服务模式说明</h3>
					<div><p>${tcprojectModel.pmservicesMode }</p></div>
					
				</div>
			</c:if>
			<c:if test="${not empty tcprojectModel.pmprofitableDesc }">
				<div class="InPrlist">
					<h3><span>4</span>项目赢利模式说明</h3>
					<div><p>${tcprojectModel.pmprofitableDesc }</p></div>
					
				</div>
			</c:if>
			<c:if test="${not empty tcprojectModel.pmcompetitors }">
				<div class="InPrlist">
					<h3><span>5</span>市场主要同行或竞争对手概述</h3>
					<div><p>${tcprojectModel.pmcompetitors }</p></div>
					
				</div>
			</c:if>
			<c:if test="${not empty tcprojectModel.pmcoreCompetitiveness }">
				<div class="InPrlist">
					<h3><span>6</span>项目主要核心竞争力说明</h3>
					<div><p>${tcprojectModel.pmcoreCompetitiveness }</p></div>
					
				</div>
			</c:if>
		</c:if>
		<c:if test="${ empty TUser }">
			<div  class="hint"><span style="color:red">您需要登录才可以查看项目详细信息！ 你可以</span><a href="${ctx }/loginWeb.jsp"><span style="color:#09f">>>登录</span></a> 或 <a href="${ctx }/user/registerInit.ht"> <span style="color:#09f">>>注册成为投资人</span></a></div>
		</c:if>
		</div>
		<!--团队  -->
		<div class="Entrepreneurial TagContentList">
				<div class="InPrlist">
				<c:if test="${ not empty TUser }">
					<h3><span>1</span>股东团队说明</h3>
							<div class="InPrlistTable">
								<table border="0" cellspacing="1" cellpadding="0">
									<tr>
										<th width="90">姓名</th>
										<th width="120">职务</th>
										<th width="90">是否全职</th>
										<th width="105">所占股份(%)</th>
										<th width="150">实际出资金额</th>
										<th width="220">与其他股东历史关系描述</th>
									</tr>
									<c:forEach items="${listT }" var="vo">
									<c:if test="${vo.pttypeId eq '1' }">
									<tr>
										<td>${vo.ptname}</td>
										<td>${vo.ptduty}</td>
										<td><f:description nodeKey="sf" itemValue="${vo.ptmisFullTime }"></f:description></td>
										<td>${vo.pttheShare}</td> 
										<td>${vo.ptrealPay}</td>
										<td>${vo.ptrelationship}</td>
									</tr>
									</c:if>
									</c:forEach>	
								</table>
								<c:forEach items="${listT }" var="vo">
								<c:if test="${vo.pttypeId eq '1' }">
									<h4><span>${vo.ptname}</span>股东详细介绍</h4>
									${vo.ptmemberInfo} 
								</c:if>
								</c:forEach>
							</div>
							<h3><span>2</span>非股东管理团队</h3>
							<div class="InPrlistTable">
								<table border="0" cellspacing="1" cellpadding="0">
									<tr>
										<th width="90">姓名</th>
										<th width="120">职务</th>
										<th width="90">是否全职</th>
										<!-- <th width="105">所占股份(%)</th> -->
										<th width="150">入职时间</th>
										<th width="220">与创始团队成员历史关系</th>
									</tr>
								<c:forEach items="${listT }" var="vo">
								<c:if test="${vo.pttypeId eq '0' }">
									<tr>
										<td>${vo.ptname}</td>
										<td>${vo.ptduty}</td>
										<td><f:description nodeKey="sf" itemValue="${vo.ptmisFullTime }"></f:description></td>
										<%-- <td>${vo.pttypeId}</td> --%>
										<td>${vo.ptentryTime}</td>
										<td>${vo.ptrelationship}</td>
									</tr>
								</c:if>
								</c:forEach>
								<c:if test="${vo.pttypeId!='0'}">
								<tr>
										<td colspan="5">无</td>
									</tr>
								</c:if>
								</table>
								<c:forEach items="${listT }" var="vo">
								<c:if test="${vo.pttypeId eq '0' }">
									<h4><span>${vo.ptname}</span>股东详细介绍</h4>
									${vo.ptmemberInfo} 
								</c:if>
								</c:forEach>
							</div>
				</c:if>
		<c:if test="${ empty TUser }">
			<div  class="hint"><span style="color:red">您需要登录才可以查看项目详细信息！ 你可以</span><a href="${ctx }/loginWeb.jsp"><span style="color:#09f">>>登录</span></a> 或 <a href="${ctx }/user/registerInit.ht"> <span style="color:#09f">>>注册成为投资人</span></a></div>
		</c:if>
				</div>
		</div>
		<!--团队end  -->
		<!--历史情况  -->
		<div class="Diachronic TagContentList">
				<div class="InPrlist">
				<c:if test="${ not empty TUser }">
				<c:forEach items="${listH }" var="vo" varStatus="i">
					<h3><span>${i.count }</span>第${i.count }阶段</h3>
					<div class="PrHiDataList">
						<ul>
							<li><span>1、阶段名称：</span>${vo.phpname }</li>
							<li class="PrHiDataListSelect"><span>2、起止时间：</span>${vo.phpstartYear }年${vo.phpstartMonth }月--${vo.phpendYear }年${vo.phpendMonth }月</li>
							<li><span>3、阶段达成目标描述：</span>
								${vo.phptargetDesc }
							</li>
							<li><span>4、完成阶段目标的主要措施、方法、手段：</span>
								${vo.phptargetWay }
							</li>
							
							<li><span>5、阶段收入：</span>
							</li>
						<div class="InPrlistTable">
							<table border="0" cellspacing="1" cellpadding="0">
						
							<tr>
								<th width="33%">收入类别</th>
								<th width="33%">收入金额￥</th>
								<th width="33%">备注</th>
							</tr>
							<c:forEach items="${vo.listHpPayMent }" var="payM">
							<c:if test="${payM.hpptypeId eq '1' }">
								<tr class="InPrlistTr">
									<td>${payM.hppkindName }</td>
									<td><fmt:formatNumber value="${payM.hpppayment }" pattern="###,###.##"   minFractionDigits="2" /></td>
									<td>${payM.hppremarks }</td>
								</tr>
							</c:if>
							</c:forEach>
							</table>
						
						</div>
							<li><span>6、阶段开支：</span>
							</li>
						<div class="InPrlistTable">
							<table border="0" cellspacing="1" cellpadding="0">
						
							<tr>
								<th width="33%">费用类别</th>
								<th width="33%">开支金额￥</th>
								<th width="33%">备注</th>
							</tr>
							<c:forEach items="${vo.listHpPayMent }" var="payM">
							<c:if test="${payM.hpptypeId eq '2' }">
								<tr class="InPrlistTr">
									<td>${payM.hppkindName }</td>
									<td><fmt:formatNumber value="${payM.hpppayment }" pattern="###,###.##"   minFractionDigits="2" /></td>
									<td>${payM.hppremarks }</td>
								</tr>
							</c:if>
							</c:forEach>
							</table>
						
						</div>
						</ul>
					</div>
				</c:forEach>
				
				<div class="cumulative">
					<span>累计盈亏：</span>
					<div class="InPrlistTable">
						<table border="0" cellspacing="1" cellpadding="0">
							<tr>
								<th width="33%">累计收入金额￥</th>
								<th width="33%">累计开支金额￥</th>
								<th width="33%">累计盈亏金额￥</th>
							</tr>
							<tr class="InPrlistTr">
								<td><fmt:formatNumber value="${hmoneyIn }" pattern="###,###.##"   minFractionDigits="2" /></td>
								<td><fmt:formatNumber value="${hmoneyOut }" pattern="###,###.##"   minFractionDigits="2" /></td>
								<td><fmt:formatNumber value="${hmoneyIn-hmoneyOut }" pattern="###,###.##"   minFractionDigits="2" /></td>
							</tr>
						</table>
					</div>
				</div>
				</c:if>
		<c:if test="${ empty TUser }">
			<div  class="hint"><span style="color:red">您需要登录才可以查看项目详细信息！ 你可以</span><a href="${ctx }/loginWeb.jsp"><span style="color:#09f">>>登录</span></a> 或 <a href="${ctx }/user/registerInit.ht"> <span style="color:#09f">>>注册成为投资人</span></a></div>
		</c:if>
				</div>
		</div>
		<!--历史情况end  -->
		
		<!-- 未来计划 -->
		<div class="FuturePlans TagContentList">
				<div class="InPrlist">
				<c:if test="${ not empty TUser }">
				<c:forEach items="${listP }" var="vo" varStatus="i">
					<h3><span>${i.count }</span>第${i.count }阶段</h3>
					<div class="PrHiDataList">
						<ul>
							<li><span>1、阶段名称：</span>${vo.phpname }</li>
							<li class="PrHiDataListSelect"><span>2、起止时间：</span>${vo.phpstartYear }年${vo.phpstartMonth }月--${vo.phpendYear }年${vo.phpendMonth }月</li>
							<li><span>3、阶段达成目标描述：</span>
								${vo.phptargetDesc }
							</li>
							<li><span>4、完成阶段目标的主要措施、方法、手段：</span>
								${vo.phptargetWay }
							</li>
							<li><span>5、阶段收入：</span>
							</li>
							<div class="InPrlistTable">
							<table border="0" cellspacing="1" cellpadding="0">
						
							<tr>
								<th width="33%">收入类别</th>
								<th width="33%">收入金额￥</th>
								<th width="33%">备注</th>
							</tr>
							<c:forEach items="${vo.listHpPayMent }" var="payM">
							<c:if test="${payM.hpptypeId eq '1' }">
								<tr class="InPrlistTr">
									<td>${payM.hppkindName }</td>
									<td><fmt:formatNumber value="${payM.hpppayment }" pattern="###,###.##"   minFractionDigits="2" /></td>
									<td>${payM.hppremarks }</td>
								</tr>
							</c:if>
							</c:forEach>
							</table>
						
							</div>
							<li><span>6、阶段开支：</span>
							</li>
							<div class="InPrlistTable">
							<table border="0" cellspacing="1" cellpadding="0">
						
							<tr>
								<th width="33%">费用类别</th>
								<th width="33%">开支金额￥</th>
								<th width="33%">备注</th>
							</tr>
							<c:forEach items="${vo.listHpPayMent }" var="payM">
							<c:if test="${payM.hpptypeId eq '2' }">
								<tr class="InPrlistTr">
									<td>${payM.hppkindName }</td>
									<td><fmt:formatNumber value="${payM.hpppayment }" pattern="###,###.##"   minFractionDigits="2" /></td>
									<td>${payM.hppremarks }</td>
								</tr>
							</c:if>
							</c:forEach>
							</table>
						
						</div>
						</ul>
					</div>
				</c:forEach>
				<div class="cumulative">
					<span>累计盈亏：</span>
					<div class="InPrlistTable">
						<table border="0" cellspacing="1" cellpadding="0">
							<tr>
								<th width="33%">累计收入金额￥</th>
								<th width="33%">累计开支金额￥</th>
								<th width="33%">累计盈亏金额￥</th>
							</tr>
							<tr class="InPrlistTr">
								<td><fmt:formatNumber value="${fmoneyIn }" pattern="###,###.##"   minFractionDigits="2" /></td>
								<td><fmt:formatNumber value="${fmoneyOut }" pattern="###,###.##"   minFractionDigits="2" /></td>
								<td><fmt:formatNumber value="${fmoneyIn-fmoneyOut }" pattern="###,###.##"   minFractionDigits="2" /></td>
							</tr>
						</table>
					</div>
				</div>
				</c:if>
				<c:if test="${ empty TUser }">
					<div  class="hint"><span style="color:red">您需要登录才可以查看项目详细信息！ 你可以</span><a href="${ctx }/loginWeb.jsp"><span style="color:#09f">>>登录</span></a> 或 <a href="${ctx }/user/registerInit.ht"> <span style="color:#09f">>>注册成为投资人</span></a></div>
				</c:if>
				</div>
				
		</div>
		<!--未来计划end  -->
		<!--项目附件  -->
		<div class="attachment TagContentList">
				<c:if test="${ not empty TUser }">
				<!-- <div class="InPrlist">
					<h3><span>1</span>项目标题</h3>
				</div> -->
				<div class="attachment">
					<ul>
					<c:if test="${not empty listA }">
					<c:forEach items="${listA }" var="vo" varStatus="i">
					
						<li>
							<a href="${ctx}/crowdfunding/front/downloadFile.ht?fileId=${vo.attachmentId}" target="_blank">
								${vo.pafileName}
							</a>
						</li>
					</c:forEach>
						
					</c:if>
					<c:if test="${empty listA }">
						<div  class="hint">暂无内容!</div>
					</c:if>
					</ul>
				</div>
				</c:if>
			<c:if test="${ empty TUser }">
			<div  class="hint"><span style="color:red">您需要登录才可以查看项目详细信息！ 你可以</span><a href="${ctx }/loginWeb.jsp"><span style="color:#09f">>>登录</span></a> 或 <a href="${ctx }/user/registerInit.ht"> <span style="color:#09f">>>注册成为投资人</span></a></div>
			</c:if>
		</div>
		<!-- 项目附件end  -->
		<!-- 项目动态 -->
		<div class="ProjectDynamicLeft TagContentList">
			<ul>
			<c:if test="${not empty listN }">
				<c:forEach items="${listN }" var="vo" begin="0" end="5">
					<li>
						<%-- <img src="${ctx }/crowdfunding/Skin/Default/images/ProjectDynamic.png" class="f_l"> --%>
						<a href="${ctx }/tcproject/ProjectDynamic/edit.ht?newsId=${vo.newsId }" target="_Blank">
						<pageTag:ProjectDynamic menupath="${vo.fileId}"/>
						</a>
						<div class="ProjectDynamicName f_l">
							<h4><a title="${vo.pntitle }" href="${ctx }/tcproject/ProjectDynamic/edit.ht?newsId=${vo.newsId }" target="_Blank">						
							<c:if test="${fn:length(vo.pntitle) > 20 }">
								${fn:substring(vo.pncontent,0,20) }...
							</c:if>
							<c:if test="${fn:length(vo.pntitle) <= 20 }">
								${vo.pntitle }
							</c:if>
							</a></h4>
							<div><img src="${ctx }/crowdfunding/Skin/Default/images/trianglegray.png">
							项目:【<a href="${ctx}/crowdfunding/front/toProDetails.ht?projectId=${vo.projectId }" target="_Blank">${vo.pname }</a>】
							<span><a href="${ctx }/tcproject/ProjectDynamic/ProjectNewList.ht?projectId=${vo.projectId }" target="_Blank">本项目所有动态</a></span></div>
							<p>
							<span class="cl">
							<c:if test="${fn:length(vo.pncontent) > 105 }">
								${fn:substring(vo.pncontent,0,105) }...
							</c:if>
							<c:if test="${fn:length(vo.pncontent) <= 105 }">
								${vo.pncontent }
							</c:if>
							</span>
							<a href="${ctx }/tcproject/ProjectDynamic/edit.ht?newsId=${vo.newsId }" target="_Blank">[详细]</a>
							</p>
							<p><img src="${ctx }/crowdfunding/Skin/Default/images/time.png">发布时间：<fmt:formatDate value="${vo.createTime }" pattern="yyyy-MM-dd HH:mm"/>&nbsp;&nbsp;&nbsp;&nbsp;
							<span>发布者：<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${vo.creator }"/></span></p>
						</div>
						<div class="clear"></div>
					</li>
				</c:forEach>
			</c:if>
			<c:if test="${empty listN }">
				<div  class="hint">暂无内容!</div>
			</c:if>
			</ul>
		</div>
		<!-- 项目动态end -->
		<!--项目评论  -->
			<div class="comments TagContentList">
			<c:if test="${ not empty TUser }">
				<textarea class="commentsTextarea"  id="commentConten_id"></textarea>
				<div class="commentsprompt">
				<em id="_pinglunjinggao" style="color:red;display:none;">请在上面输入你要评论的文字内容！</em>
				<em>温馨提示：发表评论长度不能超过1000个字符！</em>
				<span class="commentsSpan f_r"  onclick="sendTalkmsg(${tcproject.projectId});">发表评论</span></div>
				<div class="commentsList">
					<ul>
					<iframe src="${ctx }/crowdfunding/front/toProComment.ht?projectId=${tcproject.projectId}" style="min-height: 500px;" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height=100% id="iframepage" name="iframepage" onLoad="iFrameHeight()" ></iframe>
					
						
					</ul>
				</div>
			</c:if>
			<c:if test="${ empty TUser }">
			<div  class="hint"><span style="color:red">您尚未登录，暂时不能发表评论！ 你可以</span><a href="${ctx }/loginWeb.jsp"><span style="color:#09f">>>登录</span></a> 或 <a href="${ctx }/user/registerInit.ht"> <span style="color:#09f">>>注册成为投资人</span></a></div>
			</c:if>
			</div>
		<!--项目评论 end  -->
		</c:if>
	</div>
	</div>
		<div class="InPrcontentright f_l">
		<h3><img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont.png">创业者</h3>
		<div class="InPruser">
			<c:choose>
				<c:when test="${empty tcproject.myPhoto}">
				
				
				
					<img src="${ctx }/crowdfunding/Skin/Default/images/headportrait.png">
				</c:when>
				<c:otherwise>
					<img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${tcproject.myPhoto}" width="104" height="107" alt="">
				</c:otherwise>
			</c:choose>
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
				
				<%-- <c:choose>
					<c:when test="${tcproject.pstateId eq '1' or tcproject.pstateId eq '2' or tcproject.pstateId eq '3'  or tcproject.pstateId eq '9'}">
						议价中
					</c:when>
					<c:otherwise>
						<fmt:formatNumber value="${tcproject.psharesPercent}" pattern="###,###.##"   minFractionDigits="2" />%
					</c:otherwise>
				</c:choose> --%>
				<fmt:formatNumber value="${tcproject.psharesPercent}" pattern="###,###.##"   minFractionDigits="2" />%
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
					<span><fmt:formatNumber value="${tcproject.pinvestAmount }" pattern="###,###.##"   minFractionDigits="0" />万</span>
				</li>
				<li>
					<img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont7.png">
					<div>跟投人数</div>
					<a href="${ctx}/crowdfunding/front/toInvestPersonList.ht?projectId=${tcproject.projectId }"
					style="text-decoration:;"><span>${tcproject.pinvestCount }人</span></a>
				</li>

				<!--<li>
				<img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont8.png">
				<div>询价人数</div>
				<span>${tcproject.paskPriceCount }人</span>
			</li>-->
			</ul>
		</div>
			<div class="clear planNum">
				<div>认投完成率：<span>${tcproject.pcomplete }%</span></div>
			</div>
			<div class="planImg"><div style="width:${tcproject.pcomplete }%;"></div></div>
			
			<c:if test="${empty TUser ||  TUser.groupId eq '2'}">
			
			<div class="planButton">
				<ul>
					<li class="InIfgoto" onclick="applyLeader11('${isleader}','${isaskPrice}','${tcproject.pleaderId }','${listInvest }','${tcproject.projectId }','${tcproject.pisFull }');"><img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont2.png">我要领投</li>
					<li class="yuetan" onclick="aboutEntrepre('${collectProjectInfo.creator}','${collectProjectInfo.projectId}');"><img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont3.png">约谈创业者</li>
					<li class="gentou" onclick="applyLeader12('${isaskPrice}','${tcproject.pisFull }','${listInvest }','${alreadyLingtou }');"><img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont4.png">我要跟投</li>
					<li <c:if test="${isCollected}">style="background:#b1b1b1"</c:if><c:if test="${!isCollected}">class="collection"</c:if> onclick="favorite(${tcproject.projectId},${tcproject.creator})">
						<img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont5.png">
						收藏该项目
					</li>
				</ul>
			</div>
			</c:if>
		</div>
		<c:if test="${not empty tcprojectInvest}">
		<h3 class="clear"><img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont.png">项目领投人</h3>
		<div class="InPruser2">
			<div class="InPruserimg">
			
			<c:choose>
				<c:when test="${empty tcprojectInvest.myPhoto}"> 
					<img src="${ctx }/crowdfunding/Skin/Default/images/headportrait.png">
				</c:when>
				<c:otherwise>
					<img src="${ctx}/crowdfunding/upload/getFileById.ht?path=${tcprojectInvest.myPhoto}" width="104" height="107" alt="">
				</c:otherwise>
			</c:choose>
				<input type="hidden" id="creator_2" name="creator" value="${tcprojectInvest.userId}">
				<input type="hidden" id="creatorName_2" name="creatorName" value="${tcprojectInvest.loginName }">
			<div>+发私信</div>
			</div>
			<div class="InPruserlist">
			<p>${tcprojectInvest.loginName }</p>
			<div>投资达人</div>
			<div><a href="javascript:void(0);">>>详细资料</a></div>
			<div>领投金额：<span><fmt:formatNumber value="${tcprojectInvest.piinvest }" pattern="###,###.##"   minFractionDigits="0" />万</span></div>
			<div>认投时间：${tcprojectInvest.piinvestTimeS }</div>
			</div>
			<h6>是否愿意担任有限合伙企业普通合伙人：<span><f:description nodeKey="sf" itemValue="${tcprojectInvest.piisGeneralPartner }"/></span></h6>
		</div>
		<div class="evaluate">
			<h4><img src="${ctx }/crowdfunding/Skin/Default/images/toptriangle.png">尽职调查和条款清单报告：</h4>
			
			<div>
			<c:if test="${not empty tcprojectInvest.PI_DueDoc}">
<%-- 			<a href="${ctx}/crowdfunding/tcprojectAfter/afterFileDownloadById.ht?fileId=${tcprojectInvest.PI_DueDoc}" target="_blank"> --%>
			<a href="javascript:void(0);" onclick="uploadfileDoc(${tcprojectInvest.PI_DueDoc})">
				<img src="${ctx }/crowdfunding/Skin/Default/images/word.png">
			</a>
			</c:if>
			</div>
			<div>
			<c:if test="${empty tcprojectInvest.PI_DueDoc}">
			<span><a href="${ctx }/loan/aboutus/ZYXZDetails.ht"  target="_blank">
			模板下载
			</a></span></c:if>
			<c:if test="${not empty tcprojectInvest.PI_DueDoc}">
			<span>
<%-- 			<a href="${ctx}/crowdfunding/tcprojectAfter/afterFileDownloadById.ht?fileId=${tcprojectInvest.PI_DueDoc}" target="_blank"> --%>
			<a href="javascript:void(0);" onclick="uploadfileDoc(${tcprojectInvest.PI_DueDoc})">
			我要下载
			</a>
			</span></c:if></div>
			<h4><img src="${ctx }/crowdfunding/Skin/Default/images/toptriangle.png">对创业团队评价：</h4>
			<p>${tcprojectInvest.PI_EvaluationTeam }</p>
			<h4><img src="${ctx }/crowdfunding/Skin/Default/images/toptriangle.png">对创业项目评价：</h4>
			<p>${tcprojectInvest.PI_EvaluationProject }</p>
		</div>
		</c:if>
		<c:if test="${not empty listInV}">
		<div class="clear record">
		<h3><img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont.png">跟投记录</h3>
			<c:forEach items="${listInV }" var="vo" begin="0" end="3" varStatus="status">
				<div class="InPruser2">
					<div class="InPruserimg">
					<c:choose>
						<c:when test="${empty vo.myPhoto}">
							<img src="${ctx }/crowdfunding/Skin/Default/images/headportrait.png">
						</c:when>
						<c:otherwise>
							<img src="${ctx}/crowdfunding/upload/getFileById.ht?path=${vo.myPhoto}" width="104" height="107" alt="">
						</c:otherwise>
					</c:choose>
					<input type="hidden" id="creator_${status.count }_${status.count }" name="creator" value="${vo.userId}">
					<input type="hidden" id="creatorName_${status.count }_${status.count }" name="creatorName" value="${vo.loginName }">
					<div>+发私信</div>
					</div>
					<div class="recordlist">
					<p>${vo.loginName }</p>
					<div>认投金额：<span>${vo.piinvest }万</span></div>
					<div>认投时间：${vo.piinvestTimeS }</div>
					</div>
				</div>
			</c:forEach>
			
			<div class="clear recordAll"><a href="${ctx}/crowdfunding/front/toInvestPersonList.ht?projectId=${tcproject.projectId }" onclick="">>>全部跟投人</a></div>
		</div>
		</c:if>
		</div>
	</div>
	</div>
	<form action="${ctx}/loan/tuserMsgRemind/saveMsgRemind.ht" method="post" id="sendForm">
	    <input type="hidden" id="receiverName" name="receiverName" value="${tcproject.loginName}"/>
	    <input type="hidden" id="createrId" name="createrId" value="${tcproject.creator}"/>
	    <input type="hidden" id="projectId" name="projectId" value="${tcproject.projectId}"/>
	    <input type="hidden" id="typeId" name="typeId" value="3"/>
	    <input type="hidden" id="pcomplete" name="pcomplete" value="${tcproject.pcomplete}"/>
	    <input type="hidden" id="rongzishangxian" value="${RECRUITMENT_LIMIT_FINANCING }"/>
	    <input type="hidden" id="IsBindCard" value="${IsBindCard }"/>
	    <input type="hidden" id="EnquiryMoney00" value="${EnquiryMoney00 }"/>
	    
	    <input type="hidden" id="sendContent" name="sendContent" value="${tcproject.leaderLoginName}收藏了 ${tcproject.realName}的${tcproject.pname}"/>
    </form>
	<div id="faqbg"></div>
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
	});
	$('.collection').click(function(){ 
		$(this).css('background','#b1b1b1');
	}); 
	$(function(){ 
		$(".InPruserlist a").click(function(){ 
			
		//	var _val=$(this).parent().find("input[name='creator']").val();
			
			var _val=$("#creator_2").val();
			$.dialog.open('${ctx}/crowdfunding/tcuserInvestor/tcuserInvestorPageDetails.ht?userId='+_val, {
    			title: '详细资料',lock:true});
		}); 
		$(".InPruser span,.InPruserimg div").click(function(){ 
			valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
			<c:if test="${ not empty TUser }">
			var _val=$(this).parent().find("input[name='creator']").val();
			var _id=$(this).parent().find("input[name='creator']").attr("id");
		//	var _var_name=$(this).parent().find("input[name='creatorName']").val();
			var projectId=$("#projectId").val();
			var url='${ctx}/crowdfunding/front/openSendInfoWin.ht?receiverId='+_val+'&projectId='+projectId+'&type_id=1';
			$.dialog.open(url, {
    			title: '发私信',lock:true});
			</c:if>
		}); 
		
		$(".clear a").click(function(){ 
			
			window.location = "${ctx }/loginWeb.jsp";
		}); 
	});
	
	$(function(){ 
	/* 	$(".InIfgoto").click(function(){
						$.dialog.open('./InquiryIframe.html', {
    			title: '询价认筹',lock:true});
					}); */
					
					
					
		$(".yuetan").click(function(){
			//1：创业者 2：投资者
		    <c:if test="${TUser.groupId eq 1 }">
				   openDialog("<div class=\"_warning\">对不起， 创业者不能向别的项目发起约谈!</div>",'40%','25%','3');
				return;
			</c:if>
			valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
			<c:if test="${ not empty TUser }">
			var _val=$("#creator_1").val();
			var projectId=$("#projectId").val();
			var url='${ctx}/crowdfunding/front/openSendInfoWin.ht?receiverId='+_val+'&projectId='+projectId+'&type_id=2';
			$.dialog.open(url, {
    			title: '约谈创业者',lock:true});
			</c:if>
			/* $.dialog.open('./SendPrivateMessages.html', {
    			title: '',lock:true}); */
		}); 
		
		/* $(".gentou").click(function(){
			$.dialog.open('./InquiryIframe.html', {
	title: '询价认筹',lock:true});
		}); */
		
		/* $('.collection').click(function(){ //收藏
			$(this).css('background','#b1b1b1');
		});  */
	});
	
// 关闭窗口（关闭所有弹出窗口）
	function closediv(){
		$("#faqbg").css("display","none"); 
		$("#faqdiv").css("display","none"); 
		$("#faqdiv2").css("display","none");
		
		$("#content_id").val("");
		$("#valiCode_").val("");
	}
	
	function applyView(projectId){
		
		$.ajax({
			url : "${ctx}/crowdfunding/projectApply/applyTheProjectView.ht",
			type : 'post',
			data: "projectId="+projectId,
			success : function(data) {
				openDialog(data,'40%','25%','3');
			}
		});	
	}
	
	function favorite(proId,creator){
		//1：创业者 2：投资者
	    <c:if test="${TUser.groupId eq 1 }">
			   openDialog("<div class=\"_warning\">对不起，只有投资人才能收藏项目!</div>",'40%','25%','3');
			return;
		</c:if>
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
					openDialog("收藏成功!",'40%','25%','3');
					send_message_submit();
				}else if(eval(data)==eval('2')){
					openDialog("你已经收藏过该项目了!",'40%','25%','3');
				}
			},
			error : function(xhr, textStatus, errorThrown) {
			}
		});
	}

	function send_message_submit(){
		$.ajax({
			url : "${ctx}/loan/tuserMsgRemind/saveMsgRemind.ht",
			type : 'post',
			data : $('#sendForm').serialize(),
			dataType : 'json',
			success : function(data,textStatus) {
				//alert("信息发送成功:"+data);
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				//art.dialog("信息发送失败");
			}
		});
	}
	function sendTalkmsg(proId){
		var commentConten_id=$("#commentConten_id").val();
		if(commentConten_id==''){
			$("#_pinglunjinggao").show();
			return;
		}
		if(commentConten_id.length>1000)
		{
			openDialog("发表评论长度不能超过1000个字符！");
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
						openDialog("发表成功!");
						
						 var url="${ctx }/crowdfunding/front/toProComment.ht?projectId="+proId;
						  $("#iframepage").attr("src", url);
						 // window.parent.document.getElementById('iframepage')
						//  $('#iframepage', window.parent.document).attr("src", url);
						 
						 $("#commentConten_id").val("");
						 
					}else {
						openDialog("操作异常!");
					}
				},
				error : function(xhr, textStatus, errorThrown) {
				}
			});
	}
	
	function successFun(proId){
		openDialog("<div style=\"font-size: 15px; color:#666; margin-left: 30px;margin-top: 35px;\">回复成功!</div>",'40%','25%','2');
		var url="${ctx }/crowdfunding/front/toProComment.ht?projectId="+proId;
		  $("#iframepage").attr("src", url);
	}
	
	function applyLeader11(isleader,isaskPrice,leaderId,isgentou,projectId,pisFull){//我要领投
		
		//先判断用户是否登录
		valiLoginTimeout('iframe');
		<c:if test="${ not empty TUser }">
		
		//判断项目是否已经满标 满标就不能再跟投了
		if(eval(pisFull)==1||pisFull=='1'){
			openDialog("<div class=\"_warning\">该项目已融资完成，不能再接受投资了！</div>",'40%','25%','3');
			return;
		}
		
		//判断项目是否已经有领投人了
		if(leaderId!='0'||leaderId!=0){
			openDialog("<div class=\"_warning\">该项目已经有领投人了,一个项目只能有一个领投人!</div>",'40%','25%','3');
			return;
		}
		
		//判断项目是否已经超过融资上限
		var rongzishangxian=$("#rongzishangxian").val();
		var pcomplete=$("#pcomplete").val();
		
		if(rongzishangxian!=''){
			if(eval(pcomplete)>=eval(rongzishangxian)){
				openDialog("<div class=\"_warning\">该项目已经到达融资上限，已经停止融资...</div>",'40%','25%','3');
				return;
			}
		
			
		}
		
		//1：创业者 2：投资者
	    <c:if test="${TUser.groupId eq 1 }">
			   openDialog("<div class=\"_warning\">只有投资人才能进行领投!</div>",'40%','25%','3');
			return;
		</c:if>
		
		//判断用户是否绑定银行卡
		
		var IsBindCard=$("#IsBindCard").val();
		if(IsBindCard!=''&&IsBindCard=='1'){
			   openDialog("<div class=\"_warning\">您还没有绑定银行卡,请先绑定银行卡,</div>",'40%','25%','3');
			   //跳到绑定银行卡页面
			   setTimeout('window.location = "${ctx }/loan/myAccount/myaccountPage.ht?forwordUrl=fromProDetail";',3000); 
			   
				return;
		}
		
		
		//先判断用户有无领投资格.
		if(eval(isleader)==0){
			var message_info = "";
			<c:if test="${TUser.groupId eq  2}">
					message_info = "</div><li class=\"_libtn\" onclick=\"toApplyLeaderPage()\">申请领投资格</li>";
			</c:if>
			//无,发起领投人申请
			openDialog("<div class=\"_warning\">只有领投人才能进行领投!"+message_info,'40%','25%','4');
		}else{
			var enquiryMoney=$("#EnquiryMoney00").val();//如果系统设置 认筹诚意金为0，则部收取认筹诚意金
			//判断用户是否有询价认投资格
			//4/17 根据客户要求 去掉询价功能
			//5/11日 将 询价资格 修改成是否有认筹资格
		 	if(eval(isaskPrice)==0&&eval(enquiryMoney)!=0){
		 		 art.dialog.confirm("您需要先支付项目认筹诚意金，现在就去支付吗?",function(){
					 
					 window.parent.target="_blank";
				 		window.parent.open('${ctx}/crowdfunding/memberCenter/toApplyEnqPage.ht');
				 		$.dialog({
							content:"<span style='font-size:16px;color:#666'>请您在打开的银行页面支付，支付完成前请不要关闭该窗口!</span>",
							lock: true,
							background: 'black',// 背景色#600
							opacity: 0.80,	// 透明度
							height: '100px',
							width: '500px',
							drag: false,
							fixed: true,
							cancel: false,	
							esc:true,  
							 button: [
							          {
							              name: '已完成支付',
							              callback: function() {
							            	  window.location='${ctx}/loan/myAccount/myaccountPage.ht?forwordUrl=investRecord';
							            	//  window.parent.parent.parent.clickMenu('userIcont12');
							              }
							          },{
							              name: '支付遇到问题',
							              callback: function() {
							            	  window.location='${ctx }/loan/aboutus/HelpCenterList.ht';
							              }
							          } ,{
							              name: '关闭',
							              callback: function() {
							            	  window.location.reload(false);
							            	 
							            	}
							          } 
							      ],
						    close:function(){
						    	  closediv();
						    }
						});
					 });
		 		
		 	
				/* $.dialog.open('${ctx}/crowdfunding/memberCenter/toApplyEnqPage.ht', {
					title: '申请项目认筹资格',lock:true,width:'950px',height:'700px',close:function(){
						window.location.reload(false);
					}
				}); */
			}else{ 
				//判断用户是否已经对该项目跟投
				if(isgentou=='1'||isgentou==1){//已经跟投过项目,到追加项目资金
					//openDialog("<div class=\"_warning\">您已经跟投该项目了,不能对该项目领投!</div>",'40%','25%','3');
					applyLeader12('${isaskPrice}','${tcproject.pisFull }','${listInvest }','${alreadyLingtou }');//return;
				}
				else{
					
				/* 	 var url='${ctx }/crowdfunding/front/openinquiryIframe.ht?piisLeader=1&projectId='+$("#projectId").val();
					//有,发起项目领投申请,
					$.dialog.open(url, {
		    			title: '询价认筹',lock:true}); */
		    			
					var url='${ctx }/crowdfunding/front/openinquiryIframeNext.ht?piisLeader='+isleader+"&projectId="+projectId;
					//	$(".submit").click(function(){
					$.dialog.open(url, {
			    	title: '项目认筹',lock:true});	
				}
			}
			
			
		}
		</c:if>
	}
	
	function applyLeader12(isaskPrice,pisFull,isgentou,alreadyLingtou){
		//先判断用户是否登录
		valiLoginTimeout('iframe');
		<c:if test="${ not empty TUser }">
		
		//1：创业者 2：投资者
	    <c:if test="${TUser.groupId eq 1 }">
			   openDialog("<div class=\"_warning\">只有投资人才能进行跟投!</div>",'40%','25%','3');
			return;
		</c:if>
		
		//判断项目是否已经满标 满标就不能再跟投了
		if(eval(pisFull)==1||pisFull=='1'){
			openDialog("<div class=\"_warning\">该项目已融资完成，不能再接受投资了！</div>",'40%','25%','3');
			return;
		}
		
		//判断项目是否已经超过融资上限
		var rongzishangxian=$("#rongzishangxian").val();
		var pcomplete=$("#pcomplete").val();
		
		if(rongzishangxian!=''){
			if(eval(pcomplete)>=eval(rongzishangxian)){
				openDialog("<div class=\"_warning\">该项目已经到达融资上限，已经停止融资...</div>",'40%','25%','3');
				return;
			}
		
			
		}
		//判断用户是否绑定银行卡
		
		var IsBindCard=$("#IsBindCard").val();
		if(IsBindCard!=''&&IsBindCard=='1'){
			   openDialog("<div class=\"_warning\">您还没有绑定银行卡,请先绑定银行卡,</div>",'40%','25%','3');
			   //跳到绑定银行卡页面
			   setTimeout('window.location = "${ctx }/loan/myAccount/myaccountPage.ht?forwordUrl=fromProDetail";',3000); 
			   
				return;
		}
		//判断用户是否有询价认投资格
		var enquiryMoney=$("#EnquiryMoney00").val();//如果系统设置 认筹诚意金为0，则部收取认筹诚意金
		 if(eval(isaskPrice)==0&&eval(enquiryMoney)!=0){//没有询价认投资格 //4/17日 客户要求去掉询价功能 //5/11日 将 询价资格 修改成是否有认筹资格
			 art.dialog.confirm("您需要先支付项目认筹诚意金，现在就去支付吗?",function(){
				 
			 window.parent.target="_blank";
		 		window.parent.open('${ctx}/crowdfunding/memberCenter/toApplyEnqPage.ht');
		 		$.dialog({
					content:"<span style='font-size:16px;color:#666'>请您在打开的银行页面支付，支付完成前请不要关闭该窗口!</span>",
					lock: true,
					background: 'black',// 背景色#600
					opacity: 0.80,	// 透明度
					height: '100px',
					width: '500px',
					drag: false,
					fixed: true,
					cancel: false,	
					esc:true,  
					 button: [
					          {
					              name: '已完成支付',
					              callback: function() {
					            	  window.location='${ctx}/loan/myAccount/myaccountPage.ht?forwordUrl=investRecord';
					            	//  window.parent.parent.parent.clickMenu('userIcont12');
					              }
					          },{
					              name: '支付遇到问题',
					              callback: function() {
					            	  window.location='${ctx }/loan/aboutus/HelpCenterList.ht';
					              }
					          } ,{
					              name: '关闭',
					              callback: function() {
					            	  window.location.reload(false);
					            	 
					            	}
					          } 
					      ],
				    close:function(){
				    	  closediv();
				    }
				});
			 });
			/* $.dialog.open('${ctx}/crowdfunding/memberCenter/toApplyEnqPage.ht', {
				title: '申请项目认筹资格',lock:true,width:'950px',height:'700px',close:function(){
					window.location.reload(false);
				}
			}); */
		  
		}else{ 
			//判断用户是否已经做了该项目的领投人
			/* if(alreadyLingtou=='1'||alreadyLingtou==1){
				openDialog("<div class=\"_warning\">你已经领投该项目了,</div>",'40%','25%','3');
				return;
			} */
			
			//判断用户是否已经跟投过一次(未被创业者拒绝),如果有,则第二次跟投 只能是在第一次跟投基础上,追加 跟投资金
			if(isgentou=='1'||isgentou==1||isgentou=='2'||isgentou==2){//已经跟投过项目,到追加项目资金
				if(isgentou==2||isgentou=='2'){
					 openDialog("<div class=\"_warning\">该项目,您已经打款,不能再跟投了!</div>",'40%','25%','3');
					 return;
				}else{
					var pfinancingAmount = "${tcproject.pfinancingAmount }";
					var url='${ctx }/crowdfunding/front/addtoInvestMoney.ht?projectId='+$("#projectId").val()+"&pfinancingAmount="+pfinancingAmount;
					//有,发起项目跟投申请,
					$.dialog.open(url, {
		    			title: '追加跟投资金',lock:true});
				}
			}else{
				// var url='${ctx }/crowdfunding/front/openinquiryIframe.ht?piisLeader=0&projectId='+$("#projectId").val();//4/17日 客户要求去掉询价功能
				
				 var url='${ctx }/crowdfunding/front/openinquiryIframeNext.ht?piisLeader=0'+"&projectId="+$("#projectId").val();
				//有,发起项目跟投申请,
				$.dialog.open(url, {
	    			title: '项目认筹',lock:true});
			}
		}
		</c:if>
	}
	
	function uploadfileDoc(fileName){
		valiLoginTimeout('iframe');
		<c:if test="${ not empty TUser }">
			var url="${ctx}/crowdfunding/tcprojectAfter/afterFileDownloadById.ht?fileId="+fileName;
			window.location.href=url;
		</c:if>
	}
	
	function toApplyLeaderPage(){
		window.parent.location='${ctx}/loan/myAccount/myaccountPage.ht?forwordUrl=applyLeader';
	}
	
	function iFrameHeight() {
		
	    var ifm= document.getElementById("iframepage");

	    var subWeb = document.frames ? document.frames["iframepage"].document :

			ifm.contentDocument;

	        if(ifm != null && subWeb != null) {

	        ifm.height = subWeb.body.scrollHeight;

	        }

	}
	 function reloadUrl(){
	  	   window.location.reload(true);
	 }
	
	</script>
</body>
</html>

