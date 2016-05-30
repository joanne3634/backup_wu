package com.deelon.loan.controller.sysManager;

import java.util.Date;
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
import com.deelon.core.annotion.ActionExecOrder;
import com.deelon.core.util.BeanUtils;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TLimitsApply;
import com.deelon.loan.service.sysManager.TlimitsApplyService;
import com.deelon.platform.model.system.SysAuditModelType;
@Controller
@RequestMapping({"/loan/sysManager/limitsApplyManage/"})
@Action(ownermodel=SysAuditModelType.LIMITS_APPLY_MANAGEMENT)
public class LimitsApplyManageListController extends BaseController {

	@Resource
	private TlimitsApplyService tlimitsApplyService;
	
	@Action(description="额度申请管理页面")
	@RequestMapping({"list"})
	  public ModelAndView list(HttpServletRequest request, HttpServletResponse response)
	    throws Exception
	  {
	    Long applyId = Long.valueOf(RequestUtil.getLong(request, "applyId"));
	    List<TLimitsApply> list = tlimitsApplyService.getAllTLimitsApply(new QueryFilter(request, "applyId"));
	    ModelAndView mv = getAutoView().addObject("ListVo", list);//.addObject("userId", homePageId);
	    
	    return mv;
	  }
	
	
	@RequestMapping({"edit"})
	  public ModelAndView edit(HttpServletRequest request, HttpServletResponse response)
	    throws Exception
	  {
	    String applyId=request.getParameter("applyId");
	    return getAutoView().addObject("ApplyIds", applyId);
	  }
	
	
	 @RequestMapping({"updates"})
	 @ResponseBody
	 @Action(description="额度审核", execOrder=ActionExecOrder.BEFORE, detail="额度审核")
	  public Map<String,Object> save(HttpServletRequest request, HttpServletResponse response,String applyIds,String agOrdisag)
	    throws Exception {
		 try {
			 Long[] lAryId = RequestUtil.getLongAryByStr(applyIds);
			 String audit_desc = request.getParameter("audit_desc");
			 if(StringUtil.isEmpty(audit_desc)){
				 audit_desc ="";
			 }
			 if(StringUtil.isNotEmpty(agOrdisag)){
				 if(agOrdisag.equals("agree")){//同意请求
					 
					 delByIds(lAryId,"1",audit_desc);
				 }else if(agOrdisag.equals("disagree")){//不同意
					 delByIds(lAryId,"2",audit_desc);
				 }
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
	 
	 private void delByIds(Long[] lAryId,String audit_status,String audit_desc){
		 try {
			 Long user_id=ContextUtil.getCurrentUser().getUserId();
			    if (BeanUtils.isEmpty(lAryId)) {
			      return;
			    }
			    for (Long id : lAryId){
			    	
			    	TLimitsApply t=tlimitsApplyService.getTLimitsApplyById(id);
			    	t.setAudit_status(audit_status);
			    	t.setAudit_desc(audit_desc);
			    	t.setChecker(user_id);
			    	t.setCheckTime(new Date());
			    	tlimitsApplyService.updateTLimitsApplyByPk(t);
			    }
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	 }

}
