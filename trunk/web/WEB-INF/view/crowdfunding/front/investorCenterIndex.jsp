<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

	<title>会员后台</title>
		<%@ include file="/crowdfunding/cssorjs.jsp"%>
	<meta name="renderer" content="webkit"/>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/myInfo.css">
   <link  rel="stylesheet" type="text/css" href="${ctx }/styles/default/css/web.css"></link>
</head>

<script type="text/javascript">
$().ready(function() {
	 $("#basicdata_form").validate({
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
	    });
	 $("#PerDataTopButton").click(function(){
		 valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
		 if($('#basicdata_form').valid()){
			$.ajax({
				url : "${ctx}/crowdfunding/tcuserPersonalData/editAccountData.ht",
				type : 'post',
				data : $('#basicdata_form').serialize(),
				dataType : 'json',
				success : function(data) {
					window.parent.openDialog(data);
					setTimeout('window.parent.location = "${ctx}/loan/myAccount/myaccountPage.ht?personal=1";',2000);
					
				},
				error : function(xhr, textStatus, errorThrown) {
					//alert('异步获取数据出现异常');
				}
			});
		 }	 
	 });
	 
		$("#provincesId").change(function(){
			$.ajax({
				url : "${ctx}/user/ajaxGetJilian.ht",
				type : 'post',
				data : "areaId=" + $(this).val(),
				dataType : 'json',
				success : function(data) {
					var html = "<option value=''></option>";
					if(data.length > 0){
						for ( var i = 0; i < data.length; i++) {
							html += "<option value='" + data[i].areaId + "'>" + data[i].areaName + "</option>";
						}		
					}
					$("#cityId").html(html);

				},
				error : function(xhr, textStatus, errorThrown) {
					//alert('异步获取数据出现异常');
				}
			});
		});	
	 
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



<body>
		<div class="personalData f_l">
			<div class="PerDataTop">
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
			</div>
			<h3><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">基本资料</h3>
			<form id="basicdata_form" >
			<div class="clear personalDataform">
				<ul>
					<li><label class="descInfo"> 用户名： </label>${tuser.loginName }&nbsp;<dfn>（不能修改）</dfn></li>
					<c:if test="${userSafe.bindMobile eq 1 }"><input id="email" name="email" value="${userSafe.email }" type="hidden"/>
						<li><label class="descInfo">邮箱：</label>${userSafe.email }&nbsp;&nbsp;<dfn>(不能修改)</dfn></li>
					</c:if>
					<c:if test="${userSafe.bindMobile eq 0 }">
						<li><label class="descInfo">邮箱：</label><input id="email" name="email" type="text"  value="${userSafe.email }" class="email" /></li>
					</c:if>
					
					
					
					<%--<li>
						<label class="descInfo">个人说明：</label>--%>
						<input id="remarks" name="remarks" type="hidden"  value="${tuser.remarks }" class="explain" />
					<%--</li>
					<li><label class="descInfo"></label><dfn>如果昵称不是真实姓名，个人说明建议采用公司+职务+真实姓名</dfn></li>--%>
					<c:if test="${tuser.groupId eq 2 }">
					<li><label class="descInfo">所在城市：</label>
					<select id="provincesId" name="provincesId">				
					<c:forEach items="${arealist }" var="list">	
						<option value="${list.areaId }" <c:if test="${tuser.provincesId == list.areaId }">selected</c:if>>${list.areaName }</option>
					</c:forEach>
					</select>
					<select id="cityId" name="cityId">
						<option value="${tuser.cityId }"><f:description modelCode="t_area"  modelPropertyName="areaName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${tuser.cityId }"></f:description></option>
					</select>
					</li>
					</c:if>
					
					<c:if test="${tuser.isCompany eq 1 }"> <!-- 是否是机构投资     是 -->
						<li><label class="descInfo">联系姓名：</label><input id="contactName" name="contactName" type="text" value="${tuser.contactName }" /><span>用于网站运营管理人员替您办理投融资手续时使用</span></li>
						<li><label class="descInfo">营业执照：</label><dfn>${tuser.businessLicense }</dfn><dfn>（不能修改）</dfn></li>
					</c:if>
					<c:if test="${tuser.isCompany eq 0 }"> <!-- 是否是机构投资     否 -->
						<c:if test="${empty isbindkcard }">
							<li><label class="descInfo">真实姓名：</label><input id="realName" name="realName" type="text" value="${tuser.realName }" /><span>用于网站运营管理人员替您办理投融资手续时使用</span></li>
						</c:if>
						<c:if test="${not empty isbindkcard }">
						<input id="realName" name="realName" type="hidden" value="${tuser.realName }" />
							<li><label class="descInfo">真实姓名：</label><dfn>${tuser.realName }</dfn><dfn>（不能修改）</dfn></li>
						</c:if>
						<c:if test="${userSafe.bindIdNo eq 1 }">
							<li><label class="descInfo">身份证号：</label><dfn>${userSafe.idNo }</dfn><dfn>（不能修改）</dfn></li>
						</c:if>
						<c:if test="${userSafe.bindIdNo eq 0 }">
							<li><label class="descInfo">身份证号：</label><input id="idNo" name="idNo" type="text"  value="${userSafe.idNo }"  /><span>用于网站运营管理人员替您办理投融资手续时使用</span></li>
						</c:if>				
						
					</c:if>			
					<li><label class="descInfo">个人住址：</label><input id="personalAddress" name="personalAddress" type="text"  value="${tuser.personalAddress }" class="address" /><span>用于网站运营管理人员替您办理投融资手续时使用</span></li>
					<c:if test="${userSafe.bindMobile eq 1 }"><input id="mobile" name="mobile" type="hidden"  value="${userSafe.mobile }"  />
						<li><label class="descInfo">手机号码：</label>${userSafe.mobile }&nbsp;&nbsp;<dfn>(不能修改)</dfn></li>
					</c:if>
					<c:if test="${userSafe.bindMobile eq 0 }">
						<li><label class="descInfo">手机号码：</label><input id="mobile" name="mobile" type="text"  value="${userSafe.mobile }"  /><span>用于网站运营管理人员替您办理投融资手续时使用</span></li>
					</c:if>
					
					<!-- <li><label>验证码：</label><input id="code" name="code" type="text" class="code" />&nbsp;&nbsp;<img src="${ctx}/servlet/ValidCode" id="validImg" alt="" onclick="reload()" style="cursor: pointer;padding-right: 50px;"/></li> -->
					
					<li><label class="descInfo"></label><dfn class="PerDataTopButton2" id="PerDataTopButton">保&nbsp;&nbsp;存</dfn></li>
				</ul>
			</div>
			</form>
			
		</div>
	
</body>
</html>
