<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>资金记录</title>
	  	<link rel="stylesheet" href="${ctx}/styles/dlweixin/css/style.css">
	  	<script type="text/javascript" src="${ctx}/js/dlweixin/jquery-1.8.3.js"></script>
		<meta name="viewport" content="width=device-width,target-densitydpi=high-dpi,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	</head>

	<body>
		<div class="top">
		<div class="fintop"></div>
		</div>

		<div class="textdiv bodersolid2 ">
			<ul class="ulbutton text-center">
				<li class="text-white background1 radiusleft" value="0" type="1">全部</li>
				<li class="text-black2 bodersolid ulbuttonli"  value="30" type="2">最近30天</li>
				<li class="text-black2 radiusright" value="90" type="3">最近90天</li>
			</ul>
		</div>

		<div class="recordtable">
			<table class=" text-center"   border="1px" cellspacing="0" cellpadding="0">
			<thead class="text-white background7">
			<tr>
				<th>名称</th>
				<th>收支</th>
				<th>交易类型</th>
			</tr>
			</thead>
				<tbody>
					<tr id="more"><td colspan="3">
						<div style="text-align: center;width:100%;color:#ccc;" onclick="get(1);">点击获取更多</div>
					</td></tr>
				</tbody>
			</table>
		</div>
	<form action="" method="post">
		<input type="hidden" name="recentDays" id="recentDays">
		<input type="hidden" name="page" id="page" value="0">
		<input type="hidden" name="pageSize" id="pageSize" value="10">
		<input type="hidden" name="type" id="type" value="1">
	</form>
	</body>
<script type="text/javascript">
var pageTotal = 0;
$(function(){
	get(0);//初始
	$(".ulbutton li").click(function(){
		$(".ulbutton li").removeClass("text-white background1");
		$(".ulbutton li").addClass("text-black2");
		$(this).addClass("text-white background1");
		$(this).removeClass("text-black2");
		var val = $(this).attr("value");
		$("#recentDays").val(val);
		$("#type").val($(this).attr("type"));
		get(0);
	});
});

function get(type){
	var page = $("#page").val();
	if(type==1 && parseInt(page)+1 > pageTotal){
		return;
	}
	if(type==0){//重置
		$("#page").val("0");
		page = 0;
		pageTotal = 0;
		$("#more div").text("点击获取更多");
	}
	$("#page").val(parseInt(page)+1);
	var param = $("form").serialize();
	var url ="${ctx}/weixin/wxmyaccount/getMyFundsRecord.ht"
	$.ajax({
		url:url,
		data:param,
		dataType:'json',
		type:'post',
		success:function(rsp){
			var list = rsp.list;
			
			pageTotal = parseInt(rsp.pageCount);
			var html="";
			for(var i=0;i<list.length;i++){
				html+="<tr>";
				html+="<td>"+list[i].remark+"</td>";
				html+="<td>"+list[i].moneyInOut+"</td>";
				html+="<td>"+list[i].applyName+"</td>";
				html+="</tr>";
			}
			
			if(type==0){
				$("tbody").children().not($("#more")[0]).remove();
			}
			$("#more").before(html);
			if(pageTotal<=parseInt($("#page").val())){
				$("#more div").text("已没有更多记录");
			}
		},
		error:function(){
			alert("获取数据失败");
		}
	});
}
</script>
</html>