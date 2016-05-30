<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8" %>
 <%@ include file="/commons/includeFront/taglibs.jsp"%>
<!DOCTYPE html>
  <%@ include file="/commons/includeFront/javascripts.jsp"%>
   <script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
  <script type="text/javascript" src="${ctx}/js/lg/ligerui.min.js"></script>
  <script type="text/javascript" src="${ctx}/js/calendar/My97DatePicker/WdatePicker.js"></script>


        <div class="tit-box element-box bg-color-s bd-color-main"><span class="tit-xxl color-main">我关注的借款</span></div>
        <form id="focusForm_id" action="${ctx }/loan/myAccount/toIFocusBorrow.ht" method="get">
        <div class="con-box con-box-wodejiekuan con-box-jibenxinxi bd-l-color-main bd-b-color-main bd-r-color-main">
       
        <form id="focusForm_id" action="${ctx }/loan/myAccount/toIFocusBorrow.ht" method="get">
        <div class="selectDate-box con-table-right">
        	从：
         <input type="text"   id="beginDate" name="beginDate"  class="inputText Wdate" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'beginDate\');}'})" value="${beginDateS }"/>
                       到<input type="text"   id="endDate"   name="endDate"    class="inputText Wdate" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endDate\');}'})"  value="${endDateS }"/>
        <a class="sub-btn bg-color-l dp-i" href="javascript:void(0);" onclick="document.getElementById('focusForm_id').submit()">查 看</a>
        
        </div>
           <table>
           	 <tr>
              <th class="color-main">标题</th>
              <th class="color-main">类型</th>
              <th class="color-main">还款方式</th>
              <th class="color-main">金额（元）</th>
              <th class="color-main">年利率</th>
              <th class="color-main">期限</th>
              <th class="color-main">发布时间</th>
              <th class="color-main">进度/剩余时间</th>
              <th class="color-main">信用等级</th>
              <th class="color-main">操作</th>
            </tr>
           <c:forEach  items="${ListVo }" varStatus="" var="vo">
           	<tr>
              <td>${vo.pname }</td>
              <td>普通借款标</td>
              
              <td>
	              <c:choose>
	              	<c:when test="${vo.prepayWay eq 1 }">一次性还本付息</c:when>
	              	<c:when test="${vo.prepayWay eq 2 }">先息后本</c:when>
	              	<c:when test="${vo.prepayWay eq 3 }">等额本息</c:when>
	              	<c:when test="${vo.prepayWay eq 4 }">等额本金</c:when>
	              	<c:otherwise>无要求</c:otherwise>
	              </c:choose>
              </td>
              <td>${vo.ploan }元</td>
              <td>${vo.prateIn }%</td>
              <td>${vo.pdeadline}</td>
              <td>${vo.popenDateStr }</td>
              <td>${vo.timeRemaining }</td>
              <td>${vo.pcertifiLevel }</td>
              <td><a href="javascript:;" name="BtnSave" class="bdc-s-l bgc-s handle-btn" id="BtnSave">取消关注</a></td>
            </tr>
           </c:forEach>
           
            
           <!--  <tr>
              <td>净值额度的借款</td>
              <td>普通借款标</td>
              <td>等额本息，按月还款</td>
              <td>140000元</td>
              <td>14.5%</td>
              <td>2014-9-12</td>
              <td>2014-10-12</td>
              <td>2014-9-12</td>
              <td>HR</td>
              <td>查看</td>
            </tr>
            <tr>
              <td>净值额度的借款</td>
              <td>普通借款标</td>
              <td>等额本息，按月还款</td>
              <td>140000元</td>
              <td>14.5%</td>
              <td>2014-9-12</td>
              <td>2014-10-12</td>
              <td>2014-9-12</td>
              <td>HR</td>
              <td>查看</td>
            </tr>
            <tr>
              <td>净值额度的借款</td>
              <td>普通借款标</td>
              <td>等额本息，按月还款</td>
              <td>140000元</td>
              <td>14.5%</td>
              <td>2014-9-12</td>
              <td>2014-10-12</td>
              <td>2014-9-12</td>
              <td>HR</td>
              <td>查看</td>
            </tr>
            <tr>
              <td>净值额度的借款</td>
              <td>普通借款标</td>
              <td>等额本息，按月还款</td>
              <td>140000元</td>
              <td>14.5%</td>
              <td>2014-9-12</td>
              <td>2014-10-12</td>
              <td>2014-9-12</td>
              <td>HR</td>
              <td>查看</td>
            </tr> -->
          </table>
          <pageTag:paging form="focusForm_id"/>
          </form>
        </div>

  
  
