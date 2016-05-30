<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>项目还款后台管理</title>
	<%@include file="/commons/include/get.jsp" %>
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
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">项目还款后台管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_tprojectRepayment" css="link search" id="btnSearch" >查询</f:a></div>
							<div class="l-bar-separator"></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
 
									<span class="label">是否还款:</span><f:select nodeKey="sf"  showBlankOnTop="true" id="Q_prIsDone_S"  defaultValue="${param['Q_prIsDone_S']}"></f:select> 
									<span class="label">是否逾期:</span><f:select nodeKey="sf"  showBlankOnTop="true" id="Q_prisLate_S" defaultValue="${param['Q_prisLate_S']}"></f:select>  
									<span class="label">最近三天:</span>
									<f:select nodeKey="jsrdq" id="Q_prRealPayTimeStr_S"  showBlankOnTop="true" onChange="latelyDays(this)" defaultValue="${param['Q_prRealPayTimeStr_S']}"></f:select>  
									<input type="hidden" id="prPlanPayTime" name="Q_prPlanPayTimeStr_S" value="${param['Q_prPlanPayTimeStr_S']}"/>
							</div>
						</form>
					</div>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="tprojectRepaymentList" id="tprojectRepaymentItem" requestURI="list.html" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:left;">
								  <input type="checkbox" class="pk" name="projectId" id="projectId" value="${tprojectRepaymentItem.projectId}">
							</display:column>
  
							<display:column property="pname" title="项目名称"  style="text-align:left;width:100px;"/> 
							<display:column property="prCurrentOfAll" title="还款期"   style="text-align:left;width:1px;"/> 
							<display:column property="prPay" title="应还款"  style="text-align:left;width:1px;"/> 
							<display:column property="prRealPay" title="实际还款"   style="text-align:left;width:1px;"/> 
							<display:column title="还款时间"   style="text-align:left;width:1px;">
								<fmt:formatDate value="${tprojectRepaymentItem.prRealPayTime}" pattern="yyyy-MM-dd"></fmt:formatDate>
							</display:column> 
							<display:column title="是否还款"   style="text-align:left;width:1px;"> 
								<f:description nodeKey="sf"  itemValue="${tprojectRepaymentItem.prIsDone }"/>
							</display:column>	
							<display:column property="prPayless" title="剩余还款"   style="text-align:left;width:1px;"/> 
							<display:column property="prLate" title="逾期罚息"   style="text-align:left;width:1px;"/> 
							<display:column title="是否逾期"   style="text-align:left;width:1px;"> 
								<f:description nodeKey="sf"  itemValue="${tprojectRepaymentItem.prisLate }"/>
							</display:column>	
							<display:column property="prLateDays" title="逾期天数"   style="text-align:left;width:1px;"/> 
							<display:column property="prRepayerName" title="还款人"   style="text-align:left;width:1px;"/>
							<display:column property="prRepayerUserName" title="用户名"  style="text-align:left;width:1px;"/>
 
							<c:if test="${param['Q_projectId_S']!=null and tprojectRepaymentItem.prisLate==1 and tprojectRepaymentItem.prIsDone==0}">
								<display:column title="操作" style="text-align:left;width:100px;">
								<a id="repayBtn" href="javascript:repayMent('${tprojectRepaymentItem.projectId}','${tprojectRepaymentItem.repaymentId}','${tprojectRepaymentItem.currentRepaymentId}');" class="link edit">逾期垫付</a>	
								</display:column> 
							</c:if> 
						</display:table>
						<deelon:paging tableId="tprojectRepaymentItem"/>
					</div>
				</div>			
	</div>
	
	
	 <div id="middle"></div>
		<div id="msg">
		    <div style="width:100%;font-size:13px;">请输入担保支付密码:</div>
		    <div><input type="password" id="pwd" style="width:152px;"/>
			    <input type="hidden" id="projectId" style="width:152px;"/>
			    <input type="hidden" id="repaymentId" style="width:152px;"/></div>
		    <div style="text-align:left;">
		        <button id="btn1">确定</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		        <button id="btn2">取消</button>
		    </div>
		</div>
	
	<script type="text/javascript">
	 $('#btn1').click(function(){
		  	$('#msg').hide();
		  	$('#middle').hide();
		  	var pwd = $('#pwd').val();
  			if(pwd){
  				$.ajax({
  					type: "post",
	  				data:{projectId:$('#projectId').val(),repaymentId:$('#repaymentId').val(),pwd:pwd},
  	  				url: "${ctx}/loan/sysManager/tprojectRepayment/repayment.ht",
  	  				dataType:"json",
  	  				success: function(data){
  	  					if('1'==data.result){
  	  						alert("垫付还款成功。");
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
  			
  			//var width = document.body.clientWidth+'px';
           // var height = document.documentElement.clientHeight+'px';

           // var p = {
           //     width:$('#msg').width(),
           //     height:$('#msg').height()
           // }

           // var left = ($(window).width() - p.width) / 2 + 'px';
           //var top = ($(window).height() - p.height) / 2 + 'px';

           //$('#middle').css({'width':width,'height':height,'position':'fixed'}).show();
           //$('#msg').css({'left':left,'top':top}).show();
  			 $('#repaymentId').val(repaymentId);
             $('#projectId').val(projectId);
            // var pwd = window.prompt("请输入交易密码。","password");
   			$('#pwd').val("");
  	 	 	
  		}else{
  			alert("请按期数还款，当前最小未还款期需先还款，才能还款之后的期数。");
  		}
 	}
	
	
	Date.prototype.Format = function(fmt)
	{
	    //author: meizz
	    var o =
	     {
	        "M+" : this.getMonth() + 1, //月份
	        "d+" : this.getDate(), //日
	        "h+" : this.getHours(), //小时
	        "m+" : this.getMinutes(), //分
	        "s+" : this.getSeconds(), //秒
	        "q+" : Math.floor((this.getMonth() + 3) / 3), //季度
	        "S" : this.getMilliseconds() //毫秒
	     };
	    if (/(y+)/.test(fmt))
	         fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	    for (var k in o)
	        if (new RegExp("(" + k + ")").test(fmt))
	             fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	    return fmt;
	}

	Date.prototype.addDays = function(d)
	{
	    this.setDate(this.getDate() + d);
	};

	Date.prototype.addWeeks = function(w)
	{
	    this.addDays(w * 7);
	};

	Date.prototype.addMonths= function(m)
	{
	    var d = this.getDate();
	    this.setMonth(this.getMonth() + m);
	    if (this.getDate() < d)
	        this.setDate(0);
	};

	Date.prototype.addYears = function(y)
	{
	    var m = this.getMonth();
	    this.setFullYear(this.getFullYear() + y);
	    if (m < this.getMonth())
	     {
	        this.setDate(0);
	     }
	};
	
	function latelyDays (ts){
			var d=new Date();
			if(0==$(ts).val()){
				$("#prPlanPayTime").val(d.Format("yyyy-MM-dd"));
			}else if(1==$(ts).val()){
				d.addDays(-1);
				$("#prPlanPayTime").val(d.Format("yyyy-MM-dd"));
			}else if(2==$(ts).val()){
				d.addDays(-2);
				$("#prPlanPayTime").val(d.Format("yyyy-MM-dd"));
			}else if(3==$(ts).val()){
				d.addDays(1);
				$("#prPlanPayTime").val(d.Format("yyyy-MM-dd"));
			}else if(4==$(ts).val()){
				d.addDays(2);
				$("#prPlanPayTime").val(d.Format("yyyy-MM-dd"));
			}else{
				$("#prPlanPayTime").val('');
			}
		} 
	</script>
</body>
</html>
