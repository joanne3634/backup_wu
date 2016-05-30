<%--
	time:2011-11-28 10:17:09
	desc:edit the 用户表
--%>
<%@page language="java" pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title> 项目方资料</title>
	<%@include file="/commons/include/form.jsp" %>
	<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/public.css">
	<f:link href="tree/zTreeStyle.css"></f:link>
	<script type="text/javascript" src="${ctx}/js/tree/jquery.ztree.js"></script>
	<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerTab.js" ></script>
	<script type="text/javascript" src="${ctx}/js/deelon/displaytag.js" ></script>
	<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerWindow.js" ></script>
   <script type="text/javascript"  src="${ctx}/js/deelon/platform/system/SysDialog.js"></script>
   <script type="text/javascript" src="${ctx}/js/deelon/platform/system/FlexUploadDialog.js"></script>
	<script type="text/javascript">
	 $(function () { 
			    	h=$('body').height();
			    	$("#tabMyInfo").ligerTab({         	
			            	//height:h-80
			          });
	 });	    	
			    	
	</script>
<style type="text/css">
	html{height:100%}
	body {overflow:auto;}
div.panel-body {
    margin: 0px;
}
.inputText{
	width: 150px !important;
}
.table-detail2 th {
	background-color: #ebebeb;
	border-bottom: 1px solid #cacaca;
	border-right: 1px solid #cacaca;
	font-size: 12px;
	height: 32px;
	padding-right: 6px;
	text-align: left;
}
.table-detail2 td {
	border-bottom: 1px solid #cacaca;
	border-right: 1px solid #cacaca;
	font-size: 12px;
	padding-left: 6px;
	text-align: left;
}
</style>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				  项目方资料
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<!-- <div class="group"><a class="link save" id="dataFormSave" href="#"><span></span>保存</a></div> -->
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht"><span></span>返回</a></div>
				</div>
			</div>
		</div>
	   <form id="sysUserForm" method="post" action="save.ht">
						
            <div  id="tabMyInfo" class="panel-nav" style="overflow:hidden; position:relative;">  
	           <div title="项目详情" tabid="userdetail" icon="${ctx}/styles/default/images/resicon/user.gif">
			         <table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="25%">项目名称:</th>	
								<td>										 
									<input readonly="readonly"  readonly="readonly" type="text" id="pname" name="pname" value="${tcproject.pname}" class="inputText" />
								</td>
								<th width="25%">项目状态:</th>	
								<td>	
								<f:select styleClass="inputText" disabled="true" nodeKey="xmzt" id="pstateId" idName="pstateId" defaultValue="${tcproject.pstateId}" showBlankOnTop="true" ></f:select>									 
									
									
								</td>
							</tr>
							<tr>
								<th width="25%">创建人:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="realName" name="realName" value="${tcproject.realName}" class="inputText" />
								</td>
								<th width="25%">创建日期:</th>	
								<td>										 
									<input disabled="disabled"  type="text" name="createTime" value="<fmt:formatDate value='${tcproject.createTime}' />" class="inputText date" style="width:110px;"/>
								</td>
							</tr>
							<tr>
								<%-- <th width="25%">项目星期资料查看权限:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pviewLimit" name="pviewLimit" value="${tcproject.pviewLimit}" class="inputText" />
								</td> --%>
								<th width="25%">项目类别</th>	
								<td>										 
									
									<f:select disabled="true" styleClass="inputText" nodeKey="XMLX" id="ptypeId" idName="ptypeId" defaultValue="${tcproject.ptypeId}" showBlankOnTop="true" ></f:select>
								</td>
								<th width="25%">项目标签:</th>	
								<td>										 
									<input readonly="readonly"  readonly="readonly"  type="text" id="plabel" name="plabel" value="${tcproject.plabel}" class="inputText" />
								</td>
							</tr>
							
							<%-- <tr>
								<th width="25%">企业成立月份:</th>	
								<td>										 
									<input readonly="readonly"  readonly="readonly"  type="text" id="pfoundedMonth" name="pfoundedMonth" value="${tcproject.pfoundedMonth}" class="inputText" />
								</td>
								
							</tr> --%>
							<tr>
								<th width="25%">项目所属阶段:</th>	
								<td>										 
									<%-- <input readonly="readonly"  readonly="readonly"  type="text" id="pstage" name="pstage" value="${tcproject.pstage}" class="inputText" /> --%>
									<f:select disabled="true" nodeKey="PTYPE" id="${tcproject.pstage}"></f:select>
								</td>
								<th width="25%">是否有其他项目:</th>	
								<td>										 
									<%-- <input readonly="readonly"  readonly="readonly"  type="text" id="pisHaveOther" name="pisHaveOther" value="${tcproject.pisHaveOther}" class="inputText" /> --%>
									<c:choose>
										<c:when test="${tcproject.pisHaveOther eq '0'}">
											<input readonly="readonly"  type="text" id="pisHaveOther" name="pisHaveOther" value="否" class="inputText" />
										</c:when>
										<c:when test="${tcproject.pisHaveOther eq '1'}">
											<input readonly="readonly"  type="text" id="pisHaveOther" name="pisHaveOther" value="是" class="inputText" />
										</c:when>
									</c:choose>
								</td>
							</tr>
							
							<tr>
								<th width="25%">项目所属行业:</th>	
								<td>										 
									<f:select disabled="true" styleClass="inputText" nodeKey="PIND" id="pindustry" idName="pindustry" defaultValue="${tcproject.pindustry}" showBlankOnTop="true" ></f:select>
								</td>
								<th width="25%">融资金额（万元）:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pfinancingAmount" name="pfinancingAmount" value="<fmt:formatNumber value="${tcproject.pfinancingAmount/10000 }" pattern="###,###.##"  minFractionDigits="0"  ></fmt:formatNumber>" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">认投金额（万元）:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pinvestAmount" name="pinvestAmount" value="<fmt:formatNumber value="${tcproject.pinvestAmount/10000 }" pattern="###,###.##"  minFractionDigits="0"  ></fmt:formatNumber>" class="inputText" />
								</td>
								<th width="25%">完成比例%:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pcomplete" name="pcomplete" value="${tcproject.pcomplete}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">投资款拨付方式:</th>	
								<td>										 
									<%-- <input readonly="readonly"  type="text" id="ppayWay" name="ppayWay" value="${tcproject.ppayWay}" class="inputText" /> --%>
									<f:select disabled="true" nodeKey="TZKPT" id="ppayWay" defaultValue="${tcproject.ppayWay}" ></f:select>
								</td>
								<th width="25%">公司是否成立:</th>	
								<td>										 
									<%-- <input readonly="readonly"  type="text" id="psetup" name="psetup" value="${tcproject.psetup}" class="inputText" /> --%>
									<c:choose>
										<c:when test="${tcproject.psetup eq '0'}">
											<input readonly="readonly"  type="text" id="psetup" name="psetup" value="否" class="inputText" />
										</c:when>
										<c:when test="${tcproject.psetup eq '1'}">
											<input readonly="readonly"  type="text" id="psetup" name="psetup" value="是" class="inputText" />
										</c:when>
									</c:choose>
								</td>
							</tr>
							<%-- <tr>
								<th width="25%">浏览次数:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pviewCount" name="pviewCount" value="${tcproject.pviewCount}" class="inputText" />
								</td>
								<th width="25%">被收藏次数:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pfavoritesCount" name="pfavoritesCount" value="${tcproject.pfavoritesCount}" class="inputText" />
								</td>
							</tr> --%>
							<%-- <tr>
								<th width="25%">跟投人数:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pinvestCount" name="pinvestCount" value="${tcproject.pinvestCount}" class="inputText" />
								</td>
								<th width="25%">询价人数:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="paskPriceCount" name="paskPriceCount" value="${tcproject.paskPriceCount}" class="inputText" />
								</td>
							</tr> --%>
							<%-- <tr>
								<th width="25%">项目图片:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="ppic" name="ppic" value="${tcproject.ppic}" class="inputText" />
								</td>
								<th width="25%">项目视频:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pvideo" name="pvideo" value="${tcproject.pvideo}" class="inputText" />
								</td>
							</tr> --%>
							<tr>
								<th width="25%">开标日期:</th>	
								<td>										 
									<input  disabled="disabled" type="text"  name="popenDate" value="<fmt:formatDate value='${tcproject.popenDate}' />" class="inputText date" style="width:110px;"/>
								</td>
								<th width="25%">结束日期:</th>	
								<td>										 
									<input disabled="disabled"  type="text" name="pcloseDate" value="<fmt:formatDate value='${tcproject.pcloseDate}' />" class="inputText date" style="width:110px;"/>
								</td>
							</tr>
							<tr>
								<th width="25%">是否推荐项目:</th>	
								<td>										 
									
									<c:choose>
										<c:when test="${tcproject.pisRecommended eq '0'}">
											<input readonly="readonly"  type="text" id="pisRecommended" name="pisRecommended" value="否" class="inputText" />
										</c:when>
										<c:when test="${tcproject.pisRecommended eq '1'}">
											<input readonly="readonly"  type="text" id="pisRecommended" name="pisRecommended" value="是" class="inputText" />
										</c:when>
									</c:choose>
								</td>
								<th width="25%">开标天数:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="popenDays" name="popenDays" value="${tcproject.popenDays}" class="inputText" />天
								</td>
							</tr>
							<tr>
								<th width="25%">公司名称:</th>	
								<td>										 
									<input readonly="readonly"  readonly="readonly"  type="text" id="pcompanyName" name="pcompanyName" value="${tcproject.pcompanyName}" class="inputText" />
								</td>
								<th width="25%">公司地址:</th>	
								<td>										 
									<input readonly="readonly"  readonly="readonly"  type="text" id="paddress" name="paddress" value="${tcproject.paddress}" class="inputText" />
								</td>
							</tr>
							<tr>
								
								<th width="25%">企业所在省份:</th>	
								<td>										 
								<input readonly="readonly"    readonly="readonly"   type="text" id="pprovincesName" name="pprovincesName" value="${tcproject.pprovincesName}" class="inputText" />
								</td>
								<th width="25%">企业所在城市:</th>	
								<td>										 
									<input readonly="readonly"   type="text" id="pcityIname" name="pcityIname" value="${tcproject.pcityIname}" class="inputText" />
								</td>
							</tr>
							<tr>
								
								<th width="25%">企业项目简介:</th>	
								<td>										 
									<input readonly="readonly"  readonly="readonly"  type="text" id="pdetail" name="pdetail" value="${tcproject.pdetail}" class="inputText" />
								</td>
								
								<th width="25%">企业成立时间:</th>	
								<td>										 
									<input readonly="readonly"  readonly="readonly"  type="text" id="pfoundedYear" name="pfoundedYear" value="${tcproject.pfoundedYear}-${tcproject.pfoundedMonth}" class="inputText" />
								</td>
							</tr>
							
							<%-- <tr>
								<th width="25%">是否删除:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="isDel" name="isDel" value="${tcproject.isDel}" class="inputText" />
								</td>
								<th width="25%">是否满标:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pisFull" name="pisFull" value="${tcproject.pisFull}" class="inputText" />
								</td>
							</tr> --%>
							<%-- <tr>
								<th width="25%">满标日期:</th>	
								<td>										 
									<input readonly="readonly"  type="text" name="pfullTime" value="<fmt:formatDate value='${tcproject.pfullTime}' />" class="inputText date" style="width:110px;"/>
								</td>
								<th width="25%">审核是否通过（平台）:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pisCheck" name="pisCheck" 
									<c:if test="${tcproject.pisCheck eq '1'}">value="通过"</c:if> 
									<c:if test="${tcproject.pisCheck eq '0'}">value="未通过"</c:if> 
									class="inputText" />
								</td>
							</tr> --%>
							<%-- <tr>
								<th width="25%">审核人:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pchecker" name="pchecker" value="${tcproject.pchecker}" class="inputText" />
								</td>
								<th width="25%">审核日期:</th>	
								<td>										 
									<input readonly="readonly"  type="text" name="pcheckTime" value="<fmt:formatDate value='${tcproject.pcheckTime}' />" class="inputText date" style="width:110px;"/>
								</td>
							</tr> --%>
							<%-- <tr>
								<th width="25%">是否放款:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pisPay" name="pisPay" value="${tcproject.pisPay}" class="inputText" />
								</td>
								<th width="25%">放款日期:</th>	
								<td>										 
									<input readonly="readonly"  type="text" name="ppayTime" value="<fmt:formatDate value='${tcproject.ppayTime}' />" class="inputText date" style="width:9%"/>
								</td>
							</tr> --%>
							<%-- <tr>
								<th width="25%">交易费比例:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pdealRate" name="pdealRate" value="${tcproject.pdealRate}" class="inputText" />
								</td>
								<th width="25%">交易费（元）:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pdealFees" name="pdealFees" value="${tcproject.pdealFees}" class="inputText" />
								</td>
							</tr> --%>
							<%-- <tr>
								<th width="25%">贷款人最后取得金额（扣除各种费用后）（元）:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pfinalGetPay" name="pfinalGetPay" value="${tcproject.pfinalGetPay}" class="inputText" />
								</td>
								<th width="25%">是否流标:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pisBreak" name="pisBreak" value="${tcproject.pisBreak}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">流标日期:</th>	
								<td>										 
									<input readonly="readonly"  type="text" name="pbreakTime" value="<fmt:formatDate value='${tcproject.pbreakTime}' />" class="inputText date" style="width:9%"/>
								</td>
								<th width="25%">流标说明:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pbreakRemark" name="pbreakRemark" value="${tcproject.pbreakRemark}" class="inputText" />
								</td>
							</tr> --%>
					</table>
					<input   type="hidden" name="projectId" value="${tcproject.projectId}" />
			           		
					
	           </div>
	          <%--  <div title="商业模式" tabid="orgdetail" icon="${ctx}/styles/default/images/icon/home.png">		         	         
		         <table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="25%">项目ID:</th>	
								<td>										 
									<input type="text" id="projectId" name="projectId" value="${tcprojectModel.projectId}" class="inputText" />
									
									<textarea rows="6" cols="20">${tcprojectModel.projectId}</textarea>
								</td>
								
							</tr>
							<tr>
								<th width="25%">目标用户或客户群体定位:</th>	
								<td>										 
									<input type="text" id="pmtargeted" name="pmtargeted" value="${tcprojectModel.pmtargeted}" class="inputText" />
									<textarea rows="6" cols="20">${tcprojectModel.pmtargeted}</textarea>
								</td>
							</tr>
							<tr>
								<th width="25%">目标用户或客户群体目前困扰或需求定位:</th>	
								<td>										 
									<input type="text" id="pmcurrentlyPlaguing" name="pmcurrentlyPlaguing" value="${tcprojectModel.pmcurrentlyPlaguing}" class="inputText" />
									<textarea rows="6" cols="20">${tcprojectModel.pmcurrentlyPlaguing}</textarea>
								</td>
								
							</tr>
							<tr>
								
								<th width="25%">满足目标用户或客户需求的产品或服务模式说明:</th>	
								<td>										 
									<input type="text" id="pmservicesMode" name="pmservicesMode" value="${tcprojectModel.pmservicesMode}" class="inputText" />
									<label>${tcprojectModel.pmservicesMode}</label>
									<textarea rows="6" cols="20">${tcprojectModel.pmservicesMode}</textarea>
								</td>
							</tr>
							<tr>
								<th width="25%">项目赢利模式说明:</th>	
								<td>										 
									<input type="text" id="pmprofitableDesc" name="pmprofitableDesc" value="${tcprojectModel.pmprofitableDesc}" class="inputText" />
								</td>
								<th width="25%">市场主要同行或竞争对手概述:</th>	
								<td>										 
									<input type="text" id="pmcompetitors" name="pmcompetitors" value="${tcprojectModel.pmcompetitors}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">项目赢利模式说明:</th>	
								<td>										 
									<input type="text" id="pmprofitableDesc" name="pmprofitableDesc" value="${tcprojectModel.pmprofitableDesc}" class="inputText" />
								</td>
								<th width="25%">市场主要同行或竞争对手概述:</th>	
								<td>										 
									<input type="text" id="pmcompetitors" name="pmcompetitors" value="${tcprojectModel.pmcompetitors}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">项目主要核心竞争力说明:</th>	
								<td>										 
									<input type="text" id="pmcoreCompetitiveness" name="pmcoreCompetitiveness" value="${tcprojectModel.pmcoreCompetitiveness}" class="inputText" />
								</td>
							</tr>
					</table>
					
	        </div> --%>
	        <div title="创业团队" tabid="posdetail" icon="${ctx}/styles/default/images/nav-sales.png">
	        	<c:if test="${empty listT }">
									<div  class="hint">暂无内容!</div>
								</c:if>
	        	<c:forEach items="${listT }" var="vo">
	        		<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td rowspan="9" align="center" width="26%">
									<!-- <div style="float:top !important;background: none;height: 24px;padding:0px 6px 0px 112px;">
										<a class="link uploadPhoto" href="#" onclick="addPic();">上传照片</a>
										<a class="link del" href="#" onclick="delPic();">删除照片</a>
									</div> -->
									<div class="person_pic_div">
										<p><img id="personPic" src="${ctx}/commons/image/default_image_male.jpg"  alt="个人相片" /></p>
									</div>
									</td>
									<%-- <th width="18%">项目名称: <span class="required">*</span></th>
									<td ><input type="text" id="account" name="account" value="${vo.account}" style="width:240px !important" class="inputText"/></td> --%>
								</tr>						
																				
								
								
								<tr>
								    <th width="15%">姓名: </th>
									<td ><input type="text" id="ptname" name="ptname" value="${vo.ptname}" style="width:240px !important" class="inputText"/></td>
								</tr>
								<tr>
									<th width="15%">类型: </th>
									<td>
									
									<c:if test="${vo.pttypeId==1}">
									<input type="text" id="pttypeId" name="pttypeId" value="股东团队成员" style="width:240px !important" class="inputText"/>
									</c:if>	
									<c:if test="${vo.pttypeId==0}">
									<input type="text" id="pttypeId" name="pttypeId" value="非股东团队成员" style="width:240px !important" class="inputText"/>
									</c:if>						
									</td>
								</tr>						
								<tr>
									<th width="15%">职务: </th>
									<td >								
										<input type="text" id="ptduty" name="ptduty" value="${vo.ptduty}" style="width:240px !important" class="inputText"/>	
									</td>				  
								</tr>
								
								<tr>
								    <th width="15%">是否全职: </th>
									<td >
										<c:if test="${vo.ptmisFullTime==1}">
									<input type="text" id="ptmisFullTime" name="ptmisFullTime" value="全职" style="width:240px !important" class="inputText"/>
									</c:if>	
									<c:if test="${vo.ptmisFullTime==0}">
									<input type="text" id="ptmisFullTime" name="ptmisFullTime" value="非全职" style="width:240px !important" class="inputText"/>
									</c:if>	
									</td>
								</tr>
								
								<tr>
									<th width="15%">所占股份: </th>
									<td >								
										<input type="text" id="pttheShare" name="pttheShare" value="${vo.pttheShare}" style="width:240px !important" class="inputText"/>%	
									</td>				  
								</tr>
								
													
								<tr>
								   <th width="15%">实际出资金额: </th>
								   <td ><input type="text" id="ptrealPay" name="ptrealPay" value="${vo.ptrealPay}" style="width:240px !important" class="inputText"/></td>
								</tr>
								
								<tr>
									<th width="15%">关系描述: </th>
									<td >
									<%-- <input type="text" id="ptrelationship" name="ptrelationship" value="${vo.ptrelationship}" style="width:240px !important" class="inputText"/> --%>
									<textarea rows="5" style="width: 240px;"  >${vo.ptrelationship}</textarea>
									</td>						   
								</tr>
								
								<tr>
								    <th width="15%">成员简介: </th>
									<td >
									 ${vo.ptmemberInfo} 
									</td>
								</tr>
														
							</table><br>
	        	</c:forEach>
	        	
			         
				 
	         </div>
	         <div  title="历史情况" tabid="roldetail1" icon="${ctx}/styles/default/images/resicon/customer.png">
	         <c:if test="${empty listH }">
									<div  class="hint">暂无内容!</div>
								</c:if>
	         <c:forEach items="${listH }" var="tcprojectHistoryplan">
	         	<c:if test="${tcprojectHistoryplan.isDel==0 and tcprojectHistoryplan.phptypeId==1 }"></c:if>
		       <table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="25%">阶段名称:</th>	
								<td>										 
									<input type="text" id="phpname" name="phpname" value="${tcprojectHistoryplan.phpname}" class="inputText" />
								</td>
								<th width="25%">起止时间（年-月）:</th>	
								<td>										 
									<input type="text" id="phpstartYear" name="phpstartYear" value="${tcprojectHistoryplan.phpstartYear}-${tcprojectHistoryplan.phpstartMonth}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">结束时间（年-月）:</th>	
								<td>										 
									<input type="text" id="phpendYear" name="phpendYear" value="${tcprojectHistoryplan.phpendYear}-${tcprojectHistoryplan.phpendMonth}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">阶段达成目标描述:</th>	
								<td colspan="3">										 
									 ${tcprojectHistoryplan.phptargetDesc} 
								</td>
							</tr>
							<tr>
								<th width="25%">完成阶段目标的主要措施、方法、手段:</th>	
								<td colspan="3">										 
									 ${tcprojectHistoryplan.phptargetWay} 
								</td>
								 
							</tr>
							 
					</table>
					</c:forEach>
			</div>	
			<%-- <div  title="未来计划" tabid="roldetail2" icon="${ctx}/styles/default/images/resicon/customer.png">
		       
			</div> --%>
			<div  title="项目附件" tabid="roldetail3" icon="${ctx}/styles/default/images/resicon/customer.png">
		       <table class="table-detail" cellpadding="0" cellspacing="0" border="0" style="width: 100%;">
								<tr>
									<td>
									 <div class="xiangqing-ite-tie">上传的材料</div>
						        <ul class="xiangqing-ite-tab">
							         <!--  <li class="shenhexiangmu th tab-top-left-radius bg-color-l">审核项目</li>
							          <li class="zhuangtai th bg-color-l">状态</li>
							          <li class="tongguoriqi th tab-top-right-radius bg-color-l">通过日期</li> -->
							          <c:forEach items="${listA }" var="vo">
							          		<li class="shenhexiangmu e1e4e9">
							          		<a href="${ctx}/crowdfunding/front/downloadFile.ht?fileId=${vo.attachmentId}" target="_blank">
											${vo.pafileName}
											</a></li>
								        <%-- <li class="zhuangtai e1e4e9"><img src="${ctx}/images/shenhetongguotubiao.png" alt=""></li>
								        <li class="tongguoriqi e1e4e9">${vo.checkTimeS }</li> --%>
							          </c:forEach>
          
       
        							</ul>
									</td>
								</tr>
							</table>
			</div>
			 <div  title="审核材料" tabid="roldetail4" icon="${ctx}/styles/default/images/resicon/customer.png">
		       <table class="table-detail2" cellpadding="0" cellspacing="0" border="0" style="width: 100%;">
								<tr>
									<th style="align:left;">  审核项目</th>
							         <!--  <th align="left">是否必须</th> -->
							          <th align="left" >是否上传</th>
							          <th align="left" >是否通过审核</th>
							          <th align="left" >审核日期</th>
							          <th align="left" >未通过原因</th>
									</tr>
							          <c:forEach items="${listTM }" var="vo">
							          <tr>
							          	<td class="shenhexiangmu e1e4e9">${vo.name }</td>
								       <%--  <td class="zhuangtai e1e4e9">
								        <img src="${ctx}/images/shenhetongguotubiao.png" alt="">
								        <c:choose>
								        	<c:when test="${vo.isMust eq '1' }">必须上传</c:when>
								        	<c:otherwise>非必须上传</c:otherwise>
								        </c:choose>
								        </td> --%>
								        <td class="tongguoriqi e1e4e9">
								        <c:choose>
								        	<c:when test="${not empty vo.userId  }">已上传</c:when>
								        	<c:otherwise>待上传</c:otherwise>
								        </c:choose>
								        </td>
								         <td class="tongguoriqi e1e4e9">
								          <c:choose>
								        	<c:when test="${empty vo.isPass ||  vo.isPass eq '0' }">未通过</c:when>
								        	<c:otherwise>已通过</c:otherwise>
								        </c:choose>
								         </td>
								          <td class="tongguoriqi e1e4e9">${vo.auditDate }</td>
								          <td class="tongguoriqi e1e4e9">${vo.reasons }</td>
								         </tr>
							          </c:forEach>
          
							</table>
			</div>	 					
	      </div>      
	  </form>
</div>
</body>
</html>
