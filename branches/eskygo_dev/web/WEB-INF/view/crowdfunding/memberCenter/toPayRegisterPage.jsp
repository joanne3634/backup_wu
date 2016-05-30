<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

	<title>会员后台</title>
		<%@ include file="/crowdfunding/cssorjs.jsp"%>
	<meta name="renderer" content="webkit"/>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
</head>


<script type="text/javascript">
$().ready(function() {
	 $("#PerDataTopButton").click(function(){
		 $("#PerDataTopButton").text("绑定中,请稍后..."); 
		 $("#PerDataTopButton").attr({"disabled":"disabled"}); 
		 document.basicdata_form.submit();
		
	 });
	 
	
});
<c:choose>
<c:when test="${empty tuserFunds.payMark }">
window.onload=function(){
	document.basicdata_form.submit();
}
</c:when>
<c:otherwise>
window.onload=function(){  
	 document.getElementById("divdata").style.display="";
}
</c:otherwise>
</c:choose>
</script>



<body>
<form id="basicdata_form" name="basicdata_form" action="${hm.SubmitURL}" method="post"> 
		<input id="RegisterType" name="RegisterType" value="${hmData.RegisterType}" type="hidden" />
		<input id="AccountType" name="AccountType" value="${hmData.AccountType}" type="hidden" />
		<input id="Mobile" name="Mobile" value="${hmData.Mobile}" type="hidden" />
		<input id="Email" name="Email" value="${hmData.Email}" type="hidden" />
		<input id="RealName" name="RealName" value="${hmData.RealName}" type="hidden" />
		<input id="IdentificationNo" name="IdentificationNo" value="${hmData.IdentificationNo}" type="hidden" />
		<input id="Image1" name="Image1" value="${hmData.Image1}" type="hidden" />
		<input id="Image2" name="Image2" value="${hmData.Image2}" type="hidden" />
		<input id="LoanPlatformAccount" name="LoanPlatformAccount" value="${hmData.LoanPlatformAccount}" type="hidden" />
		<input id="PlatformMoneymoremore" name="PlatformMoneymoremore" value="${hmData.PlatformMoneymoremore}" type="hidden" />
		<input id="RandomTimeStamp" name="RandomTimeStamp" value="${hmData.RandomTimeStamp}" type="hidden" />
		<input id="Remark1" name="Remark1" value="${hmData.Remark1}" type="hidden" />
		<input id="Remark2" name="Remark2" value="${hmData.Remark2}" type="hidden" />
		<input id="Remark3" name="Remark3" value="${hmData.Remark3}" type="hidden" />
		<input id="ReturnURL" name="ReturnURL" value="${hmData.ReturnURL}" type="hidden" />
		<input id="NotifyURL" name="NotifyURL" value="${hmData.NotifyURL}" type="hidden" />
		<input id="SignInfo" name="SignInfo" value="${hmData.SignInfo}" type="hidden" />
		</form>
		<div class="personalData f_l" id="divdata" style="display: none">
			<h3><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">支付绑定</h3>
			
			<div class="clear personalDataform" >				
				<ul>
					<li><label> 用户名： </label>${tuser.loginName }&nbsp;</li>
					<li><label>邮箱：</label>${userSafe.email }&nbsp;&nbsp;</li>
					
					<c:if test="${tuser.isCompany eq 1 }"> <!-- 是否是机构投资     是 -->
						<li><label>联系姓名：</label>${tuser.contactName }<span>用于网站运营管理人员替您办理投融资手续时使用</span></li>
						<li><label>营业执照：</label><dfn>${tuser.businessLicense }</dfn></li>
					</c:if>
					<c:if test="${tuser.isCompany eq 0 }"> <!-- 是否是机构投资     否 -->
						<li><label>真实姓名：</label><dfn>${tuser.realName }</dfn></li>
						<li><label>身份证号：</label><dfn>${userSafe.idNo }</dfn></li>	
						
					</c:if>			
					<li><label>手机号码：</label>${userSafe.mobile }&nbsp;&nbsp;</li>
					<c:choose>
						<c:when test="${not empty tuserFunds.payMark }">
							<li><label>支付号：</label>${tuserFunds.payMark }&nbsp;&nbsp;</li>
							<li><label></label><dfn class="PerDataTopButton2" >已&nbsp;绑&nbsp;定</dfn></li>
						</c:when>
						<c:otherwise>
							<li><label></label><dfn class="PerDataTopButton2" id="PerDataTopButton">绑&nbsp;&nbsp;定</dfn></li>
						</c:otherwise>
					</c:choose>		
					
				</ul>
			</div>
			
			
		</div>
	
</body>
</html>
