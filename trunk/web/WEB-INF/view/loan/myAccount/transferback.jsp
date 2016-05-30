<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/transferback.css">
</head>
  
<body style="min-height:750px;">
 
		<div class="tit-box element-box bg-color-s bd-color-main"><span class="tit-xxl color-main">债权转让</span></div>
		 <form id="pageForm" name="pageForm" action="${ctx }/myAccount/transferback.ht#">
			<div class="serach">
				<span>借款人:</span><input id="applyName" name="applyName" type="text" value="${applyName}"><span>标题：</span><input  id="pname" name="pname" value="${pname}" type="text"><span><span class="recharge" onclick="query('b1')">搜索</span>
			</div>
		<div class="buttonlist text-center">
			<div id="b1" class="button1">可以转让的借款</div>
			<div id="b2" class="button2">竞拍中的债权</div>
			<div id="b3" class="button2">竞拍结束的债权</div>
			<div id="b4" class="button2">转让失败的债权</div>
		</div>
 	 		<input type="hidden" name="status" id="status"  value="${status}"/>
		<div class="tableList" >
			
			<table class="tableContent text-center"   border="1px" cellspacing="0" cellpadding="0">
				<tr>
					<td width="">借款人</td>
					<td width="">标题</td>
					<td width="">期限</td>
					<td width="">发布时间</td>
					<td width="">年利率</td>
					<td width="">债券期限</td>
					<td width="">投资金额</td>
					<td width="">已收金额</td>
					<td width="">待收金额</td>
					<td width="">操作</td>
				</tr>
				<c:forEach var="project" items="${projectInvests}">
				<tr>
					<td>${project.loginName}</td>
					<td>${project.pname}</td>
					<td>${project.pDeadline}月</td>
					<td><fmt:formatDate value="${project.popenDate}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
					<td>${project.prateOut}%</td>
					<td>${project.pDeadline-project.prCurrent}月</td>
					<td>${project.piEffectAmount}元</td>
					<td>${project.piGetSum}元</td>
					<td>${project.piBeGetSum}元</td>
					<td><a href="#" onclick="buttonFunction('${project.piHavedPayTime}','${project.piBeGetSum}','${project.investId}','${project.projectId}','${project.piInvestors}','${project.pDeadline-project.prCurrent}')">债权转让</a></td>
				</tr>
				</c:forEach>
			</table>
		</div>

		<div class="tableList hideDiv" >
			
			<table class="tableContent text-center"   border="1px" cellspacing="0" cellpadding="0">
				<tr>
					<td width="">借款人</td>
					<td width="">标题</td>
					<td width="">期限</td>
					<td width="">年利率</td>
					<td width="">债券期限</td>
					<td width="">投资金额</td>
					<td width="">竞拍底价</td>
					<td width="">竞拍最高价</td>
					<td width="">竞拍者</td>
					<td width="">截止时间</td>
					<td width="">操作</td>
				</tr>
				<c:forEach var="project" items="${projectInvestings}">
				<tr>
					<td>${project.loginName}</td>
					<td>${project.pname}</td>
					<td>${project.pDeadline}月</td>
					<td>${project.prateOut}%</td>
					<td>${project.pDeadline-project.prCurrent}月</td>
					<td>${project.piEffectAmount}元</td>
					<td>${project.upsetPrice}元</td>
					<td>${project.hieghtestPrice}元</td>
					<td>${project.offerName}</td>
					<td><fmt:formatDate value="${project.closeDate}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
					<td><a href="#" onclick="cacelFunction('4','${project.transferId}')">撤销</a></td>
				</tr>
				</c:forEach>
				 
			</table>
		</div>

		<div class="tableList hideDiv" >
			<table class="tableContent text-center"   border="1px" cellspacing="0" cellpadding="0">
				<tr>
					<td width="">借款人</td>
					<td width="">标题</td>
					<td width="">年利率</td>
					<td width="">债券期限</td>
					<td width="">投资金额</td>
					<td width="">竞拍底价</td>
					<td width="">竞拍最高价</td>
					<td width="">竞拍者</td>
					<td width="">结束时间</td>
					<td width="">状态</td>
					<!--  td width="">协议</td>-->
				</tr>
				<c:forEach var="project" items="${projectInvestover}">
				<tr>
					<td>${project.loginName}</td>
					<td>${project.pname}</td>
					<td>${project.prateOut}%</td>
					<td>${project.pDeadline-project.prCurrent}月</td>
					<td>${project.piEffectAmount}元</td>
					<td>${project.upsetPrice}元</td>
					<td>${project.hieghtestPrice}元</td>
					<td>${project.offerName}</td>
					<td><fmt:formatDate value="${project.closeDate}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
					<td><f:description nodeKey="TRANSFER_STATUS" itemValue="${project.piTransferStateId}"></f:description></td>
					<!--<td><a href="#">查看</a></td>-->
				</tr>
				</c:forEach>
			</table>
		</div>
		<div class="tableList hideDiv" >
			<table class="tableContent text-center"   border="1px" cellspacing="0" cellpadding="0">
				<tr>
					<td width="">借款人</td>
					<td width="">标题</td>
					<td width="">期限</td>
					<td width="">年利率</td>
					<td width="">债券期限</td>
					<td width="">投资金额</td>
					<td width="">转让金额</td>
					<td width="">竞拍底价</td>
					<td width="">状态</td>
				</tr>
				<c:forEach var="project" items="${projectInvested}">
				<tr>
					<td>${project.loginName}</td>
					<td>${project.pname}</td>
					<td>${project.pDeadline}月</td>
					<td>${project.prateOut}%</td>
					<td>${project.pDeadline-project.prCurrent}月</td>
					<td>${project.piEffectAmount}元</td>
					<td>${project.hieghtestPrice}元</td>
					<td>${project.upsetPrice}元</td>
					<td>失败</td>
				</tr>
				</c:forEach>
			</table>
		</div>
			  <pageTag:paging form="pageForm"/>
       	 </form>

   	 <!-- 弹出层 -->
	 <div id="faqbg"></div> 
	<div id="faqdiv" style="display:none"> 
		<h2>债权转让申请<a href="#" class="close">×</a></h2> 
		<div class="form"> 
		<div class="formname text-right">
		<ul>
		<li>竞拍期限：</li>
		<li>竞拍方式：</li>
		<li>债权金额：</li>
		<li>债权期限：</li>
		<li>竞拍底价：</li>
		<li>交易密码：</li>
		<li>转让描述：</li>
		</ul></div>
		<select id="openDays" name="openDays">
			<option value="3">3天</option>
			<option value="5">5天</option>
			<option value="15">15天</option>
			<option value="30">30天</option>
			<option value="60">60天</option>
		</select>
		<div class="causelist">
		  <div><input type="radio" value="1" name="auctionWay" checked="checked"/>明拍<input type="radio" value="2" name="auctionWay"/>暗拍</div>
		  <div><span id="claimsSum"></span>元</div>
		  <div><span id="line"></span>个月</div>
		  <div><input type="text" id="upsetPrice" class="causelistinput"/>元</div>
		  <div><input type="password" id="transferpwd" class="causelistinput" /></div>
		  <textarea rows="5" id="description"  >
		  </textarea>
		 <input type="hidden" id="transferorId"/> 
		<input type="hidden" id="investId"/> 
		<input type="hidden" id="projectId"/> 
		</div>
		
		</div> 
		<div class="clear"></div>
		<div class="button">
		  <div class="submit" onclick="submitdiv()">提交</div><div class="cancel" onclick="closediv()">取消</div>
		</div>
	</div>
