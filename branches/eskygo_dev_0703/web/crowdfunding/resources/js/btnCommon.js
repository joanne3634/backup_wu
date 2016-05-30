/**
 *发私信
 */
function sendMessage(creator,projectId){
    var url=_ctx+'/crowdfunding/front/openSendInfoWin.ht?receiverId='+creator+'&projectId='+projectId+'&type_id=1';
    window.top.$.Dialog.modalIframe({
        url: url,
        title: "发私信",
        width: '500px',
        height: '420px'
    });
}
/**
 * 约谈项目方|再次约谈
 */
function aboutEntrepre(createrId,projectId,sendTime){
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
        }else{
            $.ajax({
                url : _ctx+"/crowdfunding/front/tcprojectinvest/timeLimit.ht?sendTime="+sendTime+"&projectId="+projectId,
                type : 'post',
                success : function(data) {
                    if(data=="0"){
                        window.top.$.Dialog.toast({
                            title: "提示",
                            content: "24小时内只能约谈一次",
                            onDismiss: function() {
                                window.location.reload();
                            }
                        });
                    }else if(data=="1"){
                        var url=_ctx+"/crowdfunding/front/tcprojectinvest/aboutEntrepre.ht?createrId="+createrId+"&projectId="+projectId+"&sendTime="+sendTime;
                        window.top.$.Dialog.modalIframe({
                            url: url,
                            title: "约谈项目方",
                            width: '500px',
                            height: '420px'
                        });
                    }
                    setTimeout(function(){
                        window.location.reload();
                    },5000);
                }
            });

        }

    });
}


/**
 *我要付款
 */

function openPostWindow(url, data, name,investId){
    var tempForm = document.createElement("form");
    tempForm.id="tempForm1";
    tempForm.method="post";
    tempForm.action=url;
    tempForm.target=name;

    var hideInput = document.createElement("input");
    hideInput.type="hidden";
    hideInput.name= "projectId";
    hideInput.value= data;
    tempForm.appendChild(hideInput);

    var hideInput1 = document.createElement("input");
    hideInput1.type="hidden";
    hideInput1.name= "investId";
    hideInput1.value= investId;
    tempForm.appendChild(hideInput1);

    document.body.appendChild(tempForm);
    tempForm.submit();
}

function payMoney(projectid,investId){
    window.top.$.Dialog.confirm('提示','你确定要付款吗', function(){

        url=_ctx+"/crowdfunding/front/tcprojectinvest/toPayment.ht";

        openPostWindow(url,projectid,"_blank",investId);

        window.top.$.Dialog.bankConfirm(function () {
            window.top.location = _ctx + '/loan/myAccount/myaccountPage.ht?forwordUrl=investRecord';
        }, function () {
            window.top.location = _ctx + '/loan/aboutus/HelpCenterList.ht';
        }, function () {
            window.location.reload(false);
        });

    });


}

