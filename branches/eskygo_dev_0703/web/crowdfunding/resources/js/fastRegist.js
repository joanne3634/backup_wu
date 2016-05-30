var form = $('#fastRegistForm'), $alert =  $('#register-alert'), $alertContent = $('#register-alert-content'), $submitBtn = $('#submitBtn');

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
        						if("验证码已发送，请查收"==datas){
        							time(self);
        						}
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

    var registerFormValidator = new FormValidator( '#fastRegistForm', {
        onSuccess : function(elements){
            $.when($.getJSON(_ctx+"/user/validateUserName.ht",{"loginName":$('#loginName').val()}),
                $.getJSON(_ctx+"/user/validatePhone.ht",{mobile: $("#mobile").val()}))
                //$.getJSON(_ctx+"/user/validateCode.ht",{valiCode_: $("#code").val()}))
                .done(function(loginNameRes,  mobileRes) {
                    if(loginNameRes[0] == false) {
                        return renderError("#loginName", "该会员已被注册,请更换会员");
                    } else {
                        clearError("#loginName");
                    }
                    if(mobileRes[0] == false) {
                        return renderError("#mobile", "该手机号已存在，请重新输入");
                    } else {
                        clearError("#mobile");
                    }
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
        	alert(11);
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