<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>项目审核</title>
	<%@include file="/commons/include/get.jsp" %>
</head>
<script type="text/javascript">

	
	
function audits(ab){
	
	
	
	
	var d = $("input[type='checkbox'][disabled!='disabled'][class='pk']:checked");
	if (d.length == 0) {
		$.ligerDialog.warn("请选择记录！");
		return false;
	}
	
	var f = ""; 
	var c = "";
	var a = d.length;
	var flag=true;
	d.each(function(g) {
		var h = $(this);
		
		if (g < a - 1) {
			f += h.val() + ",";
		} else {
			c = h.attr("name");
			f += h.val();
		}
	});
	
		agreeApply(f,ab);
	
}
function agreeApply(pamrm,agOrdisag,isok){
	if(agOrdisag=='agree'){
		
		
		$.ligerDialog.confirm("确认执行该操作吗？","提示信息",function(rtn){
			if(!rtn){
				
				
			}else{
				if(isok==1){
					$.ligerDialog.warn("项目的信息并没有填写完整，请联系项目创建人完成项目信息再审核通过。详情请点击<a href='edit.ht?projectId="+pamrm+"' class='link edit'>查看项目方资料</a>。");
				}else{
					var rep=$.ajax({  
				        type: "POST",  
				        url: "${ctx}/crowdfunding/backstage/proAudit/updates.ht",
				        data: {applyIds:pamrm,agOrdisag:agOrdisag }  
				        });  
					rep.done(function( data ){  
				       	//	 $.ligerDialog.warn(data.msg);
				       		///closewin();
				       		location.href=location.href.getNewUrl();
				        });  
				      
				    rep.fail(function( jqXHR, textStatus ) {  
				        $.ligerDialog.warn(textStatus);
				    });
				}
			} 
		});
	}else{
		location.href="get.ht?projectId="+pamrm;
	//	openWdin(pamrm,this);
	}
	   
}

