<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>借款合同</title>
	<%@include file="/commons/include/get.jsp" %>
	<script type="text/javascript" src="${ctx}/js/util/form.js"></script>
	<script type="text/javascript">
	
	
	function syncToLdap(obj){
		
		var v=$(obj);
		
		if(v.hasClass("disabled")){
			$.ligerDialog.error('没有权限!');
			return;
		}
		var confirmContent="<font color='red'>与AD服务器同步会将AD的用户同步到系统数据库，您确定要进行同步吗？</font>";
		$.ligerDialog.confirm(confirmContent,function(data){
			if(data){
				sync();
			}else{
				return false;
			}
		});
		sync=function(conf){
			var url=__ctx + "/platform/system/sysUser/syncUser.ht";
			$.ligerDialog.waitting('正在同步AD用户，请等待...');
			$.post(url,function(data){
				$.ligerDialog.closeWaitting();
				var obj=new com.deelon.form.ResultMessage(data);
				if(obj.isSuccess()){
					$.ligerDialog.success("同步用户成功!","提示信息",function(){
						location.href=location.href.getNewUrl();
					});
				}
				else{
					$.ligerDialog.err("提示信息","同步用户失败!",obj.getMessage());
				}
			})
		};
	}
	
	
	function audits(ab){
		var d = $("input[type='checkbox'][disabled!='disabled'][class='pk']:checked");
		if (d.length == 0) {
			$.ligerDialog.warn("请选择记录！");
			return false;
		}
		
		var f = "";
		var c = "";
		var a = d.length;
		d.each(function(g) {
			var h = $(this);
			if (g < a - 1) {
				f += h.val() + ",";
			} else {
				c = h.attr("name");
				f += h.val();
			}
		});
		agreeApply(f,'',ab);
	//	openWdin(f,this);
		
	}
	
	
	function agreeApply(pamrm,pstatusId,agOrdisag){
		
		 var rep=$.ajax({  
		        type: "POST",  
		        url: "${ctx}/p2p/sysManager/preliminaryAudit/updates.ht",
		        data: {applyIds:pamrm,pstatusId:pstatusId,agOrdisag:agOrdisag }  
		        });  
		      
		   	 rep.done(function( data ){  
		       		 $.ligerDialog.warn(data.msg);
		       		///closewin();
		       		location.href=location.href.getNewUrl();
		        });  
		      
		    rep.fail(function( jqXHR, textStatus ) {  
		        $.ligerDialog.warn(textStatus);
		    });  
	}
	
	</script>
</head>
<body>

	<div class="panel">

			<div class="panel-top">
				<div class="tbar-title">
					<span class="tbar-label">借款合同管理列表</span>
				</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<%-- <div class="group">
						<f:a alias="searchBorrowApply" css="link search" id="btnSearch"><span></span>查询</f:a>
					</div> --%>
					<div class="l-bar-separator"></div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link " style="width: 50px;"  href="javascript:void(0);" onclick="audits('agree')"><span>批量同意</span></a>
					</div>
					
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link " style="width: 50px;"  href="javascript:void(0);" onclick="audits('disagree')"><span>批量不同意</span></a>
					</div>
				</div>	
			</div>
			
			
			<%-- <!--search boor  -->
					<div class="panel-search">
								<form id="searchForm" method="post" action="list.ht">
										<ul class="row">
											<li><span class="label">会员:</span><input type="text" name="applyName"  class="inputText" value="${param['applyName']}"/></li>
											<li><span class="label">项目名称:</span><input type="text" name="pname"  class="inputText" value="${param['pname']}"/></li>
											<!-- <li><span class="label">审核状态:</span>
											<select name="Q_allowDel_SN" class="select" >
												<option value="">--全部--</option>
												<option value="1">允许</option>
												<option value="0">不允许</option>
											</select></li> -->
											<div class="row_date">
											<li><span class="label">申请时间从:</span><input type="text" id="beginDate" name="beginDate"  class="inputText Wdate" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'beginDate\');}'})" value="${param['beginDate']}"/></li>
											<li><span class="label">至</span><input type="text" id="endDate" name="endDate"  class="inputText Wdate" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endDate\');}'})"  value="${param['endDate']}"/></li>
											</div>
										</ul>
								</form>
								
						</div><!-- search bar end --> --%>

		</div>
		<div class="panel-body">
		    	<c:set var="checkAll">
					<input type="checkbox" id="chkall"/>
				</c:set>
			    <display:table name="ListVo" id="entity" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1"   class="table-grid">
			    
					<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
						  	<input type="checkbox" class="pk" name="ProjectId" value="${entity.projectId}">
					</display:column>
					
					<display:column property="pcNo" title="合同编号" sortable="false" sortName="pcNo" style="text-align:center;width:10%;"></display:column>
					<display:column property="proName" title="项目名称" sortable="false" sortName="proName" style="text-align:center;width:40%;"></display:column>
					<display:column property="ploanReal" title="借款金额" sortable="false" sortName="ploanReal" style="text-align:center;width:10%;"></display:column>
					<%-- <display:column property="prateIn" title="利率" sortable="false" sortName="prateIn" style="text-align:center;width:13%;"></display:column> --%>
					<display:column property="pdeadline" title="贷款期限" sortable="false" sortName="pdeadline" style="text-align:center;width:8%;"></display:column>
				 	<display:column property="pcstarDate" title="开始日期" sortable="false" sortName="pcStarDate" style="text-align:center;width:10%;" format="{0,date,yyyy-MM-dd HH:dd}" ></display:column>
					<display:column property="pcendDate" title="结束日期" sortable="false" sortName="pcEndDate" style="text-align:center;width:10%;" format="{0,date,yyyy-MM-dd HH:dd}" ></display:column>
					<%-- <display:column property="" title="审核状态" sortable="false" sortName="" style="text-align:center;width:13%;"></display:column>
					<display:column property="" title="审核进度" sortable="false" sortName="" style="text-align:center;width:13%;"></display:column>
				 --%>
				 	
					
					<display:column title="审核操作" media="html" style="text-align:center;width:13%;">
						<%-- ${entity.alinkAction } --%>
					</display:column>
				</display:table>
					<deelon:paging tableId="contractId"/>
			
		</div>
	</div>
</body>
</html>


