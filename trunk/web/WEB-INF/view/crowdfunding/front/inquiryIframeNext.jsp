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
	<title>询价认筹</title>
	<meta name="renderer" content="webkit"/>
  	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/DialogIframe.css">
   
</head>
<body>
<div id="InquiryWindow"> 
<form name="dofrom" id="dofrom" action="${ctx }/crowdfunding/front/doInvest.ht">
	<div id="hi_content">
		<div>
			<div class="InIfNextLeft f_l">
				<h4>项目投资</h4>
				<%-- <c:if test="${yesAsk eq '1' }">
					<div>项目估值：<input type="text" 
					onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" 
				onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" 
					id="pivaluation" onclick="wanig_inf1()" placeholder="请输入内容" name="pivaluation"/>万元&nbsp;&nbsp;&nbsp;<em id="waning_info1"></em></div>
				</c:if> --%><!--4/17 客户要求去掉询价功能  -->
				<%-- <c:if test="${yesAsk ne '1' }">
					 <input type="hidden" id="pivaluation" name="pivaluation"/> 
				</c:if> --%><!--4/17 客户要求去掉询价功能  -->
				<c:if test="${piisLeader eq '1'  }">
				<div style="display:none" >领投类型：<input style="width:15px;" type="radio" onchange="sh_piinvest()"  checked="checked" id="pitypeId_1" name="pitypeId" value="2"/>领投部分
				<input style="width:15px;" type="radio"   id="pitypeId_2" onclick="hi_piinvest()" name="pitypeId" value=""/>领投全部</div>
				</c:if>
				<div id="_hid">投资金额：<input type="text"
				onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" 
				onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"  
				id="piinvest" onchange="wanig_inf3()" onclick="wanig_inf2()" placeholder="请输入内容" name="piinvest"/>万元&nbsp;&nbsp;&nbsp;<em id="waning_info"></em></div>
				
				
				
			</div>
			<%-- <div class="InquiryIframeRight f_r">该项目剩余询价机会<div><c:choose>
				<c:when test="${askPriceNum >0 }">${askPriceNum }</c:when>
				<c:otherwise>0</c:otherwise>
			</c:choose>次</div></div> --%><%-- 4/17 根据客户要求去掉询价功能 --%>
			<div  class="clear InIfNextcontent">
				<div>投资理由：</div>
				<div><textarea rows="6" id="pireasons" name="pireasons" placeholder="请输入内容"></textarea></div>
				<div>我能为创业者提供非资金帮助：</div>
				<div><textarea rows="6" id="pimyHelp" name="pimyHelp" placeholder="请输入内容"></textarea></div>
				<div>是否愿意担任有限合伙企业普通合伙人：
				<input style="width:15px;" type="radio" onclick="setvalue();"   id="piisGeneralPartner_1" name="piisGeneralPartner" value="1"/>是&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input style="width:15px;" type="radio" onclick="setvalue1();"  id="piisGeneralPartner_2"  name="piisGeneralPartner" value="0" checked="checked"/>否</div>
			</div>
		</div>
		<input type="hidden" id="piisLeader" name="piisLeader" value="${piisLeader }"/>
		<input type="hidden" id="pinvestMinLeader" value="${pinvestMinLeader }"/>
		<input type="hidden" id="pinvestMaxLeader" value="${pinvestMaxLeader }"/>
		<input type="hidden" id="pinvestMinFollow" value="${pinvestMinFollow }"/>
		<input type="hidden" id="pfinancingAmount" value="${pfinancingAmount }"/>
		
		<input type="hidden" id="projectId" name="projectId" value="${projectId }"/>
		<%-- <input type="hidden" id="yesAsk" name="yesAsk" value="${yesAsk }"/> --%><!--4/17 客户要求去掉询价功能  -->
	</div>
	<div id="sh_content" ><em id="_warInfo"></em></div>
	<div class="faqbutton">
	    <div class="submit" onclick="doInvest();" id="hi_btn">确认完成</div><div class="cancel" onclick="closediv()">取消</div>
	</div>
