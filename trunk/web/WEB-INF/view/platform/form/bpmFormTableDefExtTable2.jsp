<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
<title>添加外部表定义</title>
<%@include file="/commons/include/form.jsp" %>
<f:js pre="js/lang/view/platform/form" ></f:js>
<script type="text/javascript" src="${ctx}/js/deelon/platform/form/ColumnDialog.js"></script>
<script type="text/javascript" src="${ctx}/js/deelon/platform/form/EditTable.js"></script>
<script type="text/javascript" src="${ctx}/js/deelon/platform/form/FieldsManage.js"></script>
<script type="text/javascript" src="${ctx}/js/deelon/platform/form/FormTableDialog.js"></script>
<script type="text/javascript">
</script>
<style type="text/css">
	input.error {
	    border: 1px solid red;
	}
</style>
<script type="text/javascript">

	var tableId=${tableId};
	var canEditTbColName=${canEditTbColName};
	var hasForm=${hasForm};
	var dataSource="${dataSource}";
	var tableName="${tableName}";
	var allowEditTbColName=false;
	
	var validator;
	
	var fieldObj;
	
	var table=null;
	
	$(function(){
		
		fieldObj=new FieldsManage();
		
		TableRow.setFieldManage(fieldObj);
		
		TableRow.setAllowEditColName(false);
		
		
		
		TableRow.setIsExternal(1);
		//编辑
		if(tableId>0){
			
			$.get("getByTableId.ht",{tableId:tableId},function(data){
				table=data.table;
				if(table.isExternal==0){
					bindTable(data,canEditTbColName);
				}
				else{
					bindExtTable(data,hasForm);
				}
				
				
			});
		}else{//新增加
			$.get("getTableModel.ht",{dataSource:dataSource,tableName:tableName},function(data){
				bindExtTable(data);
				table=data.table;
			});
		}

		//行高亮
		$("#tableColumnItem").delegate("tbody>tr", "click", function() {
			$("#tableColumnItem>tbody>tr").removeClass("over");
			$(this).addClass("over");
		});
		//编辑列的详细信息
		$("#tableColumnItem").delegate("tbody>tr a[name='editColumn']", "click", function() {
			var trObj=$(this).parent().parent();
			var idx=$("#tableColumnItem>tbody>tr").index(trObj);
			var field=fieldObj.getFieldByIndex(idx);
			TableRow.editField(field.fieldName,$("input[name='isMain']:checked").val());
		});
		//处理选项选择。
		$("#tableColumnItem").delegate("tbody>tr input:checkbox", "click", function() {
			var chkObj=$(this);
			TableRow.editFieldOption(chkObj);
		});
		//处理点击列名和列注释。
		$("#tableColumnItem").delegate("tbody>tr>td[class='editField']", "click", function() {
			var tdObj=$(this);
			TableRow.editNameComment(tdObj);
		});
		
		//字段上移动
		$("#moveupField").click(function(){
			TableRow.move(true);
		});
		//字段下移
		$("#movedownField").click(function(){
			TableRow.move(false);
		});
		
		$("#delField").click(function(){
			TableRow.del();
		});
		
		validator=validTable();
		//处理字段保存
		handSave();
		
		handIsMain();
		
	});
	
	function handIsMain(){
		$("[name='isMain']").click(function(){
			var v=$(this).val();
			if(v==1){
				$("#trSubTable").hide();
			}
			else{
				$("#trSubTable").show();
			}
		});
	}
	
	/**
	 * 处理保存事件。
	 */
	function handSave(){
		$("#dataFormSave").click(function(){
			var rtn=validator.form();
			if(!rtn) return;
			var mainTableId=$("#mainTableId").val();
			var relation=$("#relation").val();
			var name=$("#name").val();
			var mainTableName=$("#mainTableName").val();
			
			
			var isMain=$("input:radio[name='isMain']:checked").val();
			if(isMain=="0" ){
				if(mainTableId=="0"){
					$.ligerDialog.warn("请选择从表!",'出错信息');
					return;
				}
				if(name==mainTableName){
					$.ligerDialog.warn("主表和子表名称不能相同!",'出错信息');
					return;
				}
			}
			
			var comment=$("#comment").val();
			var isMain=$("input:radio[name='isMain']:checked").val();
			var keyType=$('#keyType').val();
			var keyValue="";
			if(keyType==2) keyValue=$('#keyValue').val();
			var pkField=$('#pkField').val();
			
			var tableJson={tableName:name,tableDesc:comment,isMain:isMain,keyType:keyType,
					keyValue:keyValue,pkField:pkField,dsAlias:dataSource};
			if(isMain=="0"){
				tableJson.mainTableId=mainTableId;
				tableJson.relation=relation;
			}
			else{
				tableJson.mainTableId=0;
				tableJson.relation="";
			}
			tableJson.isExternal=1;
			table= $.extend({}, table, tableJson);
			var tableJson=JSON2.stringify(table);
			var fieldJson=JSON2.stringify(fieldObj.Fields);
			
			
			$.post("saveExtTable.ht",{table:tableJson,fields:fieldJson},showResponse);
		});
	}
	
	/**
	 * 显示返回结果。
	 */
	function showResponse(data){
		var obj=new com.deelon.form.ResultMessage(data);
		if(obj.isSuccess()){//成功
			$.ligerDialog.confirm('操作成功,继续操作吗?','提示信息',function(rtn){
				if(!rtn){
					var returnUrl=$("a.back").attr("href");
					location.href="list.ht";
				}
			});
	    }else{//失败
	    	$.ligerDialog.err('出错信息',"保存外部表定义失败",obj.getMessage());
	    }			
	}
	
	function changeKeyType(obj){
		var objTmp=$("#tdKeyValue");
		var display=(obj.value==2)?"":"none";
		objTmp.css("display",display);
	}
	
	function choosePublishMain(){
		var callBack=function(tableId,tableName){
			$("#mainTableId").val(tableId);
			$("#mainTableName").val(tableName);
		}
		FormTableDialog({callBack:callBack,isExternal:1});
	};
