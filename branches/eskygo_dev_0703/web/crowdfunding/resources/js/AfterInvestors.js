/**
 * 投后管理 【查看】
 */
function detail(afterId){
    var url=_ctx+'/crowdfunding/tcprojectAfter/investorAfterDeail.ht?afterId='+afterId;
    window.top.$.Dialog.modalIframe({
        url: url,
        title: "投后管理详情",
        width: '700px',
        height: '500px'
    });
}

