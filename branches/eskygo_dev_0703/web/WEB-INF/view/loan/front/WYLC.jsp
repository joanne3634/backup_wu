<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title><%=application.getAttribute("PLATFORM_NAME")%> - 我要理财</title>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
<script type="text/javascript">
$(function(){
//	var times=$("#iframepage").contentWindow.find("#lastUpdateTime_id").val();
 //  var times=$(window.frames["iframepage"].document).find("#lastUpdateTime_id").attr();
//var val=eval(obji1).value;
//	alert(times);
//	$("#lastupdateTime_id_2").html(times);
	/* function SetValue(ObjectID,ContentID){
		var IsIE = (navigator.appName == 'Microsoft Internet Explorer');

	     if(IsIE){//如果是IE         

	            alert(document.frames("iframepage").document.getElementById("lastUpdateTime_id").innerHTML);                              
	     }else{//如果是FF
	             alert(document.getElementById("iframepage").contentDocument.getElementById("lastUpdateTime_id").value());

	                   //FF下不支持innerText; 下面是解决方法                     

	                   //if(document.all){

	                   //　　alert(document.getElementById('div1').innerText);

	                   //}else{

	                   //　 alert(document.getElementById('div1').textContent);

	                   //}

	     }   
	} */
	  
});
function loadList() {
	$.ajax({
		url : "${ctx}/project/ajaxgetTenderProjects.ht",
		type : 'post',
		//data : $('#register_form').serialize(),
		dataType : 'json',
		success : function(data) {
			var datas = eval(data);
			if(datas.length > 0){
				var html = "";
				for(var i;i < datas.length; i++){
					html += '<li class="pro-rel-ite"><span class="pro-rel-ite-tit" onclick="validateUserName()">';
					html += '<a href="${ctx}/project/showProjectDetail.ht?projectId=${project.projectId}">${project.pdesc}</a></span>';
					html += '<span class="pro-rel-ite-huankuanfangshi pro-rel-ite-gg"><img src="${ctx}/images/renzhengdengji-pic.png" alt=""></span>';
					html += '<span class="pro-rel-ite-jiekuanjine pro-rel-ite-gg orange">${project.ploan}</span>';
					html += '<span class="pro-rel-ite-nianhualv pro-rel-ite-gg orange">${project.prateOut}%</span>';
					html += '<span class="w135 pro-rel-ite-jindu pro-rel-ite-gg"><div style="position: relative; top: 8px; display: inline-block; width: 90px; height: 10px; margin-right: 10px; border-radius: 5px; background-color: #dadada;">';
					html += '<div style="position: relative; top: -8px; display: inline-block; width: ${project.pcomplete}%; height: 10px; border-radius: 5px; background-color: #6db900;"></div>';
					html += '</div>${project.pcomplete}%  </span> <span class="w80 pro-rel-ite-caozuo"><a href="${ctx}/project/showProjectDetail.ht?projectId=${project.projectId}"></a></span></li>';
				}
			}

			
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("加载失败。。，请重试");
		}
	});
}

function iFrameHeight() {
	
    var ifm= document.getElementById("iframepage");

    var subWeb = document.frames ? document.frames["iframepage"].document :

		ifm.contentDocument;

        if(ifm != null && subWeb != null) {

        ifm.height = subWeb.body.scrollHeight;

        }

}

function loadPages(m,n) {
	var url="${ctx}/tenderProjects/getTenderProjectsListPage.ht?pflag=1";
	
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
}

