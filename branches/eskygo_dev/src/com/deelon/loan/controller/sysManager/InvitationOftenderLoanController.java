package com.deelon.loan.controller.sysManager;

import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
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
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.BeanUtils;
import com.deelon.core.util.ExceptionUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.model.front.TProjectInvest;
import com.deelon.loan.service.backstage.TSettingsService;
import com.deelon.loan.service.front.TprojectInvestService;
import com.deelon.loan.service.sysManager.TprojectContractService;
import com.deelon.loan.service.sysManager.TprojectService;
import com.deelon.loan.service.sysManager.TuserFundsService;
import com.deelon.platform.model.system.SysAuditModelType;
import com.deelon.platform.util.ParamHelper;
@Controller
@RequestMapping({"/loan/sysManager/invitationOftenderLoan/"})
@Action(ownermodel=SysAuditModelType.INVITATIONOFTENDERLOAN)
public class InvitationOftenderLoanController extends BaseController {
	@Resource
	private TprojectService tprojectService;
	
	@Resource
	private TSettingsService tsettingsService;
	@Resource
	private TprojectContractService tprojectContractService;
	@Resource
	private TprojectInvestService tprojectInvestService;
	@Resource
	private TuserFundsService TuserFundsService;
	
	@Action(description="招标中的借款 ")
	@RequestMapping({"list"})
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response){
		boolean floagDate=false;//确定是否过期
		try {
			String fullLoan=request.getParameter("fullLoan");
			String pcomplete =(String)AppUtil.getServletContext().getAttribute("TENDER_MIN_LIMIT_PROPORTION");
			QueryFilter queryFilter=new QueryFilter(request,"projectId");
			queryFilter.addFilter("fullLoan", fullLoan);
			queryFilter.addFilter("pcomplete", pcomplete);
			
			
			Map<String,Object> map=queryFilter.getFilters();
			String endDate=(String)map.get("endDate");
			if(StringUtil.isNotEmpty(endDate)){
				queryFilter.addFilter("endDate", endDate+" 23:59:59");
			}
			String beginDate=(String)map.get("beginDate");
			if(StringUtil.isNotEmpty(beginDate)){
				queryFilter.addFilter("beginDate", beginDate+" 00:00:00");
			}
			
			List<TProject> list=tprojectService.getInvitationOfTenderInfo(queryFilter);
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
			if(list!=null&&list.size()>0){
				for (TProject t : list) {
					if(t.getPisFull()==0)
						t.setAlinkAction("<a href=\"javascript:void(0)\" class=\"link resetPwd\" onclick=\"inviteDisagere("+t.getProjectId()+","+t.getPcomplete()+");\">流标</a>&nbsp;&nbsp;&nbsp;&nbsp;"
							+"<a href=\"javascript:void(0)\" class=\"link primary\" onclick=\"agreeApply("+t.getProjectId()+",'agree',"+t.getPcomplete()+");\">满标</a>");
					else
						t.setAlinkAction("已审核");
					if(t.getPopenDate()!=null&&t.getPcloseDate()!=null){
						int times=(int)(t.getPcloseDate().getTime()-System.currentTimeMillis());
						t.setTimeRemaining(getTime(times));
						/*Long d=(t.getPcloseDate().getTime()-new Date().getTime())/(24*60*60*1000);
						Long h=(t.getPcloseDate().getTime()-new Date().getTime())/(60*60*1000);
						Long m=(t.getPcloseDate().getTime()-new Date().getTime())/(60*1000);
						if(d==0){//说明不足一天
							if(h==0){//说明不足一小时
								t.setTimeRemaining(m+"分钟");
							}else if(h<0){
								t.setTimeRemaining("已过期");
								floagDate=true;
							}else{
								t.setTimeRemaining(h+"小时"+m+"分钟");
							}
						}else if(d<0){
							t.setTimeRemaining("已过期");
							floagDate=true;
						}else{
							t.setTimeRemaining(d+"天"+h+"小时"+m+"分钟");
						}*/
					}
					if(t.getPopenDate()!=null){
						
						t.setPopenDateStr(sdf.format(t.getPopenDate()));
					}
					if(t.getPcloseDate()!=null){
						t.setPcloaseDateStr(sdf.format(t.getPcloseDate()));
					}
					t.setpComplateStr(t.getPcomplete()+"%");
					/*
					 * 当招标的时间已经用完时
					 * 如果招标金额达到预期的百分比例 则自动满标
					 * 如果招标金额没有达到预期的百分比例则自动流标
					 * 百分比例从 tsetting表中取 
					 */
					
					/*if(floagDate){
						if(t.getPcomplete()!=null){
							TSettings ts=tsettingsService.getTSettingsBySetCode(TSettingParem.InviteTender.inviteTenderPerCent);
							//贷款招标比例
							Integer m=0;
							if(ts!=null){
								if(StringUtil.isNotEmpty(ts.getSetValue())){
									Double d=Double.parseDouble(ts.getSetValue())*100;
									m=d.intValue();
									
								}
							}
							if(m!=0){
								
								if(t.getPcomplete()>=m){//自动满标
									TProject tp=tprojectService.getTProjectById(t.getProjectId());
							    	tp.setPstatusId("4");//招标
							    	tp.setPbreakRemark("在时间内,已经达到预期的借款比例!");
							    	Short ifu=1;
							    	tp.setPisFull(ifu);//满标
							    	tprojectService.update(tp);
								}else{//自动流标
									TProject tp=tprojectService.getTProjectById(t.getProjectId());
							    	tp.setPstatusId("8");//招标
							    	tp.setPbreakRemark("在时间内,未达到预期的借款比例!");
							    	Short ifu=0;
							    	tp.setPisFull(ifu);//未满标
							    	tp.setPbreakTimes(tp.getPbreakTimes()+1);//流标次数加1
							    	tprojectService.update(tp);
								}
							}
						}
					}*/
					
					
				}
			}
			return  getAutoView().addObject("ListVo", list).addObject("fullLoan", fullLoan);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	@Action(description="编辑页面")
	@RequestMapping({"edit"})
	  public ModelAndView edit(HttpServletRequest request, HttpServletResponse response)
	    throws Exception
	  {
	    String projectId=request.getParameter("projectId");
	    String fullLoan=request.getParameter("fullLoan");
	    TProject p=tprojectService.getById(Long.valueOf(projectId));
	    return getAutoView().addObject("TProject", p).addObject("fullLoan", fullLoan);
	  }
	
	@Action(description="保存修改说明")
	@RequestMapping({"saveBreakRemark_"})
	 public void saveBreakRemark_(HttpServletRequest request, HttpServletResponse response,String pbreakRemark,String projectId)
			    throws Exception {
		 ResultMessage message = new ResultMessage(1, "操作成功！");
		 PrintWriter writer = response.getWriter();
		 try {
			 
			 Long[] lAryId = RequestUtil.getLongAryByStr(projectId);
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
			 String msg = ExceptionUtil.getExceptionMessage(e);
		        message = new ResultMessage(0, msg);
		       e.printStackTrace();
		}
		 writer.print(message);
	 }
	
	@Action(description="满标/批量操作", execOrder=ActionExecOrder.BEFORE,detail="满标/批量操作")
	@RequestMapping({"updateProject"})
	@ResponseBody  
	public Map<String,String> updateProject(HttpServletRequest request,HttpServletResponse response,String arrayIds,String agOrdisag){
		try {
			Long[] lAryId = RequestUtil.getLongAryByStr(arrayIds);
			 
			 if(StringUtil.isNotEmpty(agOrdisag)){
				 if(agOrdisag.equals("agree")){//满标
					 
//					 delByIds(lAryId,(short)1);
					 /* if (BeanUtils.isEmpty(lAryId)) {
					      return;
					    }*/
					    for (Long id : lAryId){
					    	
					    	TProject t=tprojectService.getTProjectById(id);
					    	
					    		t.setPisFull((short)1);//满标或为满标
					    		t.setPstatusId("5");//满标
					    		t.setPcloseDate(new Date());
					    		t.setUpdatetime(new Date());
					    	
					    	
					    	
					    	
					    	//发起合同签订
					    /*	TProjectContract pc=new TProjectContract();
					    	pc.setProjectId(id);
					    	
					    	tprojectContractService.add(pc);*/
					    	//借款成立
					    	t.setPisSetup((short)1);
					    	tprojectService.update(t);
					    }
				 }/*else{//流标
					 delByIds(lAryId,breakRemark,(short)0);
				 }*/
			 }
			  Map<String,String> map=new HashMap<String,String>();  
				 map.put("msg", "数据操作成功!");
				 return map;
		} catch (Exception e) {
			 e.printStackTrace();
		}
		return null;
		 
	}
	
	 private void delByIds(Long[] lAryId,short isfull){
		 try {
//			 Long user_id=ContextUtil.getCurrentUser().getUserId();
			    if (BeanUtils.isEmpty(lAryId)) {
			      return;
			    }
			    for (Long id : lAryId){
			    	
			    	TProject t=tprojectService.getTProjectById(id);
			    	
			    	t.setPisFull(isfull);//满标或为满标
			    //	if(isfull==1){//满标
			    		t.setPstatusId("5");//满标
			    		t.setPcloseDate(new Date());
			    		t.setUpdatetime(new Date());
			    	//}
			    	/*else if(isfull==0){//未满标
			    		t.setPstatusId("8");//招标阶段未满标
			    		t.setPbreakRemark(breakRemark);
			    		t.setPbreakTimes(t.getPbreakTimes()+1);
			    	}*/
			    	
			    	tprojectService.update(t);
			    	
			    	
			    }
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	 }
	 
	 public String getTime(int time){

		 int theDay,theHour,theMinutes;
		 theDay = 24*60*60*1000;//一天
		 theHour = 60*60*1000; //一小时
		 theMinutes = 60*1000; //一分钟

		 int nowTime = 0; //当前的总秒数

		 //现在的天数，小时，分，秒
		 int nowDay = 0, nowHour = 0, nowMinutes = 0, nowSenconds = 0;
		 StringBuffer sb = new StringBuffer();

		 if (time-theDay>=0)//显示：天，小时
		 {
		 nowDay = time/theDay;
		 nowTime = time%theDay;

		 if(nowTime-theHour>=0)
		 nowHour = nowTime/theHour;
		 else
		 theHour =0;

		 sb.append(nowDay + "天");
		 sb.append(nowHour + "小时");
		 }

		 else if(time-theHour>=0){//显示：小时，分钟
		 nowHour = time/theHour;
		 nowTime = time%theHour;
		 if(nowTime - theMinutes>=0)
		 nowMinutes = nowTime/theMinutes;
		 else
		 nowMinutes = 0;
		 sb.append(nowHour + "小时");
		 sb.append(nowMinutes + "分钟");

		 }
		 else if(time-theHour< 0 && time - theMinutes>=0){//显示：分钟
		 nowMinutes = time/theMinutes;
		 sb.append("0小时"+ nowMinutes + "分");
		 }
		 else{
		nowSenconds = time;

		// sb.append("0分" + nowSenconds*1000 + "秒");
			sb.append("超过限定时间");
		 }


		 return sb.toString();
	}
	
}
