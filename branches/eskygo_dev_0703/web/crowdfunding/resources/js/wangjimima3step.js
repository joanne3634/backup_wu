$().ready(function() {

    if(_success != ""){
        window.top.$.Dialog.toast({
            title: "提示",
            content: _success,
            onDismiss: function() {
                window.location = _ctx+"/loginWeb.jsp";
            }
        });
        setTimeout(function(){
            window.location = _ctx+"/loginWeb.jsp";
        },2000);
    }

});


Ink.requireModules( [ 'Ink.UI.FormValidator_2'], function( FormValidator ){
    //手机号码
    var reset_pass_form_Validator = new FormValidator( '#reset_pass_form', {

    } );
});

