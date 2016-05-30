/**
 *取消领投
 */
function cancelLed(investId,pid,askPrice){

    window.top.$.Dialog.confirm('提示','你确定要取消领投吗?,反悔后将失去项目认筹资格</br>要取得项目认筹资格就得重新缴纳认筹诚意金 '+askPrice+'元,你确定要反悔吗？', function() {
        $.ajax({
            url : _ctx+"/crowdfunding/front/tcprojectinvest/cancelLed.ht",
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

/**
 * 上传调查报告与评价
 */
function uploadSurvey(projectid,investId){
    //检查当前用户是否有查看项目的权限
    $.ajax({
        url : _ctx+"/crowdfunding/projectApply/checkViewProjectPrivilage.ht",
        type : 'post',
        async:false,
        dataType : 'json',
        data:{projectId:projectid},
        success : function(data) {
            if(data=="yes"){
                window.top.leadProj_IframeDialog =  window.top.$.Dialog.modalIframe({
                    url: _ctx+"/crowdfunding/front/tcprojectinvest/uploadSurvey.ht?projectId="+projectid+"&investId="+investId,
                    title: "上传调查报告与评价",
                    width: '700px',
                    height: '800px'
                });
            }else{
                window.top.$.Dialog.toast({
                    title: "提示",
                    content: '对不起， 您没有权限上传调查报告与评价!',
                    onDismiss: function() {
                        window.location.reload();
                    }
                });
            }

        }
    });
}
