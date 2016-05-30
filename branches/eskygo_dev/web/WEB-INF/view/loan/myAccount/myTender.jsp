<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<%@ include file="/commons/includeFront/taglibs.jsp"%>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
 <script type="text/javascript" src="${ctx}/js/calendar/My97DatePicker/WdatePicker.js"></script>
   </head>
   <body> 
     
        <div class="tit-box mb15 element-box bg-color-s bd-color-main"><span class="tit-xxl color-main">我的投标</span></div>
        <div style="overflow:hidden;">
          <div id="daishoukuan" onclick="loadDates1();" class="con-tabname editinfo-tabname bd-b-color-main  tab-on">待收款</div>
          <div class="editinfo-spac13 bd-b-color-main"></div>
          <div id="zhengzaishoukuan" onclick="loadDates2();"  class="con-tabname editinfo-tabname bd-b-color-main">正在收款中</div>
          <div class="editinfo-spac13 bd-b-color-main"></div>
          <div id="yihuanqing" onclick="loadDates3();"  class="con-tabname editinfo-tabname bd-b-color-main">已还清</div>
          <div class="editinfo-spac13 bd-b-color-main" style="width:202px;"></div>
        </div>
        <!-------------待收款----------------->
        <div class="con-box con-box-daishoukuan con-box-wodejiekuan bd-b-color-main bd-l-color-main bd-r-color-main" id="con-box_1">
         
       <%--  <form id="query_id_1"  action="${ctx }/loan/myAccount/toMyTender.ht" method="get">
          <div class="selectDate-box con-table-right">从：
          <input type="text"   id="beginDate1" name="beginDate1"  class="inputText Wdate input-text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'beginDate\');}'})" value="${TProjectInvest.beginDateS1 }"/>
          <input type="hidden" id="hide_1" value="${HIDE_1}">
          <input type="hidden" name="hide_1" value="1">
             至<input type="text" id="endDate1"  name="endDate1"  class="inputText Wdate input-text"  onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endDate\');}'})"  value="${TProjectInvest.endDateS1 }"/>
          <input id="sub-btn-jibenxinxi"  onclick="document.getElementById('query_id_1').submit()" class="sub-btn bg-color-l" type="button" value="查询">
          <span class=""><img src="${ctx }/images/Money.png" style="position:relative; top:7px;"/>总金额：<span class="color-main fs16">${piEffectAmount }</span>元</span>
          </div>
        </form> --%>
        
        
         <%--  <table>
          <tr >
          <th  class="color-main">项目名称</th>
            <th  class="color-main">投标日期</th>
            <th  class="color-main">借入者</th>
            <th class="color-main">期数/总期数</th>
            <th  class="color-main">待收本息</th>
          </tr>
          <c:forEach items="${ListVo }" var="vo">
	          <tr>
	        	  <td >${vo.pname }</td>
	            <td >${vo.paPayBackTime }</td>
	            <td >${vo.realName }</td>
	            <td >0/${vo.pDeadline }</td>
	            <td >${vo.piBeGetSum }</td>
	          </tr>
          </c:forEach>
       
        </table> --%>
          <iframe src="${ctx }/loan/myAccount/toMyTenderWillDo.ht" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height=100% id="iframepage" name="iframepage" onLoad="iFrameHeight()" ></iframe>
        </div>
        <!-------------正在收款中----------------->
        <div class="con-box con-box-zhengzaishoukuan con-box-wodejiekuan bd-b-color-main bd-l-color-main bd-r-color-main" id="con-box_2" style="display:none;">
        <%-- <form id="query_id_2" action="${ctx }/loan/myAccount/toMyTender.ht" method="get">
          <div class="selectDate-box con-table-right">从：
            <input type="text"   id="beginDate2" name="beginDate2"  class="inputText Wdate input-text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'beginDate\');}'})" value="${TProjectInvest.beginDateS2 }"/>
            <input type="hidden" id="hide_2" value="${HIDE_2}">
            <input type="hidden" name="hide_2" value="2">
           	 至<input type="text" id="endDate2"  name="endDate2"  class="inputText Wdate input-text"  onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endDate\');}'})"  value="${TProjectInvest.endDateS2 }"/>
          <input id="sub-btn-jibenxinxi"  onclick="document.getElementById('query_id_2').submit()" class="sub-btn bg-color-l" type="button" value="查询">
          <span class=""><img src="${ctx }/images/Money.png" style="position:relative; top:7px;"/>总金额：<span class="color-main fs16">${piEffectAmount1 }</span>元</span>
          </div>
         </form> --%>
        <%--   <table>
          <tr >
           	<th  class="color-main">项目名称</th>
            <th class="color-main">还款日</th>
            <th class="color-main">借入者</th>
            <th class="color-main">期数/总期数</th>
            <th  class="color-main">已回本金/已收利息</th>
            <th  class="color-main">待回本金/待收利息</th>
          </tr>
         <c:forEach items="${ListVo1 }" var="vo1">
	          <tr>
	          	<td >${vo1.pname }</td>
	            <td >${vo1.paPayBackTime }</td>
	            <td >${vo1.realName }</td>
	            <td >${vo1.deadlineNum}/${vo1.pDeadline }</td>
	            <td >${vo1.piGetPrincipalSum }元/${vo1.piGetRateSum }元</td>
	            <td >${vo1.piBeGetPrincipalSum }元/${vo1.piBeGetRateSum }元</td>
	          </tr>
          </c:forEach>
        
        </table> --%>
          <iframe src="" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height=100% id="iframepage_2" name="iframepage_2" onLoad="iFrameHeight2()" ></iframe>
        </div>
        <!-------------已还清----------------->
        <div class="con-box con-box-yihuanqing con-box-wodejiekuan bd-b-color-main bd-l-color-main bd-r-color-main" id="con-box_3" style="display:none;">
        <%-- <form id="query_id_3" action="${ctx }/loan/myAccount/toMyTender.ht" method="get">
          <div class="selectDate-box con-table-right">从：
          <input type="hidden"   id="beginDate3" name="beginDate3"  class="inputText Wdate input-text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'beginDate\');}'})" value="${TProjectInvest.beginDateS3 }"/>
          <input type="hidden" id="hide_3" value="${HIDE_3}">
          <input type="hidden" name="hide_3" value="3">
            <input type="text"   id="beginDate" name="beginDate"  class="inputText Wdate input-text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'beginDate\');}'})" value="${TProjectInvest.beginDateS3 }"/>
             至<input type="text" id="endDate3"  name="endDate3"  class="inputText Wdate input-text"  onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endDate\');}'})"  value="${TProjectInvest.endDateS3 }"/>
             <input type="hidden" id="endDate"  name="endDate"  class="inputText Wdate input-text"  onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endDate\');}'})"  value="${TProjectInvest.endDateS3 }"/>
          <input id="sub-btn-jibenxinxi"  onclick="document.getElementById('query_id_3').submit()" class="sub-btn bg-color-l" type="button" value="查询">
          <span class=""><img src="${ctx }/images/Money.png" style="position:relative; top:7px;"/>总金额：<span class="color-main fs16">${piEffectAmount2 }</span>元</span>
          </div>
           </form> --%>
         <%--  <table>
          <tr >
          	
         	 <th  class="color-main">项目名称</th>
            <th  class="color-main">还款日</th>
            <th  class="color-main">借入者</th>
            <th  class="color-main">期数/总期数</th>
            <th  class="color-main">本息合计</th>
            <th  class="color-main">已回本金/已收本息</th>
          </tr>
          <c:forEach items="${ListVo2 }" var="vo2">
	          <tr>
	          <td >${vo2.pname }</td>
	            <td >${vo2.paPayBackTime }</td>
	            <td >${vo2.realName }</td>
	            <td >${vo2.deadlineNum}/${vo2.pDeadline }</td>
	            <td>${vo2.piBeGetSum }</td>
	            <td >${vo2.piGetPrincipalSum }元/${vo2.piGetRateSum }元</td>
	          </tr>
          </c:forEach>
        
        </table> --%>
	
          <iframe src="" marginheight="0" marginwidth="0" frameborder="0" scrolling="no" width="100%" height=100% id="iframepage_3" name="iframepage_3" onLoad="iFrameHeight3()" ></iframe>
        </div>
        
  <script>
  $(function(){

		$(".con-tabname").click(function() {
			$(".con-tabname span").removeClass("color-main");
			$(this).find("span").addClass("color-main");
			$(".con-tabname").removeClass("tab-on");
			$(this).addClass("tab-on");
			$(".con-box").css("display", "none");
			$(".con-box-" + $(this).attr("id")).css("display", "block");
		});
		
		var hide_1=$("#hide_1").val();
		var hide_2=$("#hide_2").val();
		var hide_3=$("#hide_3").val();
		if(hide_1=='block'){
			$(".con-tabname").removeClass("tab-on");
			
			$("#daishoukuan").addClass("tab-on");
			$(".con-box").css("display", "none");
			 $(".con-box-daishoukuan").css("display", "block");
			
		//      $("#query_Form_id_1").attr("action","${ctx }/loan/myAccount/toMyTender.ht?hide_1=1");
		}
		if(hide_2=='block' ){
			
			$(".con-tabname").removeClass("tab-on");
			
			$("#zhengzaishoukuan").addClass("tab-on");
			$(".con-box").css("display", "none");
			
			 $(".con-box-zhengzaishoukuan").css("display", "block");
		//	 $("#query_Form_id_1").attr("action","${ctx }/loan/myAccount/toMyTender.ht?hide_2=2");
		}
		if(hide_3=='block'){
			$(".con-tabname").removeClass("tab-on");
			
			$("#yihuanqing").addClass("tab-on");
			$(".con-box").css("display", "none");
			
			 $(".con-box-yihuanqing").css("display", "block");
		//	 $("#query_Form_id_1").attr("action","${ctx }/loan/myAccount/toMyTender.ht?hide_3=3");
		}
	  });
  
  function loadDates1(){
	 var url='${ctx }/loan/myAccount/toMyTenderWillDo.ht?hide_1=1';
	  $("#iframepage").attr("src", url);
  }
	function loadDates2(){
		 var url='${ctx }/loan/myAccount/toMyTenderBeDoing.ht?hide_2=2';
		 $("#iframepage_2").attr("src", url);
  }
	function loadDates3(){
		 var url='${ctx }/loan/myAccount/toMyTenderEnd.ht?hide_3=3';
		 $("#iframepage_3").attr("src", url);
	}
	function iFrameHeight() {
		
        var ifm= document.getElementById("iframepage");

        var subWeb = document.frames ? document.frames["iframepage"].document :

			ifm.contentDocument;

            if(ifm != null && subWeb != null) {

            ifm.height = subWeb.body.scrollHeight;

            }

    }
