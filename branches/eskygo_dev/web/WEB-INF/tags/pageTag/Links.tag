<%@tag import="java.io.File"%>
<%@tag import="com.deelon.platform.service.util.ServiceUtil"%>
<%@tag import="com.deelon.platform.controller.system.SysFileController"%>
<%@tag import="com.deelon.platform.model.system.SysFile"%>
<%@tag import="com.deelon.platform.service.system.SysFileService"%>
<%@tag import="com.fr.base.core.json.JSONObject"%>
<%@tag import="com.fr.base.core.json.JSONArray"%> 
<%@tag import="com.deelon.cmsform.model.site.CmsSiteMenuContent"%>
<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag import="com.deelon.cmsform.service.site.CmsSiteMenuContentService"%>
<%@tag import="com.deelon.loan.service.front.HomeIndexPageService"%>
<%@tag import="com.deelon.loan.model.sysManager.TSetHomepage"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="友情链接"%>
<%@tag import="java.util.*"%>
<%
	StringBuffer sb = new StringBuffer("");
HomeIndexPageService homePageService=(HomeIndexPageService)AppUtil.getBean(HomeIndexPageService.class);
TSetHomepage homepageMoudle = homePageService.getHomePageMoudleByCode("youqinglianjie");//获取投资列表
if(null!=homepageMoudle&&homepageMoudle.getIsVisiable()==1){   
CmsSiteMenuContentService cmsSiteMenuContentService=(CmsSiteMenuContentService)AppUtil.getBean(CmsSiteMenuContentService.class);
	List<CmsSiteMenuContent> list=cmsSiteMenuContentService.getMenuId(menupath);
	sb.append("<h2> <img src=\"images/youqinglianjie.png\" alt=\"\"> <a class=\"f-r color-main\" href=\""+application.getAttribute("ctx")+"/site/AboutUs/AboutUsList.ht?srcurl='loan/aboutus/LinksList.ht'&&urlname=7\"  target=\"_blank\">更多>></a> </h2>  <ul>");
	int len=0;
	if(list.size()>5){ 
		len=5;
	} 
	else{
		len=list.size();
	}
	for(int i=0;i<len;i++){
		CmsSiteMenuContent cmsSiteMenuContent=(CmsSiteMenuContent)list.get(i);  
		cmsSiteMenuContent.getContentFileIds(); 
	    String fileId= cmsSiteMenuContent.getFilesIds(); 
		String url=application.getAttribute("ctx")+"/wuyouchou/system/sysFile/getFileById.ht?fileId="+fileId;   
		 if(cmsSiteMenuContent.getContentUrl()==null||"".equals(cmsSiteMenuContent.getContentUrl())){
			 sb.append(" <li><a href=\"#\"><img src=\""+url+"\" alt=\"\"></a></li>"); 
		 } else{
			 sb.append(" <li><a href=\""+cmsSiteMenuContent.getContentUrl()+"\"  target=\"_blank\"><img src=\""+url+"\" alt=\"\"></a></li>");
		 } 
 	}   
	sb.append("</ul>");
}
	out.print(sb.toString());
%>