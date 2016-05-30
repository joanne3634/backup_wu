<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html" %>


<html>
<head>
	<title>用户基本信息管理</title>
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
	
	
	function groupActions(p){
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
		if(p=='1'){//解锁
			unclockAccount(f);
		}
		if(p=='2'){//锁定
			lockAccount(f);
		}
		if(p=='3'){//激活
			activateAccount(f);
		}
		
	}
	

	//解锁
	function unclockAccount(pamrm){
		
		 var rep=$.ajax({  
		        type: "POST",  
		        url: "${ctx}/loan/sysManager/userBasicInfo/updateUserInfo.ht",
		        data: {arrayIds:pamrm ,isLock:'0'}  
		        });  
		      
				rep.done(function( data ){  
					$.ligerDialog.success(data.msg);
		       		location.href=location.href.getNewUrl();
		        });  
			      
			    rep.fail(function( jqXHR, textStatus ) {  
			        $.ligerDialog.err(textStatus);
			    });   
	}
	//锁定
	function lockAccount(pamrm){
		
		 var rep=$.ajax({  
		        type: "POST",  
		        url: "${ctx}/loan/sysManager/userBasicInfo/updateUserInfo.ht",
		        data: {arrayIds:pamrm ,isLock:'1' }  
		        });  
		      
			 	rep.done(function( data ){  
					$.ligerDialog.success(data.msg);
		       		location.href=location.href.getNewUrl();
		        });  
			      
			    rep.fail(function( jqXHR, textStatus ) {  
			        $.ligerDialog.err(textStatus);
			    }); 
	}
	//激活
	function activateAccount(pamrm){
		
		 var rep=$.ajax({  
		        type: "POST",  
		        url: "${ctx}/loan/sysManager/userBasicInfo/updateUserInfo.ht",
		        data: {arrayIds:pamrm ,isActive:'1'}  
		        });  
		      
			 	rep.done(function( data ){  
					$.ligerDialog.success(data.msg);
		       		location.href=location.href.getNewUrl();
		        });  
			      
			    rep.fail(function( jqXHR, textStatus ) {  
			        $.ligerDialog.err(textStatus);
			    }); 
	}
	
	
	
	
	</script>
</head>
<body>

	<div class="panel">

			<div class="panel-top">
				<div class="tbar-title">
					<span class="tbar-label">用户信息列表 </span>
				</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<f:a alias="userBaisicQeury" css="link search" id="btnSearch"><span></span>查询</f:a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link update" href="javascript:void(0);" onclick="groupActions('1');"><span></span>批量解锁</a>
<!-- 						<a alias="groupActions"  href="javascript:void(0);" onclick="groupActions('1');"><span>批量解锁</span></a> -->
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a  class="link update" href="javascript:void(0);" onclick="groupActions('2');"><span></span>批量锁定</a>
<!-- 						<a alias="groupActions"  href="javascript:void(0);" onclick="groupActions('2');"><span>批量锁定</span></a> -->
					</div>
					
					<div class="l-bar-separator"></div>
					<div class="group">
						<a  class="link update" href="javascript:void(0);" onclick="groupActions('3');"><span></span>批量激活</a>
<!-- 						<a alias="groupActions"  href="javascript:void(0);" onclick="groupActions('3');"><span>批量激活</span></a> -->
					</div>
				</div>	
			</div>
			
			
			<!--search boor  -->
					<div class="panel-search">
								<form id="searchForm" method="post" action="list.ht">
										<ul class="row">
											<li><span class="label">会员:</span><input type="text" name="realName"  class="inputText" value="${param['realName']}"/></li>
											<li><span class="label">登录名:</span><input type="text" name="loginName"  class="inputText" value="${param['loginName']}"/></li>
											<li><span class="label">身份证:</span><input type="text" name="idCard"  class="inputText" value="${param['idCard']}"/></li>
										</ul>
								</form>
								
						</div><!-- search bar end -->

		</div>
		<div class="panel-body">
		    	<c:set var="checkAll">
					<input type="checkbox" id="chkall"/>
				</c:set>
			    <display:table name="ListVo" id="entity" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1"   class="table-grid">
			    
					<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
						  	<input type="checkbox" class="pk" name="userId" value="${entity.userId}">
					</display:column>
					
					

					<%-- <display:column property="realName" title="用户组" sortable="false" sortName="realName" style="text-align:center;width:13%;">
						<f:description nodeKey="" itemValue=""></f:description>
					</display:column> --%>
					
					<display:column property="loginName" title="登录名" sortable="false" sortName="loginName" style="text-align:center;width:11%;"></display:column>
					<display:column property="realName" title="真实姓名" sortable="false" sortName="realName" style="text-align:center;width:11%;"></display:column>
					<display:column property="idCard" title="身份证" sortable="false" sortName="idCard" style="text-align:center;width:15%;"></display:column>
					<display:column property="gender" title="性别" sortable="false" sortName="gender" style="text-align:center;width:10%;"></display:column>
					<display:column property="creditOut" title="借出信用" sortable="false" sortName="creditOut" style="text-align:center;width:11%;"></display:column>
					<display:column property="creditIn" title="借入信用" sortable="false" sortName="creditIn" style="text-align:center;width:11%;"></display:column>
					<%-- <display:column property="pdeadline" title="注册时间" sortable="false" sortName="pdeadline" style="text-align:center;width:13%;"></display:column> --%>
				 	<display:column title="状态(激活/锁定)" sortable="false" sortName="phavedPay" style="text-align:center;">
						<c:choose>
							<c:when test="${entity.isLock==1}">
								<span class="red">锁定</span>
						   	</c:when>
						   	<c:when test="${entity.isActive==1}">
								<span class="red">已激活</span>
						   	</c:when>
					       	<c:otherwise>
						    	<span class="green">待激活</span>
						   	</c:otherwise>
						</c:choose>
					</display:column>
					<display:column title="操作" media="html" style="text-align:center;width:13%;">
						${entity.alinkAction }
					</display:column>
				</display:table>
					<deelon:paging tableId="userId"/>
			
		</div>
	</div>
</body>
  
</html>


