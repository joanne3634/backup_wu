<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>绑定邮箱</title>
  <%@ include file="/crowdfunding/cssorjs.jsp"%>
    <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/reset.css">
<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/public.css">
   <link rel="stylesheet" href="${ctx}/crowdfunding/Skin/Default/css/Userbackground.css">
   <link rel="stylesheet" href="${ctx}/crowdfunding/Skin/Default/css/bindPhone.css"> 
</head>
<script type="text/javascript">
$().ready(function() {
	 $("#bindEmail_form").validate({
	        rules: {
	    email: {
	    required: true,
	    email: true,
	    remote: "${ctx}/safe/validateBindEmail.ht"
	   }
	  },
	        messages: {
	    email: {
	    required: "必填",
	    email: "请输入正确的email地址",
	    remote: "邮箱已存在，请重新输入"
	   }
	  }
	    });
	 
	});




function sendEmailCode(obj) {
	valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
	if($('#bindEmail_form').valid()){
	$.ajax({
		url : "${ctx}/safe/sendEmailValiCode.ht",
		type : 'post',
		data : $("#bindEmail_form").serialize(),
		dataType : 'html',
		success : function(data, status) {
			var datas = eval(data);		
			//$("#code_result").html(datas);	
			window.parent.openDialog(datas);
		},
		error : function(xhr, textStatus, errorThrown) {
			window.parent.openDialog('发送异常，请重试');
		},
		beforeSend:function(){
			time(obj);
		}
	});
	}
}

function validateEmailCode() {	
	valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
	if($('#bindEmail_form').valid()){	
	$.ajax({
		url : "${ctx}/safe/validateEmailCode.ht",
		type : 'post',
		data : $("#bindEmail_form").serialize(),
		dataType : 'html',
		success : function(data, status) {
			var datas = eval(data);
			if (datas == "0") {
				//$("#div_result").html("绑定邮箱成功");
				window.parent.openDialog('修改邮箱成功');
				setTimeout('window.location= "${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht"',2000);
			}else{
				window.parent.openDialog(datas);
			}
		},
		error : function(xhr, textStatus, errorThrown) { 
			window.parent.openDialog('修改异常，请联系管理员');
		}
	});
  }
}


function codekeyUp(){
	var code = $("#validCode").val();
	if(code == ""){
		$("#code_a").html("请输入验证码");
	}else{
		$("#code_a").html('');
	}
}


function reload(){
	var url="${ctx}/servlet/ValidCode?rand=" +new Date().getTime();
	document.getElementById("validImg").src=url;
}


var wait=60;
function time(o) {
  if (wait == 0) {
      o.removeAttribute("disabled");          
      o.value="获取验证码";
      wait = 60;
  } else {
    o.setAttribute("disabled", true);
    o.value="重新发送(" + wait + ")";
    wait--;
    setTimeout(function() {
        time(o)
    },1000)
  }
}
</script>
<body>	
			<div class="addyourproject f_l">
			<h2><img src="${ctx}/crowdfunding/Skin/Default/images/headportrait4.png">修改/绑定邮箱</h2>
			<form id="bindEmail_form">
				<div class="con-box bd-b-color-main bd-l-color-main bd-r-color-main" >
					<div class="tips">>>绑定邮箱，接收来自众筹的验证和邮箱验证。</div>
					<dl class="con-table-right xyhrzzl-tab">
<!-- 						<dt>登录密码 :</dt>
						<dd>
							<input id="loginPwd" name="loginPwd" class="text-input" type="password"
								value="">
						</dd> -->
						<dt>新邮箱 :</dt>
						<dd>
							<input id="email" name="email" class="text-input" type="text" value="">
						</dd>
						<dt></dt>
            			<dd class="error-tips"></dd>
						<dt>邮箱验证码 :</dt>
						<dd class="dongtai-yanzhengma" style="height: 42px;">
							<input class="text-input" name="code" id="code" type="text" value="">
							<input class="getcode" onclick="sendEmailCode(this)" style="margin-top:2px;margin-left:20px;padding:5px 10px;width: 140px;" type="button" value="获取校验码">
							<a style="color: red;font-size: 12px;" id="code_result"></a>
						</dd>
<!-- 						<dt>验证码 :</dt>
						<dd class="yanzhengma-input">
							<input class="text-input" type="text" id="validCode" name="validCode"  onkeyup="codekeyUp();"><img src="${ctx}/servlet/ValidCode" id="validImg"  onclick="reload()" alt=""><a class="color-main" href="javascript:;" onclick="reload()">看不清，换一个</a>
							<a style="color: red;font-size: 12x;" id="code_a"></a>
						</dd> -->
					</dl><div style="text-align: center;margin-bottom:-20px;margin-top:10px;">
					<span id="div_result" style="color: red;font-size: 12px;"></span></div>
					<div style="text-align: center;">
						<input id="sub-btn-jibenxinxi" class="sub-btn bg-color-l" type="button" value="确定修改" onclick="validateEmailCode()">
						<input type="button" onclick="window.location.href= '${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht';"  class="sub-btn" value="返回" style="margin-left:10px;cursor: pointer;">
					</div>
					<p style="text-align: center; margin-bottom: 20px; font-size: 15px; color: #999;">若您无法使用上述方法找回，请联系客服400-888-8888</p>
				</div>
			</form>
		</div>
				
	<script>
		$(function() {

			$("#pass-box").focus(function() {
				if ($(this).val() == "") {
					$(this).attr("value", "");
				}
				;
			}).blur(function() {
				if ($(this).val() == "") {
					$(this).attr("value", "");
				}
				;
			})

			$("#mail-box").focus(function() {
				if ($(this).val() == "") {
					$(this).attr("value", "");
				}
				;
			}).blur(function() {
				if ($(this).val() == "") {
					$(this).attr("value", "");
				}
				;
			})
		})
	</script>
</body>
</html>