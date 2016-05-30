<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
  <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/transferback.css"> 
       <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
<html>
<head>
	<title>管理</title>
	<%@include file="/commons/include/form.jsp" %>
<%-- 	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=tsettingsSms&formSave=Y"></script>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=tsettingsEmail&formSave=Y"></script> --%>
	<style type="text/css">
		.tableList {
			width:1000px;
			padding:0px 0px;
   			margin-top: 47px;
		}
		.buttonlist{
			top:0px;
		}
	.buttonlist2 div{
	width: 150px;
	height: 25px;
	line-height: 25px;
	font-size: 14px;
	float: left;
	margin-right: 10px;
	cursor: pointer;
	border: 1px solid #c8c8c8;
}
.button3{
	background: #fff;
}
.button4{
	background: #f5f5f5;
}
	</style>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
			    <c:choose>
			        <c:when test="${tsettingsSms.smsid!=null}">
			            <span class="tbar-label">编辑</span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加</span>
			        </c:otherwise>
			    </c:choose>
				
			</div>
			<div class="panel-toolbar">
				 <div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#">确定保存</a></div>
					<div class="l-bar-separator"></div>
				</div> 
			</div>
				<div class="buttonlist2 text-center">
					<div id="b1" class="button3">短息通道设置</div>
					<div id="b2" class="button4">邮件通道设置</div>
				</div>
				<input type="hidden" name="status" id="status"  value="${status}"/>
			
		</div>
		<div class="tableList2" >
		<div class="panel-body" style="margin-top: 1px">
		<form id="tsettingsSmsForm" method="post" action="savesms.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0" >
					<input type="hidden" name="status" id="status"  value="${status}"/>
							<tr>
								<th width="25%">是否开启:</th>	
								<td>			
									<f:select nodeKey="sf" id="isOpen" name="isOpen" showBlankOnTop="true" defaultValue="${tsettingsSms.isOpen}"></f:select> 					 
								</td>
								<th width="25%">账号:</th>	
								<td>										 
									<input type="text" id="account" name="account" value="${tsettingsSms.account}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">子账号:</th>	
								<td>										 
									<input type="text" id="subAccount" name="subAccount" value="${tsettingsSms.subAccount}" class="inputText" />
								</td>
								<th width="25%">密码:</th>	
								<td>										 
									<input type="password" id="pwd" name="pwd" value="${tsettingsSms.pwd}" class="inputText" />
								</td>
							</tr>
							<%-- <tr>
								<th width="25%">短信接口地址:</th>
								<td colspan="3">	
									<textarea rows="5" cols="80" id="interfaceUrl" name="interfaceUrl"  class="inputText">${tsettingsSms.interfaceUrl}</textarea>	 
								</td>	
							</tr>
							--%>
							<tr>
							<th width="25%">短信接口地址:</th>
							<td colspan="4">										 
									<input type="text" id="interfaceUrl" name="interfaceUrl" value="${tsettingsSms.interfaceUrl}" class="inputText"  style="width: 580px;"/>
								</td>
								</tr>
					</table>
					<input type="hidden" name="smsid" value="${tsettingsSms.smsid}" />
				</form>
		</div>
		</div>
		
		<div class="tableList2 hideDiv" >
		<div class="panel-body" style="margin-top: 1px">
		<form id="tsettingsEmailForm" method="post" action="saveemail.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
					<input type="hidden" name="status" id="status"  value="${status}"/>
							<tr>
								<th width="25%">SMTP服务器:</th>	
								<td>										 
									<input type="text" id="smtpSer" name="smtpSer" value="${tsettingsEmail.smtpSer}" class="inputText" style="width: 130px;"/>
								</td>
								<th width="25%">端口号:</th>	
								<td>										 
									<input type="text" id="portId" name="portId" value="${tsettingsEmail.portId}" class="inputText" style="width: 130px;"/>
								</td>
							</tr>
							<tr>
								<th width="25%">邮箱:</th>	
								<td>										 
									<input type="text" id="email" name="email" value="${tsettingsEmail.email}" class="inputText" style="width: 130px;"/>
								</td>
								<th width="25%">密码:</th>	
								<td>										 
									<input type="password" id="pwd" name="pwd" value="${tsettingsEmail.pwd}" class="inputText"  style="width: 130px;"/>
								</td>
							</tr>
							<%--<tr>
								<th width="25%">发送人:</th>	
								<td>										 
									<input type="text" id="senderName" name="senderName" value="${tsettingsEmail.senderName}" class="inputText" />
								</td>
							</tr>
							--%>
					</table>
					<input type="hidden"  name="senderName" value="${tsettingsEmail.senderName}" />
					<input type="hidden" name="emailId" value="${tsettingsEmail.emailId}" />
				</form>
		</div>
		</div>
