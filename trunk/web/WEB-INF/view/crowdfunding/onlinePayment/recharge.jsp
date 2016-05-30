<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ include file="/commons/includeFront/taglibs.jsp"%>
 <c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Cache-Control" content="no-cache" />
<meta http-equiv="Expires" content="0" /> 
<script type="text/javascript">
	window.onload=function(){document.form1.submit();}
</script>
</head>
<body>
	<form id="form1" name="form1" action="${hm.SubmitURL}" method="post">
		<input id="RechargeMoneymoremore" name="RechargeMoneymoremore" value="${hmData.RechargeMoneymoremore}" type="hidden" />
		<br/>
		<input id="PlatformMoneymoremore" name="PlatformMoneymoremore" value="${hmData.PlatformMoneymoremore}" type="hidden" />
		<br/>
		<input id="OrderNo" name="OrderNo" value="${hmData.OrderNo}" type="hidden" />
		<br/>
		<input id="Amount" name="Amount" value="${hmData.Amount}" type="hidden" />
		<br/>
		<input id="RechargeType" name="RechargeType" value="${hmData.RechargeType}" type="hidden" />
		<br/>
		<input id="FeeType" name="FeeType" value="${hmData.FeeType}" type="hidden" />
		<br/>
		<input id="CardNo" name="CardNo" value="${hmData.CardNo}" type="hidden" />
		<br/>
		<input id="RandomTimeStamp" name="RandomTimeStamp" value="${hmData.RandomTimeStamp}" type="hidden" />
		<br/>
		<input id="Remark1" name="Remark1" value="${hmData.Remark1}" type="hidden" />
		<br/>
		<input id="Remark2" name="Remark2" value="${hmData.Remark2}" type="hidden" />
		<br/>
		<input id="Remark3" name="Remark3" value="${hmData.Remark3}" type="hidden" />
		<br/>
		<input id="ReturnURL" name="ReturnURL" value="${hmData.ReturnURL}" type="hidden" />
		<br/>
		<input id="NotifyURL" name="NotifyURL" value="${hmData.NotifyURL}" type="hidden" />
		<br/>
		<input id="SignInfo" name="SignInfo" value="${hmData.SignInfo}" type="hidden" />
	</form>
</body>
</html>
