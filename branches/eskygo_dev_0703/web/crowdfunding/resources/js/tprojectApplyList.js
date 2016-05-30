/**
 * 领投信息确认
 */
function leadConfirm(projectId){
    var url=_ctx+'/crowdfunding/projectApply/checkTheLeadList.ht?projectId='+projectId;
    window.top.$.Dialog.modalIframe({
        url: url,
        title: "领投信息确认",
        width: '880px',
        height: '600px'
    });
}
/**
 * 跟投信息确认
 */
function voteConfirm(projectId){
    var url=_ctx+'/crowdfunding/projectApply/checkTheFollowList.ht?projectId='+projectId;
    window.top.$.Dialog.modalIframe({
        url: url,
        title: "跟投信息确认",
        width: '880px',
        height: '600px'
    });
}
/**
 * 项目查看申请确认
 */
function projectInfoConfirm(projectId){
    var url=_ctx+'/crowdfunding/projectApply/checkTheViewList.ht?projectId='+projectId;
    window.top.$.Dialog.modalIframe({
        url: url,
        title: "项目查看申请确认",
        width: '880px',
        height: '600px'
    });
}
/**
 * 查看投资人
 */
function investorsInfo(projectId){
    var url=_ctx+'/crowdfunding/tuser/investorInfo.ht?projectId='+projectId;
    window.top.$.Dialog.modalIframe({
        url: url,
        title: "查看投资人",
        width: '880px',
        height: '600px'
    });
}



