package com.deelon.crowdfunding.controller.backstage;

import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
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
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.ExceptionUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.model.backstage.Tcproject;
import com.deelon.crowdfunding.model.backstage.TcprojectInvest;
import com.deelon.crowdfunding.service.backstage.TcprojectInvestService;
import com.deelon.crowdfunding.service.backstage.TcprojectService;
import com.deelon.loan.model.front.TMoneymove;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.model.sysManager.Tsmsinformation;
import com.deelon.loan.service.front.TmoneymoveService;
import com.deelon.loan.service.front.TuserSafeService;
import com.deelon.loan.service.sysManager.TsmsinformationService;
import com.deelon.loan.service.sysManager.TuserFundsService;
import com.deelon.payform.common.moneymoremore.RongpayConfig;
import com.deelon.payform.common.moneymoremore.RongpayFunction;
import com.deelon.platform.model.system.SysUser;

/**
 * 满标审核controller
 * @author pyg
 *
 */
@Controller
@RequestMapping( { "/crowdfunding/backstage/fullTenderAudit/" } )
public class FullTenderAuditController extends BaseController {
	@Resource
	private TcprojectService tcprojectService;
	@Resource
	private TcprojectInvestService tcprojectInvestService;
	@Resource
	private TuserFundsService tuserFundsService;
	@Resource
	private TmoneymoveService tmoneymoveService;
	@Resource
	private TsmsinformationService tsmsinformationService;
	
	
	
	@RequestMapping( { "list" } )
	@Action( description = "查看满标分页列表" )
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception{ 
		//查找系统设置的 招标比例（比如达到预期的80%就可以满标）
		 String recruitment=(String)AppUtil.getServletContext().getAttribute("INVITE_TENDER_PERCENT");
		if(StringUtil.isEmpty(recruitment)){
			recruitment="80";
		}
		QueryFilter queryFilter=new QueryFilter(request, "projectId");
		Map<String,Object> map=queryFilter.getFilters();
		queryFilter.addFilter("pcomplete", recruitment);
		
		List<Tcproject> list = tcprojectService.getFullTenderForPro(queryFilter);
		
		ModelAndView mv = getAutoView().addObject("tprojectList", list );
		request.setAttribute("pstatus", map.get("pstatus"));
		return mv;
	}
	
	@RequestMapping( { "invest" } )
	@Action( description = "查看项目的跟投人" )
	public ModelAndView invest( HttpServletRequest request, HttpServletResponse response ) throws Exception{ 
		String projectId=request.getParameter("projectId");
		QueryFilter queryFilter=new QueryFilter(request, "projectId");
		queryFilter.addFilter("projectId", projectId);
//	queryFilter.addFilter("piisCheck", "1");//已经通过创业者同意的投资人
		queryFilter.addFilter("piisCheck2", "0,1");//已经通过创业者同意的投资人
		
		queryFilter.addFilter("piisCancel", "0");//没有取消跟投的
		
		List<TcprojectInvest> list = tcprojectInvestService.getInvestforPro(queryFilter);
		
		ModelAndView mv = getAutoView().addObject("tprojectList", list );
		return mv;
	}
	
	
	
	@RequestMapping( { "edit" } )
	@Action( description = "编辑Tproject数据"  )
	public ModelAndView edit( HttpServletRequest request ) throws Exception{
		return getAutoView();
	}
	
