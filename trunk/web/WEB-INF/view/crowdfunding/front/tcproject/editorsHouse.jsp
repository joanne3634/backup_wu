<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="UTF-8">
<meta name="renderer" content="webkit"/>
<title><%=application.getAttribute("PLATFORM_NAME")%> - 商业模式</title>
<%@ include file="/crowdfunding/cssorjs.jsp"%>
 <%@include file="/commons/include/form.jsp" %> 	
	  <script type="text/javascript" src="${ctx }/crowdfunding/js/ckeditor/ckeditor.js"></script>
	  
	   <script type="text/javascript" src="${ctx }/js/jquery/plugins/jquery.showLoading.js"></script>
	<script type="text/javascript" src="${ctx }/js/jquery/plugins/jquery.showLoading.min.js"></script>
   <link href="${ctx }/styles/default/css/jquery/showLoading.css" rel="stylesheet" type="text/css" />
   
     <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
</head>
<body>
		<div class="addyourproject f_l">
		<form id="tcprojectModelForm" method="post" action="${ctx}/crowdfunding/tcproject/saveprojectmodel.ht">
			<h2><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">编辑市场定位与商业模式</h2>
			<div class="steps">
				<div class="step">
					<span>基本资料</span>
				</div>
				<div class="active step">
					<span>市场定位与商业模式</span>
				</div>
				<%--<div class="step">
					<span>股东及管理团队</span>
				</div>
				<div class="step">
					<span>项目历史执行资料</span>
				</div>
				<div class="step">
					<span>项目未来计划</span>
				</div>--%>
			</div>
			<div class="clear EditMarketBusiness">
			<div class="InPrlist">
					<h3 class="InPrlistH3"><span>1</span>众筹产品</h3>
					<div class="ckeditorDiv"><textarea class="ckeditor"  name="pmtargeted" id="pmtargeted">${tcprojectModel.pmtargeted }</textarea> </div>
					<h3 class="InPrlistH3"><span>2</span>总体规划</h3>
					<div class="ckeditorDiv"><textarea class="ckeditor"  name="pmcurrentlyPlaguing" id="pmcurrentlyPlaguing">${tcprojectModel.pmcurrentlyPlaguing }</textarea> </div>
					<h3 class="InPrlistH3"><span>3</span>地理位置</h3>
					<div class="ckeditorDiv"><textarea class="ckeditor"  name="pmservicesMode" id="pmservicesMode">${tcprojectModel.pmservicesMode }</textarea> </div>
					<h3 class="InPrlistH3"><span>4</span>建设进度</h3>
					<div class="ckeditorDiv"><textarea class="ckeditor"  name="pmprofitableDesc" id="pmprofitableDesc">${tcprojectModel.pmprofitableDesc }</textarea> </div>
					<h3 class="InPrlistH3"><span>5</span>价格走势</h3>
					<div class="ckeditorDiv"><textarea class="ckeditor"  name="pmcompetitors" id="pmcompetitors">${tcprojectModel.pmcompetitors }</textarea> </div>
					<h3 class="InPrlistH3"><span>6</span>公司介绍</h3>
					<div class="ckeditorDiv"><textarea class="ckeditor"  name="pmcoreCompetitiveness" id="pmcoreCompetitiveness">${tcprojectModel.pmcoreCompetitiveness }</textarea> </div>
			</div>
			<input type="hidden"  id="modelId" name="modelId" value="${tcprojectModel.modelId}"  />									 
			<input type="hidden"  id="projectId" name="projectId" value="${projectId}"  />
				<input type="hidden" id="next" name="next"/>
					<div class="cumulativeButton">
						<div class="cumulativeButton1" onclick="savetcprojectModel(1)">保存</div>
						<div class="cumulativeButton1" onclick="savetcprojectModel(2)">返回</div>
					</div>
			</div>
			</form>
		</div>
		
		<script type="text/javascript">
		window.onload=function(){
			var interval = setTimeout(window.parent.iFrameHeight, "1000");
		}
		function savetcprojectModel(val){
			$(".addyourproject").showLoading(); 
			$('#next').val(val);
			$("#tcprojectModelForm").submit();
		}
		$(function() {
			window.parent.scrollTo(1200, 300);
			CKEDITOR.config.toolbar=App.toolbar.Basic;
			CKEDITOR.config.height = 200;
			//$('#contentText').val(CKEDITOR.instances.contentText.getData());
		});
	</script>
</body>
</html>
		 
