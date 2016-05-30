<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Cache-Control" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title>提现</title>
<script type="text/javascript">
	window.onload=function(){document.form1.submit();}
</script>
</head>
<body>
	<form id="form1" name="form1" action="${hm.SubmitURL}" method="post">
		<input id="WithdrawMoneymoremore" name="WithdrawMoneymoremore" value="${hmData.WithdrawMoneymoremore}" type="hidden" />
		<br/>
		<input id="PlatformMoneymoremore" name="PlatformMoneymoremore" value="${hmData.PlatformMoneymoremore}" type="hidden" />
		<br/>
		<input id="OrderNo" name="OrderNo" value="${hmData.OrderNo}" type="hidden" />
		<br/>
		<input id="FeePercent" name="FeePercent" value="${hmData.FeePercent}" type="hidden" />
		<br/>
		<input id="FeeMax" name="FeeMax" value="${hmData.FeeMax}" type="hidden" />
		<br/>
		<input id="FeeRate" name="FeeRate" value="${hmData.FeeRate}" type="hidden" />
		<br/>
		<input id="Amount" name="Amount" value="${hmData.Amount}" type="hidden" />
		<br/>
		<input id="CardNo" name="CardNo" value="${hmData.CardNo}" type="hidden" />
		<br/>
		<input id="CardType" name="CardType" value="${hmData.CardType}" type="hidden" />
		<br/>
		<input id="BankCode" name="BankCode" value="${hmData.BankCode}" type="hidden" />
		<br/>
		<input id="BranchBankName" name="BranchBankName" value="${hmData.BranchBankName}" type="hidden" />
		<br/>
		<input id="Province" name="Province" value="${hmData.Province}" type="hidden" />
		<br/>
		<input id="City" name="City" value="${hmData.City}" type="hidden" />
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
