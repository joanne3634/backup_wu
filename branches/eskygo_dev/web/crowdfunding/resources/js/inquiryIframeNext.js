var form = $('#dofrom');

function loadCms(menupath,contentTitle){
    var url = encodeURI(encodeURI(_ctx + "/loan/aboutus/HelpCenterDetails.ht?menupath="+menupath+"&contentTitle="+contentTitle));
    window.top.open(url);
}

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
            var piisLeader=$("#piisLeader").val();
            var piinvest=$("#piinvest").val();
            var pinvestMinLeader=$("#pinvestMinLeader").val();//最低领投金额
            var pinvestMaxLeader=$("#pinvestMaxLeader").val();//最大领投金额
            var pinvestMinFollow=$("#pinvestMinFollow").val();//最低跟投金额
            var pfinancingAmount=$("#pfinancingAmount").val();//项目融资金额
            var piisGeneralPartner= "";
            if(piisLeader=='1'||piisLeader==1){//如果是领投人
                //如果领投部分 判断领投金额是否小于项目要求的最低领投额

                if($('#pitypeId_1').is(':checked')){//是否部分领投
                    if(parseFloat(piinvest)*parseFloat("10000")<parseFloat(pinvestMinLeader)){
                        return renderError("#piinvest", "领投金额不能小于"+parseFloat(pinvestMinLeader)/parseFloat("10000")+"万元!");
                    }
                    if(parseFloat(piinvest)*parseFloat("10000")>parseFloat(pinvestMaxLeader)){
                        return renderError("#piinvest", "领投金额不能大于"+parseFloat(pinvestMaxLeader)/parseFloat("10000")+"万元!");
                    }
                }
                piisGeneralPartner = '1';
            }else{
                if(parseFloat(piinvest)*parseFloat("10000")<parseFloat(pinvestMinFollow)){
                    return renderError("#piinvest", "跟投投金额不能小于"+parseFloat(pinvestMinFollow)/parseFloat("10000")+"万元!");
                }
                piisGeneralPartner = $('input[name="piisGeneralPartner"]:checked').val();
            }

            var pireasons=$("#pireasons").val();
            var pimyHelp=$("#pimyHelp").val();
            var projectId=$("#projectId").val();

            var pfinancingAmount=$("#pfinancingAmount").val();//项目融资金额
            var pfinancingAmountNew = parseFloat(pfinancingAmount)/parseFloat("10000");
            var  piisGeneralPartnerValue = $("#piisGeneralPartner_1").val();
            var  piinvestValue = $("#piinvest").val();
            if( eval(piinvestValue)>eval(pfinancingAmountNew)){
                return renderError("#piinvest", "投资金额不能高于项目融资金额!");
            }

            $.ajax({
                url : _ctx + "/crowdfunding/front/doInvest.ht",
                type : 'post',
                data : 'projectId=' + projectId +
                '&pireasons='+pireasons+'&pimyHelp='+pimyHelp+'&piisLeader='+piisLeader+
                '&piisGeneralPartner='+piisGeneralPartner+
                '&piinvest='+piinvest,
                dataType : 'json',
                success : function(data, status) {
                    var msg = '';
                    if(eval(data)==eval('1')){
                        msg = '申请已发出,请等待项目方审核!';
                    }else if(eval(data)==eval('-1')){
                        msg = '输入金额大于剩余可投金额，请重新申请!';
                    }else{
                        msg = '操作异常!';
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