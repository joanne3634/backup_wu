package com.deelon.crowdfunding.controller.backstage;

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
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.DateUtil;
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
import com.deelon.loan.dao.front.TmoneymoveDao;
import com.deelon.loan.model.front.TMoneymove;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.model.sysManager.Tsmsinformation;
import com.deelon.loan.service.front.TmoneymoveService;
import com.deelon.loan.service.front.TuserSafeService;
import com.deelon.loan.service.sysManager.SmsSendService;
import com.deelon.loan.service.sysManager.TsmsinformationService;
import com.deelon.loan.service.sysManager.TuserFundsService;
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
	@Resource
    private SmsSendService smsSendService;
	@ Resource
	private TmoneymoveDao tmoneymoveDao;
	
	
	
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
	
	@Action(description="流标")
	@RequestMapping({"saveBreakRemark_Bak"})
	 public void saveBreakRemark_Bak(HttpServletRequest request, HttpServletResponse response,String pbreakRemark,String projectId)
			    throws Exception {
		 ResultMessage message = new ResultMessage(1, "操作成功！");
		 PrintWriter writer = response.getWriter();
		try {
			Long[] lAryId = RequestUtil.getLongAryByStr(projectId);
			for (Long id : lAryId) {
				Tcproject t = tcprojectService.getById(id);
				t.setPstateId("7");// 流标
				t.setPbreakRemark(pbreakRemark);
				t.setPisBreak(1);// 流标
				t.setPbreakTime(new Date());// 流标时间
				tcprojectService.update(t);
				Map<String, Object> map1 = new HashMap<String, Object>();
				map1.put("projectId", id);
				map1.put("isCancel", 0);// 所有认投记录，包括已付款及未付款
				List<TcprojectInvest> list = tcprojectInvestService.getInvestforPro(map1, null);

				if (list != null && list.size() > 0) {
					for (TcprojectInvest tpi : list) {
						if (tpi.getPiisPay() == 0) {// 如果未付款，清空额度
							tpi.setPiinvest(new BigDecimal(0));
						} else if (tpi.getPiisPay() == 1) {
							tpi.setPiisPay(2);// 如果是已付款，付款状态设置为已退款
						}
						tpi.setPiisCancel(2);//
						tcprojectInvestService.update(tpi);
					}
				}
				// 查询所有的资金记录
				// 修改资金记录为已退款
				Map<String, Object> map2 = new HashMap<String, Object>();
				map2.put("projectId", id);
				map2.put("resultId", 1);// 支付成功的记录
				List<TMoneymove> lt = tmoneymoveDao.getListByMap(map2);
				for (TMoneymove tm : lt) {
					tm.setResultId("3");// 支付状态为已退款
					tm.setCheckTime(new Date());// 退款时间
					tm.setRemark("退款成功");
					tmoneymoveDao.update(tm);
				}
			}
		} catch (Exception e) {
			String msg = ExceptionUtil.getExceptionMessage(e);
			message = new ResultMessage(0, msg);
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
	 * 短信通知投资人打款
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
					String mobile = usafe.getMobile();
					String content = "尊敬的会员你好,您投资的项目【"+p.getPname()+"】,已经进入打款阶段,请您及时打款。【无忧筹】";
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
					String[] str = smsSendService.getSendSmsInfoResult(mobile, content, sdf.format(new Date()), "P");
					
					// 保存发送短信记录开始
					Tsmsinformation tsmsinformation = new Tsmsinformation();
					tsmsinformation.setInfoId(UniqueIdUtil.genId());// 消息ID
					tsmsinformation.setServiceType(1); // 通知类型（1=网站、2=系统、3=APP）
					tsmsinformation.setMobileNum(mobile);// 手机号码
					tsmsinformation.setMessasge(content);// 短信内容
					tsmsinformation.setCreator(su.getUserId());// 创建人ID
					tsmsinformation.setCreateTime(new Date());// 创建时间
					String returnValue = "";
					if ("0".equals(str[0])) {
						tsmsinformation.setStatus(2);// 成功状态
						returnValue = "1";
					} else {
						tsmsinformation.setStatus(3);// 失败状态
						returnValue = "0";
					}
					tsmsinformation.setSendTime(new Date());// 发送时间
					tsmsinformationService.add(tsmsinformation);
					return returnValue;
				} catch (Exception e) {
					logger.error("save msg exception", e);
				}
				return null;
	}
}
