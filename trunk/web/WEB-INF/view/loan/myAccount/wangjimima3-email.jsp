<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>忘记密码</title>
 <%@ include file="/crowdfunding/cssorjs.jsp"%>
  <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/reset.css">
<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/public.css"> 
     
</head>
<script type="text/javascript">
$().ready(function() {
	if('${success}' != ""){
		window.openDialog('${success}');
		setTimeout('window.location = "${ctx}/loginWeb.jsp";',2000);
	}	
	 $("#reset_pass_form").validate({
	        rules: {
	        newPwd: {
		    required: true,
		    minlength: 6,
		    maxlength: 15
		   },
	   		rsnewPwd: {
	   		required: true,
		    equalTo: "#newPwd"
	   }
	  },
	     messages: {
	    	newPwd: {
		    required: "请输入新登录密码",
		    minlength: $.validator.format("密码不能小于{0}个字 符"),
		    maxlength: $.validator.format("密码不能大于{0}个字 符")
		   },
		   rsnewPwd: {
	    	required: "请重复输入新登录密码",
	    	equalTo: "两次输入的新密码不一致"
	   }
	  }
	    });
	});

function reset_pass_form_function(){
	if($('#reset_pass_form').valid()){
		$('#reset_pass_form').submit();
	}
}

</script>
<body>	
<%@ include file="/crowdfunding/head.jsp"%>
   <div class="container">
   <div class="weizhi-lianjie" style="padding-right: 850px;"><a href="${ctx }/index-web.jsp">首页</a> > <span>忘记密码</span></div>
    <div id="wangjimima-box">
      <div class="zhmm-inputlist yxzh-btn">
        <div class="zhmm-buzhouzhiyin">
          <div class="zhmm-buzounum" style="color:#ff5200;font-weight:bold;">
            <div>1</div>
            填写绑定邮箱
          </div>
          <div class="zhmm-fengexian" style="border-top-color:#ff5200;"></div>
          <div class="zhmm-buzounum" style="color:#ff5200;font-weight:bold;">
            <div>2</div>
            验证邮箱
          </div>
          <div class="zhmm-fengexian" style="border-top-color:#ff5200;"></div>
          <div class="zhmm-buzounum" style="color:#ff5200;font-weight:bold;">
            <div>3</div>
            重置密码
          </div>
        </div>
        <form action="${ctx }/safe/emailresetpass.ht?resetCode=${resetCode}" id="reset_pass_form" method="post">
          <dl id="yx-zhmm3"> <input type="hidden" id="userId" name="userId" value="${userId }"/>
            <dt><span>*</span>新密码：</dt>
            <dd><input type="password" id="newPwd" name="newPwd"></dd>
            <dt><span>*</span>确认新密码：</dt>
            <dd><input type="password" id="rsnewPwd" name="rsnewPwd"></dd>
          </dl>
          <div class="sub-btn"><a href="javascript:;" onclick="reset_pass_form_function();">提 交</a></div>
        </form>
      </div>
    </div>
  </div>
			<%@ include file="/crowdfunding/foot.jsp"%>	

</body>
</html>