function updatevaluetionFinal(projectId){
	
    var url="${ctx}/crowdfunding/backstage/proAudit/valution.ht?projectId="+projectId ;
	window.parent.parent.openDialog(url,'修改项目估值','','200','500');
}
</script>
<body>		
	<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">初审项目列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><f:a alias="search_tproject" css="link search" id="btnSearch" ><span></span>查询</f:a></div>
							<div class="l-bar-separator"></div>
							<%-- <div class="group"><f:a alias="add_tproject" css="link " href="javascript:void(0);" onclick="audits('agree')">批量通过</f:a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><f:a alias="upd_tproject" css="link " href="javascript:void(0);" onclick="audits('disagree')">批量拒绝</f:a></div>
							<div class="l-bar-separator"></div> --%>
							<%-- <div class="group"><f:a alias="del_tproject" css="link del" action="del.ht">删除</f:a></div> --%>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
						<form id="searchForm" method="post" action="list.ht">
							<div class="row">
										
										
									<span class="label">项目名称:</span><input type="text" name="Q_pname_S" value="${param['Q_pname_S']}" maxlength="100" class="inputText" />
									<span class="label">审核状态:</span>
											<%-- <select name="pstatus" class="select" value="${pstatus}">
												<option value="0"  <c:if test="${pstatus eq '0' || empty pstatus}">selected="selected"</c:if>></option>
												<option value="1" <c:if test="${pstatus eq '1' }">selected="selected"</c:if>>未审核</option>
												<option value="2" <c:if test="${pstatus eq '2' }">selected="selected"</c:if>>已通过</option>
												<option value="3" <c:if test="${pstatus eq '3' }">selected="selected"</c:if>>已拒绝</option>
											</select> --%>
											<select name="pcheckTime" class="select" value="${pcheckTime}">
												<option value="0" ></option>
												<option value="1" <c:if test="${ empty pcheckTime }">selected="selected"</c:if>>未审核</option>
												<%--<option value="2" <c:if test="${ !empty pcheckTime }">selected="selected"</c:if>>已审核</option>--%>
											</select>			
									<span class="label">项目状态:</span>
									<select name="pstateId" class="select" value="${pstateId}">
										<option></option>
										<option value="0">已保存未提交</option>
										<option value="1">已提交</option>
									</select>
									<%-- <span class="label">项目星期资料查看权限:</span><input type="text" name="Q_pviewLimit_S" value="${tproject.pviewLimit}" maxlength="3" class="inputText" /> --%>
									<span class="label">项目类别</span>
									<%-- <input type="text" name="Q_ptypeId_S" value="${tproject.ptypeId}" maxlength="10" class="inputText" /> --%>
									<f:select  styleClass="inputText" nodeKey="XMLX" id="ptypeId" idName="ptypeId" defaultValue="${param['ptypeId']}" showBlankOnTop="true" ></f:select>
									<%-- <span class="label">项目标签:</span><input type="text" name="Q_plabel_S" value="${tproject.plabel}" maxlength="200" class="inputText" /> --%>
									<span class="label">项目所属行业:</span>
									<%-- <input type="text" name="Q_pindustry_S" value="${tproject.pindustry}" maxlength="10" class="inputText" /> --%>
									<f:select  styleClass="inputText" nodeKey="PIND" id="pindustry" idName="pindustry" defaultValue="${param['pindustry']}" showBlankOnTop="true" ></f:select>
									<%-- <span class="label">:</span>
									<select name="Q_fromType_S" class="select" value="${param['Q_fromType_S']}">
										<option value="">--选择--</option>
										<option value="<%=SysUser.FROMTYPE_DB %>">系统添加</option>
										<option value="<%=SysUser.FROMTYPE_AD %>">AD同步</option>
									</select> --%>
							</div>
							<%-- <div class="row">
									
									<span class="label">企业所在城市:</span><input type="text" name="Q_pcityId_S" value="${tproject.pcityId}" maxlength="10" class="inputText" />
									<span class="label">企业所在省份:</span><input type="text" name="Q_pprovincesId_S" value="${tproject.pprovincesId}" maxlength="10" class="inputText" />
									<span class="label">企业成立年份:</span><input type="text" name="Q_pfoundedYear_S" value="${tproject.pfoundedYear}" maxlength="10" class="inputText" />
							</div> --%>
							<%-- <div class="row">
									<span class="label">公司名称:</span><input type="text" name="Q_pcompanyName_S" value="${tproject.pcompanyName}" maxlength="100" class="inputText" />
									<span class="label">企业成立月份:</span><input type="text" name="Q_pfoundedMonth_S" value="${tproject.pfoundedMonth}" maxlength="10" class="inputText" />
									
									<span class="label">项目所属阶段:</span><input type="text" name="Q_pstage_S" value="${tproject.pstage}" maxlength="10" class="inputText" />
									<span class="label">是否有其他项目:</span><input type="text" name="Q_pisHaveOther_S" value="${tproject.pisHaveOther}" maxlength="3" class="inputText" />
									<span class="label">公司是否成立:</span><input type="text" name="Q_psetup_S" value="${tproject.psetup}" maxlength="3" class="inputText" />
							</div> --%>
							<%-- <div class="row">
									<span class="label">公司名称:</span><input type="text" name="Q_pcompanyName_S" value="${tproject.pcompanyName}" maxlength="100" class="inputText" />
									<span class="label">公司地址:</span><input type="text" name="Q_paddress_S" value="${tproject.paddress}" maxlength="150" class="inputText" />
									<span class="label">企业项目简介:</span><input type="text" name="Q_pdetail_S" value="${tproject.pdetail}" maxlength="2000" class="inputText" />
									<span class="label">融资金额（万元）:</span><input type="text" name="Q_pfinancingAmount_S" value="${tproject.pfinancingAmount}" maxlength="32" class="inputText" />
							</div> --%>
							<%-- <div class="row">
									<span class="label">认投金额（万元）:</span><input type="text" name="Q_pinvestAmount_S" value="${tproject.pinvestAmount}" maxlength="32" class="inputText" />
									<span class="label">完成比例%:</span><input type="text" name="Q_pcomplete_S" value="${tproject.pcomplete}" maxlength="10" class="inputText" />
									<span class="label">投资款拨付方式:</span><input type="text" name="Q_ppayWay_S" value="${tproject.ppayWay}" maxlength="10" class="inputText" />
									<span class="label">公司是否成立:</span><input type="text" name="Q_psetup_S" value="${tproject.psetup}" maxlength="3" class="inputText" />
							</div>
							<div class="row">
									<span class="label">浏览次数:</span><input type="text" name="Q_pviewCount_S" value="${tproject.pviewCount}" maxlength="10" class="inputText" />
									<span class="label">被收藏次数:</span><input type="text" name="Q_pfavoritesCount_S" value="${tproject.pfavoritesCount}" maxlength="10" class="inputText" />
									<span class="label">跟投人数:</span><input type="text" name="Q_pinvestCount_S" value="${tproject.pinvestCount}" maxlength="10" class="inputText" />
									<span class="label">询价人数:</span><input type="text" name="Q_paskPriceCount_S" value="${tproject.paskPriceCount}" maxlength="10" class="inputText" />
							</div> --%>
							<%-- <div class="row">
									<span class="label">项目图片:</span><input type="text" name="Q_ppic_S" value="${tproject.ppic}" maxlength="150" class="inputText" />
									<span class="label">项目视频:</span><input type="text" name="Q_pvideo_S" value="${tproject.pvideo}" maxlength="150" class="inputText" />
									<span class="label">开标日期:</span><input type="text" name="Q_beginpopenDate_DL" value="<fmt:formatDate value='${tproject.beginpopenDate}' class="inputText date" style="width:9%"/>
									<span class="label">至</span><input type="text" name="Q_endpopenDate_DG" value="<fmt:formatDate value='${tproject.endpopenDate}' class="inputText date" style="width:9%"/>
									<span class="label">结束日期:</span><input type="text" name="Q_beginpcloseDate_DL" value="<fmt:formatDate value='${tproject.beginpcloseDate}' class="inputText date" style="width:9%"/>
									<span class="label">至</span><input type="text" name="Q_endpcloseDate_DG" value="<fmt:formatDate value='${tproject.endpcloseDate}' class="inputText date" style="width:9%"/>
							</div>
							<div class="row">
									<span class="label">是否推荐项目:</span><input type="text" name="Q_pisRecommended_S" value="${tproject.pisRecommended}" maxlength="3" class="inputText" />
									<span class="label">开标天数:</span><input type="text" name="Q_popenDays_S" value="${tproject.popenDays}" maxlength="10" class="inputText" />
									<span class="label">最低投资金额（万元）:</span><input type="text" name="Q_pinvestMax_S" value="${tproject.pinvestMax}" maxlength="32" class="inputText" />
									<span class="label">最大投资金额（万元）:</span><input type="text" name="Q_pinvestMin_S" value="${tproject.pinvestMin}" maxlength="32" class="inputText" />
							</div>
							<div class="row">
									<span class="label">创建人:</span><input type="text" name="Q_creator_S" value="${tproject.creator}" maxlength="19" class="inputText" />
									<span class="label">创建日期:</span><input type="text" name="Q_begincreateTime_DL" value="<fmt:formatDate value='${tproject.begincreateTime}' class="inputText date" style="width:9%"/>
									<span class="label">至</span><input type="text" name="Q_endcreateTime_DG" value="<fmt:formatDate value='${tproject.endcreateTime}' class="inputText date" style="width:9%"/>
									<span class="label">是否删除:</span><input type="text" name="Q_isDel_S" value="${tproject.isDel}" maxlength="3" class="inputText" />
									<span class="label">是否满标:</span><input type="text" name="Q_pisFull_S" value="${tproject.pisFull}" maxlength="3" class="inputText" />
							</div>
							<div class="row">
									<span class="label">满标日期:</span><input type="text" name="Q_beginpfullTime_DL" value="<fmt:formatDate value='${tproject.beginpfullTime}' class="inputText date" style="width:9%"/>
									<span class="label">至</span><input type="text" name="Q_endpfullTime_DG" value="<fmt:formatDate value='${tproject.endpfullTime}' class="inputText date" style="width:9%"/>
									<span class="label">审核是否通过（平台）:</span><input type="text" name="Q_pisCheck_S" value="${tproject.pisCheck}" maxlength="3" class="inputText" />
									<span class="label">审核人:</span><input type="text" name="Q_pchecker_S" value="${tproject.pchecker}" maxlength="19" class="inputText" />
									<span class="label">审核日期:</span><input type="text" name="Q_beginpcheckTime_DL" value="<fmt:formatDate value='${tproject.beginpcheckTime}' class="inputText date" style="width:9%"/>
									<span class="label">至</span><input type="text" name="Q_endpcheckTime_DG" value="<fmt:formatDate value='${tproject.endpcheckTime}' class="inputText date" style="width:9%"/>
							</div>
							<div class="row">
									<span class="label">是否放款:</span><input type="text" name="Q_pisPay_S" value="${tproject.pisPay}" maxlength="3" class="inputText" />
									<span class="label">放款日期:</span><input type="text" name="Q_beginppayTime_DL" value="<fmt:formatDate value='${tproject.beginppayTime}' class="inputText date" style="width:9%"/>
									<span class="label">至</span><input type="text" name="Q_endppayTime_DG" value="<fmt:formatDate value='${tproject.endppayTime}' class="inputText date" style="width:9%"/>
									<span class="label">交易费比例:</span><input type="text" name="Q_pdealRate_S" value="${tproject.pdealRate}" maxlength="32" class="inputText" />
									<span class="label">交易费（元）:</span><input type="text" name="Q_pdealFees_S" value="${tproject.pdealFees}" maxlength="32" class="inputText" />
							</div>
							<div class="row">
									<span class="label">贷款人最后取得金额（扣除各种费用后）（元）:</span><input type="text" name="Q_pfinalGetPay_S" value="${tproject.pfinalGetPay}" maxlength="32" class="inputText" />
									<span class="label">是否流标:</span><input type="text" name="Q_pisBreak_S" value="${tproject.pisBreak}" maxlength="3" class="inputText" />
									<span class="label">流标日期:</span><input type="text" name="Q_beginpbreakTime_DL" value="<fmt:formatDate value='${tproject.beginpbreakTime}' class="inputText date" style="width:9%"/>
									<span class="label">至</span><input type="text" name="Q_endpbreakTime_DG" value="<fmt:formatDate value='${tproject.endpbreakTime}' class="inputText date" style="width:9%"/>
									<span class="label">流标说明:</span><input type="text" name="Q_pbreakRemark_S" value="${tproject.pbreakRemark}" maxlength="500" class="inputText" />
							</div> --%>
								
						</form>
					</div>
					<div class="panel-data">
				    	<%-- <c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set> --%>
					    <display:table name="tprojectList" id="tprojectItem" requestURI="list.ht" sort="external" cellpadding="1" cellspacing="1"   class="table-grid">
							<%--<display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
							<%-- <display:column title="${checkAll}" media="html" style="width:30px;text-align:center;">
								  <input type="checkbox" class="pk" name="projectId" id="projectId" value="${tprojectItem.projectId}"}>
							</display:column> --%>
							<%-- <display:column property="pname" title="项目名称" sortable="false" sortName="pname" style="text-align:left"/> --%>
							<display:column title="项目名称" sortable="false"  sortName="pname" style="text-align:left;">
							<a title="点击查看" href="edit.ht?projectId=${tprojectItem.projectId}" >${tprojectItem.pname }</a>
							</display:column> 
							<display:column property="realName" title="项目发起人" sortable="false" sortName="realName" style="text-align:left"/> 
							<display:column  title="项目状态" sortable="false" sortName="pstateId" style="text-align:left">
								<%-- <c:choose>
									<c:when test="${tprojectItem.pstateId==1}">
										<span class="red">新申请</span>
								   	</c:when>
								   <c:when test="${tprojectItem.pstateId==2}">
										<span class="green">初审中</span>
								   	</c:when>
							       	<c:otherwise>
								    	<span class="green">询价众筹中</span>
								   	</c:otherwise>
								</c:choose> --%>
								<f:description nodeKey="xmzt" itemValue="${tprojectItem.pstateId}"></f:description>
							</display:column> 
							
						 <display:column property="pcheckTimes" title="拒绝次数" sortable="false" sortName="pcheckTimes" style="text-align:left"/>  
							
							<%-- <display:column property="pisCheck" title="审核<br>是否通过" sortable="false" sortName="pisCheck" style="text-align:left"/> 
							 --%> 
							
							 
							 <display:column  title="项目估值" sortable="false" sortName="pvaluationFinal" style="text-align:left">
							 <fmt:formatNumber value="${tprojectItem.pvaluationFinal}" pattern="###,###"  minFractionDigits="0"  />万
							 </display:column>
							<display:column property="createTimestr" title="创建日期" sortable="false" sortName="createTimestr" style="text-align:left"/> 
							 <display:column title="项目类别" sortable="false" sortName="ptypeId" style="text-align:left">
								<%-- <c:choose>
									<c:when test="${tprojectItem.ptypeId==1}">
										<span class="green">科技创新项目</span>
								   	</c:when>
								  <c:when test="${tprojectItem.ptypeId==2}">
										<span class="green">连锁服务业项目</span>
								   	</c:when>
							       	<c:otherwise>
								    	<span class="green">其他创意项目</span>
								   	</c:otherwise>
								</c:choose> --%>
								<f:description nodeKey="XMLX" itemValue="${tprojectItem.ptypeId}"></f:description>
							</display:column> 
							<display:column  title="所属行业" sortable="false" sortName="pindustry" style="text-align:left">
								<f:description nodeKey="PIND" itemValue="${tprojectItem.pindustry}"></f:description>
							</display:column> 
							<%-- <display:column property="pcityId" title="企业所在城市" sortable="false" sortName="pcityId" style="text-align:left"/> 
							<display:column property="pprovincesId" title="企业所在省份" sortable="false" sortName="pprovincesId" style="text-align:left"/> 
							<display:column property="pfoundedYear" title="企业成立日期" sortable="false" sortName="pfoundedYear" style="text-align:left"/> --%> 
							<%-- <display:column property="pfoundedMonth" title="企业成立月份" sortable="false" sortName="pfoundedMonth" style="text-align:left"/> --%> 
							<%-- <display:column property="plabel" title="标签" sortable="false" sortName="plabel" style="text-align:left"/> --%> 
							<%-- <display:column  title="项目阶段" sortable="false" sortName="pstage" style="text-align:left">
								<f:description nodeKey="PTYPE" itemValue="${tprojectItem.pstage}"></f:description>
							</display:column>  --%>
							<display:column title="审核状态" sortable="false" sortName="pcheckTimes" style="text-align:left">
							<c:choose>
							<c:when test="${empty tprojectItem.pcheckTime}">
								<span class="green">未审核</span>
						   	</c:when>
						   	<c:when test="${!empty tprojectItem.pcheckTime}">
						   	<span class="red">已审核</span>
						   	</c:when>
							</c:choose>
							</display:column> 
							<display:column property="auditName" title="审核人" sortable="false" sortName="auditName" style="text-align:left"/>
							<display:column property="auditTimestr" title="审核日期" sortable="false" sortName="auditTimestr" style="text-align:left"/>
							<%-- <display:column property="pisHaveOther" title="是否有其他项目" sortable="false" sortName="pisHaveOther" style="text-align:left"/> --%> 
							<%-- <display:column property="paddress" title="公司地址" sortable="false" sortName="paddress" style="text-align:left"/> 
							<display:column property="pdetail" title="企业项目简介" sortable="false" sortName="pdetail" style="text-align:left"/> --%> 
							<%-- <display:column property="pfinancingAmount" title="融资金额（万元）" sortable="false" sortName="pfinancingAmount" style="text-align:left"/> 
							<display:column property="pinvestAmount" title="认投金额（万元）" sortable="false" sortName="pinvestAmount" style="text-align:left"/>  --%>
							<%-- <display:column property="pcomplete" title="完成比例%" sortable="false" sortName="pcomplete" style="text-align:left"/> --%> 
							<%-- <display:column property="ppayWay" title="投资款拨付方式" sortable="false" sortName="ppayWay" style="text-align:left"/> --%> 
							<%-- <display:column property="pcompanyName" title="公司名称" sortable="false" sortName="pcompanyName" style="text-align:left"/> 
							<display:column property="psetup" title="公司是否成立" sortable="false" sortName="psetup" style="text-align:left"/> --%> 
							<%-- <display:column property="pviewCount" title="浏览次数" sortable="false" sortName="pviewCount" style="text-align:left"/> 
							<display:column property="pfavoritesCount" title="被收藏次数" sortable="false" sortName="pfavoritesCount" style="text-align:left"/> 
							<display:column property="pinvestCount" title="跟投人数" sortable="false" sortName="pinvestCount" style="text-align:left"/> 
							<display:column property="paskPriceCount" title="询价人数" sortable="false" sortName="paskPriceCount" style="text-align:left"/>  --%>
							<%-- <display:column property="ppic" title="项目图片" sortable="false" sortName="ppic" style="text-align:left"/> 
							<display:column property="pvideo" title="项目视频" sortable="false" sortName="pvideo" style="text-align:left"/> --%> 
							<%-- <display:column property="popenDate" title="开标日期" sortable="false" sortName="popenDate" style="text-align:left"/> 
							<display:column property="pcloseDate" title="结束日期" sortable="false" sortName="pcloseDate" style="text-align:left"/> --%> 
							<%-- <display:column property="pisRecommended" title="是否推荐项目" sortable="false" sortName="pisRecommended" style="text-align:left"/> --%> 
							<%-- <display:column property="popenDays" title="开标天数" sortable="false" sortName="popenDays" style="text-align:left"/> --%>
							
							<%-- <display:column property="isDel" title="是否删除" sortable="false" sortName="isDel" style="text-align:left"/> --%> 
							<%-- <display:column property="pisFull" title="是否满标" sortable="false" sortName="pisFull" style="text-align:left"/> --%> 
							<%-- <display:column property="pfullTime" title="满标日期" sortable="false" sortName="pfullTime" style="text-align:left"/> --%> 
							 
							<%-- <display:column property="pisPay" title="是否放款" sortable="false" sortName="pisPay" style="text-align:left"/> 
							<display:column property="ppayTime" title="放款日期" sortable="false" sortName="ppayTime" style="text-align:left"/> 
							<display:column property="pdealRate" title="交易费比例" sortable="false" sortName="pdealRate" style="text-align:left"/> 
							<display:column property="pdealFees" title="交易费（元）" sortable="false" sortName="pdealFees" style="text-align:left"/> 
							<display:column property="pfinalGetPay" title="贷款人最后取得金额（扣除各种费用后）（元）" sortable="false" sortName="pfinalGetPay" style="text-align:left"/> 
							 --%><%-- <display:column property="pisBreak" title="是否流标" sortable="false" sortName="pisBreak" style="text-align:left"/> 
							<display:column property="pbreakTime" title="流标日期" sortable="false" sortName="pbreakTime" style="text-align:left"/> 
							<display:column property="pbreakRemark" title="流标说明" sortable="false" sortName="pbreakRemark" style="text-align:left"/> --%> 
							<display:column title="操作"  media="html"  class="rowOps">
								${tprojectItem.linkedAction }&nbsp;&nbsp;&nbsp;&nbsp;
								<a href='edit.ht?projectId=${tprojectItem.projectId}' class="link edit">项目明细</a>	
								<%--<a href='javascript:void(0)' onclick="updatevaluetionFinal('${tprojectItem.projectId}')" class="link edit">重新估价</a>	--%>
								
								<%-- <a href='del.ht?projectId=${tprojectItem.projectId}'  class='link del'>删除</a> --%>														
							</display:column>
						</display:table>
						<deelon:paging tableId="projectId"/>
					</div>
				</div>			
	</div>
</body>
</html>
<script type="text/javascript">
$(function(){
/*    $("#pstatus").val("1"); */
});
</script>
