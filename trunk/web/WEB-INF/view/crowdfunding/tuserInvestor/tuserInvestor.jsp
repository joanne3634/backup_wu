<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

	<meta charset="UTF-8">
	<meta name="renderer" content="webkit"/>
	<title>投资人</title>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
	<meta name="renderer" content="webkit"/>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/investor.css">
</head>
<script type="text/javascript">
$().ready(function() {
	 $("#tuserMsgremindform").validate({
	        rules: {
	        content: {
		    required: true
		   	},
	   		code: {
	    	required: true
	  		}
	  		},
	        messages: {
	        content: {
		    required: "必填"
		   	},
	   		code: {
	    	required: "必填"
	   		}
	  		}
	    });
	
	
	$("#FProvincesId").change(function(){
		loadPages('FProvincesId',3);		
		$("#FCityId").html("<option value='请选择市'>请选择市</option>");
		if($(this).val() =="请选择省"){return;}
			
		$.ajax({
			url : "${ctx}/user/ajaxGetJilian.ht",
			type : 'post',
			data : "areaId=" + $(this).val(),
			dataType : 'json',
			success : function(data) {
				var html = "<option value='请选择市'>请选择市</option>";
				if(data.length > 0){
					for ( var i = 0; i < data.length; i++) {
						html += "<option value='" + data[i].areaId + "'>" + data[i].areaName + "</option>";
					}		
				}
				$("#FCityId").html(html);

			},
			error : function(xhr, textStatus, errorThrown) {
				alert('异步获取数据出现异常');
			}
		});
	});	
});



function iFrameHeight() {
	
    var ifm= document.getElementById("iframepage");

    var subWeb = document.frames ? document.frames["iframepage"].document :

		ifm.contentDocument;

        if(ifm != null && subWeb != null) {

        ifm.height = subWeb.body.scrollHeight;

        }

}


function loadPages(p,m) {
	var url="${ctx }/crowdfunding/tcuserInvestor/tcuserInvestorPageList.ht?pflag=1";
	
	if(p == "FProvincesId"){
		if($("#" + p).val() !="请选择省"){
			var a1 = "&provincesId=" + $("#" + p).val();
			$("#a" + m).val(a1);
			$("#a2").val('');

		}else{
			$("#a" + m).val('');
			$("#a" + (m+1)).val('');
		}	
	}else if(p == "FCityId"){
		if($("#FProvincesId").val()!="请选择省"){
			if($("#" + p).val() !="请选择市"){
				var a1 = "&cityId=" + $("#" + p).val();
				$("#a" + m).val(a1);
				$("#a2").val('');

			}
		}else{
			$("#a" + m).val('');
		}
	}else if(p == "isCompanyAndLeader"){
		var a1 = "&isCompanyAndLeader=isCompanyAndLeader";
		$("#a" + m).val(a1);
		
	}else if(p == "isLeader_yes"){
		var a1 = "&isLeader=1";
		$("#a" + m).val(a1);
	}else if(p == "isLeader_no"){
		var a1 = "&isLeader=0";
		$("#a" + m).val(a1);
	}else if(p == "quanbu"){
		var a1 = "";
		$("#a" + m).val(a1);
	}else{
		var a1 = "&cityIds=" + p;
		$("#a" + m).val(a1);
		$("#a3").val('');
		$("#a4").val('');
	}
	for(var i = 1; i < 5; i++){
		url += $("#a" + i).val();
	}
	//var url="${ctx}/project/getTenderProjectsListPage.ht";
	//alert(url);
	$("#iframepage").attr("src", url);
}


function xuanzeCity(obj,p){
	$(obj).addClass("Ahover");
	loadPages(p,2);
}
//显示投资人详情显示层
function loadPagesDetails(p,d){
	if(p ==""){
		return;
	}
	$.dialog.open('${ctx}/crowdfunding/tcuserInvestor/tcuserInvestorPageDetails.ht?userId='+p, {
		title: d + '详细资料',lock:true});
}

//私信详情显示层
function loadPagesSendMsgremind(p){
	
	$.ajax({
		url : "${ctx}/user/valiLoginTimeout.ht",
		type : 'post',
		dataType : 'json',
		success : function(data) {
			if(data){
				if(p ==""){
					return;
				}	
				$.dialog.open('${ctx}/crowdfunding/front/openSendInfoWin.ht?receiverId=' + p + '&type_id=1', {
					title: '发私信',lock:true});
			}else{
				window.parent.location.href = '${ctx}/loginWeb.jsp';
			}
		}
	});	
	
}

