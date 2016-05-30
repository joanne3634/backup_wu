<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>上传资料</title>
<%@ include file="/crowdfunding/cssorjs.jsp"%>
   <script type="text/javascript" src="${ctx}/js/deelon/p2p/personalImagesAtt.js"></script>
<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/reset.css">
<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/public.css">
   <link rel="stylesheet" href="${ctx}/crowdfunding/Skin/Default/css/Userbackground.css">
      <link rel="stylesheet" href="${ctx}/crowdfunding/Skin/Default/css/bindPhone.css">
</head>
    <script type="text/javascript">
	//添加个人照片
	function picCallBack(fileIds, array) {
		
		if (!array && array != "")
			return;
		var fileId = array[0].fileId, fileName = array[0].fileName;
		//var path =  "${ctx}/platform/system/sysFile/getFileById.ht?fileId="+ fileId;
		/* if(/\w+.(png|gif|jpg)/gi.test(fileName)){
			$("#picture").val("/platform/system/sysFile/getFileById.ht?fileId=" + fileId);
			$("#personPic").attr("src",path);
		}
			
		else
			$.ligerDialog.warn("请选择*png,*gif,*jpg类型图片!"); */
		var name = fileName.toLowerCase();
		if (name.indexOf(".png") > -1 || name.indexOf(".gif") > -1
				|| name.indexOf(".jpg") > -1) {
			//	$("#picture").val("/platform/system/sysFile/getFileById.ht?fileId=" + fileId);
			//$("#personPic").attr("src", path);
		} else {
			$.ligerDialog.warn("请选择*png,*gif,*jpg类型图片!");
		}

	};
	//上传照片
	function addPic(p) {
		valiLoginTimeout('iframe');  //验证是否登录超时，跳转至登录页面
		//FlexUploadDialog({isSingle:true,callback:picCallBack});
		UploadDialogs({
			isSingle : true,
			callback : picCallBack
		},p);
	};
	function UploadDialogs(c,t) {
		if (!c) {
			c = {};
		}
		var b = _ctx + "/user/file/uploadDialog.ht?materialsId=" + t;
		var a = "dialogWidth:450px;dialogHeight:300px;help:0;status:0;scroll:1;center:1";
		b = b.getNewUrl();
		var d = window.showModalDialog(b, window, a);	
		if (d != undefined) {
			if (c.callback) {
				c.callback.call(this, d);
			}
			window.location.reload();
		}else{
			d =window.returnValue;
		}
	}
	</script>
	<style>
	.con-box-table{margin:0 auto;width:95%;}
	.con-box-table th{text-align: center;height: 40px;font-weight: bold;border: 1px solid #ccc;}
	.con-box-table td{text-align: center;height: 35px;border: 1px solid #ccc;padding:0px 5px 0px 5px;}
	</style>
<body>

		<div class="addyourproject f_l">
			<h2><img src="${ctx}/crowdfunding/Skin/Default/images/headportrait4.png">上传资料</h2>
          <table class="con-box-table">
            <tr>
              <th style="width:4%;"></th>
              <th style="width:32%;">资料类型</th>
              <th style="width:8%;">证件类型</th>
              <th style="width:8%;">图片</th>
              <th style="width:10%;">最近上传时间</th>
              <th style="width:25%;">备注说明</th>
              <th style="width:13%;">状态</th>
            </tr>
            <c:forEach items="${tlist }" var="t">
            
            
            <c:if test="${groupId==t.isType}">
              <c:if test="${t.isMust == 1 }"> <!-- 必传 -->
              <tr>
              <td ><span class="fs16"><a style="color: red;">*</a></span></td>
              <td>${t.name }</td>
              <td>
               <c:if test="${t.isType == 1 }">
              		<span>创业者</span>
              </c:if>
               <c:if test="${t.isType == 2}">
              		<span>投资者</span>
              </c:if>
              </td>
              <td><span class="color-main">(${t.count })张</span></td>
              <td><fmt:formatDate value="${t.lastTime }" pattern="yyyy-MM-dd HH:mm"/></td>
              <td>${t.reasons }</td>
              <td>
              <c:if test="${t.isPass != 1 }">
              		<a class="color-main" href="javascript:;" onclick="addPic('${t.materialsId}');"  style="color: #ff5500;">上传资料</a>
              </c:if>
               <c:if test="${t.isPass == 1}">
              		<font class="color-main">审核通过</font>
              </c:if>
              </td>
            </tr>
              </c:if>
              
			  <c:if test="${t.isMust == 0 }"><!-- 选传 -->
              <tr>
              <td ><span class="fs16"><a style="color: red;"></a></span></td>
              <td>${t.name }</td>
              <td><span class="color-main">(${t.count })张</span></td>
              <td>${t.lastTime }</td>
              <td>${t.reasons }</td>
              <td>
               <c:if test="${t.isPass != '1' }">
              		<a class="color-main" href="javascript:;" onclick="addPic('${t.materialsId}');">上传资料</a>
              </c:if>
               <c:if test="${t.isPass == '1' }">
              		<font class="color-main">审核通过</font>
              </c:if>
              </td>
            </tr>
              </c:if>
              </c:if>
            </c:forEach>
           
          </table>

        </div>
 
</body>
</html>