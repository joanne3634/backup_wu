<%@page import="com.deelon.crowdfunding.model.backstage.Tcproject"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=Tcproject.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=tcproject&formSave=Y"></script>
	<script type="text/javascript">
		$(function() {
			valid(showRequest,showResponse);
		});
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
			    <c:choose>
			        <c:when test="${tcproject.projectId!=null}">
			            <span class="tbar-label">编辑<%=Tcproject.TABLE_ALIAS%></span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加<%=Tcproject.TABLE_ALIAS%></span>
			        </c:otherwise>
			    </c:choose>
				
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#">保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body" style="margin-top: 1px">
		<form id="tcprojectForm" method="post" action="save.html">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="25%">项目名称:</th>	
								<td>										 
									<input type="text" id="pname" name="pname" value="${tcproject.pname}" class="inputText" />
								</td>
								<th width="25%">项目状态ID:</th>	
								<td>										 
									<input type="text" id="pstateId" name="pstateId" value="${tcproject.pstateId}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">项目星期资料查看权限:</th>	
								<td>										 
									<input type="text" id="pviewLimit" name="pviewLimit" value="${tcproject.pviewLimit}" class="inputText" />
								</td>
								<th width="25%">项目类别：1科技创新、2实体经营、3地产投资:</th>	
								<td>										 
									<input type="text" id="ptypeId" name="ptypeId" value="${tcproject.ptypeId}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">项目所属行业:</th>	
								<td>										 
									<input type="text" id="pindustry" name="pindustry" value="${tcproject.pindustry}" class="inputText" />
								</td>
								<th width="25%">企业所在城市:</th>	
								<td>										 
									<input type="text" id="pcityId" name="pcityId" value="${tcproject.pcityId}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">企业所在省份:</th>	
								<td>										 
									<input type="text" id="pprovincesId" name="pprovincesId" value="${tcproject.pprovincesId}" class="inputText" />
								</td>
								<th width="25%">企业成立年份:</th>	
								<td>										 
									<input type="text" id="pfoundedYear" name="pfoundedYear" value="${tcproject.pfoundedYear}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">企业成立月份:</th>	
								<td>										 
									<input type="text" id="pfoundedMonth" name="pfoundedMonth" value="${tcproject.pfoundedMonth}" class="inputText" />
								</td>
								<th width="25%">项目标签:</th>	
								<td>										 
									<input type="text" id="plabel" name="plabel" value="${tcproject.plabel}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">项目所属阶段:</th>	
								<td>										 
									<input type="text" id="pstage" name="pstage" value="${tcproject.pstage}" class="inputText" />
								</td>
								<th width="25%">是否有其他项目:</th>	
								<td>										 
									<input type="text" id="pisHaveOther" name="pisHaveOther" value="${tcproject.pisHaveOther}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">公司名称:</th>	
								<td>										 
									<input type="text" id="pcompanyName" name="pcompanyName" value="${tcproject.pcompanyName}" class="inputText" />
								</td>
								<th width="25%">公司地址:</th>	
								<td>										 
									<input type="text" id="paddress" name="paddress" value="${tcproject.paddress}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">企业项目简介:</th>	
								<td>										 
									<input type="text" id="pdetail" name="pdetail" value="${tcproject.pdetail}" class="inputText" />
								</td>
								<th width="25%">融资金额（万元）:</th>	
								<td>										 
									<input type="text" id="pfinancingAmount" name="pfinancingAmount" value="${tcproject.pfinancingAmount}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">认投金额（万元）:</th>	
								<td>										 
									<input type="text" id="pinvestAmount" name="pinvestAmount" value="${tcproject.pinvestAmount}" class="inputText" />
								</td>
								<th width="25%">完成比例%:</th>	
								<td>										 
									<input type="text" id="pcomplete" name="pcomplete" value="${tcproject.pcomplete}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">投资款拨付方式:</th>	
								<td>										 
									<input type="text" id="ppayWay" name="ppayWay" value="${tcproject.ppayWay}" class="inputText" />
								</td>
								<th width="25%">公司是否成立:</th>	
								<td>										 
									<input type="text" id="psetup" name="psetup" value="${tcproject.psetup}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">浏览次数:</th>	
								<td>										 
									<input type="text" id="pviewCount" name="pviewCount" value="${tcproject.pviewCount}" class="inputText" />
								</td>
								<th width="25%">被收藏次数:</th>	
								<td>										 
									<input type="text" id="pfavoritesCount" name="pfavoritesCount" value="${tcproject.pfavoritesCount}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">跟投人数:</th>	
								<td>										 
									<input type="text" id="pinvestCount" name="pinvestCount" value="${tcproject.pinvestCount}" class="inputText" />
								</td>
								<th width="25%">询价人数:</th>	
								<td>										 
									<input type="text" id="paskPriceCount" name="paskPriceCount" value="${tcproject.paskPriceCount}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">项目图片:</th>	
								<td>										 
									<input type="text" id="ppic" name="ppic" value="${tcproject.ppic}" class="inputText" />
								</td>
								<th width="25%">项目视频:</th>	
								<td>										 
									<input type="text" id="pvideo" name="pvideo" value="${tcproject.pvideo}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">开标时间:</th>	
								<td>										 
									<input type="text" name="popenDate" value="<fmt:formatDate value='${tcproject.popenDate}' />" class="inputText date" style="width:9%"/>
								</td>
								<th width="25%">结束时间:</th>	
								<td>										 
									<input type="text" name="pcloseDate" value="<fmt:formatDate value='${tcproject.pcloseDate}' />" class="inputText date" style="width:9%"/>
								</td>
							</tr>
							<tr>
								<th width="25%">是否推荐项目:</th>	
								<td>										 
									<input type="text" id="pisRecommended" name="pisRecommended" value="${tcproject.pisRecommended}" class="inputText" />
								</td>
								<th width="25%">开标天数:</th>	
								<td>										 
									<input type="text" id="popenDays" name="popenDays" value="${tcproject.popenDays}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">最低投资金额（万元）:</th>	
								<td>										 
									<input type="text" id="pinvestMax" name="pinvestMax" value="${tcproject.pinvestMax}" class="inputText" />
								</td>
								<th width="25%">最大投资金额（万元）:</th>	
								<td>										 
									<input type="text" id="pinvestMin" name="pinvestMin" value="${tcproject.pinvestMin}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">创建人:</th>	
								<td>										 
									<input type="text" id="creator" name="creator" value="${tcproject.creator}" class="inputText" />
								</td>
								<th width="25%">创建时间:</th>	
								<td>										 
									<input type="text" name="createTime" value="<fmt:formatDate value='${tcproject.createTime}' />" class="inputText date" style="width:9%"/>
								</td>
							</tr>
							<tr>
								<th width="25%">是否删除:</th>	
								<td>										 
									<input type="text" id="isDel" name="isDel" value="${tcproject.isDel}" class="inputText" />
								</td>
								<th width="25%">是否满标:</th>	
								<td>										 
									<input type="text" id="pisFull" name="pisFull" value="${tcproject.pisFull}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">满标时间:</th>	
								<td>										 
									<input type="text" name="pfullTime" value="<fmt:formatDate value='${tcproject.pfullTime}' />" class="inputText date" style="width:9%"/>
								</td>
								<th width="25%">审核是否通过（平台）:</th>	
								<td>										 
									<input type="text" id="pisCheck" name="pisCheck" value="${tcproject.pisCheck}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">审核人:</th>	
								<td>										 
									<input type="text" id="pchecker" name="pchecker" value="${tcproject.pchecker}" class="inputText" />
								</td>
								<th width="25%">审核时间:</th>	
								<td>										 
									<input type="text" name="pcheckTime" value="<fmt:formatDate value='${tcproject.pcheckTime}' />" class="inputText date" style="width:9%"/>
								</td>
							</tr>
							<tr>
								<th width="25%">是否放款:</th>	
								<td>										 
									<input type="text" id="pisPay" name="pisPay" value="${tcproject.pisPay}" class="inputText" />
								</td>
								<th width="25%">放款时间:</th>	
								<td>										 
									<input type="text" name="ppayTime" value="<fmt:formatDate value='${tcproject.ppayTime}' />" class="inputText date" style="width:9%"/>
								</td>
							</tr>
							<tr>
								<th width="25%">交易费比例:</th>	
								<td>										 
									<input type="text" id="pdealRate" name="pdealRate" value="${tcproject.pdealRate}" class="inputText" />
								</td>
								<th width="25%">交易费（元）:</th>	
								<td>										 
									<input type="text" id="pdealFees" name="pdealFees" value="${tcproject.pdealFees}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">贷款人最后取得金额（扣除各种费用后）（元）:</th>	
								<td>										 
									<input type="text" id="pfinalGetPay" name="pfinalGetPay" value="${tcproject.pfinalGetPay}" class="inputText" />
								</td>
								<th width="25%">是否流标:</th>	
								<td>										 
									<input type="text" id="pisBreak" name="pisBreak" value="${tcproject.pisBreak}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">流标时间:</th>	
								<td>										 
									<input type="text" name="pbreakTime" value="<fmt:formatDate value='${tcproject.pbreakTime}' />" class="inputText date" style="width:9%"/>
								</td>
								<th width="25%">流标说明:</th>	
								<td>										 
									<input type="text" id="pbreakRemark" name="pbreakRemark" value="${tcproject.pbreakRemark}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">审核说明(台平):</th>	
								<td>										 
									<input type="text" id="pcheckRemark" name="pcheckRemark" value="${tcproject.pcheckRemark}" class="inputText" />
								</td>
								<th width="25%">审核次数(平台):</th>	
								<td>										 
									<input type="text" id="pcheckTimes" name="pcheckTimes" value="${tcproject.pcheckTimes}" class="inputText" />
								</td>
							</tr>
					</table>
					<input type="hidden" name="projectId" value="${tcproject.projectId}" />
				</form>
		</div>
</div>
</body>
</html>