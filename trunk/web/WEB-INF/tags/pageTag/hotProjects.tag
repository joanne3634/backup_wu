<%@tag import="com.deelon.platform.util.ParamHelper"%>
<%@tag import="java.math.RoundingMode"%>
<%@tag import="java.math.BigDecimal"%>
<%@tag import="com.deelon.crowdfunding.model.backstage.Tcproject"%>
<%@tag import="com.deelon.crowdfunding.service.front.HomePageService"%>
<%@tag import="com.deelon.loan.service.front.HomeIndexPageService"%>
<%@tag import="com.deelon.cmsform.model.site.CmsSiteMenuContent"%>
<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag import="com.deelon.cmsform.service.site.CmsSiteMenuContentService"%>
<%@tag import="com.deelon.loan.model.sysManager.TSetHomepage"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="热门项目"%>
<%@tag import="java.util.*"%>
<%
		StringBuffer sb = new StringBuffer("");
		HomeIndexPageService homePageService=(HomeIndexPageService)AppUtil.getBean(HomeIndexPageService.class);
		TSetHomepage homepageMoudle = homePageService.getHomePageMoudleByCode("hotProjects");//获取热门项目
		if(null!=homepageMoudle&&homepageMoudle.getIsVisiable()==1){
			HomePageService pageService=(HomePageService)AppUtil.getBean(HomePageService.class);
			List<Tcproject> list=pageService.getTcprojectsByViewHot();
			int len=0;
			if(list.size()>homepageMoudle.getRecords()){ 
				len=homepageMoudle.getRecords();
			} 
			else{
				len=list.size();
			}
			
			sb.append(" <div class=\"hot clear\"> <h3><img src=\""+application.getAttribute("ctx")+"/crowdfunding/Skin/Default/images/trianglegray.png\">热门项目<a href=\""+application.getAttribute("ctx")+"/crowdfunding/front/tofinancingPro.ht?DescList=4\"  target=\"_blank\">查看更多</a></h3><div class=\"caseShade1\"><div class=\"caseShade2\"> <ul> ");
			for(int i=0;i<8;i++){ 
				Tcproject tcproject=(Tcproject)list.get(i);  
				tcproject.getPpic(); 
			    String fileId= tcproject.getFilesIds(); 
				String url="";
				if(null!=tcproject.getFilesIds()&&!"".equals(tcproject.getFilesIds())){
			    	url=application.getAttribute("PLATFORM-SYSTEM-URL")+"/platform/system/sysFile/getFileById.ht?fileId="+tcproject.getFilesIds();
			    }else{
			    	url=application.getAttribute("ctx")+"/crowdfunding/Skin/Default/images/zwtp1.jpg";
			    }
				 
				sb.append(" <li> <div class=\"caseImg\"> <a href='"+application.getAttribute("ctx")+"/crowdfunding/front/toProDetails.ht?projectId="+tcproject.getProjectId()+"' target=\"_blank\"> <img src=\""+url+"\"></a> </div>");
				/* sb.append(" <h4  title=\""+tcproject.getPname()+"\"><a href='"+application.getAttribute("ctx")+"/crowdfunding/front/toProDetails.ht?projectId="+tcproject.getProjectId()+"' target=\"_blank\">"+tcproject.getPname()+"</a> </h4> <div class=\"hotName\"><span class=\"f_l\">"+tcproject.getPcityIname()+"</span><span class=\"f_r\">剩余"+tcproject.getLastDays()+"天</span><span class=\"f_r\">"+ParamHelper.getInstance().getDecItemName("xmzt", tcproject.getPstateId())+"</span></div>"); */
				sb.append(" <h4  title=\""+tcproject.getPname()+"\"><a href='"+application.getAttribute("ctx")+"/crowdfunding/front/toProDetails.ht?projectId="+tcproject.getProjectId()+"' target=\"_blank\">"+(tcproject.getPname().length()>14?tcproject.getPname().substring(0,13)+"...":tcproject.getPname())+"</a> </h4> <div class=\"pdetail\">"+(tcproject.getPdetail().length()>19?tcproject.getPdetail().substring(0,18)+"...":tcproject.getPdetail())+"</div>  <div class=\"hotName\"><span class=\"f_city\">"+tcproject.getPprovincesName()+tcproject.getPcityIname()+"</span><span class=\"f_r\">剩余"+tcproject.getLastDays()+"天</span></div>");
				sb.append(" <div class=\"clear hotplan\"> <div class=\"hotplanNo\" style=\"width:"+tcproject.getPcomplete()+"%;text-align:right;color:white;line-height: 1;\"><b>"+tcproject.getPcomplete()+"%</b></div> </div> <div class=\"hotNum\"> <span><div  class=\"hotspan1\">"+tcproject.getPinvestAmount().divide(new BigDecimal(10000), 0 , RoundingMode.UP)+"万</div>已融金额</span> <span><div  class=\"hotspan3\">"+tcproject.getPfinancingAmount().divide(new BigDecimal(10000), 0 , RoundingMode.UP)+"万</div>融资目标</span><span><div  class=\"hotspan2\">"+tcproject.getSingleMinAmount()+"万</div>单投资人最低出资</span>");
				sb.append("</div> <div class=\"clear\"></div><div class=\"follow\"><em>关注:"+tcproject.getPfavoritesCount()+"</em><em>约谈:"+tcproject.getAboutNum()+"</em><em>认购:"+tcproject.getPinvestCount()+"</em></div> </li>");
			}
			sb.append("	 </ul> </div> </div> </div>");
		}
	out.print(sb.toString());
%>

