package com.deelon.crowdfunding.controller.front;

/**
 * 
 *项目设置控制器
 * author:czz
 */
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.page.PageBean;
import com.deelon.core.util.FileUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.common.util.TUserUtil;
import com.deelon.crowdfunding.model.backstage.Tcproject;
import com.deelon.crowdfunding.model.backstage.TcprojectAttachment;
import com.deelon.crowdfunding.model.backstage.TcprojectInvest;
import com.deelon.crowdfunding.service.backstage.TcprojectAttachmentService;
import com.deelon.crowdfunding.service.backstage.TcprojectInvestService;
import com.deelon.crowdfunding.service.backstage.TcprojectService;
import com.deelon.crowdfunding.service.front.TProjectApplyViewService;
import com.deelon.loan.model.aboutus.TUserMsgRemind;
import com.deelon.loan.model.front.TProjectApplyView;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.service.aboutus.TUserMsgRemindService;
import com.deelon.loan.service.front.TUserService;
import com.deelon.platform.service.util.ServiceUtil;

@Controller
@RequestMapping({ "/crowdfunding/projectApply/" })
public class TProjectApplyController extends BaseFormController{
	
	@Autowired
	private TProjectApplyViewService tProjectApplyViewService;
	@Autowired
	private TUserService tUserService;
	@Autowired
	private TcprojectService tcprojectService;
	@Autowired
	private TcprojectInvestService tcprojectInvestService;
	@Autowired
	private TUserMsgRemindService tUserMsgRemindService;
	@Autowired
	private TcprojectAttachmentService tcprojectAttachmentService;

	
	/**
	 * 
	 * @param request 领投列表
	 * @return
	 * @throws Exception
	 */
	@RequestMapping({ "checkTheLeadList" })
	public ModelAndView checkTheLeadList(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Long projectId=RequestUtil.getLong( request, "projectId" );
		List<TcprojectInvest> leadInvestList=null;
		Tcproject tcproject = null;
		if (projectId.longValue() != 0L){
			tcproject=tcprojectService.getById(projectId);
			if(tcproject.getPisCheck()==0){
				return new ModelAndView("/crowdfunding/front/projectNoCheckedMsg.jsp");
			}
			
			leadInvestList=tcprojectInvestService.getLeadInvestforPro(projectId);
		}
		return new ModelAndView("/crowdfunding/front/checkTheLeadList.jsp").addObject( "tcproject", tcproject)
		.addObject( "leadInvestList", leadInvestList);
	}
	
	/**
	 * 
	 * @param request 跟投列表
	 * @return
	 * @throws Exception
	 */
	@RequestMapping({ "checkTheFollowList" })
	public ModelAndView checkTheFollowList(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Long projectId=RequestUtil.getLong( request, "projectId" );
		List<TcprojectInvest> followInvestList=null;
		Tcproject tcproject = null;
		if (projectId.longValue() != 0L){
			tcproject=tcprojectService.getById(projectId);
			if(tcproject.getPisCheck()==0){
				return new ModelAndView("/crowdfunding/front/projectNoCheckedMsg.jsp");
			}
			Map followMap=new HashMap();
			followMap.put("projectId", projectId);
			followMap.put("pitypeId", 3);
			followMap.put("piisCancel", 0);
			followInvestList=tcprojectInvestService.getInvestforProBymap(followMap);
		}
		return new ModelAndView("/crowdfunding/front/checkTheFollowList.jsp").addObject( "tcproject", tcproject)
		.addObject( "followInvestList", followInvestList);
	}
	
