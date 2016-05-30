<%@page import="com.deelon.core.util.AppUtil"%>
<%@page import="com.deelon.crowdfunding.model.backstage.TuserApplyLeader"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title><%=TuserApplyLeader.TABLE_ALIAS%>管理</title>
<%@include file="/commons/include/form.jsp" %> 	
<link href="${ctx}/js/jquery/plugins/jquery.qtip.min.css" rel="stylesheet" />
<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.qtip.min.js" ></script>
<script type="text/javascript" src="${ctx }/crowdfunding/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor_msg.js"></script>
<script type="text/javascript" src="${ctx}/js/deelon/platform/system/SysDialog.js"></script>
</head>
<body>
<div class="panel">
	<div class="panel-top">
		<div class="tbar-title">
		    <c:choose>
		        <c:when test="${tuserApplyLeader.applyLeaderId!=null}">
		            <span class="tbar-label">编辑<%=TuserApplyLeader.TABLE_ALIAS%></span>
		        </c:when>
		        <c:otherwise>
		            <span class="tbar-label">添加<%=TuserApplyLeader.TABLE_ALIAS%></span>
		        </c:otherwise>
		    </c:choose>
		</div>
		<div class="panel-toolbar">
			<div class="toolBar">
				<%-- <div class="group"><a class="link save" id="dataFormSave" href="#"><span></span>保存</a></div>--%>
				<div class="l-bar-separator"></div>
				<div class="group"><a class="link back" href="list.ht"><span></span>返回</a></div>
			</div>
		</div>
	</div> 
	<div class="panel-body" style="margin-top: 1px">
	<form id="tuserApplyLeaderForm" method="post" action="save.ht">
	    <input type="hidden"  id="applyTime" name="applyTime" value="${tuserApplyLeader.applyTime}"/>
	    <input type="hidden" id="industryDesc" name="industryDesc" value="${tuserApplyLeader.industryDesc}"/>
		<input type="hidden" name="userId" value="${tuserApplyLeader.userId}" class="inputText" style="width: 150px;"/>
		<input type="hidden" id="industryId" name="industryId"  value="${tuserApplyLeader.industryId}"/>
		<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<th width="10%">申请人<font color='red'>*</font>:</th>	
				<td><input type="text" id="userName" name="userName" value="${userName}" class="inputText"  style="width: 150px;" readonly="readonly"/></td>
			</tr> 
			<tr>
				<th width="10%">申请时间<font color='red'>*</font>:</th>	
				<td><input type="text"  id="applyTime" value="<fmt:formatDate value="${tuserApplyLeader.applyTime}" pattern="yyyy-MM-dd HH:mm"/>" class="inputText datetime" style="width: 150px;" readonly="readonly"/></td>
			</tr>
			<tr> 
				<%-- <th width="10%">所属行业:</th>	
				<td><input type="text" id="industryId" name="industryId" value="${tuserApplyLeader.industryId}" class="inputText" style="width: 150px;" readonly="readonly"/></td>
				<th width="10%">行业描述:</th>	
				<td><input type="text" id="industryDesc" name="industryDesc" value="${tuserApplyLeader.industryDesc}" class="inputText" style="width: 150px;" readonly="readonly"/></td>
			    --%>
			    <th width="10%">领投项目行业<font color='red'>*</font>:</th>
				 <td >
				  <div>
					   <c:if test="${not empty dictionaryList }">
					        <c:forEach items="${dictionaryList}" var="dictionary" varStatus="status">
					        <c:if test="${status.count%10==0}">
					             </br>
					        </c:if>
					              <span><input type="checkbox" name="invesindustry" value="${dictionary.itemValue}"/>${dictionary.itemName}</span>
					        </c:forEach>
			           </c:if>
				     </div>
				 </td>
			</tr>
			<tr>
			    <th width="10%"><c:if test="${tuserApplyLeader.isCompany == 0}">个人简介</c:if><c:if test="${tuserApplyLeader.isCompany != 0}">机构说明</c:if>:</th>	
				<td><textarea  id="applyInfo" name="applyInfo"  class="ckeditor" >${tuserApplyLeader.applyInfo}</textarea></td>
			</tr>
			<tr>
				<th width="10%">审核说明:</th>	
				<td colspan="3"><textarea rows="5" cols="80" id="checkFailReason" name="checkFailReason"  class="inputText">${tuserApplyLeader.checkFailReason}</textarea></td>
			</tr>
		</table>
		<div style="text-align: left;padding-bottom: 20px;"></div>
					<div style="text-align: center;">
							<c:if test="${tuserApplyLeader.isCheck == 0 }">
								<input class="sub-btn" type="button"
								value="审核通过" onclick="tuserAuditPass('${tuserApplyLeader.applyLeaderId}')">
								<input class="sub-btn" type="button"
								value="审核不通过" onclick="tuserAuditFail('${tuserApplyLeader.applyLeaderId}')">
							</c:if>
							<c:if test="${tuserApplyLeader.isCheck == 2 }">
								<input class="sub-btn" type="button"
								value="撤销审核" onclick="cancelAduit('${tuserApplyLeader.applyLeaderId}')">
							</c:if>
							<input id="sub-btn_save" class="sub-btn" type="button"
							value="修改并保存" onclick="dataFormSaves();">
					</div>
		<input type="hidden" name="applyLeaderId" value="${tuserApplyLeader.applyLeaderId}" />
	</form>
	</div>
