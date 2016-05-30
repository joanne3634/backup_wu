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
	if('${error}' != ""){
		window.parent.openDialog('${error}');
	}
	
	 $("#email_verify_form").validate({
	        rules: {
	   email_code: {
		    required: true
		   }
	  },
	     messages: {
	     email_code: {
		    required: "请输入邮箱验证码"
		   }
	  }
	    });
	});

function email_find_passForm(){
	if($('#email_verify_form').valid()){
		$('#email_verify_form').submit();
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
          <div class="zhmm-fengexian"></div>
          <div class="zhmm-buzounum">
            <div>3</div>
            重置密码
          </div>
        </div>
      	<div style="margin-bottom:20px;text-align:center;font-size:14px;color:#666;">验证邮件已发送至 <span>${email }</span>，若收件箱没有邮件，请尝试在垃圾邮件夹找回。 </div>
        
        <form action="${ctx }/safe/valiBindEmailcode.ht" id="email_verify_form" method="post">
        <div id="yx-zhmm2"><input type="hidden" id="email" name="email" value="${email }"/>
          <span>*</span>收到的验证码：<input type="text" id="email_code" name="email_code">&nbsp;<a style="color: red;font-size: 12px;"></a>
        </div><input id="userId" name="userId" type="hidden" value="${userId }"/>
      	<div style="margin-bottom:20px;text-align:center;font-size:14px;color:#999;">没收到邮件？请联系客服<%=application.getAttribute("CUCTOMER_SERVICE_TELEPHONE") %></div>
        <div class="sub-btn"><a href="javascript:;" onclick="email_find_passForm();">提 交</a></div>
        </form>
      </div>
    </div>
  </div>
			<%@ include file="/crowdfunding/foot.jsp"%>

</body>
</html>