package com.deelon.crowdfunding.controller.backstage;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.ExceptionUtil;
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
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.model.sysManager.Tsmsinformation;
import com.deelon.loan.service.front.TmoneymoveService;
import com.deelon.loan.service.front.TuserSafeService;
import com.deelon.loan.service.sysManager.TsmsinformationService;
import com.deelon.loan.service.sysManager.TuserFundsService;
import com.deelon.payform.common.PayCommon;
import com.deelon.payform.common.moneymoremore.PayCommonMoney;
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
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 过期项目controller
 * @author pyg
 *
 */
@Controller
@RequestMapping( { "/crowdfunding/backstage/expiredProject/" } )
public class ExpiredProjectController extends BaseController {
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
	@Action( description = "查看过期项目分页列表" )
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception{ 
		
		QueryFilter queryFilter=new QueryFilter(request, "projectId");
		Map<String,Object> map=queryFilter.getFilters();
		List<Tcproject> list = tcprojectService.getExpiredForPro(queryFilter);
		if(list!=null&&list.size()>0){
			SimpleDateFormat sdf=new SimpleDateFormat("yyy-MM-dd HH:mm");
			for (Tcproject t : list) {
					t.setLinkedAction("<a href=\"javascript:void(0)\" class=\"link primary\" onclick=\"agreeApply("+t.getProjectId()+",'agree');\">满标</a>&nbsp;&nbsp;&nbsp;&nbsp;"+
							"<a href=\"get.ht?projectId="+t.getProjectId()+"\" class=\"link resetPwd\" >流标</a>&nbsp;&nbsp;&nbsp;&nbsp;"+
							"<a href=\""+request.getContextPath()+"/crowdfunding/backstage/expiredProject/extension.ht?projectId="+t.getProjectId()+"\" class=\"link primary\" >延期</a>");
				if(t.getPopenDate()!=null){
					
					t.setPopenDateStr(sdf.format(t.getPopenDate()));
				}
				if(t.getPcloseDate()!=null){
					
					t.setPcloseDateStr(sdf.format(t.getPcloseDate()));
				}
				if(t.getCreateTime()!=null){
					t.setCreateTimestr(sdf.format(t.getCreateTime()));
				}
				t.setPcompleateStr(t.getPcomplete()+"%");
			}
		}
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
	 @Action(description="过期项目")
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
	  		Map<String,Object> map=new HashMap<String,Object>();
	  		map.put("projectId", projectId);
	  	//	invest.put("userId", userId);
	  		map.put("ispay",1);//查询已付款了的
	  		map.put("piisCancel", 0);
	  		List<TcprojectInvest> list=tcprojectInvestService.getInvestforPro(map,null);
	    
	    return getAutoView().addObject("Tcproject", p).addObject("ListSize", list.size());
	  }
	
