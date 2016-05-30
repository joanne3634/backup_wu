<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" import="com.deelon.platform.model.system.Resources"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>区域管理</title>
<%@include file="/commons/include/form.jsp" %> 
<script type="text/javascript">
	
	
	$(function(){
		
		//布局
		layout();
	});
	
	function layout(){
		$("#layout").ligerLayout( {
			leftWidth : 270,
			onHeightChanged: function(options){
				$("#menuTree").height(options.middleHeight - 90);
			},
			allowLeftResize:false
		});
		//取得layout的高度
        var height = $(".l-layout-center").height();
        $("#menuTree").height(height-90);
	};
	
	var commonTree;	
	function reFresh(refFrame){
		if(!commonTree){
			$.ligerMessageBox.warn("提示信息","请先选择区域!");
			return;
		}
		commonTree.loadTree();
		if(refFrame==true)$("#listFrame").attr("src","");
	}
	//展开收起
	function treeExpandAll(type){
		if(!commonTree){
			$.ligerMessageBox.warn("提示信息","请先选择区域!");
			return;
		}
		commonTree.treeExpandAll(type);
	};
	function entityClick(event, treeId, treeNode, clickFlag) {
		var parentId="";
		var areaId="";
		if(treeNode!=null){
		alert(treeNode.siteConfigId);
			parentId=treeNode.siteConfigId;
			areaId=treeNode.areaId;
		}else{
			parentId="1";
			areaId="11";
		}
		commonTree = new com.deelon.form.commonTree({
			treeName:"menuTree",
			listFrame:"listFrame",
			addOrEditNodeUrl:"/loan/backstage/tarea/list.ht?areaId="+parentId,
			delNodeUrl:"/loan/backstage/tarea/del.ht",
			dataUrl:"/loan/backstage/tarea/getTareaMenuTree.ht?orderField=menu_sort&orderSeq=asc",
			param:{parentId:parentId},
			setting:{
				nameKey:"parentId",					
				data: {
					simpleData : {enable : true,idKey:"areaId",pIdKey:"parentId"},
					key: {name: "areaName",nameArr:""}
				},
				callback:{},
				view: {
					selectedMulti: false
				}
			}
		}); 
	}	
	function addRootNode(parentId){
		if(!commonTree){
			$.ligerMessageBox.warn("提示信息","请先选择站点!");
			return;
		}
		commonTree.addOrEditNode(parentId);
	}
</script>
<style type="text/css">
.tree-title{overflow:hidden;}
.ztree{overflow: auto;}
</style>

</head>

<body style="overflow: hidden;" onload="entityClick();">

<div id="layout">
	<<div position="left" title="站点名称" >
		<div style="width:100%;">
		 <input class="entityComBo" entityCode="CmsSiteConfig" entityFiledId="siteConfigId" entityFiledName="siteName" 
			 pIdKeyName="siteOrgId" valueField="siteConfigId" entityClick="entityClick" valueFieldVal="10000000160010" width="270" />
		</div>
		<div class="tree-toolbar tree-title" id="pToolbar">
			<span class="toolBar">
				<div class="group"><a class="link add" id="treeFresh" href="javascript:addRootNode(0);">增加顶级</a></div>
				<div class="l-bar-separator"></div>
				<div class="group"><a class="link reload" id="treeFresh" href="javascript:reFresh();">刷新</a></div>
				<div class="l-bar-separator"></div>
				<div class="group"><a class="link expand" id="treeExpandAll" href="javascript:treeExpandAll(true)">展开</a></div>
				<div class="l-bar-separator"></div>
				<div class="group"><a class="link collapse" id="treeCollapseAll" href="javascript:treeExpandAll(false)">收起</a></div>
			</span>
		</div>
		<div id="menuTree" class="ztree"></div>
		
	</div>
    
	<div position="center">
		<iframe id="listFrame" src="" frameborder="no" width="100%" height="100%"></iframe>
	</div>
</div>
</body>
</html>

