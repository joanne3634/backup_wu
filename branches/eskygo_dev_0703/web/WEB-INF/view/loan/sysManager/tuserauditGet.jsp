<%@page import="com.deelon.loan.model.sysManager.TuserAudit"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title><%=TuserAudit.TABLE_ALIAS%>明细</title>
<%@include file="/commons/include/get.jsp" %>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
<script type="text/javascript" src="${ctx}/js/deelon/editUserInfo.js"></script>
<style type="text/css">
      #sidebar {
        overflow: hidden;
      }
      #sidebar>ul>li {
        padding-left: 30px;
        margin-bottom: 1px;
        background-color: #fff9d9;
      }
      #sidebar>ul>li>a {
        display: block;
        margin-left: -30px;
        padding-left: 30px;
        cursor: pointer;
        line-height: 50px;
        color: #545454;
        font-size: 15px;
      }
      #sidebar>ul>li>a:hover {
        text-decoration: none;
        color: #fff;
      }
      .bariocn {
        position: relative;
        top: 4px;
        display: inline-block;
        width: 20px;
        height: 20px;
        margin-right: 6px;
        background-image: url(Skin/default/images/sidebar-icons.png);
        background-repeat: no-repeat;
      }
      .subsidebar {
        display: none;
        margin-left: -30px;
      }
      .subsidebar li {
        height: 36px;
        padding-left: 60px;
        background-color: #fff;
      }
      .subsidebar li a {
        display: block;
        margin-left: -30px;
        padding-left: 30px;
        line-height: 36px;
        font-size: 15px;
        color: #909090;
      }
      .subsidebar li a:hover {
        text-decoration: none;
        color: #fff;
        background-color: #fd8f59;
      }

      .con-tit {
        height: 46px;
        margin-bottom: 15px;
        padding-left: 15px;
        line-height: 46px;
        border: 1px solid #f9d785;
        font-size: 16px;
        background-color: #fffbe9;
        color: #ff5704;
      }
      .con-item {
        height: 52px;
        width: 187px;
        border-top: 1px solid #c8c8c8;
        border-left: 1px solid #c8c8c8;
        border-right: 1px solid #c8c8c8;
        line-height: 52px;
        text-align: center;
        font-size: 16px;
        background-color: #f5f5f5;
        cursor:pointer;
      }
      .con-on {
        height: 48px;
        padding-bottom: 2px;
        background-color: #fff;
        line-height: 48px;
        border-top: 1px solid #C3DBFF;
        border-bottom: 1px solid #fff;
        border-left: 1px solid #C3DBFF;
        border-right: 1px solid #C3DBFF;
      }
      .con-box {
        overflow: hidden;
        border-left: 1px solid #C3DBFF;
        border-bottom: 1px solid #C3DBFF;
        border-right: 1px solid #C3DBFF;
      }
      .con-box-items {
        overflow: hidden;
        padding-top: 10px;
      }
      .con-box-left {
        width: 90px;
        padding-left: 102px;
        padding-right: 30px;
        text-align: center;
        vertical-align: middle;
      }
      .con-box .sub-btn {
        height: 34px;
        margin-top: 40px;
        margin-bottom: 50px;
        padding-left: 25px;
        padding-right: 25px;
        line-height: 34px;
        border: none;
        border-radius: 5px;
        font-size: 15px;
        cursor: pointer;
        color: #555;
      }
