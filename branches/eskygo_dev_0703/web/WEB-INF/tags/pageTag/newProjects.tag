<%@tag import="com.deelon.core.util.AppUtil" %>
<%@tag import="com.deelon.crowdfunding.model.backstage.Tcproject" %>
<%@tag import="com.deelon.crowdfunding.service.front.HomePageService" %>
<%@tag import="com.deelon.loan.model.sysManager.TSetHomepage" %>
<%@tag import="com.deelon.loan.service.front.HomeIndexPageService" %>
<%@tag import="java.math.BigDecimal" %>
<%@tag import="java.math.RoundingMode" %>
<%@tag import="java.util.List" %>
<%@tag pageEncoding="utf-8" %>
<%@ attribute name="menupath" required="true" description="最新项目" %>
<%
    StringBuffer sb = new StringBuffer("");
    HomeIndexPageService homePageService = (HomeIndexPageService) AppUtil.getBean(HomeIndexPageService.class);
    TSetHomepage homepageMoudle = homePageService.getHomePageMoudleByCode("newProjects");//获取最新项目
    if (null != homepageMoudle && homepageMoudle.getIsVisiable() == 1) {
        HomePageService pageService = (HomePageService) AppUtil.getBean(HomePageService.class);
        int len = 0 == homepageMoudle.getRecords() ? 12 : homepageMoudle.getRecords();
        List<Tcproject> list = pageService.getTcprojectsByStatus("3", null, len);
//			int len=0;
//			if(list.size()>homepageMoudle.getRecords()){
//				len=homepageMoudle.getRecords();
//			}
//			else{
//				len=list.size();
//			}

        sb.append(" <div class=\"news clear\"> <h3><img src=\"" + application.getAttribute("ctx") + "/crowdfunding/Skin/Default/images/trianglegray.png\">最新项目<span>这些项目是" + application.getAttribute("PLATFORM_NAME") + "优选项目，即将开始快速合投。提前预约，先人一步把握投资机会</span><a href=\"" + application.getAttribute("ctx") + "/crowdfunding/front/tofinancingPro.ht?DescList=0\"  target=\"_blank\">查看更多</a></h3><ul> ");
        for (int i = 0; i < len; i++) {
            Tcproject tcproject = (Tcproject) list.get(i);
            tcproject.getPpic();
            String fileId = tcproject.getFilesIds();
            String url = "";
            if (null != tcproject.getFilesIds() && !"".equals(tcproject.getFilesIds())) {
                url = application.getAttribute("PLATFORM-SYSTEM-URL") + "/wuyouchou/system/sysFile/getFileById.ht?fileId=" + tcproject.getFilesIds();
            } else {
                url = application.getAttribute("ctx") + "/crowdfunding/Skin/Default/images/zwtp1.jpg";
            }
            if (i % 2 == 0) {
                sb.append(" <li>");
            } else {
                sb.append(" <li style=\"border:0px;\" >");
            }
            String yijiazhong = "议价中";
            if (tcproject.getPvaluationFinal().compareTo(new BigDecimal(0)) > 0) {
                BigDecimal sharePercent = tcproject.getPfinancingAmount().divide(tcproject.getPvaluationFinal().multiply(new BigDecimal("10000")), 2, RoundingMode.HALF_UP).multiply(new BigDecimal(100));

                yijiazhong = sharePercent.setScale(0) + "%";
            }
            sb.append(" <a href='" + application.getAttribute("ctx") + "/crowdfunding/front/toProDetails.ht?projectId=" + tcproject.getProjectId() + "' target=\"_blank\"> <img src=\"" + url + "\"></a>");
            sb.append("<div class=\"recommendName\"> <h4 title=\"" + tcproject.getPname() + "\"><a href='" + application.getAttribute("ctx") + "/crowdfunding/front/toProDetails.ht?projectId=" + tcproject.getProjectId() + "' target=\"_blank\">" + tcproject.getPname() + "</a> </h4> <div>融资金额<label class=\"recommendLab\">" + tcproject.getPfinancingAmount().divide(new BigDecimal(10000), 0, RoundingMode.UP) + "万</label></div>");
				/* sb.append("<div>出让股份<label class=\"recommendLab2\">"+yijiazhong+"</label></div> </div> <div class=\"recommendIntro\"> <span>项目简介：</span>"+(tcproject.getPdetail().length()>91?tcproject.getPdetail().substring(0,90)+"...":tcproject.getPdetail())+"</div></li>"); */
            sb.append("<div>出让股份<label class=\"recommendLab2\">" + yijiazhong + "</label></div> </div> <div class=\"recommendIntro\"> <span></span>" + (tcproject.getPdetail().length() > 91 ? tcproject.getPdetail().substring(0, 90) + "..." : tcproject.getPdetail()) + "</div>");
            sb.append("<div class=\"newProject\"><span class=\"f_city\">" + tcproject.getPprovincesName() + tcproject.getPcityIname() + "</span></div></li>");
        }
        sb.append("	 </ul> </div>");
    }
    out.print(sb.toString());
%>

