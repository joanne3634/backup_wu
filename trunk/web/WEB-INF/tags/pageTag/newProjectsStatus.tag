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
			 
			sb.append(" <div class=\"message f_l\"> <h3><img src=\""+application.getAttribute("ctx")+"/crowdfunding/Skin/Default/images/trianglegray.png\">项目动态<a href=\""+application.getAttribute("ctx")+"/tcproject/ProjectDynamic/ProjectDynamicList.ht\"  target=\"_blank\">查看更多</a></h3> ");
			Long projectId=0l;
			int count = 0;
			for(int i=0;i<5;i++){  
				TcprojectNews tcprojectNews=(TcprojectNews)list.get(i);  
				/* if(count==len){
					break;
				}
				if(projectId.compareTo(tcprojectNews.getProjectId())!=0){
					projectId = tcprojectNews.getProjectId();
					count++;
				}else{
					continue;
				}
				tcprojectNews.getFileId();
				 */
				
				/* String url="";
				if(null!=tcprojectNews.getFilesIds()&&!"".equals(tcprojectNews.getFilesIds())){
			    	url=application.getAttribute("PLATFORM-SYSTEM-URL")+"/platform/system/sysFile/getFileById.ht?fileId="+tcprojectNews.getFilesIds();
			    }else{
			    	url=application.getAttribute("ctx")+"/crowdfunding/Skin/Default/images/zwtp1.jpg";
			    } */
			/* 	if(i<len-1){
					sb.append(" <div class=\"DynamicList\"> ");
				}else{
					sb.append(" <div class=\"DynamicList\" style=\"border:0px;\">");
				} */
			    sb.append(" <div class=\"DynamicList\"> ");
				sb.append(" <span>"+DateFormatUtil.formaDatetTime(tcprojectNews.getCreateTime())+"</span>");
			//	tcprojectNews.setPncontent(HtmlRegexpUtil.filterHtml(tcprojectNews.getPncontent()));
		//		sb.append(" <h4  title=\""+tcprojectNews.getPntitle()+"\"><a href='"+application.getAttribute("ctx")+"/tcproject/ProjectDynamic/edit.ht?newsId="+tcprojectNews.getNewsId()+"' target=\"_blank\">"+tcprojectNews.getPntitle()+" </a> </h4> <a href='"+application.getAttribute("ctx")+"/tcproject/ProjectDynamic/edit.ht?newsId="+tcprojectNews.getNewsId()+"' target=\"_blank\"><img src=\""+url+"\"></a> ");
				sb.append("<div class=\"DynamicContent\"> <h5  title=\""+tcprojectNews.getPname()+"\"><a href='"+application.getAttribute("ctx")+"/crowdfunding/front/toProDetails.ht?projectId="+tcprojectNews.getProjectId()+"' target=\"_blank\"> "+tcprojectNews.getPname()+" </a></h5> </div>  </div>");
			}
			sb.append("	</div>");
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