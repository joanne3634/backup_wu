<%@tag import="com.deelon.loan.util.HtmlRegexpUtil"%>
<%@tag import="com.deelon.core.util.DateFormatUtil"%>
<%@tag import="com.deelon.crowdfunding.model.backstage.TcprojectNews"%>
<%@tag import="com.deelon.crowdfunding.service.front.HomePageService"%>
<%@tag import="com.deelon.loan.service.front.HomeIndexPageService"%>
<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag import="com.deelon.loan.model.sysManager.TSetHomepage"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="最新项目动态"%>
<%@tag import="java.util.*"%>
<%
		StringBuffer sb = new StringBuffer("");
		HomeIndexPageService homePageService=(HomeIndexPageService)AppUtil.getBean(HomeIndexPageService.class);
		TSetHomepage homepageMoudle = homePageService.getHomePageMoudleByCode("newProjectsStatus");//获取最新项目动态
		if(null!=homepageMoudle&&homepageMoudle.getIsVisiable()==1){
			HomePageService pageService=(HomePageService)AppUtil.getBean(HomePageService.class);
			List<TcprojectNews> list=pageService.getTcprojectNewsByTypeId();
			int len=0;
			if(list.size()>homepageMoudle.getRecords()){ 
				len=homepageMoudle.getRecords();
			} 
			else{
				len=list.size();
			}

			sb.append("<div class=\"xlarge-50 large-50 medium-50 small-50 tiny-100\">");
			sb.append("<div class=\"title\">");
			sb.append("<h3><i class=\"fa fa-th-large\"></i> 项目动态</h3>");
			sb.append("<a class=\"ink-button blue push-right\" href=\""+application.getAttribute("ctx")+"/tcproject/ProjectDynamic/ProjectDynamicList.ht"+"\" target=\"_blank\">查看更多</a>");
			sb.append("</div>");
			sb.append("<section class=\"lists\">");
			sb.append("<ol>");
			Long projectId=0l;
			int count = 0;
			for(int i=0;i<len;i++){
				TcprojectNews tcprojectNews=(TcprojectNews)list.get(i);

				sb.append("<li title=\""+tcprojectNews.getPname()+"\">");
				sb.append("<a target=\"_blank\" href=\""+application.getAttribute("ctx")+"/crowdfunding/front/toProDetails.ht?projectId="+tcprojectNews.getProjectId()+"\">");
				sb.append("<span class=\"title\">"+tcprojectNews.getPname()+"</span>");
				sb.append("<span class=\"datetime push-right\">"+DateFormatUtil.formaDatetTime(tcprojectNews.getCreateTime())+"</span>");
				sb.append("</a>");
				sb.append("</li>");
			}

			sb.append("</ol>");
			sb.append("</section>");
			sb.append("</div>");
		}
	out.print(sb.toString());
%>

<!-- <div class="message f_l ">
			<h3><img src="./Skin/Default/images/trianglegray.png">项目动态<a href="./ProjectDynamic.html">查看更多</a></h3>
			<div class="DynamicList">
				<span>2014-06-10 22：44</span>
				
				<div class="DynamicContent">
					<h5><a href="./ProjectDynamicDetails.html">奇艺果艺术创意产品商城</a></h5> 
					
				
			</div>
			
		</div>
</div> -->