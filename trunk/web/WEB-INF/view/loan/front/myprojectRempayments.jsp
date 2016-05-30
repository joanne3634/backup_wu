<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
<style type="text/css">
    #middle{
        filter: alpha(opacity=50); 
        opacity:0.5;
        -moz-opacity:0.5;
        z-index:3;
        background-color:#e4eaf3;
    }
    #msg{
        position:fixed;
        float: left;
        z-index:999;
        width:160px;
        border:2px solid #828d97;
        background-color:#e4eaf3;
        display:none;
    }
</style>
</head>
<body>
		<div class="hyht-bodyright"><div class="tit-box element-box bg-color-s bd-color-main"><span class="tit-xxl color-main">我的还款</span></div>
        <div class="con-box con-box-wodejiekuan bd-b-color-main bd-l-color-main bd-r-color-main">
          
          <table class="" id="myrepay">
            <tr>
              <th class="color-main">还款期</th>
              <th class="color-main">应还金额</th>
              <th class="color-main">应还款时间</th>
              <th class="color-main">实际还款金额</th>
              <th class="color-main">实际还款时间</th>
              <th class="color-main">逾期天数</th>
              <th class="color-main">逾期费用</th>
              <th class="color-main">操作</th>
            </th>
            <c:forEach var="project" items="${projects}">
            <tr>
              <td>${project.prCurrentOfAll}</td>
              <td>${project.prPay}元</td>
              <td><fmt:formatDate value="${project.prPlanPayTime}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
              <td>${project.prRealPay}元</td>
              <td><fmt:formatDate value="${project.prRealPayTime}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
              <td>${project.prLateDays}</td>
              <td>${project.prLate}</td>
              <td><c:if test="${project.prIsDone==0}"><a id="repayBtn" class="handle-btn bdc-s-l bgc-s" href="javascript:repayMent('${project.projectId}','${project.repaymentId}','${project.currentRepaymentId}');">还款</a></c:if>
              	<c:if test="${project.prIsDone==1}">完成</c:if></td>
            </tr>
            </c:forEach>
          </table>
          </div>
        </div>
        
        <div id="middle"></div>
		<div id="msg">
		    <div style="width:100%;font-size:13px;">请输入交易密码：</div>
		    <div>
		    	<input type="password" id="pwd" style="width:152px;"/>
			    <input type="hidden" id="projectId" style="width:152px;"/>
			    <input type="hidden" id="repaymentId" style="width:152px;"/>
		    </div>
		    <div style="text-align:center;">
		        <button id="btn1">确定</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		        <button id="btn2">取消</button>
		    </div>
		</div>
  <script>
  $('#btn1').click(function(){
  	$('#msg').hide();
  	$('#middle').hide();
  	var pwd = $('#pwd').val();
  	if(pwd){
			$.ajax({
  				type: "post",
  				data:{projectId:$('#projectId').val(),repaymentId:$('#repaymentId').val(),pwd:pwd},
  				url: "${ctx}/project/repayment.ht",
  				dataType:"json",
  				success: function(data){
  					if('1'==data.result){
  						alert("还款成功。");
  						window.location.reload(true);
  					}else{
  						alert(data.result);
  					}
  				}
  			});
		}else{
			if(null==pwd){
					
			}else{
				alert("请先输入支付密码。");
			}
		}
  });
  
  $('#btn2').click(function(){
  	$('#msg').hide();
  	$('#middle').hide();
  });
  
  $("#repayBtn").mouseup(function(e) { 
	  var width = document.body.clientWidth+'px';
      var height = document.documentElement.clientHeight+'px';

       var p = {
         width:$('#msg').width(),
         height:$('#msg').height()
       }

       var left = ($(window).width() - p.width) / 2 + 'px';
       var top = ($(window).height() - p.height) / 2 + 'px';
	  	left = e.originalEvent.x || e.originalEvent.layerX || 0; 
	  	top = e.originalEvent.y || e.originalEvent.layerY || 0; 
	  	$('#middle').css({'width':width,'height':height,'position':'fixed'}).show();
	    $('#msg').css({'left':left-100,'top':top}).show();
  }); 
  	function repayMent(projectId,repaymentId,current){
  		if(repaymentId==current){
  			
            $('#repaymentId').val(repaymentId);
            $('#projectId').val(projectId);
           // var pwd = window.prompt("请输入交易密码。","password");
  			$('#pwd').val("");
  		}else{
  			alert("请按期数还款，当前最小未还款期需先还款，才能还款之后的期数。");
  		}
 	}
  $(function(){
  });
  </script>
</body>
</html>