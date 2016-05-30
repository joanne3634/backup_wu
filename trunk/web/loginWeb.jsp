<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title><%=application.getAttribute("PLATFORM_NAME")%> - 登录</title>
	<meta name="renderer" content="webkit"/>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
	 <%-- <link title="index" name="styleTag" rel="stylesheet" type="text/css" href="${ctx}/styles/default/css/web.css"></link> --%>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
  	<link rel="stylesheet" href="${ctx}/crowdfunding/public.css">
  	<link rel="stylesheet" href="${ctx}/crowdfunding/Skin/Default/css/loginWeb.css">
</head>
<script type="text/javascript"> 
if(top!=this){//当这个窗口出现在iframe里，表示其目前已经timeout，需要把外面的框架窗口也重定向登录页面
	  top.location='${ctx}/loginWeb.jsp';
	}
$().ready(function() {
	
	 $("#loginForm").validate({
	        rules: {
	   loginName: {
		    required: true
		   },

	   loginPwd: {
	    required: true
	   }
	  // code: {
	  //  required: true,
	  //  remote : "${ctx}/user/validateCode.ht"
	  // }
	  },
	        messages: {
	   loginName: {
		    required: "请输入用户名"
		   },

	   loginPwd: {
	    required: "请输入密码"
	   }
	   //code: {
	  //  required: "请输入验证码",
	  //  remote : "验证码输入有误"
	   }
	  });
	});



function login_form_submit(){
	//var loginName = $("#loginName").val();
	//var loginPwd=$("#loginPwd").val();


	if($('#loginForm').valid()){
	$.ajax({
		url : "${ctx}/user/login.ht",
		type : 'post',
		data : $('#loginForm').serialize(),
		dataType : 'json',
		success : function(data,textStatus) {
			//console.log(data);
			if (data == "0") {
				openDialog('登录成功');	
				if('${loginPreUrl}'!=''){
					setTimeout('window.location= "${loginPreUrl}"',2000);
					//window.location= "${loginPreUrl}";
					<%session.setAttribute("loginPreUrl", "");%>
				}else{
					var urlStr = "<%= request.getHeader("Referer")%>";
					var ctxStr = "<%=request.getServerName()%>";
					if(urlStr.indexOf(ctxStr)>0){
						if(urlStr.indexOf("loginWeb")>0){
							setTimeout('window.location.href="${ctx}/loan/myAccount/myaccountPage.ht"',2000);
						}else{
							setTimeout('window.location.href="<%= request.getHeader("Referer")%>"',2000);
						}
					}else{
						setTimeout('window.location= "${ctx}/index-web.jsp"',2000);
					}
					
				}
			}else{
				openDialog(data);
				$("#login_submit").attr("onclick","login_form_submit();");
				$("#login_submit").val('登 录');				
				setTimeout('reload();',2000);
				//if(data.indexOf("验证码") == 0)
				//	$("#codeErrMsg").html(data);
				//else if(data.indexOf("登录密码") == 0)
				//	$("#pwdErrMsg").html(data);
				//else
				//	$("#nameErrMsg").html(data);
				//$("#error_div").html(data);
				//setTimeout('window.location.href = "${ctx}/loginWeb.jsp"',2000);
				
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			openDialog(XMLHttpRequest.statusText);
			setTimeout('window.location.href = "${ctx}/loginWeb.jsp"',2000);
		},
		beforeSend:function(){
			$("#login_submit").attr("onclick","");
			$("#login_submit").val('登录中...');
		}
	});
  }
}
function login_form_submit_Enterevent(e){
	 var keyCode = e.keyCode?e.keyCode:e.which?e.which:e.charCode;
	 if(keyCode == 13)
		 login_form_submit();
}

function reload(){
	var url="${ctx}/servlet/ValidCode?rand=" +new Date().getTime();
	document.getElementById("validImg").src=url;
}
</script> 
<style type="text/css">
.tipsa{
   color: #ff5200;
   text-decoration: none;
   line-height: 18px;
   font-size: 12px;
   margin-left: 5px;
}
</style>
<body>
	<!-- <div style="height:191px;overflow: hidden;">
	</div> -->
	<%@ include file="/crowdfunding/head.jsp"%>
   
    <form action="${ctx}/user/login.ht" method="post" id="loginForm">
    <div class="w-body mlr-auto mt30 mb30 t-c">
   		
        <div id="login-left" class="d-i-b  p20 bd-ccc t-l">
            <h2 style=" font-size: 28px;">登录无忧筹众筹平台</h2>
            <dl>
                <dt>用户名：</dt>
                <dd><input type="text" name="loginName" id="loginName" onkeydown="login_form_submit_Enterevent(event)"/></dd>
                <dt>密码：</dt>
                <dd><input name="loginPwd" id="loginPwd" type="password" onkeydown="login_form_submit_Enterevent(event)"></dd>
                <dt>验证码：</dt>
                <dd class="yanzhengma-input"><input type="text" id="code" name="code" onkeydown="login_form_submit_Enterevent(event)"><img src="${ctx}/servlet/ValidCode" id="validImg" alt="" onclick="reload()" style="cursor: pointer;" alt=""><a href="javascript:;" onclick="reload()">看不清，换一个</a></dd>
                <dt></dt>
                <dd>
                    <a class="join-btn" href="javascript:;" onclick="login_form_submit();">登 录</a>
                    <a href="${ctx }/safe/wangjimimapage.ht" class="tipsa">忘记密码</a>
                    <%-- <ul class="tips">
                        <li>还不是会员？<a href="${ctx}/user/registerInit.ht">立即注册</a></li>
                        <li><a href="${ctx }/safe/wangjimimapage.ht">忘记密码</a></li>
                    </ul> --%>
                </dd>
            </dl><%-- <% String login_password_error =  AppUtil.getServletContext().getAttribute("LOGIN_PASSWORD_ERROR_COUNT").toString(); %>
            <p class="wenxintishi">温馨提示：密码连续输错<%=login_password_error  %>次后，账户会被锁定，次日将会解锁</p> --%>
        </div>
        
        <div id="login-right" class="d-i-b ml20 t-l v-a-t">
            <p>没有账号？欢迎注册加入我们！</p>
            <div><a href="${ctx }/user/registerInit.ht?type=1">注册创业者</a><a href="${ctx }/user/registerInit.ht">注册投资人</a></div>
            <img src="${ctx }/images/login.png">
        </div>
    </div>
    </form>
	<div class="clear" style="height:130px;overflow: hidden;">
			<%@ include file="/crowdfunding/foot.jsp"%>
	</div>
</body>
</html>
