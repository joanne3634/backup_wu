<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>修改/绑定手机</title>
	 		<%@ include file="/crowdfunding/cssorjs.jsp"%>
	<meta name="renderer" content="webkit"/>
    <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
    <link title="index" name="styleTag" rel="stylesheet" type="text/css" href="${ctx}/styles/default/css/web.css"></link>
    <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
   <link rel="stylesheet" href="${ctx}/crowdfunding/Skin/Default/css/Userbackground.css">
   <link rel="stylesheet" href="${ctx}/crowdfunding/Skin/Default/css/bindPhone.css">
</head>

<script type="text/javascript">
$().ready(function() {
	if('${error}' !=""){
		window.parent.openDialog('${error}');
	}
	 $("#bindPhone_form").validate({
	        rules: {
	    phone: {
	    required: true,
	    mobile: true,
	    remote: "${ctx}/safe/validatePhone.ht"
	   }
	 // code: {
	 //   required: true
	 //  }
	  },
	        messages: {
	    phone: {
	    required: "必填",
	    mobile: "请输入正确的手机号码",
	    remote: "号码已使用，请另选号码"
	   }
	   // code: {
	 //   required: "必填"
	 //  }
	        }
	        });
	});


  //向输入的绑定手机号码发送短信  、、、、、(验证码)
	function sendPhoneCode(obj) {
		valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
		if($('#bindPhone_form').valid()){
		$.ajax({
			url : "${ctx}/safe/sendPhoneValiCode.ht",
			type : 'post',
			data : $('#bindPhone_form').serialize(),
			dataType : 'html',
			success : function(data, status) {
				var datas = eval(data);
				//$("#result_code").html(datas);
				window.parent.openDialog(datas);
				
			},
			error : function(xhr, textStatus, errorThrown) {
				//$("#result_code").html("发送失败");
				window.parent.openDialog('发送异常，请重试');
			},
			beforeSend:function(){
				time(obj);
			}
		});
		}
	}
	function validatePhoneCode() {
		valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
		if($('#bindPhone_form').valid()){		
			var code = $("#code").val();
			if(code == ""){
				window.parent.openDialog('请输入验证码');
				return;
			}
		$.ajax({
			url : "${ctx}/safe/validatePhoneCode.ht",
			type : 'post',
			data :  $('#bindPhone_form').serialize(),
			dataType : 'html',
			success : function(data, status) {
				var datas = eval(data);
				if (datas == "0") {
					window.parent.openDialog('绑定成功');
					setTimeout('window.location = "${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht";',2000);
					//location.reload();
					//$("#result_").html('绑定成功');
				}else{
					window.parent.openDialog(datas);
					setTimeout('window.location = "${ctx}/safe/bindPhone.ht";',2000);
					//$("#result_").html(datas);
					//window.reload();
				}
			},
			error : function(xhr, textStatus, errorThrown) {
				window.parent.openDialog("绑定异常，请联系管理员");
			}
		});
			//reload();   //刷新验证码
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
<body>
<form id="bindPhone_form">
		<div class="addyourproject f_l">
			<h2><img src="${ctx}/crowdfunding/Skin/Default/images/headportrait4.png">修改/绑定手机</h2>
        <div class="con-box">
          <div class="tips" style="margin-top:40px;">>>绑定手机号码，接收来自众筹的验证和通知短信。</div>
          <dl>
            <dt></dt>
<!--             <dd class="error-tips">格式有误格式有误格式有误</dd>
            <dt>登录密码 :</dt>
            <dd><input id="pass-box" class="text-input" type="text" placeholder="请输入登录密码"></dd>
            <dt></dt> -->
            <dd class="error-tips"></dd>
            <dt><span>*</span>手机号码 :</dt>
            <dd><input id="phone" maxlength="11" name="phone" class="text-input" type="text" placeholder="请输入手机号码"></dd>
            <dt></dt>
            <dd class="error-tips"></dd>
            <dt><span>*</span>动态验证码 :</dt><!-- <a class="text-input" href="javascript:;" onclick="sendPhoneCode()">点击获取验证码</a> -->
            <dd class="dongtai-yanzhengma"><input class="text-input" type="text" id="code" name="code" value="">
            <input class="getcode" onclick="sendPhoneCode(this)" style="margin-top:2px;margin-left:20px;padding:5px 10px;width: 140px;" type="button" value="获取校验码">
            <a style="font-size: 13px;color: red;width: 170px;" id="result_code"></a></dd>
            <dt></dt>
            <dd class="error-tips"></dd>
<!--             <dt>验证码 :</dt>
            <dd class="yanzhengma-input"><input class="text-input" type="text"><img src="Skin/default/images/yanzhengma.png" alt=""><a href="#">看不清，换一个</a></dd> -->
          </dl>
          <div style="text-align:center;">
            <input id="sub-btn-jibenxinxi" class="sub-btn" type="button" value="立即绑定" onclick="validatePhoneCode()">
          	<input type="button" onclick="window.location.href= '${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht';"  class="sub-btn" value="返回" style="margin-left:10px;cursor: pointer;">
          </div>
          <p style="text-align:center;margin-bottom:20px;font-size:15px;color:#999;">若您无法使用上述方法找回，请联系客服<%=application.getAttribute("CUCTOMER_SERVICE_TELEPHONE") %></p>
        </div>
		</div>
		</form>
</body>
</html>