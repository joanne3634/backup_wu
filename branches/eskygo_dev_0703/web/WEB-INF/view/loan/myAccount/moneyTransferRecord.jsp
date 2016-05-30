<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
</head>
<body>
	<f:link href="Aqua/css/ligerui-all.css"></f:link>
	<f:link href="jquery/plugins/rowOps.css"></f:link>
  
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/dynamic.jsp"></script>
<script type="text/javascript" src="${ctx}/js/util/json2.js"></script>
<script type="text/javascript" src="${ctx}/js/util/util.js"></script>
<script type="text/javascript" src="${ctx}/js/util/dialog.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/ligerui.min.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerComboBox.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/htDicCombo.js"></script>  
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerResizable.js" ></script> 
<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.htselect.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.rowOps.js"></script>
<script type="text/javascript" src="${ctx}/js/deelon/displaytag.js" ></script>
<script type="text/javascript" src="${ctx}/js/deelon/foldBox.js" ></script>
<script type="text/javascript" src="${ctx}/js/calendar/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/js/deelon/absoulteInTop.js" ></script>
<script type="text/javascript" src="${ctx}/js/tree/jquery.ztree.js"></script>
<script type="text/javascript">

$(function(){
	//  loadTableGrid('','','','');
	  

  $(".jixuwancheng-btn").mouseover(function(){
    $(this).css("opacity","0.7");
    $(this).children("a").css("opacity","1");
  }).mouseout(function(){
    $(this).css("opacity","0");
    $(this).children("a").css("opacity","0");
  });
});


