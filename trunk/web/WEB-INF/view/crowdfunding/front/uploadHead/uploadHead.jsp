<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
	   <script type="text/javascript" src="${ctx}/js/deelon/p2p/personalPhotoAtt.js"></script>
	    <script type="text/javascript" src="${ctx}/js/dynamic.jsp"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/util/json2.js"></script>
<script type="text/javascript" src="${ctx}/js/util/dialog.js"></script>
<script type="text/javascript" src="${ctx}/js/util/util.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/ligerui.min.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerComboBox.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/htDicCombo.js"></script>  
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerResizable.js" ></script> 
<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.htselect.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.rowOps.js"></script>

<script type="text/javascript" src="${ctx}/js/deelon/foldBox.js" ></script>
<script type="text/javascript" src="${ctx}/js/deelon/absoulteInTop.js" ></script>
<script type="text/javascript" src="${ctx }/js/upload/imgareaselect/scripts/jquery.imgareaselect.js"></script>
  	<link rel="stylesheet" href="${ctx }/crowdfunding/public.css">
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
<link rel="stylesheet" href="${ctx }/js/upload/imgareaselect/css/imgareaselect-default.css">
<script type="text/javascript">
//添加个人照片
function picCallBack(fileIds, array) {
	
	if (!array && array != "")
		return;
	var fileId = array[0].fileId, fileName = array[0].fileName;
	var path = __ctx + "/platform/system/sysFile/getFileById.ht?fileId="+ fileId;
	 if(/\w+.(png|gif|jpg)/gi.test(fileName)){
		//$("#picture").val("/platform/system/sysFile/getFileById.ht?fileId=" + fileId);
		$("#thumbnail").attr("src",path);
		//$("#photopreview").attr("src",path);
		$("#fileId").val(fileId);
		$("#fileName").val(fileName);
		$("#MoPiLeft").hide();
		$("#MoPiLeft2").show();
	}
		
	else{
		
		//$.ligerDialog.warn("请选择*png,*gif,*jpg类型图片!"); 
		window.parent.openDialog("请选择*png,*gif,*jpg类型图片!");
		return;
	}
	var name = fileName.toLowerCase();
	if (name.indexOf(".png") > -1 || name.indexOf(".gif") > -1
			|| name.indexOf(".jpg") > -1) {
		//	$("#picture").val("/platform/system/sysFile/getFileById.ht?fileId=" + fileId);
		$("#personPic").attr("src", path);
	} else {
		window.parent.openDialog("请选择*png,*gif,*jpg类型图片!");
		//$.ligerDialog.warn("请选择*png,*gif,*jpg类型图片!");
	}

};
//上传照片
function addPic() {
	//FlexUploadDialog({isSingle:true,callback:picCallBack});
	DirectUploadDialog({
		isSingle : true,
		callback : picCallBack
	});
};



var picwidth, picheight;
function preview(img, selection) { 
	//150和200这两个值来源于你图片预览区域的尺寸，对应下面aspectRatio: '3:4'这个比例,尺寸和比例可按照指定要求修改
	//var scaleX = 150 / selection.width; 
	//var scaleY = 200 / selection.height; 

	//$('#photopreview').css({ 
	//	width: Math.round(scaleX * picwidth) + 'px', 
	//	height: Math.round(scaleY * picheight) + 'px',
	//	marginLeft: '-' + Math.round(scaleX * selection.x1) + 'px', 
	//	marginTop: '-' + Math.round(scaleY * selection.y1) + 'px' 
	//});
	$('#x1').val(selection.x1);
	$('#y1').val(selection.y1);
	$('#x2').val(selection.x2);
	$('#y2').val(selection.y2);
	$('#w').val(selection.width);
	$('#h').val(selection.height);
} 

$(document).ready(function () { 
	$('#save_thumb').click(function() {
		var x1 = $('#x1').val();
		var y1 = $('#y1').val();
		var x2 = $('#x2').val();
		var y2 = $('#y2').val();
		var w = $('#w').val();
		var h = $('#h').val();
		if(x1=="" || y1=="" || x2=="" || y2=="" || w=="" || h==""){
			//alert("请您拖动鼠标进行裁切!");
			window.parent.openDialog("请您拖动鼠标进行裁切");
			return false;
		}else{
			return true;
		}
	});
}); 

$(window).load(function () { 
	$('#thumbnail').imgAreaSelect({ aspectRatio: '1:1', onSelectChange: preview }); 
	picwidth = $("#thumbnail").width();
	picheight = $("#thumbnail").height();
});


/**
 * 摄像头上传头像开始。。。。
 */

