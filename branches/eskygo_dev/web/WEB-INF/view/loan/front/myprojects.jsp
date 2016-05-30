<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
</head>
<body style="min-height:650px; ">
  
        <div class="tit-box mb15 element-box bg-color-s bd-color-main"><span class="tit-xxl color-main">还款管理</span></div>
        <div style="overflow:hidden;">
          <div id="huankuaning" class="con-tabname editinfo-tabname bd-b-color-main tab-on">还款中借款</div>
          <div class="editinfo-spac13 bd-b-color-main"></div>
          <div id="huankuaned" class="con-tabname editinfo-tabname bd-b-color-main">已还清借款</div>
          <div class="editinfo-spac13 bd-b-color-main" style="width:404px;"></div>
        </div>
         <form id="pageForm" name="pageForm" action="${ctx }/project/myinprojects.ht#">
         <input type="hidden" name="status" id="status"  value="${status}"/>
        <div class="con-box con-box-huankuaning con-box-wodejiekuan bd-b-color-main bd-l-color-main bd-r-color-main">
          <table>
            <tr>
              <th class="color-main">借款项目名称</th>
              <th class="color-main">金额</th>
              <th class="color-main">年利率</th>
              <th class="color-main">期限</th>
              <th class="color-main">还款总额</th>
              <th class="color-main">放款日期</th>
              <th class="color-main">操作</th>
            </th>
            <c:forEach var="project" items="${projectsi}">
            <tr>
              <td><a href="${ctx}/loan/productsloan/project.ht?projectId=${project.projectId}" target="_blank"> ${project.pname}</a></td>
              <td>${project.ploanReal}元</td>
              <td>${project.prateIn}%</td>
              <td>${project.pdeadline}个月</td>
              <td>${project.psumPayBack}元</td>
              <td><fmt:formatDate value="${project.phavedPayTime}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
              <td><a class="handle-btn bgc-s bdc-s-l" href="${ctx}/project/projectRepayment.ht?projectId=${project.projectId}">还款管理</a></td>
            </tr>
            </c:forEach>
           
          </table>
        </div>
        <div class="con-box con-box-huankuaned con-box-wodejiekuan bd-b-color-main bd-l-color-main bd-r-color-main" style="display:none;">
          <table>
            <tr>
              <th class="color-main">借款项目名称</th>
              <th class="color-main">金额</th>
              <th class="color-main">年利率</th>
              <th class="color-main">期限</th>
              <th class="color-main">还款总额</th>
              <th class="color-main">放款日期</th>
            </th>
             <c:forEach var="project" items="${projects}">
            <tr>
              <td><a href="${ctx}/loan/productsloan/project.ht?projectId=${project.projectId}"  target="_blank">${project.pname}</a></td>
              <td>${project.ploanReal}元</td>
              <td>${project.prateIn}%</td>
              <td>${project.pdeadline}个月</td>
              <td>${project.psumPayBack}元</td>
              <td><fmt:formatDate value="${project.phavedPayTime}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
            </tr>
            </c:forEach>
            
          </table>
        </div>
        <pageTag:paging form="pageForm"/>
        </form>
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
  })
  </script>
</body>
</html>