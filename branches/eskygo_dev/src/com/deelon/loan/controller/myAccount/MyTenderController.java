package com.deelon.loan.controller.myAccount;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.page.PageBean;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TProjectInvest;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.service.front.TprojectInvestService;
@Controller
@RequestMapping({ "/loan/myAccount/" })
public class MyTenderController extends BaseController {

	@Resource
	private TprojectInvestService tprojectInvestService;
	
	@Action(description="我的投标")
	@RequestMapping({"toMyTender"})
	public ModelAndView toMyTender(HttpServletRequest request,HttpServletResponse response,TProjectInvest t){
	/*	TUser u=(TUser)request.getSession().getAttribute("user");
		String hide_1=request.getParameter("hide_1");
		String hide_2=request.getParameter("hide_2");
		String hide_3=request.getParameter("hide_3");
		
	//	t.setUserId(u.getUserId());
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		
		
		//分页加参数
				int page = RequestUtil.getInt(request, "current_page", 1);
			    int pageSize = RequestUtil.getInt(request, "pageSize",3);
				PageBean pb=new  PageBean(page, pageSize);
				
				Map<String,Object> map = new HashMap<String,Object>();
				
				List<TProjectInvest> listVo=null;
				BigDecimal piEffectAmount=new BigDecimal(0);
				if(StringUtil.isEmpty(hide_1)&&StringUtil.isEmpty(hide_2)&&StringUtil.isEmpty(hide_3)||StringUtil.isNotEmpty(hide_1)){
					
					map.put("userId", u.getUserId());  
					map.put("beginDate1", t.getBeginDate1());
					map.put("endDate1", t.getEndDate1());
					
					
					 listVo=tprojectInvestService.getWaitingForthePayMent(map,pb);
					
					if(listVo!=null&&listVo.size()>0){
						for (TProjectInvest p : listVo) {
							if(p.getPiEffectAmount()!=null)
								p.setPiEffectAmount(p.getPiEffectAmount().setScale(2, BigDecimal.ROUND_HALF_UP));
							piEffectAmount=piEffectAmount.add(p.getPiBeGetSum());
						}
					}
				}
				BigDecimal piEffectAmount1=new BigDecimal(0);
				List<TProjectInvest> listVo1=null;
				if(StringUtil.isNotEmpty(hide_2)){
					map.put("userId", u.getUserId());  
					map.put("beginDate2", t.getBeginDate2());
					map.put("endDate2", t.getEndDate2());
					
					listVo1=tprojectInvestService.getRePayMenetList(map,pb);
					if(listVo1!=null&&listVo1.size()>0){
						for (TProjectInvest p1 : listVo1) {
							if(p1.getPiEffectAmount()!=null)
							p1.setPiEffectAmount(p1.getPiEffectAmount().setScale(2, BigDecimal.ROUND_HALF_UP));
							if(p1.getPaInterest()!=null)
							p1.setPaInterest(p1.getPaInterest().setScale(2, BigDecimal.ROUND_HALF_UP));
							piEffectAmount1=piEffectAmount1.add(p1.getPiBeGetSum());
						}
					}
				}
				List<TProjectInvest> listVo2=null;
				BigDecimal piEffectAmount2=new BigDecimal(0);
				if(StringUtil.isNotEmpty(hide_3)){
					map.put("userId", u.getUserId());  
					map.put("beginDate3", t.getBeginDate3());
					map.put("endDate3", t.getEndDate3());
					
					listVo2=tprojectInvestService.getPayOffList(map,pb);
					if(listVo2!=null&&listVo2.size()>0){
						for (TProjectInvest p2 : listVo2) {
							if(p2.getPiEffectAmount()!=null)
							p2.setPiEffectAmount(p2.getPiEffectAmount().setScale(2, BigDecimal.ROUND_HALF_UP));
							if(p2.getPaInterest()!=null)
								p2.setPaInterest(p2.getPaInterest().setScale(2, BigDecimal.ROUND_HALF_UP));
							piEffectAmount2=piEffectAmount2.add(p2.getPiBeGetSum());
						}
					}
				}
		
		
		
		if(t.getBeginDate1()!=null){
			t.setBeginDateS1(sdf.format(t.getBeginDate1()));
		}
		
		if(t.getEndDate1()!=null){
			t.setEndDateS1(sdf.format(t.getEndDate1()));
		}
		
		if(t.getBeginDate2()!=null){
			t.setBeginDateS2(sdf.format(t.getBeginDate2()));
		}
		if(t.getEndDate2()!=null){
			t.setEndDateS2(sdf.format(t.getEndDate2()));
		}
		if(t.getBeginDate3()!=null){
			t.setBeginDateS3(sdf.format(t.getBeginDate3()));
		}
		if(t.getEndDate3()!=null){
			t.setEndDateS3(sdf.format(t.getEndDate3()));
		}
		
		
		if(StringUtil.isNotEmpty(hide_1)){
			request.setAttribute("HIDE_1", "block");
		}
		if(StringUtil.isNotEmpty(hide_2)){
			request.setAttribute("HIDE_2", "block");
		}
		if(StringUtil.isNotEmpty(hide_3)){
			request.setAttribute("HIDE_3", "block");
		}
		
	
		
		request.setAttribute("piEffectAmount", piEffectAmount);
		request.setAttribute("piEffectAmount", piEffectAmount1);
		request.setAttribute("piEffectAmount", piEffectAmount2);
		request.setAttribute( "page_bean", pb );//分页参数传入页面
		*/
		return new ModelAndView("/loan/myAccount/myTender.jsp");//.addObject("ListVo", listVo).addObject("ListVo1", listVo1).addObject("ListVo2", listVo2).addObject("TProjectInvest", t);
	}
	
