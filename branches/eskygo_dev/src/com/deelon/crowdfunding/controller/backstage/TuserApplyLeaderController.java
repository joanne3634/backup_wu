package com.deelon.crowdfunding.controller.backstage;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.model.backstage.TcuserAudit;
import com.deelon.crowdfunding.model.backstage.TuserApplyLeader;
import com.deelon.crowdfunding.service.backstage.TuserApplyLeaderService;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.sysManager.TuserAuditService;
import com.deelon.platform.model.system.Dictionary;
import com.deelon.platform.service.system.DictionaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Create By [MyLiao]
 * 申请领投资格审核Controller
 */
@ Controller
@ RequestMapping({"/crowdfunding/backstage/tuserapplyleader/"})
public class TuserApplyLeaderController extends BaseController{
	@Resource
	private TuserAuditService tuserAuditService;
	@ Resource
	private TuserApplyLeaderService tuserApplyLeaderService;
	@ Resource
	private TUserService tuserService;
	@Autowired
	DictionaryService dictionaryService;
	@ RequestMapping({"list"})
	@ Action(description="查看申请领投资格分页列表")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws Exception
	{ 
		QueryFilter queryFilter = new QueryFilter(request, "tApplyLeaderItem");
		Map<String,Object> map=queryFilter.getFilters();
		List<TuserApplyLeader> list = this.tuserApplyLeaderService.getApplyLeaderInfo(queryFilter);
		request.setAttribute("isCheck", map.get("isCheck"));
		ModelAndView mv = getAutoView().addObject("tApplyLeaderList", list);
		return mv;
	}
	
	@ RequestMapping({"pass"})
	@ Action( description = "申请领投资格审核通过")
	public void pass(HttpServletRequest request, HttpServletResponse response,TuserApplyLeader tuserApplyLeader, BindingResult bindResult) throws Exception
	{
		ResultMessage message = null;
		  String resultMsg = null;
		String preUrl = RequestUtil.getPrePage(request);
		
		try{
			Long[] arrID = RequestUtil.getLongAryByStr( request, "applyLeaderId" );
			this.tuserApplyLeaderService.passByIds(arrID);
//			ResultMessage resultMessage = validForm("tuserApplyLeader", tuserApplyLeader, bindResult, request);	
//			if(resultMessage.getResult()==0){ 
//				writeResultMessage(response.getWriter(), s);
//				return;
//			}
			
			String userName = ContextUtil.getCurrentUser().getUsername();
			if(tuserApplyLeader.getApplyLeaderId() != null){
				if(tuserApplyLeader.getApplyTime() == null){
					TuserApplyLeader leaderObj = tuserApplyLeaderService.getById(arrID[0]);
					if(leaderObj != null && leaderObj.getApplyInfo() != null)
					    tuserApplyLeader.setApplyTime(leaderObj.getApplyTime());
				}
				tuserApplyLeader.setChecker(ContextUtil.getCurrentUser().getUserId()+"");
				tuserApplyLeader.setIsCheck(1);
				tuserApplyLeader.setCheckerName(userName);
				tuserApplyLeader.setCheckTime(new Date());
				this.tuserApplyLeaderService.update(tuserApplyLeader);
			}
			//message = new ResultMessage( 1, "该申请人提交的领投资格成功被审核通过！<br>恭喜！" );
		}catch(Exception e){
			e.printStackTrace();
			message = new ResultMessage( 0, "审核数据失败" );
		}
		//addMessage( message, request );
		//response.sendRedirect( preUrl );
		 resultMsg = getText("record.updated", new Object[] { "数据" });
	     writeResultMessage(response.getWriter(), resultMsg, 1);
	}
	
	@ RequestMapping({"fail"})
	@ Action( description = "申请领投资格审核通过")
	public void fail(HttpServletRequest request, HttpServletResponse response,
			String  checkFailReason) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage(request);
		 String resultMsg = null;
		 
