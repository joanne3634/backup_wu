<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<%@ include file="/crowdfunding/cssorjs.jsp"%>
 <%@include file="/commons/include/form.jsp" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="UTF-8">
	<title>会员后台-项目设置</title>
	<meta name="renderer" content="webkit"/>
	<script type="text/javascript" src="${ctx}/js/deelon/p2p/personalPhotoAtt.js"></script>
	<script type="text/javascript" src="${ctx}/js/calendar/My97DatePicker/WdatePicker.js"></script>
	<link href="${ctx}/js/jquery/plugins/attach.css" rel="stylesheet" />
	<link href="${ctx}/js/jquery/plugins/jquery.qtip.min.css" rel="stylesheet" />
	<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.qtip.min.js" ></script>
	<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.attach.js" ></script>
	
	
	 <script type="text/javascript" src="${ctx }/js/jquery/plugins/jquery.showLoading.js"></script>
	<script type="text/javascript" src="${ctx }/js/jquery/plugins/jquery.showLoading.min.js"></script>
						 
   <link href="${ctx }/styles/default/css/jquery/showLoading.css" rel="stylesheet" type="text/css" />

    <link rel="stylesheet" href="${ctx}/crowdfunding/Skin/Default/css/Userbackground.css">
    <style type="text/css">
    .ProjectSettingList .ProSetselect {
    width: 150px;
    }
   .ProjectSettingList select {
    width: 70px;
    }
    .ProjectSettingList ul li .ProSetinput {
    width: 80px;
    }
    .personalDataform ul li, .ProjectSettingList ul li {
    padding: 4px 0;
}
    </style>
