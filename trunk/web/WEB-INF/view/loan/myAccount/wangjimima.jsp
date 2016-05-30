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
	
	
	 $("#email_find_pass").validate({
	        rules: {
	   		email: {
		    required: true,
		    email: true
		   },
	   		code: {
	   		required: true,
	   		remote : "${ctx}/user/validateCode.ht"
	   }
	  },
	     messages: {
	       	email: {
		    required: "必填",
		    email: "请输入正确的email地址"
		   },
	   	code: {
	    required: "必填",
	    remote:"验证码输入有误"
	   }
	  }
	    });
	 
	 
	 $("#mobile_find_pass").validate({
	        rules: {
	        mobile: {
		    required: true,
		    mobile : true
		    
		   },
	    code: {
	    required: true,
	    remote : "${ctx}/user/validateCode.ht"
	   }
	  },
	     messages: {
	    	mobile: {
		    required: "必填",
		    mobile : "请输入正确的绑定手机号码"
		   },
	   	code: {
	    required: "必填",
	    remote : "验证码输入有误"
	   }
	  }
	    });
	 
	 
	 $("#quesion_find_pass").validate({
	        rules: {
	        loginName: {
		    required: true,
		    chrnum:true,
		    minlength:5,
		    maxlength:12
		    
		   },
	    code: {
	    required: true,
	    remote : "${ctx}/user/validateCode.ht"
	   }
	  },
	     messages: {
	    	loginName: {
		    required: "必填",
		    chrnum :"只能输入数字和字母(字符A-Z, a-z, 0-9)",
		    minlength: $.validator.format("用户名不能小于{0}个字 符"),
		    maxlength: $.validator.format("用户名不能大于{0}个字 符")
		   },
	    code: {
	    required: "请输入验证码",
	    remote:"验证码输入有误"
	   }
	  }
	    });
	 
	});

//邮箱地址
function email_find_passForm(){
	if($('#email_find_pass').valid()){
		$('#email_find_pass').submit();
	}
}

//手机号码
function mobile_find_passForm(){
	if($('#mobile_find_pass').valid()){
		$('#mobile_find_pass').submit();
	}
}

//安全问题
function quesion_find_passForm(){
	if($('#quesion_find_pass').valid()){
		$('#quesion_find_pass').submit();
	}
}


function sendEmailCode() {
	var password = $("input[name='loginPwd']").val();
	if(password == ""){
		alert("请输入登录密码");
		return;
	}
	$.ajax({
		url : "${ctx}/safe/sendEmailValiCode.ht",
		type : 'post',
		data : "",
		dataType : 'html',
		success : function(data, status) {
			var datas = eval(data);
			if(datas == "0"){
				alert("验证码已发送，请注意查收");
			}else{alert(datas);}
		},
		error : function(xhr, textStatus, errorThrown) {
			alert('发送失败');
		}
	});
}

function validateEmailCode() {
	var code = $("input[name='code']").val();
	var validCode = $("#validCode").val();
	var password = $("input[name='loginPwd']").val();

	$.ajax({
		url : "${ctx}/safe/validateEmailCode.ht",
		type : 'post',
		data : 'code=' + code + '&validCode=' + validCode + '&password=' + password,
		dataType : 'html',
		success : function(data, status) {
			var datas = eval(data);
			if (datas == "0") {
				alert("绑定邮箱成功");
				location.reload();
			}else{
				alert(datas);
			}
		},
		error : function(xhr, textStatus, errorThrown) {
			alert('绑定异常，请联系管理员');
		}
	});
}


