<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>


<html>
<head>
	<title>招标中的借款</title>
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
	
	function inviteDisagere(id,complateline){
		if(eval(complateline)>=80){
			$.ligerDialog.confirm("招标已达到    "+complateline+"%, 确认执行该操作吗？","提示信息",function(rtn){
				if(rtn){
					
					location.href="edit.ht?projectId="+id+"&fullLoan="+$("#fullLoan_id").val();
				}else{
					
				}
			});
		}else{
			location.href="edit.ht?projectId="+id+"&fullLoan="+$("#fullLoan_id").val();
		}
	//	openWdin(id,this);
	}
	
	function openWdin(projectId,obj){
		if($(obj).hasClass('disabled')) return false;
		 
		var conf={};				
		var url=__ctx + "/loan/sysManager/invitationOftenderLoan/edit.ht?projectId="+projectId;//+"&refreshUrl=${ctx}/loan/sysManager/invitationOftenderLoan/list.ht";;
		conf.url=url;
		var dialogWidth=550;
		var dialogHeight=450;
		conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);
		var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
			+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;				
		var rtn=window.showModalDialog(url,"",winArgs);		
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
		var flag=true;
		d.each(function(g) {
			var h = $(this);
			
			//当满标操作 选择了多个时,判断有的是否达到了 满标条件
			
			if(ab=='agree'){
				var pcomplete_=$("#pcomplete_"+h.val()).val();
				
				if(eval(pcomplete_)<80){
					
					flag=false;
					$.ligerDialog.warn("项目 ["+$("#pname_"+h.val()).val()+"] 已筹资金 未到达 借款金额的80% ,不能执行满标操作 !");
					return;
					
				}
				
			}
			
			
			if (g < a - 1) {
				f += h.val() + ",";
			} else {
				c = h.attr("name");
				f += h.val();
			}
		});
		if(flag){
		//	agreeApply(f,ab,'');
			 var rep=$.ajax({  
			        type: "POST",  
			        url: "${ctx}/loan/sysManager/invitationOftenderLoan/updateProject.ht",
			        data: {arrayIds:f,agOrdisag:ab }  
			        });  
			      
			   	 rep.done(function( data ){  
			       //		 $.ligerDialog.warn(data.msg);
			       		 alert(data.msg);
			       		///closewin();
			       		location.href=location.href.getNewUrl();
			        });  
			      
			    rep.fail(function( jqXHR, textStatus ) {  
			        $.ligerDialog.warn(textStatus);
			    });  
		}
	//	openWdin(f,this);
		
	}
	

	function agreeApply(pamrm,agOrdisag,compleateLine){
		
		if(agOrdisag=='agree'){
			var pcomplete_=$("#pcomplete_"+pamrm).val();
			if(pcomplete_!=''){
				if(eval(pcomplete_)<80){
					$.ligerDialog.warn("["+$("#pname_"+pamrm).val()+"] 已筹资金 未到达 借款金额的80% ,不能执行满标操作 !");
					return;
				}
			}
		}
			$.ligerDialog.confirm("确认执行该操作吗？","提示信息",function(rtn){
				if(rtn){
					 var rep=$.ajax({  
					        type: "POST",  
					        url: "${ctx}/loan/sysManager/invitationOftenderLoan/updateProject.ht",
					        data: {arrayIds:pamrm,agOrdisag:agOrdisag }  
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
			});
		
	}
	 
	
	
	</script>
</head>
<body>

	<div class="panel">

			<div class="panel-top">
				<div class="tbar-title">
					<span class="tbar-label">资金筹集列表</span>
				</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<f:a alias="searchBorrowApply" css="link search" id="btnSearch"><span></span>查询</f:a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="l-bar-separator"></div>
					<!-- <div class="group">
						<a class="link " style="width: 50px;" href="javascript:void(0);" onclick="auditsDisagree();"><span>批量流标</span></a>
					</div>
					
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link " style="width: 50px;" href="javascript:void(0);" onclick="audits('agree')"><span>批量满标</span></a>
					</div> -->
				</div>	
			</div>
			
			
			<!--search boor  -->
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
											<li><span class="label">开标时间从:</span><input type="text" id="beginDate" name="beginDate"  class="inputText date" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\');}'})" value="${param['beginDate']}"/>
											<span class="label" style="text-align:center;width:40px;">至</span><input type="text" id="endDate" name="endDate"  class="inputText date" onclick="WdatePicker({minDate:'#F{$dp.$D(\'beginDate\');}'})"  value="${param['endDate']}"/>
											</li>
											</div>
										</ul>
										<input type="hidden" id="fullLoan_id" name="fullLoan" value="${fullLoan }"/>
								</form>
								
						</div><!-- search bar end -->

		</div>
		<div class="panel-body">
		    	<c:set var="checkAll">
					<input type="checkbox" id="chkall"/>
				</c:set>
			    <display:table name="ListVo" id="entity" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1"   class="table-grid">
			    
					<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
						<%-- <c:if test="${entity.alinkAction eq '已审核'}">
							<input type="checkbox" class="pk" name="ProjectId" value="${entity.projectId}">
						</c:if>
						  	<input type="checkbox" class="pk" name="ProjectId" value="${entity.projectId}"> --%>
						  	
						  	<c:choose>
						  		<c:when test="${entity.alinkAction eq '已审核'}">
						  			<input type="checkbox" disabled="disabled" class="pk" name="ProjectId" value="${entity.projectId}">
						  		</c:when>
						  		<c:otherwise>
						  			<input type="checkbox" class="pk" name="ProjectId" value="${entity.projectId}">
						  			<input type="hidden" id="pcomplete_${entity.projectId}" name="pcomplete" value="${entity.pcomplete}">
						  			<input type="hidden" name="pname_${entity.projectId}" id="pname_${entity.projectId}" value="${entity.pname}">
						  		</c:otherwise>
						  	</c:choose>
					</display:column>
					<display:column property="applyName" title="会员" sortable="false" sortName="applyName" style="text-align:center;width:5%;"></display:column>
					<display:column property="pname" title="项目名称" sortable="false" sortName="pname" style="text-align:center;width:8%;"></display:column>
					<display:column property="ploan" title="借款金额" sortable="false" sortName="ploan" style="text-align:center;width:8%;"></display:column>
					<display:column property="ploanReal" title="已筹集金额" sortable="false" sortName="ploanReal" style="text-align:center;width:8%;"></display:column>
					<display:column property="prateIn" title="利率" sortable="false" sortName="prateIn" style="text-align:center;width:5%;"></display:column>
					
					<display:column property="pdeadline" title="期限" sortable="false" sortName="pdeadline" style="text-align:center;width:5%;"></display:column>
				 <%-- 	<display:column property="pbreakTimes" title="进度" sortable="false" sortName="pbreakTimes" style="text-align:center;width:8%;"></display:column> --%>
					<display:column property="popenDateStr" title="开标时间" sortable="false" sortName="popenDateStr" style="text-align:center;width:12%;"></display:column>
					<display:column property="pcloaseDateStr" title="结束时间" sortable="false" sortName="pcloaseDateStr" style="text-align:center;width:12%;"></display:column>
					 <display:column property="pComplateStr" title="完成进度" sortable="false" sortName="pComplateStr" style="text-align:center;width:8%;"></display:column>
					<%--  <display:column title="是否满标" sortable="false"  sortName="pisFull">
						<c:choose>
							<c:when test="${entity.pisFull==0}">
								<span class="green">未满标</span>
						   	</c:when>
						   	
					       	<c:otherwise>
						    	<span class="yellow">满标</span>
						   	</c:otherwise>
						</c:choose>
					</display:column> --%>
					<display:column property="pbreakRemark"  title="流标说明" sortable="false" sortName="pbreakRemark" style="text-align:center;width:8%;"></display:column>
					 <display:column property="timeRemaining"  title="剩余时间" sortable="false" sortName="timeRemaining" style="text-align:center;width:10%;"></display:column> 
				 	
					<display:column title="操作" media="html" style="text-align:center;width:13%;">
						${entity.alinkAction }
					</display:column>
					
					
					
				</display:table>
					<deelon:paging tableId="projectId"/>
			
		</div>
	</div>
</body>
  
</html>