	@RequestMapping({ "checkTheViewList" })
	public ModelAndView checkTheViewList(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Long projectId=RequestUtil.getLong( request, "projectId" );
		List<TProjectApplyView> tProjectApplyViewList=null;
		Tcproject tcproject = null;
		if (projectId.longValue() != 0L){
			tcproject=tcprojectService.getById(projectId);
			if(tcproject.getPisCheck()==0){
				return new ModelAndView("/crowdfunding/front/projectNoCheckedMsg.jsp");
			}
			tProjectApplyViewList=tProjectApplyViewService.getTProjectApplyViewList( projectId );
		}
		return new ModelAndView("/crowdfunding/front/checkTheViewList.jsp").addObject( "tcproject", tcproject)
		.addObject( "tProjectApplyViewList", tProjectApplyViewList);
	}
	
	
	
	

	
	/**
	 * 
	 * @param request xiugai项目设置
	 * @return
	 * @throws Exception 			
	 *//*
	@RequestMapping({ "approveLeadApply" })
	@Action(description="设置项目领投跟投申请")
	public ModelAndView approveLeadApply(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Long category=RequestUtil.getLong( request, "category" );
		Long projectId=RequestUtil.getLong( request, "projectId" );
		Long applyId=RequestUtil.getLong( request, "applyId" );
		int processType=RequestUtil.getInt( request, "processType" );
		String denyReason=RequestUtil.getString( request, "denyReason" );
		String result="设置失败";
		if ( applyId.longValue() != 0L ){
			if(category==1L){
				Long leadCount=tcprojectService.getProLeadCount(projectId);
				if(leadCount>0 && processType==2){
					result="对不起，只能设置一个领投人";
					response.getWriter().write(result);
					return null;
				}
				Tcproject tcproject = tcprojectService.getById(projectId);
				TcprojectInvest tcprojectInvest=tcprojectInvestService.getById(applyId);
				tcproject.setPleaderId(tcprojectInvest.getUserId());
				tcprojectInvest.setPichecker(0L);/////////////////////////////////////
				tcprojectInvest.setPicheckTime(new Date());
				if(!denyReason.equals("")){
					tcprojectInvest.setPidenyReason(denyReason);
				}
				tcprojectService.update(tcproject);
				tcprojectInvestService.update(tcprojectInvest);
				result="设置成功";
			}else if(category==2L){
				Long followCount=tcprojectService.getProFollowCount(projectId);
				
				Tcproject tcproject = tcprojectService.getById(projectId);
				TcprojectInvest tcprojectInvest=tcprojectInvestService.getById(applyId);
				tcproject.setPleaderId(tcprojectInvest.getUserId());
				tcprojectInvest.setPichecker(0L);/////////////////////////////////////
				tcprojectInvest.setPicheckTime(new Date());
				if(!denyReason.equals("")){
					tcprojectInvest.setPidenyReason(denyReason);
				}
				tcprojectService.update(tcproject);
				tcprojectInvestService.update(tcprojectInvest);
				result="设置成功";
				
			}
		}
		response.getWriter().write(result);
		return null;
		
		//return new ModelAndView("loan/myAccount/approveProject.jsp").addObject( "tProjectApplyView", tProjectApplyView );
	}*/
	
	
	/**
	 * 
	 * @param request
	 * @return
	 * @throws Exception 			
	 */
	@RequestMapping({ "approveCheckTheLead" })
	@Action(description="设置项目领投申请")
	@ResponseBody
	public String approveCheckTheLead(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Long projectId=RequestUtil.getLong( request, "projectId" );
		Long investId=RequestUtil.getLong( request, "investId" );
		int processType=RequestUtil.getInt( request, "processType" );
		String denyReaSon=RequestUtil.getString( request, "denyReaSon" );
		String result="设置失败";
		if ( projectId.longValue() != 0L ){
				Long leadCount=tcprojectInvestService.getleadCountCr(projectId);
				if(leadCount>0 && processType==1){
					result="对不起，只能设置一个领投人";
					return result;
				}
				Tcproject tcproject = tcprojectService.getById(projectId);
				TcprojectInvest tcprojectInvest=tcprojectInvestService.getById(investId);
				
				if(processType==1){
					tcproject.setPleaderId(tcprojectInvest.getUserId());	
					//List<TcprojectInvest> list = tcprojectInvestService.getTprojectInvestByProId(projectId);
					List<TcprojectInvest> list = tcprojectInvestService.getLeadInvestforPro(projectId);
					
					for (TcprojectInvest t: list) {  //同意一个领头人，，其他全部拒绝
						t.setPiisCheck(2);  //拒绝状态
						t.setPichecker(TUserUtil.getLogUser(request).getUserId());  //当前用户
						t.setPicheckTime(new Date());  
						tcprojectInvestService.update(t);   
					}
				}
				tcprojectInvest.setPiisCheck(processType);
				//创业者确认投资记录后增加投资人的询价次数
		//		tcprojectInvest.setPiaskPriceTimes(tcprojectInvest.getPiaskPriceTimes()+1);
				tcprojectInvest.setPichecker(TUserUtil.getLogUser(request).getUserId());
				tcprojectInvest.setPicheckTime(new Date());
				
				if(processType==2&&!"1".equals(tcprojectInvest.getPiisPay())){//拒绝
					//如果拒绝之前同意过的领头人，则清空项目表的领头人字段为0
					if(tcproject.getPleaderId().longValue()==tcprojectInvest.getUserId().longValue()){
						tcproject.setPleaderId(0L);	
					}
					if(denyReaSon!=null && !denyReaSon.equals("")){
						tcprojectInvest.setPidenyReason(denyReaSon);
					}
//					int askPriceCount = tcprojectInvest.getPiaskPriceTimes();
//					if(askPriceCount>0) askPriceCount=askPriceCount-1;
//					tcprojectInvest.setPiaskPriceTimes(askPriceCount);
					
					//判断投资人是否做了询价,如果有询价则拒绝后 将投资人询价次数-1,直接接受估值的(即不做询价直接跟投领投的),拒绝后不减投资人询价资格 pyg 2015/4/1
					if(tcprojectInvest.getPiisAskPrice()==1){//已询价的
						tcprojectInvest.setPiaskPriceTimes(tcprojectInvest.getPiaskPriceTimes()+1);
					}
				}
				tcprojectService.update(tcproject);
				tcprojectInvestService.update(tcprojectInvest);
				//如果是拒绝投资申请，应该处理投资加入项目的投资的金额
				tcprojectService.calculateProjectInvestmentInfo(projectId);
		}
		result="设置成功";
		return result;
		//return new ModelAndView("/urlDialog.jsp").addObject("message", "设置成功")
		//		.addObject("url", "checkTheLead.ht?projectId="+projectId);

	}
	
