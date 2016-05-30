<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>会员后台-投后添加</title>
	<meta name="renderer" content="webkit"/>
	
	<%@include file="/commons/include/form.jsp" %>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
  	<link href="${ctx}/js/jquery/plugins/attach.css" rel="stylesheet" />
    <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
    <script type="text/javascript" src="${ctx }/crowdfunding/js/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="${ctx}/js/ckeditor/ckeditor_msg.js"></script>
    <link href="${ctx}/js/jquery/plugins/attach.css" rel="stylesheet" />
    <link href="${ctx}/js/jquery/plugins/jquery.qtip.min.css" rel="stylesheet" />
	<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.qtip.min.js" ></script>
       <script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.attachcr.js" ></script>





	<style type="text/css">
	.addPrSubButton{
	background: #8ec017;
	color: #fff;
	font-size: 14px;
	margin-left: 150px;
	cursor: pointer;
	padding: 7px 15px 7px 15px;
	}
	</style>
   <script type="text/javascript">
   
   function reloadUrl(){
	   window.location.reload(true);
   }
   </script>
</head>
<body >
	<div  style="padding:20px;">
	<form id="saveForm" action="${ctx}/crowdfunding/tcprojectAfter/projectAfterSave.ht" method="post">
		<div class="addPrDy" >
			<div><label>项目：</label>
			<select id="projectSelect">
			<option value="" >--请选择--</option>
			<c:if test="${!empty tcprojectList }">
			<c:forEach items="${tcprojectList}" var="pr">
			<option value="${pr.projectId }" <c:if test="${pr.projectId == tcprojectAfter.projectId }">selected</c:if>>${pr.pname }</option>
			</c:forEach>
			</c:if>
			</select>
			<span class="addPrSubButton" onclick="submitPage()">确&nbsp;&nbsp;定</span>
			</div>
			<div><label>类型：</label>
			<select id="paTypeId">
			<option value="0" >--请选择--</option>
			<option value="1" <c:if test="${tcprojectAfter.paTypeId==1 }">selected</c:if>>年度报表</option>
		 	<option value="2" <c:if test="${tcprojectAfter.paTypeId==2 }">selected</c:if>>季度报表</option>
		 	<option value="3" <c:if test="${tcprojectAfter.paTypeId==3 }">selected</c:if>>重大事件披露</option>
			</select></div>
			<div><label>标题：</label>
			<input type="text" id="paTitle" name="paTitle"	value="${tcprojectAfter.paTitle }" />
			</div>
			<div>
			<textarea  name="paContent" id="paContent">${tcprojectAfter.paContent }</textarea>
			</div>
			<div id="uploaded_files">
			</div>
			<div>
			<input type="text" name="fileId" id="fileId" class="attach" attachType="2" value="${tcprojectAfter.fileId}" />
			<!-- <span class="addPrDygreenButton" id="liulang" onclick="addPic('${afterId}');">上传附件</span> --></div>
			
		</div>
		</form>
	</div>
</body>
<script type="text/javascript">
function reloadUrl(){
	art.dialog.open.origin.location.reload(true);
}

			//function add(){
			//	window.location.href="${ctx}/crowdfunding/tcprojectAfter/projectAfterForm.ht";
			//}
			
	var editor=CKEDITOR.replace('paContent'); 
			//editor.config.width="700px";
			//editor.config.height="150px";
	$(function(){
		 	$('.addPrDy').on('click','#liulang',function(){
		 		_index=$(this).parent().parent().index();
		 		$(this).parent().find("input").click();
		 	});
	})
	var _index;
	function upfile(file){
		 var _name=file.files[0].name;
		 $('.addPrDy').find('#textName').val(_name);
	}
	
	function winresh(){
		//window.opener.location.reload(true);
		window.location.reload(true);
		
	}
		
	function submitPage(){
		

		var projectSelect = $("#projectSelect").val();
		var paTypeId = $("#paTypeId").val();
		var paTitle = $("#paTitle").val();
		//var paContent = $("#paContent").val();
		var projectSelect = $("#projectSelect").val();
		var paContent=editor.document.getBody().getHtml();
		var fileId = $("#fileId").val();
		//alert(text);
	
		if(projectSelect==""){
			openDialog("请选择项目");
			return false;
		}
		if(paTypeId=="0"){
			//art.dialog("请选择类型");
			openDialog("请选择类型");
			return false;
		}
		if(paTitle==""){
			openDialog("请填写标题");
			return false;
		}
		if(fileId.indexOf("fileId")==-1){
			openDialog("请先上传附件后再进行保存");
			return false;
		}
		if(paContent==""){
			openDialog("请填写内容");
			return false;
		}
		
		
		//alert("projectId="+projectSelect+"&paTypeId="+paTypeId+"&paTitle"=+paTitle);
		
			$.ajax({
			url : "${ctx}/crowdfunding/tcprojectAfter/projectAfterSave.ht?time="+new Date(),
			type : 'post',
			data: "afterId="+${afterId}+"&projectId="+projectSelect+"&paTypeId="+paTypeId+"&paTitle="+paTitle+
			"&paContent="+paContent+"&fileId="+fileId,
			success : function(data) {
				openDialog(data);
				setTimeout(reloadUrl,2000);
				
				//art.dialog({
				//	content:data,
				//	ok:function(){
				//		art.dialog.close();
				//		art.dialog.open.origin.location.reload(true);	
				//	}});
			}
		});			
	
		
	}
	  		
</script>
</html>