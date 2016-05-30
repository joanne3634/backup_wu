<%@tag import="com.deelon.cmsform.model.site.CmsSiteMenuContent"%>
<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag import="com.deelon.cmsform.service.site.CmsSiteMenuContentService"%>
<%@tag import="com.deelon.loan.service.front.HomeIndexPageService"%>
<%@tag import="com.deelon.loan.model.sysManager.TSetHomepage"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="通知公告"%>
<%@tag import="java.util.*"%>
<%
	StringBuffer sb = new StringBuffer("");
	HomeIndexPageService homePageService=(HomeIndexPageService)AppUtil.getBean(HomeIndexPageService.class);
    TSetHomepage homepageMoudle = homePageService.getHomePageMoudleByCode("notice");//获取投资列表
    if(null!=homepageMoudle&&homepageMoudle.getIsVisiable()==1){
	     CmsSiteMenuContentService cmsSiteMenuContentService=(CmsSiteMenuContentService)AppUtil.getBean(CmsSiteMenuContentService.class);
		List<CmsSiteMenuContent> list=cmsSiteMenuContentService.getMenuId(menupath);
		sb.append("<a href=\""+application.getAttribute("ctx")+"/loan/aboutus/NoticeList.ht\"><h2><img src=\"images/gonggao.png\" alt=\"\"></h2></a>");
		sb.append("<ul class=\"gonggao\">");
		int len=0;
		if(list.size()>homepageMoudle.getRecords()){ 
			len=homepageMoudle.getRecords();
		} 
		else{
			len=list.size();
		}
		for(int i=0;i<len;i++){  
		CmsSiteMenuContent c=list.get(i); 
		sb.append("<li><a href=\""+application.getAttribute("ctx")+"/site/AboutUs/AboutUsList.ht?srcurl='loan/aboutus/NoticeList.ht?id="+c.getSiteMenuContentId()+"'\" title=\""+c.getContentTitle()+"\">"+c.getContentTitle()+"</a>"); 
		}
		sb.append("</ul>");
    }
	out.print(sb.toString());
%>