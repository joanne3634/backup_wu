<%--
	time:2011-11-28 10:17:09
	desc:edit the 用户信息
--%>
<%@page language="java" pageEncoding="UTF-8" import="com.deelon.platform.model.system.SysUser"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>用户信息</title>
	<%@include file="/commons/include/form.jsp" %>
	<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/public.css">
	<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerWindow.js" ></script>
	<script type="text/javascript" src="${ctx}/js/deelon/displaytag.js" ></script>
	<%-- <script type="text/javascript" src="${ctx}/servlet/ValidJs?form=sysUser"></script>
	<f:link href="tree/zTreeStyle.css"></f:link>
	<script type="text/javascript" src="${ctx}/js/tree/jquery.ztree.js"></script>
	<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerTab.js" ></script>
   <script type="text/javascript"  src="${ctx}/js/deelon/platform/system/SysDialog.js"></script>
   <script type="text/javascript" src="${ctx}/js/deelon/platform/system/FlexUploadDialog.js"></script> --%>
	<script type="text/javascript">
	
   
	
	</script>
<style type="text/css">
	html{height:100%}
	body {overflow:auto;}
div.panel-body {
    margin: 0px;
}
</style>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">
				<c:if test="${sysUser.userId==null }">添加用户信息</c:if>
				<c:if test="${sysUser.userId!=null }">编辑【${sysUser.fullname}】用户信息</c:if>  
				</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<!-- <div class="group"><a class="link save" id="dataFormSave" href="#"><span></span>保存</a></div> -->
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="${returnUrl}"><span></span>返回</a></div>
				</div>
			</div>
		</div>
	   <form id="sysUserForm" method="post" action="save.ht">
						
            <div  id="tabMyInfo" class="panel-nav" style="overflow:hidden; position:relative;">  
	           <div title="基本信息" tabid="userdetail" icon="${ctx}/styles/default/images/resicon/user.gif">
			         
			           		<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td colspan="5" rowspan="<c:if test="${not empty sysUser.userId}">9</c:if><c:if test="${empty sysUser.userId}">10</c:if>" align="center" width="18%">
									<!-- <div style="float:top !important;background: none;height: 24px;padding:0px 6px 0px 112px;">
										<a class="link uploadPhoto" href="#" onclick="addPic();">上传照片</a>
										<a class="link del" href="#" onclick="delPic();">删除照片</a>
									</div> -->
									<div class="person_pic_div">
										<p><img id="personPic" src="${ctx}/${pictureLoad}"  alt="个人相片" /></p>
									</div>
									</td>
									<td colspan="15" rowspan="<c:if test="${not empty sysUser.userId}">9</c:if><c:if test="${empty sysUser.userId}">10</c:if>" align="center" width="50%">
									<dl class="yonghuxinxi" style="width: 984px;">
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
						          <dd><c:if test="${pdv.isHouseLoan == 1}">
						          		<img src="${ctx}/images/wu.png" alt=""><span>有</span>
						          		<img src="${ctx}/images/you.png" alt=""><span>无</span>
						          		</c:if>
						          <c:if test="${pdv.isHouseLoan == 0|| empty pdv.isHouseLoan}">
						          		<img src="${ctx}/images/you.png" alt=""><span>有</span>
						         		 <img src="${ctx}/images/wu.png" alt=""><span>无</span>
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
						          		<img src="${ctx}/images/wu.png" alt=""><span>有</span>
						          		<img src="${ctx}/images/you.png" alt=""><span>无</span>
						          		</c:if>
						          <c:if test="${pdv.isHouseLoan == 0 || empty pdv.isHouseLoan}">
						          		<img src="${ctx}/images/you.png" alt=""><span>有</span>
						         		 <img src="${ctx}/images/wu.png" alt=""><span>无</span>
						          </c:if>
						          
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
						          		<img src="${ctx}/images/wu.png" alt=""><span>有</span>
						          		<img src="${ctx}/images/you.png" alt=""><span>无</span>
						          		</c:if>
						          <c:if test="${pdv.isBuyCar == 0|| empty pdv.isBuyCar}">
						          		<img src="${ctx}/images/you.png" alt=""><span>有</span>
						         		 <img src="${ctx}/images/wu.png" alt=""><span>无</span>
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
						          		<img src="${ctx}/images/wu.png" alt=""><span>有</span>
						          		<img src="${ctx}/images/you.png" alt=""><span>无</span>
						          		</c:if>
						          <c:if test="${pdv.isBuyCarLoan == 0|| empty pdv.isBuyCarLoan}">
						          		<img src="${ctx}/images/you.png" alt=""><span>有</span>
						         		 <img src="${ctx}/images/wu.png" alt=""><span>无</span>
						          </c:if>
						        <%--   <img src="${ctx}/images/you.png" alt=""><span>有</span><img src="${ctx}/images/wu.png" alt=""><span>无</span> --%>
						          </dd>
						        </dl>
						       
									</td>
								</tr>												
								
														
							</table>
							
			           		<table class="table-detail" cellpadding="0" cellspacing="0" border="0" style="width: 100%;">
								<tr>
									<td>
									 <div class="xiangqing-ite-tie">通过的认证</div>
						        <ul class="xiangqing-ite-tab">
							          <li class="shenhexiangmu th tab-top-left-radius bg-color-l">审核项目</li>
							          <li class="zhuangtai th bg-color-l">状态</li>
							          <li class="tongguoriqi th tab-top-right-radius bg-color-l">通过日期</li>
							          <c:forEach items="${ListVo }" var="vo">
							          	<li class="shenhexiangmu e1e4e9">${vo.fileName }</li>
								        <li class="zhuangtai e1e4e9"><img src="${ctx}/images/shenhetongguotubiao.png" alt=""></li>
								        <li class="tongguoriqi e1e4e9">${vo.checkTimeS }</li>
							          </c:forEach>
          
       
        							</ul>
									</td>
								</tr>
							</table>
							<input type="hidden" name="userId" value="${sysUser.userId}" />
							<input type="hidden" id="picture" name="picture" value="${sysUser.picture}" />
					
	           </div>
	           
	      </div>      
	  </form>
</div>
</body>
</html>
