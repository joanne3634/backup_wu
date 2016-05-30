<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html lang="en">
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<%@ include file="/commons/includeFront/javascripts.jsp"%>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>



<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/signin.css">
<title><%=application.getAttribute("PLATFORM_NAME")%>-免费注册</title>
</head>

<script type="text/javascript">
$().ready(function() {
	 $("#register_form").validate({
	        rules: {
	   loginName: {
		    required: true,
		    chrnum:true,
		    minlength:5,
		    maxlength:12,	    
		    remote: "${ctx}/user/validateUserName.ht"
		   },
	   email: {
	    required: true,
	    email: true,
	    remote: "${ctx}/user/validateEmail.ht"
	   },
	   loginPwd: {
	    required: true,
	    minlength: 6,
	    maxlength: 15
	   },
	   rePassword: {
	    required: true,
	    equalTo: "#loginPwd"
	   }
	  },
	        messages: {
	   loginName: {
		    required: "请输入用户名",
		    chrnum :"只能输入数字和字母(字符A-Z, a-z, 0-9)",
		    minlength: $.validator.format("用户名不能小于{0}个字 符"),
		    maxlength: $.validator.format("用户名不能大于{0}个字 符"),	    
		    remote:"用户名已存在，请重新输入"
		   },
	   email: {
	    required: "请输入Email地址",
	    email: "请输入正确的email地址",
	    remote: "邮箱已存在，请重新输入"
	   },
	   loginPwd: {
	    required: "请输入密码",
	    minlength: $.validator.format("密码不能小于{0}个字 符"),
	    maxlength: $.validator.format("密码不能大于{0}个字 符")
	   },
	   rePassword: {
	    required: "请输入确认密码",
	    equalTo: "两次输入的密码不一致"
	   }
	  }
	    });
	});
function register_form_submit(){
	//var loginName = $("#loginName").val();
	//var email = $("#email").val();
	//var loginPwd=$("#loginPwd").val();
	//var rePassword=$("#rePassword").val();
	if($('#register_form').valid()){
		$.ajax({
			url : "${ctx}/user/register.ht",
			type : 'post',
			data : $('#register_form').serialize(),
			dataType : 'json',
			success : function(data,textStatus) {
				if(data == "0"){
					//alert("注册成功");
					window.location = "${ctx}/loan/myAccount/myaccountPage.ht";
				}else{
				alert(data);
				$("#zhuce_submit").val('注册');
				$("#zhuce_submit").attr("onclick","register_form_submit()");
				}
				
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert("注册异常，请重试");
			},
			beforeSend:function(){
				$("#zhuce_submit").attr("onclick","");
				//$("#zhuce_submit").removeClass("bg-color");
				$("#zhuce_submit").val('注册中...');
			}
		});
	}

}


function xuanze(obj,p){
	$(obj).css({"text-decoration":"none","color":"#ff5200","border-color":"#ff5200","background-image":"url(${ctx}/images/woxiang_btn_bg.png)","background-repeat":"no-repeat","background-position":"right bottom"});
	$("#" + p).attr("style","");
	
	$("#groupID").val($(obj).attr("lang"));
	if(p == "mm"){
		$("#xieyi_a").html('《借入协议》');
		$("#xieyi_a").attr("href","${ctx}/loan/aboutus/TermsServiceList.ht?xieyiid=2");
		
	}else{
		$("#xieyi_a").html('《借出协议》');
		$("#xieyi_a").attr("href","${ctx}/loan/aboutus/TermsServiceList.ht?xieyiid=3");
	}
	
}

///////////////////////////////////////////

//判断输入密码的类型  
function CharMode(iN) {
	if (iN >= 48 && iN <= 57) //数字  
		return 1;
	if (iN >= 65 && iN <= 90) //大写  
		return 2;
	if (iN >= 97 && iN <= 122) //小写  
		return 4;
	else
		return 8;
}
//bitTotal函数  
//计算密码模式  
function bitTotal(num) {
	modes = 0;
	for (i = 0; i < 4; i++) {
		if (num & 1)
			modes++;
		num >>>= 1;
	}
	return modes;
}
//返回强度级别  
function checkStrong(sPW) {
	if (sPW.length <= 4)
		return 0; //密码太短  
	Modes = 0;
	for (i = 0; i < sPW.length; i++) {
		//密码模式  
		Modes |= CharMode(sPW.charCodeAt(i));
	}
	return bitTotal(Modes);
}

