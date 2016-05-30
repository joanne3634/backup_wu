<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
</head>
<body>

        <div class="tit-box element-box bd-color-main bg-color-s"><span class="tit-xxl color-main">我的借款</span></div>
        <div class="con-box con-box-wodejiekuan bd-b-color-main bd-l-color-main bd-r-color-main">
          <div class="sea-condi"><span class="bg-color-l">借款状态 :</span><div class="onejiao bd-l-color-l"></div>
            <a id="a0" class="hover" style="margin-left:20px;" href="javascript:ajaxmyallproject('');">全部</a>
            <a id="a1" href="javascript:ajaxmyallproject('1');">待审核</a>
            <a id="a3" href="javascript:ajaxmyallproject('3');">筹集中</a>
            <a id="a2" href="javascript:ajaxmyallproject('2');">等待订立合同</a>
            <a id="a5" href="javascript:ajaxmyallproject('5');">等待成立</a>
            <a id="a6" href="javascript:ajaxmyallproject('6');">还款中</a>
            <a id="a7" href="javascript:ajaxmyallproject('7');">已还款</a>
            <a id="a8" href="javascript:ajaxmyallproject('8');">未成立</a>
          </div>
       <form id="pageForm" name="pageForm" action="${ctx }/project/myallinprojects.ht#">
       	  <input type="hidden" name="status" id="status" value="${status}"/>
          <div class="zongjie">查询到借款共 <span class="color-main" id="counts">${counts}</span> 笔，总借款金额 <span class="color-main" id="sumLoan">${sumLoan}</span> 元</div>
          <table class="" id="myallin">
            <tr>
              <th class="color-main">借款标题</th>
              <th class="color-main">借款金额</th>
              <th class="color-main">年化利率</th>
              <th class="color-main">投资到期日</th>
              <th class="color-main">交易时间</th>
              <th class="color-main">状态</th>
              <th class="color-main">操作</th>
            </th>
            <c:forEach var="project" items="${projects}">
            <tr>
              <td>${project.pname}</td>
              <td>${project.ploan}元</td>
              <td>${project.prateIn}%</td>
              <td><fmt:formatDate value="${project.pcloseDate}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
              <td><fmt:formatDate value="${project.popenDate}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
              <td><c:choose>
						<c:when test="${project.pstatusId==1}">
							<span class=""><a href="${ctx}/loan/productsloan/project.ht?projectId=${project.projectId}&productId=${project.productsLoanId}" target="_blank">待审核</a></span>
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
              <td><a class="bdc-s-l bgc-s handle-btn" href="${ctx}/loan/productsloan/project.ht?projectId=${project.projectId}" target="_blank">查看</a></td>
            </tr>
            </c:forEach>
          </table><pageTag:paging form="pageForm"/>
          </form>
          </div>
  <script>
  	function ajaxmyallproject(value){
  		$("#status").val(value);
  		$("#pageForm").submit();
  		<%--var html="<tr> <th>借款标题</th> <th>借款金额</th> <th>年化利率</th> <th>投资到期日</th> <th>交易时间</th> <th>状态</th> <th>操作</th> </tr>";
 	 	$.ajax({
			type: "get",
			url: "${ctx}/project/ajaxallinprojects.ht?status="+value,
			dataType:"json",
			success: function(data){
				$("#counts").html(data[0].counts);
				$("#sumLoan").html(data[0].sumLoan);
				$(data).each(function(){
						var controlStr='';
						if(this.pstatusId==1){
							controlStr=" <a href=javascript:window.open('${ctx}/loan/productsloan/project.ht?projectId="+this.projectId+"&productId="+this.productsLoanId+"')>待审核</a>";}
					    else if(this.pstatusId==2){
					    	controlStr='<span class="green">担保审核</span>';}
						else if(this.pstatusIdpstatusId==3){
							controlStr='<span class="green">平台审核</span>';}
						else if(this.pstatusId==4){
							controlStr='<span class="green">招标中</span>';}
						else if(this.pstatusId==5){
							controlStr='<span class="green">满标</span>';}
						else if(this.pstatusId==6){
							controlStr='<span class="green">还款中</span>';}
						else if(this.pstatusId==7){
							controlStr='<span class="green">已还完</span>';}
						else{
							controlStr='<span class="red">流标</span>';
				       	}
						if(this.pname){
							html+="<tr><td>"+this.pname+"</td><td>"+this.ploan+"元</td><td>"+this.prateIn+"%</td><td>"+this.pcloaseDateStr+"</td><td>"+this.popenDateStr+"</td><td>"+controlStr+"</td><td><a href=javascript:window.open('${ctx}/loan/productsloan/project.ht?projectId="+this.projectId+"')>查看</a></td></tr>";
						}
				});
				$("#myallin").html(html);
			}
		});--%>
 	 	
 	}
  $(function(){
    $(".sea-condi a").click(function(){
      $(".sea-condi a").removeClass("hover");
      $(this).addClass("hover");
    });
    if("${status}"){
    	$("#a0").removeClass("hover");
    	$("#a"+"${status}").addClass("hover");
    }
  });
  </script>
</body>
</html>