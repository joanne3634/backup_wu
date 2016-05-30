<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<title>借款列表详情</title>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
  <script type="text/javascript" src="${ctx }/js/lg/plugins/ligerDialog.js"></script>
  
<script type="text/javascript">
	// click cancle value
	$(function() {
		var inputEl = $("#input_id"), defVal = inputEl.val();
		inputEl.bind({
			focus : function() {
				var _this = $(this);
				if (_this.val() == defVal) {
					_this.val('');

				}

			} /* ,  blur: function() {
								alert(_this.val() == '');
								var _this = $(this);
								if (_this.val() == '') {
									_this.val(defVal); 
									
								} 
								
							} */

		});

	});
	function addText(parm) {
		var inputEl = $("#input_id").val();

		if (inputEl == '') {
			$("#input_id").val(parm);

		}
	}

	function submit_Inverst(proId, pminInvest) {
		if("${sessionScope.user.groupID}"=='1'){
    		alert("对不起，您的账户类型没有理财的权限，请阅读理财条例重新注册理财类型账号，或者联系管理员开通理财权限。");
    		return ;
    	}
		var inputEl = $("#input_id"), defVal = inputEl.val();

		if (defVal.indexOf("每次投标至少") == 0) {
			alert("投资额不可为空!");
			return;
		}
		if (eval(defVal) <eval(pminInvest)) {
			alert("投标金额不能少于"+pminInvest+"元!");
			return;
		}
		 if (eval(defVal) == 0) {
			alert("不可输入0元");
			return;
		} 
		
		var currenMo_id = $("#currenMo_id").html();

		if (eval(defVal) > eval(currenMo_id)) {
			alert("输入金额大于你的可用金额！");
			inputEl.val('每次投标至少' + pminInvest + '元');
			return;
		}
		var payLoan_id = $("#payLoan_id").html();
		if (eval(defVal) > eval(payLoan_id)) {
			alert("您最多能投资" + payLoan_id + "元!");
			inputEl.val('每次投标至少' + pminInvest + '元');
			return;
		}

		$.ajax({
					url : "${ctx}/project/bidProject.ht",
					type : 'post',
					data : 'loan=' + defVal + '&projectId=' + proId+'&token_id='+$("#token_id").val()//+'&currenMo_id='+currenMo_id+"&payLoan_id="+payLoan_id
					,
					dataType : 'html',
					success : function(data, status) {
					
						
						//	location.href = "${ctx }/tenderProjects/getTenderProjects.ht";
						
							alert(data);
							if(data.indexOf("您最多能投资")>0){
								location.reload(true);
							}else{
								
								location.href = "${ctx }/tenderProjects/getTenderProjects.ht";
							}
					
					},
					error : function(xhr, textStatus, errorThrown) {
					}
				});
	}

	function attentionProject(p) {
		if (p == "") {
			return;
		}
		$.ajax({
			url : "${ctx}/attention/attentionProject.ht",
			type : 'post',
			data : 'projectId=' + p,
			dataType : 'html',
			success : function(data) {
				if (eval(data) == "0") {
					alert("请先登录再关注");
					window.location = "${ctx}/loginWeb.jsp";
				} else {
					alert(eval(data));
				}
			},
			error : function(xhr, textStatus, errorThrown) {
			}
		});
	}

	
</script>

