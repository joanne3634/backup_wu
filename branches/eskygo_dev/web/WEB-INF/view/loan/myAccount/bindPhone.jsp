<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang=""> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title><%=application.getAttribute("PLATFORM_NAME")%> - 上传资料</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="${ctx }/crowdfunding/resources/css/personalInfo.css">
      <link rel="stylesheet" href="${ctx}/crowdfunding/Skin/Default/css/bindPhone.css">
</head>
<body class="iframe">
</head>


<body>
	<div class="addyourproject f_l">

		<header>
			<h2>修改/绑定手机</h2>
			<div class="tips">绑定手机号码，接收来自众筹的验证和通知短信。</div>
			</header>
        <div class="con-box">
	<form id="bindPhone_form" class="ink-form v2 vertical">
			<fieldset class="clear changePwdForm">
				<div class="control-group gutters">
                    <div class="control">
                    	<input type="tel" maxlength=11 name="phone" id="phone" class="text-input" required data-rules="required|mobile|exact_length[11]"/>
	                    <label class="all-100" for="phone">
	                    	手机号码 
	                    </label>
                    </div>
                </div>
				<div class="control-group gutters all-100">
                    <div class="control">
                    	<button class="getcode ink-button blue-light" style="position: absolute; z-index: 800; right: 0; font-size: .8em; padding-left: 1em; padding-right: 1em;" onclick="sendPhoneCode(this)">获取校验码</button>
                    	<input class="text-input" type="text" id="code" name="code" value="" required data-rules="required">
	                    <label class="all-100" for="code">
	                    	动态验证码
	                    </label>
	                    
                    </div>
                </div>
<!--           <dl>
            <dt></dt>
            <dd class="error-tips">格式有误格式有误格式有误</dd>
            <dt>登录密码 :</dt>
            <dd><input id="pass-box" class="text-input" type="text" placeholder="请输入登录密码"></dd>
            <dt></dt>
            <dd class="error-tips"></dd>
            <dt><span>*</span>手机号码 :</dt>
            <dd><input id="phone" maxlength="11" name="phone" class="text-input" type="text" placeholder="请输入手机号码"></dd>
            <dt></dt>
            <dd class="error-tips"></dd>
            <dt><span>*</span>动态验证码 :</dt><a class="text-input" href="javascript:;" onclick="sendPhoneCode()">点击获取验证码</a>
            <dd class="dongtai-yanzhengma"><input class="text-input" type="text" id="code" name="code" value="">
            <input class="getcode" onclick="sendPhoneCode(this)" style="margin-top:2px;margin-left:20px;padding:5px 10px;width: 140px;" type="button" value="获取校验码">
            <a style="font-size: 13px;color: red;width: 170px;" id="result_code"></a></dd>
            <dt></dt>
            <dd class="error-tips"></dd>
            <dt>验证码 :</dt>
            <dd class="yanzhengma-input"><input class="text-input" type="text"><img src="Skin/default/images/yanzhengma.png" alt=""><a href="#">看不清，换一个</a></dd>
          </dl> -->
<%--           <div style="text-align:center;">
            <input id="sub-btn-jibenxinxi" class="sub-btn" type="button" value="立即绑定" onclick="validatePhoneCode()">
          	<input type="button" onclick="window.location.href= '${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht';"  class="sub-btn" value="返回" style="margin-left:10px;cursor: pointer;">
          </div> --%>
<%--           <p style="text-align:center;margin-bottom:20px;font-size:15px;color:#999;">若您无法使用上述方法找回，请联系客服<%=application.getAttribute("CUCTOMER_SERVICE_TELEPHONE") %></p> --%>
          </fieldset>
                       <div class="control-group gutters">
                   <div class="control push-right">
                   		<a href="${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht" class="ink-button trans">返回</a>
                       <button id="submitBtn" class="ink-button blue-dark" type="submit">立即绑定</button>
                   </div>
               </div>
		</form>
		</div>
		</div>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script type="text/javascript">
