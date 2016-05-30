<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" import="com.deelon.platform.model.system.Resources"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head> 
<%@include file="/commons/include/form.jsp" %> 
<script type="text/javascript">
	
	
	$(function(){
		
		//布局
		layout();
	});
	
	function layout(){
		$("#layout").ligerLayout( {
			leftWidth : 200,
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
			$.ligerMessageBox.warn("提示信息","请先选择站点!");
			return;
		}
		commonTree.loadTree();
		if(refFrame==true)$("#listFrame").attr("src","");
	}
	//展开收起
	function treeExpandAll(type){
		if(!commonTree){
			$.ligerMessageBox.warn("提示信息","请先选择站点!");
			return;
		}
		commonTree.treeExpandAll(type);
	};
	function entityClick(event, treeId, treeNode, clickFlag) {
		var siteConfigId="";
		if(treeNode!=null){
			siteConfigId=treeNode.siteConfigId;
		}else{
			siteConfigId="10000000160010";
		}
		commonTree = new com.deelon.form.commonTree({
			treeName:"menuTree",
			listFrame:"listFrame",
			treeNodeAttrName:"menuPath,menuUrl",
			addOrEditNodeUrl:"/cmsform/site/cmssitemenucontent/list.ht?siteConfigId="+siteConfigId,
			dataUrl:"/cmsform/site/cmssitemenu/getSiteMenuTree.ht?orderField=menu_sort&orderSeq=asc",
			param:{siteConfigId:siteConfigId},
			setting:{
				onRightClick:false,
				nameKey:"siteMenuId",					
				data: {
					simpleData : {enable : true,idKey:"siteMenuId",pIdKey:"menuSupId"},
					key: {name: "menuName"}
				},
				callback:{},
				view: {
					selectedMulti: false
				}
			}
		});
		 
	}	
	function addRootNode(menuSupId){
		if(!commonTree){
			$.ligerMessageBox.warn("提示信息","请先选择站点!");
			return;
		}
		commonTree.addOrEditNode(menuSupId);
	}
</script>
<style type="text/css">
.tree-title{overflow:hidden;}
.ztree{overflow: auto;}
</style>

</head>

<body style="overflow: hidden;" onload="entityClick();">

<div id="layout">
	<div position="left" title="站点名称" >
		<div style="width:100%;">
		 <input class="entityComBo" entityCode="CmsSiteConfig" entityFiledId="siteConfigId" entityFiledName="siteName" 
			 pIdKeyName="siteOrgId" valueField="siteConfigId" entityClick="entityClick" valueFieldVal="10000000160010" width="200" />
		</div>
		<div class="tree-toolbar tree-title" id="pToolbar">
			<span class="toolBar">
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

