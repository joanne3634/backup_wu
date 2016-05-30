<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag import="com.deelon.loan.service.front.HomeIndexPageService"%>
<%@tag import="com.deelon.loan.model.sysManager.TSetHomepage"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="通知公告"%>
<%@tag import="java.util.*"%>
<%
	StringBuffer sb = new StringBuffer("");
	HomeIndexPageService homePageService=(HomeIndexPageService)AppUtil.getBean(HomeIndexPageService.class);
    TSetHomepage homepageMoudle = homePageService.getHomePageMoudleByCode("TopTel");//获取投资列表
    if(null!=homepageMoudle&&homepageMoudle.getIsVisiable()==1){
		sb.append(" 服务电话：<span>"+application.getAttribute("TOP_CUCTOMER_SERVICE_TELEPHONE")+"</span> ");
    }
	out.print(sb.toString());
%>