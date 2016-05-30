<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/commons/includeFront/taglibs.jsp"%>
	<!DOCTYPE html>
	<%@ include file="/commons/includeFront/javascripts.jsp"%>
	
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




        <div class="hy-info base-info bd-color-main">
          <div id="user-face">
          	<a  href="#" onclick="addPic();" title="点击更换图像" alt="">
          	<c:if test="${not empty TUserFunds.fileId}">
          		<img id="personPic" src="${ctx}/platform/system/sysFile/getFileById.ht?fileId=${TUserFunds.fileId}" width="100" height="100" alt="">
          	</c:if>
          	<c:if test="${ empty TUserFunds.fileId}">
          		<img id="personPic" src="${ctx}/images/huiyuantouxiang.png"  width="100" height="100" alt="">
          	</c:if>
          	
           	 
            </a>
          </div>
          <div>
            <div id="user-name">
            <%-- <c:if test="${not empty TUserFunds.realName}">${TUserFunds.realName}</c:if>
            <c:if test="${empty TUserFunds.realName}">${TUserFunds.loginName}</c:if> --%>
            	<c:choose>
	          		<c:when test="${not empty TUserFunds.realName }">${TUserFunds.realName }</c:when>
	          		<c:otherwise>${TUserFunds.loginName }</c:otherwise>
          		</c:choose>
            </div>
            <div style="font-size:14px;">
              安全等级 <div style="position:relative;top:3px;width:125px;height:12px;display:inline-block;margin-right:20px;padding:1px;border:1px solid #ccc;border-radius:6px;" title="${TUserFunds.safePercentum}%"><div style="width:${TUserFunds.safebar}px;height:12px;background-color:#ff5704;border-radius:6px;"></div></div><span style="font-size:16px;">账户余额： </span><span style="font-size:22px;color:#ff5704">${TUserFunds.balance }</span><span style="color:#ff5704;">元</span><a class="hy-info-btn" href="${ctx }/loan/myAccount/toDrawMnPage.ht" style="border:1px solid #548d00;background-color:#70b800;">提 现</a><a class="hy-info-btn" href="${ctx }/loan/myAccount/rechargePage.ht" style="margin-right:20px;border:1px solid #e04900;background-color:#ff6215;">充 值</a>
            </div>
            <div style="margin-top:10px;font-size:14px;">
              <div class="hy-zhuangtai light" >
            	<a  <c:if test="${not empty TUserFunds.bindMobile && TUserFunds.bindMobile eq '1'}">href="${ctx}/safe/bindPhone.ht" title="绑定手机，已绑定" style="background-position:-30px -30px;"</c:if><c:if test="${empty TUserFunds.bindMobile || TUserFunds.bindMobile eq '0'}"> href="${ctx}/safe/bindPhone.ht" title="绑定手机，未绑定" style="background-position:-30px 0px;"</c:if>  ></a>
            </div>
            
            <div class="hy-zhuangtai light" >
            
            	<a <c:if test="${not empty TUserFunds.bindCard  && TUserFunds.bindCard eq '1'}"> href="${ctx}/user/editUserInfoInit.ht"  title="实名认证，已设置" style="background-position:0px -30px;"</c:if><c:if test="${empty TUserFunds.bindCard || TUserFunds.bindCard eq '0'}"> href="${ctx}/user/editUserInfoInit.ht"  title="实名认证，未设置" style="background-position:0px 0px;"</c:if>  ></a>
            </div>
            <div class="hy-zhuangtai" >
            	<a  <c:if test="${not empty TUserFunds.tradingPwd }">href="#" title="提现密码，已设置" style="background-position:-90px -30px;"</c:if><c:if test="${empty TUserFunds.tradingPwd || TUserFunds.tradingPwd eq ''}"> href="javascript:void(0)" title="提现密码，未设置" style="background-position:-90px 0px;"</c:if>  ></a>
            </div>
            <div class="hy-zhuangtai" >
            <a  <c:if test="${not empty TUserFunds.bindEmail && TUserFunds.bindEmail eq '1'}"> href="${ctx}/safe/bindEmail.ht" title="绑定邮箱，已绑定" style="background-position:60px -30px;"</c:if><c:if test="${empty TUserFunds.bindEmail || TUserFunds.bindEmail eq '0'}">href="${ctx}/safe/bindEmail.ht" title="绑定邮箱，未绑定" style="background-position:-60px 0;"</c:if>  ></a>
            </div>
            <span style="position:relative;top:6px;"><span style="margin-left:40px;">冻结金额 </span><span style="font-size:18px;">${TUserFunds.freeze }</span><span style="font-size:12px;">元</span><span style="margin-left:40px;">可用金额 </span><span style="font-size:18px;">${TUserFunds.available }</span><span style="font-size:12px;">元</span></span>
            </div>         </div>
        </div>
        <div class="hy-info bd-color-main">
          <ul class="equation bd-b-color-main">
          
          
            <li>账户净资产<br><span><c:if test="${empty TUserFunds1.balance}">0.00</c:if><c:if test="${not empty TUserFunds1.balance}">${TUserFunds1.balance}</c:if></span>元</li>
            <li class="fuhao">=</li>
            
            <li>账户余额<br><span><c:if test="${empty TUserFunds1.available}">0.00</c:if><c:if test="${not empty TUserFunds1.available}">${TUserFunds1.available}</c:if></span>元</li>
            
             <li class="fuhao">+</li>
            <li>理财资产<br><span><c:if test="${empty TUserFunds1.piEffectAmountTotal}">0.00</c:if><c:if test="${not empty TUserFunds1.piEffectAmountTotal}">${TUserFunds1.piEffectAmountTotal}</c:if></span>元</li>
           
             <li class="fuhao">-</li>
            <li>借款负债<br><span><c:if test="${empty TUserFunds1.ploanRealTotal}">0.00</c:if><c:if test="${not empty TUserFunds1.ploanRealTotal}">${TUserFunds1.ploanRealTotal}</c:if></span>元</li>
          </ul>
          <dl>
          	<c:if test="${TUser.groupID eq '2' || TUser.groupID eq '3'}">
            <dt>已赚总金额<span style="margin-left:10px;">${payMoneyTotal } </span>元<a class="color-main f-r" href="${ctx }/loan/myAccount/toManagerMoneyCount.ht">理财统计</a></dt>
            <dd>
              <ul>
                <li class="th bg-color-xs">
                  <span>理财方式</span>
                  <span>本金</span>
                  <span>已赚利息</span>
                  <span>待收利息</span>
                  <span style="width:140px;">加权平均收益率</span>
                  <span>持有数量</span>
                </li>
                <c:forEach items="${ListVo }" var="vo">
                	<li class="tr">
	                  <span>${vo.produ_name }</span>
	                  <span>${vo.pieffectAmountTotal }元</span>
	                  <span>${vo.psumHavedPayInterestTotal }元</span>
	                  <span>${vo.piBeGetRateSum }元</span>
	                  <span style="width:140px;">${vo.prateOutavg }%</span>
	                  <span>${vo.countNum }</span>
	                 
                	</li>
                </c:forEach>
                
                <!-- <li class="tr">
                  <span>优选理财计划</span>
                  <span>0.00元</span>
                  <span>0.00元</span>
                  <span style="width:140px;">0.0%</span>
                  <span>0</span>
                  <a href="#">查看</a>
                </li> -->
              </ul>
            </dd>
            </c:if>
            <c:if test="${TUser.groupID eq '1' || TUser.groupID eq '3'}">
            <dt>待还总金额<span style="margin-left:10px;">${totalMoneyPay } </span>元<a class="color-main f-r" href="${ctx}/project/myapprojects.ht">申请查询</a></dt>
            <dd>
              <ul>
                <li class="th bg-color-xs">
                  <span>借款标题</span>
                  <span>待还本金</span>
                  <span style="width:140px;">待还利息/管理费</span>
                  <span>逾期费用</span>
                </li>
                <c:forEach items="${ListVo1 }" var="vo1">
	                 <li class="tr">
	                  <span>${vo1.produ_name }</span>
	                  <span>${vo1.psumHavedPayTotal }元</span>
	                  <span>${vo1.psumHavedPayInterestTotal }元</span>
	                  <span style="width:140px;">${vo1.psumLateTotal }元</span>
	                </li>
                </c:forEach>
               
               <!--  <li class="tr">
                  <span>优选理财计划</span>
                  <span>0.00元</span>
                  <span>0.00元</span>
                  <span style="width:140px;">0.00元</span>
                  <a href="#">查看</a>
                </li> -->
              </ul>
            </dd>
            </c:if>
          </dl>
        </div>
        <div style="overflow:hidden;">
          <div class="xinrenzhuanxiang">
            <div class="tit bg-color-s bd-color-main"><div class="shuxian bd-color-shuxian"></div>新人专享：简单四步，完成后领取新手礼包！<span>投标中</span><a class="color-main" href="${ctx }/tenderProjects/getTenderProjects.ht" target="_top">在此查看</a></div>
            <div class="con">
