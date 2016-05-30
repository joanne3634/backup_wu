<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ include file="/commons/includeFront/taglibs.jsp"%>
 <c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
	<title>创业项目</title>
	<meta name="renderer" content="webkit"/>
  	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/innovationProject.css">
</head>
<body>
<!-- <div style="height:191px;overflow: hidden;">
</div> -->
	<%@ include file="/crowdfunding/head.jsp"%>
	<div class="window">
	<!--<div class="innovationLeft f_l">
			<ul>
				<li <c:if test="${empty success}"> class="innovationhover"</c:if>><span class="innovationspan1"></span><div>科技创新</div><div class="triangle"></div></li>
				<li><span class="innovationspan2"></span><div>连锁服务</div><div class="triangle"></div></li>
				<li <c:if test="${not empty success}"> class="innovationhover"</c:if>><span class="innovationspan2"></span><div>房产服务</div><div class="triangle"></div></li>
				<li <c:if test="${not empty success}"> class="innovationhover"</c:if>><span class="innovationspan3"></span><div>融资成功</div><div class="triangle"></div></li>
			</ul>
		</div>  -->
		<div class="innovationRight f_c">
			<div id="showHide">
			<!--<h3 class="clear">分类检索</h3>  -->
			<dl class="innovationlist">
				<dt id="_xingzhi" class="innovationlistdt"><img src="${ctx }/crowdfunding/Skin/Default/images/trianglegray.png">项目性质</dt>
				<dd id="" class="innovationlistdd">
					<a class="Ahover" id="All" href="javascript:void(0);" onclick="loadPages('&DescType=','1')">全部</a>
					<a href="javascript:void(0);" onclick="loadPages('&DescType=0','1')">科技创新</a>
		       		<a href="javascript:void(0);" onclick="loadPages('&DescType=1','1')">实体经营</a>
		        	<a href="javascript:void(0);" onclick="loadPages('&DescType=2','1')">地产投资</a>
				</dd>
				
				<!-- <dt id="_hangye"><img src="${ctx }/crowdfunding/Skin/Default/images/trianglegray.png">行业</dt>
				<dd id="_keji">
		        	<a class="Ahover" id="All" href="javascript:void(0);" onclick="loadPages('&pindustry=','1')">全部</a>
		       		<a href="javascript:void(0);" onclick="loadPages('&pindustry=1','1')"><f:description nodeKey="PIND" itemValue="1"/></a>
		        	<a href="javascript:void(0);" onclick="loadPages('&pindustry=2','1')"><f:description nodeKey="PIND" itemValue="2"/></a>
		        	<a href="javascript:void(0);" onclick="loadPages('&pindustry=3','1')"><f:description nodeKey="PIND" itemValue="3"/></a>
		        	<a href="javascript:void(0);" onclick="loadPages('&pindustry=4','1')"><f:description nodeKey="PIND" itemValue="4"/></a>
		        	<a href="javascript:void(0);" onclick="loadPages('&pindustry=5','1')"><f:description nodeKey="PIND" itemValue="5"/></a>
		        	<a href="javascript:void(0);" onclick="loadPages('&pindustry=6','1')"><f:description nodeKey="PIND" itemValue="6"/></a>
		        	<a href="javascript:void(0);" onclick="loadPages('&pindustry=7','1')"><f:description nodeKey="PIND" itemValue="7"/></a>
		        	<a href="javascript:void(0);" onclick="loadPages('&pindustry=8','1')"><f:description nodeKey="PIND" itemValue="8"/></a>
		        	<a href="javascript:void(0);" onclick="loadPages('&pindustry=9','1')"><f:description nodeKey="PIND" itemValue="9"/></a> -->
		        <%--  <a href="javascript:void(0);" onclick="loadPages('&pindustry=10','1')"><f:description nodeKey="PIND" itemValue="10"/></a>
		          <a href="javascript:void(0);" onclick="loadPages('&pindustry=11','1')"><f:description nodeKey="PIND" itemValue="11"/></a>
		           <a href="javascript:void(0);" onclick="loadPages('&pindustry=12','1')"><f:description nodeKey="PIND" itemValue="12"/></a> --%>
		        <!--</dd>  -->
		        
		        <!--<dd id="_liansuofuwu" style="display: none;">
		        	<a class="Ahover" id="All" href="javascript:void(0);" onclick="loadPages('&pindustry=','1')">全部</a>
		        	<a href="javascript:void(0);" onclick="loadPages('&pindustry=10','1')"><f:description nodeKey="PIND" itemValue="10"/></a>
		       		<a href="javascript:void(0);" onclick="loadPages('&pindustry=11','1')"><f:description nodeKey="PIND" itemValue="11"/></a>
		        	<a href="javascript:void(0);" onclick="loadPages('&pindustry=12','1')"><f:description nodeKey="PIND" itemValue="12"/></a>
		        	<a href="javascript:void(0);" onclick="loadPages('&pindustry=13','1')"><f:description nodeKey="PIND" itemValue="13"/></a>
		        	<a href="javascript:void(0);" onclick="loadPages('&pindustry=14','1')"><f:description nodeKey="PIND" itemValue="14"/></a>
		        	<a href="javascript:void(0);" onclick="loadPages('&pindustry=15','1')"><f:description nodeKey="PIND" itemValue="15"/></a>
		        	<a href="javascript:void(0);" onclick="loadPages('&pindustry=16','1')"><f:description nodeKey="PIND" itemValue="16"/></a>
		        	<a href="javascript:void(0);" onclick="loadPages('&pindustry=9','1')"><f:description nodeKey="PIND" itemValue="9"/></a>  -->
		        <%--  <a href="javascript:void(0);" onclick="loadPages('&pindustry=10','1')"><f:description nodeKey="PIND" itemValue="10"/></a>
		          <a href="javascript:void(0);" onclick="loadPages('&pindustry=11','1')"><f:description nodeKey="PIND" itemValue="11"/></a>
		           <a href="javascript:void(0);" onclick="loadPages('&pindustry=12','1')"><f:description nodeKey="PIND" itemValue="12"/></a> --%>
		        </dd>
		        
		        <dt class="innovationlistdt"><img src="${ctx }/crowdfunding/Skin/Default/images/trianglegray.png">项目属地</dt>
		        <dd class="innovationlistdd">
		        	<a class="Ahover" id="All" href="javascript:void(0);" onclick="loadPages('&pcityId=','2')">全部</a>
		        	<c:forEach items="${list }" var="vo" begin="0" end="6" varStatus="i">
			        	<a href="javascript:void(0);" onclick="loadPages('&pcityId=${vo.areaId}','2')">${vo.areaName }</a>
		        	</c:forEach>
		        </dd>
		        
		        <dt class="innovationlistdt" id="_xiangmujieduan_ti"><img src="${ctx }/crowdfunding/Skin/Default/images/trianglegray.png">项目阶段</dt>
		        <dd class="innovationlistdd" id="_xiangmujieduan"><a class="Ahover" id="All" href="javascript:void(0);" onclick="loadPages('&pstage=','3')">全部</a>
		        <a href="javascript:void(0);" onclick="loadPages('&pstage=1','3')">众筹中</a>
		        <a href="javascript:void(0);" onclick="loadPages('&pstage=2','3')">融资成功</a>
		        <!--<a href="javascript:void(0);" onclick="loadPages('&pstage=3','3')"><f:description nodeKey="PTYPE" itemValue="3"/></a>
		        <a href="javascript:void(0);" onclick="loadPages('&pstage=4','3')"><f:description nodeKey="PTYPE" itemValue="4"/></a>
		        <a href="javascript:void(0);" onclick="loadPages('&pstage=5','3')"><f:description nodeKey="PTYPE" itemValue="5"/></a>  -->
		        </dd>
	        </dl>
	        </div>
	    <input type="hidden" id="a1">
		<input type="hidden" id="a2">
		<input type="hidden" id="a3">
		<input type="hidden" id="orderBy" value="${orderBy }">
	       <h3 class="clear"><!--<span id="pro_type_name">科技创新项目 </span>  -->
	        <div id="rank" class="rank f_l">
	        	<ul>
	        		<li>发布时间</li>
	        		<li>融资金额</li>
	        		<li>完成进度</li>
	        		<li>认投金额</li>
	        	</ul>
	        </div>
	        </h3>
	        <!--<iframe <c:if test="${not empty success}"> src="${ctx}/crowdfunding/front/financingSuccessProList.ht?DescType=2" </c:if> <c:if test="${empty success}"> src="${ctx }/crowdfunding/front/tofinancingProList.ht?DescList=${DescList}&pisRecommended=${pisRecommended}" </c:if> style="min-height: 500px;" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height=100% id="iframepage" name="iframepage" onLoad="iFrameHeight()" ></iframe>  -->
	        <iframe src="${ctx }/crowdfunding/front/tofinancingProList.ht?DescList=${DescList}&orderBy=${orderBy}&pisRecommended=${pisRecommended}" style="min-height: 500px;" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height=100% id="iframepage" name="iframepage" onLoad="iFrameHeight()" ></iframe>
		</div>
	</div>
	<div class="clear" style="height:130px;overflow: hidden;">
	<%@ include file="/crowdfunding/foot.jsp"%>
	</div>
	<script type="text/javascript">
	//var leftbtn=0;
	$(function(){
		$(".innovationRight").eq(0).css("display","block");
		$(window).scroll(function(){
			if($(window).scrollTop()>190){
				$(".innovationLeft").addClass("fixation");
			}else{
				$(".innovationLeft").removeClass("fixation");
			}
		});
		
		//左侧选项卡切换
		/*$(".innovationLeft li").click(function(){
			  $(this).addClass('innovationhover').siblings().removeClass('innovationhover');
			  $(".innovationlist a").removeClass('Ahover');
			  $('.innovationRight #All').addClass('Ahover');
			  $(".rank li").removeClass('rankChecked');
			  var n=$(this).index();
			  /*if(n!='3'){
				  if(n==0){
					  leftbtn=0;
				  $("#_keji").show();
				  $("#_hangye").show();
				  $("#_xiangmujieduan_ti").show();
				  $("#_xiangmujieduan").show();
				  
				  $("#_liansuofuwu").hide();
				  }else if(n == 1){
					  leftbtn=1;
					  $("#_keji").hide();
					  $("#_xiangmujieduan_ti").hide();
					  $("#_xiangmujieduan").hide();
					  $("#_hangye").show();
					  $("#_liansuofuwu").show();
				  }else{
					  leftbtn=2;
					  $("#_keji").hide();
					  $("#_hangye").hide();
					  $("#_xiangmujieduan_ti").show();
					  $("#_xiangmujieduan").show();
					  $("#_liansuofuwu").hide();
				  }
				  
				  var url="${ctx}/crowdfunding/front/tofinancingProList.ht?DescList=${DescList}&pisRecommended=${pisRecommended}&DescType="+$(this).index();
				  $("#iframepage").attr("src", url);
			  }else{
				  var parent = window.parent;
				//	parent.window.location = "${ctx}/crowdfunding/front/toSuccessProList.ht?DescType="+$(this).index();
				 var url="${ctx}/crowdfunding/front/financingSuccessProList.ht?DescList=${DescList}&pisRecommended=${pisRecommended}&DescType="+$(this).index();
				  $("#iframepage").attr("src", url);
			  }
		});*/
		//排序
		$(".rank li").click(function(){
			  $(this).addClass('rankChecked').siblings().removeClass('rankChecked');
			  var orderBy = $("#orderBy").val();
			  orderBy = orderBy==0 ? 1 : 0;
			  $("#orderBy").val(orderBy);
			  var url="${ctx}/crowdfunding/front/tofinancingProList.ht?DescList="+$(this).index()+"&orderBy="+orderBy;
			  var a1=$("#a1").val();
			  var a2=$("#a2").val();
			  var a3=$("#a3").val();
			  if(a1!=''){
				url+=a1;
			  }
			  if(a2!=''){
				url+=a2;
			  }
			  if(a3!=''){
				url+=a3;
			  }
			  $("#iframepage").attr("src", url);
		});
		// 分类检索
		
		$(".innovationlist a").click(function(){
			 $(this).addClass('Ahover').siblings().removeClass('Ahover');
		});
	});
	
	function loadPages(m,n) {
		var orderBy = $("#orderBy").val();
		var url="${ctx}/crowdfunding/front/tofinancingProList.ht?pflag=1&orderBy="+orderBy;
		$("#a"+n).val(m);
		var a1=$("#a1").val();
		var a2=$("#a2").val();
		var a3=$("#a3").val();
		if(a1!=''){
			url+=a1;
		}
		if(a2!=''){
			url+=a2;
		}
		if(a3!=''){
			url+=a3;
		}
		//var url="${ctx}/project/getTenderProjectsListPage.ht";
		$("#iframepage").attr("src", url);
	//	location.href=url;
	}
	
	function iFrameHeight() {
	    var ifm= document.getElementById("iframepage");
	    var subWeb = document.frames ? document.frames["iframepage"].document :
		ifm.contentDocument;
	    if(ifm != null && subWeb != null) {
	    ifm.height = subWeb.body.scrollHeight;
	    }
	}
	</script>
</body>
</html>
