<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>重置安全问题</title>
<%@ include file="/crowdfunding/cssorjs.jsp"%>
      <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/reset.css">
<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/public.css">
   <link rel="stylesheet" href="${ctx}/crowdfunding/Skin/Default/css/Userbackground.css">
   <link rel="stylesheet" href="${ctx}/crowdfunding/Skin/Default/css/bindPhone.css"> 
</head>
<body>

		<div class="addyourproject f_l">
			<h2><img src="${ctx}/crowdfunding/Skin/Default/images/headportrait4.png">邮箱验证/修改安全问题</h2>
						<div class="con-box bd-b-color-main bd-l-color-main bd-r-color-main">
					<div class="tips">>>验证重置安全问题操作</div>
					<form id="bindEmail_form" action="${ctx}/safe/validateSingleEmailCode.ht" method="post">
					<dl class="con-table-right xyhrzzl-tab">
			            <dt>电子邮箱 :</dt>
						<dd>
							<input id="email" name="email" class="text-input" type="text" value="">
						</dd>
						 <dt></dt>
            			<dd class="error-tips"></dd>
						<dt>邮箱验证码 :</dt>
						<dd class="dongtai-yanzhengma">
							<input class="text-input" name="code" id="code" type="text" value="">
							<input class="getcode" onclick="sendEmailCode(this)" style="margin-top:2px;margin-left:20px;padding:5px 10px;width: 140px;" type="button" value="获取校验码">
							<a style="color: red;font-size: 12px;" id="code_result"></a>
						</dd>
					
						<div style="text-align: center;margin-bottom:-20px;margin-top:10px;height:14px;">
						 <span style="color: red;font-size: 12px;" id="result_"></span>
						</div>
						<div style="text-align: center;">
							<input id="sub-btn-jibenxinxi" class="sub-btn bg-color-l" type="button" value="提交" onclick="validateEmailCode()">
							<input type="button" onclick="window.location.href= '${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht';"  class="sub-btn" value="返回" style="margin-left:10px;cursor: pointer;">
						</div>
					</dl>
					</form>
					<p style="text-align: center; margin-bottom: 20px; font-size: 15px; color: #999;">若您无法使用上述方法找回，请联系客服<%=application.getAttribute("CUCTOMER_SERVICE_TELEPHONE") %></p>
				</div>
		</div>
</body>

<script type="text/javascript">

	$().ready(function() {
		
		if('${error}' != ""){
			window.parent.openDialog('${error}');
		}
		$("#bindEmail_form").validate({
			rules : {
				email : {
					required : true,
					email : true
				},
				loginPwd : {
					required : true,
					minlength : 6,
					maxlength : 15
				}
			},
			messages : {
				email : {
					required : "必填",
					email : "请输入正确的email地址"
				},
				loginPwd : {
					required : "请输入登录密码",
					minlength : $.validator.format("密码不能小于{0}个字 符"),
					maxlength : $.validator.format("密码不能大于{0}个字 符")
				}

			}
		});

	});

	function sendEmailCode(obj) {
		valiLoginTimeout('iframe'); //验证是否登录超时，跳转至登录页面	
		if ($('#bindEmail_form').valid()) {
			
			$.ajax({
				url : "${ctx}/safe/sendEmailValiCode.ht",
				type : 'post',
				data : "email=" + $("#email").val(),
				dataType : 'html',
				success : function(data, status) {
					var datas = eval(data);
					//$("#code_result").html(datas);
					window.parent.openDialog(datas);

				},
				error : function(xhr, textStatus, errorThrown) {
					window.parent.openDialog("发送异常，请联系管理员");
				},
				beforeSend:function(){
					time(obj);
				}
			});
		}
	}
	//邮箱重置安全问题
	function validateEmailCode() {
		valiLoginTimeout('iframe'); //验证是否登录超时，跳转至登录页面
		if($('#bindEmail_form').valid()){
			$("#bindEmail_form").submit();
		}
		
	}

	function codekeyUp() {
		var code = $("#validCode").val();
		if (code == "") {
			//$("#code_a").html("请输入验证码");
			window.parent.openDialog("请输入验证码");
		} else {
			$("#code_a").html('');
		}
	}

	function reload() {
		var url = "${ctx}/servlet/ValidCode?rand=" + new Date().getTime();
		document.getElementById("validImg").src = url;
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
</html>