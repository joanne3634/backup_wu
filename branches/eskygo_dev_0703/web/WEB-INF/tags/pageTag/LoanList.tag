<%@tag import="com.deelon.loan.service.front.HomeIndexPageService"%>
<%@tag import="com.deelon.loan.model.front.TProject"%>
<%@tag import="com.deelon.loan.model.sysManager.TSetHomepage"%>
<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="投资列表"%>
<%@tag import="java.util.*"%>
<%
	StringBuffer sb = new StringBuffer("");
    HomeIndexPageService homePageService=(HomeIndexPageService)AppUtil.getBean(HomeIndexPageService.class);
    TSetHomepage homepageMoudle = homePageService.getHomePageMoudleByCode("projectlist");//获取投资列表
    if(null!=homepageMoudle&&homepageMoudle.getIsVisiable()==1){
    	sb.append("<h2> <img src=\"images/liebiao.png\" alt=\"\"> <a href=\""+application.getContextPath()+"/tenderProjects/getTenderProjects.ht\">更多>></a>  </h2>  <div class=\"liebiao\">");
	    Map<String,List<TProject>> list=homePageService.getIndexPageprojects(homepageMoudle.getRecords());
	    if((null!=list.get("1")&&list.get("1").size()>0)||(null!=list.get("2")&&list.get("2").size()>0)){
				int i = 0;
				for(TProject tp:list.get("1")){
					sb.append("<div class=\"yikaishi\">");
					sb.append("<div class=\"title\">");
					sb.append("<img src=\"images/list_logo.png\" alt=\"\">");
					sb.append("<span>"+tp.getPname()+"</span>");
					sb.append("<a class=\"mashangkaishi-btn\" href=\""+AppUtil.getServletContext().getContextPath()+"/project/showProjectDetail.ht?applicationId="+tp.getPapplicant()+"&projectId="+tp.getProjectId()+"\">投标</a></div>");
					sb.append("<div class=\"arg\"><div style=\"position: relative; top: 8px; display: inline-block; width: 90px; height: 10px; margin-right: 10px; border-radius: 5px; background-color: #dadada;\"><div style=\"position: relative; top: -8px; display: inline-block; width: "+tp.getPcomplete()+"%; height: 10px; border-radius: 5px; background-color: #6db900;\"></div></div>");
					sb.append("<span style=\"padding-right: 20px;\">"+tp.getPcomplete()+"%</span>");
					sb.append("<img src=\"images/jine.png\" alt=\"\">");
					sb.append("<span class=\"orange\">"+tp.getPloan()+"元</span>");
					sb.append("<img src=\"images/nianhualv.png\" alt=\"\">");
					sb.append("<span>预计年化率:</span><span class=\"orange\">"+tp.getPrateOut()+"%</span>");
					sb.append("<img src=\"images/shijian.png\" alt=\"\">时间：");
					sb.append("<span>"+tp.getPdeadline()+"个月</span>");
					sb.append("<img src=\"images/fuxihuanben.png\" alt=\"\">");
					sb.append("<span class=\"orange\">付息还本</span></div>"); 
					sb.append("</div>");
					i++;
					if(i>=homepageMoudle.getRecords()){
						break;
					}
				}
				if(i<homepageMoudle.getRecords()){
					for(TProject tp:list.get("2")){
						sb.append("<div class=\"huankuanzhong\">");
						sb.append("<div class=\"title\">");
						sb.append("<img src=\"images/list_logo.png\" alt=\"\">");
						sb.append("<span>"+tp.getPname()+"</span>");
						sb.append("<a class=\"huankuanzhong-btn\" href=\"#\"></a></div>");
						sb.append("<div class=\"arg\"><div style=\"position: relative; top: 8px; display: inline-block; width: 90px; height: 10px; margin-right: 10px; border-radius: 5px; background-color: #dadada;\"><div style=\"position: relative; top: -8px; display: inline-block; width: "+tp.getPcomplete()+"%; height: 10px; border-radius: 5px; background-color: #6db900;\"></div></div>");
						sb.append("<img src=\"images/jine.png\" alt=\"\">");
						sb.append("<span class=\"orange\">"+tp.getPloan()+"元</span>");
						sb.append("<img src=\"images/nianhualv.png\" alt=\"\">");
						sb.append("<span>预计年化率:</span><span class=\"orange\">"+tp.getPrateOut()+"%</span>");
						sb.append("<img src=\"images/shijian.png\" alt=\"\">时间：");
						sb.append("<span>"+tp.getPdeadline()+"个月</span>");
						sb.append("<img src=\"images/fuxihuanben.png\" alt=\"\">");
						sb.append("<span class=\"orange\">付息还本</span></div>"); 
						sb.append("</div>");
						i++;
						if(i>=homepageMoudle.getRecords()){
							break;
						}
					}
				}
				 if(i<homepageMoudle.getRecords()){
					for(TProject tp:list.get("3")){
						sb.append("<div class=\"daikaishispan\">");
						sb.append("<div class=\"title\">");
						sb.append("<img src=\"images/list_logo.png\" alt=\"\">");
						sb.append("<span>"+tp.getPname()+"</span>");
						sb.append("<a class=\"daikaishispan-btn\" href=\"#\">审核中</a></div>");
						sb.append("<div class=\"arg\"><div class=\"daikaishispan-jindutiao\"></div>");
						sb.append("<span style=\"padding-right: 20px;\">"+tp.getPcomplete()+"%</span>");
						sb.append("<img src=\"images/jine.png\" alt=\"\">");
						sb.append("<span class=\"orange\">"+tp.getPloan()+"元</span>");
						sb.append("<img src=\"images/nianhualv.png\" alt=\"\">");
						sb.append("<span>预计年化率:</span><span class=\"orange\">"+tp.getPrateOut()+"%</span>");
						sb.append("<img src=\"images/shijian.png\" alt=\"\">时间：");
						sb.append("<span>"+tp.getPdeadline()+"个月</span>");
						sb.append("<img src=\"images/fuxihuanben.png\" alt=\"\">");
						sb.append("<span class=\"orange\">付息还本</span></div>"); 
						sb.append("</div>");
						i++;
						if(i>=homepageMoudle.getRecords()){
							break;
						}
					}
				}
			}
    }
    out.print(sb.toString());
	
%>