var registerFormValidator;
$().ready(function() {
    var form = $('#bindPhone_form');

    Ink.requireModules( ['Ink.Dom.Selector_1','Ink.UI.Modal_1', 'Ink.UI.FormValidator_2'], function( Selector, Modal, FormValidator ){

        form.on('submit', function(e) {
        	e.preventDefault();

        });

        registerFormValidator = new FormValidator( '#bindPhone_form', {
            onSuccess : function(elements){
				valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
				$.post("${ctx}/safe/validatePhone.ht", {phone: $('#phone').val()})
					.success(function(data){
						var phoneEl = registerFormValidator.getElements().phone[0];
						if ( data ) {
							$.ajax({
								url : "${ctx}/safe/validatePhoneCode.ht",
								type : 'post',
								data :  $('#bindPhone_form').serialize(),
								dataType : 'html',
								success : function(data, status) {
									var datas = eval(data);
									if (datas == "0") {
				                        window.top.$.Dialog.toast({
				                            title: "提示",
				                            content: "绑定成功",
				                            onDismiss: function() {
				                            	window.location = "${ctx}/crowdfunding/tcuserPersonalData/changeAccountPwdPage.ht";
				                                /* window.parent.location.reload(); */
				                            }
				                        });
										setTimeout('window.location = "${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht";',2000);
										//location.reload();
										//$("#result_").html('绑定成功');
									}else{
				                        window.top.$.Dialog.toast({
				                            title: "提示",
				                            content: data,
				                            onDismiss: function() {
				                            	window.location = "${ctx}/safe/bindPhone.ht";
				                                /* window.parent.location.reload(); */
				                            }
				                        });
										setTimeout('window.location = "${ctx}/safe/bindPhone.ht";',2000);
										//$("#result_").html(datas);
										//window.reload();
									}
								},
								error : function(xhr, textStatus, errorThrown) {
									window.parent.openDialog("绑定异常，请联系管理员");
								}
							});
						} else {
							phoneEl.forceInvalid("电话已经被使用")
						}
					})
            },
            onError: function(elements){
            }
        } );
    });
})
 
 
/* 	if('${error}' !=""){
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
	}); */


  //向输入的绑定手机号码发送短信  、、、、、(验证码)
	function sendPhoneCode(obj) {
		valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
		
		if(registerFormValidator.getElements().phone[0].validate()){
			$.post("${ctx}/safe/validatePhone.ht", {phone: $('#phone').val()})
				.success(function(data){
					$.ajax({
						url : "${ctx}/safe/sendPhoneValiCode.ht",
						type : 'post',
						data : $('#bindPhone_form').serialize(),
						dataType : 'html',
						success : function(data, status) {
							var datas = eval(data);
							//$("#result_code").html(datas);
	                        window.top.$.Dialog.toast({
	                            title: "提示",
	                            content: datas,
	                            onDismiss: function() {
	                            	/* window.location = "${ctx}/crowdfunding/tcuserPersonalData/changeAccountPwdPage.ht"; */
	                                /* window.parent.location.reload(); */
	                            }
	                        });
							
						},
						error : function(xhr, textStatus, errorThrown) {
							//$("#result_code").html("发送失败");
	                        window.top.$.Dialog.toast({
	                            title: "提示",
	                            content: "发送异常，请重试",
	                            onDismiss: function() {
	                            	/* window.location = "${ctx}/crowdfunding/tcuserPersonalData/changeAccountPwdPage.ht"; */
	                                /* window.parent.location.reload(); */
	                            }
	                        });
						},
						beforeSend:function(){
							time(obj);
						}
					});
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
	      o.innerHTML = "获取验证码";
	      wait = 60;
	  } else {
	    o.setAttribute("disabled", true);
	    o.innerHTML = "重新发送(" + wait + ")";
	    wait--;
	    setTimeout(function() {
	        time(o)
	    },1000)
	  }
	}

</script>
</body>
</html>