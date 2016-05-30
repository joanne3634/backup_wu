package com.deelon.loan.controller.sysManager;

import java.io.PrintWriter;
import java.math.BigDecimal;
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

import com.deelon.core.annotion.Action;
import com.deelon.core.annotion.ActionExecOrder;
import com.deelon.core.util.BeanUtils;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.ExceptionUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.model.front.TProjectInvest;
import com.deelon.loan.service.front.TprojectInvestService;
import com.deelon.loan.service.sysManager.TprojectService;
import com.deelon.loan.service.sysManager.TuserFundsService;
import com.deelon.platform.model.system.SysAuditModelType;
@Controller
@RequestMapping({"/loan/sysManager/invitationOftenderLoan/"})
@Action(ownermodel=SysAuditModelType.INVITATIONOFTENDERLOAN)
public class InvitationOftenderLoanFormController extends BaseFormController {
	@Resource
	private TprojectService tprojectService;
	@Resource
	private TuserFundsService TuserFundsService;
	
	@Resource
	private TprojectInvestService tprojectInvestService;
	
	@RequestMapping({"save"})
	@Action(description="流标保存", execOrder=ActionExecOrder.BEFORE,detail="流标保存")
	  public void save(HttpServletRequest request, HttpServletResponse response,String pbreakRemark,String projectId)
	    throws Exception {
		 ResultMessage message = new ResultMessage(1, "操作成功！");
		 PrintWriter writer = response.getWriter();
		 try {
			 
			 Long[] lAryId = RequestUtil.getLongAryByStr(projectId);
		    delByIds(lAryId,pbreakRemark);
		 
		} catch (Exception e) {
			 String msg = ExceptionUtil.getExceptionMessage(e);
		        message = new ResultMessage(0, msg);
		       e.printStackTrace();
		}
		 writer.print(message);
	  }
	 
	 private void delByIds(Long[] lAryId,String pbreakRemark ){
		 try {
			    if (BeanUtils.isEmpty(lAryId)) {
			      return;
			    }
			    for (Long id : lAryId){
			    	TProject t=tprojectService.getTProjectById(id);
			    		t.setPstatusId("8");//招标阶段未满标
			    		t.setPbreakRemark(pbreakRemark);
			    		t.setPbreakTimes(t.getPbreakTimes()+1);
			    		t.setPisBreak((short)1);//流标
			    		t.setUpdatetime(new Date());
			    		t.setPisFull((short)0);
			    		tprojectService.update(t);
			    		//解冻资金
			    		//查询出同一个项目的所有投资
						List<TProjectInvest> list=tprojectInvestService.getTprojectInvestByProId(id,null);
						if(list!=null&&list.size()>0){
							for (TProjectInvest tpi : list) {
								//修改 t_user_funds 中的冻结金额 和余额
								TuserFundsService.userFundsChangeFunction(null, null, tpi.getPiInvestors(), tpi.getPiEffectAmount(), null, "",null,"");//解冻资金
								//将投资记录表中的 投资额，实际投资额清空,取消投标 设为1
								tpi.setPiAmount(new BigDecimal(0));
								tpi.setPiEffectAmount(new BigDecimal(0));
								tpi.setPiIsCancel(1);//取消投标
								tprojectInvestService.update(tpi);
								
							}
						}
							
			    }
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	 }
}
