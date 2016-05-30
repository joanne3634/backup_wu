<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title><%=application.getAttribute("PLATFORM_NAME")%> - 债权转让</title>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
</head>
<body>
	 
	 <%@ include file="/commons/includeFront/head.jsp"%>
	 <div class="container woyaolicai-body">
 
    <div class="weizhi-lianjie">
      <a href="/p2p/index-web.jsp">首页</a> > <span>债权转让</span>
    </div>
    <div id="woyaolicai-con">
      <div style="float:left;width:560px;">
        <div style="margin-bottom:5px;">交易时间：<span class="color-main"><%=application.getAttribute("TRADING_HOURS") %></span></div>
        <div style="color:#989898;font-size:12px;">短期限3~12个月借款项目，到期一次性还本付息，年化利率7%~11%，新手投资10000元起投，持有30天后可转让债权收回资金。</div>
      </div>
      <div style="float:right;width:420px;margin-top:18px;text-align:right;">最新借款项目更新时间：<span class="color-main" style="font-size:22px;">${lastUpdateTime}</span></div>
    </div>
    <div id="touzishaixuan">
      <div id="touzishaixuan-tit">债权转让筛选<a href="javascript:void(0);"></a></div>
      <dl id="touzishaixuan-list" class="transfer-list">
        <dt>待收金额 </dt>
        <dd id="claimsSum">
        	<a class="checked color-main" href="javascript:void(0);" min="" max="">不限</a>
        	<a class="color-main" href="javascript:void(0);" min="0" max="2999">3000元以下</a>
        	<a class="color-main" href="javascript:void(0);" min="3000" max="4999">3000-5000</a>
        	<a class="color-main" href="javascript:void(0);" min="5000" max="9999">5000-10000</a>
        	<a class="color-main" href="javascript:void(0);" min="10000" max="19999">1万-2万</a>
        	<a class="color-main" href="javascript:void(0);" min="20000" max="49999">2万-5万</a>
        	<a class="color-main" href="javascript:void(0);" min="50000" max="">5万以上</a></dd>
        <dt>拍卖底价</dt>
       <dd id="upsetPrice">
       		<a class="checked color-main" href="javascript:void(0);" min="" max="">不限</a>
       		<a class="color-main" href="javascript:void(0);" min="0" max="2999">3000元以下</a>
        	<a class="color-main" href="javascript:void(0);" min="3000" max="4999">3000-5000</a>
        	<a class="color-main" href="javascript:void(0);" min="5000" max="9999">5000-10000</a>
        	<a class="color-main" href="javascript:void(0);" min="10000" max="19999">1万-2万</a>
        	<a class="color-main" href="javascript:void(0);" min="20000" max="49999">2万-5万</a>
        	<a class="color-main" href="javascript:void(0);" min="50000" max="">5万以上</a></dd>
        <dt>拍卖模式 </dt>
        <dd id="auctionWay">
        	<a class="checked color-main" href="javascript:void(0);" value="">不限</a>
        	<a class="color-main" href="javascript:void(0);" value="1">明拍</a>
        	<a class="color-main" href="javascript:void(0);" value="2">暗拍</a>
       	</dd>
        <dt>逾期状态  </dt>
        <dd id="isLate">
        	<a class="checked color-main" href="javascript:void(0);" value="">不限</a>
        	<a class="color-main" href="javascript:void(0);" value="1">逾期</a>
        	<a class="color-main" href="javascript:void(0);" value="0">没有逾期</a>
       	</dd>
        <dt>发布时间 </dt>
        <dd id="openDate">
        	<a class="checked color-main" href="javascript:void(0);" value="">不限</a>
        	<a class="color-main" href="javascript:void(0);" value="1">1天内</a>
        	<a class="color-main" href="javascript:void(0);" value="3">3天内</a>
        	<a class="color-main" href="javascript:void(0);" value="7">7天内</a>
        	<a class="color-main" href="javascript:void(0);" value="10">10天内</a>
        	<a class="color-main" href="javascript:void(0);" value="30">30天内</a>
        	<a class="color-main" href="javascript:void(0);" value="0">一个月以上</a>
       	</dd>
      </dl>
    </div>
   <iframe src="${ctx }/myAccount/transferList.ht" 
    marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%"  id="iframepage" onLoad="iFrameHeight()" ></iframe>
    
  </div>
  <div style="border-top:1px solid #dcdcdc;min-width:1000px;"></div>
  
   <%@ include file="/commons/includeFront/footer.jsp"%>
  

</body>
<script>
  $(function(){
    $("#touzishaixuan-tit a").click(function(){
      if ($("#touzishaixuan-list").is(":visible")) {
        $("#touzishaixuan-list").hide();
        $("#touzishaixuan-tit a").css("background-position","0 0");
      }else {
        $("#touzishaixuan-list").show();
        $("#touzishaixuan-tit a").css("background-position","0 -15px");
      }
    });

    $("#claimsSum a").click(function(){
      $("#claimsSum a").removeClass("checked");
      $(this).addClass("checked");
      refresh();
    });
    $("#upsetPrice a").click(function(){
        $("#upsetPrice a").removeClass("checked");
        $(this).addClass("checked");
        refresh();
      });
    $("#auctionWay a").click(function(){
      $("#auctionWay a").removeClass("checked");
      $(this).addClass("checked");
      refresh();
    });
    $("#isLate a").click(function(){
      $("#isLate a").removeClass("checked");
      $(this).addClass("checked");
      refresh();
    });
    $("#openDate a").click(function(){
        $("#openDate a").removeClass("checked");
        $(this).addClass("checked");
        refresh();
      });
  });
  function refresh(){
	  var claimsSum = $("#claimsSum a.checked");
	  var upsetPrice = $("#upsetPrice a.checked");
	  var auctionWay = $("#auctionWay a.checked");
	  var isLate = $("#isLate a.checked");
	  var openDate = $("#openDate a.checked");
	  var param = new Array();
	  if(claimsSum.length >0){
		  var min = claimsSum.attr("min");
		  var max = claimsSum.attr("max");
		  if(min!=""){
			  param.push("claimsSumBegin="+min);
		  }
		  if(max!=""){
			  param.push("claimsSumEnd="+max);
		  }
	  }
	  if(upsetPrice.length>0){
		  var min = upsetPrice.attr("min");
		  var max = upsetPrice.attr("max");
		  if(min!=""){
			  param.push("upsetPriceBegin="+min);
		  }
		  if(max!=""){
			  param.push("upsetPriceEnd="+max);
		  }
	  }
	  if(auctionWay.length>0){
		  var value = auctionWay.attr("value");
		  if(value!=""){
			  param.push("auctionWay="+value);
		  }
	  }
	  if(isLate.length>0){
		  var value = isLate.attr("value");
		  if(value!=""){
			  param.push("isLate="+value);
		  }
	  }
	  if(openDate.length>0){
		  var value = openDate.attr("value");
		  if(value!=""){
			  if(parseInt(value)==0){
				  param.push("openDateAbove="+30);
			  }else{
				  param.push("openDateBelow="+value);
			  }
		  }
	  }
	  param = param.join("&");
	  //console.debug(param);
	  var url = "${ctx }/myAccount/transferList.ht?"+param;
	  $("#iframepage").attr("src",url);
  }
  function iFrameHeight() {
		
	    var ifm= document.getElementById("iframepage");

	    var subWeb = document.frames ? document.frames["iframepage"].document :

			ifm.contentDocument;

	        if(ifm != null && subWeb != null) {

	        ifm.height = subWeb.body.scrollHeight;

	        }

	}
  
  </script>
</html>
       