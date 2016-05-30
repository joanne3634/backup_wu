<%--
	time:2011-11-28 10:17:09
	desc:edit the 用户表
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>

<html>
<head>
	<title>批量审核操作</title>
	<%@include file="/commons/include/form.jsp" %>
	<f:link href="Aqua/css/ligerui-all.css"></f:link>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=tLimitsApply"></script>
	<f:link href="tree/zTreeStyle.css"></f:link>
	<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerTab.js" ></script>
	<script type="text/javascript" src="${ctx}/js/deelon/displaytag.js" ></script>
	<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerWindow.js" ></script>
   <script type="text/javascript"  src="${ctx}/js/deelon/platform/system/SysDialog.js"></script>
   <script type="text/javascript" src="${ctx}/js/deelon/platform/system/FlexUploadDialog.js"></script>
	<script type="text/javascript">
	
	var h;
	var expandDepth =2; 
	
	var action="${action}";
   
	$(function(){
		function showRequest(formData, jqForm, options) { 
			return true;
		} 
		
		function showResponse(responseText, statusText)  { 
    		var self=this;
    		var obj=new com.deelon.form.ResultMessage(responseText);
    		if(obj.isSuccess()){//成功
    			$.ligerDialog.confirm( obj.getMessage()+",是否继续操作","提示信息",function(rtn){
    				if(rtn){
    					if(self.isReset==1){
    						window.location.reload(true);
    					}
    				}else {
    					window.location.href="${returnUrl}";
    				}
    			});
    			
    	    }else{//失败
    	    	$.ligerDialog.error( obj.getMessage(),"出错了");
    	    }
    	}
		$(".link.back").attr("href","list.ht");
		if(${TSetHomepage.homePageId==null}){
			valid(showRequest,showResponse,1);
			
		}else{
			valid(showRequest,showResponse);
		}
		
		
		
		$("a.save").click(function() {
			$('#tSetHomepageForm').submit(); 
		});
	});
	
	
 
	function saveDatas(){
		var audit_status=$("#audit_status").val();
		var audit_desc=$("#audit_desc").val();
		var ApplyIds=$("#ApplyIds").val();
		 var rep=$.ajax({  
		        type: "POST",  
		        url: "${ctx}/loan/sysManager/limitsApplyManage/save.ht",
		        data: { audit_status: audit_status, audit_desc: audit_desc,applyIds:ApplyIds }
		        });  
		      
		    rep.done(function( data ){  
		       		 //$.ligerDialog.warn(data.msg);  		 
		       		//window.parent.location.reload();
		       		window.returnValue=2;
		       		window.close();
		       		 
		       		 
		       		///closewin();
		        });  
		      
		    rep.fail(function( jqXHR, textStatus ) {  
		        //$.ligerDialog.warn(textStatus);
		        //window.opener.location.reload();
		       	window.returnValue=2;
		        window.close();
		        
		        
		    });  
	}
	
	
	function closewin(){
		this.window.close();
		
	}
	
	
	</script>
<style type="text/css">
	html{height:100%}
	body {overflow:auto;}
div.panel-body {
    margin: 0px;
}
</style>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">
					批量审核
				</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a  onclick="saveDatas();" id="dataFormSave" href="#"><span></span>保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a  onclick="closewin();" id="closewin" href="#"><span></span>关闭</a></div>
					<div class="l-bar-separator"></div>
				</div>
			</div>
		</div>
	   <form id="tSetHomepageForm" method="post" action="save.ht">
						
			         
			           		<table class="table-detail"  cellpadding="0" cellspacing="0" border="0">
								<tr>
									<th>是否通过审核: </th>
									<td>
									<select id="audit_status" name="audit_status" class="select" style="width:245px !important">
											<option value="1" <c:if test="${tLimitsApply.audit_status==1}">selected</c:if> >同意</option>
											<option value="2" <c:if test="${tLimitsApply.audit_status==2}">selected</c:if> >不同意</option>
									</select>						
									</td>
								</tr>						
								
								
													
								<tr height="100">
								   <th>备注说明: </th>
								   <td ><input type="text" height="100"  name="audit_desc" id="audit_desc" value="${tLimitsApply.audit_desc}"  style="width:240px !important" class="inputText"/></td>
								</tr>
														
							</table>
							<input type="hidden" id="ApplyIds" name="ApplyIds" value="${ApplyIds}" />
					
	          
	  </form>
</div>
</body>
</html>
