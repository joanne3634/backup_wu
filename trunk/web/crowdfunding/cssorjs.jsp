<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="f" uri="http://www.deelon.com/functions" %> 
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" /> 
<script type="text/javascript">
var _ctx="${ctx}";
</script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/area.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/location.js"></script>
<script type="text/javascript" src="${ctx }/js/jquery/jquery.kinMaxShow-1.1.min.js"></script>
<f:link href="Aqua/css/ligerui-all.css"></f:link>
<f:js pre="js/lang/common" ></f:js>
<f:js pre="js/lang/js" ></f:js>
<script type="text/javascript" src="${ctx}/js/util/util.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/ligerui.min.js"></script>
<script type="text/javascript" src="${ctx }/js/lg/plugins/ligerDialog.js"></script>
<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
<link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/index.css"> 
<link href="${ctx }/crowdfunding/favicon.ico" type="image/x-icon" rel="shortcut icon" />
<script type="text/javascript" src="${ctx }/crowdfunding/artDialog/jquery.artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/crowdfunding/artDialog/iframeTools.js"></script>
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
