<%@page import="com.deelon.loan.model.sysManager.Tinfotemplat"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=Tinfotemplat.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=tinfotemplat&formSave=Y"></script>
	<script type="text/javascript">
		$(function() {
			valid(showRequest,showResponse<c:if test="${tinfotemplat.infoTemplateId==null}">,1</c:if>);
		});
	</script>
	
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
			    <c:choose>
			        <c:when test="${tinfotemplat.infoTemplateId!=null}">
			            <span class="tbar-label">编辑<%=Tinfotemplat.TABLE_ALIAS%></span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加<%=Tinfotemplat.TABLE_ALIAS%></span>
			        </c:otherwise>
			    </c:choose>
				
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#"><span></span>保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht"><span></span>返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body" style="margin-top: 1px">
		<form id="tinfotemplatForm" method="post" action="save.ht">
					<style>
						select{
							width:116px;
							padding:2px;
						}
					</style>
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="15%">模板名称:</th>	
								<td width="25%">										 
									<input type="text" id="templateName" name="templateName" value="${tinfotemplat.templateName}" class="inputText" />
								</td>
								<th width="25%">通知类型:</th>	
								<td>
									<f:select  nodeKey="NOTICE_TYPE" id="serviceType" name="serviceType" defaultValue="${tinfotemplat.serviceType}"/>										 
								</td>
							</tr>
							<tr>
								<th width="15%">通知方式:</th>	
								<td width="25%">
									<f:select  nodeKey="NOTICE_METHOD" id="infoType" name="infoType" defaultValue="${tinfotemplat.infoType}"/>										 
								</td>
								<th width="25%">通知对象:</th>	
								<td>										 
									<input type="text" id="infoFlag" name="infoFlag" value="${tinfotemplat.infoFlag}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="15%">标题:</th>	
								<td colspan="3">										 
									<input type="text" id="header" name="header" value="${tinfotemplat.header}" class="inputText" style="width: 764px;"/>
								</td>											
							</tr>
							<tr>
								<th width="15%" style="height:auto;">消息内容:</th>
								<td  colspan="2" style="height:auto;" class="inputText">
									<textarea style="width:764px;height:320px;" id="messasge" name="messasge" >${tinfotemplat.messasge}</textarea>										 
								</td>
								<td style="vertical-align: top;text-align:center;">
									<span style="align:center;font-size:16px;font-size: 18px;font-weight: bold;margin:5px auto;display:block;">选择参数字段</span>
									<select style="width:80%;height:250px;" class="inputText" multiple="multiple" id="params">
									</select>
									<br>
									<button style="padding:4px 6px;margin-top:10px" onclick="addParam();" type="button">添加参数</button>
									<button style="padding:4px 6px;margin-top:10px" onclick="delParam();" type="button">删除参数</button>
								</td>
							</tr>
					</table>
					<input type="hidden" name="infoTemplateId" value="${tinfotemplat.infoTemplateId}" />
					<input type="hidden" name="infotemplatparams" id="infotemplatparams">
				</form>
		</div>
</div>
</body>
<script type="text/javascript">
var addDialog;
var insObj;
$(function(){
	$("#params").dblclick(function(){
		var value = $(this).val();
		if(!value || value==""){
			return;
		}
		value = "{"+value+"}";
		insertAtCursor(insObj,value);
	});
	var templateId = "${tinfotemplat.infoTemplateId}";
	if(templateId!="null" && templateId!="")
		refreshTemplateParams(templateId);

	$("#header,#messasge").focus(function(){
		insObj = $(this)[0];
	});
});

function refreshTemplateParams(templateId){
	var url = "${ctx}/loan/sysManager/tinfotemplatparam/getAllByInfoTemplatId.ht";
	var params = {infoTemplatId:templateId};
	$.ajax({
		url:url,
		type:'post',
		dataType:'json',
		data:params,
		success:function(data){
			var options = "";
			if(data){
				for(var i=0;i<data.length;i++){
					var key = data[i].paramName;
					var value = data[i].comments;
					options += "<option value='"+key+"' refId='"+data[i].infoTemplatId+"' text='"+value+"'>"+key+":"+value+"</option>";
				}
			}
			$("#params").html(options);
		}
	});
}
function addTemplateParam(key,value){
	var flag = true;
	$("#params option").each(function(){
		if($(this).attr("value")==key){
			flag = false;
			return false;
		}
	});
	if(!flag){
		return false;
	}
	var option = "<option value='"+key+"' refId='0' text='"+value+"'>"+key+":"+value+"</option>";
	$("#params").append(option);
	genInfoTemplateParams();
	return true;
}
function genInfoTemplateParams(){
	var param = "[";
	var count = 0;
	$("#params").children().each(function(i){
		var refId = $(this).attr("refId");
		if(refId=='0'){
			if(count>0){
				param += ",";
			}
			var paramName = $(this).attr("value");
			var comments = $(this).attr("text");
			param += "{paramName:'"+paramName+"',comments:'"+comments+"'}";
			count ++;
		}
	});
	param +="]";
	$("#infotemplatparams").val(param);
}
function insertAtCursor(myField, myValue){ 
	//IE support 
	if (document.selection){ 
		myField.focus(); 
		sel = document.selection.createRange(); 
		sel.text = myValue; 
		sel.select(); 
	} 
	//MOZILLA/NETSCAPE support 
	else if (myField.selectionStart || myField.selectionStart == '0') { 
		var startPos = myField.selectionStart; 
		var endPos = myField.selectionEnd; 
		// save scrollTop before insert 
		var restoreTop = myField.scrollTop; 
		myField.value = myField.value.substring(0, startPos) + myValue + myField.value.substring(endPos,myField.value.length); 
		if (restoreTop > 0) 
		{ 
		// restore previous scrollTop 
			myField.scrollTop = restoreTop; 
		} 
		myField.focus(); 
		myField.selectionStart = startPos + myValue.length; 
		myField.selectionEnd = startPos + myValue.length; 
	} else { 
		myField.value += myValue; 
		myField.focus(); 
	} 
} 

function addParam(){
	var url ="<iframe frameborder='0' src='${ctx}/loan/sysManager/tinfotemplatparam/edit.ht'></iframe>";
	addDialog = $.ligerDialog.open({ height: 300,width:600,content:url,title:'新增模板参数'});
}
function delParam(){
	var refId = $("#params option:selected").attr("refId");
	$("#params option:selected").remove();
	if(refId && refId !="0"){
		var url ="${ctx}/loan/sysManager/tinfotemplatparam/delById";
		$.ajax({
			url:url,
			data:'infoTemplatParamId='+refId,
			dataType:'json',
			type:'post',
			success:function(data){
				
			}
		});
	}
	genInfoTemplateParams();
}
</script>
</html>