<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag import="com.deelon.loan.service.front.HomeIndexPageService"%>
<%@tag import="com.deelon.loan.model.sysManager.TSetHomepage"%>
<%@tag pageEncoding="utf-8"%>
<%@tag import="java.util.*"%>
<%
	StringBuffer sb = new StringBuffer("");
	HomeIndexPageService homePageService=(HomeIndexPageService)AppUtil.getBean(HomeIndexPageService.class);
    TSetHomepage homepageMoudle = homePageService.getHomePageMoudleByCode("footer");//底部链接
    if(null!=homepageMoudle&&homepageMoudle.getIsVisiable()==1){
    	sb.append(" <ul> <li class=\"firstli\">新手入门</li> <li><a href=\"#\">免费注册</a></li> <li><a href=\"#\">我的网贷</a></li> <li><a href=\"#\">如何借入</a></li></ul> ");
		sb.append(" <ul><li class=\"firstli\">我要借出</li><li><a href=\"#\">浏览借款</a></li><li><a href=\"#\">自动投标</a></li><li><a href=\"#\">成为VIP</a></li></ul> ");
		sb.append(" <ul><li class=\"firstli\">我要借入</li><li><a href=\"#\">发布借款</a></li><li><a href=\"#\">优先计划</a></li><li><a href=\"#\">诚信认证</a></li><li><a href=\""+application.getAttribute("ctx")+"/loan/productsloan/projectincomelist.ht\">收益计算器</a></li> </ul> ");
		sb.append(" <ul><li class=\"firstli\">诚信保障</li><li><a href=\"#\">本金保障</a></li><li><a href=\"#\">法律政策</a></li> </ul>");
		sb.append(" <ul><li class=\"firstli\">关于帝隆</li><li><a href=\"#\">帝隆团队</a></li><li><a href=\"#\">帝隆论坛</a></li><li><a href=\"#\">媒体报道</a></li><li><a href=\"#\">招贤纳士</a></li></ul> ");
		sb.append(" <ul><li class=\"firstli\">关于我们</li><li><a href=\"#\">新浪微博</a></li><li><a href=\"#\">腾讯微博</a></li><li><a href=\"#\">联系我们</a></li></ul> ");
      	sb.append(" <ul> <li class=\"firstli\">微信二维码</li> <li><img src=\""+application.getAttribute("ctx")+"/images/erweima.png\" alt=\"\"></li> </ul> ");
    }
	out.print(sb.toString());
%>