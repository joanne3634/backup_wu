<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
<%@ include file="/crowdfunding/cssorjs.jsp"%>
<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">

	<div class="PrManaContent">
<c:if test="${not empty voteProjectInfos }">
		<c:forEach var="voteProjectInfo" items="${voteProjectInfos}">
			<ul>
				<li>
					<div class="Invesimg f_l">
				    <c:if test="${empty voteProjectInfo.myPhoto}">
				        <img src="${ctx }/crowdfunding/Skin/Default/images/headportrait3.png">
					</c:if>
					<c:if test="${not empty voteProjectInfo.myPhoto}">
					   <img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${voteProjectInfo.myPhoto}">
					</c:if>
						<div onclick="sendMessage('${voteProjectInfo.creator}','${voteProjectInfo.projectId}');" style="cursor: pointer;">+发私信</div>
					</div>
					<div class="PrManaRight f_l">
						<div class="PrManaName"><a href="${ctx }/crowdfunding/front/toProDetails.ht?projectId=${voteProjectInfo.projectId}" target="_blank">${voteProjectInfo.pname}</a><span><img src="${ctx }/crowdfunding/Skin/Default/images/editIcont2.png"><f:description itemValue="${voteProjectInfo.pstateId}" nodeKey="xmzt" /></span>
						<c:if test="${voteProjectInfo.piisPay == 0 || voteProjectInfo.piisPay == '0'}">
						<em><img src="${ctx }/crowdfunding/Skin/Default/images/refuse.png">未付款</em></c:if>
						<c:if test="${voteProjectInfo.piisPay == 1 && voteProjectInfo.piisPay == '1'}">
						<em><img src="${ctx }/crowdfunding/Skin/Default/images/consent.png">已付款</em></c:if>
						</div>
						<div class="PrManaDetails"><img src="${ctx }/crowdfunding/Skin/Default/images/toptriangle.png">地区：<f:description modelCode="t_area"  modelPropertyName="areaName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${voteProjectInfo.pcityId }"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;行业：<f:description itemValue="${voteProjectInfo.pindustry}" nodeKey="PIND" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;阶段：<f:description itemValue="${voteProjectInfo.pstage}" nodeKey="PTYPE" /></div>
						<div class="PrManaData">
					    <div>融资金额：<span>${voteProjectInfo.pfinancingAmount}万</span>已融金额：<span>${voteProjectInfo.pinvestAmount}万</span>认投完成率：<em>${voteProjectInfo.pcomplete}%</em></div>
						<div>跟投金额：<span>${voteProjectInfo.followAmount}万</span>
						
						<%-- <c:if test="${voteProjectInfo.piisAskPrice=='1'}">
					<!-- 	项目估值 --> 我的估值：<span>
						<fmt:formatNumber value="${voteProjectInfo.pivaluation}" pattern="###,###"  minFractionDigits="0"  />万
						</span>
						</c:if>
						<c:if test="${voteProjectInfo.piisAskPrice=='0'}">
							<!-- 项目估值 --> 我的估值：<span>不询价</span>
						</c:if> --%>
						项目估值：<span><fmt:formatNumber value="${voteProjectInfo.pvaluationFinal}" pattern="###,###"  minFractionDigits="0"  />万</span>
						被投资人约谈数：<span>${voteProjectInfo.aboutNum}次</span></div>
						<div>
						            我的跟投金额：<span>
						             <fmt:formatNumber value="${voteProjectInfo.piinvest/10000}" pattern="###,###"  minFractionDigits="0"  />万
						            </span>
						<%-- <c:if test="${voteProjectInfo.pivaluation!=0}">
						           我的估值：<span>${voteProjectInfo.pivaluation}
						          万
						           </span>
					   </c:if>
						<c:if test="${voteProjectInfo.pivaluation==0}">
						  我的估值：<span>不询价</span>
						</c:if> --%>
							<c:if test="${voteProjectInfo.piisCheck==0}">
							<span>审核状态：待创业者审核</span>
							</c:if>
							<c:if test="${voteProjectInfo.piisCheck==1}">
							<span>审核状态：通过</span>
							</c:if>
							<c:if test="${voteProjectInfo.piisCheck==2}">
							<span>审核状态：拒绝</span>
							</c:if>
						</div>
						</div>
						<div class="PrManaButton">
						<c:if test="${voteProjectInfo.piisPay == 0 || voteProjectInfo.piisPay == '0'}">
							<c:if test="${voteProjectInfo != null && voteProjectInfo.piisCheck !=1}">
			                    <span id="dosubmitbtn" style="display: inline-block;font-size: 16px;width: 80px;height: 20px;line-height: 20px;background: #C0C0C0;color: #fff;margin-right: 15px;cursor: pointer;">我要付款</span>
			                </c:if>
			                <c:if test="${voteProjectInfo.piisCheck==1}">
								<span onclick="payMoneyVote('${voteProjectInfo.projectId}','${voteProjectInfo.investId}')"  style="cursor: pointer;">我要付款</span>
							</c:if>	
						
						<span onclick="aboutEntrepre('${voteProjectInfo.creator}','${voteProjectInfo.projectId}','${voteProjectInfo.createTimestr}');" style="cursor: pointer;">再次约谈</span>
						<span onclick="cancelVote('${voteProjectInfo.investId}','${voteProjectInfo.projectId}','${askPrice}');"  style="cursor: pointer;">取消跟投</span>
						</c:if>
						</div>
					</div>
					<div class="clear"></div>
				</li>
			</ul>
	</c:forEach>
