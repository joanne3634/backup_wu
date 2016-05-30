<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>额度申请管理</title>
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
	
	
	function audits(){
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
	
	function openWdin(applyId,obj){
		if($(obj).hasClass('disabled')) return false;
		 
		var conf={};				
		var url=__ctx + "/loan/sysManager/limitsApplyManage/edit.ht?applyId="+applyId;
		conf.url=url;
		var dialogWidth=550;
		var dialogHeight=450;
		conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);
		var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
			+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;				
		var rtn=window.showModalDialog(url,"",winArgs);
		if(rtn == 2)
		  window.location.reload(); 
	}
	
	function agreeApply(pamrm,agOrdisag){
		
		 var rep=$.ajax({  
		        type: "POST",  
		        url: "${ctx}/loan/sysManager/limitsApplyManage/updates.ht",
		        data: {applyIds:pamrm,agOrdisag:agOrdisag }  
		        });  
		      
		   	 rep.done(function( data ){  
		       		 $.ligerDialog.warn(data.msg,function(){
		       			location.href=location.href.getNewUrl();
		       		 });
		       		///closewin();	       		
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
					<span class="tbar-label">额度申请管理列表</span>
				</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="l-bar-separator"></div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a alias="delModel"  class="link"  style="width: 50px;" href="javascript:void(0);" onclick="audits()"><span>批量审核</span></a>
					</div>
					
					<div class="l-bar-separator"></div>
				</div>	
			</div>
		

		</div>
		<div class="panel-body">
		    	<c:set var="checkAll">
					<input type="checkbox" id="chkall"/>
				</c:set>
			    <display:table name="ListVo" id="entity" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1"   class="table-grid">
			    
					<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
							<c:choose>
							<c:when test="${entity.audit_status != 1 && entity.audit_status != 2 }">
								<input type="checkbox" class="pk" name="ApplyId" value="${entity.applyId}">
						   	</c:when>
						   	<c:otherwise>
						   		<input type="checkbox" class="pk" name="ApplyId" disabled="disabled" value="${entity.applyId}">
						   	</c:otherwise>
						</c:choose>
					</display:column>	
					<display:column property="applyName" title="申请人" sortable="true" sortName="applyName" style="text-align:left;width:60px;"></display:column>
					<display:column property="limitApply" title="申请额度" sortable="true" sortName="limitApply" style="text-align:left;width:80px;"></display:column>
					<display:column property="limitOld" title="原额度" sortable="true" sortName="limitOld" style="text-align:left;width:80px;"></display:column>
					<display:column property="applytimeStr" title="申请时间" sortable="true" sortName="applytimeStr" style="text-align:left;width:110px;"></display:column>
					<display:column property="checkrName" title="审核人" sortable="true" sortName="checkrName" style="text-align:left;width:70px;"></display:column>
					<display:column property="checktimeStr" title="审核时间" sortable="true" sortName="checktimeStr" style="text-align:left;width:110px;"></display:column>
					<display:column property="audit_desc" title="备注说明" sortable="true" sortName="audit_desc" style="text-align:left;width:200px;"></display:column>
					
					<display:column title="审核状态" media="html"  style="text-align:left;width:70px;">
						<f:description nodeKey="shztys" itemValue="${entity.audit_status }"></f:description>
						<%-- <c:choose>
							<c:when test="${entity.audit_status==1}">
								<span class="green">通过</span>
						   	</c:when>
						   	<c:when test="${entity.audit_status==2}">
						   	<span class="red">未通过</span>
						   	</c:when>
					       	<c:otherwise>
						    	<span class="yellow">待审核</span>
						   	</c:otherwise>
						</c:choose> --%>
					</display:column>
					
					<display:column title="操作" media="html" style="text-align:center;width:90px;">
						<c:choose>
							<c:when test="${entity.audit_status != 1 && entity.audit_status != 2}">
								<a href="javascript:;" class="link primary" onclick="agreeApply('${entity.applyId}','agree');">同意</a>							
						   		<a href="javascript:;" class="link primary" onclick="agreeApply('${entity.applyId}','disagree');">不同意</a>	
						   	</c:when>
						   	<c:otherwise>
						   		已审核
						   	</c:otherwise>
						</c:choose>

					</display:column>
					
					
				</display:table>
					<deelon:paging tableId="applyId"/>
			
		</div>
	</div>
</body>
</html>


