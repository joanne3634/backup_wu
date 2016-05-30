var form = $('#registerForm'), $alert =  $('#register-alert'), $alertContent = $('#register-alert-content'), $submitBtn = $('#submitBtn');

Ink.requireModules( ['Ink.Dom.Selector_1','Ink.UI.Modal_1', 'Ink.UI.FormValidator_2'], function( Selector, Modal, FormValidator ){
    var modalElement = Ink.s('#protocolModal');
    var rsiskNotice = Ink.s("#riskNotice");
    var modalObj = new Modal( modalElement, {
        responsive: true,
        onShow: function(){
            $('#modalContent iframe').css('height', $('#modalContent').height());
        },
        onDismiss: function() {
            $('#protocol input[type="checkbox"]').attr('checked',true);
        }
    });

    var riskNoticeObj=new Modal(rsiskNotice,{
        responsive: true,
        onShow: function(){
            $('#noticeContent iframe').css('height', $('#noticeContent').height());
        },
        onDismiss: function() {
            $('#protocol input[type="checkbox"]').attr('checked',true);
        }
    });
    
    var wait = 60;
    function time(o) {
    	if (wait == 0) {
    		o.removeAttr("disabled");
    		o.html('获取验证码');
    		wait = 60;
    	} else {
    		o.attr('disabled', true);
    		o.html(['重新发送(',wait, ')'].join(''));
    		wait--;
    		setTimeout(function() {
    			time(o)
    		}, 1000)
    	}
    }
    
	// 向输入的绑定手机号码发送短信 、、、、、(验证码)
    $('#btn-msgcode').on('click', function(e) {
    	var self = $(this);
    	var mobileElement = registerFormValidator.getElements().mobile;
    	var mobile = $("#mobile").val();
    	if(mobileElement[0].validate()) {
    		$.ajax({
    			url : _ctx + "/safe/validatePhone.ht",
    			method: 'post',
    			dataType: 'json',
    			data : {
    				phone : mobile
    			}
    		}).done(function(data){
    			$.ajax({
        			url : _ctx + "/safe/sendPhoneValiCode.ht",
        			type : 'post',
        			data : { phone : mobile },
        			dataType : 'html',
        			success : function(data, status) {
        				var datas = eval(data);
        				window.top.$.Dialog.toast({
        					title : "提示",
        					content : datas,
        					onDismiss : function() {
        					}
        				});

        			},
        			error : function(xhr, textStatus, errorThrown) {
        				window.top.$.Dialog.toast({
        					title : "提示",
        					content : "发送异常，请重试",
        					onDismiss : function() {
        					}
        				});
        			},
        			beforeSend : function() {
        				time(self);
        			}
        		});
    		}) 
    	} else {
    		mobileElement[0].displayErrors();
    	}
    });

    form.on('submit', function(e) {
        e.preventDefault();
    });

    var registerFormValidator = new FormValidator( '#registerForm', {
        onSuccess : function(elements){
            $.when($.getJSON(_ctx+"/user/validateUserName.ht",{"loginName":$('#loginName').val()}),
                $.getJSON(_ctx+"/user/validateEmail.ht",{"email":$('#email').val()}),
                function(){
                    if($('input[name="isCompany"]:checked').val() === "0") {
                        return $.post(_ctx+"/user/verifyIdNo.ht",{realName: $("#realName").val(), idNo:$("#idNo").val()})
                    } else {
                        return [true];
                    }
                }(),
                $.getJSON(_ctx+"/user/validatePhone.ht",{mobile: $("#mobile").val()}))
                //$.getJSON(_ctx+"/user/validateCode.ht",{valiCode_: $("#code").val()}))
                .done(function(loginNameRes, emailRes, verifyIdNoRes, mobileRes) {
                    if(loginNameRes[0] == false) {
                        return renderError("#loginName", "该会员已被注册,请更换会员");
                    } else {
                        clearError("#loginName");
                    }
                    if(emailRes[0] == false) {
                        return renderError("#email", "该邮箱已存在，请重新输入");
                    } else {
                        clearError("#email");
                    }
                    if(verifyIdNoRes[0] == "false") {
                        return renderError("#idNo", "姓名与身份证号不匹配");
                    } else {
                        clearError("#idNo");
                    }
                    if(mobileRes[0] == false) {
                        return renderError("#mobile", "该手机号已存在，请重新输入");
                    } else {
                        clearError("#mobile");
                    }
                    //if(codeRes == 0) {
                    //    return renderError("#code", "请输入正确的验证码");
                    //} else {
                    //    clearError("#code");
                    //}
                    $submitBtn.attr('disabled', true);

                    $.ajax({
                        url: form.attr("action"),
                        type: 'post',
                        timeout: 15000,
                        data: form.serialize(),
                        dataType: 'json',
                        success: function (data, textStatus) {
                            $alert.css("display","none");
                            $alertContent.html("");
                            if (data == "0") {
                                window.location = _ctx+"/loan/myAccount/myaccountPage.ht";
                            } else if(data == "短信验证码输入有误"){
                            	return renderError("#msgcode", "短信验证码输入有误");
                            } else {
                                $submitBtn.html('立即注册');
                                $alert.css("display","block");
                                $alertContent.html(data);
                                setTimeout('reload();',0);
                            }

                        },
                        complete: function (XMLHttpRequest, status) { //请求完成后最终执行参数
                            if (status == 'timeout') {//超时,status还有success,error等值的情况
                                $alert.css("display","block");
                                $alertContent.html("连接超时,请重试!");
                            }
                            $submitBtn.removeAttr("disabled");
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            $alert.css("display","block");
                            $alertContent.html("注册异常，请重试!");
                        },
                        beforeSend: function () {
                            $submitBtn.html('注册中...');
                        }
                    });
                })
        },
        onError: function(elements){
        }
    } );
});

