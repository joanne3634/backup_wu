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


		sb.append("<div class=\"xlarge-50 large-50 medium-50 small-50 tiny-100\">");
		sb.append("<div class=\"title\">");
		sb.append("<h3><i class=\"fa fa-th-large\"></i> 最新资讯</h3>");
		sb.append("<a class=\"ink-button blue push-right\" href=\""+application.getAttribute("ctx")+"/site/Investmessage/InvestmessageList.ht"+"\" target=\"_blank\">查看更多</a>");
		sb.append("</div>");
		sb.append("<section class=\"lists\">");
		sb.append("<ol>");

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

			sb.append("<li title=\""+c.getContentTitle()+"\">");
			sb.append("<a target=\"_blank\" href=\""+application.getAttribute("ctx")+"/site/Investmessage/InvestmessageDetails.ht?id="+c.getSiteMenuContentId()+"\">");
			sb.append("<span class=\"title\">"+c.getContentTitle()+"</span>");
			sb.append("<span class=\"datetime push-right\">"+DateFormatUtil.formaDatetTime(c.getContentCreateDate())+"</span>");
			sb.append("</a>");
			sb.append("</li>");
		}
		sb.append("</ol>");
		sb.append("</section>");
		sb.append("</div>");
	}
	out.print(sb.toString());
%>