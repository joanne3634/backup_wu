<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
</head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
 <ul class="pro-rel" >
      <li class="pro-rel-tit">
        <span style="width:70px;">转让人</span>
        <span style="width:240px;">借款人头像  /  信用指数  /  用户名 </span>
        <span style="width:150px;">借款标题</span>
        <span style="width:70px;">是否有逾期</span>
        <span style="width:60px;">竞拍方式</span>
        <span style="width:170px;">债权总额/竞拍底价/年利率</span>
        <span style="width:100px;">剩余时间</span>
        <span style="width:80px;">操作</span>
      </li>
      <c:forEach var="transfer" items="${tprojectTransferList}">
      <li class="pro-rel-tra-ite" >
        <span style="width:50px;">${transfer.transferorName}</span>
        <span style="width:220px;" class="itespan">
        		<c:if test="${not empty transfer.fileId}">
					<img id="personPic" src="${ctx}/wuyouchou/system/sysFile/getFileById.ht?fileId=${transfer.fileId}" style="widows:220px;height:41px " alt="">
				</c:if>
				<c:if test="${empty transfer.fileId}"><img src="${ctx }/images/pro-tit-bg.png" alt=""  ></c:if>
        <a  class="checked color-main" >${transfer.project.pcertifiLevel}</a>
        <span >${transfer.lenderName}</span>
        </span>
        <span style="width:130px;" class="spanname"><a href="${ctx }/myAccount/transferDetails.ht?transferId=${transfer.transferId}" target="top">${transfer.project.pname}</a></span>
        <span style="width:50px;">
        	<c:if test="${transfer.project.pisLate==1}">是</c:if>
        	<c:if test="${transfer.project.pisLate==0}">否</c:if>
        </span>
        <span style="width:40px;">
        	<c:if test="${transfer.auctionWay==1}">明拍</c:if>
        	<c:if test="${transfer.auctionWay==2}">暗拍</c:if>
        </span>
        <span class="color-main" style="width:150px;">
          <span>${transfer.claimsSum}</span>
          <span>${transfer.upsetPrice}元/${transfer.project.prateOut}% </span>
        </span>
        <span style="width:80px;">${transfer.remainTime}</span>
        <span style="width:60px;" class="pro-rel-ite-caozuo"><a class="tra-btn-bg" id="tra-btn-bg"href="${ctx }/myAccount/auction.ht?transferId=${transfer.transferId}&closeDate=${transfer.closeDate}" target="_blank"></a></span>
      </li>
      </c:forEach>
	</ul>
    <pageTag:paging form="pageForm"/>
</body>
</html>