var clearSelection = function() {
	if (document.selection && document.selection.empty) {
		document.selection.empty();
	} else {
		if (window.getSelection) {
			var a = window.getSelection();
			a.removeAllRanges();
		}
	}
};
function switchConditionType(a) {
	if (a == 1) {
		$(".condition-conds-build").show();
		$(".condition-conds-script").hide();
		$(
				"#condition-columnsTbl th:nth-child(1),#condition-columnsTbl td:nth-child(1)")
				.show();
		$("#condition-columnsTbl tbody tr").unbind("dblclick");
		$("#condition-columnsTbl tbody tr").qtip("destroy");
	} else {
		$(".condition-conds-build").hide();
		$(".condition-conds-script").show();
		$(
				"#condition-columnsTbl th:nth-child(1),#condition-columnsTbl td:nth-child(1)")
				.hide();
		$("#condition-columnsTbl tbody tr").dblclick(function() {
			var b = $(this).find("[name='naTd']").text();
			var c = conditonScriptEditor.getCursor();
			conditonScriptEditor.replaceRange(b, c);
		});
		if (conditonScriptEditor) {
			setTimeout(function() {
				conditonScriptEditor.refresh();
			}, 0);
		}
		$("#condition-columnsTbl tbody tr").qtip({
			content : "双击插入到脚本中",
			position : {
				target : "mouse",
				viewport : $(window),
				adjust : {
					x : 10,
					y : 10
				}
			}
		});
	}
}
function selectTr() {
	$("tr.odd,tr.even").each(function() {
		$(this).bind("mousedown", function(b) {
			if (b.target.tagName == "TD") {
				var a = 'input:checkbox[class="pk"],input:radio[class="pk"]';
				var d = $(this).find(a);
				if (d.length == 1) {
					var c = d.attr("checked");
					d.attr("checked", !c);
				}
			}
		});
	});
}
function validate() {
	var a = tabcomp.getSelectedTabItemID();
	var b = validateBaseSetting();
	if (b.status != 0) {
		if (a != "baseSetting") {
			pgmswitchta = true;
			tabcomp.selectTabItem("baseSetting");
		}
		if (b.message) {
			$.ligerDialog.error(b.message, "Error");
		}
		return false;
	}
	b = validateDisplaySetting();
	if (b.status != 0) {
		if (a != "displaySetting") {
			pgmswitchta = true;
			tabcomp.selectTabItem("displaySetting");
		}
		if (b.message) {
			$.ligerDialog.error(b.message, "Error");
		}
		return false;
	}
	var b = validateParameterSetting();
	if (b.status != 0) {
		if (a != "parameterSetting") {
			pgmswitchta = true;
			tabcomp.selectTabItem("parameterSetting");
		}
		if (b.message) {
			$.ligerDialog.error(b.message, "Error");
		}
		return false;
	}
	b = validateConditionSetting();
	if (b.status != 0) {
		if (a != "conditionSetting") {
			pgmswitchta = true;
			tabcomp.selectTabItem("conditionSetting");
		}
		if (b.message) {
			$.ligerDialog.error(b.message, "Error");
		}
		return false;
	}
	return true;
}
function validateBaseSetting() {
	var b = {
		status : 0,
		message : ""
	};
	var d = $("#sysTableManageForm").form();
	if (!d.valid()) {
		b.status = 1;
		return b;
	}
	var a = $("#dsAlias").val();
	if (!a) {
		b.status = 2;
		b.message = "请选择数据源！";
		return b;
	}
	var c = $("#objName").val();
	if (!c) {
		b.status = 3;
		b.message = "请选择表/视图！";
		return b;
	}
	var c = $("#templateId").val();
	if (!c) {
		b.status = 4;
		b.message = "请选择数据模板！";
		return b;
	}
	return b;
}
function validateDisplaySetting() {
	var a = {
		status : 0,
		message : ""
	};
	var b = $("#columnsTbl tbody [name='ds']:checked").length;
	if (b < 1) {
		a.status = 1;
		a.message = "请选择显示字段！";
	}
	return a;
}
function validateParameterSetting() {
	var b = {
		status : 0,
		message : ""
	};
	var a = [];
	var c = 0;
	var d;
	$("#parameters-table tbody tr").each(function() {
		var j = $(this);
		var h = j.find("[name='na']").val();
		var f = j.find("[name='cm']").val() || f;
		var e = j.find("[name='ty']").val();
		var g = j.find("[name='vf']").val();
		var i = j.find("[name='va']").val();
		if (!/^[a-zA-Z_]{1}[\w\d_]*$/.test(h)) {
			b.status = 1;
			b.message = "变量名称必须由字母、下划线和数字组成，并由字母或下划线开头！";
			return false;
		}
		if ($.inArray(h, a) != -1) {
			b.status = 2;
			b.message = "变量名称不能重复！";
			return false;
		}
		a.push(h);
		if (g != 4 && g != 1) {
			if (!i) {
				b.status = 3;
				b.message = "变量[" + h + "<" + f + ">]的值不能为空！";
				return false;
			}
		}
	});
	return b;
}
function validateConditionSetting() {
	var a = {
		status : 0,
		message : ""
	};
	var b = $("[name=conditionType]").val();
	if (b == 2) {
		return a;
	}
	$("#conditionTbl tbody tr").each(function() {
		var f = $(this);
		var g = $.parseJSON(f.find("input[type='hidden']").val());
		var d = f.find("[name='vf']").val();
		var c = f.find("[name='cm']").val();
		var e = f.find("[name='va']").val();
		if (d != 1) {
			if (!e) {
				a.status = 1;
				a.message = "条件[" + g.na + "<" + c + ">]的值不能为空！";
				return false;
			}
		}
	});
	return a;
}
function customFormSubmit(c) {
	var k = $("#id").val();
	var u = $("#name").val();
	var j = $("#alias").val();
	var h = $("input[name='needPage']:checked").val();
	var s = $("#pageSize").val();
	var t = $("#isTable").val();
	var g = $("#objName").val();
	var q = $("#displayField").val();
	var e = $("#conditionField").val();
	var f = $("#dsName").val();
	var a = $("#dsAlias").val();
	var l = "";
	var n = $("input[name='editable']:checked").val();
	var m = $("input[name='conditionType']:checked").val();
	var d = $("#parameters").val();
	var o = $("#templateId").val();
	var r = {
		id : k,
		name : u,
		alias : j,
		needPage : h,
		pageSize : s,
		isTable : t,
		objName : g,
		displayField : q,
		conditionField : e,
		dsName : f,
		dsAlias : a,
		dspTemplate : l,
		editable : n,
		conditionType : m,
		parameters : d,
		templateId : o
	};
	var b = $('<form method="post" action="save.ht"></form>');
	var i = $("<input type='hidden' name='json'/>");
	i.val(JSON2.stringify(r));
	b.append(i);
	b.ajaxForm(c);
	b.submit();
}
function selectTable() {
	var e = $("#dsAlias").val();
	if (typeof (e) == "undefine" || e == "") {
		$.ligerDialog.warn("请选择数据源！", "提示信息");
		return false;
	}
	var c = __ctx + "/platform/system/sysTableManage/selectTable.ht?dsName="
			+ e;
	var b = "dialogWidth=800px;dialogHeight=600px;help=0;status=0;scroll=1;center=1;resizable=1;";
	c = c.getNewUrl();
	var d = window.showModalDialog(c, {}, b);
	if (d) {
		$("#objName").val(d.tableName);
		$("#isTable").val(d.tableType == "table" ? 1 : 0);
		resetParameterSetting();
		var a = getTableColumns(e, d.tableName, d.tableType);
		initSetting({
			fields : a
		});
	}
}
function getTableColumns(f, a, d) {
	var e = {
		dsName : f,
		tableName : a,
		tableType : d
	};
	var c;
	var b = __ctx + "/platform/system/sysTableManage/getTableColumns.ht";
	$.ajax({
		url : b,
		data : e,
		async : false
	}).done(function(g) {
		c = g.columns;
	});
	return c;
}
function initSetting(c, d) {
	var a = c.fields;
	var b = c.conds;
	var e = c.params;
	initColumns(a);
	initConditionSelCols(a);
	$("#conditionTbl tbody").html("");
	if (e) {
		initParameters(e);
	}
	if (b) {
		if (d == 1) {
			initConditionFields(b);
		}
	}
	jQuery.highlightTableRows();
	selectTr();
}
function switchNeedPage() {
	var a = $("input:radio[name='needPage']:checked").val();
	if (a > 0) {
		$("#spanPageSize").show();
	} else {
		$("#spanPageSize").hide();
	}
}
function selectCondition() {
	var a = $("input[name='conditionType']:checked").val();
	$("#condition-columnsTbl input:[name='select']:checked").each(
			function() {
				var f = $.parseJSON($(this).closest("tr").find(
						"input[type='hidden']").val());
				var d = f.na;
				var c = f.ty;
				var b = f.cm;
				var g = {
					jt : "AND",
					na : d,
					ty : c,
					op : "=",
					cm : b,
					va : "",
					vf : 2
				};
				var e = constructConditionTr(g);
				$("#conditionTbl tbody").append(e);
			});
}
function showResponse(a) {
	alert(a);
	var b = new com.deelon.form.ResultMessage(a);
	if (b.isSuccess()) {
		$.ligerDialog.confirm(b.getMessage() + ",是否继续操作", "提示信息", function(c) {
			if (c) {
				this.close();
			} else {
				window.location.href = __ctx
						+ "/platform/system/sysTableManage/list.ht";
			}
		});
	} else {
		$.ligerDialog.error(b.getMessage(), "提示信息");
	}
}
function dsAliasOnChangeHandler(b) {
	$("#dsName").val("");
	var a = $(b).val();
	if (a) {
		var c = $("#dsAlias option[value='" + a + "']").text();
		$("#dsName").val(c);
	}
	resetSelectTable();
}
function resetSelectTable() {
	$("#objName").val("");
	$("#isTable").val("");
	resetParameterSetting();
}
function resetParameterSetting() {
	$("#conditionTbl tbody").html("");
	$("#columnsTbl tbody").html("");
}
function initConditionFields(e) {
	$("#conditionTbl tbody").html("");
	for (var d = 0; d < e.length; d++) {
		var l = e[d];
		var a = l.jt;
		var h = l.na;
		var c = l.ty;
		var m = l.cm;
		var g = l.op;
		var f = l.vf;
		var k = l.va;
		var b = {
			jt : a,
			na : h,
			ty : c,
			cm : m,
			op : g,
			vf : f,
			va : k
		};
		var j = constructConditionTr(b);
		$("#conditionTbl tbody").append(j);
	}
}
function constructConditionTr(w) {
	var r = w.jt;
	var y = w.ty;
	var j = w.na;
	var h = w.cm;
	var k = w.op;
	var b = w.va;
	var C = w.vf;
	var v = function(i, a, E) {
		if (!E) {
			E = a;
		}
		var D = constructTag("option", {
			value : a
		}, E);
		if (i == a) {
			D.attr("selected", "selected");
		}
		return D;
	};
	var l = constructTag("td");
	var B = constructTag("select", {
		name : "jt"
	});
	B.append(v(r, "AND"));
	B.append(v(r, "OR"));
	l.append(B);
	var t = constructTag("input", {
		type : "hidden",
		value : JSON2.stringify(w)
	});
	l.append(t);
	var o = constructTag("td", {}, j);
	var A = constructTag("td");
	var f = constructTag("select", {
		name : "op",
		style : "width:70px;"
	});
	switch (y) {
	case "varchar":
		f.append(v(k, "="));
		f.append(v(k, "likeEnd"));
		f.append(v(k, "like"));
		break;
	case "number":
		f.append(v(k, "="));
		f.append(v(k, ">"));
		f.append(v(k, "<"));
		f.append(v(k, ">="));
		f.append(v(k, "<="));
		break;
	case "int":
		f.append(v(k, "="));
		f.append(v(k, ">"));
		f.append(v(k, "<"));
		f.append(v(k, ">="));
		f.append(v(k, "<="));
		break;
	default:
		f.append(v(k, "="));
		f.append(v(k, ">="));
		f.append(v(k, "<="));
		f.append(v(k, "between"));
	}
	A.append(f);
	var q = constructTag("td");
	var d = constructTag("input", {
		name : "cm",
		value : h,
		type : "text",
		"class" : "inputText"
	});
	q.append(d);
	var n = constructTag("td");
	var x = constructTag("select", {
		name : "vf",
		onchange : "selectValueFrom(this)"
	});
	x.append(v(C, 2, "固定值"));
	x.append(v(C, 3, "脚本"));
	x.append(v(C, 4, "变量"));
	n.append(x);
	var s = constructTag("td");
	var z = constructTag("a", {
		href : "#",
		name : "btnScript",
		"class" : "hide link var",
		title : "常用脚本",
		onclick : "selectScript(this)"
	}, "常用脚本");
	var m;
	if (C == 1) {
		m = constructTag("input", {
			name : "va",
			type : "text",
			"class" : "hide",
			readonly : "readonly"
		});
	} else {
		if (C == 2) {
			m = constructTag("input", {
				name : "va",
				type : "text"
			});
		} else {
			if (C == 3) {
				z.show();
				m = constructTag("textarea", {
					name : "va"
				});
			} else {
				m = constructTag("select", {
					name : "va"
				});
				var g = getParameters();
				for (var u = 0; u < g.length; u++) {
					p = g[u];
					m.append(constructTag("option", {
						value : p.na
					}, p.cm + "(" + p.na + ")"));
				}
			}
		}
	}
	m.val(b);
	s.append(z);
	s.append(m);
	var c = constructTag("td");
	var e = constructTag("a", {
		href : "#",
		"class" : "link del",
		onclick : "delConditionTr(this)"
	}, "删除");
	c.append(e);
	tr = constructTag("tr");
	tr.append(l);
	tr.append(o);
	tr.append(A);
	tr.append(q);
	tr.append(n);
	tr.append(s);
	tr.append(c);
	return tr;
}
function initColumns(a) {
	var b = $("#columnsTbl tbody").html("");
	for (var c = 0; c < a.length; c++) {
		var e = a[c];
		var d = constructColumnTr(e);
		if (c % 2 == 0) {
			d.addClass("even");
		} else {
			d.addClass("odd");
		}
		b.append(d);
	}
}
function initConditionSelCols(a) {
	var b = $("#condition-columnsTbl tbody").html("");
	for (var c = 0; c < a.length; c++) {
		var e = a[c];
		var d = constructConditionSelColTr(e);
		if (c % 2 == 0) {
			d.addClass("even");
		} else {
			d.addClass("odd");
		}
		b.append(d);
	}
}
function constructColumnTr(k) {
	var g = k.ty;
	var h = k.na;
	var l = k.cm || h;
	var a = false;
	if (typeof (k.ds) != "undefined") {
		a = k.ds;
	}
	var d = constructTag("td", {}, h);
	var f = constructTag("input", {
		type : "hidden"
	});
	f.val(JSON2.stringify(k));
	d.append(f);
	var b = constructTag("td", {}, (g || "").toUpperCase());
	var j = constructTag("td");
	var c = constructTag("input", {
		name : "cm",
		value : l,
		"class" : "inputText"
	});
	j.append(c);
	var e = constructTag("td");
	var m = constructTag("input", {
		name : "ds",
		type : "checkbox",
		"class" : "pk"
	});
	if (a) {
		m.attr("checked", "checked");
	}
	e.append(m);
	var i = constructTag("tr");
	i.append(e);
	i.append(d);
	i.append(b);
	i.append(j);
	return i;
}
function constructConditionSelColTr(h) {
	var e = h.ty;
	var f = h.na;
	var i = h.cm || f;
	var d = constructTag("td");
	var j = constructTag("input", {
		name : "select",
		type : "checkbox",
		"class" : "pk"
	});
	d.append(j);
	var b = constructTag("td", {
		name : "naTd"
	}, f);
	var c = constructTag("input", {
		type : "hidden"
	});
	c.val(JSON2.stringify(h));
	b.append(c);
	var a = constructTag("td", {}, (e || "").toUpperCase());
	var g = constructTag("tr");
	g.append(d);
	g.append(b);
	g.append(a);
	return g;
}
function delConditionTr(a) {
	$(a).closest("tr").remove();
}
function getParameterSetting() {
	var a = {
		fieldSetting : new Array(),
		conditionField : new Array(),
		parameters : new Array()
	};
	a.fieldSetting = getFields();
	var c = getConditions();
	a.conditionField = c;
	var b = getParameters();
	a.parameters = b;
	return a;
}
function getFields() {
	var a = [];
	$("#columnsTbl tbody tr").each(function() {
		var e = $(this);
		var c = $.parseJSON(e.find("input:[type='hidden']").val());
		var b = e.find("[name='cm']").val();
		var d = e.find("[name='ds']").is(":checked");
		c.cm = b;
		c.ds = d;
		a.push(c);
	});
	return a;
}
function getConditions() {
	var c = new Array();
	var a = $("input[name='conditionType']:checked").val();
	if (a == 1) {
		$("#conditionTbl tbody tr").each(function() {
			var h = $(this);
			var i = $.parseJSON(h.find("input[type='hidden']").val());
			var g = h.find("[name='jt']").val();
			var j = h.find("[name='op']").val();
			var e = parseInt(h.find("[name='vf']").val());
			var f = h.find("[name='va']").val();
			var d = h.find("[name='cm']").val();
			i.jt = g;
			i.op = j;
			i.vf = e;
			i.va = f;
			i.cm = d;
			c.push(i);
		});
		return c;
	} else {
		var b = $("#conditionScript").val();
		return b;
	}
}
function getParameters() {
	var a = [];
	$("#parameters-table tbody tr").each(function() {
		var g = $(this);
		var e = g.find("[name='na']").val();
		var c = g.find("[name='cm']").val() || e;
		var b = g.find("[name='ty']").val();
		var d = g.find("[name='vf']").val();
		var f = g.find("[name='va']").val();
		var h = {
			na : e,
			cm : c,
			ty : b,
			vf : d,
			va : f
		};
		a.push(h);
	});
	return a;
}
function selectValueFrom(h) {
	var f = $(h).closest("tr");
	var c = f.find("a:[name='btnScript']");
	c.hide();
	var b = $(h).val();
	var g;
	if (b == 1) {
		g = constructTag("input", {
			name : "a",
			type : "text",
			"class" : "hide",
			readonly : "readonly"
		});
	} else {
		if (b == 2) {
			g = constructTag("input", {
				name : "va",
				type : "text"
			});
		} else {
			if (b == 3) {
				c.show();
				g = constructTag("textarea", {
					name : "va"
				});
			} else {
				g = constructTag("select", {
					name : "va"
				});
				var e = getParameters();
				for (var d = 0; d < e.length; d++) {
					p = e[d];
					g.append(constructTag("option", {
						value : p.na
					}, p.cm + "(" + p.na + ")"));
				}
			}
		}
	}
	f.find("[name='va']").replaceWith(g);
}
function selectScript(b) {
	var a = $(b);
	var c = a.next()[0];
	ScriptDialog({
		callback : function(d) {
			$.insertText(c, d);
		}
	});
}
function addParameter() {
	var b = {
		na : "",
		cm : "",
		ty : "varchar",
		vf : 1,
		va : ""
	};
	var a = constructParameterTr(b);
	$("#parameters-table").append(a);
}
function constructParameterTr(h) {
	var k = h.na;
	var j = h.cm;
	var s = h.ty;
	var v = h.vf;
	var b = h.va;
	var r = function(x, w, z) {
		if (!z) {
			z = w;
		}
		var y = constructTag("option", {
			value : w
		}, z);
		if (x == w) {
			y.attr("selected", "selected");
		}
		return y;
	};
	var a = constructTag("tr");
	var t = constructTag("td");
	var l = constructTag("input", {
		name : "na",
		type : "text",
		"class" : "inputText",
		value : k
	});
	t.append(l);
	var o = constructTag("td");
	var f = constructTag("input", {
		name : "cm",
		type : "text",
		"class" : "inputText",
		value : j
	});
	o.append(f);
	var u = constructTag("td");
	var d = constructTag("select", {
		name : "ty"
	});
	d.append(r(s, "S", "字符类型"));
	d.append(r(s, "L", "整数类型"));
	d.append(r(s, "DB", "数字类型"));
	d.append(r(s, "DL", "日期类型"));
	u.append(d);
	var n = constructTag("td");
	var g = constructTag("select", {
		name : "vf",
		onchange : "paramValueFromChange(this)"
	});
	g.append(r(v, 1, "输入"));
	g.append(r(v, 2, "固定值"));
	g.append(r(v, 3, "脚本"));
	n.append(g);
	var c = constructTag("td");
	var q = $("<a style='display:none;' href='#' name='btnScript' class='link var' title='常用脚本' onclick='selectScript(this)'>常用脚本</a>");
	var m;
	if (v == 1) {
		m = constructTag("input", {
			name : "va",
			type : "text",
			value : b,
			readonly : "readonly"
		});
		m.hide();
	} else {
		if (v == 2) {
			m = constructTag("input", {
				name : "va",
				type : "text",
				value : b,
				style : "width:96%"
			});
		} else {
			q.show();
			m = constructTag("textarea", {
				name : "va",
				value : b,
				style : "width:96%"
			});
		}
	}
	c.append(q);
	c.append(m);
	var e = constructTag("td");
	var i = constructTag("a", {
		onclick : "delConditionTr(this)",
		href : "#",
		"class" : "link del"
	}, "删除");
	e.append(i);
	a.append(t);
	a.append(o);
	a.append(u);
	a.append(n);
	a.append(c);
	a.append(e);
	return a;
}
function paramValueFromChange(d) {
	var b = $(d).closest("tr");
	var e = b.find("a:[name='btnScript']");
	e.hide();
	var a = $(d).val();
	var c;
	if (a == 1) {
		c = constructTag("input", {
			name : "va",
			type : "text",
			readonly : "readonly"
		});
		c.hide();
	} else {
		if (a == 2) {
			c = constructTag("input", {
				name : "va",
				type : "text",
				style : "width:96%"
			});
		} else {
			e.show();
			c = constructTag("textarea", {
				name : "va",
				style : "width:96%"
			});
		}
	}
	b.find("[name='va']").replaceWith(c);
}
function constructTag(b, d, e) {
	var a = $("<" + b + "></" + b + ">");
	if (d) {
		for ( var c in d) {
			a.attr(c, d[c]);
		}
	}
	if (e) {
		a.text(e);
	}
	return a;
}
function onBeforeSelectTabItem(f) {
	if (pgmswitchta) {
		pgmswitchta = false;
		return true;
	}
	var a = tabcomp.getSelectedTabItemID();
	if (f == "baseSetting") {
		return true;
	} else {
		if (f == "displaySetting") {
			var e = validateBaseSetting();
			if (e.status != 0) {
				if (a != "baseSetting") {
					pgmswitchta = true;
					tabcomp.selectTabItem("baseSetting");
				}
				if (e.message) {
					$.ligerDialog.error(e.message, "Error");
				}
				return false;
			}
		} else {
			if (f == "parameterSetting") {
				return true;
			} else {
				if (f == "conditionSetting") {
					setTimeout(function() {
						conditonScriptEditor.refresh();
					}, 0);
					var e = validateBaseSetting();
					if (e.status != 0) {
						if (a != "baseSetting") {
							pgmswitchta = true;
							tabcomp.selectTabItem("baseSetting");
						}
						if (e.message) {
							$.ligerDialog.error(e.message, "Error");
						}
						return false;
					}
					e = validateParameterSetting();
					if (a != "parameterSetting") {
						pgmswitchta = true;
						tabcomp.selectTabItem("parameterSetting");
					}
					if (e.status != 0) {
						if (e.message) {
							$.ligerDialog.error(e.message, "Error");
						}
						return false;
					}
					var d = getParameters();
					var c = constructTag("select", {
						name : "va"
					});
					for (var b = 0; b < d.length; b++) {
						p = d[b];
						c.append(constructTag("option", {
							value : p.na
						}, p.cm + "(" + p.na + ")"));
					}
					$("#conditionTbl tbody select[name='vf']:[value='4']")
							.each(function() {
								var i = $(this).closest("tr");
								var g = i.find("[name='va']");
								var h = g.val();
								c.val(h);
								g.replaceWith(c);
							});
					initConditionSelParams();
				}
			}
		}
	}
	return true;
}
function selectAll(a) {
	if ($(a).attr("checked")) {
		$(a).closest("table").find("[name='ds']").each(function() {
			$(this).attr("checked", "checked");
		});
	} else {
		$(a).closest("table").find("[name='ds']").each(function() {
			$(this).removeAttr("checked");
		});
	}
}
function initParameters(c) {
	for (var a = 0; a < c.length; a++) {
		var d = c[a];
		var b = constructParameterTr(d);
		$("#parameters-table tbody").append(b);
	}
}
function helpInfoShow(c, b) {
	var a = $("#" + b).html();
	$.ligerDialog.open({
		content : a,
		width : 500,
		height : 400,
		modal : false,
		showMin : false
	});
}
function initConditionSelParams() {
	var g = getParameters();
	var d = $("#condition-script-div-parameters-list");
	d.html("");
	for (var c = 0; c < g.length; c++) {
		p = g[c];
		var b = constructTag("a", {
			name : p.na,
			"class" : "button",
			style : "margin:5px 10px",
			href : "#",
			onclick : "insertParameterToScript(this)"
		});
		var f = "" + "<table class='table-detail'>" + "<tr>"
				+ "<th colspan='2'><span class='green'>点击插入到脚本中</span></th>"
				+ "</tr>" + "<tr>" + "<th>名称</th>" + "<td>" + p.na + "</td>"
				+ "</tr>" + "<tr>" + "<th>注释</th>" + "<td>" + p.cm + "</td>"
				+ "</tr>" + "<tr>" + "<th>类型</th>" + "<td>" + getType(p.ty)
				+ "</td>" + "</tr>" + "</table>";
		b.qtip({
			content : f
		});
		var e = constructTag("span", {}, p.cm);
		b.append(e);
		d.append(b);
	}
}
function insertParameterToScript(a) {
	var b = $(a).attr("name");
	var c = conditonScriptEditor.getCursor();
	conditonScriptEditor.replaceRange(b, c);
}
function getType(b) {
	var a = b;
	switch (b) {
	case "S":
		a = "String";
		break;
	case "L":
		a = "Long";
		break;
	case "N":
		a = "Integer";
		break;
	case "DB":
		a = "Double";
		break;
	case "BD":
		a = "BigDecimal";
		break;
	case "FT":
		a = "Float";
		break;
	case "SN":
		a = "Short";
		break;
	case "DL":
		a = "Date";
		break;
	}
	return a;
}
function validateConditionScript(d) {
	var a = __ctx + "/platform/system/sysTableManage/parseConditionScript.ht";
	var n = getParameters();
	var f = [];
	var q = [];
	for (var e = 0; e < n.length; e++) {
		var c = n[e];
		if (c.vf != 1) {
			continue;
		}
		var l;
		if (c.ty == "DL") {
			l = constructTag("input", {
				name : "Q_" + c.na + "_" + c.ty,
				onfocus : "datePicker(this)",
				"class" : "Wdate inputText"
			});
		} else {
			l = constructTag("input", {
				name : "Q_" + c.na + "_" + c.ty,
				"class" : "inputText"
			});
		}
		var g = "" + "<table class='table-detail'>" + "<tr>" + "<th>名称</th>"
				+ "<td>" + c.na + "</td>" + "</tr>" + "<tr>" + "<th>注释</th>"
				+ "<td>" + c.cm + "</td>" + "</tr>" + "<tr>" + "<th>类型</th>"
				+ "<td>" + getType(c.ty) + "</td>" + "</tr>" + "</table>";
		l.qtip({
			show : {
				event : "focus"
			},
			hide : {
				event : "blur"
			},
			content : g
		});
		var h = constructTag("tr");
		var m = constructTag("td");
		m.text(c.na);
		var k = constructTag("td");
		k.append(l);
		h.append(m);
		h.append(k);
		f.push(h);
		q.push("");
	}
	var j = function(r) {
		r = r || {};
		var i = conditonScriptEditor.getValue();
		var s = {
			script : i,
			parameters : JSON2.stringify(n)
		};
		$.extend(s, r);
		$.post(a, s, function(t) {
			console.dir(JSON2.stringify(t));
			if (t.status) {
				$.ligerDialog.success("结果:" + t.result, "在当前上下文，脚本执行成功");
			} else {
				$.ligerDialog.error(t.message, "当前上下文，解析条件脚本失败：");
			}
		});
	};
	if (f.length > 0) {
		var o = $("<table class='table-detail'><tr><th style='text-align: center;'>变量名</th><th style='text-align: center;'>变量值</th></tr></table>");
		for (var e = 0; e < f.length; e++) {
			o.append(f[e]);
		}
		var b = $("<form id='dialog-input-parameter-form'>").append(o);
		$.ligerDialog.open({
			width : 300,
			height : 350,
			target : b,
			buttons : [ {
				text : "确定",
				onclick : function(s, r, i) {
					r.close();
					var t = serializeObject(b);
					j(t);
				}
			} ]
		});
	} else {
		j();
	}
}
function serializeObject(c) {
	var d = {};
	var b = $(c).serializeArray();
	$.each(b, function() {
		if (d[this.name]) {
			if (!d[this.name].push) {
				d[this.name] = [ d[this.name] ];
			}
			d[this.name].push(this.value || "");
		} else {
			d[this.name] = this.value || "";
		}
	});
	return d;
}