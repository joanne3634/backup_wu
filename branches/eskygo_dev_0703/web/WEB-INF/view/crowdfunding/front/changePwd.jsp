<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang=""> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title><%=application.getAttribute("PLATFORM_NAME")%> - 上传资料</title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/crowdfunding/globalcss.jsp"%>
<link rel="stylesheet" href="${ctx }/crowdfunding/resources/css/personalInfo.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/changePwd.css">
</head>
<body class="iframe">
		<div class="addyourproject f_l">
			<header>
			<h2>修改密码</h2>
			</header>
        <div class="con-box" id="con-box1">
        	<form id="changeloginPwd_form" class="ink-form v2 vertical">
			<fieldset class="clear changePwdForm">
                <div class="control-group gutters">
                    <div class="control">
                    	<input type="password" name="beforePwd" id="beforePwd" class="text-input" required data-rules="required"/>
	                    <label class="all-100" for="beforePwd">
	                    	原登录密码
	                    </label>
                    </div>
                </div>
                <div class="control-group gutters">
                    <div class="control">
                    	<input type="password" name="newPwd" id="newPwd" class="text-input" required data-rules="required|min_length[6]|max_length[20]"/>
	                    <label class="all-100" for="newPwd">
	                    	新登录密码
	                    </label>
                    </div>
                </div>
                <div class="control-group gutters">
                    <div class="control">
                    	<input type="password" name="reNewPwd" id="reNewPwd" class="text-input" required data-rules="required|min_length[6]|max_length[20]|matches[newPwd]"/>
	                    <label class="all-100" for="reNewPwd">
	                    	确认新密码
	                    </label>
                    </div>
                </div>
           	</fieldset>
               <div class="control-group gutters">
                   <div class="control push-right">
                       <button id="submitBtn" class="ink-button blue-dark" type="submit">保存</button>
                   </div>
               </div>
        </form>
      </div>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script type="text/javascript">
$().ready(function() {
/* 	 $("#changeloginPwd_form").validate({
	        rules: {
	        beforePwd: {//原密码验证
	    	    required: true,
	  		    minlength: 6,
	  		    maxlength: 20
		   			},
		   	newPwd: { //  //新密码
	    	    required: true,
	  		    minlength: 6,
	  		    maxlength: 20
			   	     },
			reNewPwd: { //  确认密码
				required: true,
				equalTo: "#newPwd"
					}				
	  		},
	        messages: {
	        beforePwd: {
	    	    required: "必填",
			    minlength: $.validator.format("密码不能小于{0}个字 符"),
			    maxlength: $.validator.format("密码不能大于{0}个字 符")
		   			},
		   	newPwd: {
	    	    required: "必填",
			    minlength: $.validator.format("密码不能小于{0}个字 符"),
			    maxlength: $.validator.format("密码不能大于{0}个字 符")
	   			},
	   		reNewPwd: {
		   		required: "必填",
		   		equalTo:"俩次密码不一致"
		   		}
	  		}
	    }); */
	    var form = $('#changeloginPwd_form');

	    Ink.requireModules( ['Ink.Dom.Selector_1','Ink.UI.Modal_1', 'Ink.UI.FormValidator_2'], function( Selector, Modal, FormValidator ){

	        form.on('submit', function(e) {
	        	e.preventDefault();

	        });

	        var registerFormValidator = new FormValidator( '#changeloginPwd_form', {
	            onSuccess : function(elements){
					valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
					$.ajax({
						url : "${ctx}/crowdfunding/tcuserPersonalData/changeAccountPwd.ht",
						type : 'post',
						data : $('#changeloginPwd_form').serialize(),
						dataType : 'json',
						success : function(data) {
	                        window.top.$.Dialog.toast({
	                            title: "提示",
	                            content: data,
	                            onDismiss: function() {
	                            	window.location = "${ctx}/crowdfunding/tcuserPersonalData/changeAccountPwdPage.ht";
	                                /* window.parent.location.reload(); */
	                            }
	                        });
/* 							window.parent.openDialog(data); */
							setTimeout('window.location = "${ctx}/crowdfunding/tcuserPersonalData/changeAccountPwdPage.ht";',2000);
						},
						error : function(request) {
							
						}
					});
	            },
	            onError: function(elements){
	            }
	        } );
	    });
	 
	 
	 
})
</script>
		<script>

  function tabShowCon(showid)
  {
	  //$("#con-box1,#con-box2").hide();
	  //$("#"+showid).addClass(showid+"2");
	  if(showid=="Orange")
	  {
		$("#div_Orange").removeClass("Orange1").addClass("Orange2");
	  	$("#div_green").removeClass("green2").addClass("green1");
		$("#con-box1").show();$("#con-box2").hide();
		
	  }
		else
		{
		$("#div_Orange").removeClass("Orange2").addClass("Orange1");
		$("#div_green").removeClass("green1").addClass("green2");
		$("#con-box1").hide();$("#con-box2").show();
		}
	  //alert(showid);
  }
		</script>
</body>
</html>