$(function() {
	initDisplaytag();
});
function initDisplaytag() {
	jQuery.highlightTableRows();
	jQuery.selectTr();
	handlerSearch();
	handleSearchKeyPress();
	handlerCheckAll();
	handlerDelOne();
	handlerUpd();
	handlerDelSelect();
	exportCheckAll();
	pageInit();
}
function exportAllCheckChange(e) {
	var a = document.getElementById("divExportAll");
	if (a != null) {
		var d = a.childNodes;
		for (var c = 0; c < d.length; c++) {
			if (d[c] != null && d[c].tagName == "A") {
				var b = d[c].href;
				if (e.checked) {
					if (b.indexOf("?") != -1) {
						b += "&";
					} else {
						b += "?";
					}
					d[c].href = b + "exportAll=1";
				} else {
					d[c].href = d[c].href.replace("&exportAll=1", "").replace(
							"?exportAll=1").replace("exportAll=1");
				}
			}
		}
	}
}
function exportCheckAll() {
	$(".expCheckAll").bind(
			"click",
			function(b) {
				var a = b.target.checked;
				$(".expCheckAll ~ a").each(
						function() {
							var c = $(this).attr("href");
							if (a) {
								if (c.indexOf("?") != -1) {
									c += "&";
								} else {
									c += "?";
								}
								$(this).attr("href", c + "exportAll=1");
							} else {
								c = c.replace("&exportAll=1", "").replace(
										"?exportAll=1").replace("exportAll=1");
								$(this).attr("href", c);
							}
						});
			});
}
function handlerCheckAll() {
	$("#chkall").click(function() {
		var a = $(this).attr("checked");
		if (a == undefined) {
			checkAll(false);
		} else {
			checkAll(true);
		}
	});
}
function checkAll(a) {
	$("input[type='checkbox'][class='pk']").each(function() {
		$(this).attr("checked", a);
	});
}
function handlerSearch() {
	$("a.link.search").click(function() {
		if (!$(this).hasClass("disabled")) {
			$("#searchForm").submit();
		}
	});
}
function handleSearchKeyPress() {
	$(".panel-search :input").keypress(function(b) {
		if (b.keyCode == 13) {
			$("a.link.search").click();
		} else {
			if (b.keyCode == 27) {
				var a = $("#searchForm");
				if (a) {
					a[0].reset();
				}
			}
		}
	});
}
function handlerDelOne() {
	$("table.table-grid td a.link.del").click(function() {
		if ($(this).hasClass("disabled")) {
			return false;
		}
		var a = this;
		$.ligerDialog.confirm("确认删除吗？", "提示信息", function(b) {
			if (b) {
				if (a.click) {
					$(a).unbind("click");
					a.click();
				} else {
					location.href = a.href;
				}
			}
		});
		return false;
	});
}
function handlerUpd() {
	$("div.group > a.link.update")
			.click(
					function() {
						if ($(this).hasClass("disabled")) {
							return false;
						}
						var e = $(this).attr("action");
						var f = $("input[type='checkbox'][disabled!='disabled'][class='pk']:checked");
						var a = f.length;
						if (a == 0) {
							$.ligerDialog.warn("还没有选择,请选择一项进行编辑!", "提示信息");
							return;
						} else {
							if (a > 1) {
								$.ligerDialog
										.warn("已经选择了多项,请选择一项进行编辑!", "提示信息");
								return;
							}
						}
						var b = f.attr("name");
						var d = f.val();
						var c = new com.deelon.form.Form();
						c.creatForm("form", e);
						c.addFormEl(b, d);
						c.submit();
					});
}
function handlerDelSelect() {
	$("div.group > a.link.del")
			.click(
					function() {
						if ($(this).hasClass("disabled")) {
							return false;
						}
						var e = $(this).attr("action");
						var d = $("input[type='checkbox'][disabled!='disabled'][class='pk']:checked");
						if (d.length == 0) {
							$.ligerDialog.warn("请选择记录！");
							return false;
						}
						var f = "";
						var c = "";
						var a = d.length;
						d.each(function(g) {
							var h = $(this);
							if (g < a - 1) {
								f += h.val() + ",";
							} else {
								c = h.attr("name");
								f += h.val();
							}
						});
						var b = e + "?" + c + "=" + f;
						$.ligerDialog.confirm("确认删除吗？", "提示信息", function(h) {
							if (h) {
								var g = new com.deelon.form.Form();
								g.creatForm("form", e);
								g.addFormEl(c, f);
								g.submit();
							}
						});
						return false;
					});
}
function goPage(c, b) {
	var a = replacecurrentPage($("#_nav" + b).attr("href"), c, b);
	a = replagePageSize(a, $("#oldPageSize" + b).val(), b);
	location.href = replageOldPageSize(a, $("#oldPageSize" + b).val(), b);
}
function first(a) {
	goPage(1, a);
}
function last(b) {
	var a = $("#totalPage" + b).val();
	goPage(a, b);
}
function previous(b) {
	var a = parseInt($("#currentPage" + b).val());
	a -= 1;
	if (a < 1) {
		a = 1;
	}
	goPage(a, b);
}
function next(c) {
	var b = parseInt($("#currentPage" + c).val());
	var a = parseInt($("#totalPage" + c).val());
	b += 1;
	if (b > a) {
		b = a;
	}
	goPage(b, c);
}
function changePageSize(c, b) {
	var a = replagePageSize($("#_nav" + b).attr("href"), c.value, b);
	a = replacecurrentPage(a, $("#currentPage" + b).val(), b);
	location.href = replageOldPageSize(a, $("#oldPageSize" + b).val(), b);
}
function jumpTo(d) {
	var c = $("#navNum" + d), a = c.val(), b = $("#totalPage" + d).val();
	jumpToPage(d, a, b);
}
function jumpToPage(d, a, b) {
	a = parseInt(a), b = parseInt(b);
	if (/^\d+$/.test(a) && a > 0 && a <= b) {
		goPage(a, d);
	} else {
		var c = String.format($lang.operateTip.pageTip, b);
		alert(c);
		$("#navNum" + d).focus();
	}
}
function pageInit() {
	$("div.panel-page input.pageInput").keypress(function(a) {
		return handleKeyPress(a, this);
	});
}
function handleKeyPress(g, f) {
	var c = $(f), a = c.val(), d = c.attr("tableidcode"), b = $(
			"#totalPage" + d).val();
	if (/^13$|^39$|^37$/.test(g.keyCode)) {
		switch (g.keyCode) {
		case 13:
			jumpToPage(d, a, b);
			break;
		case 39:
			break;
		case 37:
			break;
		}
	}
}
function replacecurrentPage(b, d, f) {
	var a = b.indexOf("#");
	if (a != -1) {
		b = b.substring(0, a);
	}
	var e = f + "p";
	var c = new RegExp(e + "=\\d*");
	if (c.test(b)) {
		b = b.replace(c, e + "=" + d);
	} else {
		if (b.indexOf("?") != -1) {
			b += "&" + e + "=" + d;
		} else {
			b += "?" + e + "=" + d;
		}
	}
	return b;
}
function replagePageSize(b, a, e) {
	var d = e + "z";
	var c = new RegExp(d + "=\\d*");
	if (c.test(b)) {
		b = b.replace(c, d + "=" + a);
	} else {
		if (b.indexOf("?") != -1) {
			b += "&" + d + "=" + a;
		} else {
			b += "?" + d + "=" + a;
		}
	}
	return b;
}
function replageOldPageSize(b, a, e) {
	var d = e + "oz";
	var c = new RegExp(d + "=\\d*");
	if (c.test(b)) {
		b = b.replace(c, d + "=" + a);
	} else {
		if (b.indexOf("?") != -1) {
			b += "&" + d + "=" + a;
		} else {
			b += "?" + d + "=" + a;
		}
	}
	return b;
}