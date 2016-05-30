<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
  <meta charset="UTF-8">
  <%@ include file="/commons/includeFront/javascripts.jsp"%>
  <title><%=application.getAttribute("PLATFORM_NAME")%> - 收益计算器</title>
</head>
<body>
  <%@ include file="/commons/includeFront/head.jsp"%>
  <div class="container">
    <div class="weizhi-lianjie">
      <a href="${ctx }/index-web.jsp">首页</a> > <a href="${ctx}/loan/productsloan/productsLoanList.ht">我要理财</a> > <span>收益计算器</span>
    </div>
 
    	<div class="income_box bd-color-main">
        	<div class="tit bd-b-color-main bg-color-s"><span>收益计算器</span></div>
            <p>
            	使用收益计算器，帮您计算一下借款的总成本，包括每月需要偿还的金额及月利率等；同时，一份完整的还款计划时间表让您更好地了解还款的情况。P2P贷采用的是通用的"等额本息还款法"，即借款人每月以相等的金额偿还贷款本息。也是银行房贷等采用的方法。 
            </p>
        </div>
        <div class="income_box bd-color-main">
        	<div class="tit bd-b-color-main bg-color-s"><span>借款设置</span></div>
            <div class="set-up">
           	  <p>
                	<span>借款金额：<input id="principal" name="principal" type="text"  value="${principal}" />元</span>
                    <span>年利率：<input id="rate" name="rate" type="text" class="width" value="${rate}" />%</span>
                    <span>借款期限：<input id="months" name="months" type="text" class="width" value="${months}" />月</span>
                    <span>还款方式：
                     <select name="prepayWay" id="prepayWay">
						 <c:forEach var="dic" items="${dics}">
						 <option value="${dic.itemValue}"  >${dic.itemName}</option>
						 </c:forEach>
		              </select><br>
					<input id="start" type="button" onclick="startcalculate()" class="input_button bg-color-l" value="开始计算">
					<input id="reset" type="button" onclick="reset()" class="input_button bg-color-l" value="重置">
                </p>
               <c:if test="${product!=null }">
                <span class="border">
                	每个月将偿还：<a>${per }</a> 元   月利率：<a>${perate }%</a>    还款本息总额：<a>${total }</a> 元  [借款交易记录采用银行的截断处理（舍去小于0.01的金额），实际还款总金额可能会少 ]
                </span>
                <ul>
                	<li>
                    	<span class="width">期数</span>
                         <c:if test="${prepayWay==1}"><span>还本息</span>
                        <span>还本金</span>
                        <span>还利息</span>
                        <span>本息余额</span></c:if>
                         <c:if test="${prepayWay!=1}"><span>月还本息</span>
                        <span>月还本金</span>
                        <span>月还利息</span>
                        <span>本息余额</span></c:if>
                    </li>
                   	<c:forEach var="p" items="${product}">
                   		<span class="width">${p.prCurrent}</span>
                        <span>${p.prPay}</span>
                        <span>${p.prPrincipal}</span>
                        <span>${p.prInterest}</span>
                        <c:if test="${prepayWay==3}"><span>${total-p.prPay*p.prCurrent}</span></c:if>
                        <c:if test="${prepayWay==1}"><span>${total-p.prPay}</span></c:if>
                        <c:if test="${prepayWay==2}"><span>${total-p.prInterest*p.prCurrent-p.prPrincipal}</span></c:if>
                        <c:if test="${prepayWay==4}"><span>${total-p.prPayless}</span></c:if>
                   	</c:forEach>
                    <div class="clear"></div>
                </ul>
                </c:if>
            </div>
        </div>
	</div>

  <%@ include file="/commons/includeFront/footer.jsp"%>
  <script>
  	function num(th){th.value = th.value.replace(/[^\d\.\-]*$/g, '');}
  	<c:if test="${prepayWay!=null}"> $("#prepayWay").val("${prepayWay}"); </c:if>
  	function startcalculate(){
  		if($('#principal').val()&&$('#rate').val()&&$('#months').val()){
  			if($('#months').val().indexOf('.')>-1){
  				alert("请输入整数月份计算收益值。");
  				return false;
  			}
  			window.location.href="${ctx}/loan/productsloan/projectincomelist.ht?principal="+$('#principal').val()+"&rate="+$('#rate').val()+"&months="+$('#months').val()+"&prepayWay="+$("#prepayWay").val();
  		}else{
  			alert("请输入完整的本金、年利率、整数月份计算收益值。");
  		}
	}
  	function reset(){
  			$('#principal').val("");
  			$('#months').val("");
  			$('#rate').val("");
  			window.location.href="${ctx}/loan/productsloan/projectincomelist.ht?principal="+$('#principal').val()+"&rate="+$('#rate').val()+"&months="+$('#months').val()+"&prepayWay="+$("#prepayWay").val();
  	}
  	
  $(function(){
	    $("#sidebar>ul>li:not(:first)>a").hover(function(){
	      $(this).css("background-color","#fd8f59");
	      var background_position_y = $(this).children("div").css("background-position").split(" ")[1];
	      $(this).children("div").css("background-position","-20px " + background_position_y);
	    },function(){
	      var background_position_y = $(this).children("div").css("background-position").split(" ")[1];
	      $(this).css("background-color","#fff9d9");
	      $(this).children("div").css("background-position","0px " + background_position_y);
	    }).bind("click",function(){
	      $(".subsidebar").hide();
	      if ($(this).next().css("display")=="none") {
	        $(this).next().show();
	      }else{
	        $(this).next().hide();
	      };
	    });
	  })

  </script>
</body>
</html>