<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
<%@ include file="/crowdfunding/cssorjs.jsp"%>
<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
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
</style>

</head>

<body>
<div class="PrManaContent">
 <c:if test="${not empty collectProjectInfos }">
  		<c:forEach var="collectProjectInfo" items="${collectProjectInfos}" begin="0" end="3" varStatus="status">
			<ul>
				<li>
					<div class="Invesimg f_l">
				<c:if test="${empty collectProjectInfo.myPhoto}">
				      <img src="${ctx }/crowdfunding/Skin/Default/images/headportrait3.png">
				</c:if>
				<c:if test="${not empty collectProjectInfo.myPhoto}">
				      <img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${collectProjectInfo.myPhoto}">
				</c:if>
						<div onclick="sendMessage('${collectProjectInfo.creator}','${collectProjectInfo.projectId}');" style="cursor: pointer;">+发私信</div>
					</div>
					<div class="PrManaRight f_l">
						<div class="PrManaName"><a href="${ctx }/crowdfunding/front/toProDetails.ht?projectId=${collectProjectInfo.projectId}" target="_blank">${collectProjectInfo.pname}</a><span><img src="${ctx }/crowdfunding/Skin/Default/images/editIcont2.png"><f:description itemValue="${collectProjectInfo.pstateId}" nodeKey="xmzt" /></span></div>
						<div class="PrManaDetails"><img src="${ctx }/crowdfunding/Skin/Default/images/toptriangle.png">地区：<f:description modelCode="t_area"  modelPropertyName="areaName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${collectProjectInfo.pcityId }"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行业：<f:description itemValue="${collectProjectInfo.pindustry}" nodeKey="PIND" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;阶段：<f:description itemValue="${collectProjectInfo.pstage}" nodeKey="PTYPE" /></div>
						<div class="PrManaData">
						<div>融资金额：<span>${collectProjectInfo.pfinancingAmount}万</span>已融金额：<span>${collectProjectInfo.pinvestAmount}万</span>认投完成率：<em>${collectProjectInfo.pcomplete}%</em></div>
						<div>领投金额：<span>${collectProjectInfo.leaderAmount}万</span>跟投金额：<span>${collectProjectInfo.followAmount}万</span>被投资人约谈数：<span>0次</span></div>
						</div>
						<div class="PrManaButton">
						<c:if test="${collectProjectInfo.pstateId eq '3'}">
							<span onclick="ledTou('${isleader}','${isaskPrice}','${collectProjectInfo.pleaderId}','${collectProjectInfo.projectId}','${collectProjectInfo.isDel }');" style="cursor: pointer;">我要领投</span><span onclick="voteTou('${collectProjectInfo.projectId}','${collectProjectInfo.isDel }','${collectProjectInfo.pisFull}');" style="cursor: pointer;">我要跟投</span>
							<span onclick="aboutEntrepre('${collectProjectInfo.creator}','${collectProjectInfo.projectId}');" style="cursor: pointer;">约谈创业者</span>
						</c:if>
							<span onclick="cancelCollect('${collectProjectInfo.attentionId}');"  style="cursor: pointer;">取消收藏</span>
						</div>
					</div>
					<div class="clear"></div>
				</li>
			</ul>
	</c:forEach>
 </c:if>
 <c:if test="${empty collectProjectInfos }">
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
     function toProDetails(projectId){
		 $.dialog.open("${ctx }/crowdfunding/front/toProDetails.ht?projectId="+projectId,
					{title:"项目详情",width:1200,height:1000});
	  } 
   //发送私信
	 function sendMessage(creator,projectId){
		// $.dialog.open("${ctx }/loan/tuserMsgRemind/sendMessage.ht",
					//{title:"发送私信",width:620,height:520});
			var url='${ctx}/crowdfunding/front/openSendInfoWin.ht?receiverId='+creator+'&projectId='+projectId+'&type_id=1';
			$.dialog.open(url, {
 			title: '发私信',lock:true});
	  }
     
     function cancelCollect(AttentionId){
    	 art.dialog.confirm("你确定要取消收藏",function(){
				$.ajax({
					url : "${ctx }/crowdfunding/front/tcprojectinvest/cancelCollect.ht?AttentionId="+AttentionId,
					type : 'post',
					success : function(data) {
						openDialog(data,'','','2',function(){
							reloadUrl();
						});
						setTimeout(reloadUrl,3000);
					}
				});			
			},function(){});
     }
     
   //我要跟投
   function voteTou(ProjectId,isInvest,pisFull){
	 //判断项目是否已经满标 满标就不能再跟投了
		if(eval(pisFull)==1||pisFull=='1'){
			openDialog("<div class=\"_warning\">该项目已融资完成，不能再接受投资了！</div>",'40%','25%','3');
			return;
		}else{
			//判断用户是否已经对该项目跟投
			if(isInvest=='1'||isInvest==1){//已经跟投过项目,到追加项目资金
				//var url='${ctx }/crowdfunding/front/addtoInvestMoney.ht?projectId='+$("#projectId").val();
				var url='${ctx }/crowdfunding/front/addtoInvestMoney.ht?projectId='+ProjectId+"&collectPro=1";
				
				//有,发起项目跟投申请,
				$.dialog.open(url, {
	    			title: '询价认筹   追加跟投资金',lock:true});
			}else{
				art.dialog.confirm("你确定要跟投",function(){
					$.ajax({
							url : "${ctx }/crowdfunding/front/tcprojectinvest/voteTou.ht",
							type : 'post',
							success : function(data) {
								if(data=="0"){
									$.dialog.open('${ctx}/crowdfunding/memberCenter/toApplyEnqPage.ht', {
										title: '申请询价认筹资格',lock:true,width:'950px',height:'700px',close:function(){
											window.location.reload(false);
										}
									});
									//window.parent.parent.location='${ctx}/crowdfunding/memberCenter/toApplyEnqPage.ht';
								}else if(data=="1"){
									var url='${ctx }/crowdfunding/front/openinquiryIframe.ht?piisLeader=0&projectId='+ProjectId;
									//有,发起项目跟投申请,
									$.dialog.open(url, {
						    			title: '询价认筹',lock:true});
								}
							}
					});
				},function(){});
			}
		}
	 
		
   }
   
 //约谈创业者
   function aboutEntrepre(createrId,projectId){
	   art.dialog.confirm("你确定要约谈创业者",function(){
				 $.dialog.open("${ctx }/crowdfunding/front/tcprojectinvest/aboutEntrepre.ht?createrId="+createrId+"&projectId="+projectId,
							{title:"约谈创业者",width:620,height:520});
	   },function(){});
					}
 
