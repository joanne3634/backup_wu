<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>修改/绑定银行卡</title>
   <%@ include file="/crowdfunding/cssorjs.jsp"%> 
	<meta name="renderer" content="webkit"/>
	 <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
 	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
 	<link title="index" name="styleTag" rel="stylesheet" type="text/css" href="${ctx}/styles/default/css/web.css"></link>
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
    <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/bindBankCards.css">


</head>
<script type="text/javascript">

$().ready(function() {
	 $("#bindBankForm").validate({
	    rules: {
	    	 bankId: {
	  	       required:true
	  	       },
	  	       city: {
	  		    	required: true
	  		       },
	    opening: {
		required: true
		   },	    	
	    realName: {
		required: true
		   },
		idNo: {
	    required: true,
	    idNo : true,
	    remote: "${ctx}/user/validateIdNo.ht"
	   },
	    cardId: {
	    required: true,
	    digits:true
	   },
	    recardId: {
	    required: true,
	    equalTo: "#cardId"
	   }
	  },
	        messages: { 
	       bankId: {
	       required: "请选择银行"
	       },
	       city: {
		   required: "请选择省"
		    },
	       opening: {
	       required: "请选择市"
	       },
	        realName: {
		    required: "请输入真实姓名"
		   },
		   idNo: {
	   	   required: "请输入证件号码",
	   	   idNo: "请输入正确的证件号码",
	   	   remote:"该身份证号已存在,请重新输入"
	   },
	       cardId: {
	       required: "请输入银行卡号",
	       digits: "必须输入整数"

	   },
	  	   recardId: {
	       required: "请再次输入银行卡号",
	       equalTo: "两次输入的银行卡号不一致"
	   }
	  }
	    });
	});
 
