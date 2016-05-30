<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>确认安全问题</title>
<%@ include file="/crowdfunding/cssorjs.jsp"%>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/reset.css">
<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/public.css">
<link rel="stylesheet" href="${ctx}/crowdfunding/Skin/Default/css/Userbackground.css">
<link rel="stylesheet" href="${ctx}/crowdfunding/Skin/Default/css/bindPhone.css"> 
</head>
<body>	
		<div class="addyourproject f_l">
			<h2><img src="${ctx}/crowdfunding/Skin/Default/images/headportrait4.png">修改/设置安全问题</h2>
						<div class="con-box bd-b-color-main bd-l-color-main bd-r-color-main">
					<div class="tips">>>修改安全问题关系到您的账号安全，请您验证安全问题</div>
					<form id="questionForm" method="post">
					<dl class="con-table-right xyhrzzl-tab">
						<dt>问题一 :</dt>
						<dd class="select-box">
						 	<f:description itemValue="${userSafe.q1 }" nodeKey="SALE_ISSUE" /> 
						</dd>
						<dt></dt>
            			<dd class="error-tips"></dd>
						<dt>答案 :</dt>
						<dd>
							<input id="a1" name="a1" class="text-input" type="text" value="">
						</dd>
						<dt></dt>
            			<dd class="error-tips"></dd>
						<dt>问题二 :</dt>
						<dd class="select-box">
						<f:description itemValue="${userSafe.q2 }" nodeKey="SALE_ISSUE" />
						</dd>
						<dt></dt>
            			<dd class="error-tips"></dd>
						<dt>答案 :</dt>
						<dd>
							<input id="a2" name="a2" class="text-input" type="text" value="">
						</dd>
						 <dt></dt>
           				<dd class="error-tips"></dd>
						<dt>问题三 :</dt>
						<dd class="select-box">
						<f:description itemValue="${userSafe.q3 }" nodeKey="SALE_ISSUE" />
						</dd>
						<dt></dt>
            			<dd class="error-tips"></dd>
						<dt>答案 :</dt>
						<dd>
							<input id="a3" name="a3" class="text-input" type="text" value="">
						</dd>
					</dl>
					<div style="text-align: center;"><a id="result_" style="color: red;font-size: 12px;"></a></div>
					<input type="hidden" id="flag" name="flag" value="change">
					<div style="text-align: center;">
						<input id="sub-btn-jibenxinxi" class="sub-btn bg-color-l" type="button"
							value="确认提交" onclick="fillSafeQuestion()">
							<input type="button" onclick="window.location.href= '${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht';"  class="sub-btn" value="返回" style="margin-left:10px;cursor: pointer;">
					</div>
					</form>
					<div style="padding-left:275px;margin-bottom:30px;font-size:14px;"><span>忘记安全问题答案？ </span><a class="color-main" href="${ctx}/safe/safeQuestionReset.ht">点击邮箱重置安全问题 >></a></div>
					<div class="wenxintishi" style="margin-left:275px;">
						<span>温馨提示：</span><br> 1. 请设置容易记忆的安全问题，并定期重新设置，避免遗忘。<br>
						2. 请不要向外人透露您的安全问题答案。
					</div>
      </div>
		</div>






 
	
</body>

<script type="text/javascript">

	$().ready(function() {
		$("#questionForm").validate({
			rules : {
				q1 : {
					required : true
				},
				a1 : {
					required : true
				},
				q2 : {
					required : true
				},
				a2 : {
					required : true
				},
				q3 : {
					required : true
				},
				a3 : {
					required : true
				}
			},
			messages : {
				q1 : {
					required : "请选择问题"
				},
				a1 : {
					required : "必填"
				},
				q2 : {
					required : "请选择问题"
				},
				a2 : {
					required : "必填"
				},
				q3 : {
					required : "请选择问题"
				},
				a3 : {
					required : "必填"
				}
			}
		});
	});

	function fillSafeQuestion() {
		valiLoginTimeout('iframe'); //验证是否登录超时，跳转至登录页面
		if ($('#questionForm').valid()) {
			//console.log($("#questionForm").serialize());		
			$.ajax({
				url : "${ctx}/safe/fillSafeQuestion.ht",
				type : 'post',
				data : $("#questionForm").serialize(),
				dataType : 'html',
				success : function(data, status) {
					var datas = eval(data);
					if (datas == "0") {
						//alert("安全问题已提交成功");
						window.parent.openDialog("安全问题设置成功");
						//$("#result_").html('安全问题设置成功');
						//location.reload();
					} else if(datas == "1"){
						window.location.href = "${ctx}/safe/safeQuestionInit.ht?flag=old";	
					} else if(datas == "2"){
						window.parent.openDialog("安全答案输入错误");
					} else {
						//$("#result_").html(datas);
						window.parent.openDialog(datas);
					}
				},
				error : function(xhr, textStatus, errorThrown) {
					//$("#result_").html("安全问题提交异常");
					window.parent.openDialog("安全问题提交异常");
				}
			});
		}
	}

	$(function() {
		$("select").focus(
				function() {
					var selectList = new Array();
					$("select[name=q1] option").each(function() {
						selectList.push({
							value : $(this).attr('value'),
							text : $(this).text()
						});
					});

					var curVal = $(this).val();
					var curList = new Array();
					$("select").each(function() {
						var val = $(this).val();
						if (val && val != curVal) {
							curList.push(val);
						}
					});
					var html = "";
					for ( var i = 0; i < selectList.length; i++) {
						var s = selectList[i];
						var flag = false;
						for ( var j = 0; j < curList.length; j++) {
							if (curList[j] == s.value) {
								flag = true;
								break;
							}
						}
						if (flag) {
							continue;
						}
						if (s.value == curVal) {
							html += "<option value='"+s.value+"'>" + s.text
									+ "</option>";
						} else {
							html += "<option value='"+s.value+"'>" + s.text
									+ "</option>";
						}
					}
					$(this).html(html);
				});
	});
</script>
</html>