//我要领投
function ledTou(isleader,isaskPrice,leaderId,projectId,isInvest){
	if(isInvest=='1'||isInvest==1){//已经跟投过项目,到追加项目资金
		var url='${ctx }/crowdfunding/front/addtoInvestMoney.ht?projectId='+projectId+"&collectPro=1";
		//有,发起项目跟投申请,
		$.dialog.open(url, {
			title: '询价认筹   追加跟投资金',lock:true});
	}else{
		art.dialog.confirm("你确定要领投",function(){
		//判断项目是否已经有领投人了
			if(leaderId!='0'||leaderId!=0){
				openDialog("<div class=\"_warning\">该项目已经有领投人了,一个项目只能有一个领投人!</div>",'40%','25%','3');
				return;
			}
			//先判断用户是否登录
			valiLoginTimeout('iframe');
			//先判断用户有无领投资格.
			if(eval(isleader)==0){
				//无,发起领投人申请
				openDialog("<div class=\"_warning\">只有领投人才能进行领投!</div><li class=\"_libtn\" onclick=\"toApplyLeaderPage()\">"+
						"申请领投资格</li>",'40%','25%','10000');
			}else{
				
				//判断用户是否有询价认投资格
				if(eval(isaskPrice)==0){
					$.dialog.open('${ctx}/crowdfunding/memberCenter/toApplyEnqPage.ht', {
						title: '申请询价认筹资格',lock:true,width:'950px',height:'700px',close:function(){
							window.location.reload(false);
						}
					});
					//window.parent.parent.location='${ctx}/crowdfunding/memberCenter/toApplyEnqPage.ht';
				}else{
					
					 var url='${ctx }/crowdfunding/front/openinquiryIframe.ht?piisLeader=1&projectId='+projectId;
					//有,发起项目领投申请,
					$.dialog.open(url, {
		    			title: '询价认筹',lock:true});
				}
				
			}
		},function(){});
	}
}
function toaskPricePage(){
	window.parent.parent.location='${ctx}/loan/myAccount/myaccountPage.ht?forwordUrl=applyLeader';
}
function toApplyLeaderPage(){
	window.parent.parent.location='${ctx}/loan/myAccount/myaccountPage.ht?forwordUrl=applyLeader';
}
	 	</script>
	 	</body>
 </html>