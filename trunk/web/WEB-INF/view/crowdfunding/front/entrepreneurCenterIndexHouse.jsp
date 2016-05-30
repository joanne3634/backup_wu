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
			<h2><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">我的项目资料<a href="javascript:show();"  style="color:red;" >>>项目商业计划书撰写指南（创业者融资必看）</a></h2>
			<c:if test="${tcproject.pstateId!=2 and tcproject.pstateId!=3}"><div class="hint">温馨提示：请完整填写您的项目资料，填写完整后，页面底部将会出现提交审核按钮，点击提交才能进行项目审核！</div></c:if>
			<c:if test="${tcproject.pstateId==2 or tcproject.pstateId==7}"><div class="hint"><font color="red">审核不通过！</font>审核意见：${tcproject.pbreakRemark}</div></c:if>
			<table  cellpadding="0" cellspacing="1" border="0" class="addyourprojectTable">
				<c:if test="${tcproject.pstateId==0 or tcproject.pstateId==2 or tcproject.pstateId==9}"><tr><td colspan="3"><a href="${ctx }/crowdfunding/tcproject/editorTcproject.ht?projectId=${tcproject.projectId}" class="edit"><img src="${ctx }/crowdfunding/Skin/Default/images/editIcont.png">编辑</a></td></tr></c:if>
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
				<tr><td><span>创业者：</span></td><td colspan="2">${tuser.realName}</td></tr>
				<tr><td><span>项目资料查看期限：</span></td><td colspan="2"><c:if test="${tcproject.pviewLimit==1}">所有用户需先申请经我批准后才可看</c:if><c:if test="${tcproject.pviewLimit==0}">所有登录用户可看</c:if></td></tr>
				<tr><td><span>项目类别：</span></td><td><f:description nodeKey="XMLX"  itemValue="${tcproject.ptypeId}"/> <span>是否有其他项目：</span></td><td width="260"><f:description nodeKey="sf"  itemValue="${tcproject.pisHaveOther}"/> </td></tr>
				<tr><td><span>项目所属行业：</span></td><td><f:description nodeKey="PIND"  itemValue="${tcproject.pindustry}"/> <span>项目标签：</span></td><td>${tcproject.plabel} </td></tr>
				<tr><td><span>项目所属阶段：</span></td><td><f:description nodeKey="PTYPE"  itemValue="${tcproject.pstage}"/> <span>企业成立时间：</span></td><td>${tcproject.pfoundedYear}年${tcproject.pfoundedMonth}月</td></tr>
				<tr><td><span>企业员工人数：</span></td><td>${tcproject.pemployeesCount}人<span>企业所在城市：</span></td><td>${tcproject.pcityIname} </td></tr>
				<tr><td><span>企业名称：</span></td><td>${tcproject.pcompanyName}<span>办公地址：</span></td><td>${tcproject.paddress}</td></tr>
				<tr><td><span>项目估值￥：</span></td><td colspan="2"><fmt:formatNumber value="${tcproject.pvaluationFinal}" pattern="###,###.##"  minFractionDigits="0" ></fmt:formatNumber>万</td></tr>
				<tr><td><span>融资金额￥：</span></td><td colspan="2"><fmt:formatNumber value="${tcproject.pfinancingAmount/10000}" pattern="###,###.##"  minFractionDigits="0" ></fmt:formatNumber>万</td></tr>
				<tr><td><span>已认投金额：</span></td><td colspan="2"><fmt:formatNumber value="${tcproject.pinvestAmount/10000}" pattern="###,###.##"   minFractionDigits="0" ></fmt:formatNumber>万 </td></tr>
				<tr><td><span>投资款拨付方式：</span></td><td><f:description nodeKey="TZKPT"  itemValue="${tcproject.ppayWay}"/> <span>认投完成率：</span></td><td>${tcproject.pcomplete}%</td></tr>
				<tr><td><span>最低投资金额：</span></td><td colspan="2">最低领投金额<fmt:formatNumber value=" ${tcproject.pinvestMinLeader/10000}" pattern="###,###.##"  minFractionDigits="0"  ></fmt:formatNumber>万元，最低跟投金额<fmt:formatNumber value="${tcproject.pinvestMinFollow/10000}" pattern="###,###.##"  minFractionDigits="0"  ></fmt:formatNumber>万元</td></tr>
				<tr><td><span>企业项目简介：</span></td><td colspan="2" width="500">${tcproject.pdetail}</td></tr>
				<tr><td><span>项目图片：</span></td><td colspan="2"> <pageTag:projectPic menupath="${tcproject.projectId}"/></td></tr>
				<tr><td colspan="3" onclick="returnArtDialog()" class="video"><c:if test="${empty tcproject.pvideo}">暂未上传项目视频！    项目审核完成前不能</c:if>点击此处更改项目视频！</td></tr>
			</table>
			
			<div class="patternPaymentNav">
				<input id="type" type="hidden"/>
				<ul>
					<li class="PaPaNavChecked">商业模式</li>
					<%--<li>创业团队</li>
					<li>历史情况</li>
					<li>未来计划</li>--%>
					<li>项目附件</li>
					<li>项目动态</li>
				</ul>
			</div>
			<div class="TagContent">
			<c:if test="${tcproject.pstateId==0 or tcproject.pstateId==2 or tcproject.pstateId==9 }">
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
				<!--团队  -->
				<%--<div class="Entrepreneurial TagContentList">
						<div class="InPrlist">
						
						<c:if test="${not empty listT }">
							<h3><span>1</span>股东团队说明</h3>
							<div class="InPrlistTable">
								<table border="0" cellspacing="1" cellpadding="0">
									<tr>
										<th width="90">姓名</th>
										<th width="120">职务</th>
										<th width="90">是否全职</th>
										<th width="105">所占股份(%)</th>
										<th width="150">实际出资金额</th>
										<th width="220">与其他股东历史关系描述</th>
									</tr>
									<c:forEach items="${listT }" var="vo">
									<c:if test="${vo.pttypeId eq '1' }">
									<tr>
										<td>${vo.ptname}</td>
										<td>${vo.ptduty}</td>
										<td><f:description nodeKey="sf" itemValue="${vo.ptmisFullTime }"></f:description></td>
										<td>${vo.pttheShare}</td> 
										<td>${vo.ptrealPay}</td>
										<td>${vo.ptrelationship}</td>
									</tr>
									</c:if>
									</c:forEach>	
								</table>
								<c:forEach items="${listT }" var="vo">
								<c:if test="${vo.pttypeId eq '1' }">
									<h4><span>${vo.ptname}</span>股东详细介绍</h4>
									${vo.ptmemberInfo} 
								</c:if>
								</c:forEach>
							</div>
							<h3><span>2</span>非股东管理团队</h3>
							<div class="InPrlistTable">
								<table border="0" cellspacing="1" cellpadding="0">
									<tr>
										<th width="90">姓名</th>
										<th width="120">职务</th>
										<th width="90">是否全职</th>
										<!-- <th width="105">所占股份(%)</th> -->
										<th width="150">入职时间</th>
										<th width="220">与创始团队成员历史关系</th>
									</tr>
								<c:forEach items="${listT }" var="vo">
								<c:if test="${vo.pttypeId eq '0' }">
									<tr>
										<td>${vo.ptname}</td>
										<td>${vo.ptduty}</td>
										<td><f:description nodeKey="sf" itemValue="${vo.ptmisFullTime }"></f:description></td>
										<%-- <td>${vo.pttypeId}</td> --%>
										<%--<td>${vo.ptentryTime}</td>
										<td>${vo.ptrelationship}</td>
									</tr>
								</c:if>
								</c:forEach>
									
								</table>
								<c:forEach items="${listT }" var="vo">
								<c:if test="${vo.pttypeId eq '0' }">
									<h4><span>${vo.ptname}</span>股东详细介绍</h4>
									${vo.ptmemberInfo} 
								</c:if>
								</c:forEach>
							</div></c:if>
						</div>
						<c:if test="${empty listT }">
									<div  class="hint">暂无内容!</div>
						</c:if>
					</div>--%>
				<!--团队end  -->
				<!--历史情况  -->
				<%--<div class="Diachronic TagContentList">
						<div class="InPrlist">
						
						<c:forEach items="${listH }" var="vo" varStatus="i">
							<h3><span>${i.count }</span>第${i.count }阶段</h3>
							<div class="PrHiDataList">
								<ul>
									<li><span>1、阶段名称：</span>${vo.phpname }</li>
									<li class="PrHiDataListSelect"><span>2、起止时间：</span>${vo.phpstartYear }年${vo.phpstartMonth }月--${vo.phpendYear }年${vo.phpendMonth }月</li>
									<li><span>3、阶段达成目标描述：</span>
										${vo.phptargetDesc }
									</li>
									<li><span>4、完成阶段目标的主要措施、方法、手段：</span>
										${vo.phptargetWay }
									</li>
									
									<li><span>5、阶段收入：</span>
									</li>
								<div class="InPrlistTable">
									<table border="0" cellspacing="1" cellpadding="0">
								
									<tr>
										<th width="33%">收入类别</th>
										<th width="33%">收入金额￥</th>
										<th width="33%">备注</th>
									</tr>
									<c:forEach items="${vo.listHpPayMent }" var="payM">
									<c:if test="${payM.hpptypeId eq '1' }">
										<tr class="InPrlistTr">
											<td>${payM.hppkindName }</td>
											<td><fmt:formatNumber value="${payM.hpppayment }" pattern="###,###.##"   minFractionDigits="2" /></td>
											<td>${payM.hppremarks }</td>
										</tr>
									</c:if>
									</c:forEach>
									</table>
								
								</div>
									<li><span>6、阶段开支：</span>
									</li>
										<div class="InPrlistTable">
									<table border="0" cellspacing="1" cellpadding="0">
								
									<tr>
										<th width="33%">费用类别</th>
										<th width="33%">开支金额￥</th>
										<th width="33%">备注</th>
									</tr>
									<c:forEach items="${vo.listHpPayMent }" var="payM">
									<c:if test="${payM.hpptypeId eq '2' }">
										<tr class="InPrlistTr">
											<td>${payM.hppkindName }</td>
											<td><fmt:formatNumber value="${payM.hpppayment }" pattern="###,###.##"   minFractionDigits="2" /></td>
											<td>${payM.hppremarks }</td>
										</tr>
									</c:if>
									</c:forEach>
									</table>
								
								</div>
								</ul>
							</div>
						</c:forEach>
						<c:if test="${not empty listH }">
							<div class="cumulative">
							<span>累计盈亏：</span>
							<div class="InPrlistTable">
								<table border="0" cellspacing="1" cellpadding="0">
									<tr>
										<th width="33%">累计收入金额￥</th>
										<th width="33%">累计开支金额￥</th>
										<th width="33%">累计盈亏金额￥</th>
									</tr>
									<tr class="InPrlistTr">
										<td><fmt:formatNumber value="${hmoneyIn }" pattern="###,###.##"   minFractionDigits="2" /></td>
										<td><fmt:formatNumber value="${hmoneyOut }" pattern="###,###.##"   minFractionDigits="2" /></td>
										<td><fmt:formatNumber value="${hmoneyIn-hmoneyOut }" pattern="###,###.##"   minFractionDigits="2" /></td>
									</tr>
								</table>
							</div>
						</div></c:if>
						</div>
						<c:if test="${empty listH }">
									<div  class="hint">暂无内容!</div>
						</c:if>
					</div>--%>
				<!--历史情况end  -->
				
				<!-- 未来计划 -->
				<%--<div class="FuturePlans TagContentList">
						<div class="InPrlist">
						
						<c:forEach items="${listP }" var="vo" varStatus="i">
							<h3><span>${i.count }</span>第${i.count }阶段</h3>
							<div class="PrHiDataList">
								<ul>
									<li><span>1、阶段名称：</span>${vo.phpname }</li>
									<li class="PrHiDataListSelect"><span>2、起止时间：</span>${vo.phpstartYear }年${vo.phpstartMonth }月--${vo.phpendYear }年${vo.phpendMonth }月</li>
									<li><span>3、阶段达成目标描述：</span>
										${vo.phptargetDesc }
									</li>
									<li><span>4、完成阶段目标的主要措施、方法、手段：</span>
										${vo.phptargetWay }
									</li>
									<li><span>5、阶段收入：</span>
									</li>
									<div class="InPrlistTable">
									<table border="0" cellspacing="1" cellpadding="0">
								
									<tr>
										<th width="33%">收入类别</th>
										<th width="33%">收入金额￥</th>
										<th width="33%">备注</th>
									</tr>
									<c:forEach items="${vo.listHpPayMent }" var="payM">
									<c:if test="${payM.hpptypeId eq '1' }">
										<tr class="InPrlistTr">
											<td>${payM.hppkindName }</td>
											<td><fmt:formatNumber value="${payM.hpppayment }" pattern="###,###.##"   minFractionDigits="2" /></td>
											<td>${payM.hppremarks }</td>
										</tr>
									</c:if>
									</c:forEach>
									</table>
								
								</div>
									<li><span>6、阶段开支：</span>
									</li>
									<div class="InPrlistTable">
									<table border="0" cellspacing="1" cellpadding="0">
								
									<tr>
										<th width="33%">费用类别</th>
										<th width="33%">开支金额￥</th>
										<th width="33%">备注</th>
									</tr>
									<c:forEach items="${vo.listHpPayMent }" var="payM">
									<c:if test="${payM.hpptypeId eq '2' }">
										<tr class="InPrlistTr">
											<td>${payM.hppkindName }</td>
											<td><fmt:formatNumber value="${payM.hpppayment }" pattern="###,###.##"   minFractionDigits="2" /></td>
											<td>${payM.hppremarks }</td>
										</tr>
									</c:if>
									</c:forEach>
									</table>
								
								</div>
								</ul>
							</div>
						</c:forEach>
						<c:if test="${not empty listP }">
								
							<div class="cumulative">
							<span>累计盈亏：</span>
							<div class="InPrlistTable">
								<table border="0" cellspacing="1" cellpadding="0">
									<tr>
										<th width="33%">累计收入金额￥</th>
										<th width="33%">累计开支金额￥</th>
										<th width="33%">累计盈亏金额￥</th>
									</tr>
									<tr class="InPrlistTr">
										<td><fmt:formatNumber value="${fmoneyIn }" pattern="###,###.##"   minFractionDigits="2" /></td>
										<td><fmt:formatNumber value="${fmoneyOut }" pattern="###,###.##"   minFractionDigits="2" /></td>
										<td><fmt:formatNumber value="${fmoneyIn-fmoneyOut }" pattern="###,###.##"   minFractionDigits="2" /></td>
									</tr>
								</table>
							</div>
						</div></c:if>
						</div>
						<c:if test="${empty listP }">
									<div  class="hint">暂无内容!</div>
						</c:if>
					</div>--%>
				<!--未来计划end  -->

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
								<p><img src="${ctx }/crowdfunding/Skin/Default/images/time.png">发布时间：<fmt:formatDate value="${vo.createTime }" pattern="yyyy-MM-dd HH:mm"/></p>
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
		if('${tcproject.pstateId}'=='3'||'${tcproject.pstateId}'=='4'||'${tcproject.pstateId}'=='5'){
		var dialog = art.dialog({
		    title: '添加视频',
		    //width:'300px',top:'100px',height:'200px',
			content: "请填写项目网络视频路径：<br/><input id='video' style=' width: 350px'/>",
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
				
				window.parent.art.dialog('项目未通过平台审核，暂时不能添加项目视频。').lock().time(1);
			}
		}
	}
	function show(){
		var url='${ctx }/loan/aboutus/HelpCenterDetails.ht?menupath=CYZ';
		$.dialog.open(url, {
			title: '创业者必看',lock:true,width:'880px',top:'100px',height:'400px',close:function(){
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
		//	if('${tcproject.pstateId}'=='1'||'${tcproject.pstateId}'=='2'||'${tcproject.pstateId}'=='7'){
			//为发起申请,初审未通过,询价认筹过程中 可以修改
			if('${tcproject.pstateId}'=='0'||'${tcproject.pstateId}'=='9'||'${tcproject.pstateId}'=='3'){
			window.location.href="${ctx }/crowdfunding/tcproject/editorpartners.ht?projectId=${tcproject.projectId}";
			}else{
				art.dialog('项目已经提交，已提交的项目不能再编辑，除非项目被打回！').lock();
			}
		}else if($("#type").val()==2){
		//	if('${tcproject.pstateId}'=='1'||'${tcproject.pstateId}'=='2'||'${tcproject.pstateId}'=='7'){
			//为发起申请,初审未通过,询价认筹过程中 可以修改
			if('${tcproject.pstateId}'=='0'||'${tcproject.pstateId}'=='9'||'${tcproject.pstateId}'=='3'){
			window.location.href="${ctx }/crowdfunding/tcproject/editorhplans.ht?type=1&projectId=${tcproject.projectId}";
			}else{
				art.dialog('项目已经提交，已提交的项目不能再编辑，除非项目被打回！').lock();
			}
		}else if($("#type").val()==3){
			
	//		if('${tcproject.pstateId}'=='1'||'${tcproject.pstateId}'=='2'||'${tcproject.pstateId}'=='7'){
		//为发起申请,初审未通过,询价认筹过程中 可以修改
			if('${tcproject.pstateId}'=='0'||'${tcproject.pstateId}'=='9'||'${tcproject.pstateId}'=='3'){
			window.location.href="${ctx }/crowdfunding/tcproject/editorhplans.ht?type=2&projectId=${tcproject.projectId}";
			}else{
				art.dialog('项目已经提交，已提交的项目不能再编辑，除非项目被打回！').lock();
			}
		}else if($("#type").val()==4){
			
			addPic('${projectId}');
			 
		}else if($("#type").val()==5){
		//	if('${tcproject.pstateId}'=='3'||'${tcproject.pstateId}'=='4'||'${tcproject.pstateId}'=='5'||'${tcproject.pstateId}'=='6'){
			//为发起申请,初审未通过,询价认筹过程中 可以修改
			if('${tcproject.pstateId}'=='0'||'${tcproject.pstateId}'=='9'||'${tcproject.pstateId}'=='3'){
				window.location.href="${ctx }/tcproject/ProjectDynamic/ProjectDynamicBackList.ht?projectId=${tcproject.projectId}";
			}else{
				art.dialog('项目未通过平台审核，暂时不能添加项目动态。').lock();
			}
		}else{
		//	if('${tcproject.pstateId}'=='1'||'${tcproject.pstateId}'=='2'||'${tcproject.pstateId}'=='7'){
			//为发起申请,初审未通过,询价认筹过程中 可以修改
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
	})
	</script>
</body>
</html>
