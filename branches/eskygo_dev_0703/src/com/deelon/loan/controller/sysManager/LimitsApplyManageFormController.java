package com.deelon.loan.controller.sysManager;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.BeanUtils;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TLimitsApply;
import com.deelon.loan.service.sysManager.TlimitsApplyService;

@Controller
@RequestMapping({"/loan/sysManager/limitsApplyManage/"})
public class LimitsApplyManageFormController extends BaseFormController {
	
	@Resource
	private TlimitsApplyService tlimitsApplyService;
	
	@Action(description="额度申请管理保存")
	 @RequestMapping({"save"})
	 @ResponseBody
	  public Map<String,Object> save(HttpServletRequest request, HttpServletResponse response,String audit_status, String audit_desc,String applyIds)
	    throws Exception {
		 try {
			 
			 Long[] lAryId = RequestUtil.getLongAryByStr(applyIds);
		    delByIds(lAryId,audit_status,audit_desc);
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
