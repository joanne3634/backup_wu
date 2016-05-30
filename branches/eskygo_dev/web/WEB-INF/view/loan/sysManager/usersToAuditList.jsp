<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<%@include file="/commons/include/get.jsp" %>
	<script type="text/javascript">
		function addAuditTogether(){
			var d = $("input[type='checkbox']:checked");
			var f = "";
			var c = "";
			var a = d.length;
			if(a==0){
				$.ligerDialog.alert("请选择数据");
				return;
			}
			d.each(function(g) {
				var h = $(this);
				if (g < a - 1) {
					f += h.val() + ",";
				} else {
					c = h.attr("name");
					f += h.val();
				}
			});
			window.location.href="${ctx}/loan/sysManager/usersToAudit/editTogether.ht?arrayIds="+f;
			//agreePayLoan(f);
		}
		
		function agreePayLoan(pamrm){
			
			/*  var rep=$.ajax({  
			        type: "POST",  
			        url: "${ctx}/loan/sysManager/usersToAudit/editTogether.ht",
			        data: {arrayIds:pamrm }  
			        });  
			      
			   	 rep.done(function( data ){  
			       		  $.ligerDialog.warn(data.msg);
			       		///closewin();
			       		location.href=location.href.getNewUrl();
			        });  
			      
			    rep.fail(function( jqXHR, textStatus ) {  
			    	/* alert(1);
			        $.ligerDialog.warn(textStatus); 
			    });   */
		}
	</script>
</head>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<%-- <div class="group">							
							<f:a alias="search_cmsSiteConfig" css="link search" id="btnSearch" ><span></span>查询</f:a></div> --%>
							<%-- <div class="l-bar-separator"></div>
							<div class="group"><f:a alias="add_cmsSiteConfig" css="link add" href="edit.ht"><span></span>添加</f:a></div> --%>
							<div class="l-bar-separator"></div>
							<div class="group">
								<a class="link " style="width: 100px;" onclick="addAuditTogether();"><span>批量编辑跟进审核人</span></a>
							</div>
							<%-- <div class="l-bar-separator"></div>
							<div class="group"><f:a alias="del_cmsSiteConfig" css="link del" action="del.ht"><span></span>删除</f:a></div> --%>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<%-- <div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
									<span class="label">站点名称:</span><input type="text" name="Q_siteName_S" value="${cmsSiteConfig.siteName}" maxlength="200" class="inputText" />
									<span class="label">站点代码:</span><input type="text" name="Q_siteCode_S" value="${cmsSiteConfig.siteCode}" maxlength="200" class="inputText" />
							</div>
						</form>
					</div> --%>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="listVo" id="userItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1" export="false"  class="table-grid">
							<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="userId" id="userId" value="${userItem.userId}"}>
							</display:column>
							<display:column property="loginName" title="登入名"   style="text-align:center;width:25%;"/> 
							<display:column property="realName" title="真实姓名"   style="text-align:center;width:25%;"/> 
							<display:column   title="跟进审核人" style="text-align:center;width:25%;" sortProperty="${userItem.checker }" sortable="false" sortName="checker" > 
								<f:description modelCode="sys_user"  modelPropertyName="fullname" modelPropertyValue="userId" nodeKey="MODEL_DATA"  itemValue="${userItem.checker }"/>
							</display:column>
							<display:column title="操作" media="html" style="text-align:center">
								<a href='credit.ht?userId=${userItem.userId}' class="link edit">编辑跟进审核人</a>	
							</display:column>
						</display:table>
						<deelon:paging tableId="userItem"/>
					</div>
				</div>			
	</div>
</body>
</html>
