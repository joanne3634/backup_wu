//下载附件
function download(id){
	$.ajax({
		url : _ctx + "/platform/system/sysFile/download.ht?fileId=" + id,
		type : 'post',
		data : "",
		dataType : 'html',
		success : function(data, status) {
			if(data != '文件不存在!'){
				location = __ctx + "/platform/system/sysFile/download.ht?fileId=" + id;
			}else{
				//openDialog(data);
				$.Dialog.toast({
                    title: "提示",
                    content: data,
                    onDismiss: function() {
                    	//window.location = "${ctx}/crowdfunding/tcuserPersonalData/changeAccountPwdPage.ht";
                        //window.parent.location.reload();
                    }
                });
				
			}
			
		},
		error : function(xhr, textStatus, errorThrown) {
			//$("#code_result").html("发送异常，请重试");
		},
		beforeSend:function(){
			
		}
	});
}