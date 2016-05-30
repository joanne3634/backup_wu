package com.deelon.crowdfunding.controller.backstage;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.ExceptionUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.common.constants.WuyouchouErrorCode;
import com.deelon.crowdfunding.common.exception.CrowdFundException;
import com.deelon.crowdfunding.common.util.DateUtilWuyouchou;
import com.deelon.crowdfunding.common.util.DealTimeUtil;
import com.deelon.crowdfunding.model.backstage.*;
import com.deelon.crowdfunding.service.backstage.*;
import com.deelon.loan.model.sysManager.Tauditmaterials;
import com.deelon.loan.service.sysManager.TauditmaterialsService;
import com.deelon.platform.model.system.SysUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

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
		queryFilter.addFilter("userId", userId);//当取用户审核过的项目时 用到
	    if("1".equals(pcheckTime)){
	    	queryFilter.addFilter("pcheckTime", pcheckTime); //未审核
	    }else if("2".equals(pcheckTime)){
	    	queryFilter.addFilter("pcheckTime", pcheckTime); //已审核
	    }
		List<Tcproject> list =null;
		try{
			list = tcprojectService.getToAuditPro(queryFilter);
		}catch(Exception e){
			logger.error("list audit project error:errorCode = "+WuyouchouErrorCode.PRJ_SEARCH_LIST_ERROR.getErrorCode(),e);
			throw new CrowdFundException(WuyouchouErrorCode.PRJ_SEARCH_LIST_ERROR.getErrorCode(),
				WuyouchouErrorCode.PRJ_SEARCH_LIST_ERROR.getErrorMsg(),e);
		}
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
			if(tproject!=null&&!"3".equals(tproject.getPtypeId())){
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

	@RequestMapping( { "upd" } )
	@Action( description = "编辑Tproject数据"  )
	public ModelAndView upd( HttpServletRequest request ) throws Exception{
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
			if(tproject!=null&&!"3".equals(tproject.getPtypeId())){
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
		     logger.error("update project error:errorCode = "+WuyouchouErrorCode.PRJ_MODEL_UPDATE_ERROR.getErrorCode(),e);
		     throw new CrowdFundException(WuyouchouErrorCode.PRJ_MODEL_UPDATE_ERROR.getErrorCode(),
				WuyouchouErrorCode.PRJ_MODEL_UPDATE_ERROR.getErrorMsg(),e);
		}
		 writer.print(message);
	}

	@RequestMapping({"saveUpd"})
	@ResponseBody
	@Action(description="项目基本资料修改保存")
	public void saveUpd(HttpServletRequest request, HttpServletResponse response, Tcproject tcproject) throws Exception
	{


		String resultMsg = null;
		try{

			Tcproject t=tcprojectService.getById(tcproject.getProjectId());
			boolean flag = false;
			//0已保存未提交，1已提交 9 初审未通过 三个状态不允许修改时间 结束日期等
			if(t!=null&&("0".equals(t.getPstateId())||"1".equals(t.getPstateId())||"9".equals(t.getPstateId())||"2".equals(t.getPstateId()))){
				flag = true;
			}

			t.setPname(tcproject.getPname());
			//由其他状态更改为预热中时
			if("2".equals(tcproject.getPstateId())){
				t.setPneedWarmUp(1);
				String duration = (String)AppUtil.getServletContext().getAttribute("PROJECT_WARMUP_DURATION");
				if(StringUtil.isEmpty(duration)){
					logger.warn("未取到预热期默认期限");
					throw new RuntimeException("未取到预热期默认期限");
				}
				t.setPopenDate(DateUtilWuyouchou.addDays(new Date(),Integer.valueOf(duration)));
				if(t.getPopenDays()!=0){
					GregorianCalendar gc=new GregorianCalendar();
					gc.add(5, t.getPopenDays());
					t.setPcloseDate(gc.getTime());//结束时间
				}
			}else{
				t.setPneedWarmUp(0);
			}
			t.setPstateId(tcproject.getPstateId());
			t.setPlabel(tcproject.getPlabel());
			t.setPstage(tcproject.getPstage());
			t.setPisHaveOther(tcproject.getPisHaveOther());
			t.setPindustry(tcproject.getPindustry());
			//保证分母不为0
			if(tcproject.getPfinancingAmount()!=null&&(new BigDecimal(0).compareTo(tcproject.getPfinancingAmount())!=0)){
				//融资金额
				t.setPfinancingAmount(tcproject.getPfinancingAmount().multiply(new BigDecimal(10000)));
				//完成比例根据融资金额来计算
				int complete=t.getPinvestAmount().divide(t.getPfinancingAmount(), 2, BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(100)).intValue();
				t.setPcomplete(complete);
			}

			t.setPsetup(tcproject.getPsetup());

			if(!flag && tcproject.getPcloseDate()!=null){
				//结束日期
				t.setPcloseDate(tcproject.getPcloseDate());
				//开标天数根据结束日期来计算
				int days  = DealTimeUtil.daysBetween(t.getPcloseDate(), t.getPopenDate());
				t.setPopenDays(days);
			}

			t.setPisRecommended(tcproject.getPisRecommended());
			t.setPcompanyName(tcproject.getPcompanyName());
			t.setPaddress(tcproject.getPaddress());
			//项目方估计 不是平台的估值
			t.setPvaluationFinal(tcproject.getPvaluationFinal());
			t.setPdetail(tcproject.getPdetail());
	//		//出让股份计算 页面会自己计算 故无需处理
	//		BigDecimal sharePercent = t.getPfinancingAmount().divide(t.getPvaluationFinal().multiply(new BigDecimal("10000")), 2, RoundingMode.HALF_UP).multiply(new BigDecimal(100));
	//		t.setPsharesPercent(sharePercent);

			tcprojectService.update(t);
			resultMsg = getText("修改成功", new Object[] { "数据" });
			writeResultMessage(response.getWriter(), resultMsg, 1);
		}catch(Exception e){
			logger.error("ProAuditController.saveUpd() error:errorCode = "+WuyouchouErrorCode.PRJ_BACKAGE_UPDATE_ERROR.getErrorCode(),e);
			throw new CrowdFundException(WuyouchouErrorCode.PRJ_BACKAGE_UPDATE_ERROR.getErrorCode(),
					WuyouchouErrorCode.PRJ_BACKAGE_UPDATE_ERROR.getErrorMsg(),e);
		}



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
					 t.setUpdateTime(new Date());
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
					 //取得项目预热期期限
					 String duration = (String)AppUtil.getServletContext().getAttribute("PROJECT_WARMUP_DURATION");
					 if(StringUtil.isEmpty(duration)){
						 logger.warn("未取到预热期默认期限");
						 throw new RuntimeException("未取到预热期默认期限");
					 }

				    Tcproject t=tcprojectService.getById(id);

				    t.setPisCheck(1);//审核通过
				    t.setPchecker(su.getUserId());//审核人
				    t.setPcheckTime(new Date());//审核时间
					//需要预热的项目，开标时间为当前日期+默认设置的项目有预热期，且状态转为2：预热中
					//否则开标时间取系统当前时间
					 if(1==t.getPneedWarmUp()){
						t.setPstateId("2");//审核通过，进入预热阶段
						t.setPopenDate(DateUtilWuyouchou.addDays(new Date(),Integer.valueOf(duration)));
					 }else {
						 t.setPstateId("3");//审核通过，进入询价认筹阶段
						 t.setPopenDate(new Date());//开标时间
					 }
				    gc.setTime(t.getPopenDate());
				    if(t.getPopenDays()!=0){
				    	gc.add(5, t.getPopenDays());
				    	t.setPcloseDate(gc.getTime());//结束时间
				    }
					t.setUpdateTime(new Date());
				    tcprojectService.update(t);
				    map.put("msg", "数据操作成功,项目通过审核!");
				 }
			    }
			 return map;
		} catch (Exception e) {
			logger.error("update project error:errorCode = "+WuyouchouErrorCode.PRJ_MODEL_UPDATE_ERROR.getErrorCode(),e);
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
				 		t.setUpdateTime(new Date());
			    		tcprojectService.update(t);
			    }
		 
		} catch (Exception e) {
			 String msg = ExceptionUtil.getExceptionMessage(e);
		     message = new ResultMessage(0, msg);
		     logger.error("update project error:errorCode = "+WuyouchouErrorCode.PRJ_MODEL_UPDATE_ERROR.getErrorCode(),e);
		}
		 writer.print(message);
	 }
}
