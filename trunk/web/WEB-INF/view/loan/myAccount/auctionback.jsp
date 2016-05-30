<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/transferback.css">
</head>
<body>
<body>
	<div class="tit-box element-box bg-color-s bd-color-main"><span class="tit-xxl color-main">债权竞拍</span></div>
		<form id="pageForm" name="pageForm" action="${ctx }/myAccount/auctionback.ht#">
			<div class="serach">
				<span>借款人:</span><input id="applyName" name="applyName" type="text" value="${applyName}"><span>标题：</span><input  id="pname" name="pname" value="${pname}" type="text"><span><span class="recharge" onclick="query('b1')">搜索</span>
			</div>
		<div class="buttonlist text-center">
			<div id="b1" class="button1">参与购买的债权</div>
			<div id="b2" class="button2">已成功购买的债权</div>
		</div>
		<input type="hidden" name="status" id="status"  value="${status}"/>
		<div class="tableList" >
		 
		<table class="tableContent text-center"   border="1px" cellspacing="0" cellpadding="0">
			<tr>
				<td width="">借款人</td>
				<td width="">标题</td>
				<td width="">期限</td>
				<td width="">年利率</td>
				<td width="">债券期限</td>
				<td width="">债权金额</td>
				<td width="">最高价</td>
				<td width="">我的竞价</td>
				<td width="">截止时间</td>
				<td width="">状态</td>
				<td width="">操作</td>
			</tr>
			<c:forEach var="project" items="${projectInvestings}">
				<tr>
					<td>${project.loginName}</td>
					<td>${project.pname}</td>
					<td>${project.pDeadline}月</td>
					<td>${project.prateOut}%</td>
					<td>${project.pDeadline-project.prCurrent}月</td>
					<td>${project.piBeGetSum}元</td>
					<td>${project.hieghtestPrice}元</td>
					<td>${project.myPrice}元</td>
					<td><fmt:formatDate value="${project.closeDate}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
					<td>开启</td>
					<td><a href="#" onclick="cacelFunction('${project.transferId}')">撤销</a></td>
				</tr>
			</c:forEach>
			 
		</table>
		</div>

		<div class="tableList hideDiv" >
		 
		<table class="tableContent text-center"   border="1px" cellspacing="0" cellpadding="0">
			<tr>
				<td width="">借款人</td>
				<td width="">标题</td>
				<td width="">期限</td>
				<td width="">年利率</td>
				<td width="">债券期限</td>
				<td width="">债权金额</td>
				<td width="">竞拍底价</td>
				<td width="">竞拍价</td>
				<td width="">竞拍成功时间</td>
				<td width="">转让者</td>
				<td width="">操作</td>
			</tr>
			<c:forEach var="project" items="${projectInvested}">
				<tr>
					<td>${project.loginName}</td>
					<td>${project.pname}</td>
					<td>${project.pDeadline}月</td>
					<td>${project.prateOut}%</td>
					<td>${project.pDeadline-project.prCurrent}月</td>
					<td>${project.piBeGetSum}元</td>
					<td>${project.upsetPrice}元</td>
					<td>${project.hieghtestPrice}元</td>
					<td><fmt:formatDate value="${project.closeDate}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
					<td>${project.transferorIdName}</td>
					<td><a href="#" onclick="queryFunction('1','${project.transferId}')">查看</a></td>
				</tr>
			</c:forEach>
		</table>
		</div>
		<pageTag:paging form="pageForm"/>
       </form>
<script type="text/javascript">
	function cacelFunction(transferId){
		$.ajax({
			type: "post",
			url: "${ctx}/myAccount/cancelauction.ht",
			data:{transferId:transferId},
			dataType:"json",
			success: function(json){
				 alert(json.result);
				 $("#pageForm").submit();
			}
		});
	}
	function query(value){
		$("#pageForm").submit();
	}
	 $(function() {
            $('.buttonlist div').click(function() {
                $(this).removeClass('button2').addClass('button1').siblings().removeClass('button1').addClass('button2');
                $('.tableList').addClass('hideDiv').eq($(this).index()).removeClass('hideDiv');
                $("#status").val($(this).attr("id"));
                $("#pname").val("");
                $("#applyName").val("");
                $("#pageForm").submit();
            });
            if("${status}"){  
         	   $("#${status}").removeClass('button2').addClass('button1').siblings().removeClass('button1').addClass('button2');
                $('.tableList').addClass('hideDiv').eq($("#${status}").index()).removeClass('hideDiv');
            }
            
        });
</script>
</body>
</html>