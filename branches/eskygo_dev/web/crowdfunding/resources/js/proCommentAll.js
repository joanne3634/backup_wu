


$('i.fa.fa-envelope-o').on('click', function(e){
    valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
    if(isLogin) {
        var _val=$(this).data('value');
        var _id=$(this).data("id");
        var projectId=$("#projectId").val();
        var url= _ctx + '/crowdfunding/front/openSendInfoWin.ht?receiverId='+_val+'&projectId='+projectId+'&type_id=1';
        window.top.$.Dialog.modalIframe({
            title: '发私信',
            url: url,
            width: '500px',
            height: '420px'
        });
    }
});



