<%@tag import="com.deelon.cmsform.model.site.CmsSiteMenuContent"%>
<%@tag import="com.deelon.cmsform.service.site.CmsSiteMenuContentService"%>
<%@tag import="com.deelon.cmsform.model.site.CmsSiteMenu"%>
<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag import="com.deelon.cmsform.service.site.CmsSiteMenuService"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="新手入门-我要理财"%>
<%@tag import="java.util.*"%>
<%
	StringBuffer sb = new StringBuffer("");
	CmsSiteMenuService cmsSiteMenuService = (CmsSiteMenuService) AppUtil.getBean(CmsSiteMenuService.class);
	CmsSiteMenuContentService cmsSiteMenuContentService = (CmsSiteMenuContentService) AppUtil.getBean(CmsSiteMenuContentService.class); 
	List<CmsSiteMenu> cmssitemenu = cmsSiteMenuService.getMenuPath(menupath);
	for (int i=0;i<3;i++) {
		CmsSiteMenu cms=cmssitemenu.get(i); 
		sb.append("<div class=\"big-tit\">" + cms.getMenuName()
				+ "</div>");
    List<CmsSiteMenuContent> cmsSiteMenuContentlist =cmsSiteMenuContentService.getMenuId(cms.getMenuPath());
    if(i==0){
    	  CmsSiteMenuContent cmsSiteMenuContent=cmsSiteMenuContentlist.get(0);
    	  cmsSiteMenuContent.getContentFileIds(); 
		 	String fileId=cmsSiteMenuContent.getFilesIds(); 
			String url=application.getAttribute("ctx")+"/wuyouchou/system/sysFile/getFileById.ht?fileId="+fileId;
			sb.append("<img class=\"borrow-process\" src=\""+url+"\" alt=\"\">"); 
    }
    if(i==1){ 
		for(int k=0;k<5;k++){  
			 CmsSiteMenuContent cmsSiteMenuContent=cmsSiteMenuContentlist.get(k);
			 if(k==0){
				 sb.append("<div class=\"h2\">"+cmsSiteMenuContent.getContentTitle()+"</div> <p>"+cmsSiteMenuContent.getContentText()+"</p> ");
			 }if(k==1){
				 sb.append("<table><tr>"); 
				 sb.append("<td><div class=\"h2\">"+cmsSiteMenuContent.getContentTitle()+"</div> <p>"+cmsSiteMenuContent.getContentText()+"</p><td> ");
			 }
			 if(k==2){
					String fileIds=cmsSiteMenuContent.getContentFileIds(); 
					String fileId=fileIds.split(",")[0];
					for(int j=0;j<2;j++){
						int a=fileId.indexOf(":");
						fileId=fileId.substring(a+1);   
					}
					fileId=fileId.replaceAll("'","");
					String url=application.getAttribute("ctx")+"/wuyouchou/system/sysFile/getFileById.ht?fileId="+fileId;
					sb.append("<td><img   src=\""+url+"\" alt=\"\"></td></tr></table>"); 
			 }
			 if(k==3){
				 sb.append("<table><tr>"); 
				  cmsSiteMenuContent.getContentFileIds(); 
				 	String fileId=cmsSiteMenuContent.getFilesIds(); 
					String url=application.getAttribute("ctx")+"/wuyouchou/system/sysFile/getFileById.ht?fileId="+fileId;
					sb.append("<td><img   src=\""+url+"\" alt=\"\"></td>");
			 }if(k==4){
				 sb.append("<td><div class=\"h2\">"+cmsSiteMenuContent.getContentTitle()+"</div> <p>"+cmsSiteMenuContent.getContentText()+"</p><td></tr></table> ");
			 }
	     	} 
		}
    if(i==2){
    	  sb.append("<table><tr>"); 
		   for(int k=0;k<2;k++){
			   CmsSiteMenuContent cmsSiteMenuContent=cmsSiteMenuContentlist.get(k);
			   if(k==0){
				   sb.append(" <td> <div class=\"h2\">"+cmsSiteMenuContent.getContentTitle()+"</div>  <p>"+cmsSiteMenuContent.getContentText()+"</p> ");
				   sb.append(" <a href=\""+application.getAttribute("ctx")+"/loan/productsloan/productsLoanList.ht\">我要去借款</a></td>");

			   }else{
				   cmsSiteMenuContent.getContentFileIds(); 
				 	String fileId=cmsSiteMenuContent.getFilesIds(); 
					String url=application.getAttribute("ctx")+"/wuyouchou/system/sysFile/getFileById.ht?fileId="+fileId;
					sb.append("<td><img   src=\""+url+"\" alt=\"\"></td>");
			   }
		   }
		   sb.append("</tr></table>");  
	  }
	}
	out.print(sb.toString());
%>