<%@tag import="com.deelon.loan.service.front.HomeIndexPageService" %>
<%@tag import="com.deelon.loan.model.sysManager.TSetHomepage" %>
<%@tag import="com.deelon.cmsform.model.site.CmsSiteMenuContent" %>
<%@tag import="com.deelon.core.util.AppUtil" %>
<%@tag import="com.deelon.cmsform.service.site.CmsSiteMenuContentService" %>
<%@tag pageEncoding="utf-8" %>
<%@ attribute name="menupath" required="true" description="广告大图" %>
<%@tag import="java.util.*" %>
<%
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
%>
<div id="index-carousel" class="ink-carousel" data-pagination="#index-carousel-pagination">
    <ul class="stage column-group">
        <%
            for (int i = 0; i < len; i++) {
                CmsSiteMenuContent cmsSiteMenuContent = (CmsSiteMenuContent) list.get(i);
    			List<Long> fileIds = cmsSiteMenuContent.getContentFileIdsList();
    			Long fileId = fileIds.get(0);
                //图片url
                String tmpUrl = cmsSiteMenuContent.getContentUrl();
                String contentUrl = null == tmpUrl ? "" : tmpUrl;
                String url = application.getAttribute("PLATFORM-SYSTEM-URL") + "/wuyouchou/system/sysFile/getFileById.ht?fileId=" + fileId;

        %>
        <li class="slide all-100">
            <a href="<%=contentUrl%>" style="display: block;height: 100%">
            <img alt="<%=cmsSiteMenuContent.getContentTitle()%>" src="<%=url%>"></a>
        </li>
        <%}%>
    </ul>
    <nav id="index-carousel-pagination" class="ink-navigation align-center">
        <ul class="pagination dotted">
        </ul>
        <ul class="pagination chevron">
            <li class="previous"><a href="#"><span>Previous</span></a></li>
            <li class="next"><a href="#"><span>Next</span></a></li>
        </ul>
    </nav>
</div>
<%}%>