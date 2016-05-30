<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
<link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/transferback.css">
</head>
<body>
 <%@ include file="/commons/includeFront/head.jsp"%>
  <div class="container">
    <div class="weizhi-lianjie">
      <a href="${ctx}/index-web.jsp">首页</a> > <a href="${ctx}/myAccount/transfer.ht">债权转让</a> > <span>债权转让详情</span>
    </div>
    
    <div class="hyht-body">
      <div style="overflow:hidden;">
        <div style="overflow:hidden;width:650px;float:left;">
          <div class="xiangqing-tit">${project.pname} <a class="bgc-s" href="javascript:;" onclick="attentionProject('${project.projectId}')">关注此借款</a></div>
          <dl class="xiangqing-data">
            <dt>债权期限：</dt>
            <dd class="color-main fs28">${loanTime}个月</dd>
            <dt>竞拍模式：</dt>
            <dd class="color-main fs28">
            	<c:if test="${transfer.auctionWay==1}">明拍</c:if>
        		<c:if test="${transfer.auctionWay==2}">暗拍</c:if>
            </dd>
            <dt>  竞拍数：</dt>
            <dd class="color-main fs28">${auctionCount}</dd>
            <dt>发布时间：</dt>
            <dd><fmt:formatDate value="${transfer.openDate}" pattern="yyyy-MM-dd"></fmt:formatDate></dd>
            
          </dl>
          <div class="xiangqing-center-box bgc-s-s">
            <div class="green" style="font-size:20px;">债权总额：<span class="color-main">${transfer.claimsSum}</span> 元</div>
            <div class="orange" style="font-size:20px;padding-top:10px;padding-bottom:10px;">竞拍底价：<span class="color-main">${transfer.upsetPrice}</span> 元</div>
            <div class="green" style="font-size:14px;padding-top:10px;padding-bottom:10px;">剩余时间：<span  id="timer"></span></div>
            <a href="${ctx}/myAccount/auction.ht?transferId=${transfer.transferId}&closeDate=${transfer.closeDate}">竞&nbsp;&nbsp;&nbsp;&nbsp;价</a>
          </div>
        </div>
        <div class="xiangqing-right-box">
          <div class="huiyuantouxiang130">
          				<c:if test="${not empty pdv.filedId}">
							<img id="personPic"
								src="${ctx}/wuyouchou/system/sysFile/getFileById.ht?fileId=${pdv.filedId}"
								style="padding-top: 5px;" width="150" height="138" alt="">
						</c:if><c:if test="${empty pdv.filedId}"><img src="${ctx }/images/huiyuantouxiang130.png" alt=""></c:if><br><span>${pdv.loginName }</span></div>
          <div style="font-size:18px;color:#333;">${pdv.successNum}次成功，${pdv.isbreakNum}次流标</div>
          <dl>
            <dt>借入信用：</dt>
            <dd><img src="${ctx }/images/jieruxinyong_bg.png" alt="">（${pdv.creditIn}）分</dd>
            <dt>借出信用：</dt>
            <dd>10分</dd>
            <div style="clear:both;"></div>
            
          </dl>
        </div>
      </div>
      <div class="licaixiangqing-tit">
        <a id="jiekuanxinxi" class="hover" href="javascript:;">借款信息</a>
        <a id="toubiaojilu" href="javascript:;">投标记录</a>
      </div>
      <ul>
				<li class="jiekuanxinxi">
					<div class="xiangqing-ite-tie">
						用户信息<span>ID: ${pdv.loginName }</span>
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
				 
        <li class="toubiaojilu" id="toubiaojilu_id" style="display:none;">
          <table class="toubiaojilu-table">
            <tr>
              <th>投资人</th>
              <th>投资金额</th>
              <th>投资时间</th>
              <th>状态</th>
            </tr>
           <c:forEach var="invest" items="${invests}">
				<tr>
					<td>${invest.loginName}</td>
					<td class="color-main">${invest.piEffectAmount}</td>
					<td><fmt:formatDate value="${invest.piBidTime}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
					<td>成功</td>
				</tr>
			</c:forEach>
          </table>
          <!-- div class="paging-index-box">
            <a href="javascript:;">首页</a> 
            <a href="javascript:;">上一页</a> 
            <a class="page-num" href="javascript:;">1</a> 
            <a class="page-num" href="javascript:;">2</a> 
            <a class="page-num" href="javascript:;">3</a>
            <a class="page-num" href="javascript:;">4</a> 
            <a class="page-num" href="javascript:;">5</a> 
            <a class="page-num" href="javascript:;">6</a> --- 
            <a href="javascript:;">下一页</a> 
            <a href="javascript:;">尾页</a>
          </div> -->
        </li>
      </ul>
      </div>
  </div>
  <div style="border-top:1px solid #dcdcdc;min-width:1000px;"></div>
	
 <%@ include file="/commons/includeFront/footer.jsp"%>
  <div id="faqbg"></div> 
