<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
		<title>找回密码 </title>  
  <script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
  <link rel="stylesheet" href="${ctx}/styles/p2p/reset.css">
  <link rel="stylesheet" href="${ctx}/styles/p2p/public.css">
  <link rel="stylesheet" type="text/css" href="${ctx}/styles/login/login.css"></link>

<script type="text/javascript" src="${ctx}/js/dynamic.jsp"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/util/util.js"></script>
<script type="text/javascript" src="${ctx}/js/util/json2.js"></script>
<script type="text/javascript" src="${ctx}/js/util/form.js"></script>
<script type="text/javascript" src="${ctx}/js/util/dialog.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/ligerui.min.js"></script>
<script type="text/javascript" src="${ctx}/js/deelon/displaytag.js" ></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerDialog.js" ></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerComboBox.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/htDicCombo.js"></script>  
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerResizable.js" ></script> 
<script type="text/javascript" src="${ctx}/js/calendar/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.htselect.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.rowOps.js"></script>

<script type="text/javascript" src="${ctx}/js/deelon/foldBox.js" ></script>
<script type="text/javascript" src="${ctx}/js/deelon/absoulteInTop.js" ></script>
<script type="text/javascript" src="${ctx}/js/tree/jquery.ztree.js"></script>
<script type="text/javascript">
	function reload(v){
		if(v=='1'){
			
			var url="${ctx}/servlet/ValidCode?rand=" +new Date().getTime();
			document.getElementById("validImg").src=url;
		}
		if(v=='2'){
					
					var url="${ctx}/servlet/ValidCode?rand=" +new Date().getTime();
					document.getElementById("validImg2").src=url;
				}
		if(v=='3'){
			
			var url="${ctx}/servlet/ValidCode?rand=" +new Date().getTime();
			document.getElementById("validImg3").src=url;
		}
		
	}
	
	function emailValid(){
        var email_addr=document.getElementById("email_addr_id").value;
		$.ajax({  
	          type : "post",  
	          url : "${ctx}/p2p/front/emailValid.ht",  
	          data : "email_addr=" + email_addr,  
	          async : false,  
	          success : function(data){  
	        	  alert(data);
	        	  if(data!=''){
						$("#email_addr_id").attr("value","");
						$("#warrn_inf").text(data);
						
					}else{
						$("#warrn_inf").text("");
						$("#warrn_inf").hide();
					}
	          }  
        });

		
	}
	
	function mobileValiSubm() {
		var mobileNum =$("#mobileNum_id").val();
		mobileNum=$.trim(mobileNum);
		if(mobileNum==""){
			
			var url="${ctx}/images/error.jpg";
			document.getElementById("err_id").src=url;
			return;
		}
		//ajax 验证手机是否为密保手机
		
		document.getElementById('retrieve_form_2').submit();
	}
	
	</script>
