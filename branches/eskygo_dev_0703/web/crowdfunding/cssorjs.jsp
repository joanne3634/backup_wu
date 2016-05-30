<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="f" uri="http://www.deelon.com/functions" %>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags/helpers"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<script type="text/javascript">
var _ctx="${ctx}";
</script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery-migrate/1.2.1/jquery-migrate.min.js"></script>
<link title="index" name="styleTag" rel="stylesheet" type="text/css" href="<h:static src="/styles/green/css/Aqua/css/ligerui-all.css" type="css"/>">
<script src="<h:static src="/js/lang/common/zh_CN.js" type="js"/>"></script>
<script src="<h:static src="/js/lang/js/zh_CN.js" type="js"/>"></script>
<script src="<h:static src="/js/util/util.js" type="js"/>"></script>
<script src="<h:static src="/js/lg/ligerui.min.js" type="js"/>"></script>
<script src="<h:static src="/js/lg/plugins/ligerDialog.js" type="js"/>"></script>
<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/public.css"/>">
<link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/Skin/Default/css/index.css"/>"> 
<link href="<h:static type="img" src="/crowdfunding/favicon.ico"/>" type="image/x-icon" rel="shortcut icon" />
<script src="<h:static type="js" src="/crowdfunding/artDialog/jquery.artDialog.js?skin=default"/>"></script>
<script src="<h:static type="js" src="/crowdfunding/artDialog/iframeTools.js"/>"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="renderer" content="webkit"/>


<!-- 判断ajax提交的时候是否登录超时 -->
<script type="text/javascript">
	function valiLoginTimeout(p){
		$.ajax({
			url : "${ctx}/user/valiLoginTimeout.ht",
			type : 'post',
			dataType : 'json',
			success : function(data) {
				if(!data){
					if(p == 'iframe'){    //是否是iframe嵌入的页面
						window.parent.location = '${ctx}/loginWeb.jsp';
					}else{
						window.location = '${ctx}/loginWeb.jsp';
					}
				}
			}
		});			
	}
	
	
	
	function openDialog(content,width,height,time,fn){
		if(width==''||width==null||width==undefined){
			width="400px";
		}
		if(height==''||height==null||height==undefined){
			height="150px";
		}
		if(time==''||time==null||time==undefined){
			time=2;
		}
		if(fn ='' ||fn == null || fn == undefined)
			fn = function(){};
		$.dialog({
			time:time,
			content:"<span style='font-size:20px;'>"+ content +"</span>",
			lock: true,
			background: 'black',// 背景色#600
			opacity: 0.80,	// 透明度
			height: height,
			width: width,
			drag: false,
			fixed: true,
			cancel: false,	
			esc:true,
			close:fn
		});
	}
</script>
