<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>自定义表代码生成</title>
<%@include file="/commons/include/form.jsp"%>
<f:link href="tree/zTreeStyle.css"></f:link>
<script type="text/javascript"	src="${ctx}/js/tree/jquery.ztree.js"></script>
<script type="text/javascript">
	var tableTree;
	var height;
	$(function() {
		$("#layout").ligerLayout({
			leftWidth : 250,
			height : '100%',
			allowLeftResize : false
		});
		height = $('#layout').height();
		loadTree("");
		$("#treeReFresh").click(function() {
			loadTree("");
			$("#viewFrame").attr("src","${ctx}/platform/system/sysCodegen/detail.ht");
		});

		$("#treeExpand").click(function() {
			tableTree.expandAll(true);
		});
		$("#treeCollapse").click(function() {
			tableTree.expandAll(false);
		});
		$("#treeSearch").click(function(){
			var subject=$("#subject").val();
			loadTree(subject);
		});
	});
	
	function loadTree(subject) {
		var setting = {
			data : {
				key : {
					name : "subject"
				},
				simpleData : {
					enable : true,
					idKey : "formDefId",
					rootPId : 1
				}
			},
			view : {
				selectedMulti : false
			},
			check:{
				enable: true,
				chkboxType: { "Y": "", "N": "" }
			},
			callback : {
				onClick	: zTreeOnCheck
			}
		};

		$.post(
			"${ctx}/platform/system/sysCodegen/getTableData.ht?subject="+subject,
			function(result) {
				for ( var i = 0; i < result.length; i++) {
					var node = result[i];
					if (node.isRoot!= 1) {
						if (node.isMain== 1) {
							node.icon ="${ctx}/styles/default/images/icon/prodia_call_activity.png";
						} else {
							node.icon = "${ctx}/styles/default/images/icon/icon-remark15X15.gif";
						}
					}
				}
				tableTree = $.fn.zTree.init($("#tableTree"), setting,result);
				tableTree.expandAll(true);
				
			});
	}
	
	function zTreeOnCheck(event, treeId, treeNode){
		tableTree.checkNode(treeNode, '', false, true);
		$("#viewFrame").attr("src","${ctx}/platform/system/sysCodegen/detail.ht");
	}
	
</script>
<style type="text/css">
	.ztree {
		overflow: auto;
	}
	html {height: 100%}
	body {padding: 0px;margin: 0;overflow: auto;}
	#layout {width: 99.5%;margin: 0;padding: 0;overflow: auto;}
</style>
</head>
<body>
	<div id="layout" style="bottom: 1; top: 1">
		<div position="left" title="自定义表单管理" id="TreeManage"
			style=" height: 95%; width: 100% !important;">
			<div style="width: 100%;">
					<input type="text" name="subject" id="subject" style="width:75%;"><a class="link search" id="treeSearch">查询</a>
			</div>
			<div class="tree-toolbar" id="pToolbar">
				<div class="toolBar"
					style="text-overflow: ellipsis; white-space: nowrap">
					<div class="group">
						<a class="link reload" id="treeReFresh" ></a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link expand" id="treeExpand" ></a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group">
						<a class="link collapse" id="treeCollapse" ></a>
					</div>
					
				</div>
			</div>
			<ul id="tableTree" class="ztree" style="overflow:auto;height:80%" ></ul>
		</div>
		<div position="center" id="tableView" style="height: 100%;">
			<div class="l-layout-header" >代码配置</div>
			<iframe id="viewFrame" src="${ctx}/platform/system/sysCodegen/detail.ht" frameborder="0" width="100%"
				height="90%"></iframe>
		</div>
	</div>
</body>
</html>