</head>
<body>
		<div class="AccountCenterWindow f_l">
		<form id="basicForm"  method="post" action="${ctx}/crowdfunding/tcproject/saveproject.ht">
			<h3 class="AccountCenterH3"><img src="${ctx}/crowdfunding/Skin/Default/images/headportrait4.png">编辑项目资料</h3>
			<!-- <div class="patternPaymentNav">
				<ul>
					<li class="PaPaNavChecked">项目基本资料</li>
					<%--<li onclick="clicking()"> 上传项目视频</li>--%>
				</ul>
			</div> -->
			<div class="steps">
				<div class="active step">
					<span>基本资料</span>
				</div>
				<div class="step">
					<span>市场定位与商业模式</span>
				</div>
				<div class="step" id="step3">
					<span>股东及管理团队</span>
				</div>
				<div class="step" id="step4">
					<span>项目历史执行资料</span>
				</div>
				<div class="step" id="step5">
					<span>项目未来计划</span>
				</div>
			</div>
			<span class="clear ProjectSettingList">
				<ul>
					<li>
						<span><a style="color: red;">*</a>项目名称：</span><input type="text" id="pname" name="pname" value="${tcproject.pname}"/>
					</li>
					<li>
						<span>项目详细资料查看权限：</span><input type="radio" name="pviewLimit" <c:if test="${tcproject.pviewLimit==0 or empty tcproject.pviewLimit}">checked="checked"</c:if> value="0"/>所有登陆用户可看<input type="radio" name="pviewLimit" <c:if test="${tcproject.pviewLimit==1}">checked="checked"</c:if> value="1"/>所有用户需先申请经我批准后才可看
					</li>
					<li>
						<span class="proType">项目类别：</span>
						<input type="radio" name="ptypeId" <c:if test="${tcproject.ptypeId==1 or empty tcproject.ptypeId}">checked="checked"</c:if>  value="1"/>科技创新
						<input type="radio" name="ptypeId" <c:if test="${tcproject.ptypeId==2}">checked="checked"</c:if> value="2"/>实体经营
						<input id="houseInvest" type="radio" name="ptypeId" <c:if test="${tcproject.ptypeId==3}">checked="checked"</c:if> value="3" data-step-hide="#step3|#step4|#step5"/>地产投资
					</li>
					<li>
						<span>项目所属行业：</span><f:select nodeKey="PIND" id="pindustry" styleClass="ProSetselect" defaultValue="${tcproject.pindustry}"></f:select><span>企业成立时间：</span><select name="pfoundedYear" ><c:forEach items="${years }" var="year"> <option <c:if test="${tcproject.pfoundedYear==year}"> selected </c:if>>${year}</option> </c:forEach></select>年<select  name="pfoundedMonth" > <c:forEach items="${months }" var="month"> <option <c:if test="${tcproject.pfoundedMonth==month}"> selected </c:if>>${month}</option> </c:forEach></select>月  
					</li>
					<li>
						<span>项目所属阶段：</span><f:select nodeKey="PTYPE" id="pstage"  defaultValue="${tcproject.pstage}" styleClass="ProSetselect"></f:select>  <span><a style="color: red;">*</a>企业所在城市：</span><select id="pprovincesId" name="pprovincesId"  style=" width:90px;">
															<option value="请选择省">请选择省</option>
															<c:forEach items="${arealist }" var="list">
																<option value="${list.areaId }" <c:if test="${tcproject.pprovincesId == list.areaId }">selected</c:if>>${list.areaName }</option>
															</c:forEach>
														</select>
														<select id="pcityId" name="pcityId" style=" width:90px;"><option value="${tcproject.pcityId }"><h:getArea areaId="${tcproject.pcityId }"></h:getArea></option></select> 
					</li>
					<li>
						<%-- <span><a style="color: red;">*</a>企业员工人数：</span><input name="pemployeesCount" type="text" class="ProSetinput"  value="${tcproject.pemployeesCount}"/>人<span>是否还有其他项目：</span><f:select nodeKey="sf" id="pisHaveOther" defaultValue="${tcproject.pisHaveOther}"></f:select> --%>
						<span><a style="color: red;">*</a>企业员工人数(人)：</span><input id="pemployeesCount" name="pemployeesCount" type="text" class="ProSetinput"  value="${tcproject.pemployeesCount}"/>
						<span style="
							position: relative;
							left: 200px;">是否还有其他项目：</span>
						<c:if test="${empty tcproject }">
							<select name="pisHaveOther" id="pisHaveOther" style="position: relative; left:191px">
									<option value="1">是</option>
									<option value="0" selected='selected'>否</option>
							</select>
						<%--<f:select nodeKey="sf" id="pisHaveOther" defaultValue="1"  ></f:select>--%>
						</c:if>
						<c:if test="${!empty tcproject }">
							<select name="pisHaveOther" id="pisHaveOther" style="position: relative; left:191px">
							<c:choose>
								<c:when test="${tcproject.pisHaveOther == 1}">
									<option value="1"selected='selected'>是</option>
									<option value="0" >否</option>
								</c:when>
								<c:otherwise>
									<option value="1">是</option>
									<option value="0" selected='selected'>否</option>
								</c:otherwise>
							</c:choose>
						   </select>
						</c:if>
					</li>
					<li>
						<span>公司是否已经成立：</span><f:select nodeKey="sf" id="psetup" defaultValue="${tcproject.psetup}"></f:select><span>项目标签：</span><input name="plabel" type="text"  class="ProSetinput" value="${tcproject.plabel}" style=" width: 295px"/>
					</li>
					<li>
						<span><a style="color: red;">*</a>公司全称：</span><input id="pcompanyName" name="pcompanyName" type="text" value="${tcproject.pcompanyName}" style=" width: 560px"/>
					</li>
					<li>
						<span>办公地址：</span><input name="paddress" type="text" value="${tcproject.paddress}" style=" width: 560px"/>
					</li>
					<li>
						<span><a style="color: red;">*</a>项目估值(万元)：</span><input name="pvaluationFinal" id="pvaluationFinal" type="text" style=" width: 300px" class="ProSetinput" value="<fmt:formatNumber value="${tcproject.pvaluationFinal}" pattern="#####.##"  minFractionDigits="0" />"/>
					</li>
					<li>
					
						<%-- <span>融资金额：</span><input name="pfinancingAmount" type="text" class="ProSetinput" value="<fmt:formatNumber value="${tcproject.pfinancingAmount/10000}" pattern="#####.##"  minFractionDigits="0" />"/>万人民币<span>融资天数：</span><input name="popenDays" type="text" class="ProSetinput" <c:if test="${empty tcproject.popenDays}"> value="<%=application.getAttribute("PROJECT-OPEN-DAYS")==null?30:application.getAttribute("PROJECT-OPEN-DAYS") %>"</c:if> <c:if test="${tcproject.popenDays>0}"> value="${tcproject.popenDays}"</c:if>/>天 --%>
						<span><a style="color: red;">*</a>融资金额(万元)：</span><input name="pfinancingAmount" id="pfinancingAmount" type="text" class="ProSetinput" onblur="valueCheck()" value="<fmt:formatNumber value="${tcproject.pfinancingAmount/10000}" pattern="#####.##"  minFractionDigits="0" />"/>
						<label style="display: none;" id="pfinancingAmount_no_show" for="pfinancingAmount" generated="true" class="error" >必填</label>
						<span><a style="color: red;">*</a>融资天数(天)：</span><input id="popenDays" name="popenDays" type="text" class="ProSetinput" <c:if test="${empty tcproject.popenDays}"> value="<%=application.getAttribute("PROJECT-OPEN-DAYS")==null?30:application.getAttribute("PROJECT-OPEN-DAYS") %>"</c:if> <c:if test="${tcproject.popenDays>0}"> value="${tcproject.popenDays}"</c:if>/>
							<%--<input type="hidden" id="warmValue" name = "warmValue" <c:if test="${empty tcproject.pneedWarmUp or tcproject.pneedWarmUp==0}"> value = "0" </c:if> <c:if test="${tcproject.pneedWarmUp >= 1}"> value="${tcproject.pneedWarmUp}" checked="checked"</c:if>  />--%>
					</li>
					<li>
						<span>是否需要预热：</span><input type="checkbox" id="needWarmUp"  name="needWarmUp" onclick="iClick();" <c:if test="${ tcproject.pneedWarmUp==0}"> value = 0 </c:if> <c:if test="${tcproject.pneedWarmUp >= 1}"> value="${tcproject.pneedWarmUp}" checked="checked"</c:if> />
						<span style="
								width: 400px;
								text-align: left;
								font-size: 12px;"> 温馨提示：<font color="red">默认预热天数为：<%=application.getAttribute("PROJECT_WARMUP_DURATION")==null?10:application.getAttribute("PROJECT_WARMUP_DURATION") %>天</font></span>
					</li>
					<%--<li class="ProSettextarea">--%>
						<%--<span> 温馨提示：<font color="red">默认预热天数为：<%=application.getAttribute("PROJECT_WARMUP_DURATION")==null?10:application.getAttribute("PROJECT_WARMUP_DURATION") %>天</font></span>--%>
					<%--</li>--%>
					<li>
						<span>投资款拨付方式：</span><input type="radio" name="ppayWay" <c:if test="${tcproject.ppayWay==1}">checked="checked"</c:if>  value="1"/> 每季度一次，每次25%<input type="radio" name="ppayWay" <c:if test="${tcproject.ppayWay==2}">checked="checked"</c:if>  value="2"/>每半年一次，每次50%；<input type="radio" name="ppayWay"  <c:if test="${tcproject.ppayWay==3  or empty tcproject.ppayWay}">checked="checked"</c:if>  value="3"/>一次性全额到账；
					</li>
					<li class="ProSettextarea">
						<div style="
							position: fixed;
							padding-left: 0px;
							font-size: 16px;
							color: #141414;">
							<span><a style="color: red;">*</a>企业项目简介：</span>
						</div>
						<div>
						<textarea id="pdetail" name="pdetail" cols="80" rows="5" >${tcproject.pdetail}</textarea>
						</div>
						<div>您<em id="h"></em>可以输入<em id="counts">300</em>个字</div>
					</li>
					<!-- li>
						<span>上传项目图片：</span><div style="display:inline-block;width:400px;">attachType="2" /></div>
					</li> -->
					<li><span>上传项目图片：</span><a  href="#" onclick="addPic();" title="点击上传项目图片" alt="" id="projectImage"><pageTag:projectPic menupath="${tcproject.projectId}"/></a><input type="hidden" name="ppic" id="ppic"  value="${tcproject.ppic}"/> </li>
					<li class="ProSettextarea">
						<div>温馨提示：<font color="red">点击图片上传项目图片。</font>项目审核通过后项目方不能再更换项目图片，请选择最有吸引力的一张图片，宽高最佳尺寸为220x130像素，其他产品图片请在商业模式资料编辑栏继续添加</div>
					</li>
					<li><span>上传视频：</span><input id='pvideo' name="pvideo" value="${tcproject.pvideo}" style=' width: 350px;margin-left: 0px'/>（请填写网络视频路径）</li>
				</ul>
			</div>
			<input type="hidden" id="pinvestAmount" name="pinvestAmount" value="${tcproject.pinvestAmount}">
			<input type="hidden" id="pviewCount" name="pviewCount" value="${tcproject.pviewCount }">
			<input type="hidden" id="pfavoritesCount" name="pfavoritesCount" value="${tcproject.pfavoritesCount }">
			<input type="hidden" id="pinvestCount" name="pinvestCount" value="${tcproject.pinvestCount }">
			<input type="hidden" id="paskPriceCount" name="paskPriceCount" value="${tcproject.paskPriceCount }">
			<input type="hidden" id="pisRecommended" name="pisRecommended" value="${tcproject.pisRecommended }">
			<input type="hidden" id="pinvestMax" name="pinvestMax" value="${tcproject.pinvestMax }">
			<input type="hidden" id="pinvestMin" name="pinvestMin" value="${tcproject.pinvestMin }">
			<input type="hidden" id="isDel" name="isDel" value="${tcproject.isDel }">
			<input type="hidden" id="pisFull" name="pisFull" value="${tcproject.pisFull }">
			<input type="hidden" id="pisCheck" name="pisCheck" value="${tcproject.pisCheck }">
			<input type="hidden" id="pchecker" name="pchecker" value="${tcproject.pchecker }">
			<input type="hidden" id="pisPay" name="pisPay" value="${tcproject.pisPay }">
			<input type="hidden" id="pdealRate" name="pdealRate" value="${tcproject.pdealRate }">
			<input type="hidden" id="pdealFees" name="pdealFees" value="${tcproject.pdealFees }">
			<input type="hidden" id="pfinalGetPay" name="pfinalGetPay" value="${tcproject.pfinalGetPay }">
			<input type="hidden" id="pisBreak" name="pisBreak" value="${tcproject.pisBreak }">
			<input type="hidden" id="pbreakRemark" name="pbreakRemark" value="${tcproject.pbreakRemark }">
			<input type="hidden" id="pcheckRemark" name="pcheckRemark" value="${tcproject.pcheckRemark }">
			<input type="hidden" id="phavedPay" name="phavedPay" value="${tcproject.phavedPay }">
			<input type="hidden" id="ppayPercent" name="ppayPercent" value="${tcproject.ppayPercent }">
			<input type="hidden" id="pleaderId" name="pleaderId" value="${tcproject.pleaderId }">
			<input type="hidden" id="psharesPercent" name="psharesPercent" value="${tcproject.psharesPercent }">
			<input type="hidden" id="pneedWarmUp" name="pneedWarmUp" value="${ tcproject.pneedWarmUp}" >
			<input type="hidden" id="pcheckTimes" name="pcheckTimes" value="${tcproject.pcheckTimes }">
			<div class="cumulative">
			<div class="cumulativeButton"><div  class="cumulativeButton1"  onclick="submitForm(1)">下一步</div><div  class="cumulativeButton1" onclick="submitForm(2)">返回</div></div>
			<input type="hidden" id="next" name="next"/><input type="hidden" id="projectId" name="projectId" value="${tcproject.projectId}"/>
		</form>
		</div>
	<script type="text/javascript">
		$().ready(function(){
			if($("#pneedWarmUp").val()==''){
				$("#pneedWarmUp").val(0);
			}
			var test = document.getElementById("houseInvest").checked;
			if(test){
				$("#step3").attr("style","display:none");
				$("#step4").attr("style","display:none");
				$("#step5").attr("style","display:none");
			}
			$("#pic").attr("style","width:224px; height:132px;");
		});

	function valueCheck(){
//		alert(111)
		var invest=parent.frames["iframepage"].document.getElementById("pfinancingAmount").value;
		var estimate=parent.frames["iframepage"].document.getElementById("pvaluationFinal").value;
		if(""==invest||""==estimate){
			return false;
		}else{
			invest=parseInt(invest);
			estimate=parseInt(estimate);
		}

	//融资金额不可大于估值金额
		if(invest>estimate){
			$.ligerDialog.warn("融资金额不可大于估值金额");
			return false;
		}else{
			return true;
		}
	}
	var myDate,year,month;
	myDate = new Date();
	year=myDate.getFullYear();
	month=parseInt(myDate.getMonth())+1;
	day=myDate.getDate();
	//判断公司成立时间小于当前时间
	function SelectMonth()
	{
		var selYear = $("select[name='pfoundedYear']").children("option:selected").html();
		var selMon = $("select[name='pfoundedMonth']").children("option:selected").html();
		 var selecttime = new Date(selYear, selMon, "01");
		 var nowtime = new Date(year, month, day);
			if(selecttime>nowtime)
			{
			  return true;
			
		}else{
			
			return false;
		}
	}
	//添加个人照片
	function picCallBack(fileIds, array) {
		
		if (!array && array != "")
			return;
		var fileId = array[0].fileId, fileName = array[0].fileName;
		var ppic = "{'attachs':[{'fileId':'"+fileId+"','fileName':'"+fileName+"'}]}";
		$("#ppic").attr("value",ppic);
		var path = __ctx + "/wuyouchou/system/sysFile/getFileById.ht?fileId="+ fileId;
		 if(/\w+.(png|gif|jpg)/gi.test(fileName)){
			//$("#picture").val("/wuyouchou/system/sysFile/getFileById.ht?fileId=" + fileId);
			$("#pic").attr("src",path);
		}
		 
		var name = fileName.toLowerCase();
		if (name.indexOf(".png") > -1 || name.indexOf(".gif") > -1
				|| name.indexOf(".jpg") > -1) {
			//	$("#picture").val("/wuyouchou/system/sysFile/getFileById.ht?fileId=" + fileId);
			$("#pic").attr("src", path);
		} else {
			$.ligerDialog.warn("请选择*png,*gif,*jpg类型图片!");
		}

	};
	//上传照片
	function addPic() {
		//FlexUploadDialog({isSingle:true,callback:picCallBack});
		DirectUploadDialog({
			isSingle : true,
			callback : picCallBack
		});
		$("#projectImage").attr("title","点击更换项目图片");
	};
	
		function clicking(){
			art.dialog({
			    top: 100,
				content: '项目未通过平台审核，暂时不能添加项目视频。'}).lock().time(2);
		}
		function returnArtDialog(){
			var dialog = art.dialog({
			    title: '欢迎',
				content: '欢迎使用artDialog对话框组件！<input />',
				icon: 'succeed',
			    follow: document.getElementById('btn2'),
			    ok: function(){
			    	this.title('警告').content('请注意artDialog两秒后将关闭！').lock().time(2);
			        return false;
			    }
			});
		}
		//function returnArtDialog(){
		//	var dialog = art.dialog({
		//	    title: '欢迎',
		//	    content: '欢迎使用artDialog对话框组件！',
		//	    icon: 'succeed',
		//	    follow: document.getElementById('btn2'),
		//	    ok: function(){
		//	        return false;
		//	    },okVal: '确定',
		//	      cancelVal: '关闭',
		//	    cancel: function(){
		//	   	console.log(123);
		//	    },fixed:true,
		//	    resize:true
		//	});
		//	art.dialog('简单愉悦的接口，强大的表现力，优雅的内部实现', function(){art.dialog('处理你的逻辑，跳转或者其他操作。');});
		//}

	//验证页面必输项，并弹出提示框提示
	function validateAlert(){
		if (''==$("#popenDays").val()){
			$.ligerDialog.warn("请填写完整的项目信息");

		}

		if(''==$("#pname").val()){
			$.ligerDialog.warn("请填写完整的项目信息");

		}

		if(''==$("#pemployeesCount").val()){
			$.ligerDialog.warn("请填写完整的项目信息");

		}

		if(''==$("#pcityId").val()){
			$.ligerDialog.warn("请填写完整的项目信息");

		}


		if(''==$("#pcompanyName").val()){
			$.ligerDialog.warn("请填写完整的项目信息");

		}
		if(""==parent.frames["iframepage"].document.getElementById("pvaluationFinal").value){
			$.ligerDialog.warn("请填写完整的项目信息");

		}

		if(""==parent.frames["iframepage"].document.getElementById("pfinancingAmount").value){
			$.ligerDialog.warn("请填写完整的项目信息");

		}

		if(''==$("#pdetail").val()){
			$.ligerDialog.warn("请填写完整的项目信息");

		}

		if(''==$("#popenDays").val()){
			$.ligerDialog.warn("请填写完整的项目信息");

		}

	}
		function submitForm(next){
			if(!valueCheck()){
				return;
			}
			$(".AccountCenterWindow").showLoading(); 
			var pfinancingAmount = $("#pfinancingAmount").val();
			var pvaluationFinal = $("#pvaluationFinal").val();
			$('#next').val(next);
			if(SelectMonth()){
				$.ligerDialog.warn("企业成立日期不能大于当前日期");
				$(".AccountCenterWindow").hideLoading(); 
				return;
			}/*  else if(pvaluationFinal<=0){
				$.ligerDialog.warn("项目估值不能为空");
				$(".AccountCenterWindow").hideLoading(); 
				return;
			}*/ else if(pfinancingAmount==0||pfinancingAmount<0){
			//	$.ligerDialog.warn("融资金额不能为空");
				$("#pfinancingAmount_no_show").show();
				
				$(".AccountCenterWindow").hideLoading(); 
				return;
			}
			else if($("#basicForm").valid()) {
				$("#basicForm").submit();
		//		$(".AccountCenterWindow").hideLoading(); 
			}else{
				$(".AccountCenterWindow").hideLoading();
				validateAlert();
				return ;
			}
		}
		
		 function submitfun (){
			 $("#basicForm").submit();
		}


		$(function(){
			$('input[name="ptypeId"]').click(function(){
				var hides = $(this).data('step-hide');
				if(hides) {
					hides.split("|").forEach(function(value){
						$(value).hide();
					});
				} else {
					$('.step').show();
				}
			});
			$("select[name='pfoundedYear']").children("option[value='"+year+"']").attr("selected",true);
			$("select[name='pfoundedMonth']").children("option[value='"+month+"']").attr("selected",true);
			function maxLimit(){
		        var num=$(this).val().substr(0,300);
		        $(this).val(num);
		        $("#h").text("还");
		        $("#counts").text(300-($(this).val().length));
			};
			$("#pdetail").keyup(maxLimit);//调用方法
			$("#basicForm").validate({
		        rules: {
		        	popenDays: {//融资天数
			    	    required: true ,
			    	    number: true
				   			},
		        pname: {//项目名称
		    	    required: true ,
		  		    maxlength: 50
			   			},
			   	pemployeesCount: { //  企业员工人数
				    required: true,
				    number: true
				   	     },
				pcityId: { //城市验证
		    		required: true
		  				},
		  		pcompanyName: { //公司全称
				    required: true,
				    maxlength: 50
					    },
				pvaluationFinal: { //项目估值
					required: true,
					number: true
						},
				pfinancingAmount: { //融资金额
					required: true,
					//maxlength: 3 ,
					number: true
						},
				pdetail: { //详情
					required: true 
						}
				},
		        messages: {
		        	popenDays: {//融资天数
			    	   /*  required: "请确认融资天数", */
			    	    required: "必填",
					    number:"请填写数字"
				   			},
		        pname: {
		    		/* required: "项目名称必填" */
		        	required: "必填"
		   			},
		   		pcityId: {
			    	/* required: "城市必选" */
		   			required: "必选"
			   		},
			   	pemployeesCount: {
				    /* required: "员工人数必填" ,
				    number:"请填写数字" */
			   		required: "必填" ,
				    number:"请填写数字"
				   	},
				pcompanyName: {
					/* required: "公司名称必填" */
					required: "必填"
				    },
				pvaluationFinal: {
					/* required: "融资金额必填",
				    number:"请填写数字" */
					required: "必填",
				    number:"请填写数字"
					} ,
				pfinancingAmount: {
					/* required: "融资金额必填",
				    number:"请填写数字" */
					required: "必填",
				    number:"请填写数字"
					} ,
				pdetail: { //详情
					/* required: "详情不可以为空"  */
					required: "必填" 
					}
		  		}
		    });
			$(".patternPaymentNav li").click(function(){
				  $(this).addClass('PaPaNavChecked').siblings().removeClass('PaPaNavChecked');
			});
			$("select[name='pfoundedMonth']").change(function(){
				if(SelectMonth()){
					$.ligerDialog.warn("企业成立日期不能大于当前日期");
				}
			});
			$("#pprovincesId").change(function(){
				if($(this).val() =="请选择省"){return;}			
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
						$("#pcityId").html(html);

					},
					error : function(xhr, textStatus, errorThrown) {
						//alert('异步获取数据出现异常');
					}
				});
			});	
		})


		function iClick(){
//			var check=document.getElementById('iframepage').contentWindow.$("#needWarmUp").is(":checked");
			var t = $("#pneedWarmUp").val();
			if(t ==1){
				$("#pneedWarmUp").val(0);
			}else{
				$("#pneedWarmUp").val(1);
			}
//			alert($("#pneedWarmUp").val())
		}
	</script>
</body>
</html>