	@RequestMapping({"updates"})
	 @ResponseBody
	 @Action(description="满标审核")
	  public Map<String,Object> save(HttpServletRequest request, HttpServletResponse response,String applyIds,String pstatusId,String agOrdisag){
		 SysUser su=ContextUtil.getCurrentUser();
			
		 try {
			 Long[] lAryId = RequestUtil.getLongAryByStr(applyIds);
			 for (Long id : lAryId){
			    	
			    	Tcproject t=tcprojectService.getById(id);
			    	t.setPstateId(4+"");//满标状态
			    	t.setPchecker(su.getUserId());//审核人
			    	t.setPcheckTime(new Date());//
			    	t.setPisFull(1);//满标
			    	t.setPfullTime(new Date());//满标时间
			    	
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
	
	@Action(description="编辑页面")
	@RequestMapping({"get"})
	  public ModelAndView get(HttpServletRequest request, HttpServletResponse response)
	    throws Exception
	  {
	    String projectId=request.getParameter("projectId");
	    Tcproject p=tcprojectService.getById(Long.valueOf(projectId));
	    
	  //查询出同一个项目的所有已经付过款的投资
	    
	    QueryFilter queryFilter=new QueryFilter(request, "projectId");
		queryFilter.addFilter("projectId", projectId);
//	queryFilter.addFilter("piisCheck", "1");//已经通过创业者同意的投资人
		queryFilter.addFilter("ispay", 1);//已经付过款的
		
		queryFilter.addFilter("piisCancel", "0");//没有取消跟投的
	    
	    
	  		/*Map<String,Object> map=new HashMap<String,Object>();
	  		map.put("projectId", projectId);
	  	//	invest.put("userId", userId);
	  		map.put("ispay",1);//查询已付款了的
	  		map.put("piisCancel", 0);*/
	  		List<TcprojectInvest> list=tcprojectInvestService.getInvestforPro(queryFilter);
	    
	    return getAutoView().addObject("Tcproject", p).addObject("ListSize", list.size()).addObject("tprojectList", list);
	  }
	
	@Action(description="保存修改说明并")
	@RequestMapping({"saveBreakRemark_"})
	  public ModelAndView saveBreakRemark_(HttpServletRequest request, HttpServletResponse response,String pbreakRemark,String projectId)
	    throws Exception
	  {
	  
		SysUser sysUser = ContextUtil.getCurrentUser();// 当前系统后台审核放款用户
		
	    Tcproject t=tcprojectService.getById(Long.valueOf(projectId));
	    String pbreakRemark1 = java.net.URLDecoder.decode(request.getParameter("pbreakRemark"),"UTF-8");
	    t.setPbreakRemark(pbreakRemark1);
	//	tcprojectService.update(t);
	   
		//解冻资金
		//查询出同一个项目的所有已经付过款的投资
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("projectId", projectId);
	//	invest.put("userId", userId);
		map.put("ispay",1);//已经付过款的
		map.put("piisCancel", 0);
		List<TcprojectInvest> list=tcprojectInvestService.getInvestforPro(map,null);
		
		String resultStr= tcprojectService.flowRefundAction(t,list,sysUser);
		if(StringUtil.isEmpty(resultStr)){
			resultStr="<TR><TD height=\"40\" colspan=\"3\" style=\"color: blue;\" align=\"right\">没有在平台找到投资人的支付记录,请联系管理员!</TD></TR>";
		}
		
		
		/*	PayCommon.loanTrans(listM);  
			Map<String,Object> hm=listM.get(1);
			Map<String,Object> hmData=listM.get(0);*/
		
		ModelAndView mv = new ModelAndView("/crowdfunding/backstage/refundBackInfo.jsp").addObject("resultStr", resultStr);
	
		
	    
	    return mv;
	  }
	
	@Action(description="保存修改说明")
	@RequestMapping({"saveBreakRemark_Bak"})
	 public void saveBreakRemark_Bak(HttpServletRequest request, HttpServletResponse response,String pbreakRemark,String projectId)
			    throws Exception {
		 ResultMessage message = new ResultMessage(1, "操作成功！");
		 PrintWriter writer = response.getWriter();
		 try {
			 
			 Long[] lAryId = RequestUtil.getLongAryByStr(projectId);
			 for (Long id : lAryId){
			    	Tcproject t=tcprojectService.getById(id);
			    		t.setPstateId("7");//流标
			    		t.setPbreakRemark(pbreakRemark);
			    		t.setPisBreak(1);//流标
			    		t.setPbreakTime(new Date());//流标时间
			    		tcprojectService.update(t);
			    		//解冻资金
			    		//查询出同一个项目的所有投资
			    		Map<String,Object> map=new HashMap<String,Object>();
			    		map.put("projectId", id);
					//	invest.put("userId", userId);
			    		map.put("ispay",0);
			    		map.put("isCancel", 0);
						List<TcprojectInvest> list=tcprojectInvestService.getInvestforPro(map,null);
						if(list!=null&&list.size()>0){
							for (TcprojectInvest tpi : list) {
								//修改 t_user_funds 中的冻结金额 和余额
					//			tuserFundsService.userFundsChangeFunction(null, null, tpi.getUserId(), tpi.getPiinvest(), null, "",null,"");//解冻资金
								//将投资记录表中的 投资额，实际投资额清空,取消投标 设为1
								tpi.setPiinvest(new BigDecimal(0));
								tpi.setPiisCancel(1);//取消投标
								tcprojectInvestService.update(tpi);
								
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
	
	/**
	 * 查看 项目的付款情况
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping({"viewInvestOfPro"})
	@ResponseBody
	public String viewInvestOfPro(HttpServletRequest request, HttpServletResponse response,String projectId){
		
		//查询出同一个项目的所有已经付过款的投资
				Map<String,Object> map=new HashMap<String,Object>();
				map.put("projectId", projectId);
			//	invest.put("userId", userId);
				map.put("ispay",0);//还没有付过款的
				map.put("piisCancel", 0);
				map.put("piisCheck2", "0,1");
				
				List<TcprojectInvest> list=tcprojectInvestService.getInvestforPro(map,null);
				if(list.size()>0){
					return "1";//还有投资人没有打款
				}else{
					return "0";
				}
	}
	/**
	 * 查看 项目的付款情况
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping({"doSendMsg"})
	@ResponseBody
	public String doSendMsg(HttpServletRequest request, HttpServletResponse response,String projectId,String investUser){
		
		
				try {
					SysUser su=ContextUtil.getCurrentUser();
					Tcproject p=tcprojectService.getById(Long.valueOf(projectId));
					//发信息给用户
					TuserSafeService safe=(TuserSafeService)AppUtil.getBean(TuserSafeService.class);
					TUserSafe usafe=safe.queryTUserSafeByuserId(investUser);
					Tsmsinformation s=new Tsmsinformation();
					s.setInfoId(UniqueIdUtil.genId());
					s.setServiceType(2);//系统
					s.setMobileNum(usafe.getMobile());
					s.setMessasge("尊敬的会员你好,您投资的项目【"+p.getPname()+"】,已经进入打款阶段,请您及时打款。");
					s.setCreator(su.getUserId());
					s.setStatus(0);
					s.setCreateTime(new Date());
					tsmsinformationService.add(s);//保存
					return "1";
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				
				
				return null;
	}
	
	
}
