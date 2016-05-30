<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
  <meta charset="UTF-8">
  <%@ include file="/commons/includeFront/javascripts.jsp"%>
   <script type="text/javascript" src="${ctx}/js/p2p/applyLimit.js"></script>
  <title><%=application.getAttribute("PLATFORM_NAME")%> - ${product.pName}</title>
</head>
<body>
  <%@ include file="/commons/includeFront/head.jsp"%>
  <div class="container">
    <div class="weizhi-lianjie">
      <a href="${ctx }/index-web.jsp">首页</a> > <a href="${ctx}/loan/productsloan/productsLoanList.ht">我要借款</a> > <a href="${ctx}/loan/productsloan/productDetails.ht?productId=${product.productsLoanId}">${product.pName}</a> > <span>借款基本信息</span>
    </div>
 
    <form id="form" action="${ctx}/project/saveProject.ht" method="post">
    <div class="jkjbxx-body">
      <dl>
        <dt class="bd-color-main bg-color-s"><div class="shuxian bd-color-shuxian"></div>借款基本信息</dt>
        <dd class="jkjbxx-con con-box mb15 bd-l-color-main bd-b-color-main bd-r-color-main" style="">
          <dl class="mb15 con-table-right xyhrzzl-tab">
            <dt>借款标题：</dt>
            <dd><input class="text-input mr5" style="width:300px;" type="text" id="pname" name="pname" <c:if test="${project!=null}">value="${project.pname}"</c:if> />
            	<div class="fsh16lh16" id="div_1" style="line-height:34px;"></div>
            </dd>
            <dt>借款金额：</dt>
            <dd><input class="text-input mr5" style="width:100px;" type="text" onkeyup="num(this)" onblur="interest()" id="ploan" name="ploan" <c:if test="${project!=null}">value="${project.ploan}"</c:if> />元&nbsp;&nbsp;<c:if test="${product!=null}">(产品金额限制：${product.pAmountMin}元~${product.pAmountMax}元)</c:if><a href="javascript:applyLoan('${ctx}','${sessionScope.user}',0);">额度申请</a>
            	<div class="fsh16lh16" id="div_2"></div>
            </dd>
            <dt>借款期限：</dt>
            <dd><input class="text-input mr5" style="width:100px;" type="text" onkeyup="num(this)"  onblur="interest()" id="pdeadline" name="pdeadline" <c:if test="${project!=null}">value="${project.pdeadline}"</c:if> />月&nbsp;&nbsp;<c:if test="${product!=null}">(借款期限限制：${product.pDeadlineMin}月~${product.pDeadlineMax}月)</c:if>
            	<div class="fsh16lh16" id="div_3"></div>
            </dd>
            <dt>年利率：</dt>
            <dd><input class="text-input mr5" style="width:100px;" type="text" onkeyup="num(this)"  onblur="interest()" id="prateIn" name="prateIn" <c:if test="${project!=null}">value="${project.prateIn}"</c:if> />%&nbsp;&nbsp;<c:if test="${product!=null}">(借款利率限制：${product.pRateMin}%~${product.pRateMax}%)</c:if>
            	<div class="fsh16lh16" id="div_4"></div>
            </dd>
            <dt>筹标期限：</dt>
            <dd><input class="text-input mr5" style="width:100px;" type="text" onkeyup="num(this)" id="popenDays" name="popenDays" <c:if test="${project==null and product!=null}">value="${product.pVotingDaysMax}"</c:if><c:if test="${project!=null}">value="${project.popenDays}"</c:if> />天&nbsp;&nbsp;<c:if test="${product!=null}">(开标天数限制：${product.pVotingDaysMin}~${product.pVotingDaysMax})</c:if>
            	<div class="fsh16lh16" id="div_4"></div>
            </dd>
            <dt>还款方式：</dt>
            <dd class="select-box">
              <select name="prepayWay" id="prepayWay">
				 <c:forEach var="dic" items="${dics}">
				 <option value="${dic.itemValue}"  >${dic.itemName}</option>
				 </c:forEach>
              </select>
              <div class="fsh16lh16" id="div_5"></div>
            </dd>
            <dt>起投金额：</dt>
            <dd><input class="text-input mr5" style="width:100px;" type="text" onkeyup="num(this)" id="pminInvest" name="pminInvest" <c:if test="${project!=null}">value="${project.pminInvest}"</c:if> />元
            	<div class="fsh16lh16" id="div_6"></div>
            </dd>
            <dt>最大投额：</dt>
            <dd><input class="text-input mr5" style="width:100px;" type="text" onkeyup="num(this)" id="pmaxInvest" name="pmaxInvest" <c:if test="${project!=null}">value="${project.pmaxInvest}"</c:if> />元
            	<div class="fsh16lh16" id="div_7"></div>
            </dd>
          </dl>
          <div class="extrainfo">实际支付利息:<span id="interest"></span></div>
          <div class="extrainfo">服务费用请参照：<a href="${ctx }/loan/productsloan/rate.ht?Q_typeId_S=2">资费说明</a></div>
        </dd>
        <dt class="bd-color-main bg-color-s jiekuanmiaoshu-tit"><div class="shuxian bd-color-shuxian"></div>借款描述</dt>
        <dd class="jiekuanmiaoshu  con-box mb15 bd-l-color-main bd-b-color-main bd-r-color-main">
          <textarea name="pdesc" id="pdesc" cols="107" rows="6"><c:if test="${project!=null}">${project.pdesc}</c:if><c:if test="${project==null}">关于我/我想使用这笔款项做什么/我的还款能力说明(注：借款发布成功后，可在个人中心我的借款中看到记录，系统将对借款申请进行审核，请细心等待)</c:if></textarea>
          <div class="fsh16lh16" id="div_8"></div>
        </dd>
      </dl>
      <c:if test="${product!=null}"><div class="fabujiekuanqueren-btn texta-c"><a class="bg-color-l bd-color-main-l" href="javascript:submitProject();">确定无误，发布</a></div></c:if>
    </div>
	    <input type="hidden" id="projectId" name="projectId" <c:if test="${project!=null}">value="${project.projectId}"</c:if><c:if test="${project==null}">value="0"</c:if>/>
	    <input type="hidden" id="productsLoanId" name="productsLoanId" value="${product.productsLoanId}"/>
    </form>
  </div>
  <div id="applayDialog" class="login_nav body" style="display:none" >
      
       	 <div class="login_nav_con jiekuan-con" >
       	 <div style="text-align:right;"><span class="cancel_btn"></span></div>
          <dl>
            <dt>申请额度：</dt>
            <dd class="login_nav_con">
              <input id="applyInMax" type="text" name="applyInMax" onkeyup="num(this)"/>元
            </dd>
            <dt>已有额度：</dt>
             <dd class="login_nav_con">
              <span id="cando">3000</span>元(最大可借款金额)
            </dd>
             <dt></dt>
             <dd class="login_nav_con">
              <span id="nowcando"></span>元(当前可用)
             </dd>
          </dl>
          <a href="javascript:submitLoan('${ctx}','${sessionScope.user}');">快速申请</a>
      	</div>
      </div>
  <div style="border-top:1px solid #dcdcdc;min-width:1000px;"></div>
  <%@ include file="/commons/includeFront/footer.jsp"%>
  <script>
  $("#pdesc").focus(function(){
      if ($(this).html()=="关于我/我想使用这笔款项做什么/我的还款能力说明(注：借款发布成功后，可在个人中心我的借款中看到记录，系统将对借款申请进行审核，请细心等待)") {
        $(this).html("");
      };
    }).blur(function(){
      if ($(this).html()=="") {
        $(this).html("关于我/我想使用这笔款项做什么/我的还款能力说明(注：借款发布成功后，可在个人中心我的借款中看到记录，系统将对借款申请进行审核，请细心等待)");
      };
    });
  $(".cancel_btn").click(function(){
      $("#applayDialog").css("display","none");
    });
  function num(th){
	  var reg = /^[0-9]{0}([0-9]|[.])+$/;
      if(reg.test(th.value)!=true){th.value="";}
  }
  <c:if test="${project!=null}"> $("#prepayWay").val("${project.prepayWay}"); </c:if>
  <c:if test="${project==null}"> $("#prepayWay").val("${product.pRepayWay}"); </c:if>
  
	  $("#prepayWay").change(function() {
		  var ploanT =$("#ploan").val();
		  var prateInT =$("#prateIn").val();
		  var pdeadlineT =$("#pdeadline").val();
		  if(ploanT==""||prateInT==""||pdeadlineT==""){
			  return;
		  }
		  if(1==$(this).val()){
			  $("#interest").text((parseFloat($("#ploan").val())*parseFloat($("#prateIn").val())*parseInt($("#pdeadline").val())/1200).toFixed(2)+"元");
		  }else if(2==$(this).val()){
			  $("#interest").text((parseFloat($("#ploan").val())*parseFloat($("#prateIn").val())*parseInt($("#pdeadline").val())/1200).toFixed(2)+"元");
		  }else if(3==$(this).val()){
			  $("#interest").text((parseInt($("#pdeadline").val())*parseFloat($("#ploan").val())*parseFloat($("#prateIn").val())/1200*(Math.pow(parseFloat($("#prateIn").val())/1200+1,parseInt($("#pdeadline").val())))/(Math.pow(parseFloat($("#prateIn").val())/1200+1,parseInt($("#pdeadline").val()))-1)-parseFloat($("#ploan").val())).toFixed(2)+"元");
		  }else if(4==$(this).val()){
			  $("#interest").text(((parseFloat($("#ploan").val())*parseFloat($("#prateIn").val())/1200+parseFloat($("#ploan").val())/parseInt($("#pdeadline").val())*parseFloat($("#prateIn").val())/1200)*parseInt($("#pdeadline").val())/2).toFixed(2)+"元");
		  }
	  });
	  
	  function interest(){
		  var ploanT =$("#ploan").val();
		  var prateInT =$("#prateIn").val();
		  var pdeadlineT =$("#pdeadline").val();
		  if(ploanT==""||prateInT==""||pdeadlineT==""){
			  return;
		  }
		  if(1==$("#prepayWay").val()){
			  $("#interest").text((parseFloat($("#ploan").val())*parseFloat($("#prateIn").val())*parseInt($("#pdeadline").val())/1200).toFixed(2)+"元");
		  }else if(2==$("#prepayWay").val()){
			  $("#interest").text((parseFloat($("#ploan").val())*parseFloat($("#prateIn").val())*parseInt($("#pdeadline").val())/1200).toFixed(2)+"元");
		  }else if(3==$("#prepayWay").val()){
			  $("#interest").text((parseInt($("#pdeadline").val())*parseFloat($("#ploan").val())*parseFloat($("#prateIn").val())/1200*(Math.pow(parseFloat($("#prateIn").val())/1200+1,parseInt($("#pdeadline").val())))/(Math.pow(parseFloat($("#prateIn").val())/1200+1,parseInt($("#pdeadline").val()))-1)-parseFloat($("#ploan").val())).toFixed(2)+"元");
		  }else if(4==$("#prepayWay").val()){
			  $("#interest").text(((parseFloat($("#ploan").val())*parseFloat($("#prateIn").val())/1200+parseFloat($("#ploan").val())/parseInt($("#pdeadline").val())*parseFloat($("#prateIn").val())/1200)*parseInt($("#pdeadline").val())/2).toFixed(2)+"元");
		  }
	  }
	  
    function submitProject(){
    	if("${sessionScope.user.groupID}"=='2'){
    		alert("对不起，您的账户类型没有借款的权限，请阅读借款条例重新注册借款类型账号，或者联系管理员开通借款权限。");
    		return ;
    	}
    	applyLoan('${ctx}','${sessionScope.user}',1);
    	if(!$("#pname").val()){
    		$("#div_1").html("<font color='red'>借款标题不可以为空。</font>");
    		window.location.href="#";
//     		alert("借款标题不可以为空。");
    		return ;
    	}else if($("#pname").val().length>75){
    		$("#div_1").html("<font color='red'>借款标题超过75个字，请精简一点有利于通过审核。"+$("#pname").val().length+"</font>");
    		window.location.href="#";
//     		alert("借款标题超过75个字，请精简一点有利于通过审核。"+$("#pname").val().length);
    		return ;
    	}<c:if test="${project==null}">else if(parseFloat($("#nowcando").text())<parseFloat($("#ploan").val())){
    		//alert(parseFloat($("#nowcando").text()));
    		$("#div_2").html("<font color='red'>借款金额已经超过您的当前可用借款额度，如有需要请先进行借款额度申请。</font>");
//     		alert("借款金额已经超过您的最大借款额度，如有需要请先进行借款额度申请。");
			window.location.href="#";
    		return ;
    	}</c:if>
    	<c:if test="${project!=null}">else if(parseFloat($("#nowcando").text())+parseFloat("${project.ploan}")<parseFloat($("#ploan").val())){
    		//alert(parseFloat($("#nowcando").text()));
    		$("#div_2").html("<font color='red'>借款金额已经超过您的当前可用借款额度，如有需要请先进行借款额度申请。</font>");
//     		alert("借款金额已经超过您的最大借款额度，如有需要请先进行借款额度申请。");
			window.location.href="#";
    		return ;
    	}</c:if>else if(!((parseFloat($("#ploan").val())>parseFloat(${product.pAmountMin})&&parseFloat($("#ploan").val())<parseFloat(${product.pAmountMax}))||(parseFloat($("#ploan").val())==parseFloat(${product.pAmountMin})||parseFloat($("#ploan").val())==parseFloat(${product.pAmountMax})))){
    		window.location.href="#";
    		$("#div_2").html("<font color='red'>借款金额必须在贷款产品的金额范围内。</font>");
//     		alert("借款金额必须在贷款产品的金额范围内。");
    		return ;
    	}else if(!((parseInt($("#pdeadline").val())>parseInt(${product.pDeadlineMin})&&parseInt($("#pdeadline").val())<parseInt(${product.pDeadlineMax}))||(parseInt($("#pdeadline").val())==parseInt(${product.pDeadlineMin})||parseInt($("#pdeadline").val())==parseInt(${product.pDeadlineMax})))){
    		window.location.href="#";
    		$("#div_3").html("<font color='red'>借款期限必须在贷款产品的期限之内。</font>");
//     		alert("借款期限必须在贷款产品的期限之内。");
    		return ;
    	}else if(!((parseFloat($("#prateIn").val())>parseFloat(${product.pRateMin})&&parseFloat($("#prateIn").val())<parseFloat(${product.pRateMax}))||(parseFloat($("#prateIn").val())==parseFloat(${product.pRateMin})||parseFloat($("#prateIn").val())==parseFloat(${product.pRateMax})))){
    		window.location.href="#";
    		$("#div_4").html("<font color='red'>借款年利率必须在贷款产品规定的利率范围内。</font>");
//     		alert("借款年利率必须在贷款产品规定的利率范围内。");
    		return ;
    	}else if(!(parseFloat($("#pmaxInvest").val())<=parseFloat($("#ploan").val()))){
    		$("#div_7").html("<font color='red'>投标最大金额不可以为空，且应该小于等于借款额。</font>");
    		$("#div_6").html("<font color='red'>投标最小金额应该在投标最大金额范围之内,都不为空。</font>");
    		window.location.href="#";
//     		alert("投标最大金额不可以为空，且应该小于等于借款额。");
    		return ;
    	}else if(!(parseFloat($("#pminInvest").val())<=parseFloat($("#pmaxInvest").val()))){
    		$("#div_6").html("<font color='red'>投标最小金额应该在投标最大金额范围之内,都不为空。</font>");
    		$("#div_7").html("<font color='red'>投标最大金额不可以为空，且应该小于等于借款额。</font>");
    		window.location.href="#";
//     		alert("投标最小金额应该在投标最大金额范围之内。");
    		return ;
    	}
//     	else if(!(parseFloat($("#pminInvest").val())<=parseFloat($("#pmaxInvest").val()))){
//     		$("#div_7").html("<font color='red'>投标最小金额应该在投标最大金额范围之内。</font>");
//     		window.location.href="#";
//     		alert("投标最小金额应该在投标最大金额范围之内。");
//     		return ;
//     	}
    	else if($("#pdesc").val().length>150){
    		$("#div_8").html("<font color='red'>借款详细描述太长了，请概括缩小一下体积,在150个字范围内更有利于审核人查看和通过您的借款请求。</font>");
    		window.location.href="#";
//     		alert("借款详细描述太长了，请概括缩小一下体积,在150个字范围内更有利于审核人查看和通过您的借款请求。");
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
  	}
  </script>
</body>
</html>