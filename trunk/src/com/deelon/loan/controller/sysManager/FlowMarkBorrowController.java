package com.deelon.loan.controller.sysManager;

import java.math.BigDecimal;
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
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.model.front.TProjectInvest;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.service.front.TprojectInvestService;
import com.deelon.loan.service.sysManager.TprojectService;
import com.deelon.loan.service.sysManager.TuserFundsService;
import com.deelon.platform.model.system.SysAuditModelType;
@Controller
@RequestMapping({"/loan/sysManager/flowMarkBorrow/"})
@Action(ownermodel=SysAuditModelType.FLOWMARKBORROW)
public class FlowMarkBorrowController extends BaseController {

	@Resource
	private TprojectService tprojectService;
	@Resource
	private TuserFundsService TuserFundsService;
	
	@Resource
	private TprojectInvestService tprojectInvestService;
	
	@RequestMapping({"list"})
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response){
		String applyName=request.getParameter("applyName");
		String pname=request.getParameter("pname");
		String queryNum=request.getParameter("queryNum");
		try {
			QueryFilter queryFileter=new QueryFilter(request,"projectId");
			queryFileter.addFilter("applyName", applyName);
			queryFileter.addFilter("pname", pname);
			queryFileter.addFilter("queryNum", queryNum);
			
			 Map<String,Object> map=queryFileter.getFilters();
				String endDate=(String)map.get("endDate");
				if(StringUtil.isNotEmpty(endDate)){
					queryFileter.addFilter("endDate", endDate+" 23:59:59");
				}
				String beginDate=(String)map.get("beginDate");
				if(StringUtil.isNotEmpty(beginDate)){
					queryFileter.addFilter("beginDate", beginDate+" 00:00:00");
				}
			
			
			List<TProject> listVo=	tprojectService.getBreakedList(queryFileter);
			return getAutoView().addObject("ListVo", listVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	@RequestMapping({"blockingFundsofUser"})
	@ResponseBody
	@Action(description="解放资金", execOrder=ActionExecOrder.BEFORE, detail="解放资金")
	public Map<String,String> blockingFundsofUser(HttpServletRequest request,HttpServletResponse response,String arrayIds ){
		 Map<String,String> map=new HashMap<String,String>();
		try {
			Long[] larryIds=RequestUtil.getLongAryByStr(arrayIds);
			 for(long id:larryIds){
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
						map.put("msg", "操作成功!");
					}else{
						map.put("msg", "操作异常!");
					}
					
			 }
			
				
				return map;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	
		return null;
	}
	
	
	@RequestMapping({"queryBreakList"})
	public ModelAndView queryBreakList(HttpServletRequest request,HttpServletResponse response){
		
		String queryNum=request.getParameter("queryNum");
		try {
			QueryFilter queryFileter=new QueryFilter(request,"projectId");
			queryFileter.addFilter("queryNum", queryNum);
			
			List<TProject> listVo=	tprojectService.getBreakedList(queryFileter);
			return new ModelAndView("/loan/sysManager/flowMarkBorrowList.jsp").addObject("ListVo", listVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
