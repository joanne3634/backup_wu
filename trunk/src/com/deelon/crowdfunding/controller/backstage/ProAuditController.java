package com.deelon.crowdfunding.controller.backstage;

import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.ExceptionUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.model.backstage.Tcproject;
import com.deelon.crowdfunding.model.backstage.TcprojectAttachment;
import com.deelon.crowdfunding.model.backstage.TcprojectHistoryplan;
import com.deelon.crowdfunding.model.backstage.TcprojectModel;
import com.deelon.crowdfunding.model.backstage.TcprojectTeam;
import com.deelon.crowdfunding.service.backstage.TcprojectAttachmentService;
import com.deelon.crowdfunding.service.backstage.TcprojectHistoryplanService;
import com.deelon.crowdfunding.service.backstage.TcprojectModelService;
import com.deelon.crowdfunding.service.backstage.TcprojectService;
import com.deelon.crowdfunding.service.backstage.TcprojectTeamService;
import com.deelon.loan.model.sysManager.Tauditmaterials;
import com.deelon.loan.service.sysManager.TauditmaterialsService;
import com.deelon.platform.model.system.SysUser;

/**
 * 项目审核
 * @author pyg
 *
 */
@Controller
@RequestMapping( { "/crowdfunding/backstage/proAudit/" } )
public class ProAuditController extends BaseController {

	@Resource
	private TcprojectService tcprojectService;
	@Resource
	private TcprojectTeamService tcprojectTeamService;
	@Resource
	private TcprojectModelService tcprojectModelService;
	@Resource
	private TcprojectAttachmentService tcprojectAttachmentService;
	@Resource
	private TcprojectHistoryplanService tcprojectHistoryplanService;
	@Resource
	private TauditmaterialsService tauditmaterialsService;
	
	@RequestMapping( { "list" } )
	@Action( description = "查看Tproject分页列表" )
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception{ 
		
		/* 1.这里只查询 新申请的项目,不包括 询价众筹阶段所流标的项目.
		 * 2.如果要查询 项目审核阶段 已审核过的项目 则只查询 初审中的
		 * 
		 * 
		 */
		
		long userId=ContextUtil.getCurrentUserId();
		QueryFilter queryFilter=new QueryFilter(request, "projectId");
		String pcheckTime = request.getParameter("pcheckTime");
		Map<String,Object> map=queryFilter.getFilters();
		/*String pstatus=(String)map.get("pstatus");
		//1.初次查询 为审核的 初审项目
		if(StringUtil.isNotEmpty(pstatus)){
			
		}else{//初始 查询未审核的
			
		}*/
		
		
		queryFilter.addFilter("userId", userId);//当取用户审核过的项目时 用到
		
	    if(pcheckTime=="1")
	       queryFilter.addFilter("pcheckTime", pcheckTime); //未审核
	    else if(pcheckTime=="2")
	       queryFilter.addFilter("pcheckTime", pcheckTime); //已审核
	    
		List<Tcproject> list = tcprojectService.getToAuditPro(queryFilter);
		request.setAttribute("pstatus", map.get("pstatus"));
		ModelAndView mv = getAutoView().addObject("tprojectList", list );
		return mv;
	}
	
