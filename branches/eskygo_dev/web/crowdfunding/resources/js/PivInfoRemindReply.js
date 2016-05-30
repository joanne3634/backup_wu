var form = $('#sendForm');


Ink.requireModules( [ 'Ink.UI.FormValidator_2'], function( FormValidator ){
    form.on('submit', function(e) {
        e.preventDefault();
    });

    var sendFormValidator = new FormValidator( '#sendForm', {
        onSuccess : function(elements){
            $.ajax({
                url : form.attr('action'),
                type : form.attr('method'),
                data : form.serialize(),
                dataType : 'json',
                success : function(data,textStatus) {
                    if(data == "1"){
                        window.top.$.Dialog.toast({
                            title: "提示",
                            content: "信息发送成功",
                            onDismiss: function() {
                                window.parent.location.reload();
                            }
                        });
                        setTimeout(function(){
                            window.parent.location.reload();
                        },5000);
                    }else if(data=="2"){
                        renderError('#receiverName',"收信人不存在,请填写收信人登陆名");
                    }
                },
                error : function(XMLHttpRequest, textStatus, errorThrown) {
                    alert(XMLHttpRequest.statusText);
                }
            });
        },
        onError: function(elements){
        }
    } );
});