//自荐项目显示层
function loadPageszijianMyProject(p){
	
	$.ajax({
		url : "${ctx}/user/valiLoginTimeout.ht",
		type : 'post',
		dataType : 'json',
		success : function(data) {
			if(!data){
				window.parent.location.href = '${ctx}/loginWeb.jsp';
			}else{
				if(p ==""){
					return;
				}
				$.dialog.open('${ctx}/crowdfunding/tcuserInvestor/zijianMyProjectPage.ht?receiverId='+p, {
					title: '推荐我的项目',lock:true});
			}
		}
	});	

}

//关闭窗口（关闭所有弹出窗口）
function closediv(){
	$("#faqbg").css("display","none"); 
	$("#faqdiv").css("display","none"); 
	$("#faqdiv2").css("display","none");
}


//刷新验证码
function reload(){
	var url="${ctx}/servlet/ValidCode?rand=" +new Date().getTime();
	document.getElementById("validImg").src=url;
}
</script>
<body>
	<!-- <div style="height:191px;overflow: hidden;">
	</div> -->
	<%@ include file="/crowdfunding/head.jsp"%>
	<div class="window">
		<div class="incestorLeft f_l">
			<h3 class="clear"><img src="${ctx }/crowdfunding/Skin/Default/images/InPrIcont.png">投资人</h3>
			<dl class="incestorLeftlist">
				<dt><img src="${ctx }/crowdfunding/Skin/Default/images/trianglegray.png">投资人类型</dt>
		        <dd><a class="Ahover" href="javascript:;" onclick="loadPages('quanbu',1)">全部</a>
		        <a href="javascript:;" onclick="loadPages('isCompanyAndLeader',1)">机构</a>
		        <a href="javascript:;" onclick="loadPages('isLeader_yes',1)">领投人</a>
		        <a href="javascript:;" onclick="loadPages('isLeader_no',1)">跟投人</a></dd>
		        <dt><img src="${ctx }/crowdfunding/Skin/Default/images/trianglegray.png">按所属城市</dt>
		        <dd><a class="Ahover" href="javascript:;" onclick="loadPages('quanbu',2)">全部</a>
		        <c:forEach items="${areaisRecommendedlist }" var="list" begin="0" end="6">
		        	<a href="javascript:;" onclick="xuanzeCity(this,'${list.areaId}',2)">${list.areaName }</a>
		        </c:forEach>
