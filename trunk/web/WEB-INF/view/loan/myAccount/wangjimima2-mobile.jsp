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
	 $("#mobile_verify_form").validate({
	        rules: {
	        mobile_code: {
		    required: true
		   }
	  },
	     messages: {
	    	mobile_code: {
		    required: "请输入手机验证码"
		   }
	  }
	    });
	});

function mobile_find_passForm(){
	if($('#mobile_verify_form').valid()){
		$('#mobile_verify_form').submit();
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
            填写绑定手机
          </div>
          <div class="zhmm-fengexian" style="border-top-color:#ff5200;"></div>
          <div class="zhmm-buzounum" style="color:#ff5200;font-weight:bold;">
            <div>2</div>
            验证手机
          </div>
          <div class="zhmm-fengexian"></div>
          <div class="zhmm-buzounum">
            <div>3</div>
            重置密码
          </div>
        </div>
        <form action="${ctx }/safe/valiBindMobilecode.ht" id="mobile_verify_form" method="post">
      	<div style="margin-bottom:20px;text-align:center;font-size:14px;color:#666;">“众筹手机验证短信” 已发送至您的手机 <span>${mobile }</span></div>
        <div id="sj-zhmm2"><input type="hidden" id="userId" name="userId" value="${userId }"/>
        <input id="mobile" name="mobile" value="${mobile }" type="hidden"/>
          <span>*</span>收到的验证码：<input type="text" id="mobile_code" name="mobile_code">&nbsp;<a style="color: red;font-size: 12px;"></a>
        </div>
      	<div style="margin-bottom:20px;text-align:center;font-size:14px;color:#999;">没收到短信？请联系客服400-888-8888</div>
        <div class="sub-btn"><a href="javascript:;" onclick="mobile_find_passForm();">提 交</a></div>
        </form>
      </div>
    </div>
  </div>
			<%@ include file="/crowdfunding/foot.jsp"%>

</body>
</html>