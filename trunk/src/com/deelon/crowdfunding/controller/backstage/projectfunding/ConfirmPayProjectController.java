package com.deelon.crowdfunding.controller.backstage.projectfunding;

import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
import com.deelon.crowdfunding.model.backstage.Tcproject;
import com.deelon.crowdfunding.model.backstage.TcprojectLoanRecords;
import com.deelon.crowdfunding.service.backstage.TcprojectLoanRecordsService;
import com.deelon.crowdfunding.service.backstage.TcprojectService;
import com.deelon.loan.model.front.TMoneymove;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.service.front.TmoneymoveService;
import com.deelon.loan.service.sysManager.TuserFundsService;
import com.deelon.payform.common.PayCommon;
import com.deelon.payform.common.moneymoremore.PayCommonMoney;
import com.deelon.platform.model.system.SysUser;
 
/**
 * 众筹项目确认放款项目
 * @author verry
 *
 */
@Controller
@RequestMapping( { "/crowdfunding/backstage/confirmPayProject/" } )
public class ConfirmPayProjectController extends BaseController {
	@Resource
	private TcprojectService tcprojectService;
	@Resource
	private TuserFundsService tuserFundsService;
	@Resource
	private TmoneymoveService tmoneymoveService;
	@Resource
	private TcprojectLoanRecordsService tcprojectLoanRecordsService;
	
	
	@RequestMapping( { "list" } )
	@Action( description = "查看Tproject确认放款分页列表" )
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception{ 
		QueryFilter qf = new QueryFilter(request, "projectId");
		qf.addFilter("pstateId", "5");//众筹确认放款阶段
	//	qf.addFilter("pstateIdIn", "4,5");//众筹确认放款阶段
		List<Tcproject> list = tcprojectService.getAllSendMoney(qf);
		ModelAndView mv = getAutoView().addObject( "tprojectList", list );
		return mv;
	}
	
