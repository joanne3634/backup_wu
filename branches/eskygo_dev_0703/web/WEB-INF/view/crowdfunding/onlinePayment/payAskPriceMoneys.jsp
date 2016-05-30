<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Cache-Control" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title>网贷转账测试 - 乾多多</title>
<script type="text/javascript">
	window.onload=function(){document.form1.submit();}
</script>
</head>
<body>
	<form id="form1" name="form1" action="${hm.SubmitURL}" method="post">
		<input id="LoanJsonList" name="LoanJsonList" value='${hmData.LoanJsonList}' type="hidden" />
		<br/>
		<input id="PlatformMoneymoremore" name="PlatformMoneymoremore" value="${hmData.PlatformMoneymoremore}" type="hidden" />
		<br/>
		<input id="TransferAction" name="TransferAction" value="${hmData.TransferAction}" type="hidden" />
		<br/>
		<input id="Action" name="Action" value="${hmData.Action}" type="hidden" />
		<br/>
		<input id="TransferType" name="TransferType" value="${hmData.TransferType}" type="hidden" />
		<br/>
		<input id="NeedAudit" name="NeedAudit" value="${hmData.NeedAudit}" type="hidden" />
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
