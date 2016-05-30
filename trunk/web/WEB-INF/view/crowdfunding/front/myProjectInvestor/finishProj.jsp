<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
<%@ include file="/crowdfunding/cssorjs.jsp"%>
<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
<div class="PrManaContent">
<c:if test="${not empty finishProjectInfos }">
    <c:forEach var="finishPro" items="${finishProjectInfos}">
			<ul>
				<li>
					<div class="Invesimg f_l">
				    <c:if test="${empty finishPro.myPhoto}">
				        <img src="${ctx }/crowdfunding/Skin/Default/images/headportrait3.png">
					</c:if>
					<c:if test="${not empty finishPro.myPhoto}">
					   <img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${finishPro.myPhoto}">
					</c:if>
					<div onclick="sendMessage('${finishPro.creator}','${finishPro.projectId}');" style="cursor: pointer;">+发私信</div>
					</div>
					<div class="PrManaRight f_l">
						<div class="PrManaName"><a href="${ctx }/crowdfunding/front/toProDetails.ht?projectId=${finishPro.projectId}" target="_blank">${finishPro.pname}</a><span><img src="${ctx }/crowdfunding/Skin/Default/images/editIcont2.png"><f:description itemValue="${finishPro.pstateId}" nodeKey="xmzt" /></span></div>
						<div class="PrManaDetails"><img src="${ctx }/crowdfunding/Skin/Default/images/toptriangle.png">地区：<f:description modelCode="t_area"  modelPropertyName="areaName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${finishPro.pcityId }"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行业：<f:description itemValue="${finishPro.pindustry}" nodeKey="PIND" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;阶段：<f:description itemValue="${finishPro.pstage}" nodeKey="PTYPE" /></div>
						<div class="PrManaData">
							<div>融资金额：<span>${finishPro.pfinancingAmount}万</span>已融金额：<span>${finishPro.pinvestAmount}万</span>认投完成率：<em>${finishPro.pcomplete}%</em></div>
							<div>领投金额：<span>${finishPro.leaderAmount}万</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;跟投金额：<span>${finishPro.followAmount}万</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;被投资人约谈数：<span>${finishPro.aboutNum}次</span></div>
						</div>
					</div>
					<div class="clear"></div>
				</li>
			</ul>
	</c:forEach>
</c:if>
 <c:if test="${empty finishProjectInfos }">
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