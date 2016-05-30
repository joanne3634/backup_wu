<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
		<title>修改/绑定邮箱</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
    <link rel="stylesheet" href="${ctx}/crowdfunding/resources/css/bindEmail.css?&_cache=0" type="text/css">
<%@ include file="/crowdfunding/globaljs.jsp"%>
			      <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
<script type="text/javascript">
$().ready(function() {
	if('${error}' !=""){
		openDialog('${error}');
	}
	
	
	 $("#bindEmail_form").validate({
	        rules: {
	    email: {
	    required: true,
	    email: true,
	    remote: "${ctx}/safe/validateEmail.ht"
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
		data : "email=" + $("#email").val(),
		dataType : 'html',
		success : function(data, status) {
			var datas = eval(data);		
			//$("#code_result").html(datas);
			openDialog(datas);
			
		},
		error : function(xhr, textStatus, errorThrown) {
			$("#code_result").html("发送异常，请重试");
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
		var code = $("#code").val();
		if(code == ""){
			openDialog('请输入验证码');
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
				//$("#div_result").html("绑定邮箱成功");
				openDialog('绑定邮箱成功');
				setTimeout('window.location= "${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht"',2000);
				//location.reload();
			}else{
				openDialog(datas);
				setTimeout('window.location= "${ctx}/safe/bindEmail.ht"',2000);
			}
		},
		error : function(xhr, textStatus, errorThrown) {
			openDialog('绑定异常，请联系管理员',"30%","30%");
		}
	});
  }
}


function codekeyUp(){
	var code = $("#code").val();
	if(code == ""){
		openDialog('请输入验证码');
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
</head>
<body class="iframe">
<form id="bindEmail_form">
		<div id="bindEmail" class="all-100 push-center addyourproject f_l">
			<div class="title">
				<h3><i class="fa fa-envelope-o"></i>邮箱绑定</h3>
			</div>
        <div class="con-box content">
          <div class="tips">>>绑定邮箱，接收来自众筹的验证和通知短信。</div>
          <dl>
            <dt></dt>
<!--             <dd class="error-tips">格式有误格式有误格式有误</dd>
            <dt>登录密码 :</dt>
            <dd><input id="pass-box" class="text-input" type="text" placeholder="请输入登录密码"></dd>
            <dt></dt> -->
            <dd class="error-tips"></dd>
            <dt><span>*</span>邮箱:</dt><input id="emailFlag" name="emailFlag" type="hidden" value="bindEmail"/>
            <dd><input id="email" name="email" value="" class="text-input" type="text" placeholder="请输入邮箱"></dd>
            <dt></dt>
            <dd class="error-tips"></dd>
            <dt><span>*</span>邮箱验证码 :</dt>
            <dd class="dongtai-yanzhengma"><input class="text-input" type="text" id="code" name="code" value="">
            <input class="getcode" onclick="sendEmailCode(this)"  type="button" value="获取校验码"><a id="code_result"></a></dd>
            <dt></dt>
            <dd class="error-tips"></dd>
<!--             <dt>验证码 :</dt>
            <dd class="yanzhengma-input"><input class="text-input" type="text"><img src="Skin/default/images/yanzhengma.png" alt=""><a href="#">看不清，换一个</a></dd> -->
          </dl>
          <div style="text-align:center;">
            <input id="sub-btn-jibenxinxi" class="ink-button blue" type="button" value="立即绑定" onclick="validateEmailCode()">
         	<input type="button" class="ink-button blue" onclick="window.location.href= '${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht';"  class="sub-btn" value="返回" style="margin-left:10px;cursor: pointer;">
          </div>
          <p id="contact">若您无法使用上述方法找回，请联系客服<%=application.getAttribute("CUCTOMER_SERVICE_TELEPHONE") %></p>
        </div>
		</div>
		</form>
</body>
</html>