	@RequestMapping( { "editPay" } )
	@Action( description = "平台审核众筹项目确认放款处理" )
	public ModelAndView editPay( HttpServletRequest request, HttpServletResponse response ) throws Exception{ 
	//	boolean flag = tcprojectService.confirmPayProject(request.getParameter("projectId"));
	//	if(flag){
			
			long id=Long.parseLong(request.getParameter("projectId"));
			Tcproject project = tcprojectService.getById(id);
			
			float paymethod = 1;//拨付方式的比例
			if("1".equals(project.getPpayWay())){//每季度一次，每次25%
				paymethod = 0.25f;
			}else if("2".equals(project.getPpayWay())){//每半年一次，每次50%
				paymethod = 0.5f;
			}else if("3".equals(project.getPpayWay())){//一次性投资拨付全到帐
				paymethod = 1;
			}
			
			//算好手续费.如果是第一次转账 则 扣除手续费 ，往后就不再扣除
			
			String poundage =(String)AppUtil.getServletContext().getAttribute("CROWD_SUCCESS_FEES");//平台手续费比例
			double dealFee = 0;//平台放款处理费用
			if(StringUtil.isNotEmpty(poundage)){//如果平台借款比例不为空则处理此次拨付放款的处理费为以下计算得
				project.setPdealRate(Float.valueOf(poundage));//设置项目平台拨付筹集资金款费用比例
				dealFee = project.getPinvestAmount().multiply(new BigDecimal(Float.valueOf(poundage)).divide(new BigDecimal(100),2, RoundingMode.UP)).doubleValue(); 
			}
			//设置项目平台拨付筹集资金款费用
			if(null!=project.getPdealFees()&&project.getPdealFees()>0){//属于分批拨付款的情况，将费用设置为0，因为第一次已经收取所有平台处理费用
				dealFee = 0;
			}/*else{//设置平台处理费用
				project.setPdealFees(dealFee);
			}*/
			//如果放款成功,如果是第一次扣手续费,则在放款成功时 更新PdealFees 字段
			
			//手续费 在第一次 时 扣除
			
			TUserFunds uaco=tuserFundsService.getTUserFundsByUserId(project.getCreator());//借款人账户
			
			HashMap<String,String> hm=new HashMap<String,String>();
			String flowCode=String.valueOf(UniqueIdUtil.genId());
			hm.put("LoanOutMoneymoremore", PayCommonMoney.payformNo);//付款账户,平台账户
			hm.put("LoanInMoneymoremore",uaco.getPayMark());//收款账户
			hm.put("OrderNo", flowCode);//订单号
			hm.put("BatchNo", flowCode);//批次号
			hm.put("Amount",project.getPinvestAmount().multiply(new BigDecimal(paymethod)).subtract(new BigDecimal(dealFee)).toString());//转账金额 减去手续费
			hm.put("TransferName", "放款,转账金额");//
			PayCommon.loanTrans(hm);  
			
			  //在资金记录插入一条数据,状态为失败，等双乾返回转账成功后再修改为成功
			
			TMoneymove m=new TMoneymove();	
			m.setMoneyMoveId(UniqueIdUtil.genId());
			m.setUserId(uaco.getUserId());
			m.setProjectId(project.getProjectId());
			m.setTypeId("8");//平台放款
			m.setMoneyInOut(project.getPinvestAmount().multiply(new BigDecimal(paymethod)).subtract(new BigDecimal(dealFee)));
			m.setGetFee(new BigDecimal(dealFee));//手续费
			m.setMoneyCurrent(uaco.getBalance());//成功后 在加上 平台放款的金额
			m.setAudit(0);
			m.setResultId("2");
			m.setRemark("平台放款失败");
			m.setSerialNo("");	
			m.setChecker(0);
			m.setCreateTime(new Timestamp(System.currentTimeMillis()));
			m.setFlowCode(flowCode);
			tmoneymoveService.add(m);
			
		/*	QueryFilter qf = new QueryFilter(request, "projectId");
			qf.addFilter("pstateId", "5");//众筹确认放款阶段
			List<Tcproject> list = tcprojectService.getAll(qf);*/
		//	ModelAndView mv = new ModelAndView("/crowdfunding/backstage/confirmPayProjectList.jsp").addObject( "tprojectList", list );
			ModelAndView mv = new ModelAndView("/crowdfunding/onlinePayment/payAskPriceMoneys.jsp").addObject("hm", hm)
					.addObject("hmData", hm.get(PayCommonMoney.payDataKey));
			
			return mv;
		/*}else{
			return null;
		}*/
	}
	
	@RequestMapping( { "cacelPay" } )
	@Action( description = "平台审核众筹项目取消放款并且项目作与项目创建人再确认处理" )
	public ModelAndView cacelPay( HttpServletRequest request, HttpServletResponse response ) throws Exception{ 
		boolean flag = tcprojectService.cancelPayProject(request.getParameter("projectId"),request.getParameter("ispay"));
		if(flag){
			QueryFilter qf = new QueryFilter(request, "projectId");
			qf.addFilter("pstateId", "5");//众筹确认放款阶段
	//		List<Tcproject> list = tcprojectService.getAll(qf);
			List<Tcproject> list = tcprojectService.getAllSendMoney(qf);
			ModelAndView mv = new ModelAndView("/crowdfunding/backstage/confirmPayProjectList.jsp").addObject( "tprojectList", list );
			return mv;
		}else{
			return null;
		}
	}
	