	@RequestMapping({ "approveCheckTheFollowByIds" })
	@Action(description="设置项目跟投申请")
	@ResponseBody
	public String approveCheckTheFollowByIds(HttpServletRequest request,HttpServletResponse response) {
		String ids=RequestUtil.getString( request, "ids" );
		int processType=RequestUtil.getInt( request, "processType" );
		
		String result="设置成功";
		try{
			if ( ids!=null && !ids.equals("") ){
				String idArray[]=ids.split(";");	
				String idStr="";
				TcprojectInvest tcprojectInvest=null;
				Long projectId = 0l;
				for(int i=0;i<idArray.length;i++){
					idStr = idArray[i];
					if(!idStr.equals("")){
						tcprojectInvest = tcprojectInvestService.getById(Long.valueOf(idStr));
						projectId = tcprojectInvest.getProjectId();
						if(processType==2){
							if("1".equals(tcprojectInvest.getPiisPay())){
								continue;//已经付款的投资记录不可以再拒绝
							}
//							int askPriceCount = tcprojectInvest.getPiaskPriceTimes();
//							if(askPriceCount>0) askPriceCount=askPriceCount-1;
//							tcprojectInvest.setPiaskPriceTimes(askPriceCount);
						}
						tcprojectInvest.setPiisCheck(processType);
					//	tcprojectInvest.setPiaskPriceTimes(tcprojectInvest.getPiaskPriceTimes()+1);
						if(tcprojectInvest.getPiaskPriceTimes()!=null&&tcprojectInvest.getPiaskPriceTimes()>0){//2/11 by pyg
							
							tcprojectInvest.setPiaskPriceTimes(tcprojectInvest.getPiaskPriceTimes()-1);
						}else{
							tcprojectInvest.setPiaskPriceTimes(0);
						}
						tcprojectInvest.setPiisAskPrice(0);//去掉询价 //2/11 by pyg
						tcprojectInvest.setPichecker(TUserUtil.getLogUser(request).getUserId());
						tcprojectInvest.setPicheckTime(new Date());
						tcprojectInvestService.update(tcprojectInvest);
					}
				}
				//如果是拒绝投资申请，应该处理投资加入项目的投资的金额
				tcprojectService.calculateProjectInvestmentInfo(projectId);
				
			}
		}catch (Exception e) {
			e.printStackTrace();
			result="设置失败";
			
		}
		return result;
		//return new ModelAndView("/urlDialog.jsp").addObject("message", "设置成功")
		//		.addObject("url", "checkTheLead.ht?projectId="+projectId);

	}
	
