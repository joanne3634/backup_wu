<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>借款申请</title>
<link rel="stylesheet" href="${ctx}/styles/dlweixin/css/style.css">
<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
</head>

<body>
	<div class="top">
	<div class="fintop"></div>
	</div>
	<form id="form" action="${ctx}/weixin/wxproject/saveProject.ht" method="post">
	<div class="formlist text-black2">
		<ul>
			<li>
				<span class="text-right">借款标题：</span><input type="text" placeholder="" class="bodersolid radiu background2" id="pname" name="pname" <c:if test="${project!=null}">value="${project.pname}"</c:if> />
			</li>
			<li>
				<span class="text-right">借款金额：</span><input type="text" placeholder="" class="bodersolid radiu background2" onkeyup="num(this)" id="ploan" name="ploan" <c:if test="${project!=null}">value="${project.ploan}"</c:if> />元
			</li>
			<li>
				<span class="text-right">借款期限：</span><input type="text" placeholder="" class="bodersolid radiu background2" onkeyup="num(this)" id="pdeadline" name="pdeadline" <c:if test="${project!=null}">value="${project.pdeadline}"</c:if> />月
			</li>
			<li>
				<span class="text-right">年利率：</span><input type="text" placeholder="" class="bodersolid radiu background2" onkeyup="num(this)" id="prateIn" name="prateIn" <c:if test="${project!=null}">value="${project.prateIn}"</c:if> />%
			</li>
			<li>
				<span class="text-right">还款方式：</span>
				<select name="prepayWay" id="prepayWay"  class="bodersolid radiu background2  text-black2">
					 <c:forEach var="dic" items="${dics}">
					 <option value="${dic.itemValue}"  >${dic.itemName}</option>
					 </c:forEach>
	            </select>
			</li>
			<li>
				<span class="text-right">起投金额：</span><input type="text" placeholder="" class="bodersolid radiu background2" onkeyup="num(this)" id="pminInvest" name="pminInvest" <c:if test="${project!=null}">value="${project.pminInvest}"</c:if> />元
			</li>
			<li>
				<span class="text-right">最大投额：</span><input type="text" placeholder="" class="bodersolid radiu background2" onkeyup="num(this)" id="pmaxInvest" name="pmaxInvest" <c:if test="${project!=null}">value="${project.pmaxInvest}"</c:if> />元
			</li>
		</ul>
		<c:if test="${product!=null}"><div class="textdiv background1 text-white text-center lbutton" onclick="javascript:submitProject();">确定发布</div></c:if>
	</div>

		
	</form>
</body>

<script type="text/javascript">
function num(th){
	var reg = /^[0-9]{0}([0-9]|[.])+$/;
	if(reg.test(th.value)!=true){th.value="";}
}

function submitProject(){//alert(parseFloat(${product.pAmountMin}) + "--" + parseFloat($("#ploan").val()) + "--" +parseFloat(${product.pAmountMax}));
	if(!$("#pname").val()){
 		alert("借款标题不可以为空。");
 		window.location.href="#";
		return ;
	}<c:if test="${project==null}">else if(parseFloat($("#nowcando").text())<parseFloat($("#ploan").val())){
 		alert("借款金额已经超过您的最大借款额度，如有需要请先进行借款额度申请。");
		window.location.href="#";
		return ;
	}</c:if>
	<c:if test="${project!=null}">else if(parseFloat($("#nowcando").text())+parseFloat("${project.ploan}")<parseFloat($("#ploan").val())){
 		alert("借款金额已经超过您的最大借款额度，如有需要请先进行借款额度申请。");
		window.location.href="#";
		return ;
	}</c:if>else if(!((parseFloat($("#ploan").val())>parseFloat(${product.pAmountMin})&&parseFloat($("#ploan").val())<parseFloat(${product.pAmountMax}))||(parseFloat($("#ploan").val())==parseFloat(${product.pAmountMin})||parseFloat($("#ploan").val())==parseFloat(${product.pAmountMax})))){
		window.location.href="#";
 		alert("借款金额必须在贷款产品的金额范围内。");
		return ;
	}else if(!((parseInt($("#pdeadline").val())>parseInt(${product.pDeadlineMin})&&parseInt($("#pdeadline").val())<parseInt(${product.pDeadlineMax}))||(parseInt($("#pdeadline").val())==parseInt(${product.pDeadlineMin})||parseInt($("#pdeadline").val())==parseInt(${product.pDeadlineMax})))){
		window.location.href="#";
 		alert("借款期限必须在贷款产品的期限之内。");
		return ;
	}else if(!((parseFloat($("#prateIn").val())>parseFloat(${product.pRateMin})&&parseFloat($("#prateIn").val())<parseFloat(${product.pRateMax}))||(parseFloat($("#prateIn").val())==parseFloat(${product.pRateMin})||parseFloat($("#prateIn").val())==parseFloat(${product.pRateMax})))){
		window.location.href="#";
 		alert("借款年利率必须在贷款产品规定的利率范围内。");
		return ;
	}else if(!(parseFloat($("#pmaxInvest").val())<=parseFloat($("#ploan").val()))){
		window.location.href="#";
 		alert("投标最大金额不可以为空，且应该小于等于借款额。");
		return ;
	}else if(!(parseFloat($("#pminInvest").val())<=parseFloat($("#pmaxInvest").val()))){
		window.location.href="#";
 		alert("投标最小金额应该在投标最大金额范围之内。");
		return ;
	}
	if($("#prepayWay").val()!="${product.pRepayWay}"){
		if(confirm("借款选择的还款方式跟产品要求的还款方式不同，这个可能降低借款的通过率，请确定要继续提交吗？"))
		{
			$("#form").submit();
			return ;
		}else{
			return ;
		}
	}
	$("#form").submit();
	return;
}
</script>
</html>