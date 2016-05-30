package com.deelon.loan.controller.front;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.page.PageBean;
import com.deelon.core.util.AppUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.service.front.TUserAuditMatService;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TprojectInvestService;
import com.deelon.loan.service.front.UserInfoService;
import com.deelon.loan.service.sysManager.TprojectService;


@Controller
@RequestMapping({ "/tenderProjects/" })
public class TenderProjectsController extends BaseController {
	
	@Resource
	private TprojectService tProjectService;
	@Resource
	private UserInfoService userInfoService;
	@Resource
	private TUserService tUserService;
	@Resource
	private TprojectInvestService tprojectInvestService;
	@Resource
	private TUserAuditMatService tuserAuditMatService;
	/**
	 * 获取借款列表
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping({ "getTenderProjects" })
	public ModelAndView getTenderProjects(HttpServletRequest request) {
		String tradingHours="";
		String taskId = request.getParameter("taskId");   //新手任务Id
		try {
			 tradingHours=(String)AppUtil.getServletContext().getAttribute("TRADING_HOURS");
			 String pdeadlineBegin = request.getParameter("pdeadlineBegin");
				String pdeadlineEnd = request.getParameter("pdeadlineEnd");
				String certLev=request.getParameter("CertLev");
				String typeId=request.getParameter("proType");
				
				Map<String,Object> map = new HashMap<String,Object>();
				map.put("pstatusId", "2");  
				map.put("currentDate", new Date());   //当前时间范围
				map.put("pdeadlineBegin", pdeadlineBegin);
				map.put("pdeadlineEnd", pdeadlineEnd);
				map.put("typeId", typeId);
				map.put("pcertifiLevel", certLev);
				/**/
			 List<TProject> projects = tProjectService.getAllLoanByWhere(map,null);
				if(projects!=null&&projects.size()>0){
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
					if(projects.get(0).getPupdateTime()!=null)
						request.setAttribute("lastUpdateTime", sdf.format(projects.get(0).getPupdateTime()));
					else
						request.setAttribute("lastUpdateTime", sdf.format(new Date()));
					
				}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new ModelAndView("/loan/front/WYLC.jsp").addObject("tradingHours", tradingHours).addObject("taskId", taskId);
	}
	
	/**
	 * 获取借款列表
	 * 
	 * @param request
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping({ "getTenderProjectsListPage" })
	public ModelAndView getTenderProjectsListPage(HttpServletRequest request,HttpServletResponse response) throws IOException {

		String pdeadlineBegin = request.getParameter("pdeadlineBegin");
		String pdeadlineEnd = request.getParameter("pdeadlineEnd");
		String certLev=request.getParameter("CertLev");
		String typeId=request.getParameter("proType");
		String taskId = request.getParameter("taskId");   //新手任务Id
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("pstatusId", "2");  
		map.put("currentDate", new Date());   //当前时间范围
		map.put("pdeadlineBegin", pdeadlineBegin);
		map.put("pdeadlineEnd", pdeadlineEnd);
		map.put("typeId", typeId);
		map.put("pcertifiLevel", certLev);
		//分页加参数
		int page = RequestUtil.getInt(request, "current_page", 1);
	    int pageSize = RequestUtil.getInt(request, "pageSize",PageBean.getDefaultPageSize().intValue());
		PageBean pb=new  PageBean(page, pageSize);
	         
		List<TProject> projects = tProjectService.getAllLoanByWhere(map,pb);
		/**/
		request.setAttribute("projects", projects);
		request.setAttribute( "page_bean", pb );//分页参数传入页面
		return new ModelAndView("/loan/front/WYLCList.jsp").addObject("taskId", taskId);
	}
	
	
	
}