</head>
<body>
	<%@ include file="/commons/includeFront/head.jsp"%>
	<div class="container">
		<div class="weizhi-lianjie">
			<a href="${ctx }/index-web.jsp">首页</a> > <a
				href="${ctx }/tenderProjects/getTenderProjects.ht">我要理财</a> > <span>理财列表详情</span>
		</div>

		<div class="hyht-body">
			<div style="overflow: hidden;">
				<div style="overflow: hidden; width: 650px; float: left;">
					<div class="xiangqing-tit">
						${pdv.pName}<a class="bgc-s" href="javascript:;" onclick="attentionProject('${pdv.projectId}')">关注此借款</a>
					</div>
					<dl class="xiangqing-data">
						<dt>金额：</dt>
						<dd class="color-main fs28">${pdv.loan}元</dd>
						<dt>年利率：</dt>
						<dd class="color-main fs28">${pdv.rateOut}%</dd>
						<dt>期限：</dt>
						<dd class="color-main fs28">${pdv.deadline}个月</dd>
						<dt>还款方式：</dt>
						<dd>
							<c:choose>
								<c:when test="${pdv.repayWay eq 1}">一次性还本付息</c:when>
								<c:when test="${pdv.repayWay eq 2}">按月付息,到期还本</c:when>
								<c:when test="${pdv.repayWay eq 3}">等额本息,每月还款</c:when>
								<c:otherwise>等额本金,每月还款</c:otherwise>
							</c:choose>
						</dd>
						<dt>进度：</dt>
						<dd>
							<div class="jindutiao">
								<div class="bgc-s" style="width:${pdv.complete}%"></div>
							</div>
							${pdv.complete}%
						</dd>
					</dl>
					<div class="xiangqing-center-box bgc-s-s">
						<div class="color-s" style="font-size: 20px;">
							还需金额：<span>${pdv.payLoan}</span> 元
						</div>
						<div class="color-main" style="font-size: 14px; padding-top: 10px; padding-bottom: 10px;">
							您当前可用：<span id="currenMo_id">${pdv.canUseLoan}</span> 元
						</div>

						<input class="bgc-s-s bdc-s" type="text" onblur="addText('每次投标至少${pdv.pminInvest }元');"
							id="input_id" alt="" value="每次投标至少${pdv.pminInvest }元"
							onkeypress="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value"
							onkeyup="if(!this.value.match(/^[\+\-]?\d*?\.?\d*?$/))this.value=this.t_value;else this.t_value=this.value;if(this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?)?$/))this.o_value=this.value"><br>
						<div class="color-s" style="font-size: 14px; padding-top: 10px; padding-bottom: 10px;">
							还需金额：<span id="payLoan_id">${pdv.payLoan}</span> 元
						</div>
						<input type="hidden" name="token" id="token_id" value="${token }"/>
						
						<a href="javascript:void(0);"
							onclick="submit_Inverst('${pdv.projectId}','${pdv.pminInvest }');">确认投资</a>
					</div>
				</div>
				<div class="xiangqing-right-box">
					<div class="huiyuantouxiang130">
						<%-- <img src="${ctx}/images/huiyuantouxiang130.png" alt=""> --%>
						<c:if test="${not empty pdv.filedId}">
							<img id="personPic"
								src="${ctx}/platform/system/sysFile/getFileById.ht?fileId=${pdv.filedId}"
								style="padding-top: 5px;" width="150" height="138" alt="">
						</c:if>
						<c:if test="${ empty pdv.filedId}">
							<img id="personPic" src="${ctx}/images/huiyuantouxiang.png"
								style="padding-top: 5px; border: 0 none;" width="150"
								height="138" alt="">
						</c:if>
						<br>
						<span>${pdv.userName }</span>
					</div>
					<div style="font-size: 18px; color: #333;">${pdv.successNum}次成功，${pdv.isbreakNum}次流标</div>
					<dl>
						<dt>借入信用：</dt>
						<dd>
							<img src="${ctx }/images/jieruxinyong_bg.png" alt="">（${pdv.creditIn}）分
						</dd>
						<dt>借出信用：</dt>
						<dd>${pdv.creditOut}分</dd>
						<div style="clear: both;"></div>
						<div style="margin: 0 auto; width: 80px; height: 30px; border-radius: 3px; color: #fff; line-height: 30px; cursor: pointer;"
							class="but bgc-s">举报用户</div>
					</dl>
				</div>
			</div>
			<div class="licaixiangqing-tit">
				<a id="jiekuanxinxi" class="hover" href="javascript:;">借款信息</a> <a
					id="toubiaojilu" href="javascript:;">投标记录</a>
				<!--   <a href="#">还款方案</a> -->
			</div>
			<ul>
				<li class="jiekuanxinxi">
					<div class="xiangqing-ite-tie">
						用户信息<span class="bg-color-l">ID: ${pdv.loginName }</span>
					</div>
					<dl class="yonghuxinxi">
						<dt>用户名</dt>
						<dd>
							<c:if test="${ empty pdv.userName }">--</c:if>
							<c:if test="${ not empty pdv.userName }">${pdv.userName }</c:if>
						</dd>
						<dt>公司行业</dt>
						<dd>
							<c:if test="${ empty pdv.cpyTrade }">--</c:if>
							<c:if test="${not empty pdv.cpyTrade }">${pdv.cpyTrade }</c:if>
						</dd>
						<dt>收入范围</dt>
						<dd>
							<c:if test="${ empty pdv.salary }">--</c:if>
							<c:if test="${ not empty pdv.salary }">${pdv.salary }元</c:if>
						</dd>
						<dt>年龄</dt>
						<dd>
							<c:if test="${ empty pdv.age }">--</c:if>
							<c:if test="${ not empty pdv.age }">${pdv.age }岁</c:if>
						</dd>
						<dt>公司规模</dt>
						<dd>
							<c:if test="${ empty pdv.cpySize }">--</c:if>
							<c:if test="${ not empty pdv.cpySize }">${pdv.cpySize }人</c:if>
						</dd>
						<dt>房产</dt>
						<!-- 应加入房产字段 -->
						<dd>
							<c:if test="${pdv.isHouseLoan == 1}">
								<img src="${ctx}/images/wu.png" alt="">
								<span>有</span>
								<img src="${ctx}/images/you.png" alt="">
								<span>无</span>
							</c:if>
							<c:if test="${pdv.isHouseLoan == 0|| empty pdv.isHouseLoan}">
								<img src="${ctx}/images/you.png" alt="">
								<span>有</span>
								<img src="${ctx}/images/wu.png" alt="">
								<span>无</span>
							</c:if>
						</dd>
						<dt>学历</dt>
						<dd>
							<c:if test="${ empty pdv.edu }">--</c:if>
							<c:if test="${ not empty pdv.edu }">${pdv.edu }</c:if>
						</dd>
						<dt>岗位职位</dt>
						<dd>
							<c:if test="${ empty pdv.post }">--</c:if>
							<c:if test="${ not empty pdv.post }">${pdv.post }</c:if>
						</dd>
						<dt>房贷</dt>
						<dd>
							<c:if test="${pdv.isHouseLoan == 1}">
								<img src="${ctx}/images/wu.png" alt="">
								<span>有</span>
								<img src="${ctx}/images/you.png" alt="">
								<span>无</span>
							</c:if>
							<c:if test="${pdv.isHouseLoan == 0 || empty pdv.isHouseLoan}">
								<img src="${ctx}/images/you.png" alt="">
								<span>有</span>
								<img src="${ctx}/images/wu.png" alt="">
								<span>无</span>
							</c:if>

							<%--  <c:if test="${pdv.isHouseLoan == 1}">
         	 <img src="${ctx}/images/you.png" alt="">
          </c:if>
          <c:if test="${pdv.isHouseLoan != 1}">
          <img src="${ctx}/images/wu.png" alt="">
          </c:if><span>有</span>
          <c:if test="${pdv.isHouseLoan != 1}">
          <img src="${ctx}/images/you.png" alt="">
          </c:if>
          <c:if test="${pdv.isHouseLoan == 1}">
          <img src="${ctx}/images/wu.png" alt="">
          </c:if>
          <span>无</span> --%>
						</dd>
						<dt>学校</dt>
						<dd>
							<c:if test="${ empty pdv.school }">--</c:if>
							<c:if test="${ not empty pdv.school }">${pdv.school }</c:if>
						</dd>
						<dt>工作城市</dt>
						<dd>
							<c:if test="${ empty pdv.workCity }">--</c:if>
							<c:if test="${ not empty pdv.workCity }">${pdv.workCity }</c:if>
						</dd>
						<dt>车产</dt>
						<dd>
							<c:if test="${pdv.isBuyCar == 1}">
								<img src="${ctx}/images/wu.png" alt="">
								<span>有</span>
								<img src="${ctx}/images/you.png" alt="">
								<span>无</span>
							</c:if>
							<c:if test="${pdv.isBuyCar == 0|| empty pdv.isBuyCar}">
								<img src="${ctx}/images/you.png" alt="">
								<span>有</span>
								<img src="${ctx}/images/wu.png" alt="">
								<span>无</span>
							</c:if>
							<%-- <img src="${ctx}/images/you.png" alt=""><span>有</span><img src="${ctx}/images/wu.png" alt=""><span>无</span> --%>
						</dd>
						<dt>婚姻</dt>
						<dd>
							<c:if test="${ empty pdv.marriage }">--</c:if>
							<c:if test="${ not empty pdv.marriage }">${pdv.marriage }</c:if>
						</dd>
						<dt>工作时间</dt>
						<dd>
							<c:if test="${ empty pdv.workTime }">--</c:if>
							<c:if test="${ not empty pdv.workTime }">${pdv.workTime }年</c:if>
						</dd>
						<dt>车贷</dt>
						<dd>
							<c:if test="${pdv.isBuyCarLoan == 1}">
								<img src="${ctx}/images/wu.png" alt="">
								<span>有</span>
								<img src="${ctx}/images/you.png" alt="">
								<span>无</span>
							</c:if>
							<c:if test="${pdv.isBuyCarLoan == 0|| empty pdv.isBuyCarLoan}">
								<img src="${ctx}/images/you.png" alt="">
								<span>有</span>
								<img src="${ctx}/images/wu.png" alt="">
								<span>无</span>
							</c:if>
							<%--   <img src="${ctx}/images/you.png" alt=""><span>有</span><img src="${ctx}/images/wu.png" alt=""><span>无</span> --%>
						</dd>
					</dl>
					<div class="xiangqing-ite-tie">审核状态</div>
					<ul class="xiangqing-ite-tab">
						<li class="shenhexiangmu th tab-top-left-radius bg-color-l">审核项目</li>
						<li class="zhuangtai th bg-color-l">状态</li>
						<li class="tongguoriqi th tab-top-right-radius bg-color-l">通过日期</li>
						<c:forEach items="${ListVo }" var="vo">
							<li class="shenhexiangmu e1e4e9">${vo.fileName }</li>
							<li class="zhuangtai e1e4e9"><img
								src="${ctx}/images/shenhetongguotubiao.png" alt=""></li>
							<li class="tongguoriqi e1e4e9">${vo.checkTimeS }</li>
						</c:forEach>

						<%--   <li class="shenhexiangmu f3f7ec">身份认证</li>
          <li class="zhuangtai f3f7ec"><img src="${ctx}/images/shenhetongguotubiao.png" alt=""></li>
          <li class="tongguoriqi f3f7ec">2014-07-25</li>
          <li class="shenhexiangmu e1e4e9">工作认证（工薪阶层）</li>
          <li class="zhuangtai e1e4e9"><img src="${ctx}/images/shenhetongguotubiao.png" alt=""></li>
          <li class="tongguoriqi e1e4e9">2014-07-25</li>
          <li class="shenhexiangmu f3f7ec">收入认证</li>
          <li class="zhuangtai f3f7ec"><img src="${ctx}/images/shenhetongguotubiao.png" alt=""></li>
          <li class="tongguoriqi f3f7ec">2014-07-25</li>
          <li class="shenhexiangmu e1e4e9 tab-bottom-left-radius">婚姻认证</li>
          <li class="zhuangtai e1e4e9"><img src="${ctx}//images/shenhetongguotubiao.png" alt=""></li>
          <li class="tongguoriqi e1e4e9 tab-bottom-right-radius">2014-07-25</li> --%>
					</ul>
					<ul class="shenhezhuangtai-tips">
						<li>P2P及其合作机构将始终秉持客观公正的原则，严控风险，最大程度的尽力确保借入者信息的真实性，但不保证审核信息100%无误。</li>
						<li>借入者若长期逾期,其个人信息将被公布。</li>
					</ul> <c:if test="${not empty pdv.proDesc }">
						<div class="xiangqing-ite-tie">借款描述</div>
						<p class="jiekuanmiaoshu-con">${pdv.proDesc }</p>
					</c:if>
				</li>
				<li class="toubiaojilu" style="display: none;">
					
					<iframe src="" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height=100% id="iframepage" name="iframepage" onLoad="iFrameHeight()" ></iframe>
				</li>
			</ul>
		</div>


	</div>
	<form  method="post" id="TUserMessageForm" name="TUserMessageForm">
	<div id="faqbg"></div> 
	<div id="faqdiv" style="display: none">
		<h2>
			用户举报<a href="#" class="close">×</a>
		</h2>
		<div class="form">
			<div class="formname text-right">被举报用户：</div>
			<span>${pdv.userName }</span>
			<input type="hidden" value="${pdv.userId }" name="userId" id="userId">
			<input type="hidden" value="${pdv.projectId}" name="projectId" id="projectId">
			<input type="hidden" value="1" name="stateId" id="stateId">
			<%
			TUser user =	(TUser)session.getAttribute("user"); 
			%> 
			<input type="hidden" name="creator" id="creator" value="<%=user.getUserId()%>"> 
			<jsp:useBeanid="nowDate" class="java.util.Date"/>						 
		   <input type="hidden" style="width: 150px"  name="createTime" value='<fmt:formatDate value="${cmsSiteMenuContent.contentCreateDate==null?nowDate:cmsSiteMenuContent.contentCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>' size="25" class="inputText datetime" />
			<div class="clear"></div>
			<div class="formname text-right">举报原因：</div>
			<div class="causelist">
				<div>
					<input type=checkbox value="此用户在其他网站有借款" name="reportReason">此用户在其他网站有借款：（请提供链接，用户名等）
				</div>
				<div>
					<input type=checkbox value="此用户乱发骚扰信息" name="reportReason">此用户乱发骚扰信息：（请提供信息内容如站内信）
				</div>
				<div>
					<input type=checkbox value="此用户冒用他人身份" name="reportReason">此用户冒用他人身份：如照片，列表内容，身份信息，网站等
				</div>
				<div>
					<input type=checkbox value="怀疑此人有虚假信息" name="reportReason">怀疑此人有虚假信息：（请提供理由，链接等）
				</div>
				<div>
					<input type=checkbox value="其他/此用户发表了不当语言或图片" name="reportReason">其他/此用户发表了不当语言或图片：（请说明或提供链接）
				</div>
			</div>
			<div class="cause">
				<div class="formname text-right">附加信息：</div>
				<textarea rows="5" name="remarks" id="remarks">
