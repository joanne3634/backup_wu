(function($) {
	$
			.extend(
					$.fn,
					{
						form : function(conf) {
							if (conf) {
								if (conf.errorPlacement) {
									this.errorPlacement = conf.errorPlacement;
								}
								if (conf.rules) {
									for ( var i = 0, len = conf.rules.length; i < len; i++) {
										this.addRule(conf.rules[i]);
									}
								}
								if (conf.success) {
									this.success = conf.success;
								}
								if (conf.excludes) {
									this.excludes = conf.excludes;
								}
							}
							var form = this;
							form
									.delegate(
											"input[validate],select[validate],textarea[validate]",
											"blur", function() {
												form.handValidResult(this);
											});
							form
									.delegate(
											"input[validate],select[validate],textarea[validate]",
											"focus", function() {
												form.success(this);
											});
							$("[validate].ckeditor", form)
									.each(
											function() {
												var me = $(this), name = me
														.attr("name");
												setTimeout(
														function() {
															var editor = CKEDITOR.instances[name], ck = me
																	.next();
															if (editor) {
																editor
																		.on(
																				"blur",
																				function() {
																					form
																							.handValidResult(me);
																				});
																editor
																		.on(
																				"focus",
																				function() {
																					form
																							.success(me);
																				});
															}
														}, 1000);
											});
							return this;
						},
						addRule : function(rule) {
							var len = this.rules.length;
							for ( var i = 0; i < len; i++) {
								var r = this.rules[i];
								if (rule.name == r.name) {
									this.rules[i] = rule;
									return;
								}
							}
							this.rules.push(rule);
						},
						isInNotValid : function(obj) {
							if ($(obj).is(":hidden")) {
								return true;
							}
							if (!this.excludes) {
								return false;
							}
							var scope = $(this.excludes, this);
							var aryInput = $(
									"input:text,input:hidden,textarea,select,input:checkbox,input:radio",
									scope);
							for ( var i = 0, len = aryInput.length; i < len; i++) {
								var tmp = aryInput.get(i);
								if (obj == tmp) {
									return true;
								}
							}
							return false;
						},
						valid : function(conf) {
							if (!conf) {
								this.ignoreRequired = false;
							} else {
								if (conf.ignoreRequired == undefined) {
									this.ignoreRequired = false;
								} else {
									this.ignoreRequired = conf.ignoreRequired;
								}
							}
							var _v = true, form = this;
							$("[validate]", form).each(function() {
								var rtn = form.handValidResult(this);
								if (!rtn) {
									_v = false;
								}
							});
							return _v;
						},
						handValidResult : function(obj) {
							if (this.isInNotValid(obj)) {
								return true;
							}
							var msg = this.validEach(obj);
							if (msg != "") {
								this.errorPlacement(obj, msg);
								return false;
							} else {
								this.success(obj);
								if ($(obj).hasClass("validError")) {
									$(obj).removeClass("validError");
								}
								return true;
							}
						},
						validEach : function(obj) {
							var element = $(obj), rules = this.rules, validRule = element
									.attr("validate"), value = "", name = element
									.attr("name");
							if (element.is(":checkbox,:radio")) {
								var parentObj = element.closest("[formtype]"), brotherObjs = (parentObj && parentObj.length > 0) ? $(
										":checked[name='" + name + "']",
										parentObj)
										: $(":checked[name='" + name + "']");
								brotherObjs.each(function() {
									if (value == "") {
										value = $(this).val();
									} else {
										value += "," + $(this).val();
									}
								});
							} else {
								if (element.is("select")) {
									value = element.find("option:selected")
											.val();
									if (typeof (value) == undefined
											|| value == null
											|| $.trim(value) == ""
											|| value.indexOf("请选择") > -1) {
										value = "";
									}
								} else {
									if (element.hasClass("ckeditor")) {
										var editor = CKEDITOR.instances[name];
										if ($.isEmpty(editor)) {
											value = element.val();
										} else {
											value = editor.getData();
										}
									} else {
										if (element.hasClass("selectFile")) {
											value = element
													.siblings(
															"textarea[controltype='attachment']")
													.val();
										} else {
											value = element.val();
										}
									}
								}
							}
							value = value == null ? "" : value.trim();
							var json = eval("(" + validRule + ")");
							var isRequired = json.required;
							if ((isRequired == false || isRequired == undefined)
									&& value == "") {
								return "";
							}
							if (this.ignoreRequired == true && value == "") {
								return "";
							}
							for ( var name in json) {
								var validValue = json[name];
								var msg = this._validRules({
									rules : rules,
									ruleName : name,
									validValue : validValue,
									value : value
								});
								if (msg != "") {
									return msg;
								}
							}
							return "";
						},
						_validRules : function(conf) {
							var _valid = true, rules = conf.rules, ruleName = conf.ruleName, validValue = conf.validValue, value = conf.value;
							for ( var m = 0; m < rules.length; m++) {
								var rule = rules[m];
								if (ruleName.toLowerCase() != rule.name
										.toLowerCase()) {
									continue;
								}
								if ($.type(validValue) === "boolean") {
									_valid = (!rule.rule(value) && validValue == true) ? false
											: true;
								} else {
									_valid = rule.rule(value, validValue);
								}
								if (!_valid) {
									return this.format(rule.msg, validValue);
								}
							}
							return "";
						},
						format : function(msg, args) {
							if ($.type(args) === "boolean") {
								return msg;
							}
							if (!$.isArray(args)) {
								args = [ args ];
							}
							$.each(args, function(d, e) {
								msg = msg.replace(
										RegExp("\\{" + d + "\\}", "g"), e);
							});
							return msg;
						},
						errorPlacement : function(element, msg) {
							var errorId = $(element).attr("tipId");
							if (errorId) {
								$("#" + errorId).find("label.error").remove();
								$("#" + errorId).append(
										$('<label class="error">' + msg
												+ "</label>"));
								return;
							}
							var parent = $(element).parent();
							parent.find("label.error").remove();
							parent.append($('<label class="error">' + msg
									+ "</label>"));
						},
						success : function(element) {
							var errorId = $(element).attr("tipId");
							if (errorId) {
								$("#" + errorId).find("label.error").remove();
								return;
							}
							$(element).parent().find("label.error").remove();
						},
						rules : [
								{
									name : "required",
									rule : function(v) {
										if (v == "" || v.length == 0) {
											return false;
										}
										return true;
									},
									msg : $lang_js.customValid.rules.required
								},
								{
									name : "number",
									rule : function(v) {
										return /^-?[\$|￥]?((\d{1,3}(,\d{3})+?|\d+)(\.\d{1,5})?)$/
												.test(v.trim());
									},
									msg : $lang_js.customValid.rules.number
								},
								{
									name : "variable",
									rule : function(v) {
										return /^[A-Za-z_0-9]*$/gi.test(v
												.trim());
									},
									msg : $lang_js.customValid.rules.variable
								},
								{
									name : "fields",
									rule : function(v) {
										return /^[A-Za-z]{1}([a-zA-Z0-9_]{1,17})?$/gi
												.test(v.trim());
									},
									msg : $lang_js.customValid.rules.fields
								},
								{
									name : "minLength",
									rule : function(v, b) {
										return (v.length >= b);
									},
									msg : $lang_js.customValid.rules.minLength
								},
								{
									name : "maxLength",
									rule : function(v, b) {
										return (v.trim().length <= b);
									},
									msg : $lang_js.customValid.rules.maxLength
								},
								{
									name : "rangeLength",
									rule : function(v, args) {
										return (v.trim().length >= args[0] && v
												.trim().length <= args[1]);
									},
									msg : $lang_js.customValid.rules.rangeLength
								},
								{
									name : "email",
									rule : function(v) {
										return /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$/i
												.test(v.trim());
									},
									msg : $lang_js.customValid.rules.email
								},
								{
									name : "url",
									rule : function(v) {
										return /^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i
												.test(v.trim());
									},
									msg : $lang_js.customValid.rules.url
								},
								{
									name : "date",
									rule : function(v) {
										var re = /^[\d]{4}-[\d]{1,2}-[\d]{1,2}\s*[\d]{1,2}:[\d]{1,2}:[\d]{1,2}|[\d]{4}-[\d]{1,2}-[\d]{1,2}|[\d]{1,2}:[\d]{1,2}:[\d]{1,2}$/g
												.test(v.trim());
										return re;
									},
									msg : $lang_js.customValid.rules.date
								},
								{
									name : "digits",
									rule : function(v) {
										return /^\d+$/.test(v.trim());
									},
									msg : $lang_js.customValid.rules.digits
								},
								{
									name : "equalTo",
									rule : function(v, b) {
										var a = $("#" + b).val();
										return (v.trim() == a.trim());
									},
									msg : $lang_js.customValid.rules.equalTo
								},
								{
									name : "range",
									rule : function(v, args) {
										return v <= args[1] && v >= args[0];
									},
									msg : $lang_js.customValid.rules.range
								},
								{
									name : "maxvalue",
									rule : function(v, max) {
										return v <= max;
									},
									msg : $lang_js.customValid.rules.maxvalue
								},
								{
									name : "minvalue",
									rule : function(v, min) {
										return v >= min;
									},
									msg : $lang_js.customValid.rules.minvalue
								},
								{
									name : "maxIntLen",
									rule : function(v, b) {
										if (/^[\$|￥]/.test(v.trim())) {
											return (v + "").split(".")[0]
													.replaceAll(",", "")
													.replaceAll("￥|$", "").length <= b + 1;
										} else {
											return (v + "").split(".")[0]
													.replaceAll(",", "").length <= b;
										}
									},
									msg : $lang_js.customValid.rules.maxIntLen
								},
								{
									name : "maxDecimalLen",
									rule : function(v, b) {
										return (v + "").replace(/^[^.]*[.]*/,
												"").length <= b;
									},
									msg : $lang_js.customValid.rules.maxDecimalLen
								},
								{
									name : "dateRangeStart",
									rule : function(v, b) {
										var end = $("#" + b).val();
										return daysBetween(v, end);
									},
									msg : $lang_js.customValid.rules.dateRangeStart
								},
								{
									name : "dateRangeEnd",
									rule : function(v, b) {
										var start = $("#" + b).val();
										return daysBetween(start, v);
									},
									msg : $lang_js.customValid.rules.dateRangeEnd
								},
								{
									name : "empty",
									rule : function(v, b) {
										return true;
									},
									msg : ""
								},
								{
									name : "noDigitsStart",
									rule : function(v) {
										return !/^(\d+)(.*)$/.test(v.trim());
									},
									msg : $lang_js.customValid.rules.noDigitsStart
								}, {
									name : "varirule",
									rule : function(v) {
										return /^[a-zA-Z]\w*$/.test(v.trim());
									},
									msg : "只能为字母开头,允许字母、数字和下划线"
								} ]
					});
})(jQuery);