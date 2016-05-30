
/**
 * 添加事件及附件按钮
 */
function addEventAndAttach(){
    var url=_ctx+'/crowdfunding/tcprojectAfter/projectAfterForm.ht';
    window.top.$.Dialog.modalIframe({
        url: url,
        title: "添加事件",
        width: '1000px',
        height: '550px'
    });
}
/**
 * 删除选中
 */
function delChecks(){
    var ids= "";
    $('.PrDyBackTable tbody').find('input[name="checkbox"]').each(function(){
        if($(this).is(':checked')) {
            ids += $(this).val() + ";";
        }
    });
    if(ids!=""){
        window.top.$.Dialog.confirm('提示','您确定删除吗', function(){
            $.ajax({
                url : _ctx+"/crowdfunding/tcprojectAfter/projectAfterDelByIds.ht?time="+new Date(),
                type : 'post',
                data: "ids="+ids,
                success : function(data) {
                    window.top.$.Dialog.toast({
                        title: "提示",
                        content: data,
                        onDismiss: function() {
                            window.location.reload();
                        }
                    });
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

function clearForm(userId){
    $("#projectName").val("");
    $("#paTitle").val("");
}
function submitForm(userId){
    $("#pageForm").submit();
}
/**
 * 查看 编辑 删除
 */
$('i[role="td-btn"]').on("click", function(e) {
    var self = $(this), type = self.data('type'),afterId = self.data('after-id');
    switch(type) {
        case 'view':
            btnIframe(_ctx+'/crowdfunding/tcprojectAfter/projectAfterDetail.ht?afterId='+afterId,'查看内容','840px','850px');
            break;
        case 'edit':
            btnIframe(_ctx+'/crowdfunding/tcprojectAfter/projectAfterEdit.ht?afterId='+afterId,'编辑事件','840px','550px');
            break;
        case 'delete':
            delPcAfterInfo(afterId);
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
function delPcAfterInfo(afterId){
    //var ids = $(this).parent().parent().attr("id");
    window.top.$.Dialog.confirm('提示','您确定删除吗', function(){
        $.ajax({
            url : _ctx+"/crowdfunding/tcprojectAfter/projectAfterDelByIds.ht?time="+new Date(),
            type : 'post',
            data: "ids="+afterId,
            success : function(data) {
                window.top.$.Dialog.toast({
                    title: "提示",
                    content: data,
                    onDismiss: function() {
                        window.location.reload();
                    }
                });
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



