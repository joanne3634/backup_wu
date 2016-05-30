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
    <title>创业项目管理</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/crowdfunding/globalcss.jsp"%>
    <link rel="stylesheet" href="<h:static type="css" src="/crowdfunding/resources/css/entrepreneurCenterIndex.css" />" type="text/css">
    <script type="text/javascript">
        var _ctx="${ctx}", __ctx = _ctx, isLogin;
    </script>
</head>
<body class="iframe">
<div id="entrepreneurCenterIndex" class="all-100 push-center">
    <div class="title">
        <h3><i class="fa fa-flag"></i> 我的项目资料</h3>
        <a href="javascript:show();" class="push-right">>>项目商业计划书撰写指南（项目方融资必看）</a>
    </div>
    <c:if test="${tcproject.pstateId!=2 and tcproject.pstateId!=3}">
        <div class="ink-alert basic" role="alert">
            <p><b>温馨提示：</b>请完整填写您的项目资料，填写完整后，页面底部将会出现提交审核按钮，点击提交才能进行项目审核！</p>
        </div>
    </c:if>
    <c:if test="${tcproject.pstateId==9}">
        <div class="ink-alert basic error" role="alert">
            <p><b>审核不通过！</b>审核意见：${tcproject.pcheckRemark}</p>
        </div>
    </c:if>
    <table class="ink-table bordered">
        <c:if test="${tcproject.pstateId==0 or tcproject.pstateId==9}">
        <thead>
            <tr>
                <th colspan="4">
                    <a href="${ctx }/crowdfunding/tcproject/editorTcproject.ht?projectId=${tcproject.projectId}" class="ink-button blue push-right">
                        <i class="fa fa-edit fa-fw"></i> 编辑
                    </a>
                </th>
            </tr>
        </thead>
        </c:if>
        <tbody>
        <tr>
            <td class="label">项目名称：</td>
            <td colspan="3">${tcproject.pname}
                <span class="status">
                    <i class="fa fa-edit fa-fw"></i>
                <c:choose>
                    <c:when test="${tcproject.pstateId eq 0}">未提交申请</c:when>
                    <c:otherwise>
                        <f:description nodeKey="xmzt" itemValue="${tcproject.pstateId}"></f:description>
                    </c:otherwise>
                </c:choose>
                </span>
            </td>
        </tr>
        <tr>
            <td class="label">项目方：</td>
            <td colspan="3">${tuser.realName}</td>
        </tr>
        <tr>
            <td class="label">项目资料查看期限：</td>
            <td>
                <c:if test="${tcproject.pviewLimit==1}">所有用户需先申请经我批准后才可看</c:if>
                <c:if test="${tcproject.pviewLimit==0}">所有登录用户可看</c:if>
            </td>
            <td class="label">是否处于预热期：</td>
            <td><c:if test="${tcproject.pneedWarmUp==0}">否</c:if>
                <c:if test="${tcproject.pneedWarmUp>0}">是</c:if>
            </td>
        </tr>
        <tr>
            <td class="label">项目类别：</td>
            <td><f:description nodeKey="XMLX" itemValue="${tcproject.ptypeId}"/></td>
            <td class="label">是否有其他项目：</td>
            <td><f:description nodeKey="sf" itemValue="${tcproject.pisHaveOther}"/></td>
        </tr>
        <tr>
            <td class="label">项目所属行业：</td>
            <td><f:description nodeKey="PIND" itemValue="${tcproject.pindustry}"/></td>
            <td class="label">项目标签：</td>
            <td>${tcproject.plabel} </td>
        </tr>
        <tr>
            <td class="label">项目所属阶段：</td>
            <td><f:description nodeKey="PTYPE" itemValue="${tcproject.pstage}"/></td>
            <td class="label">企业成立时间：</td>
            <td>${tcproject.pfoundedYear}年${tcproject.pfoundedMonth}月</td>
        </tr>
        <tr>
            <td class="label">企业员工人数：</td>
            <td>${tcproject.pemployeesCount}人</td>
            <td class="label">企业所在城市：</td>
            <td>${tcproject.pprovincesName}${tcproject.pcityIname} </td>
        </tr>
        <tr>
            <td class="label">企业名称：</td>
            <td>${tcproject.pcompanyName}</td>
            <td class="label">办公地址：</td>
            <td>${tcproject.paddress}</td>
        </tr>
        <tr>
            <td class="label">项目估值￥：</td>
            <td colspan="3">
                <fmt:formatNumber value="${tcproject.pvaluationFinal}" pattern="###,###.##" minFractionDigits="0"></fmt:formatNumber>万
            </td>
        </tr>
        <tr>
            <td class="label">融资金额￥：</td>
            <td colspan="3">
                <fmt:formatNumber value="${tcproject.pfinancingAmount/10000}" pattern="###,###.##" minFractionDigits="0"></fmt:formatNumber>万
            </td>
        </tr>
        <tr>
            <td class="label">已认投金额：</td>
            <td colspan="3">
                <fmt:formatNumber value="${tcproject.pinvestAmount/10000}" pattern="###,###.##" minFractionDigits="0"></fmt:formatNumber>万
            </td>
        </tr>
        <tr>
            <td class="label">投资款拨付方式：</td>
            <td><f:description nodeKey="TZKPT" itemValue="${tcproject.ppayWay}"/></td>
            <td class="label">认投完成率：</td>
            <td>${tcproject.pcomplete}%</td>
        </tr>
        <tr>
            <td class="label">最低投资金额：</td>
            <td colspan="3">
                最低领投金额
                <fmt:formatNumber value=" ${tcproject.pinvestMinLeader/10000}" pattern="###,###.##" minFractionDigits="0" />万元，
                最低跟投金额
                <fmt:formatNumber value="${tcproject.pinvestMinFollow/10000}" pattern="###,###.##" minFractionDigits="0" />万元
            </td>
        </tr>
        <tr>
            <td class="label">企业项目简介：</td>
            <td colspan="3">${tcproject.pdetail}</td>
        </tr>
        <tr>
            <td class="label">项目图片：</td>
            <td colspan="3" class="image"><pageTag:projectPic menupath="${tcproject.projectId}"/></td>
        </tr>
        <tr>
            <td colspan="4" onclick="returnArtDialog()" class="video">
                <c:if test="${empty tcproject.pvideo}">暂未上传项目视频！ 项目审核完成后不能</c:if>点击此处更改项目视频！
            </td>
        </tr>
        </tbody>
    </table>

    <div id="detailTabs" class="ink-tabs top">
        <ul class="tabs-nav">
            <li><a class="tabs-tab" href="#business-model">市场定位与商业模式</a></li>
            <li><a class="tabs-tab" href="#entrepreneurial-teams">创业团队</a></li>
            <li><a class="tabs-tab" href="#history">历史情况</a></li>
            <li><a class="tabs-tab" href="#future-plans">未来计划</a></li>
            <li><a class="tabs-tab" href="#attachment">项目附件</a></li>
            <li><a class="tabs-tab" href="#project-dynamic">项目动态</a></li>
        </ul>
        <c:if test="${tcproject.pstateId==0 or tcproject.pstateId==9 }">
            <p class="align-right"><a href="javascript:editInfo();" class="ink-button blue"><i class="fa fa-edit fa-fw"></i> 编辑</a></p>
        </c:if>
        <div id="business-model" class="tabs-content">
        <c:if test="${not empty tcprojectModel.pmtargeted }">
            <div class="content-title">1、目标用户或客户群体定位</div>
            <div class="content-text">${tcprojectModel.pmtargeted }</div>
        </c:if>
        <c:if test="${not empty tcprojectModel.pmcurrentlyPlaguing }">
            <div class="content-title">2、市场行业分析</div>
            <div class="content-text">${tcprojectModel.pmcurrentlyPlaguing }</div>
        </c:if>
        <c:if test="${not empty tcprojectModel.pmservicesMode }">
            <div class="content-title">3、产品或服务分析</div>
            <div class="content-text">${tcprojectModel.pmservicesMode }</div>
        </c:if>
        <c:if test="${not empty tcprojectModel.pmprofitableDesc }">
            <div class="content-title">4、项目赢利模式说明</div>
            <div class="content-text">${tcprojectModel.pmprofitableDesc }</div>
        </c:if>
        <c:if test="${not empty tcprojectModel.pmcompetitors }">
            <div class="content-title">5、项目主要核心竞争力说明</div>
            <div class="content-text">${tcprojectModel.pmcompetitors }</div>
        </c:if>
        <c:if test="${not empty tcprojectModel.pmcoreCompetitiveness }">
            <div class="content-title">6、投资回报说明</div>
            <div class="content-text">${tcprojectModel.pmcoreCompetitiveness }</div>
        </c:if>
        <c:if test="${empty tcprojectModel.pmtargeted}">
            <div class="ink-alert basic info" role="alert">
                <p>暂无内容</p>
            </div>
        </c:if>
        </div>
        <div id="entrepreneurial-teams" class="tabs-content">
            <div class="content-title">1、股东团队说明</div>
            <div class="content-text">
                <table class="ink-table bordered">
                    <thead>
                    <tr>
                        <th class="align-left">姓名</th>
                        <th class="align-left">职务</th>
                        <th class="align-left">是否全职</th>
                        <th class="align-left">所占股份(%)</th>
                        <th class="align-left">实际出资金额</th>
                        <th class="align-left">与其他股东历史关系描述</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${listT }" var="vo">
                        <c:if test="${vo.pttypeId eq '1' }">
                            <tr>
                                <td>${vo.ptname}</td>
                                <td>${vo.ptduty}</td>
                                <td><f:description nodeKey="sf" itemValue="${vo.ptmisFullTime }"></f:description></td>
                                <td>${vo.pttheShare}</td>
                                <td>${vo.ptrealPay}</td>
                                <td>${vo.ptrelationship}</td>
                            </tr>
                        </c:if>
                    </c:forEach>
                    </tbody>
                </table>
                <c:forEach items="${listT }" var="vo">
                    <c:if test="${vo.pttypeId eq '1' }">
                        <div class="introduction-title">
                            <h4>${vo.ptname}股东详细介绍</h4>
                        </div>
                        <div style="padding: 1em;">${vo.ptmemberInfo}</div>
                    </c:if>
                </c:forEach>
            </div>
            <div class="content-title">2、非股东管理团队</div>
            <div class="content-text">
                <table class="ink-table bordered">
                    <thead>
                    <tr>
                        <th class="align-left">姓名</th>
                        <th class="align-left">职务</th>
                        <th class="align-left">是否全职</th>
                        <th class="align-left">入职时间</th>
                        <th class="align-left">与创始团队成员历史关系</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${listT }" var="vo">
                        <c:if test="${vo.pttypeId eq '0' }">
                            <tr>
                                <td>${vo.ptname}</td>
                                <td>${vo.ptduty}</td>
                                <td><f:description nodeKey="sf" itemValue="${vo.ptmisFullTime }"></f:description></td>
                                <td>${vo.ptentryTime}</td>
                                <td>${vo.ptrelationship}</td>
                            </tr>
                        </c:if>
                    </c:forEach>
                    <c:if test="${vo.pttypeId!='0'}">
                        <tr>
                            <td colspan="5">无</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
                <c:forEach items="${listT }" var="vo">
                    <c:if test="${vo.pttypeId eq '0' }">
                        <div class="introduction-title">
                            <h4>${vo.ptname}股东详细介绍</h4>
                        </div>
                        <div style="padding: 1em;">${vo.ptmemberInfo}</div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
        <div id="history" class="tabs-content">
            <c:forEach items="${listH }" var="vo" varStatus="i">
                <div class="content-title">${i.count }、第${i.count }阶段</div>
                <div class="content-text">
                    <p>1、阶段名称：${vo.phpname }</p>
                    <p>2、起止时间：${vo.phpstartYear }年${vo.phpstartMonth }月--${vo.phpendYear }年${vo.phpendMonth }月</p>
                    <p>3、阶段达成目标描述：${vo.phptargetDesc }</p>
                    <p>4、完成阶段目标的主要措施、方法、手段：${vo.phptargetWay }</p>
                    <p>5、阶段收入：</p>
                    <table class="ink-table bordered">
                        <thead>
                        <tr>
                            <th class="align-left">收入类别</th>
                            <th class="align-left">收入金额￥</th>
                            <th class="align-left">备注</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${vo.listHpPayMent }" var="payM">
                            <c:if test="${payM.hpptypeId eq '1' }">
                                <tr>
                                    <td>${payM.hppkindName }</td>
                                    <td><fmt:formatNumber value="${payM.hpppayment }" pattern="###,###.##"   minFractionDigits="2" /></td>
                                    <td>${payM.hppremarks }</td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        </tbody>
                    </table>
                    <p>6、阶段开支：</p>
                    <table class="ink-table bordered">
                        <thead>
                        <tr>
                            <th class="align-left">费用类别</th>
                            <th class="align-left">开支金额￥</th>
                            <th class="align-left">备注</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${vo.listHpPayMent }" var="payM">
                            <c:if test="${payM.hpptypeId eq '2' }">
                                <tr>
                                    <td>${payM.hppkindName }</td>
                                    <td><fmt:formatNumber value="${payM.hpppayment }" pattern="###,###.##"   minFractionDigits="2" /></td>
                                    <td>${payM.hppremarks }</td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:forEach>
            <c:if test="${not empty listH }">
            <div class="content-text">
                <p>累计盈亏：</p>
                <table class="ink-table bordered">
                    <thead>
                    <tr>
                        <th class="align-left">累计收入金额￥</th>
                        <th class="align-left">累计开支金额￥</th>
                        <th class="align-left">累计盈亏金额￥</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td><fmt:formatNumber value="${hmoneyIn }" pattern="###,###.##"   minFractionDigits="2" /></td>
                        <td><fmt:formatNumber value="${hmoneyOut }" pattern="###,###.##"   minFractionDigits="2" /></td>
                        <td><fmt:formatNumber value="${hmoneyIn-hmoneyOut }" pattern="###,###.##"   minFractionDigits="2" /></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            </c:if>
            <c:if test="${empty listH}">
                <div class="ink-alert basic info" role="alert">
                    <p>暂无内容</p>
                </div>
            </c:if>
        </div>
        <div id="future-plans" class="tabs-content">
            <c:forEach items="${listP }" var="vo" varStatus="i">
                <div class="content-title">${i.count }、第${i.count }阶段</div>
                <div class="content-text">
                    <p>1、阶段名称：${vo.phpname }</p>
                    <p>2、起止时间：${vo.phpstartYear }年${vo.phpstartMonth }月--${vo.phpendYear }年${vo.phpendMonth }月</p>
                    <p>3、阶段达成目标描述：${vo.phptargetDesc }</p>
                    <p>4、完成阶段目标的主要措施、方法、手段：${vo.phptargetWay }</p>
                    <p>5、阶段收入：</p>
                    <table class="ink-table bordered">
                        <thead>
                        <tr>
                            <th class="align-left">收入类别</th>
                            <th class="align-left">收入金额￥</th>
                            <th class="align-left">备注</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${vo.listHpPayMent }" var="payM">
                            <c:if test="${payM.hpptypeId eq '1' }">
                                <tr>
                                    <td>${payM.hppkindName }</td>
                                    <td><fmt:formatNumber value="${payM.hpppayment }" pattern="###,###.##"   minFractionDigits="2" /></td>
                                    <td>${payM.hppremarks }</td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        </tbody>
                    </table>
                    <p>6、阶段开支：</p>
                    <table class="ink-table bordered">
                        <thead>
                        <tr>
                            <th class="align-left">费用类别</th>
                            <th class="align-left">开支金额￥</th>
                            <th class="align-left">备注</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${vo.listHpPayMent }" var="payM">
                            <c:if test="${payM.hpptypeId eq '2' }">
                                <tr>
                                    <td>${payM.hppkindName }</td>
                                    <td><fmt:formatNumber value="${payM.hpppayment }" pattern="###,###.##"   minFractionDigits="2" /></td>
                                    <td>${payM.hppremarks }</td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:forEach>
            <c:if test="${not empty listP }">
            <div class="content-text">
                <p>累计盈亏：</p>
                <table class="ink-table bordered">
                    <thead>
                    <tr>
                        <th class="align-left">累计收入金额￥</th>
                        <th class="align-left">累计开支金额￥</th>
                        <th class="align-left">累计盈亏金额￥</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td><fmt:formatNumber value="${fmoneyIn }" pattern="###,###.##"   minFractionDigits="2" /></td>
                        <td><fmt:formatNumber value="${fmoneyOut }" pattern="###,###.##"   minFractionDigits="2" /></td>
                        <td><fmt:formatNumber value="${fmoneyIn-fmoneyOut }" pattern="###,###.##"   minFractionDigits="2" /></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            </c:if>
            <c:if test="${empty listP}">
                <div class="ink-alert basic info" role="alert">
                    <p>暂无内容</p>
                </div>
            </c:if>
        </div>
        <div id="attachment" class="tabs-content">
            <c:if test="${not empty listA }">
            <ul>
                <c:choose>
                <c:when test="${tcproject.pstateId ==0 or tcproject.pstateId==9 }">
                    <c:forEach items="${listA }" var="vo" varStatus="i">
                        <li>
                            <a href="${ctx}/crowdfunding/front/downloadFile.ht?fileId=${vo.attachmentId}" target="_blank">${vo.pafileName}</a>
                            <img alt="" src="${ctx}/styles/default/images/resicon/del.png" onclick="delAttach('${vo.attachmentId}')">
                        </li>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${listA }" var="vo" varStatus="i">
                        <li>
                            <a href="${ctx}/crowdfunding/front/downloadFile.ht?fileId=${vo.attachmentId}" target="_blank">${vo.pafileName}</a>
                        </li>
                    </c:forEach>
                </c:otherwise>
                </c:choose>
            </ul>
            </c:if>
            <c:if test="${empty listA }">
            <div class="ink-alert basic info" role="alert">
                <p>暂无内容</p>
            </div>
            </c:if>
        </div>
        <div id="project-dynamic" class="tabs-content">
            <c:if test="${not empty listN }">
                <ul>
                    <c:forEach items="${listN }" var="vo" begin="0" end="5">
                        <li>
                            <div class="item">
                                <div class="all-25">
                                    <a href="${ctx }/tcproject/ProjectDynamic/edit.ht?newsId=${vo.newsId }" target="_blank">
                                        <c:if test="${empty vo.fileId}">
                                            <img src="${ctx}/crowdfunding/Skin/Default/images/ProjectDynamic.png">   <!-- 项目动态图片,默认图片  -->
                                        </c:if>
                                        <c:if test="${not empty vo.fileId}">
                                            <pageTag:ProjectDynamic menupath="${vo.fileId}"/>   <!-- 项目动态图片  -->
                                        </c:if>
                                    </a>
                                </div>
                                <div class="all-75">
                                    <p class="title">
                                        <a title="${vo.pntitle }" href="${ctx }/tcproject/ProjectDynamic/edit.ht?newsId=${vo.newsId }" target="_blank">${vo.pntitle }</a>
                                    </p>
                                    <p>
                                        <c:if test="${fn:length(vo.pncontent) > 105 }">
                                            ${fn:substring(vo.pncontent,0,105) }...
                                        </c:if>
                                        <c:if test="${fn:length(vo.pncontent) <= 105 }">
                                            ${vo.pncontent }
                                        </c:if>
                                    </p>
                                    <p class="publisher">
                                        <span class="time"><i class="fa fa-clock-o"></i> 开标时间：<fmt:formatDate value="${vo.createTime }" pattern="yyyy-MM-dd HH:mm"/></span>
                                    </p>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </c:if>
            <c:if test="${empty listN }">
                <div class="ink-alert basic info" role="alert">
                    <p>暂无内容</p>
                </div>
            </c:if>
        </div>
    </div>
    <div class="ink-grid push-center align-center">
        <c:if test="${tcproject.pstateId==0 or tcproject.pstateId==9}"><!-- =9是项目初审被拒绝后的状态  -->
        <c:if test="${empty ok}">
            <button onclick="sumbmitTcproject();" class="ink-button blue">我已完善资料并提交审核</button>
        </c:if>
        </c:if>
    </div>
