<%@tag import="com.deelon.cmsform.model.site.CmsSiteMenuContent" %>
<%@tag import="com.deelon.cmsform.service.site.CmsSiteMenuContentService" %>
<%@tag import="com.deelon.core.util.AppUtil" %>
<%@tag import="com.deelon.crowdfunding.model.backstage.Tcproject" %>
<%@tag import="com.deelon.crowdfunding.service.front.HomePageService" %>
<%@tag import="com.deelon.loan.model.sysManager.TSetHomepage" %>
<%@tag import="com.deelon.loan.service.front.HomeIndexPageService" %>
<%@tag import="java.math.BigDecimal" %>
<%@tag import="java.math.RoundingMode" %>
<%@tag pageEncoding="utf-8" %>
<%@ attribute name="menupath" required="true" description="投资推荐" %>
<%@tag import="java.util.List" %>
<%
    StringBuffer sb = new StringBuffer("");
    HomeIndexPageService homePageService = (HomeIndexPageService) AppUtil.getBean(HomeIndexPageService.class);
    TSetHomepage homepageMoudle = homePageService.getHomePageMoudleByCode("projectRecommend");//获取投资推荐显示
    if (null != homepageMoudle && homepageMoudle.getIsVisiable() == 1) {
        HomePageService pageService = (HomePageService) AppUtil.getBean(HomePageService.class);
        int len = 0 == homepageMoudle.getRecords() ? 1 : homepageMoudle.getRecords();
        List<Tcproject> list = pageService.getTcprojectsByStatus("3", "1", len);
        if(len>list.size())
            len=list.size();
//        int len = 0;
//        if (list.size() > homepageMoudle.getRecords()) {
//            len = homepageMoudle.getRecords();
//        } else {
//            len = list.size();
//        }
%>
<div class="ink-grid push-center all-90">
    <div class="title">
        <h3><i class="fa fa-th-large"></i> <%=homepageMoudle.getRdesc_name()%>
        </h3>
        <a class="ink-button blue push-right" href="${ctx}/crowdfunding/front/tofinancingPro.ht?pisRecommended=1"
           target="_blank">查看更多</a>
    </div>
    <div class="column-group horizontal-gutters">
        <%
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
                String url = application.getAttribute("ctx") + "/wuyouchou/system/sysFile/getFileById.ht?fileId=" + fileId;
                int pcomplete = 0;
                if (tcproject.getPcomplete() > 100) {
                    pcomplete = 100;
                } else {
                    pcomplete = tcproject.getPcomplete();
                }

        %>
        <div class="xlarge-25 large-33 medium-33 small-50 tiny-100">
            <div class="card">
                <div class="link-pic">
                    <a target="_blank"
                       href="${ctx}/crowdfunding/front/toProDetails.ht?projectId=<%=tcproject.getProjectId()%>">
                        <img src="<%=url%>">
                    </a>
                </div>
                <a class="title" title="<%=tcproject.getPname()%>" target="_blank"
                   href="${ctx}/crowdfunding/front/toProDetails.ht?projectId=<%=tcproject.getProjectId()%>"><%=tcproject.getPname()%>
                </a>

                <div class="desc">
                    <p class="text"><%=tcproject.getPdetail()%>
                    </p>

                    <p class="funded">
                        已融金额<em><%=tcproject.getPinvestAmount().divide(new BigDecimal(10000), 0, RoundingMode.UP)%>
                    </em>万</p>

                    <div class="outter">
                        <div class="column-group">
                            <div class="all-50">
                                <%=tcproject.getPprovincesName() + tcproject.getPcityIname()%>
                            </div>
                            <div class="all-50 align-right">
                                剩余<%=tcproject.getLastDays()%>天
                            </div>
                        </div>
                        <div class="progress-bar"><span class="progress"
                                                        style="width: <%=pcomplete%>"><%=tcproject.getPcomplete()%>%</span>
                        </div>
                        <div class="column-group">
                            <div class="all-50">
                                融资目标<em><%=tcproject.getPfinancingAmount().divide(new BigDecimal(10000), 0, RoundingMode.UP)%>
                            </em>万
                            </div>
                            <div class="all-50 align-right">
                                出让股份<em><%=yijiazhong%>
                            </em>
                                <%--单投资人<p style="margin:0;">最低出资<%=tcproject.getSingleMinAmount()%>万--%>
                            </div>
                        </div>
                        <div class="column-group card-bottom">
                            <div class="all-33 align-left">
                                关注：<%=tcproject.getPfavoritesCount()%>
                            </div>
                            <div class="all-33 align-center">
                                约谈：<%=tcproject.getAboutNum()%>
                            </div>
                            <div class="all-33 align-right">
                                认购：<%=tcproject.getPinvestCount()%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>
<%
} else {
    CmsSiteMenuContentService cmsSiteMenuContentService = (CmsSiteMenuContentService) AppUtil.getBean(CmsSiteMenuContentService.class);
    List<CmsSiteMenuContent> list = cmsSiteMenuContentService.getMenuId(menupath);
    int len = 0;
    if (list.size() > homepageMoudle.getRecords()) {
        len = homepageMoudle.getRecords();
    } else {
        len = list.size();
    }

%>
<div class="ink-grid push-center all-90">
    <div class="title">
        <h3><i class="fa fa-th-large"></i> <%=homepageMoudle.getRdesc_name()%>
        </h3>
        <a class="ink-button blue push-right" href="${ctx}/crowdfunding/innovationProject.html" target="_blank">查看更多</a>
    </div>
    <div class="column-group horizontal-gutters">
        <%
            for (int i = 0; i < len; i++) {
                CmsSiteMenuContent c = list.get(i);
                c.getContentFileIds();
                String fileId = c.getFilesIds();
                String url = application.getAttribute("PLATFORM-SYSTEM-URL") + "/wuyouchou/system/sysFile/getFileById.ht?fileId=" + fileId;
        %>
        <!-- 不知道干嘛用的，要测试一下，后台数据位空，看不到效果-->
        <%
                sb.append(" <div class=\"recommendContent\"> <img src=\"" + url + "\">  ");
                String[] strs = c.getContentMinTitle().split("-");
                sb.append("<div class=\"recommendName\"> <h4>" + c.getContentTitle() + "</h4> <div>融资金额<label class=\"recommendLab\">" + strs[0] + "</label></div> <div>出让股份<label class=\"recommendLab2\">" + strs[1] + "</label></div> </div>");
                sb.append("<div class=\"recommendIntro\"> <span>项目简介：</span>" + c.getContentSummary() + " </div> </div>");
            }
            sb.append("	</div>");
        %>
    </div>
</div>
<%
    }
%>