		try{
			Long[] arrID = RequestUtil.getLongAryByStr( request, "applyLeaderId" );
			this.tuserApplyLeaderService.failByIds(arrID);
			if(arrID != null && arrID.length > 0){
				TuserApplyLeader tuseryLeader = tuserApplyLeaderService.getById(arrID[0]);
				tuseryLeader.setCheckFailReason(checkFailReason);
				tuseryLeader.setChecker(ContextUtil.getCurrentUser().getUserId()+"");
				tuseryLeader.setCheckerName(ContextUtil.getCurrentUser().getUsername());
				tuseryLeader.setCheckTime(new Date());
				this.tuserApplyLeaderService.update(tuseryLeader);
			}
			
			message = new ResultMessage( 1, "该申请人提交的领投资格被否决！<br>请再审查相关资料！" );
		}catch(Exception e){
			message = new ResultMessage( 0, "审核数据失败" );
		}
		//addMessage( message, request );
		//response.sendRedirect( preUrl );
		 resultMsg = getText("record.updated", new Object[] { "数据" });
	      writeResultMessage(response.getWriter(), resultMsg, 1);
	}
	
	@ RequestMapping({"cancel"})
	@ Action( description = "只针对审核失败的投资人，重新审核")
	public void cancel(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage(request);
		 String resultMsg = null;
		try{
			Long[] arrID = RequestUtil.getLongAryByStr( request, "applyLeaderId" );
			this.tuserApplyLeaderService.cancel(arrID);
			message = new ResultMessage( 1, "该申请人提交的领投资格被否决！<br>请再审查相关资料！" );
		}catch(Exception e){
			message = new ResultMessage( 0, "审核数据失败" );
		}
		//addMessage( message, request );
		//response.sendRedirect( preUrl );
		 resultMsg = getText("record.updated", new Object[] { "数据" });
	      writeResultMessage(response.getWriter(), resultMsg, 1);
	}
	
	@ RequestMapping( { "del" } )
	@ Action( description = "删除申请领投资格数据")
	public void del(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request );
		try{
			Long[] arrID = RequestUtil.getLongAryByStr( request, "applyLeaderId" );
			if(arrID != null && arrID.length > 0){
				TuserApplyLeader tuserappler = tuserApplyLeaderService.getById(arrID[0]);
				if(tuserappler != null && tuserappler.getUserId() != null){
					TUser tuser = tuserService.getById(tuserappler.getUserId());
					if(tuser != null){
						tuser.setIsLeader(0);
						tuserService.update(tuser);
					}
				}
			}
			this.tuserApplyLeaderService.delByIds(arrID);
			message = new ResultMessage( 1, "删除数据成功" );
		}catch(Exception e){
			message = new ResultMessage( 0, "删除数据失败" );
		}
		addMessage( message, request );
		response.sendRedirect( preUrl );
	}
	
	@ RequestMapping( { "edit" } )
	@ Action( description = "编辑申请领投资格数据" )
	public ModelAndView edit(HttpServletRequest request) throws Exception
	{
		String userName = "";
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "applyLeaderId" ) );
		TuserApplyLeader tuserApplyLeader = null;
		if(pkId.longValue() != 0L)
			tuserApplyLeader = (TuserApplyLeader) this.tuserApplyLeaderService.getById(pkId);
		else
			tuserApplyLeader = new TuserApplyLeader();
		if(tuserApplyLeader != null && tuserApplyLeader.getUserId() != null){
			QueryFilter filter = new QueryFilter();
			filter.addFilter("applyLeaderId", pkId);
			List<TuserApplyLeader> list = tuserApplyLeaderService.getApplyLeaderInfo(filter);
			TuserApplyLeader tuserLeader = null;
			if(list != null)
				tuserLeader = list.get(0);
			if(null != tuserLeader)
				tuserApplyLeader.setIsCompany(tuserLeader.getIsCompany());
			TUser tcuser = tuserService.getById(tuserApplyLeader.getUserId());
			if(tcuser != null)
				userName = tcuser.getLoginName();
		}
		//获取项目所属行业
		List<Dictionary> list = null;
		if(null != dictionaryService) {
			list = dictionaryService.getByNodeKey("PIND");
		}
		ModelAndView mv=getAutoView().addObject("tuserApplyLeader", tuserApplyLeader)
				.addObject("userName",userName).addObject("applyLeaderId", pkId)
				.addObject("dictionaryList",list);
		return mv;
	}

	@ RequestMapping( { "get" } )
	@ Action( description = "查看申请领投资格数据" )
	public ModelAndView get(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "applyLeaderId" );
		TuserApplyLeader tuserApplyLeader = (TuserApplyLeader) this.tuserApplyLeaderService.getById(Long.valueOf(pkId));
		return getAutoView().addObject("tuserApplyLeader", tuserApplyLeader);
	}
	
	

	   @RequestMapping({"tuserAuditLeader"})
	   @Action(description="审核成为领投人")
	   public void tuserAuditLeader(HttpServletRequest request, HttpServletResponse response) throws Exception
	   {
		    String isLeader = request.getParameter("isLeader");
		    String userId = request.getParameter("userId");
		    String applyLeaderId = request.getParameter("applyLeaderId");
		    
		   TuserApplyLeader tuserApplyLeader = tuserApplyLeaderService.getById(Long.valueOf(applyLeaderId));
		    tuserApplyLeader.setIsCheck(1);
		    this.tuserApplyLeaderService.update(tuserApplyLeader);
		    
		    TcuserAudit userAudit = this.tuserAuditService.getById(Long.valueOf(userId));
		    userAudit.setIsLeader(Integer.valueOf(isLeader));
		    
		    this.tuserAuditService.update(userAudit);
		    String resultMsg = getText("record.updated", new Object[] { "数据" });
		    writeResultMessage(response.getWriter(), resultMsg, 1);
		     }
	   
	   

}
