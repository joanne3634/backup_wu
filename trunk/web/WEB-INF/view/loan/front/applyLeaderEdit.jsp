<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<title>申请领投资格</title>
<%@include file="/commons/include/form.jsp" %> 	
<%@ include file="/crowdfunding/cssorjs.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  	<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
  	<script type="text/javascript" src="${ctx }/crowdfunding/js/ckeditor/ckeditor.js"></script>
  	<script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor_msg.js"></script>
  	<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.qtip.min.js" ></script>
    <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
</head>
<body>
<input type="hidden" id="industryId" name="industryId"  value="${tuserApplyLeader.industryId}"/>
<input type="hidden" id="isCheck" name="isCheck"  value="${tuserApplyLeader.isCheck}"/>
<div>
<div class="PrDyBack f_l">
   <h2><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">申请领投资格</h2>
	<h3 class="applyInvesH3"><img src="${ctx }/crowdfunding/Skin/Default/images/toptriangle.png">风险说明：</h3>
	<p class="applyInvesP">风险声明风险声明风险声明风险声明风险声明风险声明风险声明风险声明风险声明风险声明风险声明风险声明风险声明</p>
    <form id="appform" name="appform" method="post" action="">
		<%--提交阶段字段，已提交未审核1--%>
		<input type="hidden" id="isSubmit" hidden="true">
        <input type="hidden" id="strName" name="strName"/>
        <input type="hidden" name="applyLeaderId" value="${tuserApplyLeader.applyLeaderId}"/>
		<h3 class="applyInvesH3"><img src="${ctx }/crowdfunding/Skin/Default/images/toptriangle.png">请选择领投项目行业：（最多不超过三项）</h3>
		<div class="InvesIndustry">
		   <c:if test="${not empty dictionaryList }">
		        <c:forEach items="${dictionaryList}" var="dictionary" varStatus="status">
		           <c:if test="${status.count%8==0}">
					             </br>
				   </c:if>
		           <span><input type="checkbox" name="invesindustry" value="${dictionary.itemValue}"/>${dictionary.itemName}</span>
		        </c:forEach>
		   </c:if>
	    </div>
		<h3 class="applyInvesH3"><img src="${ctx }/crowdfunding/Skin/Default/images/toptriangle.png">请填写个人简介：</h3>
		<p class="applyInvesP">要求写明个人求学、工作、创业、投资简历。请具体到起止年月、学校专业学历、公司名称部门职务、投资过企业名称等，便于我们做真实性背景调查，否则将不予以受理。</p>
		<div class="ckeditorDiv"><textarea  name="contentText" id="contentText">${tuserApplyLeader.applyInfo}</textarea> </div>
		<p class="applyInvesP">个人简介，不少于100字</p>
		<li class="agreement"><em></em><input type="checkbox"  name="riskCheck" id="riskCheck"/>我已阅读并认可风险声明</li>
		<c:if test="${tuserApplyLeader == null || tuserApplyLeader.isCheck==0 || tuserApplyLeader.isCheck==2}">
		     <span id="dosubmitbtn" class="PrDyBackButton" onclick="doSubmit()">确&nbsp;&nbsp;定</span>
		</c:if>
		<c:if test="${tuserApplyLeader != null && tuserApplyLeader.isCheck ==1}">
		     <span id="dosubmitbtn" style="margin: 30px;display: inline-block;font-size: 18px;width: 100px;height: 35px;line-height: 35px;color:#fff;background: #C0C0C0;-webkit-border-radius: 3px;-moz-border-radius: 3px;border-radius: 3px;cursor: pointer;border: 1px solid #c8c8c8;">确&nbsp;&nbsp;定</span>
		</c:if>
			&nbsp;<span>审核状态:<font color='red'>
				<c:choose>
					<c:when test="${tuserApplyLeader.isCheck==1}"><span class="green">已通过</span></c:when>
					<c:when test="${tuserApplyLeader.isCheck==2}"><span class="red">未通过</span></c:when>
					<c:otherwise><span class="blue">未审核</span></c:otherwise>
				</c:choose>
				</font>
			</span>
			</br>
			<c:if test="${tuserApplyLeader != null && tuserApplyLeader.checkFailReason !=null && tuserApplyLeader.checkFailReason !=''}">
			    <span>审核说明:&nbsp;<font color='red'>${tuserApplyLeader.checkFailReason}</font></span>
			</c:if>
		<input type="hidden" name="str" id ="str"/>
	</form>
	</div>
	</div>