function openSheXiangTou(){
	var html = '<EMBED height="464" type="application/x-shockwave-flash"';
	html += 'pluginspage="http://www.macromedia.com/go/getflashplayer" width="480"';
	html += 'src="${ctx }/AvatarEditor.swf" quality="high" allowscriptaccess="always"';
	html += 'flashvars="type=camera&amp;postUrl=${ctx}/crowdfunding/upload/saveSheXiangTou.ht?radom=1&amp;saveUrl=${ctx}/crowdfunding/upload/saveSheXiangTou.ht?radom=2"></EMBED>	';
	$("#MoPiLeft").html(html);
}

/**
 * 提供给FLASH的接口 ： 没有摄像头时的回调方法
 */
function noCamera() {
	window.parent.openDialog("该电脑没有摄像头设备");
	setTimeout('window.location = "${ctx}/crowdfunding/upload/uploadHeadPage.ht";',2000);
	
}

/**
 * 提供给FLASH的接口：编辑头像保存成功后的回调方法
 */
function avatarSaved() {
	//这里需跳转到别的页面去
	//alert('保存成功');
	//window.parent.openDialog("保存成功","30%","30%");
	setTimeout('window.parent.location = "${ctx}/loan/myAccount/myaccountPage.ht";',2000);
}

/**
 * 提供给FLASH的接口：编辑头像保存失败的回调方法, msg 是失败信息，
 * 可以不返回给用户, 仅作调试使用.
 */
function avatarError(msg) {
	//alert(msg);
	//window.parent.openDialog(msg,"30%","30%");
	setTimeout('window.location = "${ctx}/crowdfunding/upload/uploadHeadPage.ht";',2000);
}




/**
 * 摄像头上传头像结束。。。。
 */
</script>
<body>
		<div class="addyourproject f_l">
			<h2><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">修改头像</h2>
			<div class="ModifyPicture">
					<div class="MoPiLeft f_l" id="MoPiLeft">
						<div><img src="${ctx }/crowdfunding/Skin/Default/images/Uploadpicture.png" onclick="addPic();"></div>
						<img onclick="openSheXiangTou();" src="${ctx }/crowdfunding/Skin/Default/images/Uploadpicture2.png">	
			
					</div>
					<div class="MoPiLeft f_l" id="MoPiLeft2" style="display: none;">
						<form name="thumbnail" action="${ctx }/cut.jsp" method="post">
						<img src="" style="float: left; margin-right: 10px;" id="thumbnail"
						alt="按住鼠标拖动进行裁剪" width="400" height="400"/>
						<%--<div style="float: left; position: relative; overflow: hidden; width: 150px; height: 150px;">
						<img id="photopreview" src="" width="100" height="100" style="position: relative;" alt="Thumbnail Preview" />
						</div>
						--%><input type="hidden" name="x1" value="" id="x1" />
						<input type="hidden" name="y1" value="" id="y1" />
						<input type="hidden" name="x2" value="" id="x2" />
						<input type="hidden" name="y2" value="" id="y2" />
						<input type="hidden" name="width" value="" id="w" />
						<input type="hidden" name="height" value="" id="h" />
						<input type="hidden" name="fileId" id="fileId" value="" />
						<input type="hidden" name="fileName" id="fileName" value="" />
						<input type="hidden" name="cutdivWidth" id="cutdivWidth" value="400" />
						<input type="hidden" name="cutdivHeight" id="cutdivWidth" value="400" />
						<input type="submit" class="button" name="upload_thumbnail" value="保存头像" id="save_thumb" style="width:120px;height:30px" />			
						</form>
					</div>
				<div class="MoPiRight f_l">
						<c:if test="${empty user.myPhoto }">
							<div><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait3.png" id="MoPiRightImg1"></div>头像100 x 100
							<div><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait3.png" id="MoPiRightImg2"></div>头像90 x 90
							<div><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait3.png" id="MoPiRightImg3"></div>头像45 x 45
							<div><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait3.png" id="MoPiRightImg4"></div>头像30 x 30
						</c:if>
						<c:if test="${not empty user.myPhoto }">
							<div><img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${user.myPhoto}" id="MoPiRightImg1" height="100" width="100"></div>头像100 x 100
							<div><img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${user.myPhoto}" id="MoPiRightImg2" height="90" width="90"></div>头像90 x 90
							<div><img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${user.myPhoto}" id="MoPiRightImg3" height="45" width="45"></div>头像45 x 45
							<div><img src="${ctx }/crowdfunding/upload/getFileById.ht?path=${user.myPhoto}" id="MoPiRightImg4" height="30" width="30"></div>头像30 x 30
						</c:if>
				</div>
			</div>
		</div>

