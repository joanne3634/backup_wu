<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>项目流标退款返回信息</title>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
	<meta name="renderer" content="webkit"/>
	<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/DialogIframe.css">
	<link rel="stylesheet" href="${ctx }/styles/default/css/layout.css">
   <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
   <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
</head>
<style type="text/css"> 
.box{
	width:896px; height:396px; background:url(${ctx }/bkImages/zjfkbj.gif) no-repeat; border-collapse:collapse;
}
.fong1{
	font-size:14px; color:#3393c9; font-weight: bold; line-height:35px; margin:0px; padding:0px;
}
.fong2{
	font-size:12px; color:#666;  line-height:15px; margin:0px; padding:0px;
}
.sj_inpt{
	border:solid 1px #d2d2d2; width:130px; line-height:18px; height:18px; float:left;
}
</style>

<body>
		<!-- <form action="" method="post" id="sendForm"> -->
		<form id="rongpaysubmit" name="rongpaysubmit" action="https://epay.reapal.com/portal" method="post" target="_blank">
		   
	       
	       <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top">
   	  <table align="center" class="box">
          <tr>
            <td align="top" valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              
              <tr>
                <td align="center"><table width="80%" border="0" cellspacing="0" cellpadding="0" style="padding:5px; margin-top:50px;">
                    <TR>
                      <TD height="40"  align="right" >序号</TD>
                      <TD height="40" align="right">投资人 </TD>
                      <TD height="40" align="right">退款订单号</TD>
					  <TD height="40" align="right">是否成功</TD>
					   <TD height="40" align="right">错误代码</TD>
					 
                      
                    </TR>
                    ${resultStr }
               
                    
                  </table>
                             </td>
              </tr>
              
            </table></td>
          </tr>
        </table>
        </td>
    </tr>
  </table>
		</form>	
	<script type="text/javascript">
	function sufun(){
		document.rongpaysubmit.submit();
	/* 	var defaultbank=$("#defaultbank").val();
		var investId=$("#investId").val();
		var projectId=$("#projectId").val(); */
	//	window.location.href="${ctx }/crowdfunding/front/tcprojectinvest/toAutoSubmitjsp.ht?projectId="+projectId+'&investId='+investId+'&defaultbank='+defaultbank;
		
	}
	
	
	  function reloadUrl(){
	  	   window.location.reload(true);
	  }
	$(function(){
		$("#freeze").val($("#freeze").val()*10000);
		$('#tradingPwdErrCount').on('blur',function(){
			//clearCheck();
	 	});
		$(".submit").mouseover(function(){
			getNewBalace();
	    });
	});
	function clearCheck(){
		var tradingPwdErrCount=$.trim($("#tradingPwdErrCount").val());
		if(tradingPwdErrCount == ''){
			$("#_warninput1").html("<font color='red'>交易密码不能为空!</font>");
			return;
		}else{
			$("#_warninput1").html("");
		}
	}
	function toRechargePage(){
		window.parent.parent.location='${ctx}/crowdfunding/memberCenter/toRechargePage.ht';
	}
	//保存上传调查报告与评价
	function savePaymeny(){
		/* var tradingPwdErrCount=$.trim($("#tradingPwdErrCount").val());
		if(tradingPwdErrCount == ''){
			$("#_warninput1").html("<font color='red'>交易密码不能为空!</font>");
			return;
		} */
		var available=$("#available").val();
		var pinvestAmount=$("#freeze").val();
		if(available != '' && pinvestAmount != ''){
			if(parseFloat(available) - parseFloat(pinvestAmount) <= 0){
				art.dialog.confirm("您目前账户可用金额不足，确定请充值后再付款吗?",function(){
					//调整到充值界面
					goToRechargePage();
				});
				return;
			}
		}else{
			openDialog("认投金额或用户账户余额为空",'','','2',function(){});
		}
		art.dialog.confirm("你确定要付款吗?",function(){
			$.ajax({
					url : "${ctx }/crowdfunding/front/tcprojectinvest/savePaymeny.ht",
					type : 'post',
					dataType : 'json',
					data : $('#sendForm').serialize(),
					success : function(data) {
						if(data=="0"){
							openDialog("付款失败!",'','','2',function(){
							});
							setTimeout(closediv,3000);
						}else{
							$.dialog({
								content:"<span style='font-size:20px;'>付款中!</span>",
								lock: true,
								background: 'black',// 背景色#600
								opacity: 0.80,	// 透明度
								height: '150px',
								width: '400px',
								drag: false,
								fixed: true,
								cancel: false,	
								esc:true,  
								 button: [
								          {
								              name: '查看交易记录',
								              callback: function() {
								            	  window.open("${ctx}/crowdfunding/memberCenter/toinvestList.ht");
								            	  window.parent.parent.loadPages('${ctx }/crowdfunding/tcuserPersonalData/myAccount.ht');
								              }
								          },{
								              name: '关闭',
								              callback: function() {
								            	  //window.open("${ctx}/crowdfunding/memberCenter/toinvestList.ht");
								            	 // var flag = "voteTou";
								            	// location.href="${ctx}/crowdfunding/front/tcprojectinvest/voteProj.ht";
								            	  closediv();
								            	  //window.location.reload(); //刷新父窗口中的网页
								            	}
								          }
								      ],
							    close:function(){
							    	  closediv();
							    	 //window.parent.parent.loadPages('${ctx }/crowdfunding/tcuserPersonalData/myAccount.ht');
							  //  	window.open("${ctx}/crowdfunding/memberCenter/toinvestList.ht");
							    }
							});
							var url="${ctx }/crowdfunding/front/tcprojectinvest/savePaymenys.ht?flowCode="+eval(data);
							window.open(url);
						}
					}
			});
		});
	}
	/**
	*获取最新用户资金余额
	*/
	function getNewBalace(){
		$.ajax({
			url : "${ctx}/crowdfunding/onlinePayment/getNewBalace.ht",
			type : 'post',
			async:false,
			dataType : 'json',
			success : function(data, status) {
				if(data){
					var available = data.userfund.available;
					if(available !='' && available != null && typeof(available) !='undefined' )
						$("#available").val(available);
				}
			}
		});
	}
  function closediv(){
			//var list = window.parent.art.dialog.list;
			//for (var i in list) {
			  //  list[i].close();
			//};
			//window.parent.parent.location.reload();
	  art.dialog.open.origin.location.reload(true);
		}
  function goToRechargePage(){
	  $.dialog.open('${ctx}/crowdfunding/memberCenter/toRechargePage.ht?flag=1', {
			title: '账号充值',lock:true,width:'950px',height:'700px',close:function(){
			}
		});
		// window.parent.location = "${ctx}/crowdfunding/memberCenter/toRechargePage.ht";
	}
	</script>
</body>
</html>