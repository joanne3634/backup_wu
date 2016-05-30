<%@page import="com.deelon.crowdfunding.model.backstage.Tcproject"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=Tcproject.TABLE_ALIAS%>明细</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label"><%=Tcproject.TABLE_ALIAS%>明细</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link back" href="list.ht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
				<form id="sysFileForm" method="post" action="add2.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th>项目名称:</th>	
							<td>${tcproject.pname}</td>
							<th>项目状态ID:</th>	
							<td>${tcproject.pstateId}</td>
						</tr>
						<tr>
							<th>项目星期资料查看权限:</th>	
							<td>${tcproject.pviewLimit}</td>
							<th>项目类别：1科技创新、2实体经营、3地产投资:</th>	
							<td>${tcproject.ptypeId}</td>
						</tr>
						<tr>
							<th>项目所属行业:</th>	
							<td>${tcproject.pindustry}</td>
							<th>企业所在城市:</th>	
							<td>${tcproject.pcityId}</td>
						</tr>
						<tr>
							<th>企业所在省份:</th>	
							<td>${tcproject.pprovincesId}</td>
							<th>企业成立年份:</th>	
							<td>${tcproject.pfoundedYear}</td>
						</tr>
						<tr>
							<th>企业成立月份:</th>	
							<td>${tcproject.pfoundedMonth}</td>
							<th>项目标签:</th>	
							<td>${tcproject.plabel}</td>
						</tr>
						<tr>
							<th>项目所属阶段:</th>	
							<td>${tcproject.pstage}</td>
							<th>是否有其他项目:</th>	
							<td>${tcproject.pisHaveOther}</td>
						</tr>
						<tr>
							<th>公司名称:</th>	
							<td>${tcproject.pcompanyName}</td>
							<th>公司地址:</th>	
							<td>${tcproject.paddress}</td>
						</tr>
						<tr>
							<th>企业项目简介:</th>	
							<td>${tcproject.pdetail}</td>
							<th>融资金额（万元）:</th>	
							<td>${tcproject.pfinancingAmount}</td>
						</tr>
						<tr>
							<th>认投金额（万元）:</th>	
							<td>${tcproject.pinvestAmount}</td>
							<th>完成比例%:</th>	
							<td>${tcproject.pcomplete}</td>
						</tr>
						<tr>
							<th>投资款拨付方式:</th>	
							<td>${tcproject.ppayWay}</td>
							<th>公司是否成立:</th>	
							<td>${tcproject.psetup}</td>
						</tr>
						<tr>
							<th>浏览次数:</th>	
							<td>${tcproject.pviewCount}</td>
							<th>被收藏次数:</th>	
							<td>${tcproject.pfavoritesCount}</td>
						</tr>
						<tr>
							<th>跟投人数:</th>	
							<td>${tcproject.pinvestCount}</td>
							<th>询价人数:</th>	
							<td>${tcproject.paskPriceCount}</td>
						</tr>
						<tr>
							<th>项目图片:</th>	
							<td>${tcproject.ppic}</td>
							<th>项目视频:</th>	
							<td>${tcproject.pvideo}</td>
						</tr>
						<tr>
							<th>开标时间:</th>	
							<td><fmt:formatDate value="${tcproject.popenDate}" pattern="yyyy-MM-dd HH:mm"/></td>
							<th>结束时间:</th>	
							<td><fmt:formatDate value="${tcproject.pcloseDate}" pattern="yyyy-MM-dd HH:mm"/></td>
						</tr>
						<tr>
							<th>是否推荐项目:</th>	
							<td>${tcproject.pisRecommended}</td>
							<th>开标天数:</th>	
							<td>${tcproject.popenDays}</td>
						</tr>
						<tr>
							<th>最低投资金额（万元）:</th>	
							<td>${tcproject.pinvestMax}</td>
							<th>最大投资金额（万元）:</th>	
							<td>${tcproject.pinvestMin}</td>
						</tr>
						<tr>
							<th>创建人:</th>	
							<td>${tcproject.creator}</td>
							<th>创建时间:</th>	
							<td><fmt:formatDate value="${tcproject.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
						</tr>
						<tr>
							<th>是否删除:</th>	
							<td>${tcproject.isDel}</td>
							<th>是否满标:</th>	
							<td>${tcproject.pisFull}</td>
						</tr>
						<tr>
							<th>满标时间:</th>	
							<td><fmt:formatDate value="${tcproject.pfullTime}" pattern="yyyy-MM-dd HH:mm"/></td>
							<th>审核是否通过（平台）:</th>	
							<td>${tcproject.pisCheck}</td>
						</tr>
						<tr>
							<th>审核人:</th>	
							<td>${tcproject.pchecker}</td>
							<th>审核时间:</th>	
							<td><fmt:formatDate value="${tcproject.pcheckTime}" pattern="yyyy-MM-dd HH:mm"/></td>
						</tr>
						<tr>
							<th>是否放款:</th>	
							<td>${tcproject.pisPay}</td>
							<th>放款时间:</th>	
							<td><fmt:formatDate value="${tcproject.ppayTime}" pattern="yyyy-MM-dd HH:mm"/></td>
						</tr>
						<tr>
							<th>交易费比例:</th>	
							<td>${tcproject.pdealRate}</td>
							<th>交易费（元）:</th>	
							<td>${tcproject.pdealFees}</td>
						</tr>
						<tr>
							<th>贷款人最后取得金额（扣除各种费用后）（元）:</th>	
							<td>${tcproject.pfinalGetPay}</td>
							<th>是否流标:</th>	
							<td>${tcproject.pisBreak}</td>
						</tr>
						<tr>
							<th>流标时间:</th>	
							<td><fmt:formatDate value="${tcproject.pbreakTime}" pattern="yyyy-MM-dd HH:mm"/></td>
							<th>流标说明:</th>	
							<td>${tcproject.pbreakRemark}</td>
						</tr>
						<tr>
							<th>审核说明(台平):</th>	
							<td>${tcproject.pcheckRemark}</td>
							<th>审核次数(平台):</th>	
							<td>${tcproject.pcheckTimes}</td>
						</tr>
					</table>
				</form>
		</div>
</div> 
</body>
</html>