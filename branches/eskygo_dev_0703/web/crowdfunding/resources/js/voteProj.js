/**
 * 取消跟投
 **/
function cancelVote(investId,pid,askPrice){
    window.top.$.Dialog.confirm('提示','你确定要取消跟投吗？,反悔后将失去项目认筹资格</br>&nbsp;要取得认筹资格就得重新缴纳认筹诚意金'+askPrice+'元,你确定要反悔吗？', function() {
        $.ajax({
            url : _ctx+"/crowdfunding/front/tcprojectinvest/cancelVote.ht",
            type : 'post',
            dataType : 'json',
            data:{investId:investId,projectid:pid},
            success : function(data) {
                window.top.$.Dialog.toast({
                    width:'400px',
                    height:'300px',
                    title: "提示",
                    content: data,
                    onDismiss: function() {
                        window.location.reload();
                    }
                });
                setTimeout(function(){
                    window.location.reload();
                },3000);
            }
        });

    });

}