<script type="text/javascript">
	function query(value){
		$("#pageForm").submit();
	}
	function buttonFunction (date,price, investId , projectId , piInvestors, line ){ 
		if((new Date().getTime()-new Date(date).getTime())/(24 * 60 * 60 * 1000)>=30){
		$("#claimsSum").text(price);
		$("#line").text(line);
		$("#transferorId").val(piInvestors);
		$("#investId").val(investId);
		$("#projectId").val(projectId);
		$("#upsetPrice").val('');
		$("#transferpwd").val('');
		$("#description").val('');
 		 $("#faqbg").css({display:"block",height:$(document).height()}); 
 		 var yscroll =document.documentElement.scrollTop; 
 		 $("#faqdiv").css("top","100px"); 
 		 $("#faqdiv").css("display","block"); 
 		 document.documentElement.scrollTop=0; 
		}else{
			alert("投资债权拥有期限必须超过30天才可以进行债权转让操作。");
		}
	 } 
	 $(function() {
            $('.buttonlist div').click(function() {
                $(this).removeClass('button2').addClass('button1').siblings().removeClass('button1').addClass('button2');
                $('.tableList').addClass('hideDiv').eq($(this).index()).removeClass('hideDiv');
                $("#status").val($(this).attr("id"));
                $("#pname").val("");
                $("#applyName").val("");
                $("#pageForm").submit();
            });
           if("${status}"){  
        	   $("#${status}").removeClass('button2').addClass('button1').siblings().removeClass('button1').addClass('button2');
               $('.tableList').addClass('hideDiv').eq($("#${status}").index()).removeClass('hideDiv');
           }
           
  		 $(".close").click(function(){ 
	  		 $("#faqbg").css("display","none"); 
	  		 $("#faqdiv").css("display","none"); 
  		 });
        });
	 function cacelFunction(type,transferId){
		 //alert(type+"=="+transferId);
		 var url = "${ctx}/loan/sysManager/tprojecttransfer/doAction.ht";
		 $.ajax({
				url:url,
				data:{type:type,transferId:transferId},
				dataType:'json',
				type:'post',
				success:function(rsp){
					if(rsp.result){
						alert(rsp.message);
					}else{
						alert(rsp.message); 
					}
				}
			});
	 }
	 function submitdiv(){
		 $.ajax({
				type: "post",
				url: "${ctx}/myAccount/addTransferInfo.ht",
				data:{investId:$("#investId").val(),claimsSum:$("#claimsSum").text(),
					transferorId:$("#transferorId").val(),projectId:$("#projectId").val(),
					upsetPrice:$("#upsetPrice").val(),transferpwd:$("#transferpwd").val(),remarks:"",
					description:$("#description").val(),openDays:$("#openDays").val(),auctionWay:$("input[name='auctionWay']:checked").val()},
				dataType:"json",
				success: function(json){
					if(json.result){
						alert(json.result);
						 if(json.success=="1"){
							 closediv();
						 } 
					}else{
						window.location.href="${ctx}/loginWeb.ht";
					}
					 
				}
			});
		 }
		 function closediv(){
		   $("#faqbg").css("display","none"); 
		   $("#faqdiv").css("display","none"); 
		 }
</script>
</body>
</html>
       