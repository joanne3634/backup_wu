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
    <title>会员后台</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/crowdfunding/globalcss.jsp"%>
	<link rel="stylesheet" href="${ctx }/crowdfunding/resources/css/personalInfo.css">
</head>
<body class="iframe">
		<div class="addyourproject f_l">
			<header>
				<h2>基本资料</h2>
			</header>
			<!-- 后续可能需要，勿删    -->
			<!--<div class="PerDataTop">
				<div class="PerDataTopName">
					<p>${tuser.loginName }</p>
					安全等级
					<div class="progressBar" style="cursor: pointer;" onclick="location = '${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht';"><div style="width: ${safePlan}%"></div></div>
				</div>
				<div class="PerDataTopMoney">
					<div>账户余额 <span>${tuserFunds.balance }元</span></div>
					<span>冻结金额 ${tuserFunds.freeze }元</span><span>可用金额 ${tuserFunds.available }元</span>
				</div>
				<c:if test="${tuser.groupId eq 2 }">
					<div class="PerDataTopButton">
						<span class="PerDataTopButton1" onclick="location = '${ctx}/crowdfunding/memberCenter/toRechargePage.ht';">充&nbsp;&nbsp;值</span>
						<span class="PerDataTopButton2" onclick="location = '${ctx}/crowdfunding/memberCenter/todrawBack.ht';">提&nbsp;&nbsp;现</span>
					</div>
				</c:if>
			</div>  -->
			<form id="basicdata_form" class="ink-form v2 vertical">
			<fieldset class="clear personalDataform">
                <div class="control-group gutters">
                    <label class="all-100" for="loginName">
                    	用户名
                    </label>
                    <div class="control">
                    	<output name="loginName" tabIndex=0 id="loginName">${tuser.loginName }<summary class="onfocus">不可修改</summary></output>
                    </div>
                </div>
                <div class="control-group gutters">
                    <label class="all-100" for="email">
                    	邮箱
                    </label>
                    <div class="control">
                		<c:if test="${userSafe.bindMobile eq 1 }"><input id="email" name="email" value="${userSafe.email }" type="hidden"/>
	                    	<output name="email" id="email">${userSafe.email}<summary class="onfocus">不可修改</summary></output>
	                    	
                    	</c:if>
                    	<c:if test="${userSafe.bindMobile eq 0 }">
                    		<input id="email" name="email" type="email" required data-rules="required|email" value="${userSafe.email }" class="email" />
                    	</c:if>
                    </div>
                </div>
                <div class="control-group gutters">
                    <label class="all-100" for="remarks">个人说明<summary>建议采用公司+职务+真实姓名</summary></label>
                    <div class="control">
                    	<input id="remarks" name="remarks" data-rules="required" required type="text"  value="${tuser.remarks }" class="explain" />
                    	
                    </div>
                </div>
                <c:if test="${tuser.groupId eq 2 }">
	                <div class="control-group gutters">
	                    <label class="all-100" for="provincesId">所在城市</label>
	                    <div class="control">
	                    	<select id="provincesId" name="provincesId">
								<c:forEach items="${arealist }" var="list">	
									<option value="${list.areaId }" <c:if test="${tuser.provincesId == list.areaId }">selected</c:if>>${list.areaName }</option>
								</c:forEach>
							</select>
	                    </div>
	                    <div class="control">
	                    	<select id="cityId" name="cityId" data-rule="required">
								<option value="${tuser.cityId }"><h:getArea areaId="${tuser.cityId }"></h:getArea></option>
							</select>
	                    </div>
	                </div>
                </c:if>
				<c:choose>
					<c:when test="${tuser.isCompany eq 1 }">
		                <div class="control-group gutters">
		                    <label class="all-100" for="contactName">联系姓名<summary>用于网站运营管理人员替您办理投融资手续时使用</summary></label>
		                    <div class="control">
		                    	<input id="contactName" required data-rule="required" name="contactName" type="text" value="${tuser.contactName}" />
		                    	
		                    </div>
		                </div>
		                <div class="control-group gutters">
		                    <label class="all-100" for="remarks">营业执照</label>
		                    <div class="control">
		                    	<output id="businessLicense">${tuser.businessLicense }<summary class="onfocus">不可修改</summary></output>
		                    </div>
		                </div>
					</c:when>
					<c:when test="${tuser.isCompany eq 0 }">
		                <div class="control-group gutters">
		                    <label class="all-100" for="realName">真实姓名</label>
		                    <div class="control">
								<output id="realName">${tuser.realName }<summary class="onfocus">不可修改</summary></output>
							</div>
		                </div>
		                <div class="control-group gutters">
		                    <label class="all-100" for="idNo">身份证号</label>
		                    <div class="control">
								<output id="realName">${userSafe.idNo }<summary class="onfocus">不可修改</summary></output>
							</div>
		                </div>
					</c:when>
				</c:choose>
				<div class="control-group gutters">
					<label class="all-100" for="personalAddress">个人住址<summary>用于网站运营管理人员替您办理投融资手续时使用</summary></label>
					<div class="control">
						<input id="personalAddress" required data-rule="required" name="personalAddress" type="text"  value="${tuser.personalAddress }" class="address" />
						
					</div>
				</div>
				<c:choose>
					<c:when test="${userSafe.bindMobile eq 1 }">
						<div class="control-group gutters">
							<label class="all-100" for="mobile">手机号码</label>
							<div class="control">
								<output id="mobile" name="mobile">${userSafe.mobile }<summary class="onfocus">不可修改</summary></output>
							</div>
						</div>
					</c:when>
					<c:when test="${userSafe.bindMobile eq 0 }">
						<div class="control-group gutters">
							<label class="all-100" for="mobile">手机号码<summary>用于网站运营管理人员替您办理投融资手续时使用</summary></label>
							<div class="control">
								<input id="mobile" required data-rule="required|mobile" name="mobile" type="text"  value="${userSafe.mobile}"  />
							</div>
						</div>
					</c:when>
				</c:choose>
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
/* 	 $("#basicdata_form").validate({
	        rules: {
	        email: {//邮箱验证
	    	    required: true,
	    	    email: true
		   			},
			remarks: { //  个人说明/机构说明
			    required: true
			   	     },
		   	cityId: { //城市验证
	    		required: true
	  				},
	  		contactName: { //联系人姓名
	  	        required: true
	  				},
			realName: { //真实姓名
			    required: true
				    },
			personalAddress: {
				required: true
					},
			mobile: {
				required: true,
				mobile : true
					}
			//code: {
			//	required: true,
			//	remote : "${ctx}/user/validateCode.ht"
				//	}
				
	  		},
	        messages: {
	        email: {
		    	required: "必填",
		    	email:"请输入正确的邮箱"
		   			},
		   	remarks: {
	    		required: "必填"
	   			},
	   		cityId: {
		    	required: "必选"
		   		},
		  	contactName: { //联系人姓名
		  	    required: "必填"
		  		},
			realName: {
				required: "必填"
			    },
			personalAddress: {
				required: "必填"
				},
			mobile: {
				required: "必填",
				mobile:"输入正确的手机号"
				}
			//code: {
			//	required: "必填",
			//	remote:"输入正确的验证码"
				//}
	  		}
	    }); */
	    var form = $('#basicdata_form');

	    Ink.requireModules( ['Ink.Dom.Selector_1','Ink.UI.Modal_1', 'Ink.UI.FormValidator_2'], function( Selector, Modal, FormValidator ){

	        form.on('submit', function(e) {
	        	e.preventDefault();

	        });

	        var BasicDataFormValidator = new FormValidator( '#basicdata_form', {
	            onSuccess : function(elements){
		       		 valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
	    			$.ajax({
	    				url : "${ctx}/crowdfunding/tcuserPersonalData/editAccountData.ht",
	    				type : 'post',
	    				data : $('#basicdata_form').serialize(),
	    				dataType : 'json',
	    				success : function(data) {
	                        window.top.$.Dialog.toast({
	                            title: "提示",
	                            content: data,
	                            onDismiss: function() {
	                            	window.parent.location = "${ctx}/loan/myAccount/myaccountPage.ht?personal=1";
	                                /* window.parent.location.reload(); */
	                            }
	                        });
	    					setTimeout('window.parent.location = "${ctx}/loan/myAccount/myaccountPage.ht?personal=1";',2000);
	    					
	    				},
	    				error : function(xhr, textStatus, errorThrown) {
	    					//alert('异步获取数据出现异常');
	    				}
	    			});
	            },
	            onError: function(elements){
	            }
	        } );
	    });
	 
	 
	 function getCities(){
		 var self = this, $t = $(this);
		$.ajax({
			url : "${ctx}/user/ajaxGetJilian.ht",
			type : 'post',
			data : "areaId=" + $t.val(),
			dataType : 'json',
			success : function(data) {
				
				var oldVal = $('#cityId').val();
				var html = "<option value=''></option>";
				if(data.length > 0){
					for ( var i = 0; i < data.length; i++) {
						html += "<option value='" + data[i].areaId + (oldVal == data[i].areaId ? "' selected>" : "'>") + data[i].areaName + "</option>";
					}		
				}
				$("#cityId").html(html);
			},
			error : function(xhr, textStatus, errorThrown) {
				//alert('异步获取数据出现异常');
			}
		});
	}
		$("#provincesId").change(getCities).each(getCities); // adding each to ensure it starts with data
	 
		$(".personalDataform input").click(function(){
			$(this).parent().find("span").remove();
		});
		$("#PerDataTopButton").click(function(){
			$(this).parent().parent().find("span").remove();			
		});
	 
	
});


//刷新验证码
function reload(){
	var url="${ctx}/servlet/ValidCode?rand=" +new Date().getTime();
	document.getElementById("validImg").src=url;
}
</script>

</body>
</html>
