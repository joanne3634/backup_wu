if (typeof FormDef == "undefined") {
	FormDef = {};
}
var editor;
FormDef.isSourceMode = false;
FormDef.getEditor = function(b) {
	var c = $(window).height(), a = $(window).width(), d = b.lang ? b.lang
			: "zh_cn";
	c = b.height ? (c - b.height) : c;
	a = b.width ? (a - b.width) : a;
	editor = new baidu.editor.ui.Editor({
		minFrameHeight : c,
		initialFrameWidth : a,
		lang : b.lang
	});
	editor.addListener("sourceModeChanged", function(f, e) {
		FormDef.isSourceMode = e;
	});
};
FormDef.openWin = function(h, c, i, a, f, e) {
	var d = ($(window).width() - c) / 2;
	var g = ($(window).height() - i) / 2;
	var b = {
		url : a,
		width : c,
		height : i,
		left : d,
		top : g,
		title : h,
		buttons : f,
		name : e
	};
	$.ligerDialog.open(b);
};
FormDef.getFieldsByTableId = function(tableId) {
	if ($("#colstree").length <= 0) {
		return;
	}
	var iconFolder = __ctx + "/styles/tree/";
	$.post("getAllFieldsByTableId.ht?tableId=" + tableId, function(data) {
		var json = eval("(" + data + ")"), treeData = [];
		$("#tableName").val(json.mainname);
		for (var i = 0, c; c = json.mainfields[i++];) {
			if (c.isHidden == 0) {
				c.tableId = json.mainid;
				c.name = c.fieldDesc;
				c.id = c.fieldId;
				c.pId = 0;
				c.icon = iconFolder + c.fieldType + ".png";
				treeData.push(c);
			}
		}
		for (var i = 0, c; c = json.subtables[i++];) {
			c.icon = iconFolder + "table.png";
			c.pId = 0;
			c.tableId = c.id;
			treeData.push(c);
			for (var j = 0, m; m = c.subfields[j++];) {
				m.tableId = c.id;
				m.pId = c.id;
				m.name = m.fieldDesc;
				m.icon = iconFolder + m.fieldType + ".png";
				treeData.push(m);
			}
		}
		var setting = {
			data : {
				key : {
					name : "name"
				},
				simpleData : {
					enable : true,
					idKey : "id",
					pIdKey : "pId",
					rootPId : 0
				}
			},
			callback : {
				beforeClick : function(treeId, treeNode, clickFlag) {
					FormDef.insertHtml(editor, treeNode);
					return false;
				}
			}
		};
		glTypeTree = $.fn.zTree.init($("#colstree"), setting, treeData);
	});
};
FormDef.genByTemplate = function(a, b) {
	$.post(__ctx + "/platform/form/bpmFormDef/genByTemplate.ht", {
		templateTableId : a,
		templateAlias : b
	}, function(c) {
		editor.setContent(c);
	});
};
var controls = {};
FormDef.insertHtml = function(b, c) {
	if (c.fieldType) {
		if (!controls[c.fieldName]) {
			var a = $("#templatesId").val();
			var d = FormDef.parseTemplateAlias(a, c.tableId);
			if (!$.isEmpty(d)) {
				FormDef.insert(b, c, d);
			} else {
				FormDef.selectTemplate(b, c);
			}
		} else {
			b.execCommand("inserthtml", controls[c.fieldName], 1);
		}
	} else {
		FormDef.selectSubTemplate(b, c);
	}
};
FormDef.insert = function(a, b, c) {
	$.post("getControls.ht", {
		templateAlias : c,
		tableId : b.tableId
	}, function(d) {
		if ($.isEmptyObject(d) || d.length == 0) {
			return FormDef.selectTemplate(a, b);
		}
		if ($.isEmpty(d)) {
			return FormDef.selectTemplate(a, b);
		}
		controls = d;
		a.execCommand("inserthtml", controls[b.fieldName], 1);
	});
};
FormDef.selectTemplate = function(a, b) {
	FormDef.showSelectTemplate("selectTemplate.ht?tableId=" + b.tableId
			+ "&isSimple=1", function(f, d) {
		var e = $(document.getElementById("selectTemplate").contentDocument);
		if ($.isIE() && (!e || e.length == 0)) {
			e = $(document.frames["selectTemplate"].document);
		}
		var c = FormDef.getTemplatesId(e);
		$("#templatesId").val(c);
		var g = FormDef.parseTemplateAlias(c, b.tableId);
		d.close();
		FormDef.insert(a, b, g);
	});
};
FormDef.selectSubTemplate = function(a, b) {
	FormDef.showSelectTemplate("selectTemplate.ht?tableId=" + b.tableId
			+ "&isSimple=1", function(e, c) {
		var d = $(document.getElementById("selectTemplate").contentDocument);
		if ($.isIE() && (!d || d.length == 0)) {
			d = $(document.frames["selectTemplate"].document);
		}
		var f = $('select[templateId="templateId"]', d).val();
		c.close();
		$.post("genByTemplate.ht", {
			templateTableId : b.tableId,
			templateAlias : f
		}, function(g) {
			a.execCommand("inserthtml", g, 1);
		});
	});
};
FormDef.parseTemplateAlias = function(a, f) {
	if ($.isEmpty(a)) {
		return "";
	}
	var d = a.split(";");
	for (var b = 0, g; g = d[b++];) {
		var e = g.split(",");
		if (e[0] == f) {
			return e[1];
		}
	}
};
FormDef.getTemplatesId = function(b) {
	var a = [];
	$("select[templateId='templateId']", b).each(function(d) {
		var e = $(this).attr("tableid"), c = $(this).val();
		a.push(e + "," + c);
	});
	return a.join(";");
};
FormDef.showSelectTemplate = function(a, d) {
	if (!d) {
		d = FormDef.onOk;
	}
	var b = [ {
		text : $lang.button.ok,
		onclick : d
	} ];
	var c = a + "&templatesId=" + $("#templatesId").val();
	FormDef.openWin($lang.button.selectTemplate, 550, 350, c, b,
			"selectTemplate");
};
FormDef.onOk = function(f, c) {
	var e = $(document.getElementById("selectTemplate").contentDocument);
	if ($.isIE() && (!e || e.length == 0)) {
		e = $(document.frames["selectTemplate"].document);
	}
	var b = [], d = [], a = [];
	$("select[templateId='templateId']", e).each(function(h) {
		var j = $(this).attr("tableid"), g = $(this).val();
		b.push(j);
		d.push(g);
		a.push(j + "," + g);
	});
	FormDef.genByTemplate(b.join(","), d.join(","));
	$("#templatesId").val(a.join(";"));
	c.close();
};
FormDef.showResponse = function(a) {
	var b = new com.deelon.form.ResultMessage(a);
	if (b.isSuccess()) {
		$.ligerDialog.success($lang.save.success, $lang.tip.msg, function() {
			window.onbeforeunload = null;
			if (window.opener) {
				if (window.opener.parent.reload) {
					window.opener.parent.reload();
				} else {
					if (window.opener.reload) {
						window.opener.reload();
					}
				}
			}
			window.close();
		});
	} else {
		$.ligerDialog.err($lang.tip.msg, b.getMessage());
	}
};