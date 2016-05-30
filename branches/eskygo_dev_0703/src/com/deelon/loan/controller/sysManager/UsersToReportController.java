package com.deelon.loan.controller.sysManager;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.deelon.core.page.PageBean;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.aboutus.TUserMessage;
import com.deelon.loan.model.aboutus.TUserMsgRemind;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.model.sysManager.Temailinformation;
import com.deelon.loan.model.sysManager.Tsmsinformation;
import com.deelon.loan.model.sysManager.TuserReport;
import com.deelon.loan.model.sysManager.TuserReportFollowup;
import com.deelon.loan.service.aboutus.TUserMsgRemindService;
import com.deelon.loan.service.front.TuserSafeService;
import com.deelon.loan.service.sysManager.TemailinformationService;
import com.deelon.loan.service.sysManager.TsmsinformationService;
import com.deelon.loan.service.sysManager.TuserReportFollowupService;
import com.deelon.loan.service.sysManager.TuserReportService;

@Controller
@RequestMapping({ "/loan/sysManager/usersToReport/" })
public class UsersToReportController extends BaseController {

	@Resource
	private TuserReportService tuserReportService;
	
	@Resource
	private TuserReportFollowupService tuserReportFollowupService;
 
	@Resource
	private TuserSafeService tuserSafeService;
	
	@Resource
	private TsmsinformationService tsmsinformationService;
	
	@Resource
	private TUserMsgRemindService tuserMsgRemindService;
	
	@Resource
	private TemailinformationService temailinformationService;
	
	
	@RequestMapping({"list"})
	  public ModelAndView list(HttpServletRequest request, HttpServletResponse response)
	    throws Exception{ 
		List<TuserReport> list = tuserReportService
				.getUserReportList(new QueryFilter(request,"reportId"));
		if(list!=null&&list.size()>0){
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			for (TuserReport t : list) {
				if(t.getCreateTime()!=null)
				t.setCreateTimes(sdf.format(t.getCreateTime()));
				if(t.getEndTimes()!=null)
				t.setEndTimesS(sdf.format(t.getEndTimes()));
			}
		}
		return getAutoView().addObject("ListVo", list).addObject("queryParam",request.getQueryString());
	  }
	/**
	 * 关闭举报信息
	 * @param request
	 * @return
	 */
	@RequestMapping("closeReport")
	@ResponseBody
	public Object closeReport(HttpServletRequest request,String reportIds){
		ResultMessage resultMessage =  new ResultMessage();
		resultMessage.setResult(1);
		resultMessage.setMessage("操作成功");
		try{
			List<Long> reportIdList = JSONArray.parseArray(reportIds, Long.class);
			if(reportIdList.size()>0){		
				List<TuserReport> list = new ArrayList<TuserReport>();
				for(Long reportId : reportIdList){
					TuserReport report = tuserReportService.getById(reportId);
					if(report !=null && report.getStateId().equals("3")){
						resultMessage.setResult(0);
						resultMessage.setMessage("你选择了已关闭的举报信息，不能重复关闭。");
						list.clear();
						return resultMessage;
					}
					list.add(report);
				}
				for(TuserReport report:list){
					report.setStateId("3");
					tuserReportService.update(report);
				}
			}
		}catch(Exception e){
			resultMessage.setResult(0);
			resultMessage.setMessage("系统异常，关闭失败。");
		}
		return resultMessage;
	}
	/**
	 * 举报跟进
	 *  
	 *  
	 */ 
	@RequestMapping({ "FollowUpReport" })
	public ModelAndView AboutUsList(HttpServletRequest request,
			HttpServletResponse response,String userId,String stateId) {  
		List<TuserReportFollowup> tuserReportFollowup=tuserReportFollowupService.getByReportId(Long.parseLong(userId));
		return new ModelAndView("loan/sysManager/FollowUpReport.jsp").addObject(
				"userId", userId).addObject("tuserReportFollowup",tuserReportFollowup).addObject("stateId",stateId);
	}
	/**
	 * 举报跟进信息保存
	 *  
	 *  
	 */ 
	@RequestMapping({ "FollowUpReportsave" })
	public void FollowUpReportsave(HttpServletRequest request,
			HttpServletResponse response,TuserReportFollowup tuserReportFollowup) {  
		TuserReport tuserReport= tuserReportService.getById(tuserReportFollowup.getReportId());   
		tuserReportFollowup.setCreateTime(new Date());
		tuserReport.setStateId(String.valueOf(tuserReportFollowup.getStateId()));
		tuserReportService.update(tuserReport);
		TUserSafe tuserSafe=tuserSafeService.getUserSafeByUserId(tuserReport.getUserId());   
        //LinkWay=1短信回复
		if(tuserReportFollowup.getLinkWay().equals("1")){
			Tsmsinformation tsmsinformation = new Tsmsinformation();  
    		tsmsinformation.setServiceType(1);
    		tsmsinformation.setMobileNum(tuserSafe.getMobile());
    		tsmsinformation.setMessasge(tuserReportFollowup.getNotes());
    		tsmsinformation.setCreator(tuserReport.getCreator());
    		tsmsinformation.setStatus(0);
    		tsmsinformationService.add(tsmsinformation); 
		} else if(tuserReportFollowup.getLinkWay().equals("2")){ 
			//LinkWay=邮件回复
			Temailinformation temailinformation=new Temailinformation(); 
			temailinformation.setServiceType(1);
			temailinformation.setEmailAddr(tuserSafe.getEmail());
			String header=tuserReportFollowup.getNotes();
			if(header.length()<10){
				temailinformation.setHeader(header);
			}else{
				temailinformation.setHeader(header.substring(0, 9));
			}
			temailinformation.setMessasge(tuserReportFollowup.getNotes());
			temailinformation.setStatus(0);
			temailinformation.setCreator(tuserReportFollowup.getCreator());
			temailinformation.setCreateTime(tuserReportFollowup.getCreateTime());
			temailinformationService.add(temailinformation);
		}
		//将跟进消息添加进服务与通知
		TUserMsgRemind tuserMsgremind=new TUserMsgRemind();
    	tuserMsgremind.setSenderId(Long.parseLong(String.valueOf(tuserReportFollowup.getCreator())));
    	tuserMsgremind.setContent(tuserReportFollowup.getNotes());
    	tuserMsgremind.setReceiverId(tuserReport.getCreator());
    	tuserMsgremind.setStateId(0);  
    	tuserMsgremind.setSendTime(new Date());
    	tuserMsgRemindService.add(tuserMsgremind); 
		tuserReportFollowupService.add(tuserReportFollowup);
	}
	
