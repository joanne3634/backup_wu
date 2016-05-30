<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>sys_org_bank管理</title>
<%@include file="/commons/include/get.jsp" %> 
<script type="text/javascript">


//银行编辑页面
function openBank(bankId){
	var conf={
			url:"edit.ht?orgId=${param['orgId']}",
			callback:function(s,rtn){ 
				$('#searchForm').submit();
			}
	};
	if(bankId){
		conf.url+="&bankId="+bankId;
	}			
	Dialog.showDialog(conf);
	return;
}
//按钮-银行编辑页面
function butOpenBank(){
	//
	var f = $("input[type='checkbox'][disabled!='disabled'][class='pk']:checked");
	var a = f.length;
	if (a == 1) { 
		openBank(f.val());
	}
}
</script>
</head>
<body> 
	<f:tab curTab="bank" tabName="sysOrg"/> 
		<c:choose>
				<c:when test="${empty sysOrg}">
					<div style="text-align: center;margin-top: 10%;">尚未指定具体组织!</div>
				</c:when>
				<c:when test="${sysOrg.orgType!=2}">
					<div style="text-align: center;margin-top: 10%;">只有公司类型才能维护银行帐号!</div>
				</c:when>
				<c:otherwise>
				
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">sys_org_bank管理列表</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link search" id="btnSearch"><span></span>查询</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link add" onclick="openBank()" ><span></span>添加</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link update" id="btnUpd"  onclick="butOpenBank()" ><span></span>修改</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link del"  action="del.ht"><span></span>删除</a></div>
				</div>	
			</div>
			<div class="panel-search">
				<form id="searchForm" method="post" action="list.ht?orgId=${param['orgId']}"> 
				<ul class="row">
						<table>
						<tr>
						<td nowrap   >
						<span class="label">开户银行:</span></td><td width="200px" nowrap><input class="dicCombo" nodeKey="yxfl"  valueFieldID="bankRegister" treeLeafOnly="true" name="bankRegisterName"   height="200" width="200" />
						</td>
						<td nowrap>
						<span class="label">银行帐号:</span></td><td nowrap><input type="text" name="Q_bankAccount_SL"  class="inputText" />
						</td>
						<td nowrap>
						<span class="label">开户名称:</span></td><td nowrap><input type="text" name="Q_bankName_SL"  class="inputText" /> 
						</td>
						</tr>
						</table>
					 </ul>
				</form>
			</div>
		</div>
		<div class="panel-body">
	    	<c:set var="checkAll">
				<input type="checkbox" id="chkall"/>
			</c:set>
		    <display:table name="sysOrgBankList" id="sysOrgBankItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" class="table-grid">
				<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
			  		<input type="checkbox" class="pk" name="bankId" value="${sysOrgBankItem.bankId}">
				</display:column>
				<display:column   title="开户银行" sortable="true" sortName="bank_register" maxLength="80">
					<f:description itemValue="${sysOrgBankItem.bankRegister }"    nodeKey="yxfl" />
				</display:column>
				<display:column property="bankAccount" title="银行帐号" sortable="true" sortName="bank_account" maxLength="80"></display:column>
				<display:column property="bankName" title="开户名称" sortable="true" sortName="bank_name" maxLength="80"></display:column> 
				<display:column property="bankRemark" title="备注" sortable="true" sortName="bank_remark" maxLength="80"></display:column>
				<display:column title="管理" media="html" style="width:220px">
					<a href="del.ht?bankId=${sysOrgBankItem.bankId}" class="link del">删除</a>
					<a onclick="openBank(${sysOrgBankItem.bankId})" class="link edit">编辑</a> 
				</display:column>
			</display:table>
			<deelon:paging tableId="sysOrgBankItem"/>
		</div><!-- end of panel-body -->				
	</div> <!-- end of panel -->
	</c:otherwise>
</c:choose>
</body>
</html>


