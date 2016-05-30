<%@tag import="java.math.RoundingMode" %>
<%@tag import="java.math.BigDecimal" %>
<%@tag import="com.deelon.crowdfunding.model.backstage.Tcproject" %>
<%@tag import="com.deelon.crowdfunding.service.front.HomePageService" %>
<%@tag import="com.deelon.loan.service.front.HomeIndexPageService" %>
<%@tag import="com.deelon.cmsform.model.site.CmsSiteMenuContent" %>
<%@tag import="com.deelon.core.util.AppUtil" %>
<%@tag import="com.deelon.cmsform.service.site.CmsSiteMenuContentService" %>
<%@tag import="com.deelon.loan.model.sysManager.TSetHomepage" %>
<%@tag pageEncoding="utf-8" %>
<%@ attribute name="menupath" required="true" description="投资推荐" %>
<%@tag import="java.util.*" %>
<%
    StringBuffer sb = new StringBuffer("");
    HomeIndexPageService homePageService = (HomeIndexPageService) AppUtil.getBean(HomeIndexPageService.class);
    TSetHomepage homepageMoudle = homePageService.getHomePageMoudleByCode("projectRecommend");//获取投资推荐显示
    if (null != homepageMoudle && homepageMoudle.getIsVisiable() == 1) {
        HomePageService pageService = (HomePageService) AppUtil.getBean(HomePageService.class);
        List<Tcproject> list = pageService.getTcprojectsByStatus("3", "1");
        int len = 0;
        if (list.size() > homepageMoudle.getRecords()) {
            len = homepageMoudle.getRecords();
        } else {
            len = list.size();
        }
        sb.append(" <div class=\"recommend f_l\"> <h3><img src=\"" + application.getAttribute("ctx") + "/crowdfunding/Skin/Default/images/trianglegray.png\">项目推荐<a href=\"" + application.getAttribute("ctx") + "/crowdfunding/front/tofinancingPro.ht?pisRecommended=1\"  target=\"_blank\">更多项目</a></h3> ");
        for (int i = 0; i < len; i++) {
            Tcproject tcproject = (Tcproject) list.get(i);
            String yijiazhong = "议价中";
            if (tcproject.getPvaluationFinal().compareTo(new BigDecimal(0)) > 0) {
                //计算出让股权。表T_C_PROJECT字段P_FinancingAmount*10000除以P_ValuationFinal
                BigDecimal sharePercent = tcproject.getPfinancingAmount().divide(tcproject.getPvaluationFinal().multiply(new BigDecimal("10000")), 2, RoundingMode.HALF_UP).multiply(new BigDecimal(100));

                yijiazhong = sharePercent.setScale(0) + "%";
            }
            tcproject.getPpic();
            String fileId = tcproject.getFilesIds();
            fileId = fileId == null ? "0" : fileId;
            String url = application.getAttribute("ctx") + "/platform/system/sysFile/getFileById.ht?fileId=" + fileId;
            sb.append(" <div class=\"recommendContent\"> <a href='" + application.getAttribute("ctx") + "/crowdfunding/front/toProDetails.ht?projectId=" + tcproject.getProjectId() + "' target=\"_blank\"> <img src=\"" + url + "\"></a> ");
            sb.append("<div class=\"recommendName\"> <h4  title=\"" + tcproject.getPname() + "\"><a href='" + application.getAttribute("ctx") + "/crowdfunding/front/toProDetails.ht?projectId=" + tcproject.getProjectId() + "' target=\"_blank\">" + tcproject.getPname() + "</a> </h4><div>融资金额<label class=\"recommendLab\">" + tcproject.getPfinancingAmount().divide(new BigDecimal(10000), 0, RoundingMode.UP) + "万</label></div> <div>出让股份<label class=\"recommendLab2\">" + yijiazhong + "</label></div> </div>");
				/* sb.append("<div class=\"recommendIntro\"> <span>项目简介：</span>"+(tcproject.getPdetail().length()>91?tcproject.getPdetail().substring(0,90)+"...":tcproject.getPdetail())+" </div> </div>"); */
            sb.append("<div class=\"recommendIntro\"> <span></span>" + (tcproject.getPdetail().length() > 91 ? tcproject.getPdetail().substring(0, 90) + "..." : tcproject.getPdetail()) + " </div>");
            sb.append("<div class=\"newProject\"><span class=\"f_city\">" + tcproject.getPprovincesName() + tcproject.getPcityIname() + "</span></div></div>");
        }
        sb.append("	</div>");
    } else {
        CmsSiteMenuContentService cmsSiteMenuContentService = (CmsSiteMenuContentService) AppUtil.getBean(CmsSiteMenuContentService.class);
        List<CmsSiteMenuContent> list = cmsSiteMenuContentService.getMenuId(menupath);
        int len = 0;
        if (list.size() > homepageMoudle.getRecords()) {
            len = homepageMoudle.getRecords();
        } else {
            len = list.size();
        }


        sb.append(" <div class=\"recommend f_l\"> <h3><img src=\"" + application.getAttribute("ctx") + "/crowdfunding/Skin/Default/images/trianglegray.png\">项目推荐<a href=\"" + application.getAttribute("ctx") + "/crowdfunding/innovationProject.html\">更多项目</a></h3> ");
        for (int i = 0; i < len; i++) {
            CmsSiteMenuContent c = list.get(i);
            c.getContentFileIds();
            String fileId = c.getFilesIds();
            String url = application.getAttribute("PLATFORM-SYSTEM-URL") + "/platform/system/sysFile/getFileById.ht?fileId=" + fileId;
            sb.append(" <div class=\"recommendContent\"> <img src=\"" + url + "\">  ");
            String[] strs = c.getContentMinTitle().split("-");
            sb.append("<div class=\"recommendName\"> <h4>" + c.getContentTitle() + "</h4> <div>融资金额<label class=\"recommendLab\">" + strs[0] + "</label></div> <div>出让股份<label class=\"recommendLab2\">" + strs[1] + "</label></div> </div>");
            sb.append("<div class=\"recommendIntro\"> <span>项目简介：</span>" + c.getContentSummary() + " </div> </div>");
        }
        sb.append("	</div>");
    }
    out.print(sb.toString());
%>