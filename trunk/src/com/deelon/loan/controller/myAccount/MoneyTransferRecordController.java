package com.deelon.loan.controller.myAccount;

import java.math.BigDecimal;
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.page.PageBean;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TMoneymove;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.service.front.TmoneymoveService;
import com.deelon.loan.service.sysManager.TuserFundsService;

@Controller
@ RequestMapping({"/loan/myAccount/"})
public class MoneyTransferRecordController extends BaseController {
	@Resource
	private TuserFundsService tuserFundsService;
	
	@Resource
	private TmoneymoveService tmoneymoveService;
	@Action(description="分页查询资金记录,用户账户资金详情")
	@RequestMapping({"moneyRecord"})
	public ModelAndView moneyRecord(HttpServletRequest request,HttpServletResponse response){
		TUser u=(TUser)request.getSession().getAttribute("user");
		Long userId=u.getUserId();//当前用户id;
		TMoneymove tmoneymove =new TMoneymove();
		tmoneymove.setUserId(userId);//暂时
		try {
			//已充值总额 ,已体现总额 这里统计 历史 的 充值 和体现 总额
			BigDecimal chargeMoneyTotal=new BigDecimal(0.0);
			BigDecimal drawMoneyTotal=new BigDecimal(0.0);
			TMoneymove tm=new TMoneymove();
			
			List<TMoneymove> list=tmoneymoveService.getAllData(tmoneymove);
			if(list!=null&&list.size()>0){
				for (TMoneymove t : list) {
					if(StringUtil.isNotEmpty(t.getTypeId())){
						if(t.getTypeId().equals("1")){//充值
							chargeMoneyTotal.add(t.getMoneyInOut().setScale(2, BigDecimal.ROUND_HALF_UP));
						}else if(t.getTypeId().equals("2")){//体现
							drawMoneyTotal.add(t.getMoneyInOut().setScale(2, BigDecimal.ROUND_HALF_UP));
						}
					}
				}
			}
			tm.setChargeMoneyTotal(chargeMoneyTotal);
			tm.setDrawMoneyTotal(drawMoneyTotal);
			
			//账户余额 ,可用资金,冻结资金
			TUserFunds sf=tuserFundsService.getTUserFundsByUserId(userId);//
			sf.setAvailable(sf.getAvailable().setScale(2, BigDecimal.ROUND_HALF_UP));
			sf.setFreeze(sf.getFreeze().setScale(2, BigDecimal.ROUND_HALF_UP));
			sf.setBalance(sf.getAvailable().add(sf.getFreeze()).setScale(2, BigDecimal.ROUND_HALF_UP));
			
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			//查询条件
			 		String typeId=request.getParameter("typeId");//
					String timeBucket=request.getParameter("timeBucket");
				
					GregorianCalendar gc=new GregorianCalendar(); 
					Date tb=null;
					 if(StringUtil.isNotEmpty(timeBucket)){
						 gc.setTime(new Date());
						if(timeBucket.equals("1")){//1周内
							gc.add(3, -1);
							tb=gc.getTime();
						}else if(timeBucket.equals("2")){//2周内
							gc.add(3, -3);
							tb=gc.getTime();
						}else if(timeBucket.equals("3")){
							gc.add(2, -1);
							tb=gc.getTime();
						}else if(timeBucket.equals("4")){//
							gc.add(2, -2);
							tb=gc.getTime();
						}else if(timeBucket.equals("5")){
							gc.add(2, -3);
							tb=gc.getTime();
						}else if(timeBucket.equals("6")){
							gc.add(2, -6);
							tb=gc.getTime();
						}else if(timeBucket.equals("7")){
							gc.add(1, -1);
							tb=gc.getTime();
						}
					 }else{
						 tb=null;
					 }
			
				//	 String ds=sdf.format(tb);
			/*QueryFilter queryFilter=new QueryFilter(request, "moneyMoveId");
			queryFilter.addFilter("userId", userId);
			*/
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("userId", userId);  
			
			//查询条件
			if(StringUtil.isNotEmpty(typeId)){
				map.put("typeId", typeId);
			}
			if(StringUtil.isNotEmpty(timeBucket)){
				
				map.put("timeBucket", sdf.format(tb)+" 00:00:00");
			}
			map.put("currentDate", sdf.format(new Date()));
			
			//分页加参数
			int page = RequestUtil.getInt(request, "current_page", 1);
		    int pageSize = RequestUtil.getInt(request, "pageSize",PageBean.getDefaultPageSize().intValue());
			PageBean pb=new  PageBean(page, pageSize);
			
			List<TMoneymove> listVo=tmoneymoveService.getUserMoneyList(map,pb);
			String eachTable="";
			if(listVo!=null&&listVo.size()>0){
				SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
				for (TMoneymove c : listVo) {
					String cs="";
					if(c.getCreateTime()!=null)
						cs=sdf1.format(c.getCreateTime());
					
					 eachTable+="<li class=\"zijinjilu-ite\">";
					   eachTable+="<span>"+cs+"</span>";
					  eachTable+="<span>";
					 
					  switch (Integer.valueOf(c.getTypeId())) {
					  	case 1: eachTable+="充值";break;
						case 2: eachTable+="体现";break;
						case 3: eachTable+="投资";break;
						case 4: eachTable+="还款";break;
						case 5: eachTable+="收益";break;
						case 6: eachTable+="担保金";break;
						case 7: eachTable+="贷款手续费";break;
						case 8: eachTable+="平台手续费";break;
						case 9: eachTable+="资金解冻";break;
					  	/*default:
						break;*/
					  }
					  eachTable+="</span>";
					  eachTable+="<span>"+c.getMoneyInOut()+"元</span>";
					  eachTable+="<span>"+c.getMoneyCurrent()+"元</span>";
					  eachTable+="<span>"+c.getRemark()+"</span>"; 
	  				 eachTable+="</li>";
	  				 
	  				
				}
			}
				request.setAttribute( "page_bean", pb );//分页参数传入页面
				request.setAttribute( "typeId", typeId );
				request.setAttribute( "selectEd", timeBucket );
				return new ModelAndView("/loan/myAccount/moneyTransferRecord.jsp").addObject("eachTable", eachTable).addObject("TUserFunds", sf).addObject("TMoneymove", tm);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@Action(description="此方法弃用")
	@RequestMapping({"loadTableGrid"})
	@ResponseBody
	public List<TMoneymove> loadTableGrid(HttpServletRequest request,HttpServletResponse response ,Model model){
	
		TUser u=(TUser)request.getSession().getAttribute("user");
		Long userId=u.getUserId();//当前用户id;
		//查询条件
		String typeId=request.getParameter("typeId");
		String createTime=request.getParameter("createTime");
		String Q_begincreatetime_DL=request.getParameter("Q_begincreatetime_DL");
		String Q_endcreatetime_DG=request.getParameter("Q_endcreatetime_DG");
		try {
		
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			//table data
			/*QueryFilter queryFilter=new QueryFilter(request, "moneyMoveId");
			queryFilter.addFilter("userId", userId);*/
			
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("userId", userId);  
			
			//查询条件
			if(StringUtil.isNotEmpty(typeId)){
//				queryFilter.addFilter("typeId", typeId);
				map.put("typeId", typeId);
			}
			if(StringUtil.isNotEmpty(createTime)){
//				queryFilter.addFilter("createTime", createTime);
				map.put("createTime", createTime);
			}
			if(StringUtil.isNotEmpty(Q_begincreatetime_DL)){
//				queryFilter.addFilter("beginDate", sdf.parse(Q_begincreatetime_DL));
				map.put("beginDate", sdf.parse(Q_begincreatetime_DL));
			}
			if(StringUtil.isNotEmpty(Q_endcreatetime_DG)){
//				queryFilter.addFilter("endDate", sdf.parse(Q_endcreatetime_DG));
				map.put("endDate", sdf.parse(Q_endcreatetime_DG));
			}
			//分页加参数
			int page = RequestUtil.getInt(request, "current_page", 1);
		    int pageSize = RequestUtil.getInt(request, "pageSize",PageBean.getDefaultPageSize().intValue());
			PageBean pb=new  PageBean(page, pageSize);
			
			List<TMoneymove> listVo=tmoneymoveService.getAllDataOfUser(map,pb);
			model.addAttribute("ShowPage", "1");
			return listVo;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

}
