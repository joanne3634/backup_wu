<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="com.deelon.loan.model.front.TUser" %>
<%@page import="com.deelon.loan.util.TUserUtil" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="f" uri="http://www.deelon.com/functions" %>
<%@ taglib prefix="pageTag" tagdir="/WEB-INF/tags/pageTag" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%
    TUser u = TUserUtil.getLogUser(request);
%>
<script type="text/javascript">
    $(function () {
        <%if(u!=null){ %>
        $.ajax({
            url: "${ctx}/loan/tuserMsgRemind/getTUserMsgCount.ht",
            dataType: 'json',
            type: 'post',
            success: function (userMsgCount) {
                if (userMsgCount) {
                    var data = userMsgCount;
                    if (data && data > 0) {
                        var msgShow;
                        if (data > 99) {
                            msgShow = "99+";
                        } else {
                            msgShow = data;
                        }
                        $("#userMsg").text(msgShow);
                        $("#num-box").show();
                    }
                }
            }
        });
        <%}%>
	});
	
	</script>
	<div class="head">
	
		<div>
			<a href="${ctx}/index-web.jsp" target="_top"><img src="${ctx}<%=application.getAttribute("PLATFORM_LOGO") %>"></a>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="${ctx }/index-web.jsp" target="_top"><font size="4px">首页</font></a>
			&nbsp;&nbsp;&nbsp;
			<a href="${ctx }/crowdfunding/front/tofinancingPro.ht"  target="_top"><font size="4px">项目浏览</font></a>
			&nbsp;&nbsp;&nbsp;
			<a href="${ctx }/crowdfunding/tcuserInvestor/tcuserInvestorPage.ht" target="_top"><font size="4px">投资人</font></a>
			&nbsp;&nbsp;&nbsp;
			<a href="${ctx }/tcproject/ProjectDynamic/ProjectDynamicList.ht" target="_top"><font size="4px">项目动态</font></a>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<span>
				<form style="margin:0px;display:inline;" id="queryform" method="post" action="${ctx }/crowdfunding/tcproject/querywebinfos.ht">
					<input type="text" name="paramValue" value="${paramNow}" placeholder="找项目、投资人。。。" style="width: 300px;height: 30px;"/>
					&nbsp;&nbsp;<span onclick="query()"><font size="4px">搜索</font></span>
				</form>
			</span>
			
			<%if(u==null){ %>
			    &nbsp;&nbsp;<a href="${ctx }/user/registerInit.ht"><font size="4px">注册</font></a>
				<%--&nbsp;&nbsp;<a href="${ctx }/user/registerInit.ht?type=1"><font size="4px">注册创业、者</font><、--%>
				&nbsp;&nbsp;<a href="${ctx }/loginWeb.jsp"><font size="4px">登录</font></a>
			<%}else{ %>		
				<a class="gray" >欢迎您:<%=u.getLoginName(  ) %></a>
				<div style=" float: right;display:none;cursor:pointer; position: relative;right: 250px;bottom:-21px;" id="num-box" title="未读信息" onclick="window.location.href='${ctx}/loan/myAccount/myaccountPage.ht?flag=/loan/tuserMsgRemind/myInbox.ht'" >
		        	<div style="float: left;background-image:url(${ctx}/crowdfunding/Skin/Default/images/zuobanyuan.png);height: 18px;width: 8px;background-repeat: no-repeat;"></div>
		        	<div style="float: left;height: 18px; line-height: 18px; background-color: #ff5704; color: #fff;" id="userMsg"></div>
		        	<div style="float: left;background-image:url(${ctx}/crowdfunding/Skin/Default/images/youbianyuan.png);height: 18px;width: 8px;background-repeat: no-repeat;"></div>
		        </div>
				<a class="color-main" href="${ctx }/loan/myAccount/myaccountPage.ht">[会员中心]</a>
				<a class="color-main" href="${ctx }/user/logout.ht">退出</a>
			 <%} %>
		</div>
	
	
	</div>
	<script type="text/javascript">
	 	function query(){
	 		 $("#queryform").submit();
	 	}
	 	function unReadMsgSet(userMsgCount){
	 		if(userMsgCount!='0'){
				var data = userMsgCount;
				if(data && data>0){
					var msgShow;
					if(data>99){
						msgShow = "99+";
					}else{
						msgShow = data;
					}
					$("#userMsg").text(msgShow);
					$("#num-box").show();
				}
			}else{
				$("#num-box").hide();
			}
	 	}
	</script>