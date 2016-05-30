<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag import="com.deelon.loan.service.front.HomeIndexPageService"%>
<%@tag import="com.deelon.loan.model.sysManager.TSetHomepage"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="平台亮点"%>
<%@tag import="java.util.*"%>
<%
	StringBuffer sb = new StringBuffer("");
	HomeIndexPageService homePageService=(HomeIndexPageService)AppUtil.getBean(HomeIndexPageService.class);
    TSetHomepage homepageMoudle = homePageService.getHomePageMoudleByCode("goodPoint");//平台亮点
    if(null!=homepageMoudle&&homepageMoudle.getIsVisiable()==1){
		sb.append(" <ul class=\"main-body tese\"> ");
		sb.append("  <li><img src=\"images/30beihuoqi.png\" alt=\"\"></li> ");
		sb.append(" <li><img src=\"images/50yuanjiaru.png\" alt=\"\"></li> ");
		sb.append(" <li><img src=\"images/100benxidanbao.png\" alt=\"\"></li> ");
		sb.append(" <li><img src=\"images/suishishuhui.png\" alt=\"\"></li> ");
      	sb.append(" <li><img src=\"images/fuwumianfei.png\" alt=\"\"></li> </ul> ");
    }
	out.print(sb.toString());
%>