function reload(p){
	var url="${ctx}/servlet/ValidCode?rand=" +new Date().getTime();
	document.getElementById(p).src=url;
}
</script>
<body>	
	<%@ include file="/crowdfunding/head.jsp"%>
  <div class="container">
    <div class="weizhi-lianjie" style="padding-right: 850px;"><a href="${ctx }/index-web.jsp">首页</a> > <span>忘记密码</span></div>
    <div id="wangjimima-box">
      <div id="wjmm-tit">找回密码</div>
      <div id="zhmm-fangshi">
      <a class="yxzh-btn-hover" id="yxzh-btn" href="javascript:;">使用绑定邮箱找回密码</a>
      <a id="sjzh-btn" href="javascript:;">使用绑定手机找回密码</a>
      <a id="mbzh-btn" href="javascript:;">使用密保问题找回密码</a>
      
      </div>
     
     
      <form id="email_find_pass" action="${ctx }/safe/valiBindEmail.ht" method="post">
      <div class="zhmm-inputlist yxzh-btn">
        <div class="zhmm-buzhouzhiyin">
          <div class="zhmm-buzounum" style="color:#ff5200;font-weight:bold;">
            <div>1</div>
            填写绑定邮箱
          </div>
          <div class="zhmm-fengexian"></div>
          <div class="zhmm-buzounum">
            <div>2</div>
            验证邮箱
          </div>
          <div class="zhmm-fengexian"></div>
          <div class="zhmm-buzounum">
            <div>3</div>
            重置密码
          </div>
        </div>
        <dl id="yx-zhmm">
          <dt><span>*</span>邮箱地址：</dt>
          <dd><input type="text" id="email" name="email" value="">&nbsp;<a style="color: red;font-size: 12px;"></a></dd>
          <dt><span>*</span>验证码：</dt>
          <dd class="yanzhengma-box"><input type="text" id="code" name="code"><img
							 src="${ctx}/servlet/ValidCode" id="email_validImg" alt="" onclick="reload('email_validImg')" style="cursor: pointer;"/><!-- <a href="javascript:;" onclick="reload('email_validImg')">看不清，换一个</a> -->
           &nbsp;<a style="color: red;font-size: 12px;"></a>
          </dd>
        </dl>
        <div class="sub-btn"><a href="javascript:;" onclick="email_find_passForm();">提 交</a></div>
      </div>
      </form>
      
      
       <form id="mobile_find_pass" action="${ctx }/safe/valiBindPhone.ht" method="post">
      <div class="zhmm-inputlist sjzh-btn" style="display:none;">
        <div class="zhmm-buzhouzhiyin">
          <div class="zhmm-buzounum" style="color:#ff5200;font-weight:bold;">
            <div>1</div>
            填写绑定手机号
          </div>
          <div class="zhmm-fengexian"></div>
          <div class="zhmm-buzounum">
            <div>2</div>
            验证手机号
          </div>
          <div class="zhmm-fengexian"></div>
          <div class="zhmm-buzounum">
            <div>3</div>
            重置密码
          </div>
        </div>
        <dl id="sj-zhmm">
          <dt><span>*</span>手机号：</dt>
          <dd><input type="text" id="mobile" name="mobile" value="${mobile }"/>&nbsp;<a style="color:red;font-size: 12px;">${mobileResult }</a></dd>
          <dt><span>*</span>验证码：</dt>
                    <dd class="yanzhengma-box"><input type="text" id="code" name="code"><img
							 src="${ctx}/servlet/ValidCode" id="mobile_validImg" alt="" onclick="reload('mobile_validImg')" style="cursor: pointer;"/><a href="javascript:;" onclick="reload('mobile_validImg')">看不清，换一个</a>
           &nbsp;<a style="color: red;font-size: 12px;">${mobilecodeResult }</a>
          </dd>
        </dl>
        <div class="sub-btn"><a href="javascript:;" onclick="mobile_find_passForm();">提 交</a></div>
      </div>
      </form>
      
      
      <div class="zhmm-inputlist mbzh-btn" style="display:none;">
        <div class="zhmm-buzhouzhiyin">
          <div class="zhmm-buzounum" style="color:#ff5200;font-weight:bold;">
            <div>1</div>
            填写您的账号
          </div>
          <div class="zhmm-fengexian"></div>
          <div class="zhmm-buzounum">
            <div>2</div>
            验证问题
          </div>
          <div class="zhmm-fengexian"></div>
          <div class="zhmm-buzounum">
            <div>3</div>
            重置密码
          </div>
        </div>
        <form action="${ctx }/safe/valiBindQuesion.ht" id="quesion_find_pass" method="post">
        <dl id="mb-zhmm">
          <dt><span>*</span>请输入您的账号：</dt>
          <dd><input type="text" id="loginName" name="loginName">&nbsp;<a style="color: red;font-size: 12px;">${quesionResult }</a></dd>
          <dt><span>*</span>验证码：</dt>
           <dd class="yanzhengma-box"><input type="text" id="code" name="code"><img
			src="${ctx}/servlet/ValidCode" id="quesion_validImg" alt="" onclick="reload('quesion_validImg')" style="cursor: pointer;"/><a href="javascript:;" onclick="reload('quesion_validImg')">看不清，换一个</a>
           &nbsp;<a style="color: red;font-size: 12px;">${quesioncodeResult }</a>
          </dd>
        </dl>
        <div class="sub-btn"><a href="javascript:;" onclick="quesion_find_passForm();">提 交</a></div>
        </form>
      </div>
      <div style="margin-bottom:35px;text-align:center;font-size:14px;color:#999;">若您无法使用上述方法找回，请联系客服400-888-8888</div>
    </div>
  </div>

			<%@ include file="/crowdfunding/foot.jsp"%>
			  <script>
			    function show(){
			    	var obj = '${identifying}'; 
			    	if(obj != ""){
			        	$("#zhmm-fangshi a").removeClass("yxzh-btn-hover");
			       	 	$("#zhmm-fangshi a").removeClass("sjzh-btn-hover");
			        	$("#zhmm-fangshi a").removeClass("mbzh-btn-hover");
			        	$("#" + obj).addClass($("#" + obj).attr("id")+"-hover");
			        	$(".zhmm-inputlist").css("display","none");
			        	$("."+obj).show();
			    	}
			    }
    $(function(){
      $("#zhmm-fangshi a").bind("click",function(){
        $("#zhmm-fangshi a").removeClass("yxzh-btn-hover");
        $("#zhmm-fangshi a").removeClass("sjzh-btn-hover");
        $("#zhmm-fangshi a").removeClass("mbzh-btn-hover");
        $(this).addClass($(this).attr("id")+"-hover");
        $(".zhmm-inputlist").css("display","none");
        $("."+$(this).attr("id")).show();
      });
      show();
      
      
    })

    
    
    
  </script>
</body>
</html>