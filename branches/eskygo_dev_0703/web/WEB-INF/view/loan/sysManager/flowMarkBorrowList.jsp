<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>


<html>
<head>
	<title>流标的借款</title>
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
	
	function auditsDisagree(){
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
		
		openWdin(f,this);
		
	}
	
	function inviteDisagere(id){
		openWdin(id,this);
	}
	
	function openWdin(projectId,obj){
		if($(obj).hasClass('disabled')) return false;
		 
		var conf={};				
		var url=__ctx + "/p2p/sysManager/invitationOftenderLoan/edit.ht?projectId="+projectId;
		conf.url=url;
		var dialogWidth=550;
		var dialogHeight=450;
		conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);
		var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
			+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;				
		var rtn=window.showModalDialog(url,"",winArgs);		
	}
	
	
	function deblockingFundGroup(){
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
		deblockingForFund(f);
	//	openWdin(f,this);
		
	}
	
	function queryBreak(num){
		location.href="${ctx}/loan/sysManager/flowMarkBorrow/queryBreakList.ht?queryNum="+num
		 /* var rep=$.ajax({  
		        type: "POST",  
		        url: "${ctx}/loan/sysManager/flowMarkBorrow/queryBreakList.ht",
		        data: {queryNum:num}  
		        });  
		      
		   	 rep.done(function( data ){  
		       		
		       	//	location.href=location.href.getNewUrl();
		        });  
		      
		    rep.fail(function( jqXHR, textStatus ) {  
		        $.ligerDialog.warn(textStatus);
		    });   */
	}
	

	function deblockingForFund(pamrm){
		
		 var rep=$.ajax({  
		        type: "POST",  
		        url: "${ctx}/loan/sysManager/flowMarkBorrow/blockingFundsofUser.ht",
		        data: {arrayIds:pamrm }  
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
					<span class="tbar-label">流标的借款</span>
				</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<f:a alias="searchBorrowApply" css="link search" id="btnSearch"><span></span>查询</f:a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link " style="width: 50px;"  href="javascript:void(0);" onclick="deblockingFundGroup();"><span>批量解冻</span></a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link " style="width: 60px;"  href="javascript:void(0);" onclick="queryBreak(1);"><span>招标阶段流标</span></a>
					</div>
					
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link " style="width: 60px;"  href="javascript:void(0);" onclick="queryBreak('2')"><span>审核阶段流标</span></a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link " style="width: 50px;"  href="javascript:void(0);" onclick="queryBreak('3')"><span>所有流标</span></a>
					</div>
				</div>	
			</div>
			
			
			<!--search boor  -->
					<div class="panel-search">
								<form id="searchForm" method="post" action="list.ht">
										<ul class="row">
											<li><span class="label">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;会员:</span><input type="text" name="applyName"  class="inputText" value="${param['applyName']}"/></li>
											<li><span class="label">&nbsp;&nbsp;项目名称:</span><input type="text" name="pname"  class="inputText" value="${param['pname']}"/></li>
											<!-- <li><span class="label">审核状态:</span>
											<select name="Q_allowDel_SN" class="select" >
												<option value="">--全部--</option>
												<option value="1">允许</option>
												<option value="0">不允许</option>
											</select></li> -->
											<%-- <div class="row_date">
											<li><span class="label">申请时间从:</span><input type="text" id="beginDate" name="beginDate"  class="inputText Wdate" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'beginDate\');}'})" value="${param['beginDate']}"/></li>
											<li><span class="label">至</span><input type="text" id="endDate" name="endDate"  class="inputText Wdate" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endDate\');}'})"  value="${param['endDate']}"/></li>
											</div> --%>
										</ul>
								</form>
								
						</div><!-- search bar end -->

		</div>
		<div class="panel-body">
		    	<c:set var="checkAll">
					<input type="checkbox" id="chkall"/>
				</c:set>
			    <display:table name="ListVo" id="entity" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1"   class="table-grid">
			    
			    	<c:choose>
			    		<c:when test="${entity.alinkAction ne '无冻结资金'}">
			    			<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
						  	<input type="checkbox" class="pk" name="ProjectId" value="${entity.projectId}">
							</display:column>
			    		</c:when>
			    		<c:otherwise>
			    			<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
						  	<input type="checkbox" disabled="disabled" class="pk" name="ProjectId" value="${entity.projectId}">
							</display:column>
			    		</c:otherwise>
			    	</c:choose>
					<display:column property="applyName" title="会员" sortable="false" sortName="applyName" style="text-align:center;width:5%;"></display:column>
					<display:column property="pname" title="项目名称" sortable="false" sortName="pname" style="text-align:center;width:8%;"></display:column>
					<display:column property="ploan" title="借款金额" sortable="false" sortName="ploan" style="text-align:center;width:8%;"></display:column>
					<display:column property="prateIn" title="利率" sortable="false" sortName="prateIn" style="text-align:center;width:5%;"></display:column>
					
					
					<display:column property="pdeadline" title="期限" sortable="false" sortName="pdeadline" style="text-align:center;width:5%;"></display:column>
					<display:column property="havedPayTimeStr" title="申请时间" sortable="false" sortName="havedPayTimeStr" style="text-align:center;width:10%;"></display:column>
					 <display:column property="pbreakRemark" title="流标原因" sortable="false" sortName="pbreakRemark" style="text-align:center;width:23%;"></display:column>
					<display:column property="timeRemaining"  title="备注" sortable="false" sortName="timeRemaining" style="text-align:center;"></display:column>
				 	
					<display:column title="操作" media="html" style="text-align:center;width:8%;">
						${entity.alinkAction }
					</display:column>
				</display:table>
					<deelon:paging tableId="projectId"/>
			
		</div>
	</div>
</body>
  
</html>


