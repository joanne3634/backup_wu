$().ready(function() {
    if(_error != ""){
        window.top.$.Dialog.toast({
            title: "提示",
            content: _error,
            onDismiss: function() {
                //window.location.reload();
            }
        });
    }

});


Ink.requireModules( [ 'Ink.UI.FormValidator_2'], function( FormValidator ){
    //手机号码
    var mobile_find_pass_Validator = new FormValidator( '#mobile_find_pass', {

    } );
    //邮箱地址
    var email_find_passForm_Validator = new FormValidator( '#email_find_pass', {

    } );
    //安全问题
    var quesion_find_passForm_Validator = new FormValidator( '#quesion_find_pass', {

    } );
});



function sendEmailCode() {
    var password = $("input[name='loginPwd']").val();
    if(password == ""){
        alert("请输入登录密码");
        return;
    }
    $.ajax({
        url : "${ctx}/safe/sendEmailValiCode.ht",
        type : 'post',
        data : "",
        dataType : 'html',
        success : function(data, status) {
            var datas = eval(data);
            if(datas == "0"){
                alert("验证码已发送，请注意查收");
            }else{alert(datas);}
        },
        error : function(xhr, textStatus, errorThrown) {
            alert('发送失败');
        }
    });
}

function validateEmailCode() {
    var code = $("input[name='code']").val();
    var validCode = $("#validCode").val();
    var password = $("input[name='loginPwd']").val();

    $.ajax({
        url : "${ctx}/safe/validateEmailCode.ht",
        type : 'post',
        data : 'code=' + code + '&validCode=' + validCode + '&password=' + password,
        dataType : 'html',
        success : function(data, status) {
            var datas = eval(data);
            if (datas == "0") {
                alert("绑定邮箱成功");
                location.reload();
            }else{
                alert(datas);
            }
        },
        error : function(xhr, textStatus, errorThrown) {
            alert('绑定异常，请联系管理员');
        }
    });
}


function show(){
    var obj = _identifying;
    if(obj != ""){
        //$("#findWays a").removeClass("yxzh-btn-hover");
        //$("#findWays a").removeClass("sjzh-btn-hover");
        //$("#findWays a").removeClass("mbzh-btn-hover");
        //$("#" + obj).addClass($("#" + obj).attr("id")+"-hover");
        //$(".zhmm-inputlist").css("display","none");
        //$("."+obj).show();

        $("#" + obj).addClass('active').siblings().removeClass('active');
        $(".zhmm-inputlist").css("display","none");
        $("."+obj).show();
    }
}
$(function(){
    $("#findWays a").bind("click",function(){

        //$("#findWays a").removeClass("yxzh-btn-hover");
        //$("#findWays a").removeClass("sjzh-btn-hover");
        //$("#findWays a").removeClass("mbzh-btn-hover");
        //$(this).addClass($(this).attr("id")+"-hover");
        //$(".zhmm-inputlist").css("display","none");
        //$("."+$(this).attr("id")).show();


        $(this).addClass('active').siblings().removeClass('active');
        $(".zhmm-inputlist").css("display","none");
        $("."+$(this).attr("id")).show();
    });
    show();


})