</div>
</body>
</html>
<script type="text/javascript">
var editor = CKEDITOR.replace('applyInfo');
$(function(){
	var loadCked = $("#industryId").val();
	var ary = [];
	if(loadCked && loadCked.indexOf(',') != -1){
		ary = loadCked.split(',');
	}else{
		ary.push(loadCked);
	}
	$.each(ary,function(index) {
        var val = $.trim(this);
        $("input[name='invesindustry']").each(function () {
        	var value = $.trim($(this).val());
        	if(value == val){
        		$(this).attr("checked",true);
        		return false;
        	}else{
        		 return true;
        	}
        });
    });
	//initTextEditor();
});
function initTextEditor(){
	CKEDITOR.config.toolbar=App.toolbar.Basic;
	CKEDITOR.config.height = 500;
}
function tuserAudit(p,userId,applyLeaderId){
				$.ajax({
					url : "tuserAuditLeader.ht",
					type : 'post',
					data : "isLeader=" + p + "&userId=" + userId+"&applyLeaderId="+applyLeaderId, 
					dataType : 'json',
					success : function(data,textStatus) {
						if(data.result == 1){
							$.ligerDialog.success( "操作成功","成功");
							setTimeout('window.location= "list.ht"',1500);
						}		
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						$.ligerDialog.error( "操作失败","成功");
					}
				});		
		}
		
		
function tuserAuditPass(applyLeaderId){
	var applyInfo = $.trim(editor.document.getBody().getText());
	$('#applyInfo').val(applyInfo);
	var str = "",text = "";
	var len =0;
	$("input[name='invesindustry']:checked").each(function(index) {
        if (this.checked) {
       	 str+=$(this).val()+","; 
         text+=$(this).parent().text()+","; 
        }
        len++;
    });
	if (len > 3) {
		$.ligerDialog.warn("选择的项目不能超过三项！");
		return;
	}else if(len == 0){
		$.ligerDialog.warn("请选择项目！");
		return;
	}else if($('#applyInfo').val() == ""){
		$.ligerDialog.warn("个人或机构说明不能为空");
		return;
	}
	$("#industryId").val(str.substring(0,str.length-1));
	$("#industryDesc").val(text.substring(0,text.length-1));
	$.ajax({
		url : "pass.ht",
		type : 'post',
		data : $('#tuserApplyLeaderForm').serialize(),
		dataType : 'json',
		success : function(data,textStatus) {
			if(data.result == 1){
				$.ligerDialog.success( "该申请人提交的领投资格成功被审核通过！<br>恭喜！","成功");
				setTimeout('window.location= "list.ht"',1500);
			}		
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			$.ligerDialog.error( "操作失败","成功");
		}
	});		
}


function tuserAuditFail(applyLeaderId){
	$.ajax({
		url : "fail.ht",
		type : 'post',
		data :$('#tuserApplyLeaderForm').serialize(),
		dataType : 'json',
		success : function(data,textStatus) {
			if(data.result == 1){
				$.ligerDialog.success( "该申请人提交的领投资格被否决！<br>请再审查相关资料！","成功");
				setTimeout('window.location= "list.ht"',1500);
			}		
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			$.ligerDialog.error( "操作失败","成功");
		}
	});		
}


function cancelAduit(applyLeaderId){
	$.ajax({
		url : "cancel.ht",
		type : 'post',
		data : "applyLeaderId="+applyLeaderId, 
		dataType : 'json',
		success : function(data,textStatus) {
			if(data.result == 1){
				$.ligerDialog.success( "撤销审核成功","成功");
				setTimeout('window.location= "list.ht"',1500);
			}		
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			$.ligerDialog.error( "操作失败","成功");
		}
	});		
}
		
function dataFormSaves(){
	var applyInfo = $.trim(editor.document.getBody().getText());
	$('#applyInfo').val(applyInfo);
	var str = "",text = "";
	var len = 0;
	$("input[name='invesindustry']:checked").each(function(index) {
        if (this.checked) {
	       	 str+=$(this).val()+","; 
	         text+=$(this).parent().text()+","; 
        }
        len++;
    });
	if (len > 3) {
		$.ligerDialog.warn("选择的项目不能超过三项！");
		return;
	}else if(len == 0){
		$.ligerDialog.warn("请选择项目！");
		return;
	}else if($('#applyInfo').val() == ""){
		$.ligerDialog.warn("个人或机构说明不能为空");
		return;
	}
	$("#industryId").attr("value" , str.substring(0,str.length-1));
	$("#industryDesc").attr("value" , text.substring(0,text.length-1));
	$.ajax({
			url : "save.ht",
			type : 'post',
			data : $('#tuserApplyLeaderForm').serialize(),
			dataType : 'json',
			success : function(data,textStatus) {
				if(data.result == 1){
					$.ligerDialog.success( "操作成功","成功");
					setTimeout('window.location= "list.ht"',1500);
				}		
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				$.ligerDialog.error( "操作失败","成功");
			}
		});
}


		</script>