function iFrameHeight2() {
		
        var ifm= document.getElementById("iframepage_2");

        var subWeb = document.frames ? document.frames["iframepage_2"].document :

			ifm.contentDocument;

            if(ifm != null && subWeb != null) {

            ifm.height = subWeb.body.scrollHeight;

            }

    }
function iFrameHeight3() {
	
    var ifm= document.getElementById("iframepage_3");

    var subWeb = document.frames ? document.frames["iframepage_3"].document :

		ifm.contentDocument;

        if(ifm != null && subWeb != null) {

        ifm.height = subWeb.body.scrollHeight;

        }

}
  function tabShowCon(showid)
  {
	  //$("#con-box1,#con-box2").hide();
	  //$("#"+showid).addClass(showid+"2");
	  if(showid=="Orange")
	  {
		$("#div_Orange").removeClass("Orange1").addClass("Orange2");
	  	$("#div_green").removeClass("green2").addClass("green1");
		$("#con-box1").show();$("#con-box2").hide();
		
	  }
		else
		{
		$("#div_Orange").removeClass("Orange2").addClass("Orange1");
		$("#div_green").removeClass("green1").addClass("green2");
		$("#con-box1").hide();$("#con-box2").show();
		}
	  //alert(showid);
  }
  </script>
</body>
</html>