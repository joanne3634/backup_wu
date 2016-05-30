if(isLogin && document.getElementById('userlogined')) { // added condition cause this is shared for iframe too
    $.ajax({
        url: _ctx+"/loan/tuserMsgRemind/getTUserMsgCount.ht",
        dataType: 'json',
        type: 'post',
        success: function (userMsgCount) {
            if (userMsgCount) {
                var data = userMsgCount;
                if (data && data > 0) {
                    var msgShow;
                    if (data > 99) {
                        msgShow = "99+";
                    } else {
                        msgShow = data;
                    }
                    //$("#userMsg").text(msgShow);
                    $("#num-box").text(msgShow).show();
                }
            }
        }
    });
    Ink.requireModules( ['Ink.UI.Dropdown_1'], function( Dropdown ){
        new Dropdown('#userlogined');
    });
}

$.extend($.Dialog, {
    bankConfirm : function (confirmHandler, errorHandler, cancelHandler) {
        var className = 'EsgDialogbankConfirm';
        var BankConfirmContentMarkup = [
            '<div class="modal-header">',
            '   <h2>提示</h2>',
            '</div>',
            '<div class="modal-body">',
            '请您在打开的银行页面支付，支付完成前请不要关闭该窗口!',
            '</div>',
            '<div class="modal-footer">',
            '<div class="push-center align-center">',
            '<button class="ink-button blue ink-dismiss" data-type="Confirm">已完成支付</button>',
            '<button class="ink-button red ink-dismiss" data-type="Error">支付遇到问题</button>',
            '<button class="ink-button white ink-dismiss" data-type="Cancel">关 闭</button>',
            '</div>',
            '</div>'].join('');

        Ink.requireModules( ['Ink.UI.Modal_1'], function( Modal ){
            var confirmModal = new Modal( "", {
                width: '500px',
                height: '150px',
                modalClass: className,
                markup: BankConfirmContentMarkup
            });

            $(['.',className].join('')).find('.ink-dismiss').on('click', function(e){
                if($(this).data('type') === "Confirm"){
                    confirmHandler && confirmHandler(e);
                } else if($(this).data('type') === "Error"){
                    errorHandler && errorHandler(e);
                } else {
                    cancelHandler && cancelHandler(e);
                }
            });
        });
    }
});

Ink.requireModules(['Ink.UI.FormValidator_2', 'Ink.Dom.Element_1', 'Ink.UI.Modal_1'], function (FormValidator, Element, Modal) {

    FormValidator.FormElement.prototype = Ink.extendObj(FormValidator.FormElement.prototype, {
        /**
         * override _getLabel function
         */
        _getLabel: function () {
            var label = Ink.s("label[for=\""+this._element.id+"\"]");

            if (label) {
                return Element.textContent(label).replace(/：|:/, '');
            } else {
                return this._element.name || this._element.id || '';
            }
        },
        _addError: function(rule){
            var params = this._rules[rule] || [];

            var paramObj = {
                field: this._getLabel(),
                value: this.getValue()
            };

            for( var i = 1; i < params.length; i++ ){
                paramObj['param' + i] = params[i];
            }

            var i18nKey = 'formvalidator.' + rule;

            var err;

            if (this._options.error) {
                err = this._options.error;
            } else {
                err = FormValidator.getI18n().text(i18nKey, paramObj);

                if (err === i18nKey) {
                    err = '[Validation message not found for rule ]' + rule;
                }
            }

            this._errors[rule] = err;
        },
        validate: function(){
            this._errors = {};

            this._parseRules( this._options.rules );

            // We want to validate this field only if it's not empty
            // "" is not an invalid number.
            var doValidate = this.getValue() !== '' ||
                    // If it's required it will be validated anyway.
                ("required" in this._rules) ||
                    // If it has a "matches" rule it will also be validated because "" is not a valid password confirmation.
                ("matches" in this._rules);
            doValidate = !this._element.disabled;
            if (doValidate) {
                for(var rule in this._rules) {
                    if (this._rules.hasOwnProperty(rule)) {
                        if( (typeof FormValidator.validationFunctions[rule] === 'function') ){
                            if( FormValidator.validationFunctions[rule].apply(this, this._rules[rule] ) === false ){
                                this._addError( rule );
                                return false;
                            }

                        } else {
                            Ink.warn('Rule "' + rule + '" not found. Used in element:', this._element);
                            this._addError( null );
                            return false;
                        }
                    }
                }
            }

            return true;

        }
    });

    FormValidator.appendI18n({'zh_CN': {
        'formvalidator.required' : '{field} 不能为空',
        'formvalidator.min_length': '{field}不能少于{param1}个字符 ',
        'formvalidator.max_length': '{field}不能多于 {param1}个字符',
        'formvalidator.exact_length': '{field}必须有{param1}个字符',
        'formvalidator.email': '{field}格式不正确',
        'formvalidator.url': '{field} 不是有效地URL',
        'formvalidator.ip': '{field} 不包含有效的IP地址 {param1}',
        'formvalidator.phone': '{field}不包含有效的电话号码 {param1}',
        'formvalidator.credit_card': '{field}不是有效的信用卡资料 {param1}',
        'formvalidator.date': '{field} 不是有效的日期格式 {param1}',
        'formvalidator.alpha': '{field} 只应该包含字母',
        'formvalidator.text': '{field} 只包含字母和数字',
        'formvalidator.latin': '{field} 只包含字母和数字',
        'formvalidator.alpha_numeric': '{field} 只包含字母和数字',
        'formvalidator.alpha_dash': '{field} 只包含字母和横线',
        'formvalidator.digit': '{field} 只包含数字',
        'formvalidator.integer': '{field} 只包含整数',
        'formvalidator.decimal': '{field} 只包含十进制数字',
        'formvalidator.numeric': '{field} 只包含数字',
        'formvalidator.range': '{field} 只包含介于 {param1} 和 {param2} 的数字',
        'formvalidator.color': '{field} 只包含有效的颜色',
        'formvalidator.matches': '两次密码输入不一致'
    }});

    FormValidator.setLanguage('zh_CN');

    FormValidator.setRule('regexNumeric', '{field}不能为纯数字', function( value ){
        var pattern = /^([0-9]*)+$/;
        value = $.trim(value);
        return (!pattern.test(value));
    });
    FormValidator.setRule('regexAlpha', '{field}不能为纯字母', function( value ){
        var pattern = /^([a-zA-Z]*)+$/;
        value = $.trim(value);
        return (!pattern.test(value));
    });

    FormValidator.setRule('idCard', '请输入正确的{field}', function( value ){
        //hack fix
        return check18IdCard(value);

    });
    FormValidator.setRule('mobile', '请输入正确的电话号码,如:18688888888', function( value ){
        var regex = /^(1[^012][0-9]{9})$/i;
        return regex.test($.trim(value));
    });
});