	@RequestMapping( { "loanInfo" } )
	@Action( description = "查看项目的跟投人" )
	public ModelAndView loanInfo( HttpServletRequest request, HttpServletResponse response ) throws Exception{ 
		String projectId=request.getParameter("projectId");
		
		QueryFilter queryFilter=new QueryFilter(request, "tcprojectLoanRecordsItem");
		
		queryFilter.addFilter("projectId", projectId);
		queryFilter.addFilter("orderField1", "createtime");//没有取消跟投的
		List<TcprojectLoanRecords> list=tcprojectLoanRecordsService.getAll(queryFilter);
		
		ModelAndView mv = getAutoView().addObject("projectId", projectId).addObject("tcprojectLoanRecordsList", list);
		return mv;
	}
	
	
	/**
	 * 保存放款数据
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping({"saveLoanInfo"})
	
	public void saveLoanInfo(HttpServletRequest request, HttpServletResponse response){
		
		String projectId=request.getParameter("projectId");
		String loanAmout=request.getParameter("loanAmout");
		String loanDate=request.getParameter("loanDate");
		String loanPerson=request.getParameter("loanPerson");
		String loanFlowCode=request.getParameter("loanFlowCode");
		ResultMessage message =null;
		 PrintWriter writer = null;
		if(StringUtil.isEmpty(loanAmout)){
			loanAmout="0";
		}
		
				try {
					  message = new ResultMessage(1, "操作成功！");
					  writer=response.getWriter();
					 
					  SimpleDateFormat sdf=new SimpleDateFormat("yyyy-dd-mm");
					
					SysUser su=ContextUtil.getCurrentUser();
					Tcproject project=tcprojectService.getById(Long.valueOf(projectId));
					//发信息给用户
					TcprojectLoanRecords c=new TcprojectLoanRecords();
					c.setLoanRecordId(UniqueIdUtil.genId());
					c.setProjectId(Long.valueOf(projectId));
					c.setCreatetime(new Date());
					c.setCreatPerson(su.getUserId());
					c.setLoanAmout(new BigDecimal(loanAmout));
					c.setLoanDate(sdf.parse(loanDate));
					c.setLoanFlowCode(loanFlowCode);
					c.setLoanPerson(loanPerson);
			//		tcprojectLoanRecordsService.add(c);
					
					
					float paymethod = 1;//拨付方式的比例
					if("1".equals(project.getPpayWay())){//每季度一次，每次25%
						paymethod = 0.25f;
					}else if("2".equals(project.getPpayWay())){//每半年一次，每次50%
						paymethod = 0.5f;
					}else if("3".equals(project.getPpayWay())){//一次性投资拨付全到帐
						paymethod = 1;
					}
					
					//算好手续费.如果是第一次转账 则 扣除手续费 ，往后就不再扣除
					
					String poundage =(String)AppUtil.getServletContext().getAttribute("CROWD_SUCCESS_FEES");//平台手续费比例
					double dealFee = 0;//平台放款处理费用
					if(StringUtil.isNotEmpty(poundage)){//如果平台借款比例不为空则处理此次拨付放款的处理费为以下计算得
						project.setPdealRate(Float.valueOf(poundage));//设置项目平台拨付筹集资金款费用比例
						dealFee = project.getPinvestAmount().multiply(new BigDecimal(Float.valueOf(poundage)).divide(new BigDecimal(100),2, RoundingMode.UP)).doubleValue(); 
					}
					//设置项目平台拨付筹集资金款费用
					if(null!=project.getPdealFees()&&project.getPdealFees()>0){//属于分批拨付款的情况，将费用设置为0，因为第一次已经收取所有平台处理费用
						dealFee = 0;
					}
					
					
					TMoneymove m=new TMoneymove();	
					m.setMoneyMoveId(UniqueIdUtil.genId());
					m.setUserId(su.getUserId());
					m.setProjectId(project.getProjectId());
					m.setTypeId("8");//平台放款
					m.setMoneyInOut(project.getPinvestAmount().multiply(new BigDecimal(paymethod)).subtract(new BigDecimal(dealFee)));
					m.setGetFee(new BigDecimal(dealFee));//手续费
					m.setMoneyCurrent(new BigDecimal("0"));//成功后 在加上 平台放款的金额
					m.setAudit(0);
					m.setResultId("2");
					m.setRemark("平台放款成功");
					m.setSerialNo("");	
					m.setChecker(0);
					m.setCreateTime(new Timestamp(System.currentTimeMillis()));
					m.setFlowCode(loanFlowCode);
				//	tmoneymoveService.add(m);
					
					project.setPisPay(1);
					project.setPpayTime(new Date());
					
					tcprojectLoanRecordsService.updateProject(c, m,project);
					
					
					
					
				} catch (Exception e) {
					// TODO: handle exception
					 String msg = ExceptionUtil.getExceptionMessage(e);
				        message = new ResultMessage(0, msg);
					e.printStackTrace();
				}
				
				
				 writer.print(message);
	}
}
