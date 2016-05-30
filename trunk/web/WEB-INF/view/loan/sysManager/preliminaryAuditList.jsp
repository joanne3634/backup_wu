<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>借款管理-初审中的借款</title>
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
		var flag=true;
		d.each(function(g) {
			var h = $(this);
			
			if(ab=='agree'){
				var prrisk_=$("#prrisk_"+h.val()).val();
				var pcertifiLevel_=$("#pcertifiLevel_"+h.val()).val();
				
				if(prrisk_=='0'||prrisk_=='0.00'){
					
					flag=false;
					$.ligerDialog.warn("请设置["+$("#pname_"+h.val()).val()+"]的担保金比例!");
					return;
					
				}
				if(pcertifiLevel_=='xyjb'){

					flag=false;
					$.ligerDialog.warn("请设置["+$("#pname_"+h.val()).val()+"]的信用级别!");
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
			agreeApply(f,'','',ab);
		}
	//	openWdin(f,this);
		
	}
	
	/* function openWdin(applyId,obj){
		if($(obj).hasClass('disabled')) return false;
		 
		var conf={};				
		var url=__ctx + "/p2p/sysManager/limitsApplyManage/edit.ht?applyId="+applyId;
		conf.url=url;
		var dialogWidth=550;
		var dialogHeight=450;
		conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);
		var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
			+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;				
		var rtn=window.showModalDialog(url,"",winArgs);		
	}
	 */
	function agreeApply(pamrm,pstatusId,prrisk,agOrdisag){
		
		if(agOrdisag=='agree'){
			
			
			if(prrisk=='0'||prrisk=='0.00'){
				$.ligerDialog.warn("请设置担保金比例!");
				return;
			}
			if(prrisk=='xyjb'){
				$.ligerDialog.warn("请设置用户信用级别!");
				return;
			}
			$.ligerDialog.confirm("确认执行该操作吗？","提示信息",function(rtn){
				if(!rtn){
					
					
				}else{
					var rep=$.ajax({  
				        type: "POST",  
				        url: "${ctx}/loan/sysManager/preliminaryAudit/updates.ht",
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
			});
		}else{
			location.href="BrakRmark.ht?projectId="+pamrm;
		//	openWdin(pamrm,this);
		}
		   
	}
	 
	 function openWdin(projectId,obj){
			if($(obj).hasClass('disabled')) return false;
			 
			var conf={};				
			var url=__ctx + "/loan/sysManager/invitationOftenderLoan/edit.ht?projectId="+projectId;//+"&refreshUrl=location.href.getNewUrl()";
			conf.url=url;
			var dialogWidth=550;
			var dialogHeight=450;
			conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);
			var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
				+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;				
			var rtn=window.showModalDialog(url,"",winArgs);		
		}
	
	</script>
</head>
<body>

	<div class="panel">

			<div class="panel-top">
				<div class="tbar-title">
					<span class="tbar-label">额度申请管理列表</span>
				</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<f:a alias="searchBorrowApply" css="link search" id="btnSearch"><span></span>查询</f:a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link " style="width: 50px;" href="javascript:void(0);" onclick="audits('agree')"><span>批量同意</span></a>
					</div>
					
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link "  style="width: 50px;" href="javascript:void(0);" onclick="audits('disagree')"><span>批量不同意</span></a>
					</div>
				</div>	
			</div>
			
			
			<!--search boor  -->
					<div class="panel-search">
								<form id="searchForm" method="post" action="list.ht">
										<ul class="row">
											<li><span class="label">会员:</span><input type="text" name="applyName"  class="inputText" value="${param['applyName']}"/></li>
											<li><span class="label">项目名称:</span><input type="text" name="pname"  class="inputText" value="${param['pname']}"/></li>
											
											<li><span class="label">申请时间从:</span><input type="text" id="beginDate" name="beginDate"  class="inputText date" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\');}'})" value="${param['beginDate']}"/>
											 <span class="label" style="text-align:center;width:40px;">至</span><input type="text" id="endDate" name="endDate"  class="inputText date" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'beginDate\');}'})"  value="${param['endDate']}"/>
											 </li>
											
										</ul>
								</form>
								
						</div><!-- search bar end -->

		</div>
		<div class="panel-body">
		    	<c:set var="checkAll">
					<input type="checkbox" id="chkall"/>
				</c:set>
			    <display:table name="ListVo" id="entity" requestURI="list.ht" sort="external" style="width:100%"  cellpadding="1" cellspacing="1"   class="table-grid">
			    
					<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
						<c:choose>
							<c:when test="${entity.alinkAction eq '已审核' || entity.alinkAction eq '无操作权限'}">
								<input type="checkbox" disabled="disabled" class="pk" name="ProjectId" value="${entity.projectId}">
							</c:when>
							<c:otherwise>
								<input type="checkbox"  class="pk" name="ProjectId" value="${entity.projectId}">
							</c:otherwise>
						</c:choose>
						  <input type="hidden" name="prrisk_${entity.projectId}" id="prrisk_${entity.projectId}" value="${entity.prrisk}">
						  <input type="hidden" name="pname_${entity.projectId}" id="pname_${entity.projectId}" value="${entity.pname}">
						   <input type="hidden" name="pcertifiLevel_${entity.projectId}" id="pcertifiLevel_${entity.projectId}" value="${entity.pcertifiLevel}">
					</display:column>
					
					<display:column value="" property="applyName" title="会员" sortable="false" sortName="applyName" style="text-align:center;width:5%;"></display:column>
					<display:column property="pname" title="项目名称" sortable="false" sortName="pname" style="text-align:center;width:8%;"></display:column>
					<display:column property="ploan" title="借款金额" sortable="false" sortName="ploan" style="text-align:center;width:8%;"></display:column>
					<display:column property="prateIn" title="借款利率" sortable="false" sortName="prateIn" style="text-align:center;width:8%;"></display:column>
					<display:column property="riskName" title="担保机构" sortable="false" sortName="riskName" style="text-align:center;width:8%;"></display:column>
					<display:column property="prrisk" title="担保金额" sortable="false" sortName="prrisk" style="text-align:center;width:8%;">
						
					</display:column>
					<display:column property="prriskRateStr" title="担保金比例" sortable="false" sortName="prriskRateStr" style="text-align:center;width:8%;"></display:column>
					<display:column title="标的认证" sortable="false"  sortName="ptypeId" style="text-align:center;width:8%;">
					
						<c:choose>
							<c:when test="${entity.ptypeId==1}">
								<span class="green">信用认证标</span>
						   	</c:when>
						   	<c:when test="${entity.ptypeId==2}">
						   	<span class="green">实地认证标</span>
						   	</c:when>
						   	<c:when test="${entity.ptypeId==3}">
						   	<span class="green">担保机构标</span>
						   	</c:when>
						   	<c:when test="${entity.ptypeId==4}">
						   	<span class="green">智能理财</span>
						   	</c:when>
					       	<c:otherwise>
						    	<span class="green"></span>
						   	</c:otherwise>
						</c:choose>
						
					</display:column>
					<display:column title="审核状态" sortable="false"  sortName="pstatusId">
						<c:if test="${not empty entity.auditStatus }">
							${entity.auditStatus }
						</c:if>
						<c:if test="${empty entity.auditStatus }">
						<c:choose>
							<c:when test="${entity.pstatusId==1}"><!--发起申请  -->
								<span class="green">新申请</span>
						   	</c:when>
						   	<c:when test="${entity.pstatusId==2}"><!--担保审核  -->
						   	<span class="green">担保审核</span>
						   	</c:when>
						   	<c:when test="${entity.pstatusId==3}"><!--平台审核  -->
						   	<span class="green">平台审核</span>
						   	</c:when>
						   	<c:when test="${entity.pstatusId==4}"><!--筹集资金  -->
						   	<span class="red">招标中</span>
						   	</c:when>
						   	<c:when test="${entity.pstatusId==5}"><!--满标 -->
						   	<span class="red">满标</span>
						   	</c:when>
						   	<c:when test="${entity.pstatusId==6}"><!--满标 -->
						   	<span class="yellow">还款中</span>
						   	</c:when>
						   	<c:when test="${entity.pstatusId==7}"><!--满标 -->
						   	<span class="yellow">已还完</span>
						   	</c:when>
						   	<c:when test="${entity.pstatusId==8}"><!--满标 -->
						   	<span class="red">流标</span>
						   	</c:when>
					       	<c:otherwise>
						    	<span class="green">发起申请</span><!--发起请 null值  -->
						   	</c:otherwise>
						</c:choose>
						</c:if>
					</display:column>
					<display:column property="pdeadlineS" title="期限" sortable="false" sortName="pdeadlineS" style="text-align:center;width:5%;"></display:column>
				 	<display:column property="countNum" title="流标数" sortable="false" sortName="countNum" style="text-align:center;width:5%;"></display:column>
					<display:column property="appleyTime" title="申请时间" sortable="false" sortName="appleyTime" style="text-align:center;width:12%;"></display:column>
					<%-- <display:column property="" title="审核状态" sortable="false" sortName="" style="text-align:center"></display:column>
					<display:column property="" title="审核进度" sortable="false" sortName="" style="text-align:center"></display:column>
				 --%>
				 	<%-- <display:column title="审核进度" sortable="false"  sortName="pstatusId">
						<c:choose>
							<c:when test="${entity.pstatusId==1}"><!--发起申请  -->
								<span class="green">20%</span>
						   	</c:when>
						   	<c:when test="${entity.pstatusId==2}"><!--担保审核  -->
						   	<span class="red">40%</span>
						   	</c:when>
						   	<c:when test="${entity.pstatusId==3}"><!--平台审核  -->
						   	<span class="red">60%</span>
						   	</c:when>
						   	<c:when test="${entity.pstatusId==4}"><!--筹集资金  -->
						   	<span class="red">80%</span>
						   	</c:when>
						   	<c:when test="${entity.pstatusId==5}"><!--满标 -->
						   	<span class="red">100%</span>
						   	</c:when>
					       	<c:otherwise>
						    	<span class="yellow">20%</span><!--发起请 null值  -->
						   	</c:otherwise>
						</c:choose>
					</display:column> --%>
					
					<display:column title="操作" media="html" style="text-align:center;" class="rowOps">
						${entity.alinkAction }
					</display:column>
				</display:table>
					<deelon:paging tableId="projectId"/>
			
		</div>
	</div>
</body>
</html>