</style>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label"><%=TuserAudit.TABLE_ALIAS%>明细</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link back" href="list.ht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
				<div style="overflow: hidden;">
					<span id="jibenxinxi" class="con-on gg1 con-item">我的基本信息</span>
					<span id="jiatingqingkuang" class="gg1 con-item">我的家庭情况</span>
					<span id="danweiqingkuang" class="gg1 con-item">我的单位情况</span>
					<span id="lianxifangshi" class="gg1 con-item">我的联系方式</span>
				</div>
				<form id="editBaseInfoForm" method="post" action="">
					<div class="con-box con-box-jibenxinxi" style="margin-bottom:330px;">
						<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>							
								<th width="25%">真实姓名:</th>	
								<td>${tUser.realName}</td>
								<th width="25%">性别:</th>	
								<td>
								<input class="radio-input" type="radio" name="gender"
										value="先生" checked> 先生<input class="radio-input"
										type="radio" name="gender" value="女士" <c:if test="${tUser.gender == '女士'}">checked</c:if>> 女士
								</td>
							</tr>
							<tr>
								<th width="25%">身份证号码:</th>	
								<td>${tuserSafe.idNo}</td>
								<th width="25%">手机号码:</th>	
								<td><input type="text" id="mobile" name="mobile" value="${tuserSafe.mobile}" class="inputText" /></td>
							</tr>
							<tr>
								<th width="25%">Q Q号码:</th>	
								<td><input type="text" id="gender" name="qqNo" value="${tuserSafe.qqNo}" class="inputText" /></td>
								<th width="25%">教育程度:</th>	
								<td>
								<f:select nodeKey="jycd" id="edu" showBlankOnTop="true" defaultValue="${tUser.edu}"></f:select>
								<%-- <select id="edu" name="edu">
									<option value="">请选择</option>
									<option value="研究生及以上" <c:if test="${tUser.edu == '研究生及以上'}">selected</c:if>>研究生及以上</option>
									<option value="本科" <c:if test="${tUser.edu == '本科'}">selected</c:if>>本科</option>
									<option value="大专" <c:if test="${tUser.edu == '大专'}">selected</c:if>>大专</option>
									<option value="专科" <c:if test="${tUser.edu == '专科'}">selected</c:if>>专科</option>
									<option value="高中" <c:if test="${tUser.edu == '高中'}">selected</c:if>>高中</option>
									<option value="中专" <c:if test="${tUser.edu == '中专'}">selected</c:if>>中专</option>
									<option value="初中及以下" <c:if test="${tUser.edu == '初中及以下'}">selected</c:if>>初中及以下</option>
								</select> --%>
								</td>
							</tr>
							<tr>
								<th width="25%">学校:</th>	
								<td><input type="text" id="school" name="school" value="${tUser.school}" class="inputText" /></td>
							</tr>
						</table>
						<input type="hidden" id="tuserID" name="tuserID" value="${tUser.userId}" />
						<%-- <input type="hidden" id="sysuserID" name="sysuserID" value="${sessionScope.user['userId']}" /> --%>
						<input type="hidden" id="baseFlag" name="baseFlag" value="" class="inputText" />
						<div style="text-align: center;">
							<c:if test="${safeFlag == '2' || safeFlag == '3' }">
								<input id="sub-btn-jibenxinxi_outpass" class="sub-btn" type="button"
									value="取消审核" onclick="editBaseInfo('outpass')">
							</c:if>
							<c:if test="${safeFlag == '0' || safeFlag == '1' || safeFlag == '' || safeFlag == null}">
								<input id="sub-btn-jibenxinxi_pass" class="sub-btn" type="button"
									value="审核通过" onclick="editBaseInfo('pass')">
								<input id="sub-btn-jibenxinxi_nopass" class="sub-btn" type="button"
									value="审核不通过" onclick="editBaseInfo('nopass')">
							</c:if>
							<input id="sub-btn-jibenxinxi_save" class="sub-btn" type="button"
								value="保存修改" onclick="editBaseInfo('save')">
						</div>
					</div>
				</form>
				<form id="editBaseFamilyForm" method="post" action="">
				<div class="con-box con-box-jiatingqingkuang" style="display: none;">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>							
							<th width="25%">婚姻状况:</th>	
							<td>
							<f:select nodeKey="hyzk" id="marriage" showBlankOnTop="true" defaultValue="${tuserFamily.FMarriage}"></f:select>
							
								<%-- <select id="marriage" name="marriage">
									<option value="">请选择</option>
									<option value="未婚" <c:if test="${tuserFamily.FMarriage == '未婚'}">selected</c:if>>未婚</option>
									<option value="已婚" <c:if test="${tuserFamily.FMarriage == '已婚'}">selected</c:if>>已婚</option>
									<option value="离婚" <c:if test="${tuserFamily.FMarriage == '离婚'}">selected</c:if>>离婚</option>
									<option value="丧偶" <c:if test="${tuserFamily.FMarriage == '丧偶'}">selected</c:if>>丧偶</option>
									<option value="其他" <c:if test="${tuserFamily.FMarriage == '其他'}">selected</c:if>>其他</option>
								</select> --%>
							</td>
							<th width="25%">住宅状况:</th>	
							<td>
							<f:select nodeKey="zjqk" id="area" showBlankOnTop="true" defaultValue="${tuserFamily.FAreaId}"></f:select>
								<%-- <select id="area" name="area">
									<option value="">请选择</option>
									<option value="自置无按揭" <c:if test="${tuserFamily.FHouse == '自置无按揭'}">selected</c:if>>自置无按揭</option>
									<option value="自置有按揭" <c:if test="${tuserFamily.FHouse == '自置有按揭'}">selected</c:if>>自置有按揭</option>
									<option value="商住两用" <c:if test="${tuserFamily.FHouse == '商住两用'}">selected</c:if>>商住两用</option>
									<option value="租用" <c:if test="${tuserFamily.FHouse == '租用'}">selected</c:if>>租用</option>
									<option value="与父母共住" <c:if test="${tuserFamily.FHouse == '与父母共住'}">selected</c:if>>与父母共住</option>
									<option value="集体宿舍" <c:if test="${tuserFamily.FHouse == '集体宿舍'}">selected</c:if>>集体宿舍</option>
									<option value="其他" <c:if test="${tuserFamily.FHouse == '其他'}">selected</c:if>>其他</option>
								</select> --%>
							</td>
						</tr>
						
						<tr>
							<th>住宅地区:</th>
							<td>
								<select id="FProvincesId" name="FProvincesId" style="width:100px;" >
			                    	<option value="">请选择省份</option>
			                    	<c:forEach items="${list }" var="list">
			                    		
			                    		<option value="${list.areaId }" <c:if test="${tuserFamily.FProvincesId == list.areaId }">selected</c:if>>${list.areaName }</option>				                    	
			                    	</c:forEach>
			                    </select>
			                    	
			                    <select id="FCityId" name="FCityId" style="width:100px;">
			                    	<option value="${tuserFamily.FCityId }"><h:getArea areaId="${tuserFamily.FCityId }"></h:getArea></option>
			                    </select>
			                    <select id="FAreaId" name="FAreaId" style="width:100px;">
			                    	<option value="${tuserFamily.FAreaId }"><h:getArea areaId="${tuserFamily.FAreaId }"></h:getArea></option>
			                    </select>
			                    <input type="hidden" name="location_id" />
							</td>
							<th width="25%">住宅地址:</th>	
							<td><input type="text" id="address" name="address" value="${tuserFamily.FAddress}" class="inputText" /></td>
							
						</tr>
						<tr>
							<th width="25%">住宅电话:</th>	
							<td><input type="text" id="phone" name="phone" value="${tuserFamily.FPhone}" class="inputText" /></td>
							<th width="25%">入住年数:</th>	
							<td>
							<f:select nodeKey="rzns" id="liveYears" showBlankOnTop="true" defaultValue="${tuserFamily.FLiveYears}"></f:select>
								<%-- <select id="liveYears" name="liveYears">
									<option value="">请选择</option>
									<option value="1" <c:if test="${tuserFamily.FLiveYears == '1'}">selected</c:if>>半年以内</option>
									<option value="2" <c:if test="${tuserFamily.FLiveYears == '2'}">selected</c:if>>1年以内</option>
									<option value="3" <c:if test="${tuserFamily.FLiveYears == '3'}">selected</c:if>>2年以内</option>
									<option value="4" <c:if test="${tuserFamily.FLiveYears == '4'}">selected</c:if>>3年以内</option>
									<option value="5" <c:if test="${tuserFamily.FLiveYears == '5'}">selected</c:if>>3年以上</option>
								</select> --%>
							</td>
							
						</tr>
						<tr>
							<th width="25%">是否有车贷:</th>	
							<td>
								<input class="radio-input" type="radio" id="fisCarLoan"
									name="fisCarLoan" value="1" checked> 是<input
									class="radio-input" type="radio" name="fisCarLoan" value="0" <c:if test="${tuserFamily.fisCarLoan == 0}">checked</c:if>>
								否
							</td>
							<th width="25%">是否有房贷:</th>	
							<td>
								<input class="radio-input" type="radio" id="fisHouseLoan"
									name="fisHouseLoan" value="1" checked> 是<input
									class="radio-input" type="radio" name="fisHouseLoan" value="0" <c:if test="${tuserFamily.fisHouseLoan == 0}">checked</c:if>>
								否
							</td>
						</tr>
						<tr>
							<th width="25%">是否购车:</th>	
							<td>
								<input class="radio-input" type="radio" id="isBuyCar"
									name="isBuyCar" value="1" checked> 是<input
									class="radio-input" type="radio" name="isBuyCar" value="0" <c:if test="${tuserFamily.FIsBuyCar == '0'}">checked</c:if>>
								否
							</td>
						</tr>
					</table>
					<input type="hidden" name="tuserID" value="${tUser.userId}" />
					<%-- <input type="hidden" id="sysuserID" name="sysuserID" value="${sessionScope.user['userId']}" /> --%>
					<input type="hidden" id="familyFlag" name="familyFlag" value="" class="inputText" />
					<div style="text-align: center;">
						<c:if test="${familyFlag == '2' || familyFlag == '3' }">
							<input id="sub-btn-jibenxinxi_outpass" class="sub-btn" type="button"
								value="取消审核" onclick="editFamilyInfo('outpass')">
						</c:if>
						<c:if test="${familyFlag == '0' || familyFlag == '1' || familyFlag == '' || familyFlag == null}">
							<input id="sub-btn-jiatingqingkuang_pass" class="sub-btn" type="button"
							value="审核通过" onclick="editFamilyInfo('pass')">
							<input id="sub-btn-jiatingqingkuang_nopass" class="sub-btn" type="button"
							value="审核不通过" onclick="editFamilyInfo('nopass')">
						</c:if>
						<input id="sub-btn-jiatingqingkuang_save" class="sub-btn" type="button"
							value="保存修改" onclick="editFamilyInfo('save')">
					</div>
				</div>
				</form>
				<form id="editBaseCompanyForm" method="post" action="">
				<div class="con-box con-box-danweiqingkuang" style="display: none;">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>							
							<th width="25%">就业状态:</th>	
							<td>
							<f:select nodeKey="jyzt" id="jobsStatus" showBlankOnTop="true" defaultValue="${tuserCompany.CJobsStatus}"></f:select>
								<%-- <select id="jobsStatus" name="jobsStatus">
									<option value="">请选择</option>
									<option value="1" <c:if test="${tuserCompany.CJobsStatus == '1'}">selected</c:if>>工薪族</option>
									<option value="2" <c:if test="${tuserCompany.CJobsStatus == '2'}">selected</c:if>>私营业主</option>
									<option value="3" <c:if test="${tuserCompany.CJobsStatus == '3'}">selected</c:if>>网店卖家</option>
									<option value="4" <c:if test="${tuserCompany.CJobsStatus == '4'}">selected</c:if>>学生</option>
									<option value="5" <c:if test="${tuserCompany.CJobsStatus == '5'}">selected</c:if>>其他</option>
								</select> --%>
							</td>
							<th width="25%">收入发放方式:</th>	
							<td>
								<input class="radio-input" type="radio" id="incomePayWay" name="incomePayWay"
									value="银行卡发放" checked> 银行卡发放 <input
									class="radio-input" type="radio" id="incomePayWay" name="incomePayWay"
									value="现金发放" <c:if test="${tuserCompany.CIncomePayWay == '现金发放'}">checked</c:if>> 现金发放
							</td>
						</tr>
						
						<tr>
							<th width="25%">职位:</th>	
							<td>
								<input id="CPost" name="CPost" class="inputText" type="text"
									value="${tuserCompany.CPost }">
							</td>
							<th width="25%">单位性质:</th>	
							<td>
							<f:select nodeKey="dwxz" id="nature" showBlankOnTop="true" defaultValue="${tuserCompany.CNature}"></f:select>
								<%-- <select id="nature" name="nature">
									<option value="">请选择</option>
									<option value="1" <c:if test="${tuserCompany.CNature == '1'}">selected</c:if>>机关事业单位</option>
									<option value="2" <c:if test="${tuserCompany.CNature == '2'}">selected</c:if>>社会团体</option>
									<option value="3" <c:if test="${tuserCompany.CNature == '3'}">selected</c:if>>国有企业</option>
									<option value="4" <c:if test="${tuserCompany.CNature == '4'}">selected</c:if>>三资企业</option>
									<option value="5" <c:if test="${tuserCompany.CNature == '5'}">selected</c:if>>上市公司</option>
									<option value="6" <c:if test="${tuserCompany.CNature == '6'}">selected</c:if>>民营</option>
									<option value="7" <c:if test="${tuserCompany.CNature == '7'}">selected</c:if>>私营</option>
									<option value="8" <c:if test="${tuserCompany.CNature == '8'}">selected</c:if>>个体</option>
									<option value="9" <c:if test="${tuserCompany.CNature == '9'}">selected</c:if>>其他</option>
								</select>
 --%>							</td>
						</tr>
						<tr>
							<th width="25%">工作年限:</th>	
							<td>
							<f:select nodeKey="gznx" id="workYears" showBlankOnTop="true" defaultValue="${tuserCompany.CWorkYears}"></f:select>
								<%-- <select id="workYears" name="workYears">
									<option value="">请选择</option>
									<option value="1" <c:if test="${tuserCompany.CWorkYears == '1'}">selected</c:if>>半年以内</option>
									<option value="2" <c:if test="${tuserCompany.CWorkYears == '2'}">selected</c:if>>1年以内</option>
									<option value="3" <c:if test="${tuserCompany.CWorkYears == '3'}">selected</c:if>>2年以内</option>
									<option value="4" <c:if test="${tuserCompany.CWorkYears == '4'}">selected</c:if>>3年以内</option>
									<option value="5" <c:if test="${tuserCompany.CWorkYears == '5'}">selected</c:if>>3年以上</option>
								</select> --%>
							</td>
							<th width="25%">单位名称:</th>	
							<td>
								<input id="companyName" name="companyName" class="inputText" type="text"
									value="${tuserCompany.CName }">
							</td>
						</tr>
						<tr>
							<th width="25%">任职部门:</th>	
							<td>
								<input id="deptName" name="deptName" class="inputText" type="text"
									value="${tuserCompany.CDeptName}">
							</td>
							<th width="25%">单位地址:</th>	
							<td>
								<input id="companyAddress" name="companyAddress" class="inputText" type="text"
									value="${tuserCompany.CAddress}">
							</td>
						</tr>
						<tr>
							<th width="25%">单位电话:</th>	
							<td>
								<input id="companyPhone" name="companyPhone" class="inputText" type="text"
									value="${tuserCompany.CPhone}">
							</td>
							<th width="25%">收入范围:</th>	
							<td>
								<input id="CIncomeScope" name="CIncomeScope" class="inputText" type="text"
									value="${tuserCompany.CIncomeScope}">
							</td>
						</tr>
						<tr>
							<th width="25%">公司规模:</th>	
							<td>
								<input id="cSize" name="cSize" class="inputText" type="text"
									value="${tuserCompany.cSize}">
							</td>
							<th width="25%">公司行业:</th>
							<td>
								<input id="CIndustry" name="CIndustry" class="inputText" type="text"
									value="${tuserCompany.CIndustry}">
							</td>	
						</tr>
						<tr>
							<th width="25%">单位区域:</th>	
							<td>
								<input id="CAreaid" name="CAreaid" class="inputText" type="text"
									value="${tuserCompany.CAreaid}">
							</td>	
						</tr>
					</table>
					<input type="hidden" name="tuserID" value="${tUser.userId}" />
					<%-- <input type="hidden" id="sysuserID" name="sysuserID" value="${sessionScope.user['userId']}" /> --%>
					<input type="hidden" id="companyFlag" name="companyFlag" value="" class="inputText" />
					<div style="text-align: center;">
						<c:if test="${companyFlag == '2' || companyFlag == '3' }">
							<input id="sub-btn-jibenxinxi_outpass" class="sub-btn" type="button"
								value="取消审核" onclick="editCompanyInfo('outpass')">
						</c:if>
						<c:if test="${companyFlag == '0' || companyFlag == '1' || companyFlag == '' || companyFlag == null}">
							<input id="sub-btn-danweiqingkuang_pass" class="sub-btn" type="button"
							value="审核通过" onclick="editCompanyInfo('pass')">
							<input id="sub-btn-danweiqingkuang_nopass" class="sub-btn" type="button"
							value="审核不通过" onclick="editCompanyInfo('nopass')">
						</c:if>
						<input id="sub-btn-danweiqingkuang_save" class="sub-btn" type="button"
							value="保存修改" onclick="editCompanyInfo('save')">
					</div>
				</div>
				</form>
				<form id="editBaseContactForm" method="post" action="">
				<div class="con-box con-box-lianxifangshi" style="display: none;">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>							
							<th width="25%">直系联系人姓名:</th>	
							<td>
								<input id="cName" name="cName" class="inputText" type="text"
									value="${tuserContact.CName}">
							</td>
							<th width="25%">其他联系人姓名:</th>	
							<td>
								<input id="cOtherName" name="cOtherName" class="inputText" type="text"
									value="${tuserContact.COtherName}">
							</td>
						</tr>		
						<tr>
							<th width="25%">直系联系人关系:</th>	
							<td>
							<f:select nodeKey="zslxrgx" id="cRelation" showBlankOnTop="true" defaultValue="${tuserContact.CRelation}"></f:select>
								<%-- <select id="cRelation" name="cRelation">
									<option value="">请选择</option>
									<option value="1" <c:if test="${tuserContact.CRelation == '1'}">selected</c:if>>配偶</option>
									<option value="2" <c:if test="${tuserContact.CRelation == '2'}">selected</c:if>>父母</option>
									<option value="3" <c:if test="${tuserContact.CRelation == '3'}">selected</c:if>>兄弟姐妹</option>
									<option value="4" <c:if test="${tuserContact.CRelation == '4'}">selected</c:if>>其他亲戚</option>
									<option value="5" <c:if test="${tuserContact.CRelation == '5'}">selected</c:if>>朋友</option>
									<option value="6" <c:if test="${tuserContact.CRelation == '6'}">selected</c:if>>同事</option>
								</select> --%>
							</td>
							<th width="25%">其他联系人关系:</th>	
							<td>
							<f:select nodeKey="zslxrgx" id="cOtherRelation" showBlankOnTop="true" defaultValue="${tuserContact.COtherRelation}"></f:select>
							
							<%-- 	<select id="cOtherRelation" name="cOtherRelation">
									<option value="">请选择</option>
									<option value="1" <c:if test="${tuserContact.COtherRelation == '1'}">selected</c:if>>配偶</option>
									<option value="2" <c:if test="${tuserContact.COtherRelation == '2'}">selected</c:if>>父母</option>
									<option value="3" <c:if test="${tuserContact.COtherRelation == '3'}">selected</c:if>>兄弟姐妹</option>
									<option value="4" <c:if test="${tuserContact.COtherRelation == '4'}">selected</c:if>>其他亲戚</option>
									<option value="5" <c:if test="${tuserContact.COtherRelation == '5'}">selected</c:if>>朋友</option>
									<option value="6" <c:if test="${tuserContact.COtherRelation == '6'}">selected</c:if>>同事</option>
								</select> --%>
							</td>
						</tr>
						<tr>
							<th width="25%">直系联系人手机:</th>	
							<td>
								<input id="cMobile" name="cMobile" class="inputText" type="text"
									value="${tuserContact.CMobile}">
							</td>
							<th width="25%">其他联系人手机:</th>	
							<td>
								<input id="cOtherMobile" name="cOtherMobile" class="inputText" type="text"
									value="${tuserContact.COtherMobile}">
							</td>
						</tr>
					</table>
					<input type="hidden" name="tuserID" value="${tUser.userId}" />
					<%-- <input type="hidden" id="sysuserID" name="sysuserID" value="${sessionScope.user['userId']}" /> --%>
					<input type="hidden" id="contactFlag" name="contactFlag" value="" class="inputText" />
					<div style="text-align: center;">
						<c:if test="${contactFlag == '2' || contactFlag == '3' }">
							<input id="sub-btn-jibenxinxi_outpass" class="sub-btn" type="button"
								value="取消审核" onclick="editContactInfo('outpass')">
						</c:if>
						<c:if test="${contactFlag == '0' || contactFlag == '1' || contactFlag == '' || contactFlag == null}">
							<input id="sub-btn-lianxifangshi_pass" class="sub-btn" type="button"
							value="审核通过" onclick="editContactInfo('pass')">
							<input id="sub-btn-lianxifangshi_nopass" class="sub-btn" type="button"
							value="审核不通过" onclick="editContactInfo('nopass')">
						</c:if>
						<input id="sub-btn-lianxifangshi_save" class="sub-btn" type="button"
							value="保存修改" onclick="editContactInfo('save')">
					</div>
				</div>
				</form>
		
		<script>
			$(function() {
				$("#sidebar>ul>li:not(:first)>a").hover(
						function() {
							$(this).css("background-color", "#fd8f59");
							var background_position_y = $(this).children("div")
									.css("background-position").split(" ")[1];
							$(this).children("div").css("background-position",
									"-20px " + background_position_y);
						},
						function() {
							var background_position_y = $(this).children("div")
									.css("background-position").split(" ")[1];
							$(this).css("background-color", "#fff9d9");
							$(this).children("div").css("background-position",
									"0px " + background_position_y);
						}
						).bind("click", function() {
					$(".subsidebar").hide();
					if ($(this).next().css("display") == "none") {
						$(this).next().show();
					} else {
						$(this).next().hide();
					}
					;
				});
	
				$(".con-item").click(function() {
					$(".con-item").removeClass("con-on");
					$(this).addClass("con-on");
					$(".con-box").css("display", "none");
					$(".con-box-" + $(this).attr("id")).css("display", "block");
				});
			});
			
			function editBaseInfo(flag) {
				if("pass" == flag){
					$("#baseFlag").val("2"); //审核通过
				}else if("nopass" == flag){
					$("#baseFlag").val("3"); //审核不通号
				}else if("outpass" == flag){
					$("#baseFlag").val("1"); //未审核
				}else{
					$("#baseFlag").val("0");
				}
				
				//console.log($('#editBaseInfoForm').serialize());
				if($("#editBaseInfoForm").valid()) {
				$.ajax({
					url : "${ctx}/loan/sysManager/tuseraudit/editBaseInfo.ht",
					type : 'post',
					data : $('#editBaseInfoForm').serialize(),
					dataType : 'json',
					success : function(data) {
						var datas = eval(data);
						if (datas == "0") {
							if("save" == flag){
								alert("基本资料修改成功");
							}else{
								alert("基本资料审核成功");
							}
							window.location.reload();
						} else {
							alert(datas);
						}

					},
					error : function(xhr, textStatus, errorThrown) {
						if("save" == flag){
							alert("基本资料修改失败");
						}else{
							alert("基本资料审核失败");
						}
					}
				});
				}
			}

			function editFamilyInfo(flag) {

				if("pass" == flag){
					$("#familyFlag").val("2"); //审核通过
				}else if("nopass" == flag){
					$("#familyFlag").val("3"); //审核不通号
				}else if("outpass" == flag){
					$("#familyFlag").val("1"); //未审核
				}else{
					$("#familyFlag").val("0");
				}
				//console.log($('#editBaseFamilyForm').serialize());
				if($("#editBaseFamilyForm").valid()) {
				$.ajax({
					url : "${ctx}/loan/sysManager/tuseraudit/editFamilyInfo.ht",
					type : 'post',
					data : $('#editBaseFamilyForm').serialize(),
					dataType : 'html',
					success : function(data, status) {
						var datas = eval(data);
						if (datas == "0") {
							if("save" == flag){
								alert("家庭资料修改成功");
							}else{
								alert("家庭资料审核成功");
							}
							window.location.reload();
						} else {
							alert(datas);
						}
					},
					error : function(xhr, textStatus, errorThrown) {
						if("save" == flag){
							alert("家庭资料修改失败");
						}else{
							alert("家庭资料审核失败");
						}
					}
				});
				}
			}

			function editContactInfo(flag) {
				if("pass" == flag){
					$("#contactFlag").val("2"); //审核通过
				}else if("nopass" == flag){
					$("#contactFlag").val("3"); //审核不通号
				}else if("outpass" == flag){
					$("#contactFlag").val("1"); //未审核
				}else{
					$("#contactFlag").val("0");
				}
				//console.log($('#editBaseContactForm').serialize());
				if($("#editBaseContactForm").valid()) {
				$.ajax({
					url : "${ctx}/loan/sysManager/tuseraudit/editContactInfo.ht",
					type : 'post',
					data : $("#editBaseContactForm").serialize(),
					dataType : 'html',
					success : function(data, status) {
						var datas = eval(data);
						if (datas == "0") {
							if("save" == flag){
								alert("联系资料修改成功");
							}else{
								alert("联系资料审核成功");
							}
							window.location.reload();
						} else {
							alert(datas);
						}
					},
					error : function(xhr, textStatus, errorThrown) {
						if("save" == flag){
							alert("联系资料修改失败");
						}else{
							alert("联系资料审核失败");
						}
					}
				});
				}
			}

			function editCompanyInfo(flag) {
				if("pass" == flag){
					$("#companyFlag").val("2"); //审核通过
				}else if("nopass" == flag){
					$("#companyFlag").val("3"); //审核不通号
				}else if("outpass" == flag){
					$("#companyFlag").val("1"); //未审核
				}else{
					$("#companyFlag").val("0");
				}
				//console.log($('#editBaseCompanyForm').serialize());
				if($("#editBaseCompanyForm").valid()) {
				$.ajax({
					url : "${ctx}/loan/sysManager/tuseraudit/editCompanyInfo.ht",
					type : 'post',
					data : $("#editBaseCompanyForm").serialize(),
					dataType : 'html',
					success : function(data, status) {
						var datas = eval(data);
						if (datas == "0") {
							if("save" == flag){
								alert("单位资料修改成功");
							}else{
								alert("单位资料审核成功");
							}
							window.location.reload();
						} else {
							alert(datas);
						}
					},
					error : function(xhr, textStatus, errorThrown) {
						if("save" == flag){
							alert("单位资料修改失败");
						}else{
							alert("单位资料审核失败");
						}
					}
				});
				}
			}
			
			$().ready(function() {
				$("#FProvincesId").change(function(){
					$("#FCityId").html('');
					$("#FAreaId").html('');
					$.ajax({
						url : "${ctx}/loan/sysManager/tuseraudit/ajaxGetJilian.ht",
						type : 'post',
						data : "areaId=" + $(this).val(),
						dataType : 'json',
						success : function(data) {
							if(data.length > 0){
								var html = "<option value=''>请选择市</option>";
								for ( var i = 0; i < data.length; i++) {
									html += "<option value='" + data[i].areaId + "'>" + data[i].areaName + "</option>";
								}
								$("#FCityId").html(html);
							}

						},
						error : function(xhr, textStatus, errorThrown) {
							alert('异步获取数据出现异常');
						}
					});
				});
				
				$("#FCityId").change(function(){
					$("#FAreaId").html('');
					$.ajax({
						url : "${ctx}/loan/sysManager/tuseraudit/ajaxGetJilian.ht",
						type : 'post',
						data : "areaId=" + $(this).val(),
						dataType : 'json',
						success : function(data) {
							if(data.length > 0){
								var html = "<option value=''>请选择区,县</option>";
								for ( var i = 0; i < data.length; i++) {
									html += "<option value='" + data[i].areaId + "'>" + data[i].areaName + "</option>";
								}
								$("#FAreaId").html(html);
							}

						},
						error : function(xhr, textStatus, errorThrown) {
							alert('异步获取数据出现异常');
						}
					});
				});
			});
			
		</script>
			
		</div>
</div> 
</body>
</html>