</div>
<input type="hidden" id="pstateId" name="pstateId" value="${tcproject.pstateId}">
<%@ include file="/crowdfunding/globaljs.jsp"%>
<script src="<h:static type="js" src="/crowdfunding/resources/js/entrepreneurCenterIndex.js" />"></script>
<script>
    (function() {
        window.showModalDialog = window.showModalDialog || function(url, arg, opt, cb) {
                    url = url || ''; //URL of a dialog
                    arg = arg || null; //arguments to a dialog
                    opt = opt || 'dialogWidth:300px;dialogHeight:200px'; //options: dialogTop;dialogLeft;dialogWidth;dialogHeight or CSS styles
                    cb = cb || function() {}; //callback on dialog close
                    var dialog = document.body.appendChild(document.createElement('dialog'));
                    opt = opt.replace(/dialog/gi, '');
                    dialog.setAttribute('style', opt);
                    dialog.innerHTML = '<a href="#" id="dialog-close" style="position: absolute; top: 0; right: 4px; font-size: 20px; color: #000; text-decoration: none; outline: none;">&times;</a><iframe id="dialog-body" src="' + url + '" style="border: 0; width: 100%; height: 100%;"></iframe>';
                    document.getElementById('dialog-body').contentWindow.dialogArguments = arg;
                    document.getElementById('dialog-close').addEventListener('click', function(e) {
                        e.preventDefault();
                        dialog.close();
                    });
                    dialog.addEventListener('close', function() {
                        var returnValue = document.getElementById('dialog-body').contentWindow.returnValue;
                        document.body.removeChild(dialog);
                        cb(returnValue);
                    });
                    dialog.showModal();
                };
    })();
    function returnArtDialog(){
        //0:已保存未提交；1：已提交；2：初审中；9：初审未通过
        switch ($('#pstateId').val()) {
            case "0":
            case "1":
            case "2":
            case "9":
                window.$.Dialog.saveVideo('请填写项目网络视频路径：<br/><input id="video" value="${tcproject.pvideo}" style="width: 350px"/>', function(){
                    if($("#video").val()){
                        var value = $("#video").val();
                        window.top.$.Dialog.toast({
                            content:"视频信息已保存！",
                            onDismiss:function() {
                                window.location.href="${ctx }/crowdfunding/tcproject/sumbmitTcproject.ht?pvideo="+value+"&projectId=${tcproject.projectId}";
                            }
                        });
                        return false;
                    }
                });
                break;
            case "7":
                window.top.$.Dialog.toast({content:"项目已经流标，不能再添加项目视频。"});
                break;
            default:
                window.top.$.Dialog.toast({content:"项目已通过平台审核，暂时不能添加项目视频。"});
                break;
        }
    }
    function show(){
        var url='${ctx}/loan/aboutus/HelpCenterDetails.ht?menupath=CYZ';
        window.top.$.Dialog.modalIframe({
            title: '项目方必看',
            url: url,
            width: '880px',
            height: '420px'
        });
    }
    function sumbmitTcproject(){
        window.top.$.Dialog.toast({
            content:"项目已提交，请等待平台通过审核。",
            onDismiss: function(){
                window.location.href="${ctx }/crowdfunding/tcproject/sumbmitTcproject.ht?projectId=${tcproject.projectId}";
            }
        });
    }
    //上传照片
    function addPic(p) {
        valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
        //FlexUploadDialog({isSingle:true,callback:picCallBack});

        var b = __ctx + "/crowdfunding/tcprojectAfter/projectAfterUploadDialog.ht?projectId=${tcproject.projectId}";
        b = b.getNewUrl();

        window.top.$.Dialog.modalIframe({
            url: b,
            title : '添加附件',
            width: '450px',
            height: '340px',
            onDismiss: function(){
                window.location.reload();
//                window.top.$.Dialog.toast({
//                    content:"项目附件添加成功。",
//                    onDismiss: function(){
//                        window.location.reload();
//                    }
//                });
            }
        });
    }

    function editInfo(){
        switch(detailTabs.activeTab()) {
            case "entrepreneurial-teams":
                //	if('${tcproject.pstateId}'=='1'||'${tcproject.pstateId}'=='2'||'${tcproject.pstateId}'=='7'){
                //为发起申请,初审未通过,询价认筹过程中 可以修改
                if('${tcproject.pstateId}'=='0'||'${tcproject.pstateId}'=='9'||'${tcproject.pstateId}'=='3'){
                    window.location.href="${ctx }/crowdfunding/tcproject/editorpartners.ht?projectId=${tcproject.projectId}";
                }else{
                    window.top.$.Dialog.toast({content: "项目已经提交，已提交的项目不能再编辑，除非项目被打回！"});
                }
                break;
            case "history":
                //	if('${tcproject.pstateId}'=='1'||'${tcproject.pstateId}'=='2'||'${tcproject.pstateId}'=='7'){
                //为发起申请,初审未通过,询价认筹过程中 可以修改
                if('${tcproject.pstateId}'=='0'||'${tcproject.pstateId}'=='9'||'${tcproject.pstateId}'=='3'){
                    window.location.href="${ctx }/crowdfunding/tcproject/editorhplans.ht?type=1&projectId=${tcproject.projectId}";
                }else{
                    window.top.$.Dialog.toast({content: "项目已经提交，已提交的项目不能再编辑，除非项目被打回！"});
                }
                break;
            case "future-plans":
                //		if('${tcproject.pstateId}'=='1'||'${tcproject.pstateId}'=='2'||'${tcproject.pstateId}'=='7'){
                //为发起申请,初审未通过,询价认筹过程中 可以修改
                if('${tcproject.pstateId}'=='0'||'${tcproject.pstateId}'=='9'||'${tcproject.pstateId}'=='3'){
                    window.location.href="${ctx }/crowdfunding/tcproject/editorhplans.ht?type=2&projectId=${tcproject.projectId}";
                }else{
                    window.top.$.Dialog.toast({content: "项目已经提交，已提交的项目不能再编辑，除非项目被打回！"});
                }
                break;
            case "attachment":
                addPic('${projectId}');
                break;
            case "project-dynamic":
                //	if('${tcproject.pstateId}'=='3'||'${tcproject.pstateId}'=='4'||'${tcproject.pstateId}'=='5'||'${tcproject.pstateId}'=='6'){
                //为发起申请,初审未通过,询价认筹过程中 可以修改
                if('${tcproject.pstateId}'=='0'||'${tcproject.pstateId}'=='9'||'${tcproject.pstateId}'=='3'){
                    window.location.href="${ctx }/tcproject/ProjectDynamic/ProjectDynamicBackList.ht?projectId=${tcproject.projectId}";
                }else{
                    window.top.$.Dialog.toast({content: "项目未通过平台审核，暂时不能添加项目动态。"});
                }
                break;
            default: //business-model
                //	if('${tcproject.pstateId}'=='1'||'${tcproject.pstateId}'=='2'||'${tcproject.pstateId}'=='7'){
                //为发起申请,初审未通过,询价认筹过程中 可以修改
                if('${tcproject.pstateId}'=='0'||'${tcproject.pstateId}'=='9'||'${tcproject.pstateId}'=='3'){
                    window.location.href="${ctx }/crowdfunding/tcproject/editorModels.ht?projectId=${tcproject.projectId}";
                }else{
                    window.top.$.Dialog.toast({content:"项目已经提交，已提交的项目不能再编辑，除非项目被打回！"});
                }
                break;
        }
    }

    function delAttach(attachId){
        window.top.Dialog.confirm("提示", "您确定删除吗", function(){
            $.ajax({
                url : "${ctx}/crowdfunding/front/delAttachment.ht",
                type : 'post',
                data: "ids="+attachId,
                success : function(data) {
                    window.top.$.Dialog.toast({
                        content:data,
                        onDismiss: function(){
                            window.location.reload();
                        }
                    });
                }
            });
        });
    }
</script>
</body>
</html>