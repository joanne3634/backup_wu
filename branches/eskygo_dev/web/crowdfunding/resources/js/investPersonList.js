//私信详情显示层
function loadPagesSendMsgremind(p){

    $.ajax({
        url : _ctx + "/user/valiLoginTimeout.ht",
        type : 'post',
        dataType : 'json',
        success : function(data) {
            if(data){
                if(p ==""){
                    return;
                }
                $.Dialog.modalIframe({
                    url: _ctx + '/crowdfunding/front/openSendInfoWin.ht?receiverId=' + p + '&type_id=1',
                    title: "发私信",
                    width: '650px',
                    height: '420px'
                });
            }else{
                window.parent.location.href = _ctx+'/loginWeb.jsp';
            }
        }
    });

}


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