</c:if>
<c:if test="${empty voteProjectInfos }">
		 <div  class="hint">暂无内容!</div>
</c:if>
</div>
<div>
<form id="query_id_1_" action="${ctx}/crowdfunding/front/tcprojectinvest/voteProj.ht" method="post">
        <pageTag:paging form="query_id_1_"/>
        </form>
 </div>
   <script type="text/javascript">
   function reloadUrl(){
  	   window.location.href="${ctx}/crowdfunding/front/tcprojectinvest/voteProj.ht";
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
   function payMoneyVote(projectid,investId){
	
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
   
  
   //发送私信
	 function sendMessage(creator,projectId){
		// $.dialog.open("${ctx }/loan/tuserMsgRemind/sendMessage.ht",
					//{title:"发送私信",width:620,height:520});
		 var url='${ctx}/crowdfunding/front/openSendInfoWin.ht?receiverId='+creator+'&projectId='+projectId+'&type_id=1';
			$.dialog.open(url, {
			title: '发私信',lock:true});
			$.dialog.close();
		  
	  }
   
        function cancelVote(investId,pid,askPrice){
	//取消领投
        	//取消领投
        	art.dialog.confirm("你确定要取消跟投吗？,反悔后将失去项目认筹资格</br>&nbsp;要取得认筹资格就得重新缴纳认筹诚意金"+askPrice+"元,你确定要反悔吗？",function(){
        		$.ajax({
        			url : "${ctx }/crowdfunding/front/tcprojectinvest/cancelVote.ht",
        			type : 'post',
        			dataType : 'json',
        			data:{investId:investId,projectid:pid},
        			success : function(data) {
        				 window.parent.parent.openDialog(data,'','','2',function(){});
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
        							window.parent.openDialog("24小时只能约谈一次",'','','2',function(){
        								reloadUrl();
        							});
        							setTimeout(reloadUrl,3000);
        						}else if(data=="1"){
        							var url="${ctx }/crowdfunding/front/tcprojectinvest/aboutEntrepre.ht?createrId="+createrId+"&projectId="+projectId+"&sendTime="+sendTime;
        							$.dialog.open(url, {
        				    			title: '再次约谈',width:620,height:520});
        						}
        					}
        			});
        		});
        }
     function payMoney(){
    	 $.dialog.open('${ctx}/crowdfunding/memberCenter/toApplyEnqPage.ht', {
				title: '申请询价认筹资格',lock:true,width:'950px',height:'700px',close:function(){
					window.location.reload(false);
				}
			});
    	// window.parent.parent.location='${ctx}/crowdfunding/memberCenter/toApplyEnqPage.ht';
     }
     /**
      * 上传调查报告与评价
      */
     function uploadSurvey(projectid,investId){
     	$.dialog.open("${ctx }/crowdfunding/front/tcprojectinvest/uploadSurvey.ht?projectId="+projectid+"&investId="+investId,
     			{title:"上传调查报告与评价",width:620,lock:true,top:'0px',height:520});
     }
      </script>