<%@tag import="com.deelon.loan.util.HtmlRegexpUtil"%>
<%@tag import="com.deelon.core.util.DateFormatUtil"%>
<%@tag import="com.deelon.loan.service.front.HomeIndexPageService"%>
<%@tag import="com.deelon.cmsform.model.site.CmsSiteMenuContent"%>
<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag import="com.deelon.cmsform.service.site.CmsSiteMenuContentService"%>
<%@tag import="com.deelon.loan.model.sysManager.TSetHomepage"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="行业资讯"%>
<%@tag import="java.util.*"%>
<%
	StringBuffer sb = new StringBuffer("");
	HomeIndexPageService homePageService=(HomeIndexPageService)AppUtil.getBean(HomeIndexPageService.class);
	TSetHomepage homepageMoudle = homePageService.getHomePageMoudleByCode("newscf");//行业资讯
	if(null!=homepageMoudle&&homepageMoudle.getIsVisiable()==1){
	    CmsSiteMenuContentService cmsSiteMenuContentService=(CmsSiteMenuContentService)AppUtil.getBean(CmsSiteMenuContentService.class);
		List<CmsSiteMenuContent> list=cmsSiteMenuContentService.getMenuId(menupath); 
		int len=0;
		if(list.size()>homepageMoudle.getRecords()){ 
			len=homepageMoudle.getRecords();
		} 
		else{
			len=list.size();
		}
		 
		sb.append(" <div class=\"message f_l\"> <h3><img src=\""+application.getAttribute("ctx")+"/crowdfunding/Skin/Default/images/trianglegray.png\">最新资讯<a href=\""+application.getAttribute("ctx")+"/site/Investmessage/InvestmessageList.ht\"  target=\"_blank\">查看更多</a></h3> <div class=\"messageContent\"> <ul>");
		
		for(int i=0;i<len;i++){  
			CmsSiteMenuContent c=list.get(i);
			/* c.getContentFileIds(); 
		    String fileId= c.getFilesIds(); 
			String url=application.getAttribute("PLATFORM-SYSTEM-URL")+"/platform/system/sysFile/getFileById.ht?fileId="+fileId;
			if(null==fileId||"".equals(fileId)){
				url=application.getAttribute("ctx")+"/crowdfunding/Skin/Default/images/zwtp2.jpg";
			}
			String contentStr = (c.getContentSummary().length()>91?c.getContentSummary().substring(0,90)+"...":c.getContentSummary());
			if(null==contentStr||"".equals(contentStr)){
				contentStr = HtmlRegexpUtil.filterHtml(c.getContentText());
				contentStr = (contentStr.length()>91?contentStr.substring(0,90)+"...":contentStr);
			} */
		//	sb.append("  <li  class=\"clear\" > <a href='"+application.getAttribute("ctx")+"/site/Investmessage/InvestmessageDetails.ht?id="+c.getSiteMenuContentId()+"' target=\"_blank\"> <img src=\""+url+"\"> </a> <div><h4  title=\""+c.getContentTitle()+"\"><a href='"+application.getAttribute("ctx")+"/site/Investmessage/InvestmessageDetails.ht?id="+c.getSiteMenuContentId()+"' target=\"_blank\">"+c.getContentTitle()+"</a></h4> "+contentStr+"</div> </li>");
			
			   sb.append(" <div class=\"DynamicList\"> ");
				sb.append(" <span>"+DateFormatUtil.formaDatetTime(c.getContentCreateDate())+"</span>");
			//	tcprojectNews.setPncontent(HtmlRegexpUtil.filterHtml(tcprojectNews.getPncontent()));
		//		sb.append(" <h4  title=\""+tcprojectNews.getPntitle()+"\"><a href='"+application.getAttribute("ctx")+"/tcproject/ProjectDynamic/edit.ht?newsId="+tcprojectNews.getNewsId()+"' target=\"_blank\">"+tcprojectNews.getPntitle()+" </a> </h4> <a href='"+application.getAttribute("ctx")+"/tcproject/ProjectDynamic/edit.ht?newsId="+tcprojectNews.getNewsId()+"' target=\"_blank\"><img src=\""+url+"\"></a> ");
				sb.append("<div class=\"DynamicContent\"> <h5  title=\""+c.getContentTitle()+"\"><a href='"+application.getAttribute("ctx")+"/site/Investmessage/InvestmessageDetails.ht?id="+c.getSiteMenuContentId()+" target=\"_blank\"> "+c.getContentTitle()+" </a></h5> </div>  </div>");
		}
		sb.append("	</ul> <div class=\"clear\"></div> </div> </div>");
	}
	out.print(sb.toString());
%>