	@Action(description="我的投标_代收款")
	@RequestMapping({"toMyTenderWillDo"})
	public ModelAndView toMyTenderWillDo(HttpServletRequest request,HttpServletResponse response,TProjectInvest t){
		TUser u=(TUser)request.getSession().getAttribute("user");
		
		String hide_1=request.getParameter("hide_1");
		String hide_2=request.getParameter("hide_2");
		String hide_3=request.getParameter("hide_3");
		
		//分页加参数
		int page1 = RequestUtil.getInt(request, "current_page", 1);
	    int pageSize1 = RequestUtil.getInt(request, "pageSize",PageBean.getDefaultPageSize().intValue());
		PageBean pb1=new  PageBean(page1, pageSize1);
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		List<TProjectInvest> listVo=null;
		BigDecimal piEffectAmount=new BigDecimal(0);
			
			map.put("userId", u.getUserId());  
			map.put("beginDate1", t.getBeginDate1());
			map.put("endDate1", t.getEndDate1());
			
			
			 listVo=tprojectInvestService.getWaitingForthePayMent(map,pb1);
			
			if(listVo!=null&&listVo.size()>0){
				for (TProjectInvest p : listVo) {
					if(p.getPiEffectAmount()!=null)
						p.setPiEffectAmount(p.getPiEffectAmount().setScale(2, BigDecimal.ROUND_HALF_UP));
//		p.setPaPayBackTime(sdf.format(p.getPaPayBackTime()));
					piEffectAmount=piEffectAmount.add(p.getPiBeGetSum());
				}
			}
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			if(t.getBeginDate1()!=null){
				t.setBeginDateS1(sdf.format(t.getBeginDate1()));
			}
			
			if(t.getEndDate1()!=null){
				t.setEndDateS1(sdf.format(t.getEndDate1()));
			}
			if(StringUtil.isNotEmpty(hide_1)){
				request.setAttribute("HIDE_1", "block");
			}
			if(StringUtil.isNotEmpty(hide_2)){
				request.setAttribute("HIDE_2", "block");
			}
			if(StringUtil.isNotEmpty(hide_3)){
				request.setAttribute("HIDE_3", "block");
			}
			request.setAttribute( "page_bean", pb1 );//分页参数传入页面
		return new ModelAndView("/loan/myAccount/myTenderWillDo.jsp").addObject("ListVo", listVo).addObject("TProjectInvest", t);
	}
	