function renderError(selector,message) {
    var control = $(selector).closest('.control');
    if(control.length > 0) {
        var tip = control.find("p.tip");
        var controlGroup = control.closest('.control-group');
        if(tip.length > 0) {
            controlGroup.addClass('validation');
            controlGroup.addClass('error');
            tip.html(message);
        } else {
            tip = $('<p class="tip"></p>');
            controlGroup.addClass('validation');
            controlGroup.addClass('error');
            tip.html(message);
            control.append(tip);
        }
    }
}

function clearError(selector) {
    var control = $(selector).closest('.control');
    if(control.length > 0) {
        var tip = control.find("p.tip");
        var controlGroup = control.closest('.control-group');
        if(tip.length > 0) {
            tip.remove();
            controlGroup.removeClass('validation');
            controlGroup.removeClass('error');
        }
    }
}


//刷新验证码
function reload(id) {
    var elementId = id || "validImg";
    var url = _ctx + "/servlet/ValidCode?rand=" + new Date().getTime();
    document.getElementById(elementId).src = url;
}

/// 密码强度 ///////////////

///////////////////////////////////////////

//判断输入密码的类型
function CharMode(iN) {
    if (iN >= 48 && iN <= 57) //数字
        return 1;
    if (iN >= 65 && iN <= 90) //大写
        return 2;
    if (iN >= 97 && iN <= 122) //小写
        return 4;
    else
        return 8;
}
//bitTotal函数
//计算密码模式
function bitTotal(num) {
    modes = 0;
    for (i = 0; i < 4; i++) {
        if (num & 1)
            modes++;
        num >>>= 1;
    }
    return modes;
}
//返回强度级别
function checkStrong(sPW) {
    if (sPW.length <= 4)
        return 0; //密码太短
    Modes = 0;
    for (i = 0; i < sPW.length; i++) {
        //密码模式
        Modes |= CharMode(sPW.charCodeAt(i));
    }
    return bitTotal(Modes);
}

//显示颜色
function pwStrength(pwd) {
    O_color = "#eeeeee";
    L_color = "#FF0000";
    M_color = "#FF9900";
    H_color = "#33CC00";
    if (pwd == null || pwd == '') {
        Lcolor = Mcolor = Hcolor = O_color;
    } else {
        S_level = checkStrong(pwd);
        switch (S_level) {
            case 0:
                Lcolor = Mcolor = Hcolor = O_color;
            case 1:
                Lcolor = L_color;
                Mcolor = Hcolor = O_color;
                break;
            case 2:
                Lcolor = Mcolor = M_color;
                Hcolor = O_color;
                break;
            default:
                Lcolor = Mcolor = Hcolor = H_color;
        }
    }
    document.getElementById("strength_L").style.background = Lcolor;
    document.getElementById("strength_M").style.background = Mcolor;
    document.getElementById("strength_H").style.background = Hcolor;
    return;
}


