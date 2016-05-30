<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>修改密码</title>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
	<meta name="renderer" content="webkit"/>
	<link title="index" name="styleTag" rel="stylesheet" type="text/css" href="${ctx}/styles/default/css/web.css"></link>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/changePwd.css">
      <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
</head>
<script type="text/javascript">
$().ready(function() {
	 $("#changeloginPwd_form").validate({
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
	    });
	 
		 $("#BtnSave").click(function(){
			 valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
			if($('#changeloginPwd_form').valid()){			
				$.ajax({
					url : "${ctx}/crowdfunding/tcuserPersonalData/changeAccountPwd.ht",
					type : 'post',
					data : $('#changeloginPwd_form').serialize(),
					dataType : 'json',
					success : function(data) {
						window.parent.openDialog(data);
						setTimeout('window.location = "${ctx}/crowdfunding/tcuserPersonalData/changeAccountPwdPage.ht";',2000);
					},
					error : function(request) {
						
					}
				});
			}	 
	 })
	 
	 
	 
})
</script>
<body>
		<div class="addyourproject f_l">
			<h2><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">修改密码</h2>
      <div id="hyht-bodyright">
        <div class="con-main">
        	<!--切换按钮-->
        	<div class="con-box-btn">
<!--         		<div class="Orange2" id="div_Orange" onClick="tabShowCon('Orange');"></div>
        		<div class="green1"  id="div_green" onClick="tabShowCon('green');"></div> -->
        	</div>
        	<!-- 登录密码 -->
        	<form id="changeloginPwd_form">
        	<div class="con-box1" id="con-box1">
        		<div class="con-box-items">
        			<dd><span style="color:red">*</span>原登录密码：
        	    		<input type="password" name="beforePwd" id="beforePwd" class="text-input"/>
        			</dd> 
       			</div>
            <div class="con-box-items">
            	<dd><span style="color:red">*</span>新登录密码：
        	    	<input type="password" name="newPwd" id="newPwd" class="text-input"/>
        		</dd> 
       		</div>
            <div class="con-box-items">
            	<dd><span style="color:red">*</span>确认新密码：
        	    	<input type="password" name="reNewPwd" id="reNewPwd" class="text-input"/>
        		</dd> 
       		</div>
            <!-- 保存 -->
			<div style="margin-top:30px;text-align:center;">
            	<input type="button" style="cursor: pointer;" name="BtnSave" class="SetAuto_btnSave" id="BtnSave" value="立即设置">
           		<input type="button" onclick="window.location.href= '${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht';"  class="SetAuto_btnSave" value="返回" style="margin-left:10px;cursor: pointer;">
            </div>
            
        </div>
        </form>
        
        <!-- 交易密码 -->
         <div class="con-box2" id="con-box2">
        	<div class="con-box-items"><dd>原交易密码：
        	  <input type="text" name="dddd" id="dddd" class="text-input"><span>输入您现在的帐号密码，初始帐号密码为帐号密码</span>
        		</dd> 
       		</div>
            
            <div class="con-box-items"><dd>新交易密码：
        	  <input type="text" name="dddd" id="dddd" class="text-input"><span>输入您的新密码</span>
        		</dd> 
       		</div>
            
            <div class="con-box-items"><dd>确认新密码：
        	  <input type="text" name="dddd" id="dddd" class="text-input"><span>请再次输入您的新密码</span>
        		</dd> 
       		</div>
			
            <!-- 保存 -->
			<div style="margin-top:30px;text-align:center;">
              <input type="button" name="BtnSave" class="SetAuto_btnSave" id="BtnSave" value="立即设置">
            </div>
            
            

        </div>           
        
        
        
        <div class="con-box-list-bottom"></div>
        </div>
      </div>
		</div>
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