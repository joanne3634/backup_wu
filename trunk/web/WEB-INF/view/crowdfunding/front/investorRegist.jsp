<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="renderer" content="webkit"/>
	<title>投资人注册</title>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
	<meta name="renderer" content="webkit"/>
	<%-- <link title="index" name="styleTag" rel="stylesheet" type="text/css" href="${ctx}/styles/default/css/web.css"> --%>
	<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css">
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
	<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/RegistAndLogin.css">
</head>
<script type="text/javascript">
	$().ready(function() {


		jQuery.validator.addMethod("regexPassword1", function(value, element) {
			var pattern = /^([0-9]*)+$/;
			return this.optional(element) || (!pattern.test(value) );
		}, "密码不能为纯数字");

		jQuery.validator.addMethod("regexPassword2", function(value, element) {
			var pattern = /^([a-zA-Z]*)+$/;
			return this.optional(element) || (!pattern.test(value) );
		}, "密码不能为纯字母");

		var realName=$("#realName").val();
		var idNo=$("#idNo").val();
		$("input[type=text]").val('');
		$("#register_form").validate({
			rules: {
				loginName: {//用户名验证
					required: true,
					chrnum:true,
					minlength:5,
					maxlength:12,
					remote: "${ctx}/user/validateUserName.ht"
				},
				email: {//邮箱验证
					required: true,
					email: true,
					remote: "${ctx}/user/validateEmail.ht"
				},
				remarks: { //  个人说明/机构说明
					required: true
				},
				cityId: { //城市验证
					required: true
				},
				loginPwd: { //登录密码验证
					required: true,
					minlength: 6,
					maxlength: 20,
					regexPassword1: true,
					regexPassword2: true
				},
				resloginPwd: { //确认登录密码验证
					required: true,
					equalTo: "#loginPwd"
				},
				realName: { //真实姓名
					required: true
				},
				contactName: { //联系人姓名
					required: true
				},
				idNo: {     //身份证
					required: true,
					idNo : true,
					remote: {
						url:"${ctx}/user/verifyIdNo.ht",
						type:"post",
						dataType:"json",
						data:{realName:function(){return $("#realName").val()},
					      idNo:function(){return $("#idNo").val()
						  }}}
				},
				businessLicense: {
					required: true
				},
				personalAddress: {
					required: true
				},
				mobile: {
					required: true,
					mobile : true,
					remote: "${ctx}/user/validatePhone.ht"
				}
				//code: {
				//	required: true,
				//	remote : "${ctx}/user/validateCode.ht"
				//		}

			},
			messages: {
				loginName: {
					required: "必填",
					chrnum :"只能输入数字和字母(字符A-Z, a-z, 0-9)",
					minlength: $.validator.format("用户名不能小于{0}个字 符"),
					maxlength: $.validator.format("用户名不能大于{0}个字 符"),
					remote:"用户名已存在,请重新输入"
				},
				email: {
					required: "必填",
					email:"请输入正确的邮箱",
					remote:"该邮箱已存在,请重新输入"
				},
				remarks: {
					required: "必填"
				},
				cityId: {
					required: "必选"
				},
				loginPwd: {
					required: "必填",
					minlength: $.validator.format("密码不能小于{0}个字符"),
					maxlength: $.validator.format("密码不能大于{0}个字符"),
					regexPassword1: '密码不能为纯数字',
					regexPassword2: '密码不能为纯字母'
				},
				resloginPwd: {
					required: "必填",
					equalTo: "登录密码不一致"
				},
				realName: {
					required: "必填"
				},
				contactName: {
					required: "必填"
				},
				idNo: {
					required: "必填",
					idNo:"输入正确的身份证号",
					remote:"姓名与身份证号不匹配"
				},
				businessLicense: {
					required: "必填"
				},
				personalAddress: {
					required: "必填"
				},
				mobile: {
					required: "必填",
					mobile:"输入正确的手机号",
					remote:"该手机号已存在,请重新输入"
				}
				//code: {
				//	required: "必填",
				//	remote:"输入正确的验证码"
				///	}
			}
		});



		$("#provincesId").change(function(){
			if($(this).val() =="请选择省"){return;}
			$.ajax({
				url : "${ctx}/user/ajaxGetJilian.ht",
				type : 'post',
				data : "areaId=" + $(this).val(),
				dataType : 'json',
				success : function(data) {
					var html = "<option value=''></option>";
					if(data.length > 0){
						for ( var i = 0; i < data.length; i++) {
							html += "<option value='" + data[i].areaId + "'>" + data[i].areaName + "</option>";
						}
					}
					$("#cityId").html(html);

				},
				error : function(xhr, textStatus, errorThrown) {
					//alert('异步获取数据出现异常');
				}
			});
		});

		$(".InReform input").click(function(){
			$(this).parent().find("span").remove();
		});
		$(".InReformButton").click(function(){
			if($("input[name=Usertype]").is(":checked")){
				$(this).parent().parent().find("span").remove();
			}
		});
	});

	function copyLoginName_remarks(loginName) {
		$('#remarks').val(loginName);

	}

	function register_form_submit(){

		if($('#register_form').valid()){
			$.ajax({
				url : "${ctx}/user/register.ht",
				type : 'post',
				timeout:15000,
				data : $('#register_form').serialize(),
				dataType : 'json',
				success : function(data,textStatus) {
					if(data == "0"){
						//alert("注册成功");
						openDialog("注册成功","30%","30%");
						// setTimeout('window.location = "${ctx }/loan/myAccount/myaccountPage.ht";',2000);
						// update by nicole 2015/4/21 注册投资者成功后跳转到首页
						setTimeout('window.location = "${ctx }/index-web.jsp";',2000);

					}else{
						openDialog(data,"30%","30%");
						$("#InReformButton").attr("onclick","register_form_submit();");
						$("#InReformButton").html('立即注册');
						setTimeout('reload();',2000);
						//setTimeout('window.location = "${ctx }/user/registerInit.ht";',2000);
					}

				},
				/* complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
				 　//　　　if(status=='timeout'){//超时,status还有success,error等值的情况
				 　　　　　     openDialog("连接超时,请重试!","30%","30%");
				 setTimeout('window.location = "${ctx }/user/registerInit.ht";',2000);
				 //　　　　}
				 　　}, */
				error : function(XMLHttpRequest, textStatus, errorThrown) {

					openDialog("注册异常，请重试","30%","30%");
					setTimeout('window.location = "${ctx }/user/registerInit.ht";',2000);
				},
				beforeSend:function(){
					$("#InReformButton").attr("onclick","");
					$("#InReformButton").html('注册中...');
				}
			});
		}

	}

	//用户类型
	function  userTypeSelect(obj){
		var type = $(obj).val();
		if(type == 0){ //个人投资
			//$("#remarks_").html("<label class='red'>*</label>个人说明：");
			$("#xingming_").html("<label class='red'>*</label>真实姓名：");
			$("input[lang=xingming_]").attr("id","realName");
			$("input[lang=xingming_]").attr("name","realName");
			$("#shenfenzheng_").html("<label class='red'>*</label>身份证号：");
			$("input[lang=shenfenzheng_]").attr("id","idNo");
			$("input[lang=shenfenzheng_]").attr("name","idNo");
		}else{
			//$("#remarks_").html("<label class='red'>*</label>机构说明：");
			$("#xingming_").html("<label class='red'>*</label>联系人姓名：");
			$("input[lang=xingming_]").attr("id","contactName");
			$("input[lang=xingming_]").attr("name","contactName");
			$("#shenfenzheng_").html("<label class='red'>*</label>营业执照号码：");
			$("input[lang=shenfenzheng_]").attr("id","businessLicense");
			$("input[lang=shenfenzheng_]").attr("name","businessLicense");
		}
	}

	//刷新验证码
	function reload(){
		var url="${ctx}/servlet/ValidCode?rand=" +new Date().getTime();
		document.getElementById("validImg").src=url;
	}







	/// 密码强度 ///////////////

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

	// function verifyIdNo(){
	// 	var realName1=$("#realName").val();
	// 	var idNo1=$("#idNo").val();
	// 	$.ajax({
	// 		url : "${ctx}/user/verifyIdNo.ht",
	// 		type : 'post',
	// 		data : 'realName='+realName1+'&idNo='+idNo1,
	// 		dataType : 'json',
	// 		success : function(data,textStatus) {
	// 			if(data == "success"){

	// 			}else{
	// 				openDialog(data,"35%","30%");
	// 			}
	// 		},
	// 		error : function(XMLHttpRequest, textStatus, errorThrown) {

	// 		}
	// 	});
	// }
