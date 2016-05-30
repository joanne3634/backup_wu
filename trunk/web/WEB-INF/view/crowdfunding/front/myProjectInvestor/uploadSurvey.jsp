<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>上传调查报告与评价</title>
	<%@include file="/commons/include/form.jsp" %> 	
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
	<meta name="renderer" content="webkit"/>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/changePwd.css">
   <script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.min.js"></script>
	<script type="text/javascript" src="${ctx}/js/jquery/jquery.validate.ext.js"></script>
   <script type="text/javascript" src="${ctx }/crowdfunding/js/ckeditor/ckeditor.js"></script>
  <script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.qtip.min.js" ></script>
    <script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.attach.js" ></script>
   <script type="text/javascript" src="${ctx}/js/dynamic.jsp"></script>
	<script type="text/javascript" src="${ctx}/js/util/json2.js"></script>
	<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerComboBox.js"></script>
	<script type="text/javascript" src="${ctx}/js/lg/plugins/htDicCombo.js"></script>  
	<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerResizable.js" ></script> 
	<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.htselect.js"></script>
	<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.rowOps.js"></script>

	<script type="text/javascript" src="${ctx}/js/deelon/foldBox.js" ></script>
	<script type="text/javascript" src="${ctx}/js/deelon/absoulteInTop.js" ></script>

	<style>
	.con-box-table{margin:0 auto;width:95%;}
	.con-box-table th{text-align: center;height: 40px;font-weight: bold;border: 1px solid #ccc;}
	.con-box-table td{text-align: center;height: 35px;border: 1px solid #ccc;padding:0px 5px 0px 5px;}
	</style>
</head>
<body>
	<div class="UploadSurvey f_l">
		<!-- <form action="" method="post" id="sendForm"> -->
		    <input type="hidden" id=projectAfterFile value="">
			<div class="addPrDy">
			 <form id="tSetHomepageForm" method="post" action="${ctx}/crowdfunding/front/tcprojectinvest/uploadSurveyFileUpload.ht" enctype="multipart/form-data">
			    <input type="hidden" id="pi_duedoc"/>
			    <input type="hidden" id="projectId" name="projectId" value="${projectId}"/>
				<div><label>创业项目名称：</label><em class="PrName">${projectName}</em></div>
				<div><label>创业团队评价：</label><div><input style="width: 500px;height: 70px;" id="pi_evaluationteam" name="pi_evaluationteam" blur="clearCheck();" cols="80" rows="5" value="${pi_evaluationteam }"></input><br><em id="_warninput1"></em></div></div>
				<div><label>创业项目评价：</label><div><input style="width: 500px;height: 70px;" id="pi_evaluationproject" name="pi_evaluationproject" blur="clearCheck();" cols="80" rows="5" value="${pi_evaluationproject }"></input><br><em id="_warninput2"></em></div></div>
				
			   <%-- <div>上传尽职调查和条款清单文档：
			   <span class="addPrDygreenButton" id="liulang" onclick="addPic('${investId}');">上传附件</span><br><em id="_warninput3"></em></div>
			    --%>
			  
			  	 <input type="hidden" id="investId" name="investId" value="${investId}"/>
			  	 <input type="hidden" id="projectName" name="projectName" value="${projectName }"/>
			   				<table class="table-detail"  cellpadding="0" cellspacing="0" border="0">
								<tr height="100">
								<label>   项目附件上传：</label>
								   <td >
								   
								   <input type="file"   name="file" accept="application/msword" id="fileName"/>
								  <!-- <a class="link save"  id="dataFormSave" href="javascript:saveDatas();"><span></span>确认导入</a> -->
								  
								  <input type="button" style="width: 70px;" onclick="dosubmit()"   value="上传"/> 
								 <!--  <span class="addPrDygreenButton" id="liulang" onclick="dosubmit()">上传附件</span> -->
								 <%-- <span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
								 <span  id="fileNameAtt" style="font-weight: 600;font-size: 15px;color: #666">${fileNameAtt }</span> --%>
								 
								   </td>
								 	  
								</tr>
								
									
								
														
							</table>
							<div><span  id="fileNameAtt" style="font-weight: 600;font-size: 15px;color: #666">${fileNameAtt }</span></div>
							<em id="_warninput3"></em>
			   </form> 
			   
			   
			   <div id="uploaded_files">
			   </div>
			  <div class="addPrDyButton"><span onclick="saveUploadSurvey()"  class="PrDyBackButton">确&nbsp;&nbsp;定</span></div>
			</div>
		<!-- </form>	 -->
	</div>
	<script type="text/javascript">
	$(function(){
		 	$('.addPrDy').on('click','#liulang',function(){
		 		_index=$(this).parent().parent().index();
		 		$(this).parent().find("input").click();
		 	});
		 	$('#pi_evaluationproject').on('blur',function(){
		 		clearCheck();
		 	});
		 	$('#pi_evaluationteam').on('blur',function(){
		 		clearCheck();
		 	});
	});
	var _index;
	function upfile(file){
		 var _name=file.files[0].name;
		// $('.addPrDy').find('#pi_duedoc').val(_name);
	}
	
	//保存上传调查报告与评价
	function saveUploadSurvey(){
		
		
		
		var pi_evaluationteam=$("#pi_evaluationteam").val();
		var pi_evaluationproject=$("#pi_evaluationproject").val();
		var pi_duedoc = $("#fileNameAtt").html();
		if(pi_evaluationteam == ''){
			$("#_warninput1").html("<font color='red'>创业团队评价不能为空!</font>");
			return;
		}
		if(pi_evaluationproject == ''){
			$("#_warninput2").html("<font color='red'>创业项目评价不能为空!</font>");
			return;
		}
		if(pi_duedoc == ''){
			$("#_warninput3").html("<font color='red'>上传尽职调查和条款清单文档不能为空!</font>");
			return;
		}
		art.dialog.confirm("你确定要上传调查报告与评价吗?",function(){
			$.ajax({
					url : "${ctx }/crowdfunding/front/tcprojectinvest/saveUploadSurvey.ht",
					type : 'post',
					dataType : 'json',
					data : $('#tSetHomepageForm').serialize(),
					success : function(data) {
					//	if(data=="0"){
						art.dialog.alert(data);
						setTimeout(closediv,4000);
						
							/* openDialog(data,'','','2',function(){
								closediv();
							}); */
							
						/* }else{
							openDialog(data,'','','2',function(){
								closediv();
							});
						} */
					}
			});
		});
	}
	function clearCheck(){
		var pi_evaluationteam=$("#pi_evaluationteam").val();
		var pi_evaluationproject=$("#pi_evaluationproject").val();
		var pi_duedoc = $("#projectAfterFile").val();
		if(pi_evaluationteam == ''){
			$("#_warninput1").html("<font color='red'>创业团队评价不能为空!</font>");
			return;
		}else{
			$("#_warninput1").html("");
		}
		if(pi_evaluationproject == ''){
			$("#_warninput2").html("<font color='red'>创业项目评价不能为空!</font>");
			return;
		}else{
			$("#_warninput2").html("");
		}
	}
	//添加附件回调函数
	function picCallBack(fileIds, array) {
		if (!array && array != "")
			return;
		var fileId = array[0].fileId, fileName = array[0].fileName;
		if(fileId != '')
			 $('.addPrDy').find('#pi_duedoc').val(fileId);
		var path = __ctx + "/platform/system/sysFile/getFileById.ht?fileId="+ fileId;
		 if(/\w+.(txt|html|htm)/gi.test(fileName)){
			//$("#picture").val("/platform/system/sysFile/getFileById.ht?fileId=" + fileId);
			$("#fileId").val(fileId);
			$("#fileName").val(fileName);
		var name = fileName.toLowerCase();
		if (name.indexOf(".txt") > -1 || name.indexOf(".html") > -1
				|| name.indexOf(".htm") > -1) {
		} else {
			$.ligerDialog.warn("请选择*txt,*html,*htm文件!");
		}
	}
  }
	//上传附件
	function addPic(p) {
		valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
		 //FlexUploadDialog({isSingle:true,callback:picCallBack});
		/* UploadDialogs({
			isSingle : true,
			callback : picCallBack
		},p);  */
		
		
		 var url = "${ctx}/crowdfunding/front/tcprojectinvest/openUploadDialog.ht";
		art.dialog.open(url,{title:'头像上传',close:function(){
			//window.location.reload()
			//$("#head-pic").attr("src","${ctx }/xphwebsite/memcenter/myaccount/proveinfo/getLastHeadImg.ht?time="+new Date());	
		}}); 
	};
	function UploadDialogs(c,t) {
		if (!c) {
			c = {};
		}
		var b = __ctx + "/crowdfunding/front/tcprojectinvest/openUploadDialog.ht?investId="+t;
		var a = "dialogWidth:450px;dialogHeight:300px;help:0;status:0;scroll:1;center:1";
		b = b.getNewUrl();
		var d = window.open(b, "", a);
		//alert(d);
		if (d != undefined) {
			if (c.callback) {
				c.callback.call(this, d);
			}
			eachAttachUpload(d);
		}
	}
	 function eachAttachUpload(jsonobj){
		   var jsonall=jsonobj;
		   var idInputStr = document.getElementById("projectAfterFile").value;
		   if(idInputStr!=""){
			   $("#_warninput3").html("");
			   var jarray = eval(idInputStr);
			   jsonall = jsonobj.concat(jarray);
		   }
		   jQuery("#uploaded_files").empty();
		   if(jsonall!=null){
			jQuery.each(jsonall,function(key,obj){
				jQuery("#uploaded_files").append(obj.fileName+"<img src='${ctx }/crowdfunding/Skin/Default/images/deleteIcont.png' "+
						"title='删除' onclick='delFile("+obj.fileId+")'>&nbsp;&nbsp;&nbsp;");
			});}
			var inputid = document.getElementById("projectAfterFile");
			var jsonText = JSON.stringify(jsonall);
			inputid.value=jsonText;

	   }
	  function eachAttachdel(jsonobj){
		  var jsonobjt=eval(jsonobj);
		  jQuery("#uploaded_files").empty();
		  if(jsonobj!=""){
			  $("#_warninput3").html("");
		  jQuery.each(jsonobjt,function(key,obj){
				jQuery("#uploaded_files").append(obj.fileName+"<img src='${ctx }/crowdfunding/Skin/Default/images/deleteIcont.png' "+
						"title='删除' onclick='delFile("+obj.fileId+")'>&nbsp;&nbsp;&nbsp;");
			});		  
		  }
			var InputIds = document.getElementById("projectAfterFile");
			//var jsonText = JSON.stringify(jsonobj);
			InputIds.value=jsonobj;

	   }
	 function delFile(id){
		   var jsonString = jQuery("#projectAfterFile").val();
		   $.ajax({
				url : "${ctx}/crowdfunding/front/tcprojectinvest/uploadSurveyAttachDel.ht?time="+new Date(),
				type : 'post',
				data: "fileId="+id+"&jsonString="+jsonString+"&type=1",
				success : function(data) {
					eachAttachdel(data);	
				}
			});			

	   }
	 function closediv(){
			var list = window.parent.art.dialog.list;
			for (var i in list) {
			    list[i].close();
			};
		}
	 
	 function dosubmit(){
			
			var fileName=$("#fileName").val();
			if(fileName==''){
				
				$("#_warninput3").html("<font color='red'>请先上传附件!</font>");
				return;
			}
			
		
			
			document.getElementById("tSetHomepageForm").submit();
	}
	</script>
</body>
</html>