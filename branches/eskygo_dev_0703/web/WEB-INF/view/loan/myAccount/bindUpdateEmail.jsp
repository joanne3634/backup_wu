<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>绑定/修改邮箱</title>
<%@ include file="/crowdfunding/cssorjs.jsp"%>
<script type="text/javascript"
	src="${ctx}/js/jquery/jquery.validate.min.js"></script>
<script type="text/javascript"
	src="${ctx}/js/jquery/jquery.validate.ext.js"></script>

   <link rel="stylesheet" href="${ctx}/crowdfunding/Skin/Default/css/Userbackground.css">
   <link rel="stylesheet" href="${ctx}/crowdfunding/Skin/Default/css/bindPhone.css"> 
   <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/reset.css">
<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/public.css">
	
	<script type="text/javascript">
$().ready(function() {
	if('${error}' != ""){
		window.parent.openDialog('${error}');
	}
	//原邮箱修改邮箱验证
	 $("#valiEmail_form").validate({
	        rules: {
	    email: {
	    required: true,
	    email: true
	    
	   }
	  //  code: {
	  //  required: true
	   //}
	  },
	        messages: {
	    email: {
	    required: "必填",
	    email: "请输入正确的邮箱"
	  }
	   //code: {
	   // required: "必填"
	  // }
	        }

	        });
	 
	 
	 //身份证和手机修改邮箱验证
	 $("#valishenfenPhone_form").validate({
	        rules: {
	    idNo: {
	    required: true,
	    idNo: true
	   },
	    phone: {
	    required: true,
	    mobile : true
	   }
	  },
	        messages: {
	    idNo: {
	    required: "必填",
	    idNo: "请输入正确的身份证号"
	  },
	   phone: {
	    required: "必填",
	    mobile : "请输入正确的手机号码"
	   }
	        }

	        });
	});
	//原邮箱方式修改
	function ValichangephoneWheresfEmail(){
		valiLoginTimeout('iframe'); //验证是否登录超时，跳转至登录页面
		if($('#valiEmail_form').valid()){
			$("#valiEmail_form").submit();
		}
	}
	
	
     //向输入的原邮箱发送邮件  、、、、、(验证码)
	function sendEmailCode(obj) {
		valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
		if($('#valiEmail_form').valid()){
		$.ajax({
			url : "${ctx}/safe/sendEmailValiCode.ht",
			type : 'post',
			data : $('#valiEmail_form').serialize(),
			dataType : 'html',
			success : function(data, status) {
				var datas = eval(data);
				if(datas == "0"){
					//location = "";
					window.parent.openDialog('请正确输入原绑定邮箱');
					setTimeout('window.location = "${ctx}/safe/bindEmail.ht";',2000);
				}else{
					
					$("#email").attr("readonly","readonly");
					//$("#email_code").html(datas);
					window.parent.openDialog(datas);
				}
			},
			error : function(xhr, textStatus, errorThrown) {
				//$("#email_code").html("发送失败");
				window.parent.openDialog("发送异常");
			},
			beforeSend:function(){
				time(obj);
			}
		});
	}
}

	
	
	//原手机方式修改
	function validatePhoneCode(){
		valiLoginTimeout('iframe'); //验证是否登录超时，跳转至登录页面
		if($('#valishenfenPhone_form').valid()){
			$("#valishenfenPhone_form").submit();
		}
	}
	  //向输入的原手机号码发送短信  、、、、、(验证码)
	function sendPhoneCode(obj) {
		valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
		if($('#valishenfenPhone_form').valid()){	
		$.ajax({
			url : "${ctx}/safe/sendEmailResetEmailValiCode.ht",
			type : 'post',
			data : $('#valishenfenPhone_form').serialize(),
			dataType : 'html',
			success : function(data, status) {
				var datas = eval(data);
				if(datas == "1"){
					//location = "";
					$("#email").attr("readonly","readonly");
					$("#idNo").attr("readonly","readonly");
					window.parent.openDialog("验证码已发送，请查收");
					//$("#result_code").html(datas);
				}else if(datas == "0"){
					//$("#result_code").html(datas);
					window.parent.openDialog("验证码发送失败，请重试");
				}else{
					window.parent.openDialog(datas);
					setTimeout('window.location = "${ctx}/safe/bindEmail.ht";',2000);
				}
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
<style type="text/css">
.color-main{
	margin-left:60px;
}
</style>
</head>

<body>
		<div class="addyourproject f_l">
			<h2><img src="${ctx}/crowdfunding/Skin/Default/images/headportrait4.png">修改/绑定邮箱</h2>
				<div class="con-box bd-b-color-main bd-l-color-main bd-r-color-main">
			<div class="tips">>>您已绑定邮箱：${email }</div>
			<div class="texta-c con-tips" style="border:none;margin-left:200px;font-size: 15px;"><span>通过【原绑定邮箱】 + 【短信验证码】修改邮箱</span>
			<a class="f-r color-main" href="javascript:;" style=" display:none" >点击修改</a>
			</div>
			<form <c:if test="${not empty flag }">class="d-n"</c:if> action="${ctx }/safe/ValichangeEmailCode.ht" id="valiEmail_form">
			<dl class="con-table-right xyhrzzl-tab"  style="padding-bottom: 50px;">
								<dt></dt>
					<dd class="error-tips"></dd>
				<dt>原绑定邮箱 :</dt>
				<dd><input id="emailFlag" name="emailFlag" type="hidden" value="changeEmail"/>
					<input id="email" name="email" class="text-input" type="text"
						value="">
				</dd>
									<dt></dt>
					<dd class="error-tips"></dd>
				<dt>邮箱动态验证码 :</dt>
				<dd class="dongtai-yanzhengma">
					<input name="code" class="text-input" type="text" value="">
					<input class="getcode" onclick="sendEmailCode(this)" style="margin-top:2px;margin-left:20px;padding:5px 10px;width: 140px;" type="button" value="获取校验码">
					&nbsp;<a id="email_code" style="color: red;font-size: 12px;width: 170px;"></a>
				</dd>

				<div style="text-align: center; margin-bottom: -20px; margin-top: 10px; height: 14px;">
					<span style="color: red; font-size: 12px;" id="result_"></span>
				</div>
				<div style="text-align: center;">
					<input id="sub-btn-jibenxinxi" class="sub-btn bg-color-l"
						type="button" value="下一步" onclick="ValichangephoneWheresfEmail()">
						<input type="button" onclick="window.location.href= '${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht';"  class="sub-btn" value="返回" style="margin-left:10px;cursor: pointer;">
				</div>
			</dl>
			</form>
			<div class="texta-c con-tips" style="border:none;margin-left:200px;font-size: 15px;"><span> 通过【身份认证】 + 【原绑定手机】修改邮箱</span><a class="f-r color-main" href="javascript:;">点击修改</a></div>
			<form <c:if test="${empty flag }">class="d-n" style="display:none;"</c:if> action="${ctx }/safe/ValichangeemailWheresfEmail.ht" id="valishenfenPhone_form" method="post">
			<dl class="con-table-right xyhrzzl-tab">
								<dt></dt>
					<dd class="error-tips"></dd>
				<dt>身份证号码 :</dt>
				<dd>
					<input id="idNo" name="idNo" class="text-input" type="text"
						value="">
				</dd>
									<dt></dt>
					<dd class="error-tips"></dd>
				<dt>原手机 :</dt>
				<dd>
					<input maxlength="11" id="phone" name="phone" class="text-input" type="text"
						value="">
				</dd>
									<dt></dt>
					<dd class="error-tips"></dd>
				<dt>手机动态验证码 :</dt>
				<dd class="dongtai-yanzhengma">
					<input name="ecode" class="text-input" type="text" value="">
					<input class="getcode" onclick="sendPhoneCode(this)" style="margin-top:2px;margin-left:20px;padding:5px 10px;width: 140px;" type="button" value="获取校验码">
					&nbsp;<a id="result_code" style="color: red;font-size: 12px;width: 170px;"></a>
				</dd>

				<div style="text-align: center; margin-bottom: -20px; margin-top: 10px; height: 14px;">
					<span style="color: red; font-size: 12px;" id="result_"></span>
				</div>
				<div style="text-align: center;">
					<input id="sub-btn-jibenxinxi" class="sub-btn bg-color-l"
						type="button" value="下一步" onclick="validatePhoneCode()">
						<input type="button" onclick="window.location.href= '${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht';"  class="sub-btn" value="返回" style="margin-left:10px;cursor: pointer;">
				</div>
			</dl>
			</form>
			<p style="text-align: center; margin-bottom: 20px; font-size: 15px; color: #999;">若您无法使用上述方法找回，请联系客服<%=application.getAttribute("CUCTOMER_SERVICE_TELEPHONE") %></p>
		</div>
		</div>

</body>
      <script>
      	$(function(){
      		$(".con-tips a").toggle(function(){$("form").hide();$(this).parent().next().toggle();},function(){$("form").hide();$(this).parent().next().toggle();})
      	})
      </script>
<script type="text/javascript">

	$().ready(function() {
		$("#bindEmail_form").validate({
			rules : {
				email : {
					required : true,
					email : true,
					remote : "${ctx}/safe/validateEmail.ht"
				},
				loginPwd : {
					required : true,
					minlength : 6,
					maxlength : 15
				}
			},
			messages : {
				email : {
					required : "请输入Email地址",
					email : "请输入正确的email地址",
					remote : "邮箱已存在，请重新输入"
				},
				loginPwd : {
					required : "请输入登录密码",
					minlength : $.validator.format("密码不能小于{0}个字 符"),
					maxlength : $.validator.format("密码不能大于{0}个字 符")
				}

			}
		});

	});



	function validateEmailCode() {

		if ($('#bindEmail_form').valid()) {
			var code = $("#validCode").val();
			if (code == "") {
				$("#code_a").html("请输入验证码");
				return;
			}

			$.ajax({
				url : "${ctx}/safe/validateEmailCode.ht",
				type : 'post',
				data : $("#bindEmail_form").serialize(),
				dataType : 'html',
				success : function(data, status) {
					var datas = eval(data);
					if (datas == "0") {
						$("#div_result").html("绑定邮箱成功");
						//location.reload();
					} else {
						$("#div_result").html(datas);
					}
					reload();
				},
				error : function(xhr, textStatus, errorThrown) {
					$("#div_result").html('绑定异常，请联系管理员');
				}
			});
		}
	}

	function codekeyUp() {
		var code = $("#validCode").val();
		if (code == "") {
			$("#code_a").html("请输入验证码");
		} else {
			$("#code_a").html('');
		}
	}

	function reload() {
		var url = "${ctx}/servlet/ValidCode?rand=" + new Date().getTime();
		document.getElementById("validImg").src = url;
	}

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
	
var checkMarkRequesting = false;
var hasRequest = false;
var counterInterval;
var regexPhone = /^(((1[3456789][0-9]{1})|(15[0-9]{1}))+\d{8})$/;
var regexEmail =  /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
var count = 60;
function requestCheckMarkPhone(){
	if(checkMarkRequesting){
		return;
	}
	var phoneNum = $("#phone").val();
	if(!regexPhone.test(phoneNum)){
		alert("你输入的手机号码不正确！");
		return;
	}

	counterInterval = setInterval(function(){
		count --;
		if(count<=0){
			$("#phoneBtn").html("获取验证码");
			clearInterval(counterInterval);
			checkMarkRequesting=false;
			count=60;
			return;
		}
		$("#phoneBtn").html(count+"秒后重试");
	},1000);
	checkMarkRequesting = true;
// 	$.ajax({
// 		url:"${ctx}/weixin/wxuser/sendWeixinRegisterCheckCode.ht",
// 		data:"phone="+phoneNum,
// 		dataType:"json",
// 		type:'post',
// 		success:function(rsp){
// 			if(rsp.result){
// 				hasRequest = true;
// 				$("#code").removeAttr("disabled");
// 			}else{
// 				alert(rsp.message);
// 			}
// 		},
// 		error:function(){
// 			alert("网络异常，请稍后重试！");
// 		}
// 	});
}
function requestCheckMarkEmail(){
	if(checkMarkRequesting){
		return;
	}
	
	var emailNum = $("#email").val();
	if(!regexEmail.test(emailNum)){
		alert("你输入的邮箱不正确！");
		return;
	}
	counterInterval = setInterval(function(){
		count --;
		if(count<=0){
			$("#emailBtn").html("获取验证码");
			clearInterval(counterInterval);
			checkMarkRequesting=false;
			count=60;
			return;
		}
		$("#emailBtn").html(count+"秒后重试");
	},1000);
	checkMarkRequesting = true;

}
</script>

</html>