<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag import="com.deelon.loan.service.front.HomeIndexPageService"%>
<%@tag import="com.deelon.loan.model.sysManager.TSetHomepage"%>
<%@tag pageEncoding="utf-8"%>
<%@tag import="java.util.*"%>
<%
	StringBuffer sb = new StringBuffer("");
	HomeIndexPageService homePageService=(HomeIndexPageService)AppUtil.getBean(HomeIndexPageService.class);
    TSetHomepage homepageMoudle = homePageService.getHomePageMoudleByCode("paihangbang");//投资排行榜
    if(null!=homepageMoudle&&homepageMoudle.getIsVisiable()==1){
    	List<Map<String, String>> list = homePageService.getProjectsInvestDesc();
    	sb.append(" <h2><img src=\"images/paihangbang.png\" alt=\"\"></h2>  <ul class=\"paihangbang cleapadd\">   ");
    	for(int i=0;i<homepageMoudle.getRecords()&&null!=list&&list.size()>0&&i<list.size();i++){
    		if(i==0){
    			sb.append("  <li><img src=\"images/diyiming-pic.png\" alt=\"\"><a href=\"#\">"+list.get(i).get("LoginName").charAt(0)+"**"+list.get(i).get("LoginName").charAt(list.get(i).get("LoginName").length()-1)+"</a><img src=\"\" alt=\"\"></li>");
    		}else if(i==1){
    			sb.append("  <li><img src=\"images/dierming-pic.png\" alt=\"\"><a href=\"#\">"+list.get(i).get("LoginName").charAt(0)+"**"+list.get(i).get("LoginName").charAt(list.get(i).get("LoginName").length()-1)+"</a><img src=\"\" alt=\"\"></li>");
    		}else if(i==2){
    			sb.append("  <li><img src=\"images/disanming-pic.png\" alt=\"\"><a href=\"#\">"+list.get(i).get("LoginName").charAt(0)+"**"+list.get(i).get("LoginName").charAt(list.get(i).get("LoginName").length()-1)+"</a><img src=\"\" alt=\"\"></li>");
    		}else if(i==3){
    			sb.append("  <li><img src=\"images/disiming-pic.png\" alt=\"\"><a href=\"#\">"+list.get(i).get("LoginName").charAt(0)+"**"+list.get(i).get("LoginName").charAt(list.get(i).get("LoginName").length()-1)+"</a><img src=\"\" alt=\"\"></li>");
    		}else if(i==4){
    			sb.append("  <li><img src=\"images/diwuming-pic.png\" alt=\"\"><a href=\"#\">"+list.get(i).get("LoginName").charAt(0)+"**"+list.get(i).get("LoginName").charAt(list.get(i).get("LoginName").length()-1)+"</a><img src=\"\" alt=\"\"></li>");
    		}else{
    			sb.append("  <li><img src=\"images/diwuming-pic.png\" alt=\"\"><a href=\"#\">"+list.get(i).get("LoginName").charAt(0)+"**"+list.get(i).get("LoginName").charAt(list.get(i).get("LoginName").length()-1)+"</a><img src=\"\" alt=\"\"></li>");
    		}    
    		
    	}
    	sb.append("  </ul> "); 
    }
	out.print(sb.toString());
%>