</div>

<script type="text/javascript">
$(function() {
    $('.buttonlist2 div').click(function() {
        $(this).removeClass('button4').addClass('button3').siblings().removeClass('button3').addClass('button4');
        $('.tableList2').addClass('hideDiv').eq($(this).index()).removeClass('hideDiv');
        $("#status").val($(this).attr("id"));
    });
   if("${status}"){  
	   $("#${status}").removeClass('button4').addClass('button3').siblings().removeClass('button3').addClass('button4');
       $('.tableList2').addClass('hideDiv').eq($("#${status}").index()).removeClass('hideDiv');
   }
   
	 $(".close").click(function(){ 
		 $("#faqbg").css("display","none"); 
		 $("#faqdiv").css("display","none"); 
	 });
	 
	 $("a.save").click(function(){
			var status =$("#status").val();
			if("b2"==status){
				if($("#tsettingsEmailForm").valid()){
					$.ajax({
						url : "${ctx}/loan/sysManager/tsettingssms/saveemail.ht",
						type : 'post',
						data : $("#tsettingsEmailForm").serialize(),
						dataType : 'html',
						success : function(data, status) {
							var jsonobj=eval('('+data+')');
							var result = jsonobj.result;
							if (result == 1) {
								$.ligerDialog.success("保存成功!","提示信息",function(rtn){
								});
							} else {
								$.ligerDialog.success("保存失败!","提示信息",function(rtn){
								});
							}
						},
						error : function(xhr, textStatus, errorThrown){
							$.ligerDialog.success("保存失败!","提示信息",function(rtn){
							});
						}
					});
				}else{
					$.ligerDialog.success("保存失败!","提示信息",function(rtn){
					});
				}
				
			}else{
				//$("#tsettingsSmsForm").submit();
				
				//ajax
				if($("#tsettingsSmsForm").valid()){
					$.ajax({
						url : "${ctx}/loan/sysManager/tsettingssms/savesms.ht",
						type : 'post',
						data : $("#tsettingsSmsForm").serialize(),
						dataType : 'html',
						success : function(data, status) {
							var jsonobj=eval('('+data+')');
							var result = jsonobj.result;
							if (result == 1) {
								$.ligerDialog.success("保存成功!","提示信息",function(rtn){
								});
							} else {
								$.ligerDialog.success("保存失败!","提示信息",function(rtn){
								});
							}
						},
						error : function(xhr, textStatus, errorThrown) {
							$.ligerDialog.success("保存失败!","提示信息",function(rtn){
							});
						}
					});
				}else{
					$.ligerDialog.success("保存失败!","提示信息",function(rtn){
					});
				}
				
			 }
		 });

	 
	 $("#tsettingsEmailForm").validate({
	        rules: {
	   smtpSer: {
	    required: true
	   },
	   portId: {
	    required: true
	   },
	   email: {
	    required: true,
	    email:true                    
	   },
	   pwd: {
		    required: true
		   },
	   senderName: {
		    required: true
		   }
	  },
	        messages: {
	   smtpSer: {
	    required: "请输入SMTP服务器"
	   },
	   portId: {
	    required: "请输入端口ID"
	   },
	   email: {
	    required: "请输入邮箱",
	    email:"邮箱格式不正确"
	   },
	   pwd: {
		    required: "请输入密码"
		   },
		senderName: {
			required: "请输入发送人"
			   }

	  }
	    });
	 
	 
	 $("#tsettingsSmsForm").validate({
	        rules: {
	    isOpen: {
	    required: true
	   },
	   account: {
	    required: true
	   },
	   subAccount: {
	    required: true
	   },
	   pwd: {
		    required: true
		   },
	   interfaceUrl: {
		    required: true
		   },
	   upated: {
		required: true
			   }
	  },
	        messages: {
	   isOpen: {
	    required: "请确认是否开启"
	   },
	   account: {
	    required: "请输入账号"
	   },
	   subAccount: {
	    required: "请输入子账号"
	   },
	   pwd: {
		    required: "请输入密码"
		   },
		interfaceUrl: {
			required: "请输入短信接口地址"
			   }

	  }
	    });
			
});
</script>
</body>
</html>