</body>
</html>
<script type="text/javascript">
	$().ready(
		function(){
			$('#dosubmitbtn').css('background','gray');
			$('#dosubmitbtn').attr('onclick','');

			$("input[name=riskCheck]").click(function(){
//				alert($("#isSubmit").val());
				if($(this).is(":checked")&&1!=$("#isSubmit").val()){
					$('#dosubmitbtn').css('background','#72ba00');
					$('#dosubmitbtn').attr('onclick','doSubmit();');
				}else{
					$('#dosubmitbtn').css('background','gray');
					$('#dosubmitbtn').attr('onclick','');
				}
			});
		}
	);
var editor = CKEDITOR.replace('contentText');

function reloadUrl(){
	   window.location.reload(true);
}

function doSubmit() {
	var len = 0;
	$("input[name='invesindustry']:checked").each(function () {
		len++;
    });
	var contentText = $.trim(editor.document.getBody().getText());
	var str="",text = "";
	//var intL = $(".InvesIndustry input:checked").length; //获取除全选复选框外的所有选中项  张建军 201、10、21 modify(内容：注释改行)
	if (len > 3) {
		openDialog("选择的项目不能超过三项",'','','2',function(){});
		return;
	}else if(len == 0){
		openDialog("请选择项目",'','','2',function(){});
		return;
	}else if(contentText ==""){
		openDialog("请填写个人简介",'','','2',function(){});
		return;
	}else{
		$(".InvesIndustry input:checked").each(function(index) {
	        if (this.checked) {
	       	 str+=$(this).val()+","; 
	       	 text+=$(this).parent().text()+","; 
	        }
	    });
		$("#str").val(str.substring(0,str.length-1));
		$("#strName").val(text.substring(0,text.length-1));
		$("#contentText").val(contentText);
		$.ajax({
				url : "${ctx}/user/subApplyLeaderInfo.ht",
				type : 'post',
				data : $('#appform').serialize(),
				success : function(data) {
					if(data == "0") {
						openDialog("领投资格提交成功",'','','2',function(){reloadUrl()});
					}else if(data == "1"){
						openDialog("对不起，请登录操作",'','','2',function(){reloadUrl()});
					}else if(data == "3"){
						$('#dosubmitbtn').css('background','gray');
						$('#dosubmitbtn').attr('onclick','');
						$("#isSubmit").val(1);
						openDialog("已提交申请，请耐心等待审核结果",'','','2',function(){reloadUrl()});
					}
				},
				error : function(xhr, textStatus, errorThrown) {
					openDialog("领投资格提交失败",'','','2',function(){reloadUrl()});
				}
			});
	}
}


$(function(){
	var isCheck = $("#isCheck").val();
	var loadCked = $("#industryId").val();
	var ary = [];
	if(isCheck === "0" ){
		$('#dosubmitbtn').css('background','gray');
		$('#dosubmitbtn').attr('onclick','');
		$("#isSubmit").val(1);
		openDialog("已提交申请，请耐心等待审核结果",'','','4',function(){reloadUrl()});
	}else if(isCheck === "1"){
		openDialog("领投申请已通过",'','','4',function(){reloadUrl()});
	}
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
	//$(".personalDataTag li").click(function(){
		  //$(this).addClass('personalDataTagChecked').siblings().removeClass('personalDataTagChecked');
	//});
	setTimeout("window.parent.iFrameHeight();",500);
})


</script>