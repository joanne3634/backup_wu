var form = $('#dofrom');

Ink.requireModules( [ 'Ink.UI.FormValidator_2'], function( FormValidator ){
    form.on('submit', function(e) {
        e.preventDefault();
        setTimeout(function(){
            window.parent.iFrameHeight();
        },500);
    });

    $('#cancelBtn').on('click', function(e) {
        window.top.ipdIframeDialog.dismiss();
    });

    var sendFormValidator = new FormValidator( '#dofrom', {
        onSuccess : function(elements){
            var piisLeader = $("#piisLeader").val();
            var piinvest = $("#piinvest").val();
            var pfinancingAmount = $("#pfinancingAmount").val();
            var pinvestMaxLeader = $("#pinvestMaxLeader").val();//最大领投金额
            var investMoney =$("#investMoney").val();
            var checkFlag =$("#checkFlag").val();//审核标识 1有审核通过2无

            //**** 备注:看需不需要设置最高跟投上限.如果需要则在此判断.

            if("1"==checkFlag || 1==checkFlag){
                return renderError("#piinvest", "您的投资申请已通过审核,不能再进行追加了！");
            }

            if(piisLeader=='1'||piisLeader==1){//如果是领投人
                if(0 == parseFloat(pinvestMaxLeader)){
                    return renderError("#piinvest", "不能再进行领投追加了！");
                }
                if(parseFloat(piinvest)*parseFloat("10000")>parseFloat(pinvestMaxLeader)){
                    return renderError("#piinvest", "追加领投金额不能大于"+parseFloat(pinvestMaxLeader)/parseFloat("10000")+"万元!");
                }
            }
            var projectId=$("#projectId").val();
            var piisGeneralPartner= $('input[name="piisGeneralPartner"]:checked').val();
            if(eval(pfinancingAmount)<eval(piinvest)){
                return renderError("#piinvest", "项目追投金额不能高于项目剩余可投金额!(目前可投"+pfinancingAmount+"万)");
            }
            $.ajax({
                url : _ctx + "/crowdfunding/front/updateInvest.ht",
                type : 'post',
                data : 'projectId=' + projectId + '&piisGeneralPartner='+piisGeneralPartner+
                '&piinvest='+piinvest,
                dataType : 'html',
                success : function(data, status) {
                    var msg = '';
                    if(eval(data)==eval('3')){
                        msg = '您的投资申请已审核通过，不能再进行追加投资!';
                    }else if(eval(data)==eval('1')){
                        msg = '追加跟投资金成!';
                    }else if(eval(data)==eval('2')) {
                        msg = '操作异常,请联系客服人员!';
                    }else if(eval(data)==eval('-1')){
                        msg = '追加金额超过募集上限,请重新输入!';
                    }else{
                        msg = '操作异常,请联系客服人员!';
                    }
                    window.top.$.Dialog.toast({
                        content: msg,
                        onDismiss: function() {
                            window.parent.window.location = _ctx + '/crowdfunding/front/toProDetails.ht?projectId='+projectId;
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