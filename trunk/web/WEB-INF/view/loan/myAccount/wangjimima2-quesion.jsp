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
	 $("#quesion_verify_form").validate({
	        rules: {
	        a1: {
		    required: true
		   },
	        a2: {
			    required: true
			   },
			   a3: {
				    required: true
			   }
	  },
	     messages: {
	    	 a1: {
		    required: "请输入安全问题答案"
		   },
	    	 a2: {
	 		    required: "请输入安全问题答案"
	 		   },
		    	 a3: {
		 		    required: "请输入安全问题答案"
		 		   }
	  }
	    });
	});

function quesion_find_passForm(){
	if($('#quesion_verify_form').valid()){
		$('#quesion_verify_form').submit();
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
            填写您的账号
          </div>
          <div class="zhmm-fengexian" style="border-top-color:#ff5200;"></div>
          <div class="zhmm-buzounum" style="color:#ff5200;font-weight:bold;">
            <div>2</div>
            验证问题
          </div>
          <div class="zhmm-fengexian"></div>
          <div class="zhmm-buzounum">
            <div>3</div>
            重置密码
          </div>
        </div>
        <form action="${ctx }/safe/valiBindquesionAnswer.ht" method="post" id="quesion_verify_form">
        <div id="mb-zhmm2">
          <div><span>*</span>
          <f:description nodeKey="SALE_ISSUE" itemValue="${userSafe.q1 }"></f:description>?
          </div><!-- 1-19个中文或2-38个英文 -->
          <div><input type="text" id="a1" name="a1" value="${a1 }">&nbsp;<a style="color: red;font-size: 12px;">${quesion1Result }</a></div>
          </div>
           <div id="mb-zhmm2">
          <div><span>*</span>
          <f:description nodeKey="SALE_ISSUE" itemValue="${userSafe.q2 }"></f:description>?
          </div>
          <div><input type="text" id="a2" name="a2" value="${a2 }">&nbsp;<a style="color: red;font-size: 12px;">${quesion2Result }</a></div>
          </div>
           <div id="mb-zhmm2">
          <div><span>*</span>
          <f:description nodeKey="SALE_ISSUE" itemValue="${userSafe.q3 }"></f:description>?
          </div>
          <div><input type="text" id="a3" name="a3" value="${a3 }">&nbsp;<a style="color: red;font-size: 12px;">${quesion3Result }</a></div>
        </div>
        <input type="hidden" id="userId" name="userId" value="${userSafe.userId }"/>
        <div class="sub-btn"><a href="javascript:;" onclick="quesion_find_passForm();">提 交</a></div>
        </form>
        <div style="margin-bottom:20px;text-align:center;font-size:14px;color:#999;">若您无法使用上述方法找回，请联系客服400-888-8888</div>
      </div>
    </div>
  </div>
			<%@ include file="/crowdfunding/foot.jsp"%>

</body>
</html>