	@RequestMapping( { "edit" } )
	@Action( description = "编辑Tproject数据"  )
	public ModelAndView edit( HttpServletRequest request ) throws Exception{
		String flag= request.getParameter("flag");
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "projectId" ) );
		String IsShowBtn=request.getParameter("IsShowBtn");
		Tcproject tproject = null;
		List<TcprojectTeam> listT=null;//创业团队
		TcprojectModel tcprojectModel=null;//商业模式
		List<TcprojectAttachment> listA=null;//附件信息
		List<TcprojectHistoryplan> listH=null;//历史情况
		List<Tauditmaterials> listTM=null;//审核材料
		List<Tcproject> tprojectList = this.tcprojectService.getToAuditPro(new QueryFilter(request, "projectId"));
		if ( pkId.longValue() != 0L && tprojectList.size()>0){
			tproject = tprojectList.get(0);
		

		 
			tcprojectModel=tcprojectModelService.getByProId(pkId);
			listA= tcprojectAttachmentService.getByProId(pkId);
			/**
			 * 地产项目 去掉项目团队，历史情况 的查询
			 */
			if(!"3".equals(tproject.getPtypeId())){
				Map<String,Object> map=new HashMap<String,Object>();
				map.put("projectId", pkId);
				listT=tcprojectTeamService.getByProId(pkId);
				listH= tcprojectHistoryplanService.getByProId(map);
			}


			listTM=tauditmaterialsService.getAudiMeByUserId(tproject.getCreator());
			if(listTM!=null&&listTM.size()>0){
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
				for (Tauditmaterials t : listTM) {
					if(t.getCheckDate()!=null)
						t.setAuditDate(sdf.format(t.getCheckDate()));
				}
			}
		}else
		{
			tproject = new Tcproject();
		}

		request.setAttribute("tcprojectModel", tcprojectModel);
		request.setAttribute("listA", listA);
		request.setAttribute("listT", listT);
		request.setAttribute("listH", listH);
		request.setAttribute("listTM", listTM);
		request.setAttribute("IsShowBtn", IsShowBtn);
		return getAutoView().addObject( "tcproject", tproject ).addObject( "projectId", pkId ).addObject("flag",flag);
	}

	@RequestMapping( { "get" } )
	@Action( description = "查看Tproject数据" )
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception{
		long pkId = RequestUtil.getLong( request, "projectId" );
		Tcproject tproject = (Tcproject) this.tcprojectService.getById( Long.valueOf( pkId ) );
		return getAutoView().addObject( "tproject", tproject );
	}
	
	@RequestMapping( { "valution" } )
	@Action( description = "打开修改项目估值页面" )
	public ModelAndView valution( HttpServletRequest request, HttpServletResponse response ) throws Exception{
		long pkId = RequestUtil.getLong( request, "projectId" );
		Tcproject tproject = (Tcproject) this.tcprojectService.getById( Long.valueOf( pkId ) );
		return getAutoView().addObject( "tproject", tproject );
	}
	
	@RequestMapping( { "updateValution" } )
	@Action( description = "保存运营平台修改后的项目估值" )
	public void updateValution( HttpServletRequest request, HttpServletResponse response,String projectId,String pvaluationFinalNew ) throws Exception{
		
		 ResultMessage message = new ResultMessage(1, "保存成功！");
		 PrintWriter writer = response.getWriter();
		 
	//	long pkId = RequestUtil.getLong( request, "projectId" );
	//	String pvaluationFinalNew=request.getParameter("pvaluationFinalNew");
		
		try {
			
			Tcproject tproject = (Tcproject) this.tcprojectService.getById( Long.valueOf( projectId ) );
			if(tproject!=null){
				if(StringUtil.isNotEmpty(pvaluationFinalNew)){
					if(tproject.getPvaluationFinalNew()==null||tproject.getPvaluationFinal().equals(new BigDecimal("0")))
					tproject.setPvaluationFinalNew(tproject.getPvaluationFinal());//存放创业者的估值
					tproject.setPvaluationFinal(new BigDecimal(pvaluationFinalNew));//将运营方的估值 放入最终估值
					tcprojectService.update(tproject);
				}else{
					 message = new ResultMessage(0, "没有取到 运营人员对项目的估值,请联系管理员!");
				}
			}else{
				message = new ResultMessage(0, "没有找到对应的创业项目,请联系管理员!");
			}
		} catch (Exception e) {
			 String msg = ExceptionUtil.getExceptionMessage(e);
		        message = new ResultMessage(0, msg);
		       e.printStackTrace();
		}
		 writer.print(message);
		
		
	}
	
	
	
	
	 @RequestMapping({"updates"})
	 @ResponseBody
	 @Action(description="初审项目 审核通过")
	  public Map<String,Object> save(HttpServletRequest request, HttpServletResponse response,String applyIds,String pstatusId,String agOrdisag){
		 SysUser su=ContextUtil.getCurrentUser();
		 
		 try {
			 Long[] lAryId = RequestUtil.getLongAryByStr(applyIds);
			 String isrecomm = request.getParameter("isrecomm");
			 GregorianCalendar gc=new GregorianCalendar(); 
			 Map<String,Object> map=new HashMap<String,Object>();  
			 for (Long id : lAryId){
				 if(StringUtil.isNotEmpty(isrecomm)){
					 Tcproject t=tcprojectService.getById(id);
					 if("1".equals(isrecomm)){
						 t.setPisRecommended(0);//取消推荐项目
						 map.put("msg","取消推荐项目成功");
					 }else{
						 t.setPisRecommended(1);//推荐项目
						 map.put("msg","项目推荐成功");
					 }
					 tcprojectService.update(t);
				 }else{//审核通过
					 /*项目审核有如下情况:
					  * 1.新项目状态为'申请'
					  *  a.当选择通过时,项目状态直接为3(询价认筹阶段).
					  *  b.当选择拒绝时,分两种情况
					  *    (1)先看平台拒绝次数是否大于1,如果大于1,直接流标
					  *    (2)如果平台拒绝次数不大于1, 项目状态修改为2(初审中).
					  * 
					  * 
					  */
					 
					// 当选择通过时,项目状态直接为3(询价认筹阶段).
				    Tcproject t=tcprojectService.getById(id);
				    t.setPstateId(3+"");//审核通过，进入询价认筹阶段
				    t.setPisCheck(1);//审核通过
				    t.setPchecker(su.getUserId());//审核人
				    t.setPcheckTime(new Date());//审核时间
				    t.setPopenDate(new Date());//开标时间
				    gc.setTime(t.getPopenDate());
				    if(t.getPopenDays()!=0){
				    		
				    	gc.add(5, t.getPopenDays());
				    	t.setPcloseDate(gc.getTime());//接收时间
				    }
				    tcprojectService.update(t);
				    map.put("msg", "数据操作成功,项目通过审核!");
				 }
			    }
			 return map;
		} catch (Exception e) {
			   Map<String,Object> map=new HashMap<String,Object>();  
				 map.put("msg", "数据操作失败!");
			return 	map;
		}
		 
	  }
	
	@Action(description="保存不通过审核时的说明信息 ")
	@RequestMapping({"saveCheckRemark_"})
	 public void saveCheckRemark_(HttpServletRequest request, HttpServletResponse response,String pcheckRemark,String projectId)
			    throws Exception {
		 ResultMessage message = new ResultMessage(1, "操作成功！");
		 PrintWriter writer = response.getWriter();
		long userId=ContextUtil.getCurrentUser().getUserId();
		 try {
			 /*项目审核有如下情况:
			  * 
			  *  b.当选择拒绝时,分两种情况
			  *    (1)先看平台拒绝次数是否大于=1,如果大于=1,直接流标
			  *    (2)如果平台拒绝次数不大于1, 项目状态修改为2(初审中).
			  * 
			  *   2015/2/5 讨论 允许创业者无限次修改项目
			  */
			 Long[] lAryId = RequestUtil.getLongAryByStr(projectId);
			 for (Long id : lAryId){
			    	Tcproject t=tcprojectService.getById(id);
			    		
			    		t.setPcheckRemark(pcheckRemark);//不通过原因
			    		if(t.getPcheckTimes()>=1){//超过2次直接流标
			    			t.setPstateId(7+"");;//流标
			    			t.setPcheckTimes(t.getPcheckTimes()+1);//审核次数+1
			    			t.setPbreakRemark("项目超过2次修改次数");//流标原因
			    			t.setPbreakTime(new Date());
			    			t.setPisBreak(1);
			    		}else{
			    			t.setPstateId(9+"");;//初审未通过
			    
			    		}
			    		t.setPcheckTimes(t.getPcheckTimes()+1);//审核次数+1
			    		t.setPisCheck(0);//不通过
			    		t.setPchecker(userId);//审核人
			    		t.setPcheckTime(new Date());//审核日期
			    		tcprojectService.update(t);
			    }
		 
		} catch (Exception e) {
			 String msg = ExceptionUtil.getExceptionMessage(e);
		        message = new ResultMessage(0, msg);
		       e.printStackTrace();
		}
		 writer.print(message);
	 }
	
}