<!-- 		        
		        <a href="javascript:void(0);">广州市</a>
		        <a href="javascript:void(0);">北京市</a>
		        <a href="javascript:void(0);">上海市</a>
		        <a href="javascript:void(0);">杭州市</a>
		        <a href="javascript:void(0);">苏州市</a>
		        <a href="javascript:void(0);">厦门市</a> -->
		        <div></div><a href="javascript:;" onclick="$('#a3').val('');loadPages('quanbu',4);">其他</a>
		        <select id="FProvincesId">
		        	<option value="请选择省">请选择省</option>
		        	<c:forEach items="${arealist }" var="list">
		        		<option value="${list.areaId }">${list.areaName }</option>
		        	</c:forEach>
		        </select >
		        <select id="FCityId" onchange="loadPages('FCityId',4)"><option>请选择市</option></select>
		        </dd>
	        </dl>
	        <input type="hidden" id="a1">
			<input type="hidden" id="a2">
			<input type="hidden" id="a3">
			<input type="hidden" id="a4">
	        <!-- 投资人列表开始 -->
	        <iframe src="${ctx }/crowdfunding/tcuserInvestor/tcuserInvestorPageList.ht"  marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height=100% id="iframepage" name="iframepage" onLoad="iFrameHeight()" ></iframe>
			<!-- 投资人列表结束 -->	
		</div>
		<div class="incestorRight f_l">
			<h4><span>投资人推荐</span></h4>
			<c:forEach items="${tuserisRecommendedlist }" var="list" varStatus="i">
				<c:if test="${i.index < 1 }">
						<div class="incestorRightList">
							<div class="incestorRightimg">
									<c:if test="${not empty list.myPhoto }">
										<img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${list.myPhoto}">
									</c:if>
									<c:if test="${empty list.myPhoto }">
										<img src="${ctx }/crowdfunding/Skin/Default/images/headportrait3.png">
									</c:if>
							</div>
							<div class="InRightlist">
								<p title="${list.loginName }">
									<c:if test="${list.isCompany eq 0 }">
										<p title="${list.loginName }">
											<c:if test="${fn:length(list.loginName) > 6 }">
												${fn:substring(list.loginName,0,6) }...
											</c:if>
											<c:if test="${fn:length(list.loginName) <= 6 }">
												${list.loginName }
											</c:if>
									</c:if>
									<c:if test="${list.isCompany eq 1 }">
										<p title="${list.loginName }">
											<c:if test="${fn:length(list.loginName) > 6 }">
												${fn:substring(list.loginName,0,6) }...
											</c:if>
											<c:if test="${fn:length(list.loginName) <= 6 }">
												${list.loginName }
											</c:if>
									</c:if>								
									<c:if test="${list.isLeader == 1 }">  <!-- 是否领投人 -->
										<img src="${ctx }/images/lingtouren.png" title="领投人"/>
									</c:if>
									<c:if test="${list.isCompany eq 1 }">
										<img title="投资机构" src="${ctx }/crowdfunding/Skin/Default/images/touzijigou.png">
									</c:if>
									<c:if test="${list.isAskPrice == 1 }">  <!-- 是否询价 -->
										<img src="${ctx }/images/xunjia.jpg" title="询价认证资格"/>
									</c:if>
									<c:if test="${list.bindIdno == 1 }">  <!-- 是否实名认证 -->
										<img src="${ctx }/images/shimingyanzheng.png" title="实名认证会员"/>
									</c:if>
										</p>
								<div title="${list.remarks }">
										<c:if test="${fn:length(list.remarks) > 15 }">
											${fn:substring(list.remarks,0,15) }...
										</c:if>
										<c:if test="${fn:length(list.remarks) <= 15 }">
											${list.remarks }
										</c:if>
								</div>
								<div><span onclick="loadPagesSendMsgremind('${list.userId}')">+发私信</span>
								<%-- <a href="javascript:;" onclick="window.parent.loadPageszijianMyProject('${list.userId }')">>>自荐项目</a> --%>
								 <!-- update by nicole  2015/4/22 投资人时隐藏自荐我的项目 -->
									<c:choose>
										<c:when test="${curuser.groupId eq 1}">
										<a href="javascript:;" onclick="window.parent.loadPageszijianMyProject('${list.userId }')">>>自荐项目</a>
										</c:when>
										<c:otherwise>
										
										</c:otherwise>
									</c:choose>
								
								</div>
							</div>
						</div>
				</c:if>
			</c:forEach>

			
			<div class="clear incestorRightList">
			<h4><span>最新投资人</span></h4>
			<ul>
				<c:forEach items="${tuserList }" var="list" varStatus="i">
					<c:if test="${i.index < 6 }">
						<li>
							<div class="incestorRightimg">
									<c:if test="${not empty list.myPhoto }">
										<img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${list.myPhoto}">
									</c:if>
									<c:if test="${empty list.myPhoto }">
										<img src="${ctx }/crowdfunding/Skin/Default/images/headportrait3.png">
									</c:if>
							</div>
							<div class="InRightlist">
								<p title="${list.loginName }">
									<c:if test="${list.isCompany eq 0 }">
										<p title="${list.loginName }">
											<c:if test="${fn:length(list.loginName) > 10 }">
												${fn:substring(list.loginName,0,10) }...
											</c:if>
											<c:if test="${fn:length(list.loginName) <= 10 }">
												${list.loginName }
											</c:if>
									</c:if>
									<c:if test="${list.isCompany eq 1 }">
										<p title="${list.loginName }">
											<c:if test="${fn:length(list.loginName) > 10 }">
												${fn:substring(list.loginName,0,10) }...
											</c:if>
											<c:if test="${fn:length(list.loginName) <= 10 }">
												${list.loginName }
											</c:if>
									</c:if></p>
								<div title="${list.remarks }">
										<c:if test="${fn:length(list.remarks) > 10 }">
											${fn:substring(list.remarks,0,10) }...
										</c:if>
										<c:if test="${fn:length(list.remarks) <= 10 }">
											${list.remarks }
										</c:if>
								</div>
							<div><span onclick="loadPagesSendMsgremind('${list.userId}')">+发私信</span>
							<%-- <a href="javascript:;" onclick="window.parent.loadPageszijianMyProject('${list.userId }')">>>自荐项目</a> --%>
							 <!-- update by nicole  2015/4/22 投资人时隐藏自荐我的项目 -->
									<c:choose>
										<c:when test="${curuser.groupId eq 1}">
										<a href="javascript:;" onclick="window.parent.loadPageszijianMyProject('${list.userId }')">>>自荐项目</a>
										</c:when>
										<c:otherwise>
										
										</c:otherwise>
									</c:choose>
							
							</div>
							</div>
						</li>
					</c:if>
				</c:forEach>
			</ul>
			</div>
		</div>
	</div>
	<div class="clear" style="height:130px;overflow: hidden;">
	<%@ include file="/crowdfunding/foot.jsp"%>
		<!-- <iframe src="./foot.html" height="150px;" width="100%" frameborder="0" scrolling="no"></iframe> -->
	</div>

	
	<script type="text/javascript">
	$(function(){
		$(".incestorLeftlist a").click(function(){
			 $(this).addClass('Ahover').siblings().removeClass('Ahover');
		});
	})
	</script>
</body>
</html>
