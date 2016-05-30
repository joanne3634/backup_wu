<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/commons/includeFront/javascripts.jsp"%>

<form id="query_id_1_" action="${ctx }/loan/myAccount/toMyTenderWillDo.ht" method="get">
              
       <%--  <form id="query_id_1" action="${ctx }/loan/myAccount/toMyTenderWillDo.ht" method="get">
          <div class="selectDate-box con-table-right">从：
          <input type="text"   id="beginDate1" name="beginDate1"  class="inputText Wdate input-text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'beginDate\');}'})" value="${TProjectInvest.beginDateS1 }"/>
          <input type="hidden" id="hide_1" value="${HIDE_1}">
          <input type="hidden" name="hide_1" value="1">
             至<input type="text" id="endDate1"  name="endDate1"  class="inputText Wdate input-text"  onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endDate\');}'})"  value="${TProjectInvest.endDateS1 }"/>
          <input id="sub-btn-jibenxinxi"  onclick="document.getElementById('query_id_1').submit()" class="sub-btn bg-color-l" type="button" value="查询">
          <span class=""><img src="${ctx }/images/Money.png" style="position:relative; top:7px;"/>总金额：<span class="color-main fs16">${piEffectAmount }</span>元</span>
          </div>
        </form> --%>
        <div class="con-box-wodejiekuan">
          <table>
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
         <!--  <tr>
            <td >2014-09-15</td>
            <td >张宇</td>
            <td >2/2</td>
            <td >3000元</td>
          </tr> -->
        </table></div>
        <pageTag:paging form="query_id_1_"/>
        </form>
          