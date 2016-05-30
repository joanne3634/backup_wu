<%@page import="com.deelon.crowdfunding.common.util.TUserUtil"%>
<%@page import="com.deelon.loan.model.front.TUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>会员后台-添加项目动态</title>
		<meta name="renderer" content="webkit"/>
		<%@include file="/commons/include/form.jsp" %>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
	
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
  	<link href="${ctx}/js/jquery/plugins/attach.css" rel="stylesheet" />
    <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
    <script type="text/javascript" src="${ctx }/crowdfunding/js/ckeditor/ckeditor.js"></script>
    <link href="${ctx}/js/jquery/plugins/attach.css" rel="stylesheet" />
    <link href="${ctx}/js/jquery/plugins/jquery.qtip.min.css" rel="stylesheet" />
	<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.qtip.min.js" ></script>
       <script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.attachcr.js" ></script>
       
<style type="text/css">
.tupian{
color: #666666;
font-size: 14px;
}
</style>       
</head>
<%
	TUser  u=TUserUtil.getLogUser( request );
%>
<body>
	<div class="PrDyBack f_l">
		<div class="addPrDy" id="addPrDy">
		<form id="TProjectNewsForm" method="post" action="save.ht">
			<div><label>项目名称：</label>${tcproject.pname }</div>
			<div>
			<label>项目动态标题：</label>
			<input type="text" id="pntitle" name="pntitle" value="${tcprojectNews.pntitle }"/>
			<div id="div1" style="display: inline;"></div>
			</div>
			<div><label>项目动态图片：</label><div style="display: inline-block;"><input type="text" name="fileId" id="fileId" class="attach" attachType="2"
						value="${tcprojectNews.fileId}" />
						</div>
						<em class="tupian">温馨提示：图片宽高最佳尺寸为220x130像素</em>
<%-- 			<div id="div3" style="display: inline;"></div>	<input type="file" id="fileId" name="fileId" value="${tcprojectNews.fileId}"/> --%>
				
			</div>
			<div><label>项目动态内容：</label>
				<div class="ckeditorDiv">
					<textarea class="ckeditor" name="content" id="content">
						${tcprojectNews.pncontent }
					</textarea>
					<div id="div2" style="display: inline;"></div>
				</div>
			</div>
			<c:if test="${tcprojectNews.creator == null}">
				<input type="hidden" id="creator" name="creator" value="<%=u.getUserId()%>"/>
			</c:if>
			<c:if test="${tcprojectNews.creator != null}">
				<input type="hidden" id="creator" name="creator" value="${tcprojectNews.creator}"/>
			</c:if>
			<input type="hidden" id="createTime" name="createTime" value="${tcprojectNews.createTime}"/>
			<input type="hidden" id="isDel" name="isDel" value="0"/>
			<input type="hidden" id="pntypeId" name="pntypeId" value="${tcprojectNews.pntypeId}"/>
			<input type="hidden" id="viewCount" name="viewCount" value="${tcprojectNews.viewCount}"/>
			<input type="hidden" id="projectId" name="projectId" value="${tcproject.projectId}"/>
			<input type="hidden" id="newsId" name="newsId" value="${tcprojectNews.newsId}"/>
			<input type="hidden" id="pncontent" name="pncontent" value="${tcprojectNews.pncontent}"/>
			<div class="addPrDyButton"><span class="PrDyBackButton" onclick="submitForm()">确&nbsp;&nbsp;定</span></div>
		</form>
		</div>
		
		<div class="addPrDy" id="_successInfo">
			<div></div>
			<div></div>
			<div><span style="font-size: 17px; margin-left: 370px;margin-top: 35px;background-color: #6fb701">数据操作成功！！</span></div>
			<div></div>
			<div class="addPrDyButton"><span class="PrDyBackButton" onclick="closediv()">确&nbsp;&nbsp;定</span></div>
		</div>
	</div>
</body>

<script type="text/javascript">
$(function(){
	$("#addPrDy").css("display","block"); 
	$("#_successInfo").css("display","none"); 
});
	function closediv(){
		var list = window.parent.art.dialog.list;
		for (var i in list) {
		    list[i].close();
		};
	}
	
	function submitForm(){
		$("#pncontent").val(CKEDITOR.instances.content.getData());
		var fileVal=$("#fileId").val();
		if($("#pntitle").val()==""){
			openDialog("标题不能为空");
			//$("#div1").html("<font color='red'>标题不能为空！</font>");
			return false;
		}
		if(fileVal.indexOf("fileId")==-1){
			openDialog("请上传附件");
			//$("#div3").html("<font color='red'>请先上传附件后再进行保存！</font>");
			return false;
		}
		if(CKEDITOR.instances.content.getData()==""){
			openDialog("内容不能为空");
			//$("#div2").html("<font color='red'>内容不能为空！</font>");
			return false;
		}
		//$("#div1").html("");
		//$("#div2").html("");
		//$("#div3").html("");
		$.ajax({
			url : "${ctx}/tcproject/ProjectDynamic/editTProject.ht",
			type : 'post',
			data : $("#TProjectNewsForm").serialize(),
			dataType : 'json',
			success : function(data,textStatus) {
				openDialog(data);
				setTimeout('art.dialog.close();art.dialog.open.origin.location.reload(true);',2000);
				//$("#addPrDy").css("display","none"); 
				//$("#_successInfo").css("display","block"); 
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
			}
		});
	}
</script>
</html>