<div id="faqdiv" style="display:none"> 
<h2>用户举报<a href="#" class="close">×</a></h2> 
<div class="form"> 
<div class="formname text-right">被举报用户：</div><span>张三</span>
<div class="clear"></div>
<div class="formname text-right">举报原因：</div>
<div class="causelist">
  <div><input type=checkbox>此用户在其他网站有借款：（请提供链接，用户名等）</div>
  <div><input type=checkbox>此用户乱发骚扰信息：（请提供信息内容如站内信）</div>
  <div><input type=checkbox>此用户冒用他人身份：如照片，列表内容，身份信息，网站等</div>
  <div><input type=checkbox>怀疑此人有虚假信息：（请提供理由，链接等）</div>
  <div><input type=checkbox>其他/此用户发表了不当语言或图片：（请说明或提供链接）</div>
</div>
<div class="cause">
  <div class="formname text-right">附加信息：</div>
<textarea rows="5" >
</textarea>
</div>
</div> 
<div class="clear"></div>
<div class="button">
  <div class="submit">提交</div><div class="cancel" onclick="closediv()">取消</div>
</div>
</div> 
  <script>
  $(function(){
    $("#sidebar>ul>li:not(:first)>a").hover(function(){
      $(this).css("background-color","#fd8f59");
      var background_position_y = $(this).children("div").css("background-position").split(" ")[1];
      $(this).children("div").css("background-position","-20px " + background_position_y);
    },function(){
      var background_position_y = $(this).children("div").css("background-position").split(" ")[1];
      $(this).css("background-color","#fff9d9");
      $(this).children("div").css("background-position","0px " + background_position_y);
    }).bind("click",function(){
      $(".subsidebar").hide();
      if ($(this).next().css("display")=="none") {
        $(this).next().show();
      }else{
        $(this).next().hide();
      };
    });

    $(".xiangqing-center-box input").focus(function(){
      if ($(this).val()=="每次投标至少100元") {
        $(this).val("");
      };
    }).blur(function(){
      if ($(this).val()=="") {
        $(this).val("每次投标至少100元");
      };
    });

    $(".licaixiangqing-tit a").click(function(){
      $(".licaixiangqing-tit a").removeClass("hover");
      $(this).addClass("hover");
      $(".licaixiangqing-tit").next().find("li").hide();
      $("."+$(this).attr("id")).show();
      $(".xiangqing-ite-tab li").show();
    })
  })
  </script>


  <script type="text/javascript">
var time_now_server,time_now_client,time_end,time_server_client,timerID;
 
time_end=new Date("${endTime}");//结束的时间
time_end=time_end.getTime();
 
time_now_server=new Date("${nowTime}");//开始的时间
time_now_server=time_now_server.getTime();
 
time_now_client=new Date();
time_now_client=time_now_client.getTime();
 
time_server_client=time_now_server-time_now_client;
 
setTimeout("show_time()",1000);
 
function show_time()
{
 var timer = document.getElementById("timer");
 if(!timer){
 return ;
 }
 timer.innerHTML =time_server_client;
 
 var time_now,time_distance,str_time;
 var int_day,int_hour,int_minute,int_second;
 var time_now=new Date();
 time_now=time_now.getTime()+time_server_client;
 time_distance=time_end-time_now;
 if(time_distance>0)
 {
  int_day=Math.floor(time_distance/86400000)
  time_distance-=int_day*86400000;
  int_hour=Math.floor(time_distance/3600000)
  time_distance-=int_hour*3600000;
  int_minute=Math.floor(time_distance/60000)
  time_distance-=int_minute*60000;
  int_second=Math.floor(time_distance/1000)
 
  if(int_hour<10)
   int_hour="0"+int_hour;
  if(int_minute<10)
   int_minute="0"+int_minute;
  if(int_second<10)
   int_second="0"+int_second;
  str_time=int_day+"天"+int_hour+"小时"+int_minute+"分钟"+int_second+"秒";
  timer.innerHTML=str_time;
  setTimeout("show_time()",1000);
 }
 else
 {
  timer.innerHTML =timer.innerHTML;
  clearTimeout(timerID)
 }
}
</script>

<script type="text/javascript"> 

$(function(){ 
$(".but").click(function(){ 

$("#faqbg").css({display:"block",height:$(document).height()}); 
var yscroll =document.documentElement.scrollTop; 
$("#faqdiv").css("top","100px"); 
$("#faqdiv").css("display","block"); 
document.documentElement.scrollTop=0; 
}); 
$(".close").click(function(){ 
$("#faqbg").css("display","none"); 
$("#faqdiv").css("display","none"); 
}); 
});
function closediv(){
  $("#faqbg").css("display","none"); 
  $("#faqdiv").css("display","none"); 
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
</body>
</html>
       