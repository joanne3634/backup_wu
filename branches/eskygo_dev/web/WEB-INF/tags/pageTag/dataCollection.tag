<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag import="com.deelon.loan.service.front.HomeIndexPageService"%>
<%@tag import="com.deelon.loan.model.sysManager.TSetHomepage"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="筹集统计"%>
<%@tag import="java.util.*"%>
<%
	StringBuffer sb = new StringBuffer("");
	HomeIndexPageService homePageService=(HomeIndexPageService)AppUtil.getBean(HomeIndexPageService.class);
    TSetHomepage homepageMoudle = homePageService.getHomePageMoudleByCode("dataCollection");//获取投资列表
    if(null!=homepageMoudle&&homepageMoudle.getIsVisiable()==1){
    	Map<String, Object> data = homePageService.getProjectsSum();
		sb.append(" <div class=\"data\"> <dl> ");
		sb.append("  <dt>为借款人筹集</dt> ");
		sb.append(" <dd class=\"color-main\">"+data.get("realLoanSum")+"</dd> ");
		sb.append(" <dt>已为投资人创收</dt> ");
		sb.append(" <dd class=\"color-s\">"+data.get("realInterestSum")+"</dd> </dl>  </div> ");
      
    }
	out.print(sb.toString());
%>