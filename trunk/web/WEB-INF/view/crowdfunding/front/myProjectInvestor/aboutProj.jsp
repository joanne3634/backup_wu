<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
<%@ include file="/crowdfunding/cssorjs.jsp"%>
<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
<div class="PrManaContent">
<c:if test="${not empty aboutProjectInfos }">
	<c:forEach var="aboutProjectInfo" items="${aboutProjectInfos}">
				<ul>
					<li>
					<div class="Invesimg f_l">
					<c:if test="${empty aboutProjectInfo.myPhoto}">
				        <img src="${ctx }/crowdfunding/Skin/Default/images/headportrait3.png">
					</c:if>
					<c:if test="${not empty aboutProjectInfo.myPhoto}">
					   <img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${aboutProjectInfo.myPhoto}">
					</c:if>
							<div onclick="sendMessage('${aboutProjectInfo.creator}','${aboutProjectInfo.projectId}');" style="cursor: pointer;">+发私信</div>
						</div>
						<div class="PrManaRight f_l">
							<div class="PrManaName"><a href="${ctx }/crowdfunding/front/toProDetails.ht?projectId=${aboutProjectInfo.projectId}" target="_blank">${aboutProjectInfo.pname}</a><span><img src="${ctx }/crowdfunding/Skin/Default/images/editIcont2.png"><f:description itemValue="${aboutProjectInfo.pstateId}" nodeKey="xmzt" /></span></div>
							<div class="PrManaDetails"><img src="${ctx }/crowdfunding/Skin/Default/images/toptriangle.png">地区：<f:description modelCode="t_area"  modelPropertyName="areaName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${aboutProjectInfo.pcityId }"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行业：<f:description itemValue="${aboutProjectInfo.pindustry}" nodeKey="PIND" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;阶段：<f:description itemValue="${aboutProjectInfo.pstage}" nodeKey="PTYPE" /></div>
							<div class="PrManaData">
								<div>融资金额：<span>${aboutProjectInfo.pfinancingAmount}万</span>已融金额：<span>${aboutProjectInfo.pinvestAmount}万</span>认投完成率：<em>${aboutProjectInfo.pcomplete}%</em></div>
						        <div>领投金额：<span>${aboutProjectInfo.leaderAmount}万</span>跟投金额：<span>${aboutProjectInfo.followAmount}万</span>被投资人约谈数：<span>${aboutProjectInfo.aboutNum}次</span></div>
							</div>
							<div class="PrManaButton">
								<span onclick="aboutEntrepre('${aboutProjectInfo.creator}','${aboutProjectInfo.projectId}','${aboutProjectInfo.createTimestr}');" style="cursor: pointer;">再次约谈</span>
							</div>
							</div>
							<div class="clear"></div>
					</li>
				</ul>
		</c:forEach>
	</c:if>
	<c:if test="${empty aboutProjectInfos }">
	    <div  class="hint">暂无内容!</div>
    </c:if>
	</div>
	
	<div>
<form id="query_id_1_" action="" method="post">
        <pageTag:paging form="query_id_1_"/>
        </form>
 </div>
	<script type="text/javascript">
	   function reloadUrl(){
	  	   window.location.reload(true);
	  }
	//发送私信
	 function sendMessage(creator,projectId){
		 //$.dialog.open("${ctx }/loan/tuserMsgRemind/sendProjectPrivateInfo.ht?createrId="+createrId+"&projectId="+projectId,
					//{title:"发送私信",width:620,height:520});
		 var url='${ctx}/crowdfunding/front/openSendInfoWin.ht?receiverId='+creator+'&projectId='+projectId+'&type_id=1';
			$.dialog.open(url, {
			title: '发私信',lock:true});
		  
	  }
	//约谈创业者
   function aboutEntrepre(createrId,projectId,sendTime){
		$.ajax({
				url : "${ctx }/crowdfunding/front/tcprojectinvest/timeLimit.ht?sendTime="+sendTime+"&projectId="+projectId,
				type : 'post',
				dataType : 'json',
				success : function(data) {
					if(data=="0"){
						art.dialog("24小时只能约谈一次");
						setTimeout(reloadUrl,2000);
					}else if(data=="1"){
						var url="${ctx }/crowdfunding/front/tcprojectinvest/aboutEntrepre.ht?createrId="+createrId+"&projectId="+projectId+"&sendTime="+sendTime;
						$.dialog.open(url, {
			    			title: '再次约谈',lock:true,width:620,height:520});
					}
				}
		});
   }

   	 	</script>