</head>
<body>
  <div class="head-w">
    <div class="head container">
      服务电话：<span>4000-000-000</span><a class="green" href="#">免费注册</a><a class="orange" href="#">立即登录</a><a class="gray" href="#">账户中心</a><img src="${ctx}/images/zhzx.png" alt="pic">
    </div>
  </div>
  <div class="nav-w">
    <div class="nav container">
     <a href="#"><img src="${ctx}/images/logo.png" alt=""></a>
      <ul>
        <li><a class="nav-left-a" href="#">首 页</a></li>
        <li><a class="nav-left-a" href="#">关于我们</a></li>
        <li><a class="nav-left-a" href="#">我的账户</a></li>
        <li class="nav-right-li"><a class="nav-right-a" href="#">我要理财</a></li>
        <li class="nav-right-li"><a class="nav-right-a" href="#">我要借款</a></li>
      </ul>
    </div>
  </div>
  <style>
    #wjmm-tit {
      margin-left: 30px;
      margin-right: 30px;
      margin-bottom: 30px;
      border-bottom: 1px solid #ccc;
      line-height: 60px;
      font-size: 22px;
      font-weight: bold;
    }
    #zhmm-fangshi {
      margin-bottom: 30px;
      text-align: center;
    }
    #zhmm-fangshi a {
      display: inline-block;
      padding-left: 20px;
      margin-right: 20px;
      padding-right: 20px;
      line-height: 43px;
      font-size: 16px;
      color: #fff;
      border-radius: 15px;
    }
    #zhmm-fangshi a:hover {
      text-decoration: none;
    }
    #yxzh-btn {
      background-color:#ff5200;
    }
    #yxzh-btn:hover {
      background-color:#ff5200;
    }
    .yxzh-btn-hover {
      background-color:#ff5200;
    }
    #sjzh-btn {
      background-color:#82cbec;
    }
    #sjzh-btn:hover {
      background-color:#0697da;
    }
    .sjzh-btn-hover {
      background-color:#0697da;
    }
    #mbzh-btn {
      background-color:#b6c57f;
    }
    #mbzh-btn:hover {
      background-color:#6e8b00;
    }
    .mbzh-btn-hover {
      background-color:#6e8b00;
    }
    .zhmm-inputlist {
      width: 500px;
      margin-bottom: 20px;
      overflow: hidden;
      margin-left: auto;
      margin-right: auto;
      line-height: 34px;
      font-size: 14px;
    }
    .zhmm-inputlist dl {
      overflow: hidden;
    }
    .zhmm-inputlist span {
      color: red;
    }
    .zhmm-inputlist dt {
      float: left;
      width: 145px;
      height: 34px;
      text-align: right;
    }
    .zhmm-inputlist dd {
      float: left;
      width: 350px;
      margin-bottom: 15px;
    }
    .zhmm-inputlist dd input {
      float: left;
      width: 250px;
      height: 20px;
      padding: 6px 5px;
      line-height: 20px;
      font-size: 14px;
      border: 1px solid #ccc;
    }
    .zhmm-inputlist .sub-btn {
      text-align: center;
    }
    .sub-btn a {
      display: inline-block;
      height: 34px;
      padding-left: 40px;
      padding-right: 40px;
      line-height: 34px;
      font-size: 16px;
      color: #fff;
      border-radius: 6px;
      background-color:#ff5200;
    }
    .sub-btn a:hover {
      text-decoration: none;
      background-color: #ffa87f;
    }
    .zhmm-inputlist img {
      float: left;
      padding-left: 10px;
      padding-right: 10px;
    }
    .zhmm-buzhouzhiyin {
      height: 64px;
      margin-bottom: 30px;
    }
    .zhmm-buzhouzhiyin>div {
      display: inline-block;
    }
    .zhmm-buzhouzhiyin .zhmm-buzounum {
      width: 100px;
      line-height: 14px;
      font-size: 14px;
      text-align: center;
      color: #bcbcbc;
    }
    .zhmm-buzhouzhiyin .zhmm-buzounum>div {
      height: 50px;
      line-height: 50px;
      font-size: 40px;
    }
    .zhmm-buzhouzhiyin .zhmm-fengexian {
      width: 80px;
      height: 29px;
      margin-top: auto;
      margin-bottom: auto;
      border-top: 6px solid #dcdcdc;
    }
    .zhmm-inputlist .yanzhengma-box input {
      width: 100px;
    }
    .zhmm-inputlist .yanzhengma-box img {
      padding-top: 6px;
    }
    .zhmm-inputlist .yanzhengma-box a {
      font-size: 12px;
      color: #ff5200;
    }
  </style>
  <div class="container">
    <div class="weizhi-lianjie"><a href="#">首页</a> <span>忘记密码</span></div>
    <div id="wangjimima-box">
      <div id="wjmm-tit">忘记密码</div>
      <div id="zhmm-fangshi"><a id="yxzh-btn" href="#">使用绑定邮箱找回密码</a><a id="sjzh-btn" href="#">使用绑定手机找回密码</a><a id="mbzh-btn" href="#">使用密保问题找回密码</a></div>
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
	 <form id="retrieve_form_1" action="${ctx }/p2p/front/retrievePwdByMail.ht" method="post">
	 <dl id="yx-zhmm">
          <dt><span>*</span>邮箱地址：</dt>
          <dd><input type="text" id="email_addr_id" name="email_addr" onblur="emailValid();"><label id="warrn_inf"></label> </dd>
          <dt><span>*</span>验证码：</dt>
          <dd class="yanzhengma-box"><input type="text" name="validCode_"><img src="${ctx}/servlet/ValidCode" id="validImg" alt=""><a href="javascript:void(0)" onclick="reload('1')">看不清，换一个</a></dd>
        </dl>
        <div class="sub-btn"><a href="javascript:void(0);" onclick="document.getElementById('retrieve_form_1').submit();">提 交</a></div>
        </form>
      </div>
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
        <form id="retrieve_form_2" action="${ctx }/p2p/front/mobileSendValiCode.ht" method="post">
        <dl id="sj-zhmm">
          <dt><span>*</span>手机号：</dt>
          <dd><input type="text" name="mobileNum" id="mobileNum_id"><img src="" id="err_id" alt=""></dd>
          <dt><span>*</span>验证码：</dt>
          <dd class="yanzhengma-box"><input type="text" name="valiCode_2" id="valiCode_2_id"><img src="${ctx}/servlet/ValidCode" id="validImg2" alt=""><a href="javascript:void(0)" onclick="reload('2')">看不清，换一个</a></dd>
        </dl>
        <div class="sub-btn"><a href="javascript:void(0);" onclick="mobileValiSubm();">提 交</a></div>
        </form>
      </div>
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
         <form id="retrieve_form_3" action="${ctx }/p2p/front/questionBackPwd.ht" method="post">
        <dl id="mb-zhmm">
          <dt><span>*</span>请输入您的账号：</dt>
          <dd><input type="text" name="userName_" id="userName_id"></dd>
          <dt><span>*</span>验证码：</dt>
          <dd class="yanzhengma-box"><input type="text" name="valiCode_3" id="valiCode_3_id"><img src="${ctx}/servlet/ValidCode" id="validImg3" alt=""><a href="javascript:void(0)" onclick="reload('3')">看不清，换一个</a></dd>
        </dl>
        <div class="sub-btn"><a href="javascript:void(0);" onclick="document.getElementById('retrieve_form_3').submit();">提 交</a></div>
        </form>
      </div>
      <div style="margin-bottom:35px;text-align:center;font-size:14px;color:#999;">若您无法使用上述方法找回，请联系客服400-888-8888</div>
    </div>
  </div>
  <div style="border-top:1px solid #dcdcdc;min-width:1000px;"></div>
  <div class="footer-w">
    <div class="footer container">
      <div>
        <ul>
          <li class="firstli">新手入门</li>
          <li><a href="#">免费注册</a></li>
          <li><a href="#">我的网贷</a></li>
          <li><a href="#">如何借入</a></li>
        </ul>
        <ul>
          <li class="firstli">我要借出</li>
          <li><a href="#">浏览借款</a></li>
          <li><a href="#">自动投标</a></li>
          <li><a href="#">成为VIP</a></li>
        </ul>
        <ul>
          <li class="firstli">我要借入</li>
          <li><a href="#">发布借款</a></li>
          <li><a href="#">优先计划</a></li>
          <li><a href="#">诚信认证</a></li>
        </ul>
        <ul>
          <li class="firstli">诚信保障</li>
          <li><a href="#">本金保障</a></li>
          <li><a href="#">法律政策</a></li>
        </ul>
        <ul>
          <li class="firstli">关于帝隆</li>
          <li><a href="#">帝隆团队</a></li>
          <li><a href="#">帝隆论坛</a></li>
          <li><a href="#">媒体报道</a></li>
          <li><a href="#">招贤纳士</a></li>
        </ul>
        <ul>
          <li class="firstli">关于我们</li>
          <li><a href="#">新浪微博</a></li>
          <li><a href="#">腾讯微博</a></li>
          <li><a href="#">联系我们</a></li>
        </ul>
        <ul>
          <li class="firstli">微信二维码</li>
          <li><img src="${ctx}/images/erweima.png" alt=""></li>
        </ul>
        <ul class="mobile-nav">
          <li class="li1">客服电话</li>
          <li class="li2">4000-000-000</li>
          <li class="li3">工作日：9:00-18:00</li>
        </ul>
      </div>
      <p class="center">帝隆科技有限公司 版权所有 2013-2014</p>
      <p class="center">Copyright Reserved 2013-2014©P2P贷（www.p2p.com） | 粤ICP备00000000号</p>
    </div>
  </div>
  <script type="text/javascript" src="${ctx}/js/jquery/jQuery v1.7.1.js"></script>
  <script>
    $(function(){
      $("#zhmm-fangshi a").bind("click",function(){
        //$(this).addClass($(this).attr("id")+"-hover");
        $(".zhmm-inputlist").css("display","none");
        $("."+$(this).attr("id")).slideDown();
      })
    })
  </script>
</body>
</html>