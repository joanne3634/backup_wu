<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
</head>
<body>
  <script type="text/javascript" src="${ctx}/js/calendar/My97DatePicker/WdatePicker.js"></script>

 
        <div class="tit-box element-box bg-color-s bd-color-main"><span class="tit-xxl color-main">借款申请查询</span></div>
        
        <form id="pageForm" name="pageForm" action="${ctx }/project/myapprojects.ht#">
        <div class="con-box con-box-wodejiekuan con-box-jibenxinxi bd-l-color-main bd-b-color-main bd-r-color-main">
          <div class="selectDate-box con-table-right">从：
	          <input id="start" name="start" type="text" class="inputText Wdate" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'start\');}'})" value="${param['start']}"> 到
	          <input id="end" name="end" type="text" class="inputText Wdate" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'end\');}'})" value="${param['end']}">
	          <input id="sub-btn-jibenxinxi" class="sub-btn bg-color-l" type="button" value="查询">
          </div>
          <table>
          <tr>
            <th class="color-main">借款标题</th>
            <th class="color-main">借款金额</th>
            <th class="color-main">年利率</th>
            <th class="color-main">期限</th>
            <th class="color-main">状态</th>
          </tr>
          <c:forEach var="project" items="${projects}">
          <tr>
            <td class=""><a href="${ctx}/loan/productsloan/project.ht?projectId=${project.projectId}" target="_blank">${project.pname}</a></td>
              <td>${project.ploanReal}元</td>
              <td>${project.prateIn}%</td>
              <td>${project.pdeadline}个月</td>
              <td><c:choose>
						<c:when test="${project.pstatusId==1}">
							<span class="">待审核</span>
						</c:when>
					   	<c:when test="${project.pstatusId==2}">
						   	<span class="">担保审核</span>
					   	</c:when>
					   	<c:when test="${project.pstatusId==3}">
						   	<span class="">平台审核</span>
					   	</c:when>
					   	<c:when test="${project.pstatusId==4}">
						   	<span class="">招标中</span>
					   	</c:when>
					   	<c:when test="${project.pstatusId==5}">
						   	<span class="">满标</span>
					   	</c:when>
					   	<c:when test="${project.pstatusId==6}">
						   	<span class="">还款中</span>
					   	</c:when>
					   	<c:when test="${project.pstatusId==7}">
						   	<span class="">已还完</span>
					   	</c:when>
				       	<c:otherwise>
				       		<span class="red">流标</span>
					   	</c:otherwise>
				   </c:choose>
				</td>          
          </tr>
          </c:forEach>
        </table>
        </div>
  		<pageTag:paging form="pageForm"/>
     </form>   
  <script>
  $(function(){
	  $("#sub-btn-jibenxinxi").click(function(){
		  if($("#end").val()!=''&&$("#start").val()>$("#end").val()){
			  alert("请选择的开始时间不能大于截止时间。");
		  }else{
			  $("#pageForm").submit();
			  //window.location.href="${ctx}/project/myapprojects.ht?start="+$("#start").val()+"&end="+$("#end").val();
		  }
	  });
	 
  
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
  });
  </script>
</body>
</html>