</script>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">
					添加外部表定义
				</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group">
						<a class="link save" id="dataFormSave" href="#"><span></span>保存</a>
					</div>
					<div class="l-bar-separator"></div>
					<div class="group"><a id="moveupField" class="link moveup"><span></span>上移</a></div>
						<div class="l-bar-separator"></div>
						<div class="group"><a id="movedownField" class="link movedown"><span></span>下移</a></div>
						<div class="l-bar-separator"></div>
						
					<div class="group">
						<a class="link back" href="list.ht"><span></span>返回</a>
					</div>
				</div>
			</div>
		</div>
		<div class="panel-body">
			<form id="bpmTableForm" method="post" action="add2.ht">
				<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<th width="7%">表名: </th>
						<td width="15%">
							<input  type="text" id="name" name="name" maxlength='25' class="inputText"/>
						</td>
						<th width="5%">注释: </th>
						<td width="15%">
							<input  type="text" id="comment" name="comment"  class="inputText"/>
						</td>
						<th width="10%">是否主表: </th>
						<td>
							<label><input  type="radio"  name="isMain"  value="1" checked="checked"/>主表</label>
							<label><input  type="radio"  name="isMain"  value="0" />从表</label>
						</td>
						<th width="10%">主键: </th>
						<td>
							<select id="pkField" name="pkField" ></select>
						</td>
						
					</tr>
					
					<tr id="trSubTable" style="height:30px;">
						<th>所属主表:</th>
						<td colspan="3">
							<input type="hidden" name="mainTableId" value="0" id="mainTableId"/>
							<input type="text" id="mainTableName" name="mainTableName" value="" readonly="readonly">
							<input type="button" value="选择已生成的主表" onclick="choosePublishMain()"/>
						</td>
						<th>外键字段:</th>
						<td colspan="3">
							<select id="relation" name="relation" ></select>
						</td>
					</tr>
				</table>
	
				<table id="tableColumnItem" class="table-grid table-list" id="0" cellpadding="1" cellspacing="1">
			   		<thead>
			   			<th width="20%">列名</th>
			   			<th width="20%">注释</th>
			    		<th width="10%">类型</th>
			    		<th width="10%">必填</th>
			    		<th width="8%">显示到列表</th>
			    		<th width="8%">是否流程变量</th>
			    		
			    		<th width="16%">管理</th>
			    	</thead>
			    	<tbody>
			    	</tbody>
		   	 </table>
			 
			</form>
		</div>
</div>
</body>
</html>
