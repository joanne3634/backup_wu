 <%@page import="com.deelon.loan.model.front.TUser"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="f" uri="http://www.deelon.com/functions"%>
<%@ taglib prefix="pageTag" tagdir="/WEB-INF/tags/pageTag"%>
<%@page import="java.util.List"%>
<%@page import="com.deelon.core.util.AppUtil"%>
<%@page
	import="com.deelon.cmsform.service.site.CmsSiteMenuContentService"%>
<%@page import="com.deelon.cmsform.model.site.CmsSiteMenuContent"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
<link rel="stylesheet"
	href="${ctx }/styles/p2p/Skin/Default/css/Successstory.css">
</head>
<script type="text/javascript">
$(function(){
	$("#messageList").find("p").each(function(e,index){
		var val=$(this).html().trim();
		var _length=val.length;
		var val2 =null; 
		if(_length>80){
  			for(var   i=0;   i<75;   i++)   val2   +=   val[i];   
				val2 = val2+"..."; 
				$(this).html(val2);
		}
	});
});

</script>
<body>
    <div class="con">
		<ul>
			<c:forEach items="${TUserSuccessstoryList }" var="list">
				<li>
					<a href="${ctx }/loan/aboutus/tUserSuccessstory/SuceesstoryDetails.ht?messageid=${list.successstoryId }">${list.subject }</a>
					<p class="p1">分享用户:<f:description modelCode="t_user"  modelPropertyName="loginName" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${list.userId }"/>
					&nbsp;&nbsp;&nbsp;&nbsp;年龄： <f:description modelCode="t_user"  modelPropertyName="age" modelPropertyValue="id" nodeKey="MODEL_DATA"  itemValue="${list.userId }"/><span>所在单位：<span  ><pageTag:SuccessStory menupath="${list.userId }" /> </span></span></p>
					<p id="messageList"><p>标题:&nbsp;${list.subject}</p></p>
					<span>分享时间：<fmt:formatDate value="${list.createTime}" pattern="yyyy-MM-dd"/></span>
				</li>
			</c:forEach>
		</ul>
	</div>
       <form action="" name="pageForm" id="pageForm">
<pageTag:paging form="pageForm"/>
</form>
<!--         <li> -->
<!--             <a href="sucessfulCaseDetail.html">我的理财之旅</a> -->
<!--             <p class="p1">***any 28岁 (2014年7月加入 已经投资4次)<span>累计总金额：<span class="fs24">¥470，000</span></span></p> -->
<!--             <p>同学聚会无意闲聊的时候说起了投资，一个新的投资渠道P2P然后提到了P2P贷，对其有了初步的了解。然后通过研究和其它平台的对比，最终选择了在P2P贷进行投资。</p> -->
<!--             <span>分享时间：2014-07-07</span> -->
<!--         </li> -->
<!--         <li> -->
<!--             <a href="sucessfulCaseDetail.html">我的理财之旅</a> -->
<!--             <p class="p1">***any 28岁 (2014年7月加入 已经投资4次)<span>累计总金额：<span class="fs24">¥470，000</span></span></p> -->
<!--             <p>同学聚会无意闲聊的时候说起了投资，一个新的投资渠道P2P然后提到了P2P贷，对其有了初步的了解。然后通过研究和其它平台的对比，最终选择了在P2P贷进行投资。</p> -->
<!--             <span>分享时间：2014-07-07</span> -->
<!--         </li> -->
<!--         <li> -->
<!--             <a href="sucessfulCaseDetail.html">我的理财之旅</a> -->
<!--             <p class="p1">***any 28岁 (2014年7月加入 已经投资4次)<span>累计总金额：<span class="fs24">¥470，000</span></span></p> -->
<!--             <p>同学聚会无意闲聊的时候说起了投资，一个新的投资渠道P2P然后提到了P2P贷，对其有了初步的了解。然后通过研究和其它平台的对比，最终选择了在P2P贷进行投资。</p> -->
<!--             <span>分享时间：2014-07-07</span> -->
<!--         </li> -->
<!--         <li> -->
<!--             <a href="sucessfulCaseDetail.html">我的理财之旅</a> -->
<!--             <p class="p1">***any 28岁 (2014年7月加入 已经投资4次)<span>累计总金额：<span class="fs24">¥470，000</span></span></p> -->
<!--             <p>同学聚会无意闲聊的时候说起了投资，一个新的投资渠道P2P然后提到了P2P贷，对其有了初步的了解。然后通过研究和其它平台的对比，最终选择了在P2P贷进行投资。</p> -->
<!--             <span>分享时间：2014-07-07</span> -->
<!--         </li> -->
<!--         <li> -->
<!--             <a href="sucessfulCaseDetail.html">我的理财之旅</a> -->
<!--             <p class="p1">***any 28岁 (2014年7月加入 已经投资4次)<span>累计总金额：<span class="fs24">¥470，000</span></span></p> -->
<!--             <p>同学聚会无意闲聊的时候说起了投资，一个新的投资渠道P2P然后提到了P2P贷，对其有了初步的了解。然后通过研究和其它平台的对比，最终选择了在P2P贷进行投资。</p> -->
<!--             <span>分享时间：2014-07-07</span> -->
<!--         </li> -->
<!--         <li> -->
<!--             <a href="sucessfulCaseDetail.html">我的理财之旅</a> -->
<!--             <p class="p1">***any 28岁 (2014年7月加入 已经投资4次)<span>累计总金额：<span class="fs24">¥470，000</span></span></p> -->
<!--             <p>同学聚会无意闲聊的时候说起了投资，一个新的投资渠道P2P然后提到了P2P贷，对其有了初步的了解。然后通过研究和其它平台的对比，最终选择了在P2P贷进行投资。</p> -->
<!--             <span>分享时间：2014-07-07</span> -->
<!--         </li> -->
<!--       </ul> -->
<!--       <div class="paging-index-box"> -->
<!--         <a href="javascript:;">首页</a>  -->
<!--         <a href="javascript:;">上一页</a>  -->
<!--         <a class="page-num" href="javascript:;">1</a>  -->
<!--         <a class="page-num" href="javascript:;">2</a>  -->
<!--         <a class="page-num" href="javascript:;">3</a> -->
<!--         <a class="page-num" href="javascript:;">4</a>  -->
<!--         <a class="page-num" href="javascript:;">5</a>  -->
<!--         <a class="page-num" href="javascript:;">6</a> ---  -->
<!--         <a href="javascript:;">下一页</a>  -->
<!--         <a href="javascript:;">尾页</a> -->
     
</body>