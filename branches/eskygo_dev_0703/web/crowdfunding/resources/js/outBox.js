
/**
 * 删除选中
 */
function delChecks(){
    var str= "";
    $('.PrDyBackTable tbody').find('input[name="checkbox"]').each(function(){
        if($(this).is(':checked')) {
            str += $(this).val() + ",";
        }
    });
    if(str!=""){
        window.top.$.Dialog.confirm('提示','您确定删除吗', function(){
            $.ajax({
                url : _ctx+"/loan/tuserMsgRemind/delTUserMsgRemind.ht?msgRemindId="+str+"&flag="+1,
                type : 'post',
                success : function(data) {
                    if(data=="1"){
                        window.top.$.Dialog.toast({
                            title: "提示",
                            content: "删除成功",
                            onDismiss: function() {
                                window.location.reload();
                            }
                        });
                    }
                    setTimeout(function(){
                        window.location.reload();
                    },2000);
                }
            });
        });

    }else{
        window.top.$.Dialog.toast({
            title: "提示",
            content: '请选择数据',
            onDismiss: function() {
            }
        });
    }
}

/**
 * 查看 回复 删除
 */
$('i[role="td-btn"]').on("click", function(e) {
    var self = $(this), type = self.data('type'),MsgRemindId = self.data('msg-id'),senderName = self.data('sender-name');
    switch(type) {
        case 'view':
            btnIframe(_ctx+'/loan/tuserMsgRemind/PriInfoRemindDetails.ht?MsgRemindId='+MsgRemindId,'详细内容','620px','520px');
            break;
        case 'reply':
            btnIframe(_ctx+'/loan/tuserMsgRemind/replyMsgRemind.ht?replyId='+MsgRemindId+'&receiverName='+senderName,'消息回复','620px','520px');
            break;
        case 'delete':
            delMsg(MsgRemindId);
            break;
    }


});

function btnIframe(url,title,width,height){
    window.top.$.Dialog.modalIframe({
        url: url,
        title: title,
        width: width,
        height: height
    });
}

/**
 * 删除按钮
 */
function delMsg(MsgRemindId){
    //var ids = $(this).parent().parent().attr("id");
    window.top.$.Dialog.confirm('提示','您确定删除吗', function(){
        $.ajax({
            url : _ctx+"/loan/tuserMsgRemind/delTUserMsgRemind.ht?msgRemindId="+MsgRemindId+"&flag="+1,
            type : 'post',
            success : function(data) {
                if(data=="1"){
                    window.top.$.Dialog.toast({
                        title: "提示",
                        content: "删除成功",
                        onDismiss: function() {
                            window.location.reload();
                        }
                    });
                }
                setTimeout(function(){
                    window.location.reload();
                },5000);
            }
        });
    });
}

$(function(){
    $('.PrDyBackTable input[name="InvertSelection"]').on('change',function(e){
        var self = $(this);
        if(self.is(":checked")) {
            $('.PrDyBackTable tbody').find('input[name="checkbox"]').prop('checked',true);
        } else {
            $('.PrDyBackTable tbody').find('input[name="checkbox"]').prop('checked',false);
        }
    });
});



