<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<%@ include file="/commons/includeFront/javascripts.jsp"%>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
<script type="text/javascript" src="${ctx}/js/deelon/editUserInfo.js"></script>

</head>

<script type="text/javascript">

	function editBaseInfo() {
		
		if ($('#editBaseInfoForm').valid()) {
			valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
			$.ajax({
				url : "${ctx}/user/editBaseInfo.ht",
				type : 'post',
				data : $('#editBaseInfoForm').serialize(),
				dataType : 'json',
				success : function(data) {
					var datas = eval(data);
					if (datas == "0") {
						//alert("基本资料更改成功");
						//location.reload();
						window.location.reload();
					} else {
						alert(datas);
					}

				},
				error : function(xhr, textStatus, errorThrown) {
					alert("基本资料更改失败");
				}
			});
		}
	}
	
	function editFamilyInfo() {

		if ($('#editBaseFamilyForm').valid()) {
			valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
			$.ajax({
				url : "${ctx}/user/editFamilyInfo.ht",
				type : 'post',
				data : $('#editBaseFamilyForm').serialize(),
				dataType : 'html',
				success : function(data, status) {
					var datas = eval(data);
					if (datas == "0") {
						//alert("家庭资料更改成功");
						window.location.reload();
						//location.reload();
					} else {
						alert(datas);
					}
				},
				error : function(xhr, textStatus, errorThrown) {
					alert('家庭资料更改失败');
				}
			});
		}
	}
	function mobilekeyUp(){
		var cMobile = $("#cMobile").val();
		var cOtherMobile = $("#cOtherMobile").val();
		if(cMobile == cOtherMobile){
			$("#cOtherMobile_a").html('俩个手机号不能相同');
		}else{
			$("#cOtherMobile_a").html("");
		}
	}
	function editContactInfo() {
		if($("#editBaseContactForm").valid()) {
			var cMobile = $("#cMobile").val();
			var cOtherMobile = $("#cOtherMobile").val();
			if(cMobile == cOtherMobile){
				$("#cOtherMobile_a").html('俩个手机号不能相同');
				return;
			}
			
			valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
			$.ajax({
				url : "${ctx}/user/editContactInfo.ht",
				type : 'post',
				data : $("#editBaseContactForm").serialize(),
				dataType : 'html',
				success : function(data, status) {
					var datas = eval(data);
					if (datas == "0") {
						//alert("联系资料更改成功");
						window.location.reload();
						//location.reload();
					} else {
						alert(datas);
					}
				},
				error : function(xhr, textStatus, errorThrown) {
					alert('联系资料更改失败');
				}
			});
		}
	}

	function editCompanyInfo() {
		if($("#editBaseCompanyForm").valid()) {
			valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
			$.ajax({
				url : "${ctx}/user/editCompanyInfo.ht",
				type : 'post',
				data : $("#editBaseCompanyForm").serialize(),
				dataType : 'html',
				success : function(data, status) {
					var datas = eval(data);
					if (datas == "0") {
						//alert("单位资料更改成功");
						window.location.reload();
						//location.reload();
					} else {
						alert(datas);
					}
				},
				error : function(xhr, textStatus, errorThrown) {
					alert('单位资料更改失败');
				}
			});
		}
	}
	
	$().ready(function() {
		$("#FProvincesId").change(function(){
			$("#FCityId").html('');
			$("#FAreaId").html('');
			$.ajax({
				url : "${ctx}/user/ajaxGetJilian.ht",
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
				url : "${ctx}/user/ajaxGetJilian.ht",
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

<body style="min-height: 1050px;">
				<div class="tit-box mb15 element-box bd-color-main bg-color-s"><span class="tit-xxl color-main">编辑个人资料</span></div>
				<div class="overf-h">
					<div class="con-tabname editinfo-tabname bd-b-color-main tab-on" id="jibenxinxi">我的基本信息</div>
					<div class="editinfo-spac13 bd-b-color-main"></div>
					<div class="con-tabname editinfo-tabname bd-b-color-main" id="jiatingqingkuang">我的家庭情况</div>
					<div class="editinfo-spac13 bd-b-color-main"></div>
					<div class="con-tabname editinfo-tabname bd-b-color-main" id="danweiqingkuang">我的单位情况</div>
					<div class="editinfo-spac13 bd-b-color-main"></div>
					<div class="con-tabname editinfo-tabname bd-b-color-main" id="lianxifangshi">我的联系方式</div>
				</div>
				<form action="${ctx}/user/editBaseInfo.ht" method="post" id="editBaseInfoForm">
				<input type="hidden" value="${userSafe.statusID }" name="status">
					<div class="con-box bd-b-color-main bd-l-color-main bd-r-color-main con-box-jibenxinxi" style="margin-bottom:330px;">

						<div class="con-tips bd-color-main bg-color-s color-main">>>亲爱的用户，为节约您的宝贵时间，请认真准确填以下信息，否则评估会不准确，对您借款会有影响。</div>

						<table>
							<tr>
								<td class="con-table-left"><span><img
									src="${ctx}/images/jibenxinxi-pic.png" alt=""><br>我的基本信息<br>（<span class="color-red">*</span>必填）</span></td>
								<td>
									<dl class="con-table-right">
										<dt>
											<span class="color-red">*</span>真实姓名:
										</dt>
										<dd>
											<input name="realName" id="realName" class="text-input" type="text" value="${user.realName }">											
											<div id="realNameErr" style="color:red"></div>
										</dd>
										<dt>
											<span class="color-red">*</span>性别:
										</dt>
										<dd>
											<input class="radio-input" type="radio" name="gender"
												value="先生" checked> 先生<input class="radio-input"
												type="radio" name="gender" value="女士" <c:if test="${user.gender == '女士'}">checked</c:if>> 女士
										</dd>
										<dt>
											<span class="color-red">*</span>学校:
										</dt>
										<dd>
											<input name="school" class="text-input" type="text" value="${user.school }">
										</dd>
										<dt>
											<span class="color-red">*</span>手机号码:
										</dt>
										<dd>
											<input name="mobile" class="text-input" type="text" value="${userSafe.mobile }"   <c:if test="${userSafe.bindMobile == 1 }">disabled="disabled"</c:if>>
											
										</dd>
										<dt>
											<span class="color-red">*</span>Q Q号码:
										</dt>
										<dd>
											<input name="qqNo" class="text-input" type="text" value="${userSafe.qqNo }">
											
										</dd>
										<dt>
											<span class="color-red">*</span>教育程度:
										</dt>
										<dd class="select-box" >
<!-- 											<select id="edu" name="edu"> -->
<!-- 												<option value="">请选择</option> -->
<%-- 												<option value="研究生及以上" <c:if test="${user.edu == '研究生及以上'}">selected</c:if>>研究生及以上</option> --%>
<%-- 												<option value="本科" <c:if test="${user.edu == '本科'}">selected</c:if>>本科</option> --%>
<%-- 												<option value="大专" <c:if test="${user.edu == '大专'}">selected</c:if>>大专</option> --%>
<%-- 												<option value="专科" <c:if test="${user.edu == '专科'}">selected</c:if>>专科</option> --%>
<%-- 												<option value="高中" <c:if test="${user.edu == '高中'}">selected</c:if>>高中</option> --%>
<%-- 												<option value="中专" <c:if test="${user.edu == '中专'}">selected</c:if>>中专</option> --%>
<%-- 												<option value="初中及以下" <c:if test="${user.edu == '初中及以下'}">selected</c:if>>初中及以下</option> --%>
<!-- 											</select> -->
											<f:select nodeKey="jycd" id="edu" name="edu" showBlankOnTop="true" defaultValue="${user.edu}" ></f:select>
										</dd>
										<dt>
											<span class="color-red">*</span>身份证号:
										</dt>
										<dd>
											<input name="idNo" class="text-input" type="text" value="${userSafe.idNo }">
										</dd>
									</dl>
								</td>
							</tr>
						</table>
						<div style="text-align: center;">
							<input id="sub-btn-jibenxinxi" class="sub-btn bg-color-l" type="button"
								value="确定基本信息" onclick="editBaseInfo()">
						</div>
					</div>
				</form>
				<form method="post" id="editBaseFamilyForm">
				<input type="hidden" value="${userFamily.statusID }" name="status">
				<div class="con-box bd-color-main con-box-jiatingqingkuang" style="display: none;">
					<div class="con-tips bd-color-main bg-color-s color-main">>>亲爱的用户，为节约您的宝贵时间，请认真准确填以下信息，否则评估会不准确，对您借款会有影响。</div>
					<table>
						<tr>
							<td  class="con-table-left"><img
								src="${ctx}/images/jiatingqingkuang-pic.png" alt=""><br>我的家庭情况<br>（<span class="color-red">*</span>必填）</td>
							<td>
								<dl class="con-table-right">
									<dt>
										<span class="color-red">*</span>婚姻状况:
									</dt>
									<dd class="select-box">
<!-- 										<select id="marriage" name="marriage"> -->
<!-- 											<option value="">请选择</option> -->
<%-- 											<option value="未婚" <c:if test="${userFamily.FMarriage == '未婚'}">selected</c:if>>未婚</option> --%>
<%-- 											<option value="已婚" <c:if test="${userFamily.FMarriage == '已婚'}">selected</c:if>>已婚</option> --%>
<%-- 											<option value="离婚" <c:if test="${userFamily.FMarriage == '离婚'}">selected</c:if>>离婚</option> --%>
<%-- 											<option value="丧偶" <c:if test="${userFamily.FMarriage == '丧偶'}">selected</c:if>>丧偶</option> --%>
<%-- 											<option value="其他" <c:if test="${userFamily.FMarriage == '其他'}">selected</c:if>>其他</option> --%>
<!-- 										</select> -->
										<f:select nodeKey="hyzk" id="marriage" name="marriage" showBlankOnTop="true" defaultValue="${userFamily.FMarriage}" ></f:select>
									</dd>
									<dt>
										<span class="color-red">*</span>住宅状况:
									</dt>
									<dd class="select-box">
<!-- 										<select id="fHouse" name="fHouse"> -->
<!-- 											<option value="">请选择</option> -->
<%-- 											<option value="自置无按揭" <c:if test="${userFamily.FHouse == '自置无按揭'}">selected</c:if>>自置无按揭</option> --%>
<%-- 											<option value="自置有按揭" <c:if test="${userFamily.FHouse == '自置有按揭'}">selected</c:if>>自置有按揭</option> --%>
<%-- 											<option value="商住两用" <c:if test="${userFamily.FHouse == '商住两用'}">selected</c:if>>商住两用</option> --%>
<%-- 											<option value="租用" <c:if test="${userFamily.FHouse == '租用'}">selected</c:if>>租用</option> --%>
<%-- 											<option value="与父母共住" <c:if test="${userFamily.FHouse == '与父母共住'}">selected</c:if>>与父母共住</option> --%>
<%-- 											<option value="集体宿舍" <c:if test="${userFamily.FHouse == '集体宿舍'}">selected</c:if>>集体宿舍</option> --%>
<%-- 											<option value="其他" <c:if test="${userFamily.FHouse == '其他'}">selected</c:if>>其他</option> --%>
<!-- 										</select> -->
										<f:select nodeKey="zjqk" id="fHouse" name="fHouse" showBlankOnTop="true" defaultValue="${userFamily.FHouse}" ></f:select>
									</dd>
									<dt>
										<span class="color-red">*</span>住宅地区:
									</dt>
									<dd class="select-box">

					                    <select id="FProvincesId" name="FProvincesId" style="width:100px;" >
					                    	<option value="">请选择省份</option>
					                    	<c:forEach items="${list }" var="list">
					                    		
					                    		<option value="${list.areaId }" <c:if test="${userFamily.FProvincesId == list.areaId }">selected</c:if>>${list.areaName }</option>				                    	
					                    	</c:forEach>
					                    </select>
					                    	
					                    <select id="FCityId" name="FCityId" style="width:100px;">
					                    	<option value="${userFamily.FCityId }"><h:getArea areaId="${userFamily.FCityId} "></h:getArea></option>
					                    </select>
					                    <select id="FAreaId" name="FAreaId" style="width:100px;">
					                    	<option value="${userFamily.FAreaId }"><h:getArea areaId="${userFamily.FAreaId} "></h:getArea></option>
					                    </select>
					                    <input type="hidden" name="location_id" />
									</dd>
									<dt><span class="color-red">*</span>住宅地址:</dt>
									<dd>
										<input class="text-input" type="text" id="FAddress" name="FAddress" value="${userFamily.FAddress }">
									</dd>
									<dt>
										<span class="color-red">*</span>住宅电话:
									</dt>
									<dd style="margin-bottom:10px;">
										<input id="phone" name="phone" class="text-input" type="text" value="${userFamily.FPhone }"><br><span>(例
											021-51870819、13813888888)</span>
									</dd>
									<dt>
										<span class="color-red">*</span>入住年数:
									</dt>
									<dd class="select-box">
<!-- 										<select id="liveYears" name="liveYears"> -->
<!-- 											<option value="">请选择</option> -->
<%-- 											<option value="1" <c:if test="${userFamily.FLiveYears == '1'}">selected</c:if>>半年以内</option> --%>
<%-- 											<option value="2" <c:if test="${userFamily.FLiveYears == '2'}">selected</c:if>>1年以内</option> --%>
<%-- 											<option value="3" <c:if test="${userFamily.FLiveYears == '3'}">selected</c:if>>2年以内</option> --%>
<%-- 											<option value="4" <c:if test="${userFamily.FLiveYears == '4'}">selected</c:if>>3年以内</option> --%>
<%-- 											<option value="5" <c:if test="${userFamily.FLiveYears == '5'}">selected</c:if>>3年以上</option> --%>
<!-- 										</select> -->
										<f:select nodeKey="rzns" id="liveYears" name="liveYears" showBlankOnTop="true" defaultValue="${userFamily.FLiveYears}" ></f:select>
									</dd>
									<dt>是否购车:</dt>
									<dd>
										<input class="radio-input" type="radio" id="isBuyCar"
											name="isBuyCar" value="1" checked> 是<input
											class="radio-input" type="radio" name="isBuyCar" value="0" <c:if test="${userFamily.FIsBuyCar == '0'}">checked</c:if>>
										否
									</dd>
									<dt>是否有车贷:</dt>
									<dd>
										<input class="radio-input" type="radio" id="fisCarLoan"
											name="fisCarLoan" value="1" checked> 是<input
											class="radio-input" type="radio" name="fisCarLoan" value="0" <c:if test="${userFamily.fisCarLoan == 0}">checked</c:if>>
										否
									</dd>
									<dt>是否有房贷:</dt>
									<dd>
										<input class="radio-input" type="radio" id="fisHouseLoan"
											name="fisHouseLoan" value="1" checked> 是<input
											class="radio-input" type="radio" name="fisHouseLoan" value="0" <c:if test="${userFamily.fisHouseLoan == 0}">checked</c:if>>
										否
									</dd>
								</dl>
							</td>
						</tr>
					</table>
					
					<div style="text-align: center;">
						<input id="sub-btn-jiatingqingkuang" class="sub-btn bg-color-l" type="button"
							value="确定家庭情况" onclick="editFamilyInfo()">
					</div>
				</div>
				</form>
				<form method="post" id="editBaseCompanyForm">
				<input type="hidden" value="${userCompany.statusID }" name="status">
				<div class="con-box bd-color-main  con-box-danweiqingkuang" style="display: none;">
					<div class="con-tips bd-color-main bg-color-s color-main">>>亲爱的用户，为节约您的宝贵时间，请认真准确填以下信息，否则评估会不准确，对您借款会有影响。</div>
					<table>
						<tr>
							<td class="con-table-left"><img
								src="${ctx}/images/danweiqingkuang-pic.png" alt=""><br>我的单位情况<br>（<span class="color-red">*</span>必填）</td>
							<td>
								<dl class="con-table-right">
									<dt>
										<span class="color-red">*</span>就业状态:
									</dt>
									<dd class="select-box">
<!-- 										<select id="jobsStatus" name="jobsStatus"> -->
<!-- 											<option value="">请选择</option> -->
<%-- 											<option value="1" <c:if test="${userCompany.CJobsStatus == '1'}">selected</c:if>>工薪族</option> --%>
<%-- 											<option value="2" <c:if test="${userCompany.CJobsStatus == '2'}">selected</c:if>>私营业主</option> --%>
<%-- 											<option value="3" <c:if test="${userCompany.CJobsStatus == '3'}">selected</c:if>>网店卖家</option> --%>
<%-- 											<option value="4" <c:if test="${userCompany.CJobsStatus == '4'}">selected</c:if>>学生</option> --%>
<%-- 											<option value="5" <c:if test="${userCompany.CJobsStatus == '5'}">selected</c:if>>其他</option> --%>
<!-- 										</select> -->
										<f:select nodeKey="jyzt" id="jobsStatus" name="jobsStatus" showBlankOnTop="true" defaultValue="${userCompany.CJobsStatus}" ></f:select>
									</dd>
									<dt>收入发放方式:</dt>
									<dd>
										<input class="radio-input" type="radio" id="incomePayWay" name="incomePayWay"
											value="银行卡发放" checked> 银行卡发放 <input
											class="radio-input" type="radio" id="incomePayWay" name="incomePayWay"
											value="现金发放" <c:if test="${userCompany.CIncomePayWay == '现金发放'}">checked</c:if>> 现金发放
									</dd>
									<dt>
										<span class="color-red">*</span>职位:
									</dt>
									<dd>
										<input id="CPost" name="CPost" class="text-input" type="text"
											value="${userCompany.CPost }">
									</dd>
									<dt>
										<span class="color-red">*</span>单位性质:
									</dt>
									<dd class="select-box">
<!-- 										<select id="nature" name="nature"> -->
<!-- 											<option value="">请选择</option> -->
<%-- 											<option value="1" <c:if test="${userCompany.CNature == '1'}">selected</c:if>>机关事业单位</option> --%>
<%-- 											<option value="2" <c:if test="${userCompany.CNature == '2'}">selected</c:if>>社会团体</option> --%>
<%-- 											<option value="3" <c:if test="${userCompany.CNature == '3'}">selected</c:if>>国有企业</option> --%>
<%-- 											<option value="4" <c:if test="${userCompany.CNature == '4'}">selected</c:if>>三资企业</option> --%>
<%-- 											<option value="5" <c:if test="${userCompany.CNature == '5'}">selected</c:if>>上市公司</option> --%>
<%-- 											<option value="6" <c:if test="${userCompany.CNature == '6'}">selected</c:if>>民营</option> --%>
<%-- 											<option value="7" <c:if test="${userCompany.CNature == '7'}">selected</c:if>>私营</option> --%>
<%-- 											<option value="8" <c:if test="${userCompany.CNature == '8'}">selected</c:if>>个体</option> --%>
<%-- 											<option value="9" <c:if test="${userCompany.CNature == '9'}">selected</c:if>>其他</option> --%>
<!-- 										</select> -->
										<f:select nodeKey="dwxz" id="nature" name="nature" showBlankOnTop="true" defaultValue="${userCompany.CNature}" ></f:select>
									</dd>
									<dt>
										<span class="color-red">*</span>工作年限:
									</dt>
									<dd class="select-box">
<!-- 										<select id="workYears" name="workYears"> -->
<!-- 											<option value="">请选择</option> -->
<%-- 											<option value="1" <c:if test="${userCompany.CWorkYears == '1'}">selected</c:if>>半年以内</option> --%>
<%-- 											<option value="2" <c:if test="${userCompany.CWorkYears == '2'}">selected</c:if>>1年以内</option> --%>
<%-- 											<option value="3" <c:if test="${userCompany.CWorkYears == '3'}">selected</c:if>>2年以内</option> --%>
<%-- 											<option value="4" <c:if test="${userCompany.CWorkYears == '4'}">selected</c:if>>3年以内</option> --%>
<%-- 											<option value="5" <c:if test="${userCompany.CWorkYears == '5'}">selected</c:if>>3年以上</option> --%>
<!-- 										</select> -->
										<f:select nodeKey="gznx" id="workYears" name="workYears" showBlankOnTop="true" defaultValue="${userCompany.CWorkYears}" ></f:select>
									</dd>
									<dt>
										<span class="color-red">*</span>单位名称:
									</dt>
									<dd>
										<input id="companyName" name="companyName" class="text-input" type="text"
											value="${userCompany.CName }">
									</dd>
									<dt>
										<span class="color-red">*</span>任职部门:
									</dt>
									<dd>
										<input id="deptName" name="deptName" class="text-input" type="text" value="${userCompany.CDeptName }">
									</dd>
									<dt>
										<span class="color-red">*</span>单位地址:
									</dt>
									<dd>
										<input id="companyAddress" name="companyAddress" class="text-input" type="text"
											value="${userCompany.CAddress }">
									</dd>
									<dt>
										<span class="color-red">*</span>单位电话:
									</dt>
									<dd>
										<input id="companyPhone" name="companyPhone" class="text-input" type="text"
											value="${userCompany.CPhone }">
									</dd>
									<dt>
										<span class="color-red">*</span>收入范围:
									</dt>
									<dd>
										<f:select nodeKey="SRFW" id="CIncomeScope" name="CIncomeScope" defaultValue="${userCompany.CIncomeScope }"></f:select> 
									</dd>
									<dt>
										<span class="color-red">*</span>公司规模:
									</dt>
									<dd>
										<input id="cSize" name="cSize" class="text-input" type="text"
											value="${userCompany.cSize }">
									</dd>
									<dt>
										<span class="color-red">*</span>公司行业:
									</dt>
									<dd>
										<input id="CIndustry" name="CIndustry" class="text-input" type="text"
											value="${userCompany.CIndustry }">
									</dd>
									<dt>
										<span class="color-red">*</span>单位区域:
									</dt>
									<dd>
										<input id="CAreaid" name="CAreaid" class="text-input" type="text"
											value="${userCompany.CAreaid }">
									</dd>
								</dl>
							</td>
						</tr>
					</table>
					<div style="text-align: center;">
						<input id="sub-btn-danweiqingkuang" class="sub-btn bg-color-l" type="button"
							value="确定单位情况" onclick="editCompanyInfo()" />
					</div>
				</div>
				</form>
				<form method="post" id="editBaseContactForm">
				<input type="hidden" value="${userContact.statusID }" name="status">
				<div class="con-box bd-color-main  con-box-lianxifangshi" style="display: none;">
					<div class="con-tips bd-color-main bg-color-s color-main">>>请注意：请确保联系人填写正确，为了联系不到您，作为紧急联系人。</div>
					<table>
						<tr>
							<td class="con-table-left"><img
								src="${ctx}/images/lianxifangshi-pic.png" alt=""><br>我的联系方式<br>（<span class="color-red">*</span>必填）</td>
							<td>
								<dl class="con-table-right">
									<dt>
										<span class="color-red">*</span>直系联系人姓名:
									</dt>
									<dd>
										<input id="cName" name="cName" class="text-input" type="text" value="${userContact.CName }">
									</dd>
									<dt>
										<span class="color-red">*</span>直系联系人关系:
									</dt>
									<dd class="select-box">
<!-- 										<select id="cRelation" name="cRelation"> -->
<!-- 											<option value="">请选择</option> -->
<%-- 											<option value="1" <c:if test="${userContact.CRelation == '1'}">selected</c:if>>配偶</option> --%>
<%-- 											<option value="2" <c:if test="${userContact.CRelation == '2'}">selected</c:if>>父母</option> --%>
<%-- 											<option value="3" <c:if test="${userContact.CRelation == '3'}">selected</c:if>>兄弟姐妹</option> --%>
<%-- 											<option value="4" <c:if test="${userContact.CRelation == '4'}">selected</c:if>>其他亲戚</option> --%>
<%-- 											<option value="5" <c:if test="${userContact.CRelation == '5'}">selected</c:if>>朋友</option> --%>
<%-- 											<option value="6" <c:if test="${userContact.CRelation == '6'}">selected</c:if>>同事</option> --%>
<!-- 										</select> -->
										<f:select nodeKey="zslxrgx" id="cRelation" name="cRelation" showBlankOnTop="true" defaultValue="${userContact.CRelation}" ></f:select>
									</dd>
									<dt>
										<span class="color-red">*</span>直系联系人手机:
									</dt>
									<dd>
										<input id="cMobile" name="cMobile" class="text-input" type="text" value="${userContact.CMobile }">
									</dd>
									<dt>
										<span class="color-red">*</span>其他联系人姓名:
									</dt>
									<dd>
										<input id="cOtherName" name="cOtherName" class="text-input" type="text" value="${userContact.COtherName }">
									</dd>
									<dt>
										<span class="color-red">*</span>其他联系人关系:
									</dt>
									<dd class="select-box">
<!-- 										<select id="cOtherRelation" name="cOtherRelation"> -->
<!-- 											<option value="">请选择</option> -->
<%-- 											<option value="1" <c:if test="${userContact.COtherRelation == '1'}">selected</c:if>>配偶</option> --%>
<%-- 											<option value="2" <c:if test="${userContact.COtherRelation == '2'}">selected</c:if>>父母</option> --%>
<%-- 											<option value="3" <c:if test="${userContact.COtherRelation == '3'}">selected</c:if>>兄弟姐妹</option> --%>
<%-- 											<option value="4" <c:if test="${userContact.COtherRelation == '4'}">selected</c:if>>其他亲戚</option> --%>
<%-- 											<option value="5" <c:if test="${userContact.COtherRelation == '5'}">selected</c:if>>朋友</option> --%>
<%-- 											<option value="6" <c:if test="${userContact.COtherRelation == '6'}">selected</c:if>>同事</option> --%>
<!-- 										</select> -->
										<f:select nodeKey="zslxrgx" id="cRelation" name="cRelation" showBlankOnTop="true" defaultValue="${userContact.CRelation}" ></f:select>
									</dd>
									<dt>
										<span class="color-red">*</span>其他联系人手机:
									</dt>
									<dd>
										<input id="cOtherMobile" name="cOtherMobile" class="text-input" type="text"
											value="${userContact.COtherMobile }" onkeyup="mobilekeyUp();">&nbsp;&nbsp;<a id="cOtherMobile_a" style="color: red;font-size: 12px;"></a>
									</dd>
								</dl>
							</td>
						</tr>
					</table>
					<div style="text-align: center;">
						<input id="sub-btn-lianxifangshi" class="sub-btn bg-color-l" type="button"
							value="确定联系方式" onclick="editContactInfo()">
					</div>
				</div>
				</form>
	<script>

		//$(document).ready(function() {
		//	showLocation();
		//});
	
		$(function() {
			
			//公用js开始
			$(".con-tabname").click(function() {
				$(".con-tabname span").removeClass("color-main");
				$(this).find("span").addClass("color-main");
				$(".con-tabname").removeClass("tab-on");
				$(this).addClass("tab-on");
				$(".con-box").css("display", "none");
				$(".con-box-" + $(this).attr("id")).css("display", "block");
			});
			//公用js结束
		})
	</script>
</body>
</html>