//显示颜色  
function pwStrength(pwd) {
	O_color = "#eeeeee";
	L_color = "#FF0000";
	M_color = "#FF9900";
	H_color = "#33CC00";
	if (pwd == null || pwd == '') {
		Lcolor = Mcolor = Hcolor = O_color;
	} else {
		S_level = checkStrong(pwd);
		switch (S_level) {
		case 0:
			Lcolor = Mcolor = Hcolor = O_color;
		case 1:
			Lcolor = L_color;
			Mcolor = Hcolor = O_color;
			break;
		case 2:
			Lcolor = Mcolor = M_color;
			Hcolor = O_color;
			break;
		default:
			Lcolor = Mcolor = Hcolor = H_color;
		}
	}
	document.getElementById("strength_L").style.background = Lcolor;
	document.getElementById("strength_M").style.background = Mcolor;
	document.getElementById("strength_H").style.background = Hcolor;
	return;
}

function checke_function(obj){
	if($(obj).is(":checked")){
		$("#zhuce_submit").addClass("bg-color");
		$("#zhuce_submit").attr("onclick","register_form_submit()");
		//$(obj).val("1");
		
	}else{
		$("#zhuce_submit").removeClass("bg-color");
		$("#zhuce_submit").attr("onclick","");
		//$(obj).val("");
	}
}
	//////////////////////////////////////////
</script>


<body>
	 <%@ include file="/commons/includeFront/head.jsp"%> 
	<div class="main-body login-body-gg2 signin-body">
		<div class="login-left-gg2 signin-left">
			<h2>欢迎加入P2P ONE</h2>
			<form id="register_form" action="${ctx}/user/register.ht" method="post">
				<dl>
					<dt>用户名：</dt>
					<dd><!-- onBlur="validateUserName()" -->
						<input name="loginName" id="loginName" type="text"  >
					</dd>
					<dt>邮箱：</dt>
					<dd><!-- onBlur="validateEmail()" -->
						<input name="email" id="email" type="text" >
						<table width="150" border="1" cellspacing="0" cellpadding="1" bordercolor="#eeeeee" height="16" style='display:table;font-size:12px;position: relative;top:35px;z-index: 100;line-height: 16px;float: right;'>  
							<tr align="center" bgcolor="#f5f5f5">  
							<td width="33%" id="strength_L">弱</td>  
							<td width="33%" id="strength_M">中</td>  
							<td width="33%" id="strength_H">强</td> 
							</tr>  
						</table> 
					</dd>
					<dt>密码：</dt>
					<dd>
						<input name="loginPwd" id="loginPwd" type="password" onKeyUp="pwStrength(this.value)" onBlur="pwStrength(this.value)">
						
					</dd>
					<dt>确认密码：</dt>
					<dd><!-- onBlur="checkedPassword()" -->
						<input name="rePassword" id="rePassword" type="password" >
					</dd>
					<dt class="join-xuanzejuese">选择角色：</dt><input id="groupID" name="groupID" type="hidden" value="1"/>
       				<dd class="join-xuanzejuese"><a style="background-position: right bottom; border-color: rgb(255, 82, 0); color: rgb(255, 82, 0); text-decoration: none; background-image: url('${ctx }/images/woxiang_btn_bg.png'); background-repeat: no-repeat;" href="javascript:;" lang="1" onclick="xuanze(this,'mm')" id="bm">我想借款</a><a href="javascript:;" lang="2" id="mm" onclick="xuanze(this,'bm')">我想理财</a></dd>
					<dt></dt>
					<dd class="join-fuwutiaokuan">
			          <div id="jieru">
			            <input style="float:left;width:auto;margin-right:10px;margin-top:8px;" id="checkbox_name" name="checkbox_name" type="checkbox" value="1" onclick="checke_function(this)" checked="checked">我同意<a class="font-color" href="${ctx}/loan/aboutus/TermsServiceList.ht?xieyiid=1" target="_blank">《服务条款》</a>和<a id="xieyi_a" class="font-color" href="${ctx}/loan/aboutus/TermsServiceList.ht?xieyiid=2" target="_blank">《借入协议》</a>
			          </div>
<!-- 			          <div id="jiechu" style="display:none;">
			            <input style="float:left;width:auto;margin-right:10px;margin-top:8px;" type="checkbox" checked>我同意<a class="font-color" href="#">《服务条款》</a>和<a class="font-color" href="#">《借出协议》</a>
			          </div> -->
			        </dd>
				</dl>
				<div style="text-align:center;">
					<input class="join-btn bg-color" id="zhuce_submit" type="button" value="注 册" onclick="register_form_submit();"/>

				</div>
			</form>
		</div>
		<div class="login-right-gg2">
			<div class="tongqian-gg2">
				<dl>
					<dt>历史已还款本金总额</dt>
					<dd class="font-color">
						￥<span style="font-size: 30px;">200,556,000</span>
					</dd>
					<dt>平台综合年化收益率</dt>
					<dd class="font-color">10.5%</dd>
				</dl>
			</div>
		</div>
	</div> 
	
	<%@ include file="/commons/includeFront/footer.jsp"%>
</body>
</html>