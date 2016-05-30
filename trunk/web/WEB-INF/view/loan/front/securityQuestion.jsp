<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>安全问题</title>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
	<meta name="renderer" content="webkit"/>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
  <link title="index" name="styleTag" rel="stylesheet" type="text/css" href="${ctx}/styles/default/css/web.css"></link>
  	<link rel="stylesheet" href="${ctx}/crowdfunding/public.css">
    <link rel="stylesheet" href="${ctx}/crowdfunding/Skin/Default/css/Userbackground.css">
    <link rel="stylesheet" href="${ctx}/crowdfunding/Skin/Default/css/securityQuestion.css">
</head>

<script type="text/javascript">
$().ready(function() {
	 $("#questionForm").validate({
	        rules: {
	    q1: {
	    required: true
	   },
	   a1: {
	    required: true
	   },
	    q2: {
		    required: true
		   },
		   a2: {
		    required: true
		   },
		    q3: {
			    required: true
			   },
			   a3: {
			    required: true
			   }
	  },
	        messages: {
	    q1: {
	    required: "必选"
	   },
	    a1: {
	    required: "必填"
	   },
	    q2: {
		    required: "必选"
		   },
		    a2: {
		    required: "必填"
		   },
		    q3: {
			    required: "必选"
			   },
			   a3: {
				    required: "必填"
				   }
	  }
	    });
	});



	function fillSafeQuestion() {
		valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
		if($('#questionForm').valid()){
		
		$.ajax({
			url : "${ctx}/safe/fillSafeQuestion.ht",
			type : 'post',
			data : $("#questionForm").serialize(),
			dataType : 'html',
			success : function(data, status) {
				var datas = eval(data);
				if(datas == "0"){
					window.parent.openDialog("安全问题设置成功");
					setTimeout('window.location = "${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht";',2000);
				}else{
					window.parent.openDialog(datas);
					setTimeout('window.location = "${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht";',2000);
				}
			},
			error : function(xhr, textStatus, errorThrown) {
				window.parent.openDialog("安全问题提交异常");
			}
		});
		}
	}

	//selectList.push({value:'您父亲的出生地是哪里',text:'您父亲的出生地是哪里'});
	//selectList.push({value:'您出生的医院是哪间',text:'您出生的医院是哪间'});
	//selectList.push({value:'您成长的街道叫什么路',text:'您成长的街道叫什么路'});
	//selectList.push({value:"您就读的第一所学校名称是",text:"您就读的第一所学校名称是"});
	//selectList.push({value:"您的初恋情人叫什么名字",text:"您的初恋情人叫什么名字"});
	//selectList.push({value:"您就职的第一家公司名称",text:"您就职的第一家公司名称"});
	//selectList.push({value:"您父亲的姓名",text:"您父亲的姓名"});
	//selectList.push({value:"您母亲的姓名",text:"您母亲的姓名"});
	//selectList.push({value:"您父亲的生日",text:"您父亲的生日"});
	//selectList.push({value:"您母亲的生日",text:"您母亲的生日"});
	//selectList.push({value:"您配偶的姓名",text:"您配偶的姓名"});
	//selectList.push({value:"您所上大学的名称",text:"您所上大学的名称"});
	
	$(function(){
		$("select").focus(function(){
			var selectList = new Array();
			$("select[name=q1] option").each(function(){
				selectList.push({value:$(this).attr('value'),text:$(this).text()});				
			});
			
			
			var curVal = $(this).val();
			var curList = new Array();
			$("select").each(function(){
				var val = $(this).val();
				if(val && val!=curVal){
					curList.push(val);
				}
			});
			var html = "";
			for(var i=0;i<selectList.length;i++){
				var s = selectList[i];
				var flag = false;
				for(var j=0;j<curList.length;j++){
					if(curList[j]==s.value){
						flag = true;
						break;
					}
				}
				if(flag){
					continue;
				}
				if(s.value==curVal){
					html+="<option value='"+s.value+"'>"+s.text+"</option>";
				}else{
					html+="<option value='"+s.value+"'>"+s.text+"</option>";
				}
			}
			$(this).html(html);
		});
	});

</script>
<body>
<form id="questionForm" method="post">
		<div class="addyourproject f_l">
			<h2><img src="${ctx}/crowdfunding/Skin/Default/images/headportrait4.png">安全问题</h2>
        <div class="con-box">
          <div class="tips" style="margin-top:40px;">>>安全问题是基础安全工具，可作为二次验证的备选方案，建议认真填写。</div>
          <dl>
            <dt></dt>
            <dd class="error-tips"></dd>
            <dt>问题一 :</dt>
            <dd class="select-box">
            <f:select nodeKey="SALE_ISSUE" id="q1" name="q1" showBlankOnTop="true">
			</f:select>
            </dd>
            <dt></dt>
            <dd class="error-tips"></dd>
            <dt>答案 :</dt>
            <dd><input id="a1" name="a1" class="text-input" type="text" value=""></dd>
            <dt></dt>
            <dd class="error-tips"></dd>
            <dt>问题二 :</dt>
            <dd class="select-box">
            <f:select nodeKey="SALE_ISSUE" id="q2" name="q2" showBlankOnTop="true"></f:select>
            </dd>
            <dt></dt>
            <dd class="error-tips"></dd>
            <dt>答案 :</dt>
            <dd><input id="a2" name="a2" class="text-input" type="text" value=""></dd>
            <dt></dt>
            <dd class="error-tips"></dd>
            <dt>问题三 :</dt>
            <dd class="select-box">
            <f:select nodeKey="SALE_ISSUE" id="q3" name="q3" showBlankOnTop="true"></f:select>
            </dd>
            <dt></dt>
            <dd class="error-tips"></dd>
            <dt>答案 :</dt>
            <dd><input id="a3" name="a3" class="text-input" type="text" value=""></dd>
          </dl>
          <div style="text-align:center;">
            <input id="sub-btn-jibenxinxi" class="sub-btn" type="button" value="确认提交" onclick="fillSafeQuestion()"/>
            <input type="button" onclick="window.location.href= '${ctx}/crowdfunding/tcuserPersonalData/accountSafeCenter.ht';"  class="sub-btn" value="返回" style="margin-left:10px;cursor: pointer;">
          </div>
          <div class="wenxintishi">
            <span>温馨提示：</span><br>
              1. 请设置容易记忆的安全问题，并定期重新设置，避免遗忘。<br> 
              2. 请不要向外人透露您的安全问题答案。
          </div>
        </div>
		</div>
		</form>
</body>
</html>