// 判断18位身份证是否有效
function check18IdCard(idCard) {
    idCard = trim(idCard);
    return idCard.length == 18 && isValidityBrithBy18IdCard(idCard) && isTrueValidateCodeBy18IdCard(idCard);
};
// 判断是否是age年龄以上
function checkAge(idCard, age) {
    return getAge(idCard) > age;
};
var Wi = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1 ];
// 加权因子
var ValideCode = [ 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ];
// 身份证验证位值.10代表X
/**
 * 判断身份证号码为18位时最后的验证位是否正确
 * @param a_idCard 身份证号码数组
 * @return
 */
function isTrueValidateCodeBy18IdCard(a_idCard) {
    var sum = 0, lastChar = a_idCard[17];
    // 声明加权求和变量
    if (a_idCard[17].toLowerCase() == "x") {
        lastChar = 10;
    }
    for (var i = 0; i < 17; i++) {
        sum += Wi[i] * a_idCard[i];
    }
    var valCodePosition = sum % 11;
    // 得到验证码所位置
    if (lastChar == ValideCode[valCodePosition]) {
        return true;
    } else {
        return false;
    }
}
/**
 * 验证18位数身份证号码中的生日是否是有效生日
 * @param idCard 18位书身份证字符串
 * @return
 */
function isValidityBrithBy18IdCard(idCard18) {
    var year = idCard18.substring(6, 10);
    var month = idCard18.substring(10, 12);
    var day = idCard18.substring(12, 14);
    var temp_date = new Date(year, parseFloat(month) - 1, parseFloat(day));
    // 这里用getFullYear()获取年份，避免千年虫问题
    if (temp_date.getFullYear() != parseFloat(year) || temp_date.getMonth() != parseFloat(month) - 1 || temp_date.getDate() != parseFloat(day)) {
        return false;
    } else {
        return true;
    }
}
// 通过身份证取得年龄
function getAge(idCard18) {
    return new Date().getFullYear() - idCard18.substring(6, 10);
}
//去掉字符串头尾空格
function trim(str) {
    return str.replace(/(^\s*)|(\s*$)/g, "");
}

function valiLoginTimeout(p){
    $.ajax({
        url : _ctx+"/user/valiLoginTimeout.ht",
        type : 'post',
        dataType : 'json',
        success : function(data) {
            if(!data){
                if(p == 'iframe'){    //是否是iframe嵌入的页面
                    window.parent.location = _ctx+'/loginWeb.jsp';
                }else{
                    window.location = _ctx+'/loginWeb.jsp';
                }
            }
        }
    });
}


function iFrameHeight() {
    var iframes = document.getElementsByTagName('iframe');
    for(var i = 0,len = iframes.length;i < len; i++) {
        var iframe = iframes[i], subWeb = iframe.contentDocument;

        if(iframe != null && subWeb != null) {
            iframe.height = subWeb.body.scrollHeight;
        }
    }
    if(window.parent != window) {
        window.parent.iFrameHeight && window.parent.iFrameHeight();
    }
}

if ( window.calIframeHeight ) {
	iFrameHeight();
	window.calIframeHeight = false;
}

