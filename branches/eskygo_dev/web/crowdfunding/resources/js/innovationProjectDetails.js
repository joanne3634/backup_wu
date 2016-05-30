Ink.requireModules( ['Ink.Dom.Selector_1','Ink.UI.Tabs_1'], function( Selector, Tabs ){
    var detailTabs = new Tabs('#detailTabs');
});

function uploadfileDoc(fileName){
    valiLoginTimeout('iframe');
    if(isLogin) {
        var url=_ctx + "/crowdfunding/tcprojectAfter/afterFileDownloadById.ht?fileId="+fileName;
        window.location.href=url;
    }
}

function successFun(proId){
    window.top.$.Dialog.toast({content:"回复成功!"});
    var url= _ctx + "/crowdfunding/front/toProComment.ht?projectId="+proId;
    $("#iframepage").attr("src", url);
}

function send_message_submit(){
    $.ajax({
        url : _ctx + "/loan/tuserMsgRemind/saveMsgRemind.ht",
        type : 'post',
        data : $('#sendForm').serialize(),
        dataType : 'json',
        success : function(data,textStatus) {
            //alert("信息发送成功:"+data);
        },
        error : function(XMLHttpRequest, textStatus, errorThrown) {
            //art.dialog("信息发送失败");
        }
    });
}

$('i.fa.fa-envelope-o').on('click', function(e){
    valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
    if(isLogin) {
        var _val=$(this).data('value');
        var _id=$(this).data("id");
        var projectId=$("#projectId").val();
        var url= _ctx + '/crowdfunding/front/openSendInfoWin.ht?receiverId='+_val+'&projectId='+projectId+'&type_id=1';
        window.top.$.Dialog.modalIframe({
            title: '发私信',
            url: url,
            width: '500px',
            height: '420px'
        });
    }
});

$('#interviews-with-entrepreneurs').on('click', function(e){
    if($('#user-group-id').val() === "1") {
        window.top.$.Dialog.toast({content:"对不起， 项目方不能向别的项目发起约谈!"});
        return;
    }

    valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
    if(isLogin) {
        var _val=$(this).data('creator');
        var projectId=$(this).data('project-id');
        var url = _ctx + '/crowdfunding/front/openSendInfoWin.ht?receiverId='+_val+'&projectId='+projectId+'&type_id=2';
        window.top.$.Dialog.modalIframe({
            url: url,
            title: '约谈项目方',
            width: '600px',
            height: '480px'
        });
    }
});

$('#favorite-project').on('click', function(e) {
    var self = $(this);
    //1：项目方 2：投资者
    if($('#user-group-id').val() === "1") {
        window.top.$.Dialog.toast({content:"对不起，只有投资人才能收藏项目!"});
        return;
    }
    valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
    if(isLogin) {
        $.ajax({
            url : _ctx + "/crowdfunding/front/favorite.ht",
            type : 'post',
            data : {
                projectId: self.data('project-id') ,
                Creator: self.data('creator')
            },
            dataType : 'json',
            success : function(data, status) {
                if(data == "0"){
                    window.top.location = _ctx + "/loginWeb.jsp";
                }else if(data == "1"){
                    self.attr('disabled',true);
                    send_message_submit();
                }else if(data == "2") {
                    self.attr('disabled',true);
                    window.top.$.Dialog.toast({content:"你已经收藏过该项目了"});
                }
            },
            error : function(xhr, textStatus, errorThrown) {
            }
        });
    }
});

$('#apply-view').on('click', function(e){
    var projectId = $(this).data('project-id');
    $.ajax({
        url : _ctx + "/crowdfunding/projectApply/applyTheProjectView.ht",
        type : 'post',
        data: {
            projectId: projectId
        },
        success : function(data) {
            window.top.$.Dialog.toast({content: data});
        }
    });
})

$('#sendComment').on('click', function(e) {
    var commentContent = $("#commentConten_id").val();
    if($.trim(commentContent) == ""){
        window.top.$.Dialog.toast({content:"评论内容不能为空"});
        return;
    }
    if(commentContent.length>1000)
    {
        window.top.$.Dialog.toast({content:"发表评论长度不能超过1000个字符!"});
        return;
    }
    $.ajax({
        url : _ctx + "/crowdfunding/front/sendTalkmsg.ht",
        type : 'post',
        data : {
            projectId: $('#projectId').val(),
            commentConten: commentContent
        },
        dataType : 'json',
        success : function(data, status) {
            if(data == "0"){
                window.location = _ctx + "/loginWeb.jsp";
            }else if(data == "1"){
                window.top.$.Dialog.toast({content:"发表成功!"});
                var url= _ctx + "/crowdfunding/front/toProComment.ht?projectId=" + $('#projectId').val();
                $("#iframepage").attr("src", url);
                $("#commentConten_id").val("");
            }else {
                window.top.$.Dialog.toast({content:"操作异常!"});
            }
        },
        error : function(xhr, textStatus, errorThrown) {
        }
    });
});
