<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
<form id="query_id_2_2" action="" method="get">
         <div class="con-box-wodejiekuan">
          <table>
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
       
        </table></div>
          <pageTag:paging form="query_id_2_2"/>
</form>