	/**
	 * 
	 * @param request
	 * @return
	 * @throws Exception 			
	 */
	@RequestMapping({ "approveCheckTheFollow" })
	@Action(description="设置项目跟投申请")
	@ResponseBody
	public String approveCheckTheFollow(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Long projectId=RequestUtil.getLong( request, "projectId" );
		Long investId=RequestUtil.getLong( request, "investId" );
		int processType=RequestUtil.getInt( request, "processType" );
		String denyReaSon=RequestUtil.getString( request, "denyReaSon" );
		String result="设置成功";
		try{
				TcprojectInvest tcprojectInvest=tcprojectInvestService.getById(investId);
				tcprojectInvest.setPiisCheck(processType);
				tcprojectInvest.setPichecker(TUserUtil.getLogUser(request).getUserId());
				tcprojectInvest.setPicheckTime(new Date());
				if(processType==2){//拒绝
					//如果是拒绝投资申请，应该处理投资加入项目的投资的金额
					Tcproject tcproject = tcprojectService.getById(tcprojectInvest.getProjectId());
					tcproject.setPinvestAmount(tcproject.getPinvestAmount().subtract(tcprojectInvest.getPiinvest()));
					
					
					
					
					tcprojectService.update(tcproject);
					if(denyReaSon!=null && !denyReaSon.equals("")){
						tcprojectInvest.setPidenyReason(denyReaSon);
					}
//					int askPriceCount = tcprojectInvest.getPiaskPriceTimes();
//					if(askPriceCount>0) askPriceCount=askPriceCount-1;
					
					//判断投资人是否做了询价,如果有询价则拒绝后 将投资人询价次数-1,直接接受估值的(即不做询价直接跟投领投的),拒绝后不减投资人询价资格 pyg 2015/4/1
					if(tcprojectInvest.getPiisAskPrice()==1){//已询价的
						tcprojectInvest.setPiaskPriceTimes(tcprojectInvest.getPiaskPriceTimes()+1);
					}
				}
				
				
				tcprojectInvestService.update(tcprojectInvest);
				//如果是拒绝投资申请，应该处理投资加入项目的投资的金额
				tcprojectService.calculateProjectInvestmentInfo(projectId);
				
		}catch(Exception e){
			e.printStackTrace();
			result="设置失败";
		}
		return result;
		
	}
	/**
	 * 申请查看项目
	 * @param request 
	 * @return
	 * @throws Exception 			
	 */
	@RequestMapping({ "applyTheProjectView" })
	@Action(description="项目申请查看")
	@ResponseBody
	public String applyTheProjectView(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Long projectId=RequestUtil.getLong( request, "projectId" );
		String result="申请成功，请等待项目创建人审核。";
		try{
			TProjectApplyView tProjectApplyView = new TProjectApplyView();
			tProjectApplyView.setApplyViewId(UniqueIdUtil.genId());
			if(null!=TUserUtil.getLogUser(request)){
				tProjectApplyView.setUserId(TUserUtil.getLogUser(request).getUserId());
			}else{
				return "需要先登录才能申请查看项目详情。";
			}
			tProjectApplyView.setProjectId(projectId);
			tProjectApplyView.setPavIsAgree(0);
			tProjectApplyView.setApplyTime(new Date());
			tProjectApplyViewService.add(tProjectApplyView);
		}catch(Exception e){
			e.printStackTrace();
			result="申请失败,请稍后再尝试申请。或者先登陆试试看";
		}
		return result;
	}
	/**
	 * 
	 * @param request xiugai项目设置
	 * @return
	 * @throws Exception 			
	 */
	@RequestMapping({ "approveCheckTheView" })
	@Action(description="设置项目申请查看")
	@ResponseBody
	public String approveCheckTheView(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Long projectId=RequestUtil.getLong( request, "projectId" );
		Long applyId=RequestUtil.getLong( request, "applyId" );
		int processType=RequestUtil.getInt( request, "processType" );
		String result="设置成功";
		try{
			TProjectApplyView tProjectApplyView = (TProjectApplyView)tProjectApplyViewService.getById(applyId);
			tProjectApplyView.setPavIsAgree(processType);
			tProjectApplyView.setPavAgreeTime(new Date());
			tProjectApplyViewService.update(tProjectApplyView);
			TUserMsgRemind tUserMsgRemind = new TUserMsgRemind();
			Long id = Long.valueOf(UniqueIdUtil.genId());
			tUserMsgRemind.setMsgRemindId(id);
			tUserMsgRemind.setTypeId(1);
			tUserMsgRemind.setSenderId(TUserUtil.getLogUser(request).getUserId());
			tUserMsgRemind.setSendTime(new Date());
			if(processType==2){
				tUserMsgRemind.setContent("对不起，您申请查看我的项目失败");
			}else{
				tUserMsgRemind.setContent("申请查看成功，谢谢支持");
			}
			
			tUserMsgRemind.setReceiverId(tProjectApplyView.getUserId());
			tUserMsgRemind.setStateId(0);
			tUserMsgRemind.setIsReply(0l);
			tUserMsgRemind.setReplyID(0l);

			tUserMsgRemindService.add(tUserMsgRemind);
			result="设置成功";
		}catch(Exception e){
			e.printStackTrace();
			result="设置失败";
		}
		return result;


	}
	
	/**
	 * 
	 * @param request xiugai项目设置
	 * @return
	 * @throws Exception 			
	 */
	@Action(description="删除领投申请")
	@RequestMapping({ "theLeadDel" })
	public void theLeadDel(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String ids=RequestUtil.getString( request, "ids" );
		
		String result="删除失败";

			String []id=ids.split(";");
			for(int i=0;i<id.length;i++){
				tcprojectInvestService.delById(Long.valueOf(id[i]));
			}
		result="删除成功";
		response.getWriter().write(result);

	}
	