</script>
</head>
<body>
<%@ include file="/commons/includeFront/head.jsp"%>
	<div class="container woyaolicai-body">
		<div class="weizhi-lianjie">
			<a href="${ctx }/index-web.jsp">首页</a> > <span>我要理财</span>
		</div>
		<div id="woyaolicai-con">
			<div style="float: left; width: 560px;">
				<div style="margin-bottom: 5px;">
					交易时间：<span class="color-main">${tradingHours }</span>
				</div>
				<div style="color: #989898; font-size: 12px;">短期限3~12个月借款项目，到期一次性还本付息，年化利率7%~11%，新手投资10000元起投，持有30天后可转让债权收回资金。</div>
			</div>
			<div
				style="float: right; width: 420px; margin-top: 18px; text-align: right;">
				最新借款项目更新时间：<span class="color-main" style="font-size: 22px;" id="lastupdateTime_id_2">${lastUpdateTime }</span>
			</div>
		</div>
		<div id="touzishaixuan">
			<div id="touzishaixuan-tit">
				投资项目筛选<a href="javascript:;"></a>
			</div>
			<dl id="touzishaixuan-list">
				<dt>标的类型</dt>
				<dd class="biddingType">
					<a class="checked color-main"  href="javascript:;" onclick="loadPages('&proType=','1')">不限</a><a class="color-main" href="javascript:;" onclick="loadPages('&proType=1','1')">信用认证标</a><a class="color-main" href="javascript:;" onclick="loadPages('&proType=2','1')">实地认证标</a><a class="color-main"
						href="javascript:;" onclick="loadPages('&proType=3','1')">机构担保标</a><a class="color-main" href="javascript:;" onclick="loadPages('&proType=4','1')">智能理财标</a>
				</dd>
				<dt>借款期限</dt>
				<dd class="termBorrow">
					<a class="checked color-main" href="javascript:;" onclick="loadPages('&pdeadlineBegin=&pdeadlineEnd=','2')">不限</a><a class="color-main" href="javascript:;"  onclick="loadPages('&pdeadlineBegin=3&pdeadlineEnd=6','2')">3~6个月</a><a class="color-main" href="javascript:;" onclick="loadPages('&pdeadlineBegin=9&pdeadlineEnd=15','2')">9~15个月</a><a
						class="color-main" href="javascript:;" onclick="loadPages('&pdeadlineBegin=18&pdeadlineEnd=24','2')">18~24个月</a><a class="color-main" href="javascript:;" onclick="loadPages('&pdeadlineBegin=24','2')">24个月以上</a>
				</dd>
				<dt>认证等级</dt>
				<dd class="certificationLevels">
					<a class="checked color-main" href="javascript:;" onclick="loadPages('&CertLev=','3')">不限</a><a class="color-main" href="javascript:;" onclick="loadPages('&CertLev=AA','3')">AA</a><a class="color-main" href="javascript:;" onclick="loadPages('&CertLev=A','3')">A</a><a class="color-main"
						href="javascript:;" onclick="loadPages('&CertLev=B','3')">B</a><a class="color-main" href="javascript:;" onclick="loadPages('&CertLev=C','3')">C</a><a class="color-main" href="javascript:;" onclick="loadPages('&CertLev=D','3')">D</a><a class="color-main" href="javascript:;" onclick="loadPages('&CertLev=E','3')">E</a><a class="color-main"
						href="javascript:;" onclick="loadPages('&CertLev=HR','3')">HR</a>
				</dd>
			</dl>
		</div>
		<input type="hidden" id="a1">
		<input type="hidden" id="a2">
		<input type="hidden" id="a3">

			<iframe src="${ctx }/tenderProjects/getTenderProjectsListPage.ht"  marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height=100% id="iframepage" name="iframepage" onLoad="iFrameHeight()" ></iframe>
	</div>
	<%@ include file="/commons/includeFront/footer.jsp"%>
	<script>
	  $(function(){
		    $("#touzishaixuan-tit a").click(function(){
		      if ($("#touzishaixuan-list").is(":visible")) {
		        $("#touzishaixuan-list").hide();
		        $("#touzishaixuan-tit a").css("background-position","0 0");
		      }else {
		        $("#touzishaixuan-list").show();
		        $("#touzishaixuan-tit a").css("background-position","0 -15px");
		      }
		    });

		    $(".biddingType a").click(function(){
		      $(".biddingType a").removeClass("checked");
		      $(this).addClass("checked");
		    });
		    $(".termBorrow a").click(function(){
		      $(".termBorrow a").removeClass("checked");
		      $(this).addClass("checked");
		    });
		    $(".certificationLevels a").click(function(){
		      $(".certificationLevels a").removeClass("checked");
		      $(this).addClass("checked");
		    });
		  })
	</script>
</body>
</html>