var Namespace = new Object();
Namespace.register = function(path) {
	var arr = path.split(".");
	var ns = "";
	for (var i = 0; i < arr.length; i++) {
		if (i > 0) {
			ns += ".";
		}
		ns += arr[i];
		eval("if(typeof(" + ns + ") == 'undefined') " + ns + " = new Object();");
	}
};
jQuery
		.extend({
			checkAll : function(a, b) {
				$("input[name='" + a + "']").attr("checked", b);
			},
			getChkValue : function(a) {
				var b = "";
				$('input[type="checkbox"][name=' + a + "]").each(function() {
					if ($(this).attr("checked")) {
						b += $(this).val() + ",";
					}
				});
				if (b != "") {
					b = b.substring(0, b.length - 1);
				}
				return b;
			},
			getSelectValue : function(a) {
				var b = "";
				$("select[name=" + a + "] option").each(function() {
					b += $(this).val() + ",";
				});
				if (b != "") {
					b = b.substring(0, b.length - 1);
				}
				return b;
			},
			copyToClipboard : function(a) {
				if (window.clipboardData) {
					window.clipboardData.clearData();
					window.clipboardData.setData("Text", a);
					return true;
				} else {
					if (navigator.userAgent.indexOf("Opera") != -1) {
						window.location = a;
						return false;
					} else {
						if (window.netscape) {
							try {
								netscape.security.PrivilegeManager
										.enablePrivilege("UniversalXPConnect");
							} catch (f) {
								alert($lang.tip.msg,
										$lang_js.util.copyToClipboard.netscape);
								return false;
							}
							var c = Components.classes["@mozilla.org/widget/clipboard;1"]
									.createInstance(Components.interfaces.nsIClipboard);
							if (!c) {
								return false;
							}
							var b = Components.classes["@mozilla.org/widget/transferable;1"]
									.createInstance(Components.interfaces.nsITransferable);
							if (!b) {
								return false;
							}
							b.addDataFlavor("text/unicode");
							var g = Components.classes["@mozilla.org/supports-string;1"]
									.createInstance(Components.interfaces.nsISupportsString);
							var h = a;
							g.data = h;
							b.setTransferData("text/unicode", g, h.length * 2);
							var d = Components.interfaces.nsIClipboard;
							if (!c) {
								return false;
							}
							c.setData(b, null, d.kGlobalClipboard);
							return true;
						} else {
							alert($lang.tip.msg,
									$lang_js.util.copyToClipboard.notCopy);
							return false;
						}
					}
				}
			},
			copy : function(a) {
				var c = $("#" + a).val();
				var b = jQuery.copyToClipboard(c);
				if (b) {
					alert($lang_js.util.copy.success);
				}
			},
			isIE : function() {
				var b = navigator.appName;
				var a = b.indexOf("Microsoft");
				return a == 0;
			},
			isIE6 : function() {
				if (($.browser.msie && $.browser.version == "6.0")
						&& !$.support.style) {
					return true;
				}
				return false;
			},
			getChildXml : function(c, j) {
				var b = c.childNodes;
				var f = b.length;
				for (var e = 0; e < f; e++) {
					var a = b[e];
					if (a.nodeType != 1) {
						continue;
					}
					var h = a.nodeName;
					j.append("<" + h + " ");
					var l = a.attributes;
					for (var d = 0; d < l.length; d++) {
						var g = l[d];
						j.append(" " + g.name + '="' + g.value + '" ');
					}
					j.append(">");
					$.getChildXml(a, j);
					j.append("</" + h + ">");
				}
			},
			getChildXmlByNode : function(a) {
				var b = new StringBuffer();
				jQuery.getChildXml(a, b);
				return b.toString();
			},
			getAttrXml : function(d, c) {
				var b = d.childNodes;
				var h = b.length;
				for (var g = 0; g < h; g++) {
					var a = b[g];
					if (a.nodeType != 1) {
						continue;
					}
					var l = a.attributes;
					var f = new Object();
					for (var e = 0; e < l.length; e++) {
						var j = l[e];
						f[j.name] = j.value;
					}
					c.push(f);
					$.getAttrXml(a, c);
				}
			},
			fixPNG : function(f) {
				var h = navigator.appVersion.split("MSIE");
				var c = parseFloat(h[1]);
				if ((c >= 5.5) && (c < 7) && (document.body.filters)) {
					var b = (f.id) ? "id='" + f.id + "' " : "";
					var e = (f.className) ? "class='" + f.className + "' " : "";
					var g = (f.title) ? "title='" + f.title + "' " : "title='"
							+ f.alt + "' ";
					var d = "display:inline-block;" + f.style.cssText;
					var a = "<span "
							+ b
							+ e
							+ g
							+ ' style="'
							+ "width:"
							+ f.width
							+ "px; height:"
							+ f.height
							+ "px;"
							+ d
							+ ";"
							+ "filter:progid:DXImageTransform.Microsoft.AlphaImageLoader"
							+ "(src='" + f.src
							+ "', sizingMethod='scale');\"></span>";
					f.outerHTML = a;
				}
			},
			getParameter : function(b) {
				var d = unescape(window.location.search.substr(1)).split("&");
				for (var a = 0; a < d.length; a++) {
					var c = d[a].split("=");
					if (c.length == 2 && c[0].toUpperCase() == b.toUpperCase()) {
						return c[1];
					}
				}
				return new String();
			},
			getMonthDays : function(a, c) {
				if (c < 0 || c > 11) {
					return 30;
				}
				var b = new Array(12);
				b[0] = 31;
				if (a % 4 == 0) {
					b[1] = 29;
				} else {
					b[1] = 28;
				}
				b[2] = 31;
				b[3] = 30;
				b[4] = 31;
				b[5] = 30;
				b[6] = 31;
				b[7] = 31;
				b[8] = 30;
				b[9] = 31;
				b[10] = 30;
				b[11] = 31;
				return b[c];
			},
			weekOfYear : function(e, h, b) {
				var g = new Date(e, 0, 1);
				var f = new Date(e, h - 1, b, 1);
				var d = 24 * 60 * 60 * 1000;
				var a = (7 - g.getDay()) * d;
				var c = 7 * d;
				g = g.getTime();
				f = f.getTime();
				return Math.ceil((f - g - a) / c) + 1;
			},
			addBookmark : function(b, a) {
				if (window.sidebar) {
					window.sidebar.addPanel(b, a, "");
				} else {
					if (document.all) {
						window.external.AddFavorite(a, b);
					} else {
						if (window.opera && window.print) {
							return true;
						}
					}
				}
			},
			setCookie : function(b, h) {
				var c = new Date();
				var g = arguments;
				var e = arguments.length;
				var d = (e > 2) ? g[2] : null;
				var i = (e > 3) ? g[3] : null;
				var f = (e > 4) ? g[4] : null;
				var a = (e > 5) ? g[5] : false;
				if (d != null) {
					c.setTime(c.getTime() + (d * 1000));
				}
				document.cookie = b
						+ "="
						+ escape(h)
						+ ((d == null) ? "" : (";  expires=" + c.toGMTString()))
						+ ((i == null) ? "" : (";  path=" + i))
						+ ((f == null) ? "" : (";  domain=" + f))
						+ ((a == true) ? ";  secure" : "");
			},
			delCookie : function(a) {
				var c = new Date();
				c.setTime(c.getTime() - 1);
				var b = GetCookie(a);
				document.cookie = a + "=" + b + ";  expires=" + c.toGMTString();
			},
			getCookie : function(d) {
				var b = d + "=";
				var f = b.length;
				var a = document.cookie.length;
				var e = 0;
				while (e < a) {
					var c = e + f;
					if (document.cookie.substring(e, c) == b) {
						return $.getCookieVal(c);
					}
					e = document.cookie.indexOf("  ", e) + 1;
					if (e == 0) {
						break;
					}
				}
				return null;
			},
			getCookieVal : function(b) {
				var a = document.cookie.indexOf(";", b);
				if (a == -1) {
					a = document.cookie.length;
				}
				return unescape(document.cookie.substring(b, a));
			},
			setFormByJson : function(d) {
				var b = d;
				if (typeof (d) == "string") {
					b = jQuery.parseJSON(d);
				}
				for ( var e in b) {
					var c = b[e];
					var a = $("input[name='" + e + "'],textarea[name='" + e
							+ "']");
					if (a[0]) {
						a.val(c);
					}
				}
			},
			highlightTableRows : function() {
				$("tr.odd,tr.even").hover(function() {
					$(this).addClass("over");
				}, function() {
					$(this).removeClass("over");
				});
			},
			selectTr : function() {
				$("tr.odd,tr.even")
						.each(
								function() {
									$(this)
											.bind(
													"mousedown",
													function(b) {
														if (b.target.tagName == "TD") {
															var a = 'input:checkbox[class="pk"],input:radio[class="pk"]';
														}
														var d = $(this).find(a);
														if (d.length == 1) {
															var c = d
																	.attr("checked");
															d.attr("checked",
																	!c);
														}
													});
								});
			},
			insert : function(a, e, c) {
				if (isNaN(c) || c < 0 || c > a.length) {
					a.push(e);
				} else {
					var b = a.slice(c);
					a[c] = e;
					for (var d = 0; d < b.length; d++) {
						a[c + 1 + d] = b[d];
					}
				}
			},
			getFirstLower : function(a) {
				var e = "";
				if (a.indexOf("_") != -1) {
					var d = a.split("_");
					for (var c = 0; c < d.length; c++) {
						var b = d[c];
						if (c == 0) {
							e += b.toLowerCase();
						} else {
							e += b.substring(0, 1).toUpperCase()
									+ b.substring(1, b.length + 1)
											.toLowerCase();
						}
					}
				} else {
					e = a.toLowerCase();
				}
				return e;
			},
			getFirstUpper : function(a) {
				var e = "";
				if (a.indexOf("_") != -1) {
					var d = a.split("_");
					for (var c = 0; c < d.length; c++) {
						var b = d[c];
						e += b.substring(0, 1).toUpperCase()
								+ b.substring(1, b.length + 1).toLowerCase();
					}
				} else {
					e = a.substring(0, 1).toUpperCase()
							+ a.substring(1, a.length + 1).toLowerCase();
				}
				return e;
			},
			openFullWindow : function(b) {
				var c = screen.availHeight - 35;
				var a = screen.availWidth - 5;
				var e = "top=0,left=0,height="
						+ c
						+ ",width="
						+ a
						+ ",status=no,toolbar=no,menubar=no,location=no,resizable=1,scrollbars=1";
				var d = window.open(b, "", e, true);
				return d;
			},
			isEmpty : function(b, a) {
				return b === null || b === undefined || (!a ? b === "" : false);
			},
			convertCurrency : function(x) {
				var c = 99999999999.99;
				var B = "零";
				var F = "壹";
				var j = "贰";
				var k = "叁";
				var m = "肆";
				var H = "伍";
				var E = "陆";
				var A = "柒";
				var J = "捌";
				var C = "玖";
				var g = "拾";
				var q = "佰";
				var t = "仟";
				var f = "万";
				var h = "亿";
				var z = "";
				var w = "元";
				var e = "角";
				var u = "分";
				var y = "整";
				var b;
				var M;
				var v;
				var I;
				var K, o, s, r;
				var a;
				var G, D, L;
				var N, l;
				x = x.toString();
				if (x == "") {
					return "";
				}
				if (x.match(/[^,.\d]/) != null) {
					return "";
				}
				if ((x)
						.match(/^((\d{1,3}(,\d{3})*(.((\d{3},)*\d{1,3}))?)|(\d+(.\d+)?))$/) == null) {
					return "";
				}
				x = x.replace(/,/g, "");
				x = x.replace(/^0+/, "");
				if (Number(x) > c) {
					return "";
				}
				I = x.split(".");
				if (I.length > 1) {
					b = I[0];
					M = I[1];
					M = M.substr(0, 2);
				} else {
					b = I[0];
					M = "";
				}
				K = new Array(B, F, j, k, m, H, E, A, J, C);
				o = new Array("", g, q, t);
				s = new Array("", f, h);
				r = new Array(e, u);
				v = "";
				if (Number(b) > 0) {
					a = 0;
					for (G = 0; G < b.length; G++) {
						D = b.length - G - 1;
						L = b.substr(G, 1);
						N = D / 4;
						l = D % 4;
						if (L == "0") {
							a++;
						} else {
							if (a > 0) {
								v += K[0];
							}
							a = 0;
							v += K[Number(L)] + o[l];
						}
						if (l == 0 && a < 4) {
							v += s[N];
						}
					}
					v += w;
				}
				if (M != "") {
					for (G = 0; G < M.length; G++) {
						L = M.substr(G, 1);
						if (L != "0") {
							v += K[Number(L)] + r[G];
						}
					}
				}
				if (v == "") {
					v = B + w;
				}
				if (M == "") {
					v += y;
				}
				v = z + v;
				return v;
			},
			tagName : function(b, a) {
				var d = b.attributes, f = document.createElement(a);
				for (var e = 0, g; g = d[e++];) {
					if (!g.value || g.value == "null") {
						continue;
					}
					$(f).attr(g.name, g.value);
				}
				$(b).before($(f));
				$(b).remove();
				return $(f);
			},
			insertText : function(g, a) {
				if (document.selection) {
					var e = document.selection.createRange().text;
					if (!e) {
						e = a;
					}
					g.focus();
					if (e.charAt(e.length - 1) == " ") {
						e = e.substring(0, e.length - 1);
						document.selection.createRange().text = e + " ";
					} else {
						document.selection.createRange().text = e;
					}
				} else {
					if (g.selectionStart || g.selectionStart == "0") {
						var c = g.selectionStart;
						var b = g.selectionEnd;
						var f = (g.value).substring(c, b);
						if (!f) {
							f = a;
						}
						if (f.charAt(f.length - 1) == " ") {
							subst = f.substring(0, (f.length - 1)) + " ";
						} else {
							subst = f;
						}
						g.value = g.value.substring(0, c) + subst
								+ g.value.substring(b, g.value.length);
						g.focus();
						var d = c + (f.length);
						g.selectionStart = d;
						g.selectionEnd = d;
					} else {
						g.value += a;
						g.focus();
					}
				}
				if (g.createTextRange) {
					g.caretPos = document.selection.createRange().duplicate();
				}
			},
			confirm : function(a, b, c) {
				$(a).click(function() {
					if ($(this).hasClass("disabled")) {
						return false;
					}
					var d = this;
					$.ligerDialog.confirm(b, $lang.tip.msg, function(e) {
						if (e) {
							if ($.browser.msie) {
								$.gotoDialogPage(d.href);
							} else {
								location.href = d.href;
							}
						}
					});
					return false;
				});
			},
			gotoDialogPage : function(c) {
				if ($.browser.msie) {
					var b = document.createElement("a");
					b.href = c;
					document.body.appendChild(b);
					b.click();
				} else {
					location.href = c;
				}
			},
			cloneObject : function(b) {
				var c = b.constructor === Array ? [] : {};
				for ( var a in b) {
					if (b.hasOwnProperty(a)) {
						c[a] = typeof b[a] === "object" ? cloneObject(b[a])
								: b[a];
					}
				}
				return c;
			},
			clearQueryForm : function() {
				$("input[name^='Q_'],select[name^='Q_']").each(function() {
					$(this).val("");
				});
			},
			getFileExtName : function(b) {
				var a = b.lastIndexOf(".");
				if (a == -1) {
					return "";
				}
				return b.substring(a + 1);
			},
			comdify : function(a) {
				if (a && a != "") {
					n = a + "";
					var c = /\d{1,3}(?=(\d{3})+$)/g;
					var b = n.trim().replace(/^(\d+)((\.\d+)?)$/,
							function(f, e, d) {
								return e.replace(c, "$&,") + d;
							});
					return b;
				}
				return a;
			},
			toNumber : function(a) {
				if (a && a != "") {
					if (a.indexOf(",") == -1) {
						return a;
					}
					var b = a.split(",");
					var c = b.join("");
					return c;
				}
				return 0;
			},
			moveTr : function(e, d) {
				var c = $(e).parents("tr");
				if (d) {
					var b = $(c).prev();
					if (b) {
						c.insertBefore(b);
					}
				} else {
					var a = $(c).next();
					if (a) {
						c.insertAfter(a);
					}
				}
			}
		});
