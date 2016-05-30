<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag import="com.deelon.loan.service.front.HomeIndexPageService"%>
<%@tag import="com.deelon.loan.model.sysManager.TSetHomepage"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="通知公告"%>
<%@tag import="java.util.*"%>
<%
	StringBuffer sb = new StringBuffer("");
	HomeIndexPageService homePageService=(HomeIndexPageService)AppUtil.getBean(HomeIndexPageService.class);
    TSetHomepage homepageMoudle = homePageService.getHomePageMoudleByCode("zhiyin");//获取投资列表
    if(null!=homepageMoudle&&homepageMoudle.getIsVisiable()==1){
		sb.append(" <h2> <img src=\"images/zhiyin.png\" alt=\"\"> </h2> <div class=\"zhiyin\"> ");
		sb.append(" <a href=\""+application.getContextPath()+"/user/registerInit.ht\"><img src=\"images/zhuce.png\" alt=\"\"></a><img src=\"images/jiantou.png\" alt=\"\"> ");
		sb.append(" <img src=\"images/renzheng.png\" alt=\"\"><img src=\"images/jiantou.png\" alt=\"\"> ");
		sb.append(" <img src=\"images/chongzhi.png\" alt=\"\"><img src=\"images/jiantou.png\" alt=\"\"> ");
		sb.append(" <img src=\"images/touzi.png\" alt=\"\"></div>");
      
    }
	out.print(sb.toString());
%>