</textarea>
			</div>
		</div>
		<input type="hidden" name="subctx" id="subctx" value="${ctx }"> 
		<div class="clear"></div>
		<div class="button">
			<div class="submit" onclick="submitsave()">提交</div>
			<div class="cancel" onclick="closediv()">取消</div>
		</div>
	</div>
	</form>
	<%@ include file="/commons/includeFront/footer.jsp"%>
<script type="text/javascript">
	function submitsave() {
		var a = $("#TUserMessageForm").serialize();
		var suburl = $("#subctx").val();
		var reportReason = $("input[name=reportReason]:checked").length;
		 if(reportReason!=0){
			 $.ajax({
					type : 'POST',
					data : $('#TUserMessageForm').serialize(),
					dataType : 'json',
					url : suburl + "/loan/sysManager/usersToReport/Repoetsave.ht",
					success : function(data) {
						$.ligerDialog.warn("举报成功，等待管理员审核");
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						 alert(XMLHttpRequest.statusText); 
					}
				});
		 }else{
			 alert("请选择举报原因！");
		 }
	}
</script>
	
	<script type="text/javascript">
		$(function() {
			
			
			 $(".licaixiangqing-tit a").click(function(){
			      $(".licaixiangqing-tit a").removeClass("hover");
			       if($(this).attr("id")=='toubiaojilu'){
			    	   $("#iframepage").attr("src", '${ctx}/project/investList.ht?projectId='+${pdv.projectId});
			      } 
			      $(this).addClass("hover");
			      $(".jiekuanxinxi").hide();
			      $(".toubiaojilu").hide();
			      $("."+$(this).attr("id")).show();
			    });
			
			
			
			$(".but").click(function() {

				$("#faqbg").css({
					display : "block",
					height : $(document).height()
				});
				var yscroll = document.documentElement.scrollTop;
				$("#faqdiv").css("top", "100px");
				$("#faqdiv").css("display", "block");
				document.documentElement.scrollTop = 0;
			});
			$(".close").click(function() {
				$("#faqbg").css("display", "none");
				$("#faqdiv").css("display", "none");
			});
		});
		function closediv() {
			$("#faqbg").css("display", "none");
			$("#faqdiv").css("display", "none");
		}
		
		  function iFrameHeight() {
				
		        var ifm= document.getElementById("iframepage");
		
		        var subWeb = document.frames ? document.frames["iframepage"].document :
		
					ifm.contentDocument;
		
		            if(ifm != null && subWeb != null) {
		
		            ifm.height = subWeb.body.scrollHeight;
		
		            }
		
		    }
	</script>
</body>
</html>