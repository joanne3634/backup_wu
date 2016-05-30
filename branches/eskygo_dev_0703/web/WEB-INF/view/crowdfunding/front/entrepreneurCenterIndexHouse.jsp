<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>会员后台</title>
	<meta name="renderer" content="webkit"/>
	<%@include file="/commons/include/form.jsp" %> 
  	<%@ include file="/crowdfunding/cssorjs.jsp"%>
  	<link href="${ctx}/js/jquery/plugins/attach.css" rel="stylesheet" />
	<link href="${ctx}/js/jquery/plugins/jquery.qtip.min.css" rel="stylesheet" />
	<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.qtip.min.js" ></script>
	<script type="text/javascript" src="${ctx}/crowdfunding/js/jquery.attach.HelpCenter.js" ></script>
   <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
    <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/ProjectDynamic.css">
    <style type="text/css">
    	h4 {
    		text-align: left;
			color: #ff5500;
			font-size: 16px;
			border-bottom: 1px dashed #bcbcbc;
			line-height: 40px;
			margin-bottom: 20px;
    	}
    </style>
</head>
<body>
				<div class="addyourproject f_l">
			<h2><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">我的项目资料<a href="javascript:show();"  style="color:red;" >>>项目商业计划书撰写指南（项目方融资必看）</a></h2>
			<c:if test="${tcproject.pstateId!=2 and tcproject.pstateId!=3}"><div class="hint">温馨提示：请完整填写您的项目资料，填写完整后，页面底部将会出现提交审核按钮，点击提交才能进行项目审核！</div></c:if>
			<c:if test="${tcproject.pstateId==9}"><div class="hint"><font color="red">审核不通过！</font>审核意见：${tcproject.pcheckRemark}</div></c:if>
			<table  cellpadding="0" cellspacing="1" border="0" class="addyourprojectTable">
				<c:if test="${tcproject.pstateId==0 or tcproject.pstateId==9}"><tr><td colspan="3"><a href="${ctx }/crowdfunding/tcproject/editorTcproject.ht?projectId=${tcproject.projectId}" class="edit"><img src="${ctx }/crowdfunding/Skin/Default/images/editIcont.png">编辑</a></td></tr></c:if>
				<tr><td width="160"><span>项目名称：</span></td><td colspan="2" class="projectNameTD">${tcproject.pname}<span><img src="${ctx }/crowdfunding/Skin/Default/images/editIcont2.png">
				<%-- <c:if test="${tcproject.pstateId==3}">询价众筹中</c:if><c:if test="${tcproject.pstateId!=3}">资料完善中</c:if> --%>
				<c:if test=""></c:if>
				<c:choose>
					<c:when test="${tcproject.pstateId eq 0}">未提交申请</c:when>
					<c:otherwise>
					<f:description nodeKey="xmzt" itemValue="${tcproject.pstateId}"></f:description>
					</c:otherwise>
				</c:choose>
				</span></td></tr>
				<tr><td><span>项目方：</span></td><td colspan="2">${tuser.realName}</td></tr>
				<tr><td><span>项目资料查看期限：</span></td><td colspan="2"><c:if test="${tcproject.pviewLimit==1}">所有用户需先申请经我批准后才可看</c:if><c:if test="${tcproject.pviewLimit==0}">所有登录用户可看</c:if></td></tr>
				<tr><td><span>项目类别：</span></td><td><f:description nodeKey="XMLX"  itemValue="${tcproject.ptypeId}"/> <span>是否有其他项目：</span></td><td width="260"><f:description nodeKey="sf"  itemValue="${tcproject.pisHaveOther}"/> </td></tr>
				<tr><td><span>项目所属行业：</span></td><td><f:description nodeKey="PIND"  itemValue="${tcproject.pindustry}"/> <span>项目标签：</span></td><td>${tcproject.plabel} </td></tr>
				<tr><td><span>项目所属阶段：</span></td><td><f:description nodeKey="PTYPE"  itemValue="${tcproject.pstage}"/> <span>企业成立时间：</span></td><td>${tcproject.pfoundedYear}年${tcproject.pfoundedMonth}月</td></tr>
				<tr><td><span>企业员工人数：</span></td><td>${tcproject.pemployeesCount}人<span>企业所在城市：</span></td><td>${tcproject.pprovincesName}${tcproject.pcityIname} </td></tr>
				<tr><td><span>企业名称：</span></td><td>${tcproject.pcompanyName}<span>办公地址：</span></td><td>${tcproject.paddress}</td></tr>
				<tr><td><span>项目估值￥：</span></td><td colspan="2"><fmt:formatNumber value="${tcproject.pvaluationFinal}" pattern="###,###.##"  minFractionDigits="0" ></fmt:formatNumber>万</td></tr>
				<tr><td><span>融资金额￥：</span></td><td colspan="2"><fmt:formatNumber value="${tcproject.pfinancingAmount/10000}" pattern="###,###.##"  minFractionDigits="0" ></fmt:formatNumber>万</td></tr>
				<tr><td><span>已认投金额：</span></td><td colspan="2"><fmt:formatNumber value="${tcproject.pinvestAmount/10000}" pattern="###,###.##"   minFractionDigits="0" ></fmt:formatNumber>万 </td></tr>
				<tr><td><span>投资款拨付方式：</span></td><td><f:description nodeKey="TZKPT"  itemValue="${tcproject.ppayWay}"/> <span>认投完成率：</span></td><td>${tcproject.pcomplete}%</td></tr>
				<tr><td><span>最低投资金额：</span></td><td colspan="2">最低领投金额<fmt:formatNumber value=" ${tcproject.pinvestMinLeader/10000}" pattern="###,###.##"  minFractionDigits="0"  ></fmt:formatNumber>万元，最低跟投金额<fmt:formatNumber value="${tcproject.pinvestMinFollow/10000}" pattern="###,###.##"  minFractionDigits="0"  ></fmt:formatNumber>万元</td></tr>
				<tr><td><span>企业项目简介：</span></td><td colspan="2" width="500">${tcproject.pdetail}</td></tr>
				<tr><td><span>项目图片：</span></td><td colspan="2"> <pageTag:projectPic menupath="${tcproject.projectId}"/></td></tr>
				<tr><td colspan="3" onclick="returnArtDialog()" class="video"><c:if test="${empty tcproject.pvideo}">暂未上传项目视频！    项目审核完成后不能</c:if>点击此处更改项目视频！</td></tr>
			</table>
			
			<div class="patternPaymentNav">
				<input id="type" type="hidden"/>
				<ul>
					<li class="PaPaNavChecked">市场定位与商业模式</li>
					<li>项目附件</li>
					<li>项目动态</li>
				</ul>
			</div>
			<div class="TagContent">
			<c:if test="${tcproject.pstateId==0 or tcproject.pstateId==9 }">
			<a href="javascript:editInfo();" class="edit"><img src="${ctx }/crowdfunding/Skin/Default/images/editIcont.png">编辑</a>			
			</c:if>
			<div class="innovationTagContent">
				<div class="clear addyourprojectList TagContentList">
					<c:if test="${not empty tcprojectModel.pmtargeted }">
						<div class="InPrlist">
							<h3><span>1</span>众筹产品</h3>
							<p>${tcprojectModel.pmtargeted }</p>
							
						</div>
					</c:if>
					<c:if test="${not empty tcprojectModel.pmcurrentlyPlaguing }">
						<div class="InPrlist">
							<h3><span>2</span>总体规划</h3>
							<div><p>${tcprojectModel.pmcurrentlyPlaguing }</p></div>
							
							
						</div>
					</c:if>
					<c:if test="${not empty tcprojectModel.pmservicesMode }">
						<div class="InPrlist">
							<h3><span>3</span>地理位置</h3>
							<div>${tcprojectModel.pmservicesMode }</div>
							
						</div>
					</c:if>
					<c:if test="${not empty tcprojectModel.pmprofitableDesc }">
						<div class="InPrlist">
							<h3><span>4</span>建设进度</h3>
							<div>${tcprojectModel.pmprofitableDesc }</div>
							
						</div>
					</c:if>
					<c:if test="${not empty tcprojectModel.pmcompetitors }">
						<div class="InPrlist">
							<h3><span>5</span>价格走势</h3>
							<div>${tcprojectModel.pmcompetitors }</div>
							
						</div>
					</c:if>
					<c:if test="${not empty tcprojectModel.pmcoreCompetitiveness }">
						<div class="InPrlist">
							<h3><span>6</span>公司介绍</h3>
							<div>${tcprojectModel.pmcoreCompetitiveness }</div>
							
						</div>
					</c:if>
					<c:if test="${empty tcprojectModel.pmtargeted}">
						 <div  class="hint">暂无内容!</div>
					 </c:if>
				</div>

				<!--项目附件  -->
				<div class="TagContentList">
						<div class="InPrlist">
						</div>
						<div style="font-size:16px">
							<ul>
					<c:choose>
					<c:when test="${tcproject.pstateId ==0 or tcproject.pstateId==9 }">
					<c:forEach items="${listA }" var="vo" varStatus="i">
					<li>
							<a href="${ctx}/crowdfunding/front/downloadFile.ht?fileId=${vo.attachmentId}" target="_blank">
								${vo.pafileName}</a>
								<img alt="" src="${ctx}/styles/default/images/resicon/del.png" onclick="delAttach('${vo.attachmentId}')">
					</li>	
								</c:forEach>
					</c:when>
					<c:otherwise>
					<c:forEach items="${listA }" var="vo" varStatus="i">
					<li>
					<a href="${ctx}/crowdfunding/front/downloadFile.ht?fileId=${vo.attachmentId}" target="_blank">
								${vo.pafileName}</a>
					</li>
								</c:forEach>
					</c:otherwise>
					</c:choose>
						</li>
					
						</ul>
						</div>
						<c:if test="${empty listA }">
									<div  class="hint">暂无内容!</div>
							</c:if>
					</div>
				<!-- 项目附件end  -->
				<!-- 项目动态 -->
				<div class="ProjectDynamicLeft f_l TagContentList">
					<ul>
					<c:forEach items="${listN }" var="vo">
						<li>
							<c:if test="${empty vo.fileId}">
							<img src="${ctx }/crowdfunding/Skin/Default/images/ProjectDynamic.png" class="f_l">   <!-- 项目动态图片,默认图片  -->
							</c:if>	
							<c:if test="${!empty vo.fileId}">
							<pageTag:ProjectDynamic menupath="${vo.fileId}"/>   <!-- 项目动态图片  -->
							</c:if>
							<div class="ProjectDynamicName f_l">
								<h4><a title="${vo.pntitle }" href="${ctx }/tcproject/ProjectDynamic/edit.ht?newsId=${vo.newsId }">
								<c:if test="${fn:length(vo.pntitle) > 20 }">
								   ${fn:substring(vo.pntitle,0,20) }...
							    </c:if>
							    <c:if test="${fn:length(vo.pntitle) <= 20 }">
								   ${vo.pntitle }
							    </c:if>
								</a></h4>
								<!-- <div><img src="./Skin/Default/images/trianglegray.png">项目:【嘻哈公园 舞蹈音乐文化服务平台】<span><a href="">>>本项目所有动态</a></span></div> -->
								<p>
								<c:if test="${fn:length(vo.pncontent) > 105 }">
									${fn:substring(vo.pncontent,0,105) }...
								</c:if>
								<c:if test="${fn:length(vo.pncontent) <= 105 }">
									${vo.pncontent }
								</c:if>							
								</p>
								<p><img src="${ctx }/crowdfunding/Skin/Default/images/time.png">开标时间：<fmt:formatDate value="${vo.createTime }" pattern="yyyy-MM-dd HH:mm"/></p>
							</div>
							<div class="clear"></div>
						</li>
					</c:forEach>
					</ul>
						<c:if test="${empty listN }">
									<div  class="hint">暂无内容!</div>
						</c:if>
					</div>
				<!-- 项目动态end -->
		</div>
		</div>
		</div>
		<%-- <c:if test="${tcproject.pstateId==1 or tcproject.pstateId==2 or tcproject.pstateId==7}"> --%>
		<c:if test="${tcproject.pstateId==0 or tcproject.pstateId==9}"><!-- =9是项目初审被拒绝后的状态  -->
		<c:if test="${empty ok}"> 
		<div class="SubmitData" onclick="sumbmitTcproject()"><span>我已完善资料并提交审核</span>
		</div><br><br>
		</c:if></c:if>
	<script type="text/javascript">
	function returnArtDialog(){
		//0:已保存未提交；1：已提交；2：初审中；9：初审未通过
		if('${tcproject.pstateId}'=='0'||'${tcproject.pstateId}'=='1'||'${tcproject.pstateId}'=='2'||'${tcproject.pstateId}'=='9'){
		var dialog = art.dialog({
		    title: '添加视频',
		    //width:'300px',top:'100px',height:'200px',
			content: "请填写项目网络视频路径：<br/><input id='video' value='${tcproject.pvideo}' style=' width: 350px'/>",
			icon: 'succeed',
		    follow: document.getElementById('btn2'),
		    ok: function(){
		    	if($("#video").val()){
		    		var value = $("#video").val();
		    		/* this.title('提示').content('视频信息已保存，请等待审核！').lock().time(2); */
		    		this.title('提示').content('视频信息已保存！').lock().time(2);
		    		window.location.href="${ctx }/crowdfunding/tcproject/sumbmitTcproject.ht?pvideo="+value+"&projectId=${tcproject.projectId}";
			        return false;
		    	}
		    }
		});
		}else{
			if('${tcproject.pstateId}'=='7'){
				window.parent.art.dialog('项目已经流标，不能再添加项目视频。').lock().time(1);
			}else{
				
				window.parent.art.dialog('项目已通过平台审核，暂时不能添加项目视频。').lock().time(1);
			}
		}
	}
	function show(){
		var url='${ctx }/loan/aboutus/HelpCenterDetails.ht?menupath=CYZ';
		$.dialog.open(url, {
			title: '项目方必看',lock:true,width:'880px',top:'100px',height:'400px',close:function(){
				window.location.reload(false);
			}
		});
	}
	function sumbmitTcproject(){
		var dialog = art.dialog({
		    title: '提示',
		    //width:'300px',top:'100px',height:'200px',
			content: "项目已提交，请等待平台通过审核。",
			icon: 'succeed',
		    follow: document.getElementById('btn2'),
		    ok: function(){
		    	window.location.href="${ctx }/crowdfunding/tcproject/sumbmitTcproject.ht?projectId=${tcproject.projectId}";
			    return false;
		    }
		});
	}
	 function picCallBack(fileIds, array) {
			
			art.dialog('项目附件添加成功。').lock().time(2); 
			window.location.reload();

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
			var b = __ctx + "/crowdfunding/tcprojectAfter/projectAfterUploadDialog.ht?projectId=${tcproject.projectId}";
			var a = "dialogWidth:450px;dialogHeight:300px;help:0;status:0;scroll:1;center:1";
			b = b.getNewUrl();
			var d = window.showModalDialog(b, "", a);
			//alert(d);
			if (d != undefined) {
				if (c.callback) {
					c.callback.call(this, d);
				}
			}
		}
	function editInfo(){
		if($("#type").val()==1){
			if('${tcproject.pstateId}'=='0'||'${tcproject.pstateId}'=='9'||'${tcproject.pstateId}'=='3'){
				addPic('${projectId}');
			}else{
				art.dialog('项目已经提交，已提交的项目不能再编辑，除非项目被打回！').lock();
			}
		}else if($("#type").val()==2){
			if('${tcproject.pstateId}'=='0'||'${tcproject.pstateId}'=='9'||'${tcproject.pstateId}'=='3'){
				window.location.href="${ctx }/tcproject/ProjectDynamic/ProjectDynamicBackList.ht?projectId=${tcproject.projectId}";
			}else{
				art.dialog('项目未通过平台审核，暂时不能添加项目动态。').lock();
			}
		}else{
			if('${tcproject.pstateId}'=='0'||'${tcproject.pstateId}'=='9'||'${tcproject.pstateId}'=='3'){
				window.location.href="${ctx }/crowdfunding/tcproject/editorModels.ht?projectId=${tcproject.projectId}";
			}else{
				art.dialog('项目已经提交，已提交的项目不能再编辑，除非项目被打回！').lock();
			}
		}
	}
		
	function delAttach(attachId){
		art.dialog.confirm("您确定删除吗",function(){
			$.ajax({
				url : "${ctx}/crowdfunding/front/delAttachment.ht",
				type : 'post',
				data: "ids="+attachId,
				success : function(data) {
					art.dialog("  "+data+"  ").lock().time(2); 
					window.location.reload();
				}
			});	
	 		},function(){});
		}
	$(function(){
		//window.location.href="#";
		window.parent.scrollTo(1200, 300);
		$(".innovationTagContent .TagContentList").eq(0).css("display","block");
		$(".patternPaymentNav li").click(function(){
			  $(this).addClass('PaPaNavChecked').siblings().removeClass('PaPaNavChecked');
			  var _index=$(this).index();
			  $("#type").val(_index);
			  setTimeout(window.parent.iFrameHeight, "1000");
			  $(".innovationTagContent .TagContentList").css("display","none");
			  $(".innovationTagContent .TagContentList").eq(_index).css("display","block");
		});
		$("#pic").attr("style","width:224px; height:132px;");
	})
	</script>
</body>
</html>