	/**
	 * 举报跟进信息列表
	 *  
	 *  
	 */ 
	@RequestMapping({ "MyComplaint" })
	public ModelAndView MyComplaint(HttpServletRequest request,
			HttpServletResponse response,TuserReportFollowup tuserReportFollowup) {   
		int userid =Integer.parseInt(request.getParameter("userid"));
	/*	 List<TuserReport> list=tuserReportService.getUserId(userid);*/
		 
		 QueryFilter filter = new QueryFilter();
			filter.addFilter("creator", userid); 
			int page = RequestUtil.getInt(request, "current_page", 1);
			int pageSize = RequestUtil.getInt(request, "pageSize",5);
			PageBean pb=new  PageBean(page, pageSize); 
			filter.setPageBean(pb);
			List<TuserReport>  list = tuserReportService.getBySqlKeyAll(filter, TuserReport.class, "getUserId");
			 request.setAttribute( "page_bean", pb );
		 return new ModelAndView("loan/aboutus/MyComplaint.jsp").addObject("list",list).addObject( "page_bean", pb );
	}
	/**
	 * 举报跟进信息详情
	 *  
	 *  
	 */ 
	@RequestMapping({ "MyComplaintDetails" })
	public ModelAndView MyComplaintDetails(HttpServletRequest request,
			HttpServletResponse response,TuserReportFollowup tuserReportFollowup) {   
		long userid =Long.parseLong(request.getParameter("userid"));
		TuserReport list=tuserReportService.getById(userid);
		 return new ModelAndView("loan/aboutus/MyComplaintDetails.jsp").addObject("list",list);
	}
	
	/**
	 * 举报保存
	 *  
	 *  
	 */ 
	@RequestMapping({ "Repoetsave" })
	public void Repoetsave(HttpServletRequest request,
			HttpServletResponse response,TuserReport tuserReport) {   
		System.out.println(tuserReport.getReportReason());
		tuserReportService.add(tuserReport);
		 
	}
}
