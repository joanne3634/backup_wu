<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="f" uri="http://www.deelon.com/functions" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>我的资料</title>
	  	<link rel="stylesheet" href="${ctx}/styles/dlweixin/css/style.css">
	  	<script type="text/javascript" src="${ctx}/js/dlweixin/jquery-1.8.3.js"></script>
		<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	</head>

	<body>
		<div class="mydatawindow">
		<div class="safetyLevel borderdashed text-black2 text-center">
			<span>账户安全等级</span>
			<div style="position:relative;top:3px;width:125px;height:12px;display:inline-block;margin-right:20px;padding:1px;border:1px solid #ccc;border-radius:6px;" title="${TUserFunds.safePercentum}%"><div style="width:${TUserFunds.safebar}px;height:12px;background-color:#ff5704;border-radius:6px;"></div></div>
			<span class="text-orange2">${level }</span>
		</div>
		<div class="MydataList text-gray">
				<ul>
					<li class="boderbottom text-left">
					<div class="spanwidth70">
					<div class=" "><img src="${ctx}/styles/dlweixin/image/okicont2.png">实名认证</div>
					<div class="text-gray2" >
					<c:choose>
	          		<c:when test="${not empty TUserFunds.realName }">${TUserFunds.realName }</c:when>
	          		<c:otherwise>${TUserFunds.loginName }</c:otherwise>
          			</c:choose>
					（${tuserSafe.idNo }）</div>
					</div>
					<span class="payicont" style="display:none;"><span class="text-orange2">认证</span>〉</span>
					<div class="clear"></div>
					</li>
					<li class="boderbottom text-left">
					<div class="spanwidth70">
					<div class=" ">
					<c:if test="${not empty TUserFunds.bindMobile && TUserFunds.bindMobile eq '0'}">
						<img src="${ctx}/styles/dlweixin/image/noicont.png">
					</c:if>
					<c:if test="${not empty TUserFunds.bindMobile && TUserFunds.bindMobile eq '1'}">
						<img src="${ctx}/styles/dlweixin/image/okicont2.png">
					</c:if>
						手机号码</div>
					<div class="text-gray2">完成手机认证后才能投标</div>
					</div>
					<c:if test="${not empty TUserFunds.bindMobile && TUserFunds.bindMobile eq '0'}">
						<span class="payicont"><span class="text-orange2" onclick="authentication();">认证</span>〉</span>
					</c:if>
					<div class="clear"></div>
					</li>
					<li class="boderbottom text-left">
					<div class="spanwidth70">
					<div class=" ">
					<c:if test="${not empty TUserFunds.bindCard && TUserFunds.bindCard eq '0'}">
						<img src="${ctx}/styles/dlweixin/image/noicont.png">
					</c:if>
					<c:if test="${not empty TUserFunds.bindCard && TUserFunds.bindCard eq '1'}">
						<img src="${ctx}/styles/dlweixin/image/okicont2.png">
					</c:if>
					银行卡认证</div>
					<div class="text-gray2">完成银行卡认证后才能充值</div>
					</div>
					<c:if test="${not empty TUserFunds.bindCard && TUserFunds.bindCard eq '0'}">
						<span class="payicont"><span class="text-orange2" onclick="authentication();">认证</span>〉</span>
					</c:if>
					<div class="clear"></div>
					</li>
					<li class="boderbottom text-left">
					<div class=" "><img src="${ctx}/styles/dlweixin/image/okicont2.png">登录密码</div>
					<div class="text-gray2">上次登录时间：<fmt:formatDate value="${TUser.lastLoginTime }" pattern="yyyy-MM-dd"/></div>
					<div class="clear"></div>
					</li>
					<li class="boderbottom text-left">
					<div class="spanwidth70">
					<div class=" "><img src="${ctx}/styles/dlweixin/image/okicont2.png">交易密码</div>
					<div class="text-gray2">已设置</div>
					</div>
					<span class="payicont" style="display:none;"><span class="text-orange2">认证</span>〉</span>
					<div class="clear"></div>
					</li>
					<li class="boderbottom text-left">
					<div class="spanwidth70">
					<div class=" "><img src="${ctx}/styles/dlweixin/image/noicont.png">安全保护问题</div>
					<div class="text-gray2">账户信息变动时使用</div>
					</div>
					<span class="payicont"><span class="text-orange2">设置</span>〉</span>
					<div class="clear"></div>
					</li>
				</ul>
			</div>
			</div>
	</body>
	
	<script type="text/javascript">
		function authentication(){
			//window.location.href = "${ctx}/weixin/wxmyaccount/authentication.ht"
		}
	</script>
</html>