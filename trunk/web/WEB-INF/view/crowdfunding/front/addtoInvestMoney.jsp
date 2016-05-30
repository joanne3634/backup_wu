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
	<title>询价认筹   追加投资金额</title>
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
				
				
				<div id="_hid">追加投资金额：<input type="text" id="piinvest"  
				onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" 
				onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" 
				onclick="wanig_inf2()" placeholder="请输入内容" name="piinvest"/>万元&nbsp;&nbsp;&nbsp;<em id="waning_info"></em></div>
				
				
				
			</div>
			<!--<div class="InquiryIframeRight f_r">追加投资不减询价次数</div>  -->
			</div>
			<div  class="clear InIfNextcontent">
				
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
			var pfinancingAmount = $("#pfinancingAmount").val();
			/* var pinvestMinLeader=$("#pinvestMinLeader").val();//最低领投金额
			var pinvestMaxLeader=$("#pinvestMaxLeader").val();//最大领投金额
			var pinvestMinFollow=$("#pinvestMinFollow").val();//最低跟投金额 */
			
			//**** 备注:看需不需要设置最高跟投上限.如果需要则在此判断.
			
			
			/* if(piisLeader=='1'||piisLeader==1){//如果是领投人
				//如果领投部分 判断领投金额是否小于项目要求的最低领投额
				
				if($('#pitypeId').is(':checked')){//是否部分领投
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
			} */
			
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
			 
			 var projectId=$("#projectId").val();
			 var piisGeneralPartner= $('input[name="piisGeneralPartner"]:checked').val();
			 if(piinvest==""||piinvest){
				 
			 }
			 if(eval(pfinancingAmount)<eval(piinvest)){
				 openDialog("<div class=\"_warning\">项目追投金额不能高于项目融资金额!</div>",'40%','25%','3');
					return;
			 }
			 $.ajax({
					url : "${ctx}/crowdfunding/front/updateInvest.ht",
					type : 'post',
					data : 'projectId=' + projectId + '&piisGeneralPartner='+piisGeneralPartner+
					'&piinvest='+piinvest
					,
					dataType : 'html',
					success : function(data, status) {
						if(eval(data)==eval('1')){
						 $("#hi_content").hide();
						 $("#hi_btn").hide();
						 $(".cancel").css("display","none");
						 $("#_warInfo").html("<span style=\"font-size: 16px;color: #666\">追加跟投资金成功!</span>");
						 $("#sh_content").show();
						 setTimeout("closediv()",3000);
						 
						 window.parent.window.location = '${ctx}/crowdfunding/front/toProDetails.ht?projectId='+projectId;
						 
						}else if(eval(data)==eval('2')){
							
							 $("#hi_content").hide();
							 $("#hi_btn").hide();
							 $(".cancel").css("display","none");
							 $("#_warInfo").html("<span style=\"font-size: 16px;color: #666\">操作异常,请联系客服人员!</span>");
							 $("#sh_content").show();
							 setTimeout("closediv()",3000);
							 window.parent.window.location = '${ctx}/crowdfunding/front/toProDetails.ht?projectId='+projectId;
						}else{
							$("#hi_content").hide();
							 $("#hi_btn").hide();
							 $(".cancel").css("display","none");
							 $("#_warInfo").html("<span style=\"font-size: 16px;color: #666\">操作异常,请联系客服人员!</span>");
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
			if($("#pivaluation").val()==''){
				
				$("#waning_info1").html("<span style=\"font-size: 12px;color: #666\">项目估值不能为空!</span>");
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