</script>
<body>
<!-- <div style="height:191px;overflow: hidden;"> -->
<%@ include file="/crowdfunding/head.jsp"%>
<!-- <iframe src="./head.html" height="191px;" width="100%" frameborder="0" scrolling="no"></iframe> -->
<!-- </div> -->
<div class="window">
	<div class="InReTop">
		<ul>
			<a href="${ctx}/user/registerInit.ht?type=2">
				<li class="tab active">
					<div>
						<i class="fa fa-users fa-4x"></i>

						<h3>注册投资人</h3>
					</div>
				</li>
			</a>
			<a href="${ctx }/user/registerInit.ht?type=1">
				<li class="tab">
					<div>
						<i class="fa fa-user fa-4x"></i>

						<h3>创业者注册</h3>
					</div>
				</li>
			</a>
		</ul>
	</div>
	<form id="register_form">
		<div class="desc">以下信息均为必填项，请完整填写！</div>
		<div class="InReform">
			<ul><input type="hidden" name="groupId" value="2"/><!--  -->
				<li><em><label class="red">*</label>用户类型：</em><input type="radio" value="0" name="isCompany" checked="checked" onclick="userTypeSelect(this)"/>投资个人&nbsp;&nbsp;<input name="isCompany" type="radio" value="1" onclick="userTypeSelect(this)"/>投资机构</li>
				<li><em><label class="red">*</label>用户名： </em><input type="text" id="loginName" name="loginName" onblur="copyLoginName_remarks(this.value)"/></li>
				<li><em><label class="red">*</label>邮箱：</em><input type="text" id="email"  name="email"/></li>
				<li>
					<%--<em id="remarks_"><label class="red">*</label>个人说明：</em>--%>
					<input type="hidden" class="explain" id="remarks" name="remarks"/>
				</li>
				<%--<li class="explainLi"><em>&nbsp;</em><span>个人说明建议采用公司+职务+真实姓名</span></li>--%>
				<li><em><label class="red">*</label>所在城市：</em>
					<select id="provincesId" name="provincesId">
						<option value="请选择省">请选择省</option>
						<c:forEach items="${arealist }" var="list">
							<option value="${list.areaId }">${list.areaName }</option>
						</c:forEach>
					</select>
					<select id="cityId" name="cityId"></select>
				</li>

				<li><em> <label class="red">*</label>密码： </em><input type="password" id="loginPwd" name="loginPwd" onKeyUp="pwStrength(this.value)" onBlur="pwStrength(this.value)"/></li>
				<li class="explainLi"><em>&nbsp;</em><dfn><table width="150" border="1" cellspacing="0" cellpadding="1" bordercolor="#eeeeee" height="16" style='display:table;font-size:12px;position: relative;top:1px;left:120px;z-index: 100;line-height: 16px;float: left;'>
					<tr align="center" bgcolor="#f5f5f5">
						<td width="33%" id="strength_L">弱</td>
						<td width="33%" id="strength_M">中</td>
						<td width="33%" id="strength_H">强</td>
					</tr>
				</table></dfn></li>
				<li><em><label class="red">*</label>确认密码：</em><input type="password" id="resloginPwd" name="resloginPwd"/></li>
				<li><em>&nbsp;</em><div>下面两项的真实姓名和身份证号码、用于投资款转账的银行卡开户姓名与身份证号码、入股有限合伙企业的真实姓名与身份证号码这三处必须完全一致，否则将无法进行投资，请认真填写。</div></li>
				<li><em id="xingming_"><label class="red">*</label>真实姓名：</em><input lang="xingming_" type="text" id="realName" name="realName"/><span>用于网站运营管理人员替您办理投融资手续时使用</span></li>
				<li><em id="shenfenzheng_"><label class="red">*</label>身份证号：</em><input lang="shenfenzheng_" type="text" id="idNo" name="idNo" onblur="verifyIdNo()"/><span>用于网站运营管理人员替您办理投融资手续时使用</span></li>
				<li><em><label class="red">*</label>个人住址：</em><input type="text" id="personalAddress" name="personalAddress"/><span>用于办理投资入股工商变更手续及快递接收</span></li>
				<li><em><label class="red">*</label>手机号码：</em><input type="text" class="code" id="mobile" name="mobile"/><span>用于网站运营管理人员替您办理投融资手续时使用</span></li>
				<li><em><label class="red">*</label>验证码：</em><input type="text" placeholder=" " class="code" id="code" name="code"/><img src="${ctx}/servlet/ValidCode" id="validImg" alt="" onclick="reload()" style="cursor: pointer;"/></li>
				<li class="agreement"><em></em><input type="checkbox"  name="Usertype" checked="checked"/><a style="color: red;" target="_blank" href="${ctx }/loan/aboutus/TermsServiceList.ht?xieyiid=4">我已阅读并认可众筹《注册协议》</a></li>
				<li><em>&nbsp;</em><dfn class="InReformButton" id="InReformButton" onclick="register_form_submit();" style="cursor: pointer;">立即注册</dfn></li>
			</ul>
		</div>
	</form>
</div>
<div class="clear" style="height:130px;overflow: hidden;">
	<%@ include file="/crowdfunding/foot.jsp"%>
	<script type="text/javascript">
		$().ready(function() {
			$("input[name=Usertype]").click(function(){
				if($(this).is(":checked")){
					$('#InReformButton').css('background','#72ba00');
					$('#InReformButton').attr('onclick','register_form_submit();');
				}else{
					$('#InReformButton').css('background','gray');
					$('#InReformButton').attr('onclick','');
				}
			});
		});

	</script>
</div>
</body>
</html>
