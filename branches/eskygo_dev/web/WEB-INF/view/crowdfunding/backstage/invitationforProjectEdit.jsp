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

.inputText1{
border: 1px solid #adadad;
padding: 2px;
width: 180px;
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
									<input readonly="readonly"  readonly="readonly" type="text" id="pname" name="pname" value="${tcproject.pname}" class="inputText1" />
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
								<th width="25%">创建时间:</th>	
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
							 
							<tr>
								<th width="25%">项目所属行业:</th>	
								<td>										 
									<f:select disabled="true" styleClass="inputText" nodeKey="PIND" id="pindustry" idName="pindustry" defaultValue="${tcproject.pindustry}" showBlankOnTop="true" ></f:select>
								</td>
								<th width="25%">企业所在城市:</th>	
								<td>										 
									<input readonly="readonly"  readonly="readonly" type="text" id="pcityId" name="pcityId" value="${tcproject.pcityIname}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">企业所在省份:</th>	
								<td>										 
								<input readonly="readonly"  readonly="readonly"  readonly="readonly"   type="text" id="pprovincesId" name="pprovincesId" value="${tcproject.pprovincesName}" class="inputText" />
								</td>
								<th width="25%">企业成立时间:</th>	
								<td>										 
									<input readonly="readonly"  readonly="readonly"  type="text" id="pfoundedYear" name="pfoundedYear" value="${tcproject.pfoundedYear}-${tcproject.pfoundedMonth}" class="inputText" />
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
									<f:select disabled="true" nodeKey="PTYPE" id="${tcproject.pstage}"></f:select>
								</td>
								<th width="25%">是否有其他项目:</th>	
								<td>										 
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
								<th width="25%">公司名称:</th>	
								<td>										 
									<input readonly="readonly"  readonly="readonly"  type="text" id="pcompanyName" name="pcompanyName" value="${tcproject.pcompanyName}" class="inputText1" />
								</td>
								<th width="25%">公司地址:</th>	
								<td>	
								    <textarea rows="2" cols="1" readonly="readonly" id="paddress" name="paddress" class="inputText1">${tcproject.paddress}</textarea>									 
									<%-- <input readonly="readonly"  readonly="readonly"  type="text" id="paddress" name="paddress" value="${tcproject.paddress}" class="inputText1" /> --%>
								</td>
							</tr>
							<tr>
								<th width="25%">企业项目简介:</th>	
								<td>	
								    <textarea rows="2" cols="1" readonly="readonly" id="pdetail" name="pdetail" class=""inputText1>${tcproject.pdetail}</textarea>									 
									<%-- <input readonly="readonly"  readonly="readonly"  type="text" id="pdetail" name="pdetail" value="${tcproject.pdetail}" class="inputText1" /> --%>
								</td>
								<th width="25%">融资金额（万元）:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pfinancingAmount" name="pfinancingAmount" value="<fmt:formatNumber value="${tcproject.pfinancingAmount/10000 }" pattern="###,###.##"  minFractionDigits="0" /> " class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">认投金额（万元）:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pinvestAmount" name="pinvestAmount" value="<fmt:formatNumber value="${tcproject.pinvestAmount/10000 }" pattern="###,###.##"  minFractionDigits="0" />" class="inputText" />
								</td>
								<th width="25%">完成比例%:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pcomplete" name="pcomplete" value="${tcproject.pcomplete}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">投资款拨付方式:</th>	
								<td>										 
									<f:select disabled="true" nodeKey="TZKPT" id="ppayWay" defaultValue="${tcproject.ppayWay}" ></f:select>
								</td>
								<th width="25%">公司是否成立:</th>	
								<td>										 
									<f:select disabled="true" nodeKey="sf" id="ppayWay" defaultValue="${tcproject.psetup}" />
								</td>
							</tr>
							 <tr>
								<th width="25%">浏览次数:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pviewCount" name="pviewCount" value="${tcproject.pviewCount}" class="inputText" />
								</td>
								<th width="25%">被收藏次数:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pfavoritesCount" name="pfavoritesCount" value="${tcproject.pfavoritesCount}" class="inputText" />
								</td>
							</tr> 
							 <tr>
								<th width="25%">跟投人数:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pinvestCount" name="pinvestCount" value="${tcproject.pinvestCount}" class="inputText" />
								</td>
								<th width="25%">询价人数:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="paskPriceCount" name="paskPriceCount" value="${tcproject.paskPriceCount}" class="inputText" />
								</td>
							</tr>
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
								<th width="25%">开标时间:</th>	
								<td>										 
									<input  disabled="disabled" type="text"  name="popenDate" value="<fmt:formatDate value='${tcproject.popenDate}' />" class="inputText date" style="width:110px;"/>
								</td>
								<th width="25%">结束时间:</th>	
								<td>										 
									<input disabled="disabled"  type="text" name="pcloseDate" value="<fmt:formatDate value='${tcproject.pcloseDate}' />" class="inputText date" style="width:110px;"/>
								</td>
							</tr>
							<tr>
								<th width="25%">是否推荐项目:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pisRecommended" name="pisRecommended" value="${tcproject.pisRecommended}" class="inputText" />
								</td>
								<th width="25%">开标天数:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="popenDays" name="popenDays" value="${tcproject.popenDays}" class="inputText" />天
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
								<th width="25%">满标时间:</th>	
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
								<th width="25%">审核时间:</th>	
								<td>										 
									<input readonly="readonly"  type="text" name="pcheckTime" value="<fmt:formatDate value='${tcproject.pcheckTime}' />" class="inputText date" style="width:110px;"/>
								</td>
							</tr> --%>
							<%-- <tr>
								<th width="25%">是否放款:</th>	
								<td>										 
									<input readonly="readonly"  type="text" id="pisPay" name="pisPay" value="${tcproject.pisPay}" class="inputText" />
								</td>
								<th width="25%">放款时间:</th>	
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
								<th width="25%">流标时间:</th>	
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
	           <div title="项目投资人" tabid="userdetail1" icon="${ctx}/styles/default/images/resicon/user.gif">
					<!-- <table width="100%" class="table-detail" border="0" cellspacing="0" cellpadding="0" class="tab2"> -->
					<table width="100%" class="table-detail2" border="0" cellspacing="0" cellpadding="0" style="width: 100%;">
                  <tbody>
                  <tr class="col">
                    <th>姓名</th>
                    <th>是否领投人</th>
                    <th>投资类型</th>
                    <th>认投金额(万元人民币)</th>
                    <th>认投时间</th>
                    <th>认投理由</th>
                    <th>审核状态</th>
                    <th>拒绝理由</th>
                  </tr>
                  
                  <c:forEach items="${listI }" var="vo">
                   <tr>
                    <td>${vo.realName }</td>
                    <td>
                   
                    <c:choose>
                    	<c:when test="${vo.piisLeader eq '1' }">是</c:when>
                    	<c:otherwise>否</c:otherwise>
                    </c:choose>
                    </td>
                    <td>
                      <c:choose>
                    	<c:when test="${vo.pitypeId eq '1' }">领投全部</c:when>
                    	<c:when test="${vo.pitypeId eq '2' }">领投部分</c:when>
                    	<c:when test="${vo.pitypeId eq '3' }">跟投</c:when>
                    </c:choose>
                    </td>
                    <td><fmt:formatNumber value="${vo.piinvest/10000 }" pattern="###,###.##"  minFractionDigits="0" /></td>
                    <td>${vo.piinvestTimeS }</td>
                    <td>${vo.pireasons }</td>
                    <td> <c:choose>
                    	<c:when test="${vo.piisCheck eq '0' }">未审核</c:when>
                    	<c:when test="${vo.piisCheck eq '2' }">拒绝</c:when>
                    	<c:when test="${vo.piisCheck eq '1' }">通过</c:when>
                    </c:choose></td>
                    <td>${vo.pidenyReason }</td>
                   </tr>
                  </c:forEach>
                 
                         </tbody>
                     </table>

	           </div>
	          <%--  <div title="项目评论" tabid="orgdetail" icon="${ctx}/styles/default/images/icon/home.png">		         	         
		         <table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="25%">项目:</th>	
								<td>										 
									<input type="text" id="projectId" name="projectId" value="${tcprojectComments.pname}" class="inputText" />
								</td>
								<th width="25%">讨论内容:</th>	
								<td>										 
									<input type="text" id="pccontent" name="pccontent" value="${tcprojectComments.pccontent}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">回复人:</th>	
								<td>										 
									<input type="text" id="pcreply" name="pcreply" value="${tcprojectComments.pcreply}" class="inputText" />
								</td>
								<th width="25%">回复内容:</th>	
								<td>										 
									<input type="text" id="pcreplyContent" name="pcreplyContent" value="${tcprojectComments.pcreplyContent}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">回复时间:</th>	
								<td>										 
									<input type="text" name="pcreplyTime" value="<fmt:formatDate value='${tcprojectComments.pcreplyTime}' />" class="inputText date" style="width:9%"/>
								</td>
								<th width="25%">留言人:</th>	
								<td>										 
									<input type="text" id="creator" name="creator" value="${tcprojectComments.creator}" class="inputText" />
								</td>
							</tr>
							<tr>
								<th width="25%">留言时间:</th>	
								<td>										 
									<input type="text" name="creteTime" value="<fmt:formatDate value='${tcprojectComments.creteTime}' />" class="inputText date" style="width:9%"/>
								</td>
							</tr>
					</table>
					
	       		</div> --%>
	        
	         
						 					
	      </div>      
	  </form>
</div>
</body>
</html>
