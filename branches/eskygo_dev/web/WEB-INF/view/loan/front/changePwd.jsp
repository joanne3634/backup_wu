<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>修改密码</title>
  <script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
   <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
</head>

	<script type="text/javascript">
	$().ready(function() {
		 $("#changeloginPwd_form").validate({
		        rules: {
		    beforePwd: {
			required: true
			   },
			  newPwd: {
		    required: true,
		    minlength: 5,
		    maxlength: 12
		   },

		   reNewPwd: {
		    required: true,
		    equalTo: "#newPwd"
		   }
		  },
		        messages: {
		        beforePwd: {
			    required: "请输入原始登录密码"
			   },
			newPwd: {
		    required: "请输入新登录密码",
		    minlength: $.validator.format("密码不能小于{0}个字符"),
		    maxlength: $.validator.format("密码不能大于{0}个字符")
		   },
		   reNewPwd: {
		    required: "请输入确认新密码",
		    equalTo: "两次输入的密码不一致"
		   }
		  }
		    });
		 
		 
		 
		 $("#changeTradePwd_form").validate({
		        rules: {
		    beforeTradePwd: {
			required: true
			   },
			newTradePwd: {
		    required: true,
		    minlength: 5,
		    maxlength: 12
		   },

		   reNewTradePwd: {
		    required: true,
		    equalTo: "#newTradePwd"
		   }
		  },
		        messages: {
		        beforeTradePwd: {
			    required: "请输入原始交易密码"
			   },
			newTradePwd: {
		    required: "请输入新交易密码",
		    minlength: $.validator.format("密码不能小于{0}个字符"),
		    maxlength: $.validator.format("密码不能大于{0}个字符")
		   },
		   reNewTradePwd: {
		    required: "请输入确认新密码",
		    equalTo: "两次输入的密码不一致"
		   }
		  }
		    });
		});
	function changeloginPwd_form_submit(){

		if($('#changeloginPwd_form').valid()){
		valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
		$.ajax({
			url : "${ctx}/loan/front/updatechangePwd.ht",
			type : 'post',
			data : $('#changeloginPwd_form').serialize(),
			dataType : 'json',
			success : function(data) {
				if (data == "0") {
					location =  "${ctx}/loginWeb.jsp"; 
					//location.reload();
				}else{
					$("#result_span").html(data);
				}
			},
			error : function(request) {
				$("#result_span").html("修改登录密码异常，请稍后在试。");
			}
		});
	}
}
	
	function changeTradePwd_form_submit(){
		
		if($('#changeTradePwd_form').valid()){
		valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
		$.ajax({
			url : "${ctx}/loan/front/updatechangeTradePwd.ht",
			type : 'post',
			data : $('#changeTradePwd_form').serialize(),
			dataType : 'json',
			success : function(data,textStatus) {
				if (data == "0") {
					location =  "${ctx}/loginWeb.jsp"; 
				}else{
					$("#resultTrade_span").html(data);
					//location.reload();
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert(XMLHttpRequest.statusText);
			}
		});
	  }
}
	
	</script>
<body>
	<div class="tit-box element-box bd-color-main bg-color-s"><span class="tit-xxl color-main">修改密码</span></div>
	<div class="con-box bd-b-color-main bd-l-color-main bd-r-color-main">
	        <!--切换按钮-->
        <div class="changepwd-tabname-box">
		        <div class="green2"  id="div_green" onClick="tabShowCon('green');"></div>
		        <div class="Orange1" id="div_Orange" onClick="tabShowCon('Orange');"></div>
	        </div>
            <!-------------------交易密码----------------->
        <div class="con-box1" id="con-box1">
	        	<form id="changeTradePwd_form"  method="post">
		        	<dl class="con-table-right xyhrzzl-tab">
		        		<dt>原交易密码：</dt>
	        	  		<dd>
	        	  			<input class="text-input" type="password" name="beforeTradePwd" id="beforeTradePwd" class="text-input"><span id="beforeTradePwd_" style="color: red;"></span>
		        		</dd>
		            	<dt>新交易密码：</dt>
	        	  		<dd>
	        	  			<input class="text-input" type="password" name="newTradePwd" id="newTradePwd" class="text-input"><span id="newTradePwd_" style="color: red;"></span>
		        		</dd> 
		            	<dt>确认新密码：</dt>
	        	  		<dd>
		        	  		<input class="text-input" type="password" name="reNewTradePwd" id="reNewTradePwd" class="text-input"><span id="reNewTradePwd_" style="color: red;"></span>
		        		</dd> 
		       		</dl>
		            <!----保存---->
					<div style="margin-top:30px;text-align:center;">
		             	<input type="button" name="BtnSave" class="sub-btn bg-color-l" id="BtnSave" value="立即设置" onclick="changeTradePwd_form_submit();" style="cursor: pointer;">
		           		<span id="resultTrade_span" style="color: red;font-size: 13px;"></span>
		            </div>
		            <div class="wenxintishi">
		            	<span>温馨提示：</span><br>
		              	1. 设置交易密码后，当您进行充值、提现、投资等操作时，必须输入交易密码。<br> 
		              	2. 为您资金更安全，交易密码必须和登录密码不同。
		          	</div>
				</form>
	       	</div>   
	        <!-------------------登录密码----------------->
        <div class="con-box2" id="con-box2" style="display:none;">
        	<form id="changeloginPwd_form" action="${ctx }/p2p/front/updatechangePwd.ht" method="post">
	        	<dl class="con-table-right xyhrzzl-tab">
	        		<dt>原登录密码：</dt>
       	  			<dd>
	        	  		<input class="text-input" type="password" name="beforePwd" id="beforePwd" class="text-input"><span id="beforePwd_" style="color: red;"></span>
	       			</dd>
	            	<dt>新登录密码：</dt>
        	  		<dd>
	        	  		<input class="text-input" type="password" name="newPwd" id="newPwd" class="text-input"><span id="newPwd_" style="color: red;"></span>
	        		</dd>
	            	<dt>确认新密码：</dt>
	       	  		<dd>
	        	  		<input class="text-input" type="password" name="reNewPwd" id="reNewPwd" class="text-input"><span id="reNewPwd_" style="color: red;"></span>
	        		</dd>
        		</dl>
	            <!----保存---->
				<div style="margin-top:30px;text-align:center;">
	              <input type="button" name="BtnSave" class="sub-btn bg-color-l" id="BtnSave" onclick="changeloginPwd_form_submit();" value="立即设置" style="cursor: pointer;">
	       		  <span id="result_span" style="color: red;font-size: 13px;"></span>
	            </div>
            </form>
       </div>
	</div>
  <script>
  
  function tabShowCon(showid)
  {
	  //$("#con-box1,#con-box2").hide();
	  //$("#"+showid).addClass(showid+"2");
	  if(showid=="Orange")
	  {
		$("#div_Orange").removeClass("Orange1").addClass("Orange2");
	  	$("#div_green").removeClass("green2").addClass("green1");
		$("#con-box2").show();$("#con-box1").hide();
		
	  }
		else
		{
		$("#div_Orange").removeClass("Orange2").addClass("Orange1");
		$("#div_green").removeClass("green1").addClass("green2");
		$("#con-box2").hide();$("#con-box1").show();
		}
	  //alert(showid);
  }
  </script>
</body>
</html>