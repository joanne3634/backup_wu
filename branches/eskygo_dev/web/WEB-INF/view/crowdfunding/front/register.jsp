<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]> <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]> <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang=""> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <%
        TUser  u=TUserUtil.getLogUser( request );
        if(null!=u){
            response.sendRedirect(request.getContextPath()+"/index-web.jsp");
        }
    %>
    <title><%=application.getAttribute("PLATFORM_NAME")%> - <c:if test="${groupId eq '1'}">项目方注册</c:if><c:if test="${groupId eq '2'}">投资方注册</c:if></title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/crowdfunding/globalcss.jsp"%>
    <link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/register.css" />" type="text/css">
    <script type="text/javascript">
        if (top != this) {
            //当这个窗口出现在iframe里，表示其目前已经timeout，需要把外面的框架窗口也重定向登录页面
            top.location = '${ctx}/index-web.jsp';
        }

    </script>
</head>
<body>
<%@ include file="/crowdfunding/head-v2.jsp"%>
<div id="register" class="ink-grid push-center all-90">
    <div class="column-group horizontal-gutters">
        <div class="registerLink all-50">
            <a class="ink-button <c:if test="${groupId eq '2'}">active</c:if> push-right" href="${ctx }/user/registerInit.ht?type=2">投资方注册</a>
        </div>
        <div class="registerLink all-50">
            <a class="ink-button <c:if test="${groupId eq '1'}">active</c:if> push-left" href="${ctx }/user/registerInit.ht?type=1">项目方注册</a>
        </div>
        <div class="all-100">
            <div class="register-container push-center">
                <h4 class="title">以下信息均为必填项，请完整填写！</h4>
                <div id="register-alert" class="ink-alert basic" style="display:none;" role="alert">
                    <button class="ink-dismiss" onclick="document.getElementById('register-alert').style.display='none'">&times;</button>
                    <p>
                        <strong id="register-alert-content"></strong>
                    </p>
                </div>
                <form action="${ctx}/user/register.ht" method="post" id="registerForm" class="ink-form">
                    <fieldset>
                        <input type="hidden" name="groupId" value="${groupId}"/>
                        <c:if test="${groupId eq '1'}">
                        <input type="hidden" value="0" name="isCompany"/>
                        </c:if>
                        <c:if test="${groupId eq '2'}">
                        <div class="control-group required gutters">
                            <label for="investors" class="all-20 align-right">用户类型：</label>
                            <div class="control all-80">
                                <label for="investors"><input type="radio" name="isCompany" id="investors" value="0" checked>投资个人</label>
                                <label for="investmentInstitutions"><input type="radio" id="investmentInstitutions" name="isCompany" value="1">投资机构</label>
                            </div>
                        </div>
                        </c:if>
                        <div class="control-group required gutters">
                            <label for="loginName" class="all-20 align-right">用户名：</label>
                            <div class="control all-80">
                                <input type="text" name="loginName" id="loginName" required data-rules="required|min_length[3]|max_length[20]" >
                            </div>
                        </div>
                        <div class="control-group required gutters">
                            <label for="email" class="all-20 align-right">邮箱：</label>
                            <div class="control all-80">
                                <input type="email" name="email" id="email" required data-rules="required|email">
                            </div>
                        </div>
                        <div class="control-group required gutters">
                            <label for="remarks" class="all-20 align-right">个人说明：</label>
                            <div class="control all-80">
                                <input type="text" name="remarks" id="remarks" required data-rules="required">
                                <p class="help-block" id="desc">建议采用公司+职务+真实姓名</p>
                            </div>
                        </div>
                        <c:if test="${groupId eq '2'}">
                        <div class="control-group required gutters">
                            <label for="cityId" class="all-20 align-right">所在城市：</label>
                            <div class="control all-80">
                                <select id="provincesId" name="provincesId">
                                    <option value="">请选择省</option>
                                    <c:forEach items="${arealist}" var="list">
                                        <option value="${list.areaId}">${list.areaName}</option>
                                    </c:forEach>
                                </select>
                                <select id="cityId" name="cityId" data-rules="required">
                                    <option value="">请选择市</option>
                                </select>
                            </div>
                        </div>
                        </c:if>
                        <div class="control-group required gutters">
                            <label for="loginPwd" class="all-20 align-right">密码：</label>
                            <div class="control all-80">
                                <input type="password" name="loginPwd" id="loginPwd" required data-rules="required|min_length[6]|max_length[20]|regexNumeric|regexAlpha" onKeyUp="pwStrength(this.value)" onBlur="pwStrength(this.value)">
                                <table cellspacing="0" cellpadding="1" class="pwd-controls">
                                    <tr align="center" bgcolor="#f5f5f5">
                                        <td width="33%" id="strength_L">弱</td>
                                        <td width="33%" id="strength_M">中</td>
                                        <td width="33%" id="strength_H">强</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="control-group required gutters">
                            <label for="resloginPwd" class="all-20 align-right">确认密码：</label>
                            <div class="control all-80">
                                <input type="password" name="resloginPwd" id="resloginPwd" required data-rules="required|matches[loginPwd]">
                            </div>
                        </div>
                        <div class="control-group required gutters">
                            <label for="realName" class="all-20 align-right">真实姓名：</label>
                            <div class="control all-80">
                                <input type="text" name="realName" id="realName" required data-rules="required">
                                <input type="text" name="contactName" id="contactName" required data-rules="required" style="display: none;" disabled>
                                <p class="help-block">用于网站运营管理人员替您办理投融资手续时使用</p>
                            </div>
                        </div>
                        <div class="control-group required gutters">
                            <label for="idNo" class="all-20 align-right">身份证号：</label>
                            <div class="control all-80">
                                <input type="text" name="idNo" id="idNo" required data-rules="required|idCard">
                                <input type="text" name="businessLicense" id="businessLicense" required data-rules="required" style="display: none;" disabled>
                                <p class="help-block">用于网站运营管理人员替您办理投融资手续时使用</p>
                            </div>
                        </div>
                        <div class="control-group required gutters">
                            <label for="personalAddress" class="all-20 align-right">个人地址：</label>
                            <div class="control all-80">
                                <input type="text" name="personalAddress" id="personalAddress" required data-rules="required">
                                <p class="help-block">用于办理投资入股工商变更手续及快递接收</p>
                            </div>
                        </div>
                        <div class="control-group required gutters">
                            <label for="mobile" class="all-20 align-right">手机号码：</label>
                            <div class="control all-80">
                                <input type="text" name="mobile" id="mobile" maxlength="11" required data-rules="required|mobile">
                                <p class="help-block">用于网站运营管理人员替您办理投融资手续时使用</p>
                            </div>
                        </div>
                        <div class="control-group required gutters">
                            <label for="code" class="all-20 align-right">验证码：</label>
                            <div class="control all-80">
                                <input type="text" name="code" id="code" maxlength="4" required data-rules="required" onkeyup="valideCode();"style="width:15%">
                                <img src="${ctx}/servlet/ValidCode" id="validImg" alt="看不清，换一个" onclick="reload()">
                                <a id="refreshCode" href="javascript:;" onclick="reload()">看不清，换一个</a>
                            </div>
                        </div>
                        <div id="msgcodeDiv" class="control-group required gutters" style="display:none">
                        	 <label for="msgcode" class="all-20 align-right">短信验证码：</label>
							 <div class="control all-80">
							 	<input type="text" name="msgcode" id="msgcode" maxlength="6" required data-rules="required" style="width:15%">
                             	<button id="btn-msgcode" type="button" class="getcode ink-button blue-light">获取校验码</button>
                             </div>
                        </div>
                        <span class="all-20">&nbsp;</span>
                        <label id="protocol" class="all-80">
                            <input type="checkbox"/> 我已阅读并认可《<a  id="protocolModalTrigger" href="#">用户注册协议</a>》、《<a id="riskNoticeTrigger" href="#">风险提示书</a>》
                        </label>
                    </fieldset>
                    <div class="control-group gutters">
                        <label class="all-20 align-right">&nbsp;</label>
                        <div class="control all-80">
                            <input id="submitBtn" class="ink-button blue-dark" type="submit" value="立即注册">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="ink-shade fade">
    <div id="protocolModal" class="ink-modal fade" data-trigger="#protocolModalTrigger" data-width="80%" data-height="80%" role="dialog" aria-hidden="true" aria-labelled-by="modal-title">
        <div class="modal-body" id="modalContent">
            <iframe frameborder="0" width="100%" height="100%" src="${ctx}/loan/aboutus/TermsServiceList.ht?xieyiid=4"></iframe>
        </div>
        <div class="modal-footer">
            <div class="push-right">
                <button class="ink-button caution ink-dismiss">确 定</button>
            </div>
        </div>
    </div>
</div>

<div class="ink-shade fade">
    <div id="riskNotice" class="ink-modal fade" data-trigger="#riskNoticeTrigger" data-width="80%" data-height="80%" role="dialog" aria-hidden="true" aria-labelled-by="modal-title">
        <div class="modal-body" id="noticeContent">
            <iframe frameborder="0" width="100%" height="100%" src="${ctx}/loan/aboutus/TermsServiceList.ht?xieyiid=5"></iframe>
        </div>
        <div class="modal-footer">
            <div class="push-right">
                <button class="ink-button caution ink-dismiss">确 定</button>
            </div>
        </div>
    </div>
</div>
<%@ include file="/crowdfunding/footer-v2.jsp"%>
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/register.js" />"></script>
</body>
</html>