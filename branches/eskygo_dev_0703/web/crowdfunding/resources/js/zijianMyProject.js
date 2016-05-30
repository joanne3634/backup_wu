var form = $('#recomendForm');


Ink.requireModules( [ 'Ink.UI.FormValidator_2'], function( FormValidator ){
    form.on('submit', function(e) {
        e.preventDefault();
    });

    var sendFormValidator = new FormValidator( '#recomendForm', {
        onSuccess : function(elements){
            $.getJSON(_ctx+"/user/validateCode.ht",{"code":$('#code').val()})
                .done(function(data){
                if(data) {
                    $.ajax({
                        url : form.attr('action'),
                        type : form.attr('method'),
                        data : form.serialize(),
                        dataType : 'json',
                        success : function(data,textStatus) {
                            var url = _ctx + "/crowdfunding/tcuserInvestor/tcuserInvestorPage.ht";
                            window.top.$.Dialog.toast({
                                title: "提示",
                                content: data,
                                onDismiss: function() {
                                    window.parent.location = url;
                                }
                            });
                            setTimeout(function(){
                                window.parent.location = url;
                            },2000);
                        },
                        error : function(XMLHttpRequest, textStatus, errorThrown) {
                            alert(XMLHttpRequest.statusText);
                        }
                    });
                } else {
                    renderError('#code',"验证码输入不正确");
                    reload();
                }
            });
        },
        onError: function(elements){
        }
    } );
});
