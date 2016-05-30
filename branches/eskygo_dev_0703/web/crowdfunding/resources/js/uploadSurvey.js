var form = $('#sendForm');

Ink.requireModules( [ 'Ink.UI.FormValidator_2'], function( FormValidator ){
    form.on('submit', function(e) {
        e.preventDefault();
        valiLoginTimeout();
    });

    FormValidator.setRule('fileRequire', '附件不能为空', function( value ){
      if(document.getElementById("fileNameAtt").innerHTML==""){
          return false;
      }else{
          return true;
      }
    });

    var sendFormValidator = new FormValidator( '#sendForm', {
        onSuccess : function(elements){

            $.ajax({
                url : _ctx+"/crowdfunding/front/tcprojectinvest/saveUploadSurvey.ht",
                type : form.attr('method'),
                data : form.serialize(),
                dataType : 'json',
                success : function(data, status) {
                    var dialog = window.top.$.Dialog.toast({
                        title: "提示",
                        content: data,
                        onDismiss: function() {
                            window.top.leadProj_IframeDialog.dismiss();
                        }
                    });
                },
                error : function(xhr, textStatus, errorThrown) {
                }
            });
        },
        onError: function(elements){
        }
    } );
});




function dosubmit(){

    var fileName=$("#fileName").val();
    if(fileName==''){
        $("#_warninput3").html("<font color='red'>请先上传附件!</font>");
        return;
    }

    document.getElementById("sendForm").submit();
}