function doserch(){
	  var Q_begincreatetime_DL=$("#Q_begincreatetime_DL").val();
	  var Q_endcreatetime_DG=$("#Q_endcreatetime_DG").val();
	  var typeId=$("#typeId_id").val();
	  var createTime=$("#createTime_id").val();
	  loadTableGrid(typeId,createTime,Q_begincreatetime_DL,Q_endcreatetime_DG);
	  /*  var rep=$.ajax({
		  type:'POST',
		  url:'${ctx }/p2p/front/moneyRecord.ht',
		  data:{typeId:typeId,createTime:createTime,Q_begincreatetime_DL:Q_begincreatetime_DL,Q_endcreatetime_DG:Q_endcreatetime_DG}
	  });
	  rep.done(function(data){
		  alert(1);
		 location.href=location.href.getNewUrl();
	  });
	  rep.fail(function(jqXHR, textStatus ){
		  $.ligerDialog.warn(textStatus);
	  });  */
}
</script>

        <div class="hy-info base-info bd-color-main">
          <div id="user-face">
            <c:if test="${not empty TUserFunds.fileId}">
          		<img id="personPic" src="${ctx}/wuyouchou/system/sysFile/getFileById.ht?fileId=${TUserFunds.fileId}" width="100" height="100" alt="">
          	</c:if>
          	<c:if test="${ empty TUserFunds.fileId}">
          		<img id="personPic" src="${ctx}/images/huiyuantouxiang.png"  width="100" height="100" alt="">
          	</c:if>
          </div>
          <ul style="float:left;width:200px;font-size:18px;">
          	<li>
          	<c:choose>
          		<c:when test="${not empty TUserFunds.realName }">${TUserFunds.realName }</c:when>
          		<c:otherwise>${TUserFunds.loginName }</c:otherwise>
          	</c:choose>
          	</li>
          	<li style="font-size:24px;">账户余额</li>
          	<li class="color-main"><span style="font-size:22px;">${TUserFunds.balance }</span>元</li>
          </ul>
          <style>
			.gezhongzijin {
				width: 140px;
				display: inline-block;
				font-size: 16px;
				color: #333;
			}
			.gezhongzijin span {
				font-size: 18px;
			}
			.huiyuan-btn {
				position: relative;
				top: 9px;
				display: inline-block;
				height: 28px;
				line-height: 28px;
				color: #fff;
				padding-left: 20px;
				padding-right: 20px;
				margin-right: 20px;
				float: right;
				border-radius: 5px;
			}
			.huiyuan-btn:hover {
				text-decoration: none;
			}
          </style>
          <ul style="width:410px;float:left">
          	<li>
          		<ul class="gezhongzijin">
          			<li>可用资金</li>
          			<li><span>${TUserFunds.available }</span>元</li>
          		</ul>
          		<ul class="gezhongzijin">
          			<li>已充值总额</li>
          			<li><span>${TMoneymove.chargeMoneyTotal }</span>元</li>
          		</ul>
          		<a style="border-width:1px;border-style: solid;" class="huiyuan-btn bd-color-sec-l bg-color-sec-m" href="#">提 现</a>
          	</li>
          	<li class="bd-b-color-main" style="height:0;margin-top:10px;margin-bottom:10px;border-bottom-width:1px;border-bottom-style: dashed;"></li>
          	<li>
          		<ul class="gezhongzijin">
          			<li>冻结资金</li>
          			<li><span>${TUserFunds.freeze }</span>元</li>
          		</ul>
          		<ul class="gezhongzijin">
          			<li>已提现总额</li>
          			<li><span>${TMoneymove.drawMoneyTotal }</span>元</li>
          		</ul>
          		<a style="margin-right:20px;border-width:1px;border-style: solid;" class="huiyuan-btn bg-color-l bd-color-main-l" href="#">充 值</a>
          	</li>
          </ul>
        </div>
        <div class="tit-box bd-color-main element-box bg-color-s"><span class="tit-xxl color-main">资金记录</span></div>
        <form id="pageForm" name="pageForm" action="${ctx }/loan/myAccount/moneyRecord.ht">
        <div class="con-box bd-l-color-main bd-b-color-main bd-r-color-main jilu-box">
      
           <div id="condition" style="color:#ff6012;">资金类型：
            <div class="select-box"><!-- <select name="zijinleixing" id="typeId_id">
              <option value="">所有</option>
              <option value="1">充值</option>
              <option value="2">体现</option>
            </select> -->
            <f:select nodeKey="zjld" id="typeId" idName="typeId" defaultValue="${typeId}"  
										
			showBlankOnTop="true" >
			</f:select>
            </div>时间：
            <div class="select-box">
             <select name="timeBucket" id="createTime_id">
                <option value="" <c:if test="${selectEd eq '' }">selected</c:if>>所有</option>
                <option value="1" <c:if test="${selectEd eq '1' }">selected</c:if>>一周以内</option>
                <option value="2" <c:if test="${selectEd eq '2' }">selected</c:if>>半月以内</option>
                
                <option value="3" <c:if test="${selectEd eq '3' }">selected</c:if>>一月以内</option>
                <option value="4" <c:if test="${selectEd eq '4' }">selected</c:if>>二月以内</option>
                <option value="5" <c:if test="${selectEd eq '5' }">selected</c:if>>三月以内</option>
                <option value="6" <c:if test="${selectEd eq '6' }">selected</c:if>>半年以内</option>
                <option value="7" <c:if test="${selectEd eq '7' }">selected</c:if>>一年以内</option>
            
            </select> 
            </div>
            <a href="javascript:void(0);" onclick="document.getElementById('pageForm').submit()">查 询</a>
          </div> 
          
          <ul>
          
        <li class="zijinjilu-ite zijinjilu-tit"><span class="fs16">日期</span><span class="fs16">类型</span><span class="fs16">支出/存入</span><!--<span>存入</span> --><span class="fs16">余额</span><span class="fs16">说明</span></li> 
            ${eachTable } 
         
          </ul> 
            <!--  <div id="tableGrid"></div>  -->
       
        </div>
        </form>
      <pageTag:paging form="pageForm"/>
         	<!-- <div id="gridPager"></div>
           <div id="limitPage"></div> --> 
      </div>
    </div>
  </body>
  </html>
  
 