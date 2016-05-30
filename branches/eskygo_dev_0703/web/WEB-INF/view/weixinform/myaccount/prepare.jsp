<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>投资前准备</title>
	  	<link rel="stylesheet" href="${ctx}/styles/dlweixin/css/style.css">
	  	<script type="text/javascript" src="${ctx}/js/dlweixin/jquery-1.8.3.js"></script>
		<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	</head>

	<body>
		<div class="prepare">
			<div class="realname"><img src="${ctx}/styles/dlweixin/image/okicont4.png"><div class="text-white background7 text-center"><div class="triangleorg">◆</div>实名认证</div>
			<div>
				<input type="text" name="realname" id="realname" class=" text-black bodersolid background2 radiu" placeholder="本人姓名"/>
		
  				<input type="text" name="identity" id="identity" class=" text-black bodersolid background2 radiu" placeholder="本人身份证号码"/>
  				<div class="textdiv background1 text-white text-center lbutton">下一步</div>
  			</div>
			</div>
			<div class="prepassword"><img src="${ctx}/styles/dlweixin/image/noicont2.png"><div class="text-white background8 text-center"><div class="trianglegray">◆</div>设置交易密码</div>
			<div style="display:none;">
				<input type="text" name="prepassword" id="prepassword" class=" text-black bodersolid background2 radiu" placeholder="输入设置交易密码"/>
		
  				<div class="textdiv background1 text-white text-center lbutton">下一步</div>
  			</div>
			</div>
			<div class="bankcard"><img src="${ctx}/styles/dlweixin/image/noicont2.png"><div class="text-white background8 text-center"><div class="trianglegray">◆</div>银行卡认证</div>
				<div style="display:none;">
				<p class="text-gray">真实姓名：<span>张三</span></p>
				<select>
					<option>111</option>
					<option>222</option>
					<option>333</option>
				</select>
  				<input type="text" name="identity" id="identity" class=" text-black bodersolid background2 radiu" placeholder="银行卡号"/>
  				<div class="textdiv background1 text-white text-center lbutton">下一步</div>
  				</div>
			</div>
		</div>
		<script type="text/javascript">
			$(function(){
				$(".textdiv").on('click',function(){
					$(this).parent().css("display","none");//block
					var _parent=$(this).parent().parent();
					_parent.find("img").attr("src","${ctx}/styles/dlweixin/image/okicont3.png");
					_parent.find(".background7").removeClass("background7").addClass('background8');
					_parent.find(".triangleorg").removeClass("triangleorg").addClass('trianglegray');
					_parent.next().find("div").css("display","block");
					_parent.next().find("img").attr("src","${ctx}/styles/dlweixin/image/okicont4.png");
					_parent.next().find(".background8").removeClass("background8").addClass('background7');
					_parent.next().find(".trianglegray").removeClass("trianglegray").addClass('triangleorg');
				});
			});
		</script>
	</body>
</html>