	@Action(description="保存修改说明并")
	@RequestMapping({"saveBreakRemark_"})
	  public ModelAndView saveBreakRemark_(HttpServletRequest request, HttpServletResponse response,String pbreakRemark,String projectId)
	    throws Exception
	  {
	  
	    
	    Tcproject t=tcprojectService.getById(Long.valueOf(projectId));
	    String pbreakRemark1 = java.net.URLDecoder.decode(request.getParameter("pbreakRemark"),"UTF-8");
	    t.setPbreakRemark(pbreakRemark1);
		tcprojectService.update(t);
		//解冻资金
		//查询出同一个项目的所有已经付过款的投资
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("projectId", projectId);
	//	invest.put("userId", userId);
		map.put("ispay",1);//已经付过款的
		map.put("piisCancel", 0);
		List<TcprojectInvest> list=tcprojectInvestService.getInvestforPro(map,null);
		
		List<Map<String,Object>> listM=new ArrayList<Map<String,Object>>();
		if(list!=null&&list.size()>0){
			for (TcprojectInvest tpi : list) {
			
				
				String flowCode=String.valueOf(UniqueIdUtil.genId());
				TUserFunds uaco=tuserFundsService.getTUserFundsByUserId(tpi.getUserId());//借款人账户
				HashMap<String,Object> hm=new HashMap<String,Object>();
				hm.put("LoanOutMoneymoremore", PayCommonMoney.payformNo);//付款账户,平台账户
				hm.put("LoanInMoneymoremore",uaco.getPayMark());//收款账户
				hm.put("OrderNo", flowCode);//订单号
				hm.put("BatchNo", flowCode);//批次号
				hm.put("Amount",tpi.getPiinvest().toString());//
				hm.put("TransferName", "项目流标,资金退回");//
				listM.add(hm);
				
				//要先判断 同一个项目下 投资人是不是已经 插入过记录
				
				Map<String,Object> map1=new HashMap<String,Object>();
				map1.put("projectId",tpi.getProjectId());
				map1.put("typeId", "9");
				map1.put("userId", tpi.getUserId());
				map1.put("remark","满标审核,流标操作 资金归还给投资者失败");
				map1.put("resultId","2");
				map1.put("flowCode", flowCode);
				 List<TMoneymove> listMove=tmoneymoveService.getListByMap(map1);
				if(listMove.size()==0||listMove==null){
					TMoneymove m=new TMoneymove();	
					m.setMoneyMoveId(UniqueIdUtil.genId());
					m.setUserId(tpi.getUserId());
					m.setProjectId(t.getProjectId());
					m.setTypeId("9");//融资流标
					m.setMoneyInOut(tpi.getPiinvest());
					m.setGetFee(new BigDecimal(0));//手续费
					m.setMoneyCurrent(uaco.getBalance());//成功后再加上 返回的资金
					m.setAudit(0);
					m.setResultId("2");
					m.setRemark("满标审核,流标操作 资金归还给投资者失败");
					m.setSerialNo("");	
					m.setChecker(0);
					m.setCreateTime(new Timestamp(System.currentTimeMillis()));
					m.setFlowCode(flowCode);
					m.setIsOffLine(0);
					tmoneymoveService.add(m);
				}
				
			}
			
		}
			PayCommon.loanTrans(listM);  
			Map<String,Object> hm=listM.get(1);
			Map<String,Object> hmData=listM.get(0);
		
		
		ModelAndView mv = new ModelAndView("/crowdfunding/onlinePayment/payAskPriceMoneys.jsp").addObject("hm", hm)
				.addObject("hmData",hmData);
	
		
	    
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
	
	@Action(description="项目延期")
	@RequestMapping({"extension"})
	  public ModelAndView extension(HttpServletRequest request, HttpServletResponse response)
	    throws Exception
	  {
		String projectId = request.getParameter("projectId");
		Tcproject tc = tcprojectService.getById(Long.valueOf(projectId));
	    return new ModelAndView("/crowdfunding/backstage/expiredProjectEdit.jsp").
	    		addObject("projectName", tc.getPname()).addObject("pfinancingDays",tc.getPopenDays()).addObject("projectId", projectId);
	  }
	
	
	@Action(description="保存修改说明")
	@RequestMapping({"updateExtension"})
	 public void updateExtension(HttpServletRequest request, HttpServletResponse response,String pbreakRemark,String projectId)
			    throws Exception {
		 ResultMessage message = new ResultMessage(1, "操作成功！");
		 String extensionDays = request.getParameter("extensionDays");
		 PrintWriter writer = response.getWriter();
		 try {
			 Tcproject tc = tcprojectService.getById(Long.valueOf(projectId));
			 tc.setPopenDays(tc.getPopenDays()+Integer.valueOf(extensionDays));//设置项目延期的新时间
			 Calendar calv = Calendar.getInstance();
			 Date date =tc.getPcloseDate();//获得关闭的日期
			 calv.setTime(date); 
			 calv.add(Calendar.DATE,Integer.valueOf(extensionDays));
			 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			 String dateNew = sdf.format(calv.getTime());
			 tc.setPcloseDate(sdf.parse(dateNew));//设置项目关闭的时间
			 tc.setPbreakRemark(pbreakRemark);//更新项目的备注
			 tc.setPstateId("3");
			 tcprojectService.update(tc);
		 
		} catch (Exception e) {
			 String msg = ExceptionUtil.getExceptionMessage(e);
		        message = new ResultMessage(0, msg);
		       e.printStackTrace();
		}
		 writer.print(message);
	 }
}
