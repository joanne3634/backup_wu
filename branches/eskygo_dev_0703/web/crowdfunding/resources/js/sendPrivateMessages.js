var form = $('#sendForm');

Ink.requireModules( [ 'Ink.UI.FormValidator_2'], function( FormValidator ){
    form.on('submit', function(e) {
        e.preventDefault();
        valiLoginTimeout();
    });

    var sendFormValidator = new FormValidator( '#sendForm', {
        onSuccess : function(elements){
            var receiverId=$("#receiverId").val();
            var content_id=$("#content_id").val();
            var projectId=$("#projectId").val();
            var type_id=$("#type_id").val();

            $.ajax({
                url : form.attr('action'),
                type : form.attr('method'),
                data : form.serialize(),
                dataType : 'json',
                success : function(data, status) {
                    var url = _ctx + "/crowdfunding/tcuserInvestor/tcuserInvestorPage.ht";
                    if(projectId != "") {
                        url = _ctx + "/crowdfunding/front/toProDetails.ht?projectId=" + projectId;
                    }
                    window.top.$.Dialog.toast({
                        title: "提示",
                        content: data,
                        onDismiss: function() {
                            window.parent.location = url;
                        }
                    });
                    setTimeout(function(){
                        window.parent.location = url;
                    },5000);
                },
                error : function(xhr, textStatus, errorThrown) {
                }
            });
        },
        onError: function(elements){
        }
    } );
});