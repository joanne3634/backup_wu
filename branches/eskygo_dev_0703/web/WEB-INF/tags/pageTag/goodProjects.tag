<%@tag import="com.deelon.platform.util.ParamHelper"%>
<%@tag import="java.math.RoundingMode"%>
<%@tag import="java.math.BigDecimal"%>
<%@tag import="com.deelon.crowdfunding.model.backstage.Tcproject"%>
<%@tag import="com.deelon.crowdfunding.service.front.HomePageService"%>
<%@tag import="com.deelon.loan.service.front.HomeIndexPageService"%>
<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag import="com.deelon.loan.model.sysManager.TSetHomepage"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="成功案例"%>
<%@tag import="java.util.*"%>
<%@tag import="java.text.*"%>
<%
        SimpleDateFormat sdf =  new SimpleDateFormat("yy-MM-dd");
		StringBuffer sb = new StringBuffer("");
		HomeIndexPageService homePageService=(HomeIndexPageService)AppUtil.getBean(HomeIndexPageService.class);
		TSetHomepage homepageMoudle = homePageService.getHomePageMoudleByCode("goodProjects");//成功案例
		if(null!=homepageMoudle&&homepageMoudle.getIsVisiable()==1){
			HomePageService pageService=(HomePageService)AppUtil.getBean(HomePageService.class);
			//List<Tcproject> list=pageService.getTcprojectsByStatus("6", null);
			/**
			 * 查询状态为 4，5，6三个状态的项目（成功项目）
			 */
			List<Tcproject> list=pageService.getSuccessTcProjects();
			int len=0;
			if(list.size()>homepageMoudle.getRecords()){ 
				len=homepageMoudle.getRecords();
			} 
			else{
				len=list.size();
			}
			
			sb.append(" <div class=\"case clear\"> <h3><img src=\""+application.getAttribute("ctx")+"/crowdfunding/Skin/Default/images/trianglegray.png\">成功案例<a href=\""+application.getAttribute("ctx")+"/crowdfunding/front/tofinancingPro.ht?success=1\"  target=\"_blank\">查看更多</a></h3> <ul> ");
			for(int i=0;i<len;i++){  
				Tcproject tcproject=(Tcproject)list.get(i);  
				tcproject.getPpic(); 
			    String fileId= tcproject.getFilesIds(); 
				String url="";
				if(null!=tcproject.getFilesIds()&&!"".equals(tcproject.getFilesIds())){
			    	url=application.getAttribute("PLATFORM-SYSTEM-URL")+"/wuyouchou/system/sysFile/getFileById.ht?fileId="+tcproject.getFilesIds();
			    }else{
			    	url=application.getAttribute("ctx")+"/crowdfunding/Skin/Default/images/zwtp1.jpg";
			    }
				if(i<len-1){
					sb.append(" <li>");
				}else{
					sb.append(" <li style=\"border:0px;\" >");
				}
				/* sb.append(" <div class=\"caseImg\"><a href='"+application.getAttribute("ctx")+"/crowdfunding/front/toProDetails.ht?projectId="+tcproject.getProjectId()+"' target=\"_blank\"> <img src=\""+url+"\"></a><div></div> </div> <h4  title=\""+tcproject.getPname()+"\"><a href='"+application.getAttribute("ctx")+"/crowdfunding/front/toProDetails.ht?projectId="+tcproject.getProjectId()+"' target=\"_blank\">"+tcproject.getPname()+"</a></h4>  <div class=\"caseName\"> <span>"+tcproject.getPcityIname()+"</span><span>"+ParamHelper.getInstance().getDecItemName("PIND", tcproject.getPindustry())+"</span><span> "+ParamHelper.getInstance().getDecItemName("PTYPE", tcproject.getPstage())+" </span></div> "); */
				sb.append(" <div class=\"caseImg\"><a href='"+application.getAttribute("ctx")+"/crowdfunding/front/toProDetails.ht?projectId="+tcproject.getProjectId()+"' target=\"_blank\"> <img src=\""+url+"\"></a><div></div> </div> <h4  title=\""+tcproject.getPname()+"\"><a href='"+application.getAttribute("ctx")+"/crowdfunding/front/toProDetails.ht?projectId="+tcproject.getProjectId()+"' target=\"_blank\">"+(tcproject.getPname().length()>14?tcproject.getPname().substring(0,13)+"...":tcproject.getPname())+"</a></h4> <div class=\"pdetail\">"+(tcproject.getPdetail().length()>19?tcproject.getPdetail().substring(0,18)+"...":tcproject.getPdetail())+"</div> <div class=\"caseName\"> <span>"+tcproject.getPcityIname()+"</span><span>"+ParamHelper.getInstance().getDecItemName("PIND", tcproject.getPindustry())+"</span><span> "+ParamHelper.getInstance().getDecItemName("PTYPE", tcproject.getPstage())+" </span></div> ");
				sb.append(" <div class=\"caseNum\"> <span class=\"casespan1\"><div>"+tcproject.getPinvestAmount().divide(new BigDecimal(10000), 0 , RoundingMode.UP)+"万</div>已融金额</span> <span class=\"casespan2\"><div>"+sdf.format(tcproject.getPfullTime()) + "</div>完成时间</span> <span class=\"casespan3\"><div>"+tcproject.getPfinancingAmount().divide(new BigDecimal(10000), 0, RoundingMode.UP) + "万</div>融资目标</span> </div> <div class=\"clear\"></div> </li>");
			}
			sb.append("	 </ul> </div>");
		}
	out.print(sb.toString());
%>

