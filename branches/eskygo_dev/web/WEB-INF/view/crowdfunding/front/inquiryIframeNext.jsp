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
    <title>询价认筹</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/crowdfunding/globalcss.jsp" %>
    <link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/inquiryIframeNext.css" />" type="text/css">
    <script type="text/javascript">
        var _ctx = "${ctx}", isLogin;
        var __ctx='<%=request.getContextPath()%>';
        var __jsessionId='<%=session.getId() %>';
    </script>
</head>
<body class="iframe">
<div id="inquiryIframeNext" class="all-100 push-center">
    <form action="${ctx }/crowdfunding/front/doInvest.ht" method="post" id="dofrom" class="ink-form">
        <fieldset>
            <c:if test="${piisLeader eq '1'  }">
                <div style="display:none" >领投类型：<input style="width:15px;" type="radio" checked="checked" id="pitypeId_1" name="pitypeId" value="2"/>领投部分
                    <input type="radio"   id="pitypeId_2" name="pitypeId" value=""/>领投全部</div>
            </c:if>
            <div class="control-group required gutters">
                <label for="piinvest">投资金额（单位:万元）：</label>
                <div class="control">
                    <input type="text" id="piinvest" name="piinvest" placeholder="请输入内容" data-rules="required|integer">
                </div>
            </div>
            <div class="control-group required gutters">
                <label for="pireasons">投资理由：</label>
                <div class="control">
                    <textarea rows="6" id="pireasons" name="pireasons" placeholder="请输入内容" data-rules="required"></textarea>
                </div>
            </div>
            <div class="control-group required gutters">
                <label for="pimyHelp">我能为项目方提供非资金帮助：</label>
                <div class="control">
                    <textarea rows="6" id="pimyHelp" name="pimyHelp" placeholder="请输入内容" data-rules="required"></textarea>
                </div>
            </div>
            <c:choose>
                <c:when test="${piisLeader !=1 }">
                    <div class="control-group required gutters">
                        <label class="inline">是否愿意担任有限合伙企业普通合伙人：</label>
                        <div class="control">
                            <label for="piisGeneralPartner_1"><input type="radio" id="piisGeneralPartner_1" name="piisGeneralPartner" value="1">是</label>
                            <label for="piisGeneralPartner_2"><input type="radio" id="piisGeneralPartner_2" name="piisGeneralPartner" value="0" checked>否</label>
                        </div>
                    </div>
                    <label id="protocol" class="all-100">
                        <a href="javascript:loadCms('XSZN','普通合伙人和有限合伙人的区别？')">《普通合伙人和有限合伙人的区别》</a>
                    </label>
                </c:when>
                <c:otherwise>
                    <div class="control-group required gutters">
                        <label class="inline">领投人默认担任企业有限合伙人</label>
                    </div>
                    <label id="protocol" class="all-100">
                        <a href="javascript:loadCms('XSZN','普通合伙人和有限合伙人的区别？')">《普通合伙人和有限合伙人的区别》</a>
                    </label>
                    <input type="hidden" id="piisGeneralPartner" name="piisGeneralPartner" value="1">
                </c:otherwise>
            </c:choose>

        </fieldset>
        <input type="hidden" id="piisLeader" name="piisLeader" value="${piisLeader }"/>
        <input type="hidden" id="pinvestMinLeader" value="${pinvestMinLeader }"/>
        <input type="hidden" id="pinvestMaxLeader" value="${pinvestMaxLeader }"/>
        <input type="hidden" id="pinvestMinFollow" value="${pinvestMinFollow }"/>
        <input type="hidden" id="pfinancingAmount" value="${pfinancingAmount }"/>
        <input type="hidden" id="projectId" name="projectId" value="${projectId }"/>
        <div class="push-center align-center">
            <input id="submitBtn" class="ink-button blue-dark" type="submit" value="确认完成">
            <input id="cancelBtn" class="ink-button blue-white" type="button" value="取 消">
        </div>
    </form>
</div>
<%@ include file="/crowdfunding/globaljs.jsp" %>
<script src="<h:static type="js" src="/crowdfunding/resources/js/inquiryIframeNext.js" />"></script>
</body>
</html>