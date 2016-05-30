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
    var quesion_verify_form_Validator = new FormValidator( '#quesion_verify_form', {

    } );
});

