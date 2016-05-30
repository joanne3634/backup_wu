<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
<form id="query_id_3_3" action="${ctx }/loan/myAccount/toMyTenderEnd.ht" method="get">
     <div class="con-box-wodejiekuan">
          <table>
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
        </table></div>
	 <pageTag:paging form="query_id_3_3"/>
          </form>