$('#protocol input[type="checkbox"]').on('click', function () {
    if ($(this).is(':checked')) {
        $submitBtn.removeAttr('disabled');
    } else {
        $submitBtn.attr('disabled', true);
    }
});

$('input[name="isCompany"]').on("change", function(e){
    var value = $(this).val();
    $('p.tip').remove();
    $('.control-group').removeClass('validation error');
    if(value === "0") {
        $('label[for="remarks"]').text('个人说明：');
        $("#desc").html("建议采用公司+职务+真实姓名");
        $('label[for="contactName"]').text('真实姓名：');
        $('label[for="contactName"]').attr('for',"realName");
        $('#realName').removeAttr('disabled');
        $('#realName').css('display','inline-block');
        $('#contactName').attr('disabled', true);
        $('#contactName').css('display','none');

        $('label[for="personalAddress"]').text('个人地址：');
        $('label[for="businessLicense"]').text('身份证号：');
        $('label[for="businessLicense"]').attr('for',"idNo");
        $("#idNo").removeAttr('disabled');
        $("#idNo").css('display', 'inline-block');
        $('#businessLicense').attr('disabled', true);
        $('#businessLicense').css('display','none');
    } else {
        $('label[for="remarks"]').text('机构说明：');
        $("#desc").html("建议采用公司全称");
        $('label[for="realName"]').text('联系人姓名：');
        $('label[for="realName"]').attr('for',"contactName");
        $('#contactName').removeAttr('disabled');
        $('#contactName').css('display','inline-block');
        $('#realName').attr('disabled', true);
        $('#realName').css('display','none');
        $('label[for="personalAddress"]').text('公司地址：');
        $('label[for="idNo"]').text('营业执照号码：');
        $('label[for="idNo"]').attr('for',"businessLicense");
        $("#businessLicense").removeAttr('disabled');
        $("#businessLicense").css('display', 'inline-block');
        $('#idNo').attr('disabled', true);
        $('#idNo').css('display','none');
    }
});

var selectCity = $("#cityId");

$("#provincesId").on("change", function(){
    var value = $(this).val();
    if(value == ""){
        selectCity.val("");
        selectCity.html("");
        return;
    }
    $.ajax({
        url : _ctx+"/user/ajaxGetJilian.ht",
        type : 'post',
        data : "areaId=" + value,
        dataType : 'json',
        success : function(data) {
            var html = "<option value=''></option>";
            if(data.length > 0){
                for ( var i = 0; i < data.length; i++) {
                    html += "<option value='" + data[i].areaId + "'>" + data[i].areaName + "</option>";
                }
            }
            selectCity.html(html);
        },
        error : function(xhr, textStatus, errorThrown) {
            //alert('异步获取数据出现异常');
        }
    });
});

function valideCode(obj){
	var code = $("#code").val();
	if(code.length != 4){
		return;
	}
	if(''==code || undefined==code || null==code){
		return renderError("#code", "请输入验证码！");
	} else {
		clearError('#code');
	}
	
	$.ajax({
		url : _ctx + "/user/valideCode.ht",
		type : 'post',
		data : { code : code },
		success : function(data, status) {
			if('success'==data){
				clearError("#loginName");
				$("#msgcodeDiv").attr("style", "display:block");
			}else{
				return renderError("#code", data);
			}
		}
	});
}