</form>
</div>
	<script type="text/javascript">
		function closediv(){
			var list = window.parent.art.dialog.list;
			for (var i in list) {
			    list[i].close();
			};
		}
		
		function doInvest(){
			var piisLeader=$("#piisLeader").val();
			var piinvest=$("#piinvest").val();
			var pinvestMinLeader=$("#pinvestMinLeader").val();//最低领投金额
			var pinvestMaxLeader=$("#pinvestMaxLeader").val();//最大领投金额
			var pinvestMinFollow=$("#pinvestMinFollow").val();//最低跟投金额
			var pfinancingAmount=$("#pfinancingAmount").val();//项目融资金额
			
			if(piisLeader=='1'||piisLeader==1){//如果是领投人
				//如果领投部分 判断领投金额是否小于项目要求的最低领投额
				
				if($('#pitypeId_1').is(':checked')){//是否部分领投
					if(parseFloat(piinvest)*parseFloat("10000")<parseFloat(pinvestMinLeader)){
						
						$("#waning_info").html("<span style=\"font-size: 12px;color: red\">领投金额不能小于"+parseFloat(pinvestMinLeader)/parseFloat("10000")+"万元!</span>");
						return;
					}
					if(parseFloat(piinvest)*parseFloat("10000")>parseFloat(pinvestMaxLeader)){
						$("#waning_info").html("<span style=\"font-size: 12px;color: red\">领投金额不能大于"+parseFloat(pinvestMaxLeader)/parseFloat("10000")+"万元!</span>");
						return;
					}
				}
			}else{
				if(parseFloat(piinvest)*parseFloat("10000")<parseFloat(pinvestMinFollow)){
					$("#waning_info").html("<span style=\"font-size: 12px;color: red\">跟投投金额不能小于"+parseFloat(pinvestMinFollow)/parseFloat("10000")+"万元!</span>");
					return;
				}
			}
			
			/* if($("#pireasons").val()==''){
				$("#pireasons").attr("placeholder","输入不能为内容!");
				return;
			}
			if($("#pimyHelp").val()==''){
				$("#pimyHelp").attr("placeholder","输入不能为内容!");
				return;
			} */
			
		//	if(confirm("确定提交吗?")){
			//	$('#dofrom').submit();
		//	}
			
			/* String pivaluation=request.getParameter("pivaluation");
			 String piinvest=request.getParameter("piinvest");
			 String pireasons=request.getParameter("pireasons");
			 String pimyHelp=request.getParameter("pimyHelp");
			 String projectId=request.getParameter("projectId");
			 
		//	 String pitypeId=request.getParameter("pitypeId");
		//	 String piisGeneralPartner=request.getParameter("piisGeneralPartner");
			 
			 String piisLeader=request.getParameter("piisLeader");
			 String yesAsk=request.getParameter("yesAsk"); */
			 
	//		 var pivaluation=$("#pivaluation").val();
			 var pireasons=$("#pireasons").val();
			 var pimyHelp=$("#pimyHelp").val();
			 var projectId=$("#projectId").val();
			// var piisLeader=$("#piisLeader").val();
	//		 var yesAsk=$("#yesAsk").val();
			 
	//		 var pitypeId= $('input[name="pitypeId"]:checked').val();/* 客户要求去掉询价 (领投人按领投部分来算) */
			 var piisGeneralPartner= $('input[name="piisGeneralPartner"]:checked').val();
			 var pfinancingAmount=$("#pfinancingAmount").val();//项目融资金额
	//		 var pivaluation=$("#pivaluation").val();//估值金额
			 var pfinancingAmountNew=parseFloat(pfinancingAmount)/parseFloat("10000");
			 var  piisGeneralPartnerValue = $("#piisGeneralPartner_1").val();
			 var  piinvestValue = $("#piinvest").val();
			/*  if("${yesAsk eq '1'}"==true){//<!--4/17 客户要求去掉询价功能  -->
				 if( pivaluation<pfinancingAmountNew){
					 openDialog("<div class=\"_warning\">项目估值金额不能低于项目融资金额!</div>",'40%','25%','3');
				return;
				 }
			 }else{ */
				 if( eval(piinvestValue)>eval(pfinancingAmountNew)){
					 openDialog("<div class=\"_warning\">投资金额不能高于项目融资金额!</div>",'40%','25%','3');
				return;
				 }
		//	 }
			 
				 $.ajax({
						url : "${ctx}/crowdfunding/front/doInvest.ht",
						type : 'post',
						data : 'projectId=' + projectId + /* '&pivaluation=' + pivaluation+ *///客户要求 去掉询价功能
						'&pireasons='+pireasons+'&pimyHelp='+pimyHelp+'&piisLeader='+piisLeader+
						/* '&yesAsk='+yesAsk+ *//* '&pitypeId='+pitypeId+ *//* (领投人按领投部分来算) */'&piisGeneralPartner='+piisGeneralPartner+
						'&piinvest='+piinvest
						,
						dataType : 'json',
						success : function(data, status) {
							if(eval(data)==eval('1')){
							 $("#hi_content").hide();
							 $("#hi_btn").hide();
							 $(".cancel").css("display","none");
							 $("#_warInfo").html("<span style=\"font-size: 16px;color: #666\">申请已发出,请等待创业者审核!</span>");
							 $("#sh_content").show();
							 setTimeout("closediv()",3000);
							 window.parent.window.location = '${ctx}/crowdfunding/front/toProDetails.ht?projectId='+projectId;
							 
							}else {
								 $("#hi_content").hide();
								 $("#hi_btn").hide();
								 $(".cancel").css("display","none");
								 $("#_warInfo").html("<span style=\"font-size: 16px;color: #666\">操作异常!</span>");
								 $("#sh_content").show();
								 setTimeout("closediv()",3000);
								window.parent.window.location = '${ctx}/crowdfunding/front/toProDetails.ht?projectId='+projectId;
							}
						},
						error : function(xhr, textStatus, errorThrown) {
						}
					});
		}
		
		function sh_piinvest(){
			$("#pitypeId_1").val("2");
			$("#pitypeId_2").val("");
			
			$("#_hid").show();
		}
		
		function hi_piinvest(){
			$("#pitypeId_1").val("");
			$("#pitypeId_2").val("1");
			$("#piinvest").val("");
			$("#_hid").hide();
		}
		
		function wanig_inf1(){
			var pfinancingAmount=$("#pfinancingAmount").val();//项目融资金额
			var pivaluation=$("#pivaluation").val();//估值金额
			var pfinancingAmountNew=parseFloat(pfinancingAmount)/parseFloat("10000");
			if($("#pivaluation").val()==''){
				$("#waning_info1").html("<span style=\"font-size: 12px;color: #666\">不能小于融资金额!</span>");
			}else if(pivaluation<pfinancingAmountNew){
				$("#waning_info1").html("<span style=\"font-size: 12px;color: #666\">项目估值金额不能低于项目融资金额!</span>");
			}
		}
		function wanig_inf2(){
			if($("#piinvest").val()==''){
				$("#waning_info").html("<span style=\"font-size: 12px;color: #666\">投资金额不能为空!</span>");
				
			}
		}
		
		function setvalue(){
			$("#piisGeneralPartner_1").val("1");
			$("#piisGeneralPartner_2").val("");
		}
		function setvalue1(){
			$("#piisGeneralPartner_1").val("");
			$("#piisGeneralPartner_2").val("0");
		}
		function wanig_inf3(){
			var piisLeader=$("#piisLeader").val();
			var piinvest=$("#piinvest").val();
			var pinvestMinLeader=$("#pinvestMinLeader").val();//最低领投金额
			var pinvestMaxLeader=$("#pinvestMaxLeader").val();//最大领投金额
			var pinvestMinFollow=$("#pinvestMinFollow").val();//最低跟投金额
			if($('#pitypeId').is(':checked')){//是否部分领投
				if(piisLeader=='1'||piisLeader==1){//如果是领投人
					//如果领投部分 判断领投金额是否小于项目要求的最低领投额
					if(parseFloat(piinvest)*parseFloat("10000")<parseFloat(pinvestMinLeader)){
						
						$("#waning_info").html("<span style=\"font-size: 12px;color: #666\">领投金额不能小于"+parseFloat(pinvestMinLeader)/parseFloat("10000")+"万元!</span>");
					}
					if(parseFloat(piinvest)*parseFloat("10000")>parseFloat(pinvestMaxLeader)){
						$("#waning_info").html("<span style=\"font-size: 12px;color: #666\">领投金额不能大于"+parseFloat(pinvestMaxLeader)/parseFloat("10000")+"万元!</span>");
					}
				}else{
					if(parseFloat(piinvest)*parseFloat("10000")<parseFloat(pinvestMinFollow)){
						$("#waning_info").html("<span style=\"font-size: 12px;color: #666\">跟投投金额不能小于"+parseFloat(pinvestMinFollow)/parseFloat("10000")+"万元!</span>");
					}
				}
			}
		}
	</script>
</body>
</html>
