//发送私信
function sendMessage(creator,projectId){
    var url=_ctx+'/crowdfunding/front/openSendInfoWin.ht?receiverId='+creator+'&projectId='+projectId+'&type_id=1';
    window.top.$.Dialog.modalIframe({
        url: url,
        title: "发私信",
        width: '500px',
        height: '420px'
    });
}

function cancelCollect(AttentionId){
    window.top.$.Dialog.confirm('提示','你确定要取消收藏', function(){
        $.ajax({
            url : _ctx+"/crowdfunding/front/tcprojectinvest/cancelCollect.ht?AttentionId="+AttentionId,
            type : 'post',
            success : function(data) {
                window.top.$.Dialog.toast({
                    title: "提示",
                    content: data,
                    onDismiss: function() {
                        window.location.reload();
                    }
                });
                setTimeout(function(){
                    window.location.reload();
                },5000);
            }
        });
    });
}

//约谈项目方
function aboutEntrepre(createrId,projectId){
    window.top.$.Dialog.confirm('提示','你确定要约谈项目方', function(){
        //1：项目方 2：投资者
        if(groupId === '1') {
            window.top.$.Dialog.toast({
                title: "提示",
                content: '对不起， 项目方不能向别的项目发起约谈!',
                onDismiss: function() {
                    window.location.reload();
                }
            });
        }
        //valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
        //var url= _ctx + '/crowdfunding/front/openSendInfoWin.ht?receiverId='+createrId+'&projectId='+projectId+'&type_id=2';
        //
        //window.top.$.Dialog.modalIframe({
        //    url: url,
        //    title: "约谈项目方"
        //    //width: '500px',
        //    //height: '420px'
        //});

        window.top.$.Dialog.modalIframe({
            url: _ctx+"/crowdfunding/front/tcprojectinvest/aboutEntrepre.ht?createrId="+createrId+"&projectId="+projectId,
            title: "约谈项目方",
            width: '500px',
            height: '420px'
        });
    });
}