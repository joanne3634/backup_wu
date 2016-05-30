<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag import="com.deelon.loan.service.front.HomeIndexPageService"%>
<%@tag import="com.deelon.loan.model.sysManager.TSetHomepage"%>
<%@tag import="com.deelon.loan.model.front.TProjectInvest"%>
<%@tag pageEncoding="utf-8"%>
<%@tag import="java.util.*"%>
<%
	StringBuffer sb = new StringBuffer("");
	HomeIndexPageService homePageService=(HomeIndexPageService)AppUtil.getBean(HomeIndexPageService.class);
    TSetHomepage homepageMoudle = homePageService.getHomePageMoudleByCode("zuixintoubiao");//最新投资
    if(null!=homepageMoudle&&homepageMoudle.getIsVisiable()==1){
		sb.append(" <h2 class=\"zuixintoubiao-tit\"><a id=\"jinripaihang-a\" href=\"javascript:;\"></a>  ");
		sb.append(" <a id=\"zuixintoubiao-a\" href=\"javascript:;\"></a></h2> ");
		List<TProjectInvest>  results = homePageService.getProjectsLatelyInvest();
		for(int i=0;i<homepageMoudle.getRecords()&&null!=results&&results.size()>0&&i<results.size();i++){
			sb.append("  <ul class=\"zuixintoubiao cleapadd\"> <li><span>"+results.get(i).getRealName().charAt(0)+"**"+results.get(i).getRealName().charAt(results.get(i).getRealName().length()-1)+"</span><span class=\"gray\"> </span><span class=\"toubiaojine\">￥"+results.get(i).getPiAmount()+"</span></li>  </ul> ");
		}
		results = homePageService.getProjectsLatelySumInvest();
		for(int i=0;i<homepageMoudle.getRecords()&&null!=results&&results.size()>0&&i<results.size();i++){
			sb.append("  <ul class=\"jinripaihang cleapadd\" style=\"display:none;\"> <li><span>"+results.get(i).getRealName().charAt(0)+"**"+results.get(i).getRealName().charAt(results.get(i).getRealName().length()-1)+"</span><span class=\"gray\"> </span><span class=\"toubiaojine\">￥"+results.get(i).getPiAmount()+"</span></li>  </ul>");
		}
    }
	out.print(sb.toString());
%>