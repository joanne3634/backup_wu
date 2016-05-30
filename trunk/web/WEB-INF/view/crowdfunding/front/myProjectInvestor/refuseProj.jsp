<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
<%@ include file="/crowdfunding/cssorjs.jsp"%>
<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
<div class="PrManaContent">
<c:if test="${not empty leadProjectInfos }">
      <c:forEach var="leadProjectInfo" items="${leadProjectInfos}">
<div>
			<ul>
				<li>
					<div class="Invesimg f_l">
					<c:if test="${empty leadProjectInfo.myPhoto}">
				        <img src="${ctx }/crowdfunding/Skin/Default/images/headportrait3.png">
					</c:if>
					<c:if test="${not empty leadProjectInfo.myPhoto}">
					   <img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${leadProjectInfo.myPhoto}">
					</c:if>
						<div onclick="sendMessage('${leadProjectInfo.creator}','${leadProjectInfo.projectId}');" style="cursor: pointer;">+发私信</div>
					</div>
					<div class="PrManaRight f_l">
						<div class="PrManaName"><a href="${ctx }/crowdfunding/front/toProDetails.ht?projectId=${leadProjectInfo.projectId}" target="_blank">${leadProjectInfo.pname}</a><span><img src="${ctx }/crowdfunding/Skin/Default/images/editIcont2.png">
						<f:description itemValue="${leadProjectInfo.pstateId}" nodeKey="xmzt" /></span>
						<c:if test="${leadProjectInfo.pisPay == 0 || leadProjectInfo.pisPay == '0'}">
						<em><img src="${ctx }/crowdfunding/Skin/Default/images/refuse.png">未付款</em></c:if>
						<c:if test="${leadProjectInfo.pisPay != 0 && leadProjectInfo.pisPay != '0'}">
						<em><img src="${ctx }/crowdfunding/Skin/Default/images/consent.png">已付款</em></c:if>
						</div>
						
						<div class="PrManaDetails"><img src="${ctx }/crowdfunding/Skin/Default/images/toptriangle.png">地区：<f:description modelCode="t_area"  modelPropertyName="areaName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${leadProjectInfo.pcityId }"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行业：<f:description itemValue="${leadProjectInfo.pindustry}" nodeKey="PIND" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;阶段：<f:description itemValue="${leadProjectInfo.pstage}" nodeKey="PTYPE" /></div>
						<div class="PrManaData">
						<div>融资金额：<span>${leadProjectInfo.pfinancingAmount}万</span>已融金额：<span>${leadProjectInfo.pinvestAmount}万</span>认投完成率：<em>${leadProjectInfo.pcomplete}%</em></div>
						<div><c:if test="${leadProjectInfo.piTypeId!=3}">领</c:if><c:if test="${leadProjectInfo.piTypeId==3}">跟</c:if>投金额：<span>${leadProjectInfo.leaderAmount}万</span>
						<%-- <c:if test="${leadProjectInfo.pivaluation==0}">
						项目估值：<span>不询价</span>
						</c:if>
						项目估值：<span>
							<c:if test="${leadProjectInfo.piTypeId!=3}">
							   ${leadProjectInfo.sumleaderPivaluation}
							</c:if>
							<c:if test="${leadProjectInfo.piTypeId==3}">
							   ${leadProjectInfo.sumlfollowPivaluation}
							</c:if>
						万</span> --%>
						项目估值：<span><fmt:formatNumber value="${leadProjectInfo.pvaluationFinal}" pattern="###,###"  minFractionDigits="0"  />万</span>
						被投资人约谈数：<span>${leadProjectInfo.aboutNum}次</span>
						</div>
						<div>
						            我的<c:if test="${leadProjectInfo.piTypeId!=3}">领</c:if><c:if test="${leadProjectInfo.piTypeId==3}">跟</c:if>投金额：
						            <span>
						                  <c:if test="${leadProjectInfo.piTypeId!=3}">
						                        ${leadProjectInfo.myleaderAmount}万
						                  </c:if>
						                  <c:if test="${leadProjectInfo.piTypeId==3}">
						                        ${leadProjectInfo.myfollowAmount}万
						                  </c:if>
						            </span>
						            我的估值：<span>${leadProjectInfo.pivaluation}万</span>
							<c:if test="${leadProjectInfo.piisCheck==0}">
							<span>审核状态：未审核</span>
							</c:if>
							<c:if test="${leadProjectInfo.piisCheck==1}">
							<span>审核状态：通过</span>
							</c:if>
							<c:if test="${leadProjectInfo.piisCheck==2}">
							<span>审核状态：拒绝</span>
							</c:if>
						</div>
						<div>
						         认投类型：<span><c:if test="${leadProjectInfo.piTypeId!=3}">领</c:if><c:if test="${leadProjectInfo.piTypeId==3}">跟</c:if>投</span>
						</div>
						</div>
						<div class="refuse">
							<h5>拒绝理由:</h5>
							<div>
							<c:choose>
								<c:when test="${leadProjectInfo.pstateId eq '7'}">${leadProjectInfo.pbreakRemark}</c:when>
								<c:otherwise>${leadProjectInfo.pidenyReason}</c:otherwise>
							</c:choose>
							</div>
						</div>
						</div>
					</div>
					<div class="clear"></div>
				</li>
			</ul>
			</div>
	</c:forEach>
</c:if>
	<c:if test="${empty leadProjectInfos }">
	     <div  class="hint">暂无内容!</div>
    </c:if>
	</div>
<div>
<form id="query_id_1_" action="" method="post">
        <pageTag:paging form="query_id_1_"/>
        </form>
 </div>
   <script type="text/javascript">
   //发送私信
	 function sendMessage(creator,projectId){
		// $.dialog.open("${ctx }/loan/tuserMsgRemind/sendMessage.ht",
					//{title:"发送私信",width:620,height:520});
		 var url='${ctx}/crowdfunding/front/openSendInfoWin.ht?receiverId='+creator+'&projectId='+projectId+'&type_id=1';
			$.dialog.open(url, {
			title: '发私信',lock:true});
		  
	  }
	        </script>