<%--
	time:2011-11-28 10:17:09
	desc:edit the 用户表
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>

<html>
<head>
	<title>流标</title>
	<%@include file="/commons/include/form.jsp" %>
	<f:link href="Aqua/css/ligerui-all.css"></f:link>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=tpro_invitation"></script>
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
		var pbreakRemark=$("#pbreakRemark").val();
		if(pbreakRemark==''){
			 $.ligerDialog.warn("请输入流标原因!");
			 return ;
		}
		var projectId=$("#projectId").val();
		
		 var rep=$.ajax({  
		        type: "POST",  
		    //    url: "${ctx}/loan/sysManager/invitationOftenderLoan/save.ht",
		        url: "${ctx}/loan/sysManager/preliminaryAudit/saveBreak.ht",
		        data: { pbreakRemark:pbreakRemark,projectId:projectId }  
		        });  
		      
		    rep.done(function( data ){  
		       		 $.ligerDialog.warn(data.msg);
		       	//	location.href=location.href.getNewUrl();//$("#refreshUrl_id").val();
		       		location.href="list.ht";
		        });  
		      
		    rep.fail(function( jqXHR, textStatus ) {  
		        $.ligerDialog.warn(textStatus);
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
					流标
				</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link "  id="dataFormSave" href="javascript:saveDatas();">保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><div class="group"><a class="link back" href="list.ht">返回</a></div></div>
					<div class="l-bar-separator"></div>
				</div>
			</div>
		</div>
	   <form id="tSetHomepageForm" method="post" action="save.ht">
						
			         
			           		<table class="table-detail"  cellpadding="0" cellspacing="0" border="0">
														
								<tr height="100">
								   <th>流标说明: </th>
								   <td >
								   	<textarea rows="6" cols="20" name="pbreakRemark" id="pbreakRemark" ></textarea>
								   </td>
								</tr>
														
							</table>
							<input type="hidden" id="projectId" name="projectId" value="${ProjectId}" />
							<input type="hidden" id="refreshUrl_id" name="refreshUrl" value="${refreshUrl}" />
					
	          
	  </form>
</div>
</body>
</html>
