<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag import="com.deelon.loan.service.front.HomeIndexPageService"%>
<%@tag import="com.deelon.loan.model.sysManager.TSetHomepage"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="通知公告"%>
<%@tag import="java.util.*"%>
<%
	StringBuffer sb = new StringBuffer("");
	HomeIndexPageService homePageService=(HomeIndexPageService)AppUtil.getBean(HomeIndexPageService.class);
    TSetHomepage homepageMoudle = homePageService.getHomePageMoudleByCode("BottomTel");//获取投资列表
    if(null!=homepageMoudle&&homepageMoudle.getIsVisiable()==1){
		sb.append(" <ul class=\"mobile-nav\"> ");
		sb.append(" <li class=\"li1\">客服电话</li> ");
		sb.append(" <li class=\"li2\">"+application.getAttribute("BOTTTOM_CUCTOMER_SERVICE_TELEPHONE")+"</li> ");
		sb.append(" <li class=\"li3\">工作日："+application.getAttribute("TRADING_HOURS") +"</li> ");
		sb.append(" </ul> ");
    }
	out.print(sb.toString());
%>