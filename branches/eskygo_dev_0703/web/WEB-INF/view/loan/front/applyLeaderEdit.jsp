<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/commons/includeFront/taglibs.jsp" %>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]> <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]> <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang=""> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>申请领投资格</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/crowdfunding/globalcss.jsp" %>
    <link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/applyLeaderEdit.css" />" type="text/css">
    <script type="text/javascript">
        var _ctx = "${ctx}", isLogin;
        var __ctx='<%=request.getContextPath()%>';
        var __jsessionId='<%=session.getId() %>';
    </script>
</head>
<body class="iframe">
<div id="applyLeaderEdit" class="all-100 push-center">
    <div class="title">
        <h3><i class="fa fa-pencil"></i> 申请领投资格</h3>
    </div>
    <form id="appform" name="appform" method="post" action="" class="ink-form">
        <fieldset>
            <%--提交阶段字段，已提交未审核1--%>
            <input type="hidden" id="industryId" name="industryId" value="${tuserApplyLeader.industryId}"/>
            <input type="hidden" id="isCheck" name="isCheck" value="${tuserApplyLeader.isCheck}"/>
            <input type="hidden" id="isSubmit">
            <input type="hidden" id="strName" name="strName">
            <input type="hidden" name="applyLeaderId" value="${tuserApplyLeader.applyLeaderId}"/>
            <h4 class="form-h4">请选择领投项目行业：（最多不超过三项）</h4>

            <div class="control-group required gutters">
                <div class="control all-100">
                    <c:if test="${not empty dictionaryList }">
                        <c:forEach items="${dictionaryList}" var="dictionary" varStatus="status">
                            <label><input type="checkbox" name="invesindustry"
                                          value="${dictionary.itemValue}">${dictionary.itemName}</label>
                        </c:forEach>
                    </c:if>
                </div>
            </div>
            <h4 class="form-h4">请填写个人简介：</h4>
            <p class="desc">
                要求写明个人求学、工作、创业、投资简历。请具体到起止年月、学校专业学历、公司名称部门职务、投资过企业名称等，便于我们做真实性背景调查，否则将不予以受理。
            </p>
            <div class="control-group gutters editors">
                <div class="control all-100">
                    <div class="ckeditorDiv">
                        <textarea name="contentText" id="contentText">${tuserApplyLeader.applyInfo}</textarea>
                    </div>
                    <p class="help-block">个人简介，不少于100字</p>
                </div>
            </div>
            <label id="protocol" class="all-80">
                <input type="checkbox"  name="riskCheck" id="riskCheck" checked> 我已阅读并认可《<a id="riskCommitment" href="#">领投人承诺书</a>》
            </label>
        </fieldset>
        <div class="push-center align-center padding">
            <c:if test="${tuserApplyLeader == null || tuserApplyLeader.isCheck==2}">
                <input id="dosubmitbtn" class="ink-button blue-dark" type="submit" value="确 定">
            </c:if>
            <c:if test="${tuserApplyLeader != null && tuserApplyLeader.isCheck != 2}">
                <input id="dosubmitbtn" class="ink-button blue-dark" type="submit" value="确 定" disabled>
            </c:if>
        </div>
        <span>
            审核状态:<font color='red'>
            <c:choose>
                <c:when test="${tuserApplyLeader.isCheck==1}"><span class="green">已通过</span></c:when>
                <c:when test="${tuserApplyLeader.isCheck==2}"><span class="red">未通过</span></c:when>
                <c:otherwise><span class="blue">未审核</span></c:otherwise>
            </c:choose>
        </font>
        </span>
        <c:if test="${tuserApplyLeader != null && tuserApplyLeader.checkFailReason !=null && tuserApplyLeader.checkFailReason !=''}">
            <span>审核说明:&nbsp;<font color='red'>${tuserApplyLeader.checkFailReason}</font></span>
        </c:if>
        <input type="hidden" name="str" id ="str"/>
    </form>
</div>
<%@ include file="/crowdfunding/globaljs.jsp" %>
<script src="<h:static type="js" src="/crowdfunding/js/ckeditor/ckeditor.js" />"></script>
<script src="<h:static type="js" src="/js/ckeditor/ckeditor_msg.js" />"></script>
<script src="<h:static type="js" src="/crowdfunding/resources/js/applyLeaderEdit.js" />"></script>
</body>
</html>