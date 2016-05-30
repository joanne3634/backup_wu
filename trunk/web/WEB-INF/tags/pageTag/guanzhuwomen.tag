<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag import="com.deelon.loan.service.front.HomeIndexPageService"%>
<%@tag import="com.deelon.loan.model.sysManager.TSetHomepage"%>
<%@tag pageEncoding="utf-8"%>
<%@tag import="java.util.*"%>
<%
	StringBuffer sb = new StringBuffer("");
	HomeIndexPageService homePageService=(HomeIndexPageService)AppUtil.getBean(HomeIndexPageService.class);
    TSetHomepage homepageMoudle = homePageService.getHomePageMoudleByCode("guanzhuwomen");//关注我们
    if(null!=homepageMoudle&&homepageMoudle.getIsVisiable()==1){
		sb.append(" <h2><img src=\"images\\guanzhuwomen.png\" alt=\"\"></h2>  ");
		sb.append("  <ul class=\"guanzhuwomen\"> ");
		sb.append(" <li><a class=\"weixin\" href=\"http://"+application.getAttribute("MICRO_LETT_CODE")+"\" target=\"_blank\">QQ微信</a></li> ");
		sb.append(" <li><a class=\"xinlangweibo\" href=\"http://"+application.getAttribute("SINA_MICROBLOG")+"\" target=\"_blank\">新浪微博</a></li> ");
		sb.append(" <li><a class=\"tengxunweibo\" href=\"http://"+application.getAttribute("TENCENT_MICROBOLG")+"\" target=\"_blank\">腾讯微博</a></li> ");
      	sb.append(" </ul> ");
    }
	out.print(sb.toString());
%>