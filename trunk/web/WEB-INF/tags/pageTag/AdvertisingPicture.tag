<%@tag import="java.io.File" %>
<%@tag import="com.deelon.loan.service.front.HomeIndexPageService" %>
<%@tag import="com.deelon.loan.model.sysManager.TSetHomepage" %>
<%@tag import="com.deelon.platform.service.util.ServiceUtil" %>
<%@tag import="com.deelon.platform.controller.system.SysFileController" %>
<%@tag import="com.deelon.platform.model.system.SysFile" %>
<%@tag import="com.deelon.platform.service.system.SysFileService" %>
<%@tag import="com.fr.base.core.json.JSONObject" %>
<%@tag import="com.fr.base.core.json.JSONArray" %>
<%@tag import="com.deelon.cmsform.model.site.CmsSiteMenuContent" %>
<%@tag import="com.deelon.core.util.AppUtil" %>
<%@tag import="com.deelon.cmsform.service.site.CmsSiteMenuContentService" %>
<%@tag pageEncoding="utf-8" %>
<%@ attribute name="menupath" required="true" description="广告大图" %>
<%@tag import="java.util.*" %>
<%
    StringBuffer sb = new StringBuffer("");
    HomeIndexPageService homePageService = (HomeIndexPageService) AppUtil.getBean(HomeIndexPageService.class);
    TSetHomepage homepageMoudle = homePageService.getHomePageMoudleByCode("advertisement");//获取投资列表
    if (null != homepageMoudle && homepageMoudle.getIsVisiable() == 1) {
        CmsSiteMenuContentService cmsSiteMenuContentService = (CmsSiteMenuContentService) AppUtil.getBean(CmsSiteMenuContentService.class);
        List<CmsSiteMenuContent> list = cmsSiteMenuContentService.getMenuId(menupath);
        int len = 0;
        if (list.size() > homepageMoudle.getRecords()) {
            len = 6;
        } else {
            len = list.size();
        }

        sb.append("<div id=\"kinMaxShow\">");
        for (int i = 0; i < len; i++) {
            CmsSiteMenuContent cmsSiteMenuContent = (CmsSiteMenuContent) list.get(i);
            cmsSiteMenuContent.getContentFileIds();
            String fileId = cmsSiteMenuContent.getFilesIds();
            //图片url
            String tmpUrl = cmsSiteMenuContent.getContentUrl();
            String contentUrl = null == tmpUrl ? "" : tmpUrl;
            sb.append("<div data-url=\"" + contentUrl + "\"> ");//<a href=\"\"></a>
            String url = application.getAttribute("PLATFORM-SYSTEM-URL") + "/platform/system/sysFile/getFileById.ht?fileId=" + fileId;
            //String url=application.getAttribute("ctx")+"/platform/system/sysFile/getFileById.ht?fileId="+fileId;
            sb.append("<img  alt=\"" + cmsSiteMenuContent.getContentTitle() + "\" src=\"" + url + "\" width=\"100%\"></div>");
        }
        sb.append("</div>");
    }
    out.print(sb.toString());
%>