	/**
	 * 
	 * @param request xiugai项目设置
	 * @return
	 * @throws Exception 			
	 */
	@Action(description="删除项目申请")
	@RequestMapping({ "theViewDel" })
	public void theViewDel(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String ids=RequestUtil.getString( request, "ids" );
		
		String result="删除失败";
		String idt="";

			String []id=ids.split(";");
			for(int i=0;i<id.length;i++){
				idt=id[i];
				if(!idt.equals("")){	
					tProjectApplyViewService.delById(Long.valueOf(idt));
					
				}
			}
		result="删除成功";
		response.getWriter().write(result);

	}
	
	
	/*
	 * 项目设置列表
	 */
	@RequestMapping({"tprojectApplyList"})
	public ModelAndView tprojectApplyList(HttpServletRequest request,HttpServletResponse response){
		//String pname = RequestUtil.getString(request, "pname");
		//String ptypeId = RequestUtil.getString(request, "ptypeId");
		
		//分页加参数
		Long aaa=TUserUtil.getLogUser(request).getUserId();
		QueryFilter filter = new QueryFilter();
		filter.addFilter("creator", TUserUtil.getLogUser(request).getUserId());
		int page = RequestUtil.getInt(request, "current_page", 1);//默认存入页码
		int pageSize = RequestUtil.getInt(request, "pageSize",5);//存入每页显示的条数
		PageBean pb=new  PageBean(page, pageSize); 
		filter.setPageBean(pb);
		List<Tcproject> tcprojectApplyList=tcprojectService.getProjectCr(filter);
//		List<Tcproject> tcprojectApplyList2=new ArrayList<Tcproject>();
//		Tcproject tcproject2 = null;
//		for(int i=0;i<tcprojectApplyList.size();i++){
//			tcproject2 = tcprojectApplyList.get(i);
//			JSONObject jsonObj = JSONObject.fromObject(tcproject2.getPpic());
//			JSONArray jsonArray = jsonObj.getJSONArray("attachs");
//			Long fileId=jsonArray.getJSONObject(0).getLong("fileId");
//			TcprojectAttachment tcprojectAttachment=tcprojectAttachmentService.getById(fileId);
//			tcproject2.setFilePaths(tcprojectAttachment.getPapath());
//			tcproject2.setFileNames(tcprojectAttachment.getPaname());
//			tcprojectApplyList2.add(tcproject2);
//		}
		request.setAttribute( "page_bean", pb);//分页参数传入页面
		return new ModelAndView("/crowdfunding/front/tprojectApplyList.jsp").addObject("tcprojectApplyList", tcprojectApplyList)
		.addObject( "page_bean", pb );
		
	}
	/**
	 * 检查当前用户是否有查看项目的权限
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping({"checkViewProjectPrivilage"})
	@ResponseBody
	public String checkViewProjectPrivilage(HttpServletRequest request,HttpServletResponse response
			,String projectId) throws Exception {
		
		// 查看领投人是否能上传调查报告和评价, 条件是1.投资人具有领投人资格,2.领投的项目被创业者审批通过,作为项目领投人 pyg 2/3 d.
		List<TcprojectInvest> list=tcprojectInvestService.getTcprojectInvest(Long.valueOf(projectId),TUserUtil.getLogUser(request).getUserId());
		String flag = "no";
		if(list!=null&&list.size()>0){
			for(TcprojectInvest t:list){
				TcprojectInvest ij=t;
				if(ij!=null&&ij.getPiisCheck()==1){//创业者已同意
					flag =  "yes";
				}
				
				
			}
		}
		return flag;
		
		/*List<TProjectApplyView> tProjectApplyViewList=null;
		if (null != projectId && projectId.trim().length() > 0){
			QueryFilter filter = new QueryFilter();
			filter.addFilter("userId", TUserUtil.getLogUser(request).getUserId());
			filter.addFilter("projectId",projectId);
			filter.addFilter("pavIsAgree", 1);
			tProjectApplyViewList=tProjectApplyViewService.getAll(filter);
			if(null != tProjectApplyViewList && tProjectApplyViewList.size() > 0){
				TProjectApplyView view = tProjectApplyViewList.get(0);
				if(view.getPavIsAgree() != 1){//已经申请了该项目上传调查报告与评价的查看权限
					return "no";
				}else{
					return "yes";
				}
			}else{
				return "noDataList";
			}
		}*/
		//return null;
	}
}
