<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>绑定手机</title>
<%@ include file="/crowdfunding/cssorjs.jsp"%>
	
      <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
   <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/reset.css">
<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/public.css">
   <link rel="stylesheet" href="${ctx}/crowdfunding/Skin/Default/css/Userbackground.css">
   <link rel="stylesheet" href="${ctx}/crowdfunding/Skin/Default/css/bindPhone.css">

<script type="text/javascript">
$().ready(function() {
	if('${error}' != ""){
		window.parent.openDialog('${error}');
	}
	
	//原手机修改手机号码验证
	 $("#valiPhone_form").validate({
	        rules: {
	    phone: {
	    required: true,
	    mobile: true
	   }
	  //  code: {
	  //  required: true
	   //}
	  },
	        messages: {
	    phone: {
	    required: "必填",
	    mobile: "请输入正确的手机号码"
	  }
	   //code: {
	   // required: "必填"
	  // }
	        }

	        });
	 
	 
	 //身份证和邮箱修改手机验证
	 $("#valishenfenEmail_form").validate({
	        rules: {
	    idNo: {
	    required: true,
	    idNo: true
	   },
	    email: {
	    required: true,
	    email : true
	   }
	  },
	        messages: {
	    idNo: {
	    required: "必填",
	    idNo: "请输入正确的身份证号"
	  },
	   email: {
	    required: "必填",
	    email : "请输入正确的邮箱地址"
	   }
	        }

	        });
	});
	//原邮箱方式修改
	function ValichangephoneWheresfEmail(){
		valiLoginTimeout('iframe'); //验证是否登录超时，跳转至登录页面
		if($('#valishenfenEmail_form').valid()){
			$("#valishenfenEmail_form").submit();
		}
	}
	
	
     //向输入的原邮箱发送邮件  、、、、、(验证码)
	function sendEmailCode(obj) {
		valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
		if($('#valishenfenEmail_form').valid()){
		$.ajax({
			url : "${ctx}/safe/sendEmailResetPhoneValiCode.ht",
			type : 'post',
			data : $('#valishenfenEmail_form').serialize(),
			dataType : 'html',
			success : function(data, status) {
				var datas = eval(data);
				if(datas == '1'){
					
					$("#email").attr("readonly","readonly");
					$("#idNo").attr("readonly","readonly");
					//$("#email_code").html('验证码已发送，请查收');
					window.parent.openDialog('验证码已发送，请查收');
				}else if(datas == '0'){ 
					//$("#email_code").html('验证码发送失败，请稍后再试');
					window.parent.openDialog('验证码发送失败，请再试');
				}else{
					window.parent.openDialog(datas);
					setTimeout('window.location = "${ctx}/safe/bindPhone.ht?flag=flag";',2000);
				}

			},
			error : function(xhr, textStatus, errorThrown) {
				window.parent.openDialog("发送异常，请重试");
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
		if($('#valiPhone_form').valid()){
			$("#valiPhone_form").submit();
		}
	}
	  //向输入的原手机号码发送短信  、、、、、(验证码)
	function sendPhoneCode(obj) {
		valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
		if($('#valiPhone_form').valid()){	
		$.ajax({
			url : "${ctx}/safe/sendPhoneValiCode.ht",
			type : 'post',
			data : $('#valiPhone_form').serialize(),
			dataType : 'html',
			success : function(data, status) {
				var datas = eval(data);
				if(datas == "0"){
					//location = "";
					window.parent.openDialog('请输入正确的原手机号码');
					setTimeout('window.location = "${ctx}/safe/bindPhone.ht";',2000);
				}else{			
					$("#phone").attr("readonly","readonly");
					//$("#result_code").html(datas);
					window.parent.openDialog(datas);
				}
			},
			error : function(xhr, textStatus, errorThrown) {
				window.parent.openDialog('发送失败异常');
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
			<h2><img src="${ctx}/crowdfunding/Skin/Default/images/headportrait4.png">修改/绑定手机</h2>
				<div class="con-box bd-b-color-main bd-l-color-main bd-r-color-main">
					<div class="tips">>>您已绑定手机：${mobile }</div>
					<div class="texta-c con-tips" style="border:none;margin-left:200px;font-size: 15px;"><span>通过【原手机号】 + 【短信验证码】修改手机</span><a class="f-r color-main" href="javascript:;">点击修改</a></div>
					<form <c:if test="${not empty flag }">class="d-n"</c:if> action="${ctx }/safe/ValichangephoneCode.ht" id="valiPhone_form" method="post">
					<dl   style="padding-bottom: 50px;">
					<dt></dt>
					<dd class="error-tips"></dd>
			            <dt>原手机号码 :</dt>
			            <dd><input type="hidden" id="phoneFlag" name="phoneFlag" value="changephone"/>
			              <input maxlength="11" id="phone" name="phone" class="text-input" type="text" value="">
			            </dd>
			                        <dt></dt>
            <dd class="error-tips"></dd>
			            <dt>收到的验证码 :</dt>
			            <dd class="dongtai-yanzhengma">
			              <input name="code" class="text-input" type="text" value="">
			              <input class="getcode" onclick="sendPhoneCode(this)" style="margin-top:2px;margin-left:20px;padding:5px 10px;width: 140px;" type="button" value="获取校验码"><a id="result_code" style="color: red;font-size: 12px;width: 170px;"></a>
			            </dd>
<!-- 						<dt>验证码 :</dt>
						<dd class="yanzhengma-input">
							<input class="text-input" type="text" id="validCode" name="validCode" onkeyup="codekeyUp();"><img src="${ctx}/servlet/ValidCode" id="validImg"  onclick="reload()" style="cursor: pointer;" alt=""><a class="color-main" href="javascript:;" onclick="reload()">看不清，换一个</a>
							<a style="color: red;font-size: 12x;" id="code_a"></a>
						</dd> -->
					
						<div style="text-align: center;margin-bottom:-20px;margin-top:10px;height:14px;">
						 <span style="color: red;font-size: 12px;" id="result_"></span>
						</div>
						<div style="text-align: center;">
							<input id="sub-btn-jibenxinxi" class="sub-btn bg-color-l" type="button" value="下一步" onclick="validatePhoneCode()">
							<input type="button" onclick="window.location.href= '${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht';"  class="sub-btn" value="返回" style="margin-left:10px;cursor: pointer;">
						</div>
					</dl>
					</form>
					<div class="texta-c con-tips" style="border:none;margin-left:200px;font-size: 15px;"><span> 通过【身份认证】 + 【原绑定邮箱】修改手机</span><a class="f-r color-main" href="javascript:;">点击修改</a></div>
					<form <c:if test="${empty flag }">class="d-n" style="display:none;"</c:if>  action="${ctx }/safe/ValichangephoneWheresfEmail.ht" id="valishenfenEmail_form" method="post">
					<dl class="con-table-right xyhrzzl-tab">
<!-- 						<dt>登录密码 :</dt>
						<dd>
							<input id="loginPwd" name="loginPwd" class="text-input" type="password" value="">
						</dd> -->
						            <dt></dt>
            <dd class="error-tips"></dd>
			            <dt>身份证号码 :</dt>
			            <dd>
			              <input id="idNo" name=idNo class="text-input" type="text" value="">
			            </dd><input type="hidden" id="emailFlag" name="emailFlag" value="changephone"/>
			            <input type="hidden" id="mobile" name="mobile" value="${mobile }"/>
			            <dt></dt>
			                        <dd class="error-tips"></dd>			            
			            <dt>绑定邮箱 :</dt>
			            <dd>
			              <input id="email" name="email" class="text-input" type="text" value="">
			            </dd>
			                        <dt></dt>
            <dd class="error-tips"></dd>
			            <dt>邮箱动态验证码 :</dt>
			            <dd class="dongtai-yanzhengma">
			              <input name="code" class="text-input" type="text" value="">
			              <input class="getcode" onclick="sendEmailCode(this)" style="margin-top:2px;margin-left:20px;padding:5px 10px;width: 140px;" type="button" value="获取校验码">&nbsp;<a style="color: red;font-size: 12px;width: 170px;" id="email_code"></a>
			            </dd>
<!-- 						<dt>验证码 :</dt>
						<dd class="yanzhengma-input">
							<input class="text-input" type="text" id="validCode" name="validCode" onkeyup="codekeyUp();"><img src="${ctx}/servlet/ValidCode" id="validImg"  onclick="reload()" style="cursor: pointer;" alt=""><a class="color-main" href="javascript:;" onclick="reload()">看不清，换一个</a>
							<a style="color: red;font-size: 12x;" id="code_a"></a>
						</dd> -->
						
						<div style="text-align: center;margin-bottom:-20px;margin-top:10px;height:14px;">
						 <span style="color: red;font-size: 12px;" id="result_"></span>
						</div>
						<div style="text-align: center;">
							<input id="sub-btn-jibenxinxi" class="sub-btn bg-color-l" type="button" value="下一步" onclick="ValichangephoneWheresfEmail()">
							<input type="button" onclick="window.location.href= '${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht';"  class="sub-btn" value="返回" style="margin-left:10px;cursor: pointer;">
						</div>
					</dl>
					</form>
					<p style="text-align: center; margin-bottom: 20px; font-size: 15px; color: #999;">若您无法使用上述方法找回，请联系客服<%=application.getAttribute("CUCTOMER_SERVICE_TELEPHONE") %></p>
				</div>
		</div>
      
      <script>
      	$(function(){
      		$(".con-tips a").toggle(function(){$("form").hide();$(this).parent().next().toggle();},function(){$("form").hide();$(this).parent().next().toggle();})
      	})
      </script>
</body>
</html>