<!--               <div class="item"><a style="background-image: url(${ctx}/images/xinrenzhuanxiang1.png);" href="#">查看安全中心</a></div>
              <div class="item"><a style="background-image: url(${ctx}/images/xinrenzhuanxiang2.png);" href="#">账户充值</a></div>
              <div class="item"><a style="background-image: url(${ctx}/images/xinrenzhuanxiang3.png);" href="#">已投10个列表</a></div>
              <div class="item"><a style="background-image: url(${ctx}/images/xinrenzhuanxiang4.png);" href="#">查看自动投标</a></div>
              <div class="item"><a style="width:294px;height:63px;padding-top:29px;
              padding-left:202px;background-image: url(${ctx}/images/xinrenzhuanxiang5.png);font-size:14px;font-weight:normal;"><input style="margin-right:20px;padding-left:5px;padding-right:5px;background-color:#ff7800;border:none;color:#fff;font-weight:bold;border-bottom:3px solid #ff7800;cursor:pointer;" type="button" value="领取礼包">条件已满足，立即领取！</a></div>
                 <div class="item">
                <a style="color:#a6a6a6;background-image: url(${ctx}/images/xinrenzhuanxiang1-1.png);">查看安全中心</a>
                <div class="jixuwancheng-btn"><a href="#">去完善</a></div>
              </div>
              <div class="item">
                <a style="color:#a6a6a6;background-image: url(${ctx}/images/xinrenzhuanxiang2-2.png);">账户充值</a>
                <div class="jixuwancheng-btn"><a href="#">去充值</a></div>
              </div>
              <div class="item">
                <a style="height:81px;padding-top:30px;color:#a6a6a6;background-image: url(${ctx}/images/xinrenzhuanxiang3-3.png);">投10个列表<br>（还剩<span style="color:#ff7800;">10</span>个）</a>
                <div class="jixuwancheng-btn"><a href="#">去投标</a></div>
              </div>
              <div class="item">
                <a style="color:#a6a6a6;background-image: url(${ctx}/images/xinrenzhuanxiang4-4.png);">查看自动投标</a>
                <div class="jixuwancheng-btn"><a href="#">去完善</a></div>
              </div>
               -->
               
              
              <c:forEach items="${tTask }" var="t">
              	<c:if test="${t.isComplete == 1 }">   <!-- 已完成的任务  -->
              	<div class="item"><a style="background-image: url(${ctx}${t.imgSrc }.png);" href="javascript:;">${t.taskDesc }</a></div>
              	</c:if>
              	<c:if test="${t.isComplete == 0}">  <!-- 未完成的任务  -->
            	<div class="item">
                <a style="color:#a6a6a6;background-image: url(${ctx}${t.imgSrc }-.png);">${t.taskDesc }</a>      
                <c:choose>
                	<c:when test="${t.linkUrl == '/tenderProjects/getTenderProjects.ht' }">
                		<div class="jixuwancheng-btn"><a target="_parent" href="${ctx }${t.linkUrl}?taskId=${t.taskId}">去完善</a></div>
                	</c:when>
                	<c:otherwise>
                		<div class="jixuwancheng-btn"><a href="${ctx }${t.linkUrl}?taskId=${t.taskId}">去完善</a></div>
                	</c:otherwise>
                </c:choose>
             	</div>
             	</c:if>
              </c:forEach>
              
              <c:if test="${not empty tTask }">
			  <c:if test="${count == 0 }">  <!-- 没有累计的未完成任务 -->
			  <div class="item"><a style="width:294px;height:63px;padding-top:29px;
              padding-left:202px;background-image: url(${ctx}/images/xinrenzhuanxiang5.png);font-size:14px;font-weight:normal;"><input style="margin-right:20px;padding-left:5px;padding-right:5px;background-color:#ff7800;border:none;color:#fff;font-weight:bold;border-bottom:3px solid #ff7800;cursor:pointer;" type="button" value="领取礼包">条件已满足，立即领取！</a></div>
			  </c:if>
			   <c:if test="${count > 0 }">
              <div class="item"><a style="width:294px;height:63px;padding-top:29px;
              padding-left:202px;background-image: url(${ctx}/images/xinrenzhuanxiang5-5.png);font-size:14px;font-weight:normal;color:#a6a6a6;"><input style="float:left;margin-right:20px;padding-left:5px;padding-right:5px;background-color:#ececec;border:none;color:#a6a6a6;font-weight:bold;border-bottom:3px solid #ececec;cursor:pointer;" type="button" value="领取礼包" disabled="disabled"><div style="display:inline-block;width:175px;text-align:center;">您还有<span style="color:#ff7800;">${count }</span>个条件未满足，不能领取</div></a></div>
           	   </c:if>
           	   </c:if>
            </div>
          </div>
          <div style="float:right;width:258px;">
            <div class="changjianwenti bd-color-main">
              <div class="h2 bg-color-s">常见问题<a class="color-main" href="${ctx }/loan/aboutus/HelpCenterList.ht" target="_top">更多>></a></div>
              <ul>
              <pageTag:Questions menupath="CJWT"/>
              <!--   <li><div class="iocn-trangle"></div><a href="#">怎么进行投资?</a></li>
                <li><div class="iocn-trangle"></div><a href="#">如何申请“普通借款标”债权转让？</a></li>
                <li><div class="iocn-trangle"></div><a href="#">规则分别是怎样的？</a></li>
                <li><div class="iocn-trangle"></div><a href="#">积分拍卖规则是什么？</a></li>
                <li><div class="iocn-trangle"></div><a href="#">积分拍卖规则是什么？</a></li>
                <li><div class="iocn-trangle"></div><a href="#">如何申请“普通借款标”债权转让？</a></li> -->
              </ul>
            </div>
            <div class="hyht-pic"><img src="${ctx}/images/huiyuanzhuanxiangshouyi.png" alt=""></div>
            <div class="hyht-pic"><img src="${ctx}/images/putongjiekuanbiao.png" alt=""></div>
          </div>
        </div>
    
    
    <script type="text/javascript">
	//添加个人照片
	function picCallBack(fileIds, array) {
		
		if (!array && array != "")
			return;
		var fileId = array[0].fileId, fileName = array[0].fileName;
		var path = __ctx + "/platform/system/sysFile/getFileById.ht?fileId="+ fileId;
		 if(/\w+.(png|gif|jpg)/gi.test(fileName)){
			//$("#picture").val("/platform/system/sysFile/getFileById.ht?fileId=" + fileId);
			$("#personPic").attr("src",path);
		}
			
		else{
			
			$.ligerDialog.warn("请选择*png,*gif,*jpg类型图片!"); 
			return;
		}
		var name = fileName.toLowerCase();
		if (name.indexOf(".png") > -1 || name.indexOf(".gif") > -1
				|| name.indexOf(".jpg") > -1) {
			//	$("#picture").val("/platform/system/sysFile/getFileById.ht?fileId=" + fileId);
			$("#personPic").attr("src", path);
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
	};
	
	
	$(function() {

		$(".jixuwancheng-btn").mouseover(function() {
			$(this).css("opacity", "0.7");
			$(this).children("a").css("opacity", "1");
		}).mouseout(function() {
			$(this).css("opacity", "0");
			$(this).children("a").css("opacity", "0");
		});
	});
</script>