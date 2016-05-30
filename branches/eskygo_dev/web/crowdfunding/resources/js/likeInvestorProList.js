//显示投资人详情显示层
function loadPagesDetails(p,d){
    if(p ==""){
        return;
    }
    $.Dialog.modalIframe({
        url: _ctx + '/crowdfunding/tcuserInvestor/tcuserInvestorPageDetails.ht?userId='+p,
        title: d + '详细资料',
        width: '500px',
        height: '420px'
    });
}

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
                    url: _ctx + '/crowdfunding/front/openSendInfoWin.ht?receiverId=' + p,
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

//自荐项目显示层
function loadPageszijianMyProject(p){

    $.ajax({
        url : _ctx + "/user/valiLoginTimeout.ht",
        type : 'post',
        dataType : 'json',
        success : function(data) {
            if(!data){
                window.parent.location.href = _ctx + '/loginWeb.jsp';
            }else{
                if(p ==""){
                    return;
                }
                $.Dialog.modalIframe({
                    url: _ctx+'/crowdfunding/tcuserInvestor/zijianMyProjectPage.ht?receiverId='+p,
                    title: "推荐我的项目",
                    width: '620px',
                    height: '500px'
                });
            }
        }
    });

}
