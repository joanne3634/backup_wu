<%@page import="com.deelon.loan.model.productsloan.Tproductsloan"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title><%=Tproductsloan.TABLE_ALIAS%>管理</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=tproductsloan&formSave=Y"></script>
	<script type="text/javascript">
		$(function() {
			valid(showRequest,showResponse);
			<c:if test="${tproductsloan.appGuides!=null}">
			$("input[name='appGuides']").each(function(){
				if('${tproductsloan.appGuides}'.indexOf($(this).val())>=0){
					$(this).attr("checked",true);
				}
			});  
			</c:if>
			<c:if test="${tproductsloan.prepareDatas!=null}">
				$("input[name='prepareDatas']").each(function(){
					if('${tproductsloan.prepareDatas}'.indexOf($(this).val())>=0){
						$(this).attr("checked",true);
					}
				});  
			</c:if>
		});
		 function num(th){
			  var reg = /^[0-9]{0}([0-9]|[.])+$/;
		      if(reg.test(th.value)!=true){th.value="";}
		  }
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
			    <c:choose>
			        <c:when test="${tproductsloan.productsLoanId!=null}">
			            <span class="tbar-label">编辑<%=Tproductsloan.TABLE_ALIAS%></span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加<%=Tproductsloan.TABLE_ALIAS%></span>
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
		<form id="tproductsloanForm" name="tproductsloanForm" method="post" action="save.ht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="25%">产品名称:</th>	
								<td>										 
									<input type="text" id="pname" name="pname" value="${tproductsloan.pname}" class="inputText" />
								</td>
								<th width="25%">额度(最小):</th>	
								<td>										 
									<input type="text" id="pamountMin" name="pamountMin"  onkeyup="num(this)" value="${tproductsloan.pamountMin}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">额度(最大):</th>	
								<td>										 
									<input type="text" id="pamountMax" name="pamountMax"  onkeyup="num(this)" value="${tproductsloan.pamountMax}" class="inputText" />
								</td>
								<th width="25%">贷款利率(最小):</th>	
								<td>										 
									<input type="text" id="prateMin" name="prateMin"  onkeyup="num(this)" value="${tproductsloan.prateMin}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">贷款利率(最大):</th>	
								<td>										 
									<input type="text" id="prateMax" name="prateMax"  onkeyup="num(this)" value="${tproductsloan.prateMax}" class="inputText" />
								</td>
								<th width="25%">贷款期限(最小):</th>	
								<td>										 
									<input type="text" id="pdeadlineMin" name="pdeadlineMin"  onkeyup="num(this)" value="${tproductsloan.pdeadlineMin}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">贷款期限(最大):</th>	
								<td>										 
									<input type="text" id="pdeadlineMax" name="pdeadlineMax"  onkeyup="num(this)" value="${tproductsloan.pdeadlineMax}" class="inputText" />
								</td>
								<th width="25%">投注时间(最小):</th>	
								<td>										 
									<input type="text" id="pauditDaysMin" name="pauditDaysMin"  onkeyup="num(this)" value="${tproductsloan.pauditDaysMin}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">投注时间(最大):</th>	
								<td>										 
									<input type="text" id="pauditDaysMax" name="pauditDaysMax"  onkeyup="num(this)" value="${tproductsloan.pauditDaysMax}" class="inputText" />
								</td>
								<th width="25%">审核时间(最小):</th>	
								<td>										 
									<input type="text" id="pvotingDaysMin" name="pvotingDaysMin"  onkeyup="num(this)" value="${tproductsloan.pvotingDaysMin}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">审核时间(最大):</th>	
								<td>										 
									<input type="text" id="pvotingDaysMax" name="pvotingDaysMax"  onkeyup="num(this)" value="${tproductsloan.pvotingDaysMax}" class="inputText" />
								</td>
								<th width="25%">还款方式:</th>	
								<td>										 
									<f:select nodeKey="hkfs" id="prepayWay" defaultValue="${tproductsloan.prepayWay}"></f:select> 
								</td>
							</tr>
							<tr>
								<th width="25%">手续费:</th>	
								<td>										 
									<input type="text" id="pfee" name="pfee"  onkeyup="num(this)" value="${tproductsloan.pfee}" class="inputText" />
								</td>
								<th width="25%">亮点:</th>	
								<td>										 
									<input type="text" id="pgood" name="pgood" value="${tproductsloan.pgood}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">推荐人群:</th>	
								<td>										 
									<input type="text" id="precommend" name="precommend" value="${tproductsloan.precommend}" class="inputText" />
								</td>
								<th width="25%">还款指南:</th>	
								<td>										 
									<input type="text" id="prepayGuide" name="prepayGuide" value="${tproductsloan.prepayGuide}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%" height="100px">申请指南:</th>	
								<td>										 
								<c:forEach var="dic" items="${dics}">
									<label><input  name="appGuides" type="checkbox" value="${dic.itemName}" />${dic.itemName}</label><br/> 
								</c:forEach>
								</td>
								<th width="25%">准备材料:</th>	
								<td>										 
									<c:forEach var="material" items="${materials}">
									<label><input  name="prepareDatas" type="checkbox" value="${material.name}" />${material.name}</label><br/> 
									</c:forEach>
								</td>
							</tr>
					</table>
					<input type="hidden" name="productsLoanId" value="${tproductsloan.productsLoanId}" />
				</form>
		</div>
</div>
<!-- <script type="text/javascript">
		function savetproductsloan(){
			$("#tproductsloanForm").submit();
		}
		$('select').change(function() {
			  if(1==$(this).val()){
				  $("#prepayWayStr").text(1);
			  }else if(2==$(this).val()){
				  $("#prepayWayStr").text(2);
			  }else if(3==$(this).val()){
				  $("#prepayWayStr").text(3);
			  }else if(4==$(this).val()){
				  $("#prepayWayStr").text(4);
			  }
		  });
		$(function() {
			//valid(showRequest,showResponse);
			
		}); 
	</script> -->
</body>
</html>