var editor = CKEDITOR.replace('contentText');

var isCheck = $("#isCheck").val();
var loadCked = $("#industryId").val();
var ary = [];

if(loadCked && loadCked.indexOf(',') != -1){
    ary = loadCked.split(',');
}else{
    ary.push(loadCked);
}
$.each(ary,function(index) {
    var val = $.trim(this);
    $("input[name='invesindustry']").each(function () {
        var value = $.trim($(this).val());
        if(value == val){
            $(this).attr("checked",true);
            return false;
        }else{
            return true;
        }
    });
});

$('#riskCheck').on("change", function(e){
   if($(this).is(":checked")) {
       $('#dosubmitbtn').removeAttr('disabled');
   } else {
       $('#dosubmitbtn').attr('disabled',true);
   }
});

$('#riskCommitment').on('click', function(e) {
    window.top.$.Dialog.modalIframe({
        title : '协议',
        url: _ctx + '/loan/aboutus/TermsServiceList.ht?xieyiid=6',
        width: '80%',
        height: '80%'
    })
})

$('#appform').on('submit', function(e) {
    e.preventDefault();
    doSubmit();
});

function reloadUrl(){
    window.location.reload(true);
}

function doSubmit() {
    var len = 0;
    $("input[name='invesindustry']:checked").each(function () {
        len++;
    });
    var contentText = $.trim(editor.document.getBody().getText());
    var str="",text = "";
    //var intL = $(".InvesIndustry input:checked").length; //获取除全选复选框外的所有选中项  张建军 201、10、21 modify(内容：注释改行)
    if (len > 3) {
        window.top.$.Dialog.toast({content:"选择的项目不能超过三项"});
        return;
    }else if(len == 0){
        window.top.$.Dialog.toast({content:"请选择项目"});
        return;
    }else if(contentText ==""){
        window.top.$.Dialog.toast({content:"请填写个人简介"});
        return;
    }else if(contentText.length < 100){
        window.top.$.Dialog.toast({content:"请至少输入100字简介"});
        return;
    }else{
        $("input[name='invesindustry']:checked").each(function () {
            if (this.checked) {
                str+=$(this).val()+",";
                text+=$(this).parent().text()+",";
            }
        });
        $("#str").val(str.substring(0,str.length-1));
        $("#strName").val(text.substring(0,text.length-1));
        $("#contentText").val(contentText);
        $.ajax({
            url : _ctx + "/user/subApplyLeaderInfo.ht",
            type : 'post',
            data : $('#appform').serialize(),
            success : function(data) {
                if(data == "0") {
                    window.top.$.Dialog.toast({content:"领投资格提交成功", onDismiss: function() {reloadUrl()}});
                }else if(data == "1"){
                    window.top.$.Dialog.toast({content:"对不起，请登录操作", onDismiss: function() {reloadUrl()}});
                }else if(data == "3"){
                    $('#dosubmitbtn').attr('disabled',true);
                    $("#isSubmit").val(1);
                    window.top.$.Dialog.toast({content:"已提交申请，请耐心等待审核结果", onDismiss: function() {reloadUrl()}});
                }
            },
            error : function(xhr, textStatus, errorThrown) {
                window.top.$.Dialog.toast({content:"领投资格提交失败", onDismiss: function() {reloadUrl()}});
            }
        });
    }
}
