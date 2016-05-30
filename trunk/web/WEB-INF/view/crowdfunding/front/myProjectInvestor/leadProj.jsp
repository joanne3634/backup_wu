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
						<c:if test="${leadProjectInfo.piisPay == 0 || leadProjectInfo.piisPay == '0'}">
						<em><img src="${ctx }/crowdfunding/Skin/Default/images/refuse.png">未付款</em></c:if>
						<c:if test="${leadProjectInfo.piisPay != 0 && leadProjectInfo.piisPay != '0'}">
						<em><img src="${ctx }/crowdfunding/Skin/Default/images/consent.png">已付款</em></c:if>
						</div>
						<div class="PrManaDetails"><img src="${ctx }/crowdfunding/Skin/Default/images/toptriangle.png">地区：<f:description modelCode="t_area"  modelPropertyName="areaName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${leadProjectInfo.pcityId }"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行业：<f:description itemValue="${leadProjectInfo.pindustry}" nodeKey="PIND" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;阶段：<f:description itemValue="${leadProjectInfo.pstage}" nodeKey="PTYPE" /></div>
						<div class="PrManaData">
						<div>融资金额：<span>${leadProjectInfo.pfinancingAmount}万</span>已融金额：<span>${leadProjectInfo.pinvestAmount}万</span>认投完成率：<em>${leadProjectInfo.pcomplete}%</em></div>
						<div>领投金额：<span>${leadProjectInfo.leaderAmount}万</span>
						<%-- <c:if test="${leadProjectInfo.pivaluation==0}">
						项目估值：<span>不询价</span>
						</c:if>
						<c:if test="${leadProjectInfo.sumPivaluation!=0}">
						项目估值：<span>${leadProjectInfo.sumPivaluation}万</span>
						</c:if> --%>
						项目估值：<span><fmt:formatNumber value="${leadProjectInfo.pvaluationFinal}" pattern="###,###"  minFractionDigits="0"  />万</span>
						被投资人约谈数：<span>${leadProjectInfo.aboutNum}次</span>
						</div>
						<div>
						            我的领投金额：<span>${leadProjectInfo.myleaderAmount}万</span>
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
						</div>
						<div class="PrManaButton">
						<c:if test="${leadProjectInfo.piisPay == 0 || leadProjectInfo.piisPay == '0'}">
							<c:if test="${leadProjectInfo != null && leadProjectInfo.piisCheck !=1}">
			                    <span id="dosubmitbtn" style="display: inline-block;font-size: 16px;width: 80px;height: 20px;line-height: 20px;background: #C0C0C0;color: #fff;margin-right: 15px;cursor: pointer;">我要付款</span>
			                </c:if>
			                <c:if test="${leadProjectInfo.piisCheck==1}">
								<span onclick="payMoney('${leadProjectInfo.projectId}','${leadProjectInfo.investId}')"  style="cursor: pointer;">我要付款</span>
							</c:if>	
						
						<span onclick="aboutEntrepre('${leadProjectInfo.creator}','${leadProjectInfo.projectId}','${leadProjectInfo.createTimestr}');" style="cursor: pointer;">再次约谈</span>
						<span onclick="cancelLed('${leadProjectInfo.investId}','${leadProjectInfo.projectId}','${askPrice}');"  style="cursor: pointer;">取消领投</span>
						</c:if>
						<span onclick="uploadSurvey('${leadProjectInfo.projectId}','${leadProjectInfo.investId}')" class="UploadSurvey">上传调查报告与评价</span>
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
   
   function reloadUrl(){
  	   window.location.reload(true);
  }
 //发送私信
	 function sendMessage(creator,projectId){
		// $.dialog.open("${ctx }/loan/tuserMsgRemind/sendMessage.ht",
				//	{title:"发送私信",width:620,height:520});
		 var url='${ctx}/crowdfunding/front/openSendInfoWin.ht?receiverId='+creator+'&projectId='+projectId+'&type_id=1';
			$.dialog.open(url, {
			title: '发私信',lock:true});
		  
	  }
 