String.prototype.getNewUrl = function() {
	var c = new Date().getTime();
	var b = this;
	if (b.indexOf("#") != -1) {
		var a = b.lastIndexOf("#", b.length - 1);
		b = b.substring(0, a);
	}
	while (b.endWith("#")) {
		b = b.substring(0, b.length - 1);
	}
	b = b.replace(/(\?|&)rand=\d*/g, "");
	if (b.indexOf("?") == -1) {
		b += "?rand=" + c;
	} else {
		b += "&rand=" + c;
	}
	return b;
};
String.prototype.getSessionUrl = function() {
	var a = this;
	if (a.indexOf(";jsessionid=") != -1) {
		return a;
	}
	if (a.indexOf("?") == -1) {
		a += ";jsessionid=" + __jsessionid;
	} else {
		var b = a.split("?");
		a = b[0] + ";jsessionid=" + __jsessionId + "?" + b[1];
	}
	return a;
};
String.prototype.isEmpty = function() {
	var a = (this == null || this == undefined || this.trim() == "");
	return a;
};
String.prototype.trim = function() {
	return this.replace(/(^\s*)|(\s*$)/g, "");
};
String.prototype.lTrim = function() {
	return this.replace(/(^\s*)/g, "");
};
String.prototype.rTrim = function() {
	return this.replace(/(\s*$)/g, "");
};
String.prototype.endWith = function(c, b) {
	if (c == null || c == "" || this.length == 0 || c.length > this.length) {
		return false;
	}
	var a = this.substring(this.length - c.length);
	if (b == undefined || b) {
		return a == c;
	} else {
		return a.toLowerCase() == c.toLowerCase();
	}
};
String.prototype.startWith = function(c, b) {
	if (c == null || c == "" || this.length == 0 || c.length > this.length) {
		return false;
	}
	var a = this.substr(0, c.length);
	if (b == undefined || b) {
		return a == c;
	} else {
		return a.toLowerCase() == c.toLowerCase();
	}
};
String.prototype.leftPad = function(f, e) {
	if (!isNaN(e)) {
		var b = "";
		for (var d = this.length; d < e; d++) {
			b = b.concat(f);
		}
		b = b.concat(this);
		return b;
	}
	return null;
};
String.prototype.rightPad = function(f, e) {
	if (!isNaN(e)) {
		var b = this;
		for (var d = this.length; d < e; d++) {
			b = b.concat(f);
		}
		return b;
	}
	return null;
};
String.prototype.htmlEncode = function() {
	return this.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g,
			"&gt;").replace(/\"/g, "&#34;").replace(/\'/g, "&#39;");
};
String.prototype.htmlDecode = function() {
	return this.replace(/\&amp\;/g, "&").replace(/\&gt\;/g, ">").replace(
			/\&lt\;/g, "<").replace(/\&quot\;/g, "'").replace(/\&\#39\;/g, "'");
};
String.prototype.jsonEscape = function() {
	return this.replace(/\"/g, "&quot;").replace(/\n/g, "&nuot;");
};
String.prototype.jsonUnescape = function() {
	return this.replace(/&quot;/g, '"').replace(/&nuot;/g, "\n");
};
String.prototype.replaceAll = function(b, a) {
	return this.replace(new RegExp(b, "gm"), a);
};
String.prototype.getArgs = function() {
	var a = {};
	if (this.indexOf("?") > -1) {
		var j = this.split("?")[1], d = j.split("&");
		for (var b = 0, h; h = d[b++];) {
			var g = h.indexOf("=");
			if (g == -1) {
				continue;
			}
			var f = h.substring(0, g), e = h.substring(g + 1);
			e = decodeURIComponent(e);
			a[f] = e;
		}
	}
	return a;
};
String.format = function() {
	var b = arguments[0];
	var a = arguments;
	var c = b.replace(/\{(\d+)\}/g, function(d, f) {
		var e = parseInt(f) + 1;
		return a[e];
	});
	return c;
};
function StringBuffer() {
	this.content = new Array;
}
StringBuffer.prototype.append = function(a) {
	this.content.push(a);
};
StringBuffer.prototype.toString = function() {
	return this.content.join("");
};
Date.prototype.Format = function(b) {
	var c = b;
	var a = [ "日", "一", "二", "三", "四", "五", "六" ];
	c = c.replace(/yyyy|YYYY/, this.getFullYear());
	c = c.replace(/yy|YY/, (this.getYear() % 100) > 9 ? (this.getYear() % 100)
			.toString() : "0" + (this.getYear() % 100));
	c = c.replace(/MM/, (this.getMonth() + 1) > 9 ? (this.getMonth() + 1)
			.toString() : "0" + (this.getMonth() + 1));
	c = c.replace(/M/g, (this.getMonth() + 1));
	c = c.replace(/w|W/g, a[this.getDay()]);
	c = c.replace(/dd|DD/, this.getDate() > 9 ? this.getDate().toString() : "0"
			+ this.getDate());
	c = c.replace(/d|D/g, this.getDate());
	c = c.replace(/hh|HH/, this.getHours() > 9 ? this.getHours().toString()
			: "0" + this.getHours());
	c = c.replace(/h|H/g, this.getHours());
	c = c.replace(/mm/, this.getMinutes() > 9 ? this.getMinutes().toString()
			: "0" + this.getMinutes());
	c = c.replace(/m/g, this.getMinutes());
	c = c.replace(/ss|SS/, this.getSeconds() > 9 ? this.getSeconds().toString()
			: "0" + this.getSeconds());
	c = c.replace(/s|S/g, this.getSeconds());
	return c;
};
function daysBetween(a, p) {
	var b = "";
	var q = "";
	var o = "";
	var g = "";
	if (a != null && a != "") {
		var d = a.split(" ");
		b = d[0];
		if (d.length > 1) {
			o = d[1];
		}
	}
	if (p != null && p != "") {
		var u = p.split(" ");
		q = u[0];
		if (u.length > 1) {
			g = u[1];
		}
	}
	var v = 0;
	var j = 0;
	var w = 0;
	if (b != null && b != "") {
		var f = b.split("-");
		w = parseInt(f[0], 10);
		v = parseInt(f[1], 10);
		j = parseInt(f[2], 10);
	}
	var l = 0;
	var e = 0;
	var x = 0;
	if (q != null && q != "") {
		var f = q.split("-");
		x = parseInt(f[0], 10);
		l = parseInt(f[1], 10);
		e = parseInt(f[2], 10);
	}
	var s = 0;
	var i = 0;
	var m = 0;
	if (o != null && o != "") {
		var t = o.split(":");
		s = parseInt(t[0]);
		i = parseInt(t[1]);
		m = parseInt(t[2]);
	}
	var r = 0;
	var c = 0;
	var h = 0;
	if (g != null && g != "") {
		var t = g.split(":");
		r = parseInt(t[0]);
		c = parseInt(t[1]);
		h = parseInt(t[2]);
	}
	var k = x > w ? true : false;
	if (!k) {
		k = l > v ? true : false;
		if (!k) {
			k = e > j ? true : false;
			if (!k) {
				if (j == e) {
					k = r > s ? true : false;
					if (!k) {
						k = c > i ? true : false;
						if (!k) {
							k = h >= m ? true : false;
						}
					}
				} else {
					return false;
				}
			} else {
				return true;
			}
		}
	}
	return k;
}
jQuery.getMutilScript = function(g, h) {
	var b = function(i, j) {
		$.ajax({
			url : i,
			dataType : "script",
			success : j,
			async : false
		}).done(function() {
			j && j();
		});
	};
	var f = g.length, d = function() {
		c++;
	}, e = [], c = 0, a = 0;
	for (; a < f; a++) {
		e.push(b(g[a], d));
	}
	jQuery.when(e).done(function() {
		h && h();
	});
};
$(function() {
	try{
	if ($.browser.version == "6.0") {
		$("a.tipinfo").each(function() {
			$(this).mouseover(function() {
				$("span", $(this)).show();
			});
			$(this).mouseleave(function() {
				$("span", $(this)).hide();
			});
		});
	}
	}catch(e){};
});
jQuery.getWindowRect = function() {
	var b = 0, a = 0;
	if (typeof (window.innerWidth) == "number") {
		b = window.innerWidth;
		a = window.innerHeight;
	} else {
		if (document.documentElement
				&& (document.documentElement.clientWidth || document.documentElement.clientHeight)) {
			b = document.documentElement.clientWidth;
			a = document.documentElement.clientHeight;
		} else {
			if (document.body
					&& (document.body.clientWidth || document.body.clientHeight)) {
				b = document.body.clientWidth;
				a = document.body.clientHeight;
			}
		}
	}
	return {
		height : a,
		width : b
	};
};
function forbidF5(b) {
	var a = window.navigator.userAgent;
	if (a.indexOf(b) >= 0) {
		document.onkeydown = function(f) {
			var d = window.event || f;
			var c = d.keyCode || d.which;
			if (c == 116) {
				d.keyCode ? d.keyCode = 0 : d.which = 0;
				cancelBubble = true;
				return false;
			}
		};
	}
}
Date.prototype.format = function(b) {
	var c = {
		"M+" : this.getMonth() + 1,
		"d+" : this.getDate(),
		"h+" : this.getHours(),
		"m+" : this.getMinutes(),
		"s+" : this.getSeconds(),
		"q+" : Math.floor((this.getMonth() + 3) / 3),
		"S" : this.getMilliseconds()
	};
	if (/(y+)/.test(b)) {
		b = b.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	}
	for ( var a in c) {
		if (new RegExp("(" + a + ")").test(b)) {
			b = b.replace(RegExp.$1, RegExp.$1.length == 1 ? c[a]
					: ("00" + c[a]).substr(("" + c[a]).length));
		}
	}
	return b;
};

$('form.v2 input').on('change', function(){
	var $t = $(this);
	if ( $t.val() !== "" ) {
		$t.addClass('filled');
	} else {
		$t.removeClass('filled');
	}
})
