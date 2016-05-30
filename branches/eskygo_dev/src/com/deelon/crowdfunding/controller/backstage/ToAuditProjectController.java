package com.deelon.crowdfunding.controller.backstage;

import java.io.PrintWriter;
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
 * 审核中的项目
 * @author pyg
 *
 */
@Controller
@RequestMapping( { "/crowdfunding/backstage/toAuditProject/" } )
public class ToAuditProjectController extends BaseController {
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
		List<Tcproject> list = tcprojectService.getToAuditPro(new QueryFilter(request, "projectId"));
		
		ModelAndView mv = getAutoView().addObject("tprojectList", list );
		return mv;
	}
	
	@RequestMapping( { "edit" } )
	@Action( description = "编辑Tproject数据"  )
	public ModelAndView edit( HttpServletRequest request ) throws Exception{
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "projectId" ) );
		Tcproject tproject = null;
		List<TcprojectTeam> listT=null;
		TcprojectModel tcprojectModel=null;
		List<TcprojectAttachment> listA=null;
		List<TcprojectHistoryplan> listH=null;
		List<Tauditmaterials> listTM=null;
		if ( pkId.longValue() != 0L ){
			tproject = (Tcproject) this.tcprojectService.getTcprojectById( pkId );
		
			listT=tcprojectTeamService.getByProId(pkId);
		 
			tcprojectModel=tcprojectModelService.getByProId(pkId);
			listA= tcprojectAttachmentService.getByProId(pkId);
			Map<String,Object> map1=new HashMap<String,Object>();
    		map1.put("projectId", pkId);
			listH= tcprojectHistoryplanService.getByProId(map1);
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
		request.setAttribute("listT", listT);
		request.setAttribute("tcprojectModel", tcprojectModel);
		request.setAttribute("listA", listA);
		request.setAttribute("listH", listH);
		request.setAttribute("listTM", listTM);
		return getAutoView().addObject( "tcproject", tproject ).addObject( "projectId", pkId );
	}

	@RequestMapping( { "get" } )
	@Action( description = "查看Tproject数据" )
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception{
		long pkId = RequestUtil.getLong( request, "projectId" );
		Tcproject tproject = (Tcproject) this.tcprojectService.getById( Long.valueOf( pkId ) );
		return getAutoView().addObject( "tproject", tproject );
	}
	
	 @RequestMapping({"updates"})
	 @ResponseBody
	 @Action(description="初审项目 审核通过")
	  public Map<String,Object> save(HttpServletRequest request, HttpServletResponse response,String applyIds,String pstatusId,String agOrdisag){
		 SysUser su=ContextUtil.getCurrentUser();
			
		 try {
			 Long[] lAryId = RequestUtil.getLongAryByStr(applyIds);
			 GregorianCalendar gc=new GregorianCalendar(); 
			 for (Long id : lAryId){
			    	
			    	Tcproject t=tcprojectService.getById(id);
			    	t.setPstateId(3+"");//审核通过，进入询价认筹阶段
			    	t.setPchecker(su.getUserId());//审核人
			    	t.setPcheckTime(new Date());//
			    	t.setPopenDate(new Date());//开标时间
			    	gc.setTime(t.getPopenDate());
			    	if(t.getPopenDays()!=0){
			    		
			    		gc.add(5, t.getPopenDays());
			    		t.setPcloseDate(gc.getTime());//接收时间
			    	}
			    	
			    	
			    	tcprojectService.update(t);
			    }
		
		    Map<String,Object> map=new HashMap<String,Object>();  
		 map.put("msg", "数据操作成功!");
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
			 
			 Long[] lAryId = RequestUtil.getLongAryByStr(projectId);
			 for (Long id : lAryId){
			    	Tcproject t=tcprojectService.getById(id);
			    		t.setPstateId(2+"");;//初审中
			    		t.setPcheckRemark(pcheckRemark);//不通过原因
			    		if(t.getPcheckTimes()==1){//超过2次直接流标
			    			t.setPcheckTimes(t.getPcheckTimes()+1);//审核次数+1
			    			t.setPbreakRemark("项目超过2次修改次数");//流标原因
			    			t.setPisBreak(1);
			    		}else{
			    			
			    			t.setPcheckTimes(t.getPcheckTimes()+1);//审核次数+1
			    		}
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