	@Action(description="我的投标_正在收款")
	@RequestMapping({"toMyTenderBeDoing"})
	public ModelAndView toMyTenderBeDoing(HttpServletRequest request,HttpServletResponse response,TProjectInvest t){
		
		TUser u=(TUser)request.getSession().getAttribute("user");
		String hide_1=request.getParameter("hide_1");
		String hide_2=request.getParameter("hide_2");
		String hide_3=request.getParameter("hide_3");
		//分页加参数
				int page2 = RequestUtil.getInt(request, "current_page", 1);
			    int pageSize2 = RequestUtil.getInt(request, "pageSize",PageBean.getDefaultPageSize().intValue());
				PageBean pb2=new  PageBean(page2, pageSize2);

				
				Map<String,Object> map2 = new HashMap<String,Object>();
				map2.put("userId", u.getUserId());  
				map2.put("beginDate2", t.getBeginDate2());
				map2.put("endDate2", t.getEndDate2());
				
				List<TProjectInvest> listVo1=tprojectInvestService.getRePayMenetList(map2,pb2);
				BigDecimal piEffectAmount1=new BigDecimal(0);
				if(listVo1!=null&&listVo1.size()>0){
					for (TProjectInvest p1 : listVo1) {
						if(p1.getPiEffectAmount()!=null)
						p1.setPiEffectAmount(p1.getPiEffectAmount().setScale(2, BigDecimal.ROUND_HALF_UP));
						if(p1.getPaInterest()!=null)
						p1.setPaInterest(p1.getPaInterest().setScale(2, BigDecimal.ROUND_HALF_UP));
						piEffectAmount1=piEffectAmount1.add(p1.getPiBeGetSum());
//						p.setPaPayBackTime(sdf.format(p.getPaPayBackTime()));
					}
				}
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
				if(t.getBeginDate2()!=null){
					t.setBeginDateS2(sdf.format(t.getBeginDate2()));
				}
				if(t.getEndDate2()!=null){
					t.setEndDateS2(sdf.format(t.getEndDate2()));
				}
				
				
				if(StringUtil.isNotEmpty(hide_1)){
					request.setAttribute("HIDE_1", "block");
				}
				if(StringUtil.isNotEmpty(hide_2)){
					request.setAttribute("HIDE_2", "block");
				}
				if(StringUtil.isNotEmpty(hide_3)){
					request.setAttribute("HIDE_3", "block");
				}
				
				request.setAttribute("piEffectAmount1", piEffectAmount1);
				request.setAttribute( "page_bean", pb2 );//分页参数传入页面
		return new ModelAndView("/loan/myAccount/myTenderBeDoing.jsp").addObject("ListVo1", listVo1).addObject("TProjectInvest", t);
	}
	
	@Action(description="我的投标_已还清")
	@RequestMapping({"toMyTenderEnd"})
	public ModelAndView toMyTenderEnd(HttpServletRequest request,HttpServletResponse response,TProjectInvest t){
		TUser u=(TUser)request.getSession().getAttribute("user");
		String hide_1=request.getParameter("hide_1");
		String hide_2=request.getParameter("hide_2");
		String hide_3=request.getParameter("hide_3");
		//分页加参数
		int page3 = RequestUtil.getInt(request, "current_page", 1);
	    int pageSize3 = RequestUtil.getInt(request, "pageSize",PageBean.getDefaultPageSize().intValue());
		PageBean pb3=new  PageBean(page3, pageSize3);

		Map<String,Object> map3 = new HashMap<String,Object>();
		map3.put("userId", u.getUserId());  
		map3.put("beginDate3", t.getBeginDate3());
		map3.put("endDate3", t.getEndDate3());
		
		List<TProjectInvest> listVo2=tprojectInvestService.getPayOffList(map3,pb3);
		BigDecimal piEffectAmount2=new BigDecimal(0);
		if(listVo2!=null&&listVo2.size()>0){
			for (TProjectInvest p2 : listVo2) {
				if(p2.getPiEffectAmount()!=null)
				p2.setPiEffectAmount(p2.getPiEffectAmount().setScale(2, BigDecimal.ROUND_HALF_UP));
				if(p2.getPaInterest()!=null)
					p2.setPaInterest(p2.getPaInterest().setScale(2, BigDecimal.ROUND_HALF_UP));
				piEffectAmount2=piEffectAmount2.add(p2.getPiBeGetSum());
		//		p.setPaPayBackTime(sdf.format(p.getPaPayBackTime()));
			}
		}
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		if(t.getBeginDate3()!=null){
			t.setBeginDateS3(sdf.format(t.getBeginDate3()));
		}
		if(t.getEndDate3()!=null){
			t.setEndDateS3(sdf.format(t.getEndDate3()));
		}
		
		if(StringUtil.isNotEmpty(hide_1)){
			request.setAttribute("HIDE_1", "block");
		}
		if(StringUtil.isNotEmpty(hide_2)){
			request.setAttribute("HIDE_2", "block");
		}
		if(StringUtil.isNotEmpty(hide_3)){
			request.setAttribute("HIDE_3", "block");
		}
		
		request.setAttribute("piEffectAmount2", piEffectAmount2);
		request.setAttribute( "page_bean", pb3 );//分页参数传入页面
		return new ModelAndView("/loan/myAccount/myTenderEnd.jsp").addObject("ListVo2", listVo2).addObject("TProjectInvest", t);
	}
}