function openPostWindow(url, data, name,investId){  
	           var tempForm = document.createElement("form");  
	           tempForm.id="tempForm1";  
	          tempForm.method="post";  
	           tempForm.action=url;  
	           tempForm.target=name;  
	           
	           var hideInput = document.createElement("input");  
	          hideInput.type="hidden";  
	          hideInput.name= "projectId";
	          hideInput.value= data;
	          tempForm.appendChild(hideInput);   
	          
	          var hideInput1 = document.createElement("input");  
	          hideInput1.type="hidden";  
	          hideInput1.name= "investId";
	          hideInput1.value= investId;
	          tempForm.appendChild(hideInput1);  
	          
	          document.body.appendChild(tempForm);  
	          tempForm.submit();
}

 function payMoney(projectid,investId){
	
					art.dialog.confirm("你确定要付款吗?",function(){
						 url="${ctx }/crowdfunding/front/tcprojectinvest/toPayment.ht";
						
							openPostWindow(url,projectid,"_blank",investId);
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
								            	  window.parent.parent.parent.loadPages('${ctx}/crowdfunding/memberCenter/toinvestList.ht');
								            	  window.parent.parent.parent.clickMenu('userIcont12');
								              }
								          },{
								              name: '支付遇到问题',
								              callback: function() {
								            	  window.parent.parent.location='${ctx }/loan/aboutus/HelpCenterList.ht';
								              }
								          }/* ,{
								              name: '关闭',
								              callback: function() {
								            	
								            	  closediv();
								            	}
								          } */
								      ],
							    close:function(){
							    	  closediv();
							    }
							});
					});
					
	
 }
function cancelLed(investId,pid,askPrice){
	//取消领投
	art.dialog.confirm("你确定要取消领投吗?,反悔后将失去项目认筹资格</br>要取得项目认筹资格就得重新缴纳认筹诚意金 "+askPrice+"元,你确定要反悔吗？",function(){
		$.ajax({
			url : "${ctx }/crowdfunding/front/tcprojectinvest/cancelLed.ht",
			type : 'post',
			dataType : 'json',
			data:{investId:investId,projectid:pid},
			success : function(data) {
				var parent = window.parent.parent;
				parent.openDialog(data,'','','2',function(){});
				setTimeout(reloadUrl,3000);
			}
		});			
	},function(){});
}
//约谈创业者
function aboutEntrepre(createrId,projectId,sendTime){
		art.dialog.confirm("你确定要再次约谈",function(){
			$.ajax({
					url : "${ctx }/crowdfunding/front/tcprojectinvest/timeLimit.ht?sendTime="+sendTime,
					type : 'post',
					dataType : 'json',
					success : function(data) {
						if(data=="0"){
							art.dialog("24小时只能约谈一次");
							setTimeout(reloadUrl,3000);
						}/* else if(data=="2"){
							art.dialog("第一次约谈的时间不能为空");
							setTimeout(reloadUrl,3000);
						} */else if(data=="1"||data=="2"){
							var url="${ctx }/crowdfunding/front/tcprojectinvest/aboutEntrepre.ht?createrId="+createrId+"&projectId="+projectId+"&sendTime="+sendTime;
							$.dialog.open(url, {
				    			title: '再次约谈',width:620,height:520});
						}
					}
			});
		});
}
/**
 * 上传调查报告与评价
 */
function uploadSurvey(projectid,investId){
	//检查当前用户是否有查看项目的权限
	$.ajax({
		url : "${ctx }/crowdfunding/projectApply/checkViewProjectPrivilage.ht",
		type : 'post',
		async:false,
		dataType : 'json',
		data:{projectId:projectid},
		success : function(data) {
			if(data=="yes"){
				$.dialog.open("${ctx }/crowdfunding/front/tcprojectinvest/uploadSurvey.ht?projectId="+projectid+"&investId="+investId,
						{title:"上传调查报告与评价",width:680,lock:true,top:'0px',height:590});
			}else{
				window.parent.parent.openDialog("您没有权限上传调查报告与评价!",'','','2',function(){});
			} 
		}
    });
}
 </script>
 