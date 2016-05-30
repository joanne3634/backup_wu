$(function() {
	var a = {
		tables : {},
		memu : null,
		init : function() {
			var b = this;
			$("[type='subtable']").each(
					function() {
						var j = $(this);
						var g = $(j).attr("formtype");
						var k = $(j).find("[type='append']");
						var f = $(j).attr("id");
						if (g == "form") {
							isPage = false;
							var c = this.id + "Form", d = $("#" + c), e = d
									.attr("width") ? d.attr("width") : d
									.width() + 80, i = d.attr("height") ? d
									.attr("height") : d.height() + 70, h = d
									.attr("title") ? d.attr("title") : "";
							$(j).data(
									"form",
									"<form>"
											+ $("<div></div>")
													.append(d.clone()).html()
											+ "</form>");
							$(j).data("formProperty", {
								title : h,
								width : e,
								height : i
							});
							d.remove();
						}
						if (g = "page") {
						}
						$(this).data("row",
								$("<div></div>").append(k.clone()).html());
						b.addBind($(this));
						k.css("display", "none").html("");
						b.tables[f] = $(j);
					});
		},
		addBind : function(d) {
			var c = this;
			var b = (d.data("form") != null);
			var e = c.getMenu(b);
			$('[type="subdata"]').live("contextmenu", function(f) {
				e.target = f.target;
				e.show({
					top : f.pageY,
					left : f.pageX
				});
				return false;
			});
			$(".add", d).click(function() {
				c.add(d, null);
			});
		},
		add : function(e, i) {
			var c = this, h = e.data("form");
			if (h) {
				var d = $(h).clone(), b = e.data("formProperty");
				$(d).find("table,div").show();
				var g = $(d)
						.form(
								{
									errorPlacement : function(f, j) {
										$(f)
												.parent()
												.append(
														$('<label class="initerror" >*</label>'));
									}
								});
				this.openWin({
					title : "添加" + b.title,
					width : b.width,
					height : b.height,
					form : d,
					callback : function() {
						if (g.valid()) {
							var j = c.getFormData(d);
							var f = c.getFormShowData(d);
							c.addRow(j, f, e);
						}
					}
				});
			} else {
				c._addRow(e, i);
			}
		},
		addRow : function(g, b, d) {
			var h = d.data("row");
			var f = $(h).clone();
			f.attr("type", "subdata");
			f.removeAttr("style");
			for ( var c in g) {
				f.find("td,input:hidden").each(function() {
					if ($(this).is("td")) {
						var i = $(this).attr("name");
						if (c == i) {
							$(this).text(b[c]);
						}
					}
					if ($(this).is("input:hidden")) {
						var j = $(this).attr("name");
						if (c == j) {
							$(this).val(g[c]);
						}
					}
				});
			}
			var e = d.find("[type='subdata']:visible");
			if (e.length != 0) {
				$(e.get(e.length - 1)).after(f);
			} else {
				$(d.find("tbody")[0]).append(f);
			}
			$.ligerDialog.hide();
		},
		getMenu : function(b) {
			var d = this;
			var e;
			var c = [
					{
						text : "在前面插入记录",
						click : function() {
							var g = $(e.target).closest('[type="subdata"]');
							var f = g.closest("[type=subtable]");
							d.add(f, g);
						}
					},
					{
						text : "在后面插入记录",
						click : function() {
							var g = $(e.target).closest('[type="subdata"]');
							var f = g.closest("[type=subtable]");
							g = g.next('[type="subdata"]:visible');
							if (g.length == 0) {
								g = null;
							}
							d.add(f, g);
						}
					},
					{
						line : true
					},
					{
						text : "编辑",
						click : function() {
							var g = $(e.target).closest('[type="subdata"]');
							var f = g.closest("[type=subtable]");
							d.edit(f, g);
						}
					},
					{
						text : "删除此记录",
						click : function() {
							var g = $(e.target).closest('[type="subdata"]'), f = g
									.next('[type="subdata"]').length ? g
									.next('[type="subdata"]') : g
									.prev('[type="subdata"]');
							g.remove();
							if (f) {
								FormUtil.InitMathfunction(f);
							}
						}
					}, {
						line : true
					}, {
						text : "向上移动",
						click : function() {
							var f = $(e.target).closest('[type="subdata"]');
							var g = f.prev('[type="subdata"]:visible');
							if (g.length > 0) {
								g.before(f);
							}
						}
					}, {
						text : "向下移动",
						click : function() {
							var f = $(e.target).closest('[type="subdata"]');
							var g = f.next('[type="subdata"]:visible');
							if (g.length > 0) {
								g.after(f);
							}
						}
					} ];
			if (!b) {
				c.splice(3, 1);
			}
			e = $.ligerMenu({
				top : 100,
				left : 100,
				width : 130,
				items : c
			});
			if (b) {
				this.menuWithEdit = e;
			} else {
				this.menu = e;
			}
			return e;
		},
		edit : function(e, f) {
			var c = this, d = c.setFormData(f, e), b = e.data("formProperty");
			$(d).find("table,div").show();
			this.openWin({
				title : "编辑" + b.title,
				width : b.width,
				height : b.height,
				form : d,
				callback : function() {
					var g = $(d).form();
					if (g.valid()) {
						c.editRow(f, d);
					}
				}
			});
		},
		_addRow : function(c, e) {
			var b = $(c.data("row")).clone();
			b.attr("type", "subdata");
			b.removeAttr("style");
			if (e) {
				e.before(b);
			} else {
				var d = c.find("[type='subdata']:visible");
				if (d.length != 0) {
					$(d.get(d.length - 1)).after(b);
				} else {
					if ($(b).is("div")) {
						$(c).append(b);
					} else {
						$($(c).find("tbody")).append(b);
					}
				}
			}
		},
		delRow : function() {
			$.ligerMessageBox.confirm("提示信息", "确认删除吗？", function(b) {
				if (b) {
					$(".pk:checked").each(function() {
						$(this).closest("tr").remove();
					});
				}
			});
		},
		editRow : function(g, e) {
			var c = this;
			var f = c.getFormData(e);
			var b = c.getFormShowData(e);
			for ( var d in f) {
				$(g).find("td,input:hidden").each(function() {
					if ($(this).is("td")) {
						var h = $(this).attr("name");
						if (d == h) {
							$(this).text(b[d]);
						}
					}
					if ($(this).is("input:hidden")) {
						var i = $(this).attr("name");
						if (d == i) {
							$(this).val(f[d]);
						}
					}
				});
			}
			$.ligerDialog.hide();
		},
		openWin : function(b) {
			$.ligerDialog.open({
				width : b.width ? b.width : 400,
				height : b.height ? b.height : 250,
				title : b.title ? b.title : "编辑",
				isResize : true,
				showMax : true,
				showToggle : true,
				onClose : true,
				target : b.form,
				buttons : [ {
					text : "确定",
					onclick : function(d, c) {
						b.callback(d, c);
					}
				} ]
			});
		},
		setFormData : function(f, e) {
			var d = $(e.data("form")).clone().show();
			var c = {};
			$("input:hidden", f).each(function() {
				var h = $(this).val().trim();
				var g = $(this).attr("name");
				c[g] = h;
			});
			for ( var b in c) {
				d.find("input:text,textarea,select").each(function() {
					var g = $(this).attr("name");
					if (b == g) {
						if ($(this).is("select")) {
							$(this).find("option").each(function() {
								if ($(this).val() == c[b]) {
									$(this).attr("selected", "selected");
								}
							});
						} else {
							$(this).val(c[b]);
						}
					}
				});
				d.find("input:checkbox,input:radio").each(function() {
					var i = $(this).attr("name");
					var h = "";
					if (b == i) {
						h = c[b];
					}
					var g = h.split(",");
					$(this).find("[name=" + b + "]").each(function() {
						for ( var k = 0; k < g.length; k++) {
							var j = g[k];
							if ($(this).val() == j) {
								$(this).attr("checked", "checked");
							}
						}
					});
				});
			}
			return d;
		},
		getFormData : function(b) {
			var c = {};
			$(b).find("input:text,textarea,select").each(function() {
				var d = $(this).attr("name");
				var e = $(this).val();
				c[d] = e;
			});
			$(b).find(":checkbox,:radio").each(function() {
				var d = $(this).attr("name");
				var e = "";
				$(":checked[name=" + d + "]").each(function() {
					if (e == "") {
						e = $(this).val();
					} else {
						e += "," + $(this).val();
					}
				});
				c[d] = e;
			});
			return c;
		},
		getFormShowData : function(b) {
			var c = {};
			$(b).find("input:text,textarea").each(function() {
				var d = $(this).attr("name");
				var e = $(this).val();
				c[d] = e;
			});
			$(b).find("select").each(function() {
				var e = $(this);
				var d = e.attr("name");
				var f = e.find("option:selected").text();
				c[d] = f;
			});
			$(b).find(":checkbox,:radio").each(function() {
				var d = $(this).attr("name");
				var e = "";
				$(":checked[name=" + d + "]").each(function() {
					if (e == "") {
						e = $(this).val();
					} else {
						e += "," + $(this).val();
					}
				});
				c[d] = e;
			});
			return c;
		}
	};
	a.init();
});