function bindBank_form_submit(){
	var cityNumber = $("#city option:selected").attr("id");
	var openingNumber = $("#opening option:selected").attr("id");
	
	var bankCode = $("#bankId option:selected").attr("id");
	var bankName0 = $("#bankId option:selected").text();
	var bankName = escape(encodeURIComponent(bankName0));
	
	valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
	if($('#bindBankForm').valid()){	
		$.ajax({
			url : "${ctx}/loan/myAccount/bindBandCard.ht?cityNumber="+cityNumber+"&openingNumber="+openingNumber+"&bankCode="+bankCode+"&bankName="+bankName+"",
			type : 'post',
			data : $('#bindBankForm').serialize(),
			dataType : 'json',
			success : function(data,textStatus) {
				var datas = eval(data);
				if(datas == "0"){
					//alert(data);
					//alert("注册成功");
					window.parent.openDialog("绑定银行卡成功");
					setTimeout('window.location = "${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht";',2000);

					//setTimeout('window.location = "${ctx}/loan/myAccount/toBindBCPage.ht";',2000);

					//$("#result_").html("绑定银行卡成功");
					//window.location = "${ctx}/loan/myAccount/myaccountPage.ht";
					//goBack();
				}else{//alert(data);
					//$("#result_").html(datas);
					window.parent.openDialog("修改银行卡成功");
					setTimeout('window.location = "${ctx}/loan/myAccount/toBindBCPage.ht";',2000);
				}
				
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				//alert("绑定失败，请重试");
				//$("#result_").html("绑定失败，请重试");
				window.parent.openDialog("绑定失败，请重试");
				setTimeout('window.location = "${ctx}/loan/myAccount/toBindBCPage.ht";',2000);
			}
		});
	}

}
function goBack(){
	window.history.go(-1);
} 
</script>
<script type="text/javascript"> 
 function address(){ 
	if($('#city').val() =="请选择省"){return;}		
	var srcurl= "${ctx}/user/ajaxGetJilian.ht"; 
	$.ajax({
		url :srcurl,
		type : 'post',
		data : "areaId=" + $('#city').val(),
		dataType : 'json',
		success : function(data) { 
			var html = "<option value=''></option>";
			if(data.length > 0){
				for ( var i = 0; i < data.length; i++) { 
					html += "<option value='" + data[i].areaId +"'id='"+data[i].areaNumber+ "' >" + data[i].areaName + "</option>";
				}		
			}
			$("#opening").html(html);

		},
		error : function(xhr, textStatus, errorThrown) {
			// alert('异步获取数据出现异常');
		} 
	});
}
</script>
<body>
<form action="${ctx }/loan/myAccount/bindBandCard.ht" id="bindBankForm">
		<div class="addyourproject f_l">
			<h2><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">修改/绑定银行卡</h2>
   
        <div class="con-box">
          <div class="tips" style="margin-top:40px;">>>绑定唯一的银行卡或银行账户，保障您的投资/借款更加安全快捷。</div>
          <dl>
            <dt></dt>
            <dd class="error-tips"></dd>
            <dt><span>*</span>选择银行 :</dt>
            <dd  >
               <select name="bankId" id="bankId" style="width: 264px;height: 35px;"  class="text-input" >
              <option value="">--请选择银行--</option>
              	<c:forEach items="${banklist }" var="list">
              		<%-- <option value="${list.bankId }" <c:if test="${list.bankId  eq bindkcard.bankId }">selected='selected'</c:if>>${list.bankName }</option> --%>
              		<option value="${list.bankId }"  id="${list.bankCode }"  <c:if test="${list.bankId  eq bindkcard.bankId }">selected='selected'</c:if>>${list.bankName }</option>
              	</c:forEach>
              </select>
            </dd>
            <dt></dt>
            <dd class="error-tips"></dd>
            <dt><span>*</span>所在城市： </dt>
			<dd>
			<select id="city" name="city"   style="width: 130px;height: 35px;"  class="text-input" onchange="address();">
					<option value="请选择省">请选择省</option>
					<c:forEach items="${arealist }" var="list">
						<option value="${list.areaId }"  id="${list.areaNumber }" <c:if test="${list.areaId  eq bindkcard.city }">selected='selected'</c:if>>${list.areaName }</option>
					</c:forEach>
				</select>
				<select id="opening" name="opening" style="width: 130px;height: 35px;"  class="text-input">
				</select>
				</dd>				
            <dt></dt>
            <dd class="error-tips"></dd>
            <dt><span>*</span>真实姓名 :</dt>
            <dd><input id="realName" name="realName" <c:if test="${not empty isbindkcard }">readonly="readonly" value="${user.realName }"</c:if>   class="text-input" type="text" placeholder="请输入真实姓名"></dd>
            <dt></dt>
            <dd class="error-tips"></dd>
            <dt><span>*</span>证件号码 :</dt>
            <dd><input id="idNo" name="idNo" <c:if test="${not empty isbindkcard }">readonly="readonly" value="${userSafe.idNo }"</c:if>  class="text-input" type="text" placeholder="请输入身份证号"></dd>
            <dt></dt>
            <dd class="error-tips"></dd>
            <dt><span>*</span>银行卡号 :</dt>
            <dd><input id="cardId" name="cardId" class="text-input" type="text" placeholder="请输入银行卡号" value="${bindkcard.cardId }"></dd>
            <dt></dt>
            <dd class="error-tips"></dd>
            <dt><span>*</span>再次输入银行卡号 :</dt>
            <dd><input id="recardId" name="recardId" class="text-input" type="text" placeholder="请再次输入银行卡号"></dd>
            <c:if test="${ bindkcard==null}"><input id="bankCardId" name="bankCardId" class="text-input" type="hidden"  value="0"></c:if>
            <c:if test="${ bindkcard!=null}"> <input id="bankCardId" name="bankCardId" class="text-input" type="hidden"  value="${ bindkcard.bankCardId}"></c:if>
          </dl>
          <div style="text-align:center;">
            <input id="sub-btn-jibenxinxi" class="sub-btn" type="button" onclick="bindBank_form_submit();" value="确认提交">
            <input type="button" onclick="window.location.href= '${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht';"   class="sub-btn" value="返回" style="margin-left:10px;cursor: pointer;">
          </div>
        </div>
		</div>
		</form>
</body>
</html>
<script type="text/javascript">
$(function(){
	var provincet = $("#city").val();
	if($("#city").val()!=""){
		var srcurl= "${ctx}/user/ajaxGetJilian.ht"; 
		$.ajax({
			url :srcurl,
			type : 'post',
			data : "areaId=" + $('#city').val(),
			dataType : 'json',
			success : function(data) {
				var html = "<option value=''></option>";
				if(data.length > 0){
					for ( var i = 0; i < data.length; i++) {
						if('${bindkcard.opening}'==data[i].areaId){
							html += "<option value='" + data[i].areaId +"'id='"+data[i].areaNumber+"' selected='selected'>" + data[i].areaName + "</option>";
						}else{
							html += "<option value='" + data[i].areaId +"'id='"+data[i].areaNumber+ "' >" + data[i].areaName + "</option>";
						}
					}		
				}
				$("#opening").html(html);

			},
			error : function(xhr, textStatus, errorThrown) {
				// alert('异步获取数据出现异常');
			} 
		});
	}
	
})
</script>
