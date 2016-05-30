var $alert =  $('#login-alert'), $alertContent = $('#login-alert-content');
function login_form_submit_enter_event(e){
    var keyCode = e.keyCode?e.keyCode:e.which?e.which:e.charCode;
    if(keyCode == 13) {
        $('#loginForm').submit();
    }
}

Ink.requireModules( ['Ink.UI.FormValidator_2'], function( FormValidator ){
    var from = $('#loginForm');

    from.on('submit', function(e) {
        e.preventDefault();
    });

    var loginFormValidator = new FormValidator( '#loginForm', {
        onSuccess : function(elements){
            $.ajax({
                url : from.attr('action'),
                type : from.attr('method'),
                data : from.serialize(),
                dataType : 'json',
                beforeSend:function(){
                    $("#submitBtn").val('用户登录中...');
                }
            }).done(function(data) {
                if (data == "0") {
                    if(loginPreUrl != ''){
                        setTimeout('window.location= loginPreUrl',0);
                    }else{
                        var urlStr = referer;
                        var ctxStr = serverName;
                        if(urlStr.indexOf(ctxStr)>0){
                            if(urlStr.indexOf("loginWeb")>0){
                                setTimeout(function(){window.location.href= _ctx + "/loan/myAccount/myaccountPage.ht"},0);
                            }else{
                                setTimeout(function(){window.location.href= urlStr },0);
                            }
                        }else{
                            setTimeout(function(){window.location= _ctx+"/index-web.jsp"},0);
                        }
                    }
                }else{
                    $("#submitBtn").val('登 录');
                    setTimeout('reload();',0);
                    $alert.css("display","block");
                    $alertContent.html(data);
                    $("input#code").val("");
                }
            });
        },
        onError: function(elements){
        }
    } );
});