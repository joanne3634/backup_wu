  function num(th){th.value = th.value.replace(/[^\d\.\-]*$/g, '');}
  function submitLoan(ctx,user){
	  if("null"!=user&&""!=user&&undefined!=user){
		  $.ajax({
				type: "post",
				url: ctx+"/project/apply/getUserLimit.ht",
				data:{applyInMax:$("#applyInMax").val(),oldLimit:$("#cando").text()},
				dataType:"json",
				success: function(result){
					if(result.ok==1){
						alert("保存借出额度申请成功，请等待平台审核。");
						$("#applayDialog").hide();
					}else{
						alert("保存借出额度申请失败。");
					}
				}
			});
	  }
  }
  function applyLoan(ctx,user,type){
	  if("null"!=user&&""!=user&&undefined!=user){
		  $.ajax({
				type: "get",
				async: false,
				url: ctx+"/project/apply/getUserLimit.ht",
				dataType:"json",
				success: function(data){
					$("#cando").text(data.limitMaxIn);
					$("#nowcando").text(data.limitMaxCanDoIn);
					if(type==0){//额度申请，type值为1则是借款提交请求查询用户最大借款额度判断是否能提交项目
						$("#applayDialog").show();
						window.location.href="#";
					}
				}
			});
	  }else{
		  window.location.href=ctx+"/loan/myAccount/myaccountPage.ht";
	  }
	  
  }