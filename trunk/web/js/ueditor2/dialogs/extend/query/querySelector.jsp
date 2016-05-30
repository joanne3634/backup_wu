<%@page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@include file="/commons/include/form.jsp"%>
<link rel="stylesheet" type="text/css" href="../input.css">
<script type="text/javascript" src="${ctx}/js/ueditor2/dialogs/internal.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.dragdiv.js"></script>
<link rel="stylesheet" href="${ctx}/js/jquery/plugins/jquery.dragdiv.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/js/tree/zTreeStyle.css" type="text/css" />
<script type="text/javascript" src="${ctx}/js/tree/jquery.ztree.js"></script>
<script type="text/javascript" src="${ctx}/js/util/json2.js"></script>
<style type="text/css">
.field-ul {
	width: 95%;
	height: 95%;
	margin: 0;
	padding: 0;
	overflow-y: auto;
	overflow-x: hidden;
}

.fields-div {
	float: left;
	border: 1px solid #828790;
	width: 160px;
	height: 260px;
	overflow: auto;
}

.domBtnDiv {
	display: block;
	margin-left: 5px;
	float: left;
	width: 380px;
	height: 260px;
	background-color: powderblue;
	overflow-y: auto;
	overflow-x: hidden;
}
</style>
<script type="text/javascript">
	var obj = $(editor.curInput);
	var curNode = obj;
	var parent = obj.parent();
	if(!curNode.is('select'))
		curNode=parent;
	var dragDiv;
	var nametemp;
	var setting = {
		edit : {
			enable : true,
			showRemoveBtn : false,
			showRenameBtn : false,
			drag : {}
		},
		data : {
			keep : {
				parent : true,
				leaf : true
			},
			simpleData : {
				enable : true
			}
		},
		view : {
			selectedMulti : false
		}
	};

	$(function() {
		$(".button-td").bind("mouseenter mouseleave", function() {
			$(this).toggleClass("button-td-hover");
		});
		getDialogs();
	});
	//编辑时绑定数据
	function bindData(dialogStr) {
		var dialogObj=dialogStr.replaceAll("'","\"");
		var dialog = $.parseJSON(dialogObj);
		if (!dialog)
			return;
		$("#dialog-type").find("option[value='" + dialog.query + "']").each(
				function() {
					$(this).attr("selected", "selected");
					dialogChange();
				});

		var searchObj=$("#search-again")
		if(dialog.search==1){
			searchObj.attr("checked","checked");
		}
		
		//是否是父节点
		var isparent=dialog.trigger
		if(isparent=='isparent'){
			$("#inputValue").attr("checked","checked");
			if(dialog.intvalue=="iSnull"){
				$("#initialvalue").val("");
			}else{
				$("#initialvalue").val(dialog.intvalue);
			}
			$("#trintValue").show();
			$("#trselValue").hide();
		}else{
			$("#inputSel").attr("checked","checked");
			$("#trintValue").hide();
			$("#trselValue").show();
		}
		
		var key = dialog.binding.key;
		var value = dialog.binding.value;

		var target = [ {
			id : 'key',
			value : key
		}, {
			id : 'value',
			value : value
		} ];
		for ( var i = 0, t; t = target[i++];) {
			var item = $("span.item-span[itemId='" + t.id + "']").toggleClass(
					"item-span item-span-Disabled");
			if (item.length > 0) {
				var node = {
					id : t.id,
					name : item.text()
				};
				addNode(t.value, node);
			}
		}

		setTimeout(function() {
			$("#condition-field").find(
					"option[value='" + dialog.condition + "']").attr(
					"selected", "selected");
			$("#bind-event").find("option[value='" + dialog.trigger + "']")
					.attr("selected", "selected");
		}, 10);
	};

	//添加树节点
	function addNode(id, node) {
		var zTree = $.fn.zTree.getZTreeObj('fields-tree');
		if (!zTree)
			return;
		var parentNode = zTree.getNodeByParam("id", id, null);
		if (parentNode)
			zTree.addNodes(parentNode, node);
	};

	//获取自定义查询
	function getDialogs() {
		var url = __ctx + '/platform/bpm/bpmFormQuery/getAllQueries.ht';
		$.get(url,function(data) {
							if (data) {
								for ( var i = 0, c; c = data[i++];) {
									var opt = $('<option value="'+c.alias+'" fields="'+c.returnFields+'" conditions="'+c.conditionFields+'" >'
											+ c.name + '</option>');
									opt.data("fields", c.resultfield);
									$("#dialog-type").append(opt);
								}
								getFileds(editor.tableId);
							}
						});

	};
	//选择不同的查询
	function dialogChange() {
		var condition_field = $("#condition-field");
		condition_field.empty();
		var dia = $("#dialog-type").find("option:selected");
		var v = dia.data("fields");
		var condStr = dia.attr("conditions");
		if (v) {
			var nodes = [];
			var fields = $.parseJSON(v);
			for ( var i = 0; i < fields.length; i++) {
				var f = fields[i];
				nodes.push({
					id : f.field,
					pid : 0,
					name : f.comment,
					isParent : true,
					open : true
				});
			}

			$("span.item-span-Disabled").each(function() {
				$(this).toggleClass("item-span-Disabled");
				$(this).toggleClass("item-span");
			});
			var tree = $.fn.zTree.init($("#fields-tree"), setting, nodes);
			//设置拖拽 树对象
			if (dragDiv)
				dragDiv.dragdiv('bind', 'fields-tree');
		}
		if (condStr) {
			var options = [];
			var fields = condStr.split(",");

			for ( var i = 0, c; c = fields[i++];) {
				if (c) {
					var option = $("<option/>").val(c).text(c);
					options.push(option);
				}
			}

			$(options).each(function() {
				condition_field.append($(this));
			});
		}

	}

	dialog.onok = function() {
		var query = $("#dialog-type").val();

		var bindingKey = '';
		var bindingValue = '';

		if (!query) {
			curNode.removeAttr("selectquery");
			return;
		};
		var condition = $("#condition-field").val();
		var trigger = "";

		
		var intvalue=$("#initialvalue").val();
		if(!intvalue)
			intvalue="iSnull";
		var checkValue=$("#inputValue:checked").val();
		if(checkValue){
			trigger="isparent";
		}else{
			trigger=$("#bind-event").val();
		}
		
		var zTree = $.fn.zTree.getZTreeObj("fields-tree"), nodes = zTree
				.getNodes();
		for ( var i = 0, c; c = nodes[i++];) {
			if (!c.children)
				continue;
			while (child = c.children.pop()) {
				if (child.id == 'key') {
					bindingKey = c.id;
				} else if (child.id == 'value') {
					bindingValue = c.id;
				}
			}
		};
		if (!bindingKey) {
			alert("请选择Key");
			return false;
		};
		if (!bindingValue) {
			alert("请选择值");
			return false;
		};
		var binding = {
			key : bindingKey,
			value : bindingValue
		}
		
		var search=$("#search-again:checked").val()?"1":"0";
		var json = {
			query : query,
			binding : binding,
			condition : condition,
			trigger : trigger,
			search:search,
			intvalue:intvalue
		};
		var queryString = JSON2.stringify(json).replaceAll("\"","'") ;
		//for ie6
		curNode.get(0).setAttribute("selectquery", queryString);
		curNode.get(0).setAttribute("cascadename", nametemp);
	};
	//初始化字段面板
	function initFieldsDiv(data) {
		var mainTable = data.table, data = {};
		var item = [];
		var name='m:';
		
		for ( var i = 0, c; c = mainTable.fieldList[i++];) {
			var type = c.controlType;
			if (type != null && type =='11') {
				
				item.push({
					name : c.fieldDesc,
					id : name+c.fieldName
				});
			}
		}
		
		for ( var i = 0, c; c = mainTable.subTableList[i++];) {
			var subname='s:'
			for ( var y = 0, t; t = c.fieldList[y++];) {
				var type = t.controlType
				if (type != null && type =='11') {
					item.push({
						name : t.fieldDesc,
						id : subname+t.fieldName
					});
				}
			}
		}

		if (item)
			for ( var i = 0, c; c = item[i++];) {
				var opt = $('<option value="'+c.id+'"  >' + c.name
						+ '</option>');
				$("#bind-event").append(opt);
			}

		var items = [ {
			name : '值',
			id : 'value'
		}, {
			name : 'key',
			id : 'key'
		} ];
		data.items = items;
		dragDiv = $(".domBtnDiv").dragdiv('init', {
			data : data
		});
		var dialogStr = curNode.get(0).getAttribute("selectquery");
		if (dialogStr) {
			bindData(dialogStr);
		}
	};

	//加载字段面板
	function getFileds(tableId) {
		if (tableId) {
			var chooseName=curNode.attr("name");
			var names=chooseName.split(":");
			nametemp=names[0]+":"+names[2];
			var url = __ctx
					+ '/platform/form/bpmFormTable/getTableById.ht?tableId='
					+ tableId + '&incHide=true';
			$.post(url, function(data) {
				initFieldsDiv(data);
			});
		} else { //编辑器设计表单时获取字段并验证字段
			
			var span=curNode.parents("span[external]");
			var external=$(span).attr("external");
				external = htmlDecode(external);
			var externalObj = eval("("+external+")");
				nametemp=externalObj["name"];
			
			//表明是主表还是子表
			var formtype=curNode.parents("tr[formtype]").attr("formtype");
			if(formtype){
				nametemp='s:'+nametemp;
			}else{
				nametemp='m:'+nametemp;
			}
			
			
			var html = editor.getContent();
			var params = {};
			params.html = html;
			params.formDefId = editor.formDefId;

			
			$.post(__ctx + '/platform/form/bpmFormDef/validDesign.ht', params,function(data) {
						if (data.valid) {
							initFieldsDiv(data);
						} else {
							alert(data.errorMsg);
						}
					});
		}
	};
	
	function onRadio(me){
		if($(me).attr('checked')=='checked'){
			$("#trintValue").show();
			$("#trselValue").hide();
		}
	};
	
	function onRadioed(me){
		if($(me).attr('checked')=='checked'){
			$("#trintValue").hide();
			$("#trselValue").show();
		}
	};
	//解码单引号和双引号
	function htmlDecode(str){
		return str.replace(/\&quot\;/g, '\"').replace(/\&\#39\;/g, '\'');
	};
</script>
</head>
<body>
	<div id="inputPanel">
		<fieldset class="base">
			<legend>
				<var id="lang_search_setting"></var>
			</legend>
			<table >
				<tr>
					<th><var id="lang_choose_search"></var>:</th>
					<td><select id="dialog-type" onchange="dialogChange()">
							<option value="0"></option>
					</select></td>
				</tr>
				<tr>
					<th><var id="lang_condition_field"></var>:</th>
					<td><select id="condition-field">
					</select></td>
				</tr>
				<tr>
					<th><var id="lang_parent_type"></var>:</th>
					<td >
						<input type="radio" id="inputValue" name="rdoInputType" value="1" checked="checked" onclick="onRadio(this);" />固定值输入
						<input type="radio" id="inputSel"  name="rdoInputType" value="2" onclick="onRadioed(this);" />下拉框输入
					</td>
				</tr>
				<tr id="trintValue" >
					<th><var id="lang_parent_value"></var>:</th>
					<td><input type="text" id="initialvalue" name="initialvalue"  style="width: 200px;" value="">
						</td>
				</tr>
				<tr id="trselValue" style="display:none;">
					<th><var id="lang_trigger_event"></var>:</th>
					<td><select id="bind-event">
					</select></td>
				</tr>
				<tr>
					<td><var id="lang_search_again"></var>:</td>
					<td><input id="search-again" type="checkbox"  checked="checked"></td>
				</tr>
			</table>
		</fieldset>
		<fieldset class="base">
			<legend>
				<var id="lang_return_setting"></var>
			</legend>
			<div class="fields-div">
				<ul id="fields-tree" class="ztree field-ul"></ul>
			</div>
			<div class="domBtnDiv"></div>
		</fieldset>
	</div>


</body>
</html>