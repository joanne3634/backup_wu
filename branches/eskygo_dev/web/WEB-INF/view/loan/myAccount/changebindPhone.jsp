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
	 $("#changebindPhone_form").validate({
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
	    remote: "手机号码已存在，请重新输入"
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
		if($('#changebindPhone_form').valid()){	
		$.ajax({
			url : "${ctx}/safe/sendPhoneValiCode.ht",
			type : 'post',
			data : $('#changebindPhone_form').serialize(),
			dataType : 'html',
			success : function(data, status) {
				var datas = eval(data);
				time(obj);
				$("#result_code").html(datas);
			},
			error : function(xhr, textStatus, errorThrown) {
				$("#result_code").html("发送失败");
			},
			beforeSend:function(){
				time(obj);
			}
		});
		}
	}
	function validatePhoneCode() {
		valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
		if($('#changebindPhone_form').valid()){			
		$.ajax({
			url : "${ctx}/safe/validatePhoneCode.ht",
			type : 'post',
			data :  $('#changebindPhone_form').serialize(),
			dataType : 'html',
			success : function(data, status) {
				var datas = eval(data);
				if (datas == "0") {
					//window.parent.openDialog('绑定成功');
					setTimeout('window.location= "${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht"',2000);
					//location.reload();
					//$("#result_").html('绑定成功');
				}else{
					//window.parent.openDialog(datas);
					setTimeout('window.location = "${ctx}/safe/bindPhone.ht";',2000);
					//$("#result_").html(datas);
					//window.reload();
				}
			},
			error : function(xhr, textStatus, errorThrown) {
				//$("#result_").html("绑定异常，请联系管理员");
				window.parent.openDialog('绑定异常，请联系管理员');
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
</head>
<body>
			<div class="addyourproject f_l">
			<h2><img src="${ctx}/crowdfunding/Skin/Default/images/headportrait4.png">修改/绑定手机</h2>
			<div class="con-box bd-b-color-main bd-l-color-main bd-r-color-main">
					<div class="tips">>>您已绑定手机：${mobile }</div>
					<form id="changebindPhone_form">
					<dl class="con-table-right xyhrzzl-tab">
			            <dt>新手机号码 :</dt>
			            <dd>
			              <input maxlength="11" id="phone" name="phone" class="text-input" type="text" value="">
			            </dd>
			            <dt></dt>
            			<dd class="error-tips"></dd>
			            <dt>收到的验证码 :</dt>
			            <dd class="dongtai-yanzhengma">
			              <input name="code" class="text-input" type="text" value="">
			              <input class="getcode" onclick="sendPhoneCode(this)" style="margin-top:2px;margin-left:20px;padding:5px 10px;width: 140px;" type="button" value="获取校验码">&nbsp;<a id="result_code" style="color: red;font-size: 12px;"></a>
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
							<input id="sub-btn-jibenxinxi" class="sub-btn bg-color-l" type="button" value="确定修改" onclick="validatePhoneCode()">
							<input type="button" onclick="window.location.href= '${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht';"  class="sub-btn" value="返回" style="margin-left:10px;cursor: pointer;">
						</div>
					</dl>
					</form>
					<p style="text-align: center; margin-bottom: 20px; font-size: 15px; color: #999;">若您无法使用上述方法找回，请联系客服<%=application.getAttribute("CUCTOMER_SERVICE_TELEPHONE") %></p>
				</div>
		</div>
</body>
</html>