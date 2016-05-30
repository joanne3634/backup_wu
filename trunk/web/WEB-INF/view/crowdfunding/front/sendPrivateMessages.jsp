<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>发私信</title>
	<meta name="renderer" content="webkit"/>
		<%@ include file="/crowdfunding/cssorjs.jsp"%>
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/DialogIframe.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
</head>
<body>
<!-- 发私信start -->
<div id="faqdiv2" class="_bodyContent"> 
	<table class="faqtable"   border="0" cellspacing="1" cellpadding="0">
		<tr>
			<td class="faqtabletd1">
			
			<c:choose>
				<c:when test="${type_id eq '2' }">约谈人：</c:when>
				<c:otherwise>收信人：</c:otherwise>
			</c:choose>
			</td>
			<td><input type="text" id="receiverName" name="receiverName" readonly="readonly" value="${receiverName }">
				<input type="hidden" id="receiverId" name="receiverId" value="${receiverId }">
				<input type="hidden" id="projectId" name="projectId" value="${projectId }">
				<input type="hidden" id="type_id" name="type_id" value="${type_id }">
				
				<input type="hidden" id="alsnInfo" name="alsnInfo" value="${alsnInfo }">
				
			</td>
			
		</tr>
		<tr>
			<td class="faqtabletd1">
			
			<c:choose>
				<c:when test="${type_id eq '2' }">约谈留言：</c:when>
				<c:otherwise>内容：</c:otherwise>
			</c:choose>
			</td><td>
			<c:choose>
				<c:when test="${type_id eq '2' }"><textarea rows="5"  name="content" id="content_id" placeholder="请输入内容,建议填写约谈理由、时间、地点、联系电话等。"></textarea><br><em id="_warninput"></em></c:when>
				<c:otherwise><textarea rows="5" name="content"  id="content_id" placeholder="请输入内容"></textarea><br><em id="_warninput2"></em></c:otherwise>
			</c:choose>
			</td>
		</tr>
		<tr style="display:none">
			<td class="faqtabletd1">验证码：</td>
			<td><input type="text" name="valiCode_" id="valiCode_" onfocus="warrinfo_()" onblur="validateC_();" placeholder="请输入验证码">
					<a href="javascript:void(0)" onclick="reload()">
					<img src="${ctx}/servlet/ValidCode" id="validImg" alt="" width="80px;" height="25px;">
					</a>
					<span id="errInfo_id" ></span>
			</td>
		</tr>
	</table>
	<div class="faqbutton">
	    <div class="submit"  onclick="submtDate('${type_id }')">确定</div><div class="cancel" onclick="closediv()">取消</div>
	</div>
</div>
<div class="_successInfo">
	
	<div id="suninfo_" style="margin:20px;"></div>


	<div class="faqbutton">
	    <div class="submit" id="hi_btn" onclick="submtDate()">确定</div><div class="cancel" onclick="closediv()">取消</div>
	</div>
</div>
<!-- 发私信end -->
	<script type="text/javascript">
	$(function(){
		$("._bodyContent").css("display","block"); 
		$("._successInfo").css("display","none"); 
		
		if($("#alsnInfo").val()!=''&&$("#alsnInfo").val()=='1'){
			$("#suninfo_").html("<span  style=\"font-size: 15px; color:#666; margin-left: 10px;margin-top: 35px;\">你今天已经约谈过一次了,每个项目每天只能约谈一次!</span>");
			$("._successInfo").css("display","block"); 
			$("._bodyContent").css("display","none");
			$("#hi_btn").hide();
		}
		
	});
		function closediv(){
			var list = window.parent.art.dialog.list;
			for (var i in list) {
			    list[i].close();
			};
		}
		
		function canclwaring(){
			var content_id=$("#content_id").val();
			if(content_id!=''){
				$("#_warninput").html("");
				$("#_warninput2").html("");
			}
		}
		
		function submtDate(n){
			valiLoginTimeout();  //验证是否登录超时，跳转至登录页面
			var receiverId=$("#receiverId").val();
			var content_id=$("#content_id").val();
			var projectId=$("#projectId").val();
			var valiCode_=$("#valiCode_").val();
			var type_id=$("#type_id").val();
			
			
			/* if(valiCode_==''){
				$("#errInfo_id").html("<font color='red'>验证码不能为空!</font>");
				return;
			} */
			if(n==2||n=='2'){
				
				if(content_id==''){
					
					$("#_warninput").html("<font color='red'>信息内容不能为空!</font>");
					return;
				}
			}else{
				if(content_id==''){
									
						$("#_warninput2").html("<font color='red'>信息内容不能为空!</font>");
						return;
					}
				}
			
			 $.ajax({
					url : "${ctx}/crowdfunding/front/sendPrivateMsg.ht",
					type : 'post',
					data : 'projectId=' + projectId + '&receiverId=' + receiverId+ 
					'&content_id=' + content_id+ '&code=' + valiCode_ + '&type_id='+type_id
					,
					dataType : 'json',
					success : function(data, status) {
						/* if(data=='0'){
							$("#errInfo_id").html("<font color='red'>验证码输入有误!</font>"); 
						}else{ */
							//alert(data);
							$("#suninfo_").html("<span  style=\"font-size: 22px; color:#666; margin-top: 35px;\">发送成功</span>");
							$("._successInfo").css("display","block"); 
							$("._bodyContent").css("display","none");
							$("#hi_btn").hide();
							$(".cancel").css("display","none");
							//setTimeout("closediv()",2000);
							if(projectId == ""){
								setTimeout('window.parent.location = "${ctx}/crowdfunding/tcuserInvestor/tcuserInvestorPage.ht";',2500);
							}else{
								setTimeout('window.parent.location = "${ctx}/crowdfunding/front/toProDetails.ht?projectId='+projectId+'";',2500);
								
							}		
						//	closediv();
					/* 	} */
						
					},
					error : function(xhr, textStatus, errorThrown) {
					}
				});
		}
		
		
		function validateC_(){
			var valiCode_=$("#valiCode_").val();
			if(valiCode_!=''){
				
			    $.ajax({
					url : "${ctx}/crowdfunding/front/validateCode.ht",
					type : 'post',
					data : 'valiCode_=' + valiCode_ 
					,
					dataType : 'html',
					success : function(data, status) {
						if(data==0){
							$("#errInfo_id").html("<font color='red'>验证码输入有误!</font>");
						}
					},
					error : function(xhr, textStatus, errorThrown) {
					}
				});
			}else{
				$("#errInfo_id").html("<font color='red'>验证码不能为空!</font>");
			}
		}
		function warrinfo_(){
			$("#errInfo_id").html("验证码不能为空!");
		}
		
		function reload(){
				var url="${ctx}/servlet/ValidCode?rand=" +new Date().getTime();
				document.getElementById("validImg").src=url;
		}
	</script>
</body>
</html>
