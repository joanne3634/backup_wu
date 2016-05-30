package com.deelon.loan.controller.myAccount;

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
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.model.front.TProjectInvest;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.model.front.TuserSetauto;
import com.deelon.loan.service.front.TprojectInvestService;
import com.deelon.loan.service.front.TuserSetautoService;
import com.deelon.loan.service.front.TuserTaskcompleteService;
import com.deelon.loan.service.sysManager.TprojectService;
import com.deelon.loan.service.sysManager.TuserFundsService;

@Controller
@RequestMapping({ "/loan/myAccount/" })
public class AutoBiddingController extends BaseController {
	
	@Resource
	private TuserSetautoService tuserSetautoService;
	@Resource
	private TprojectService tprojectService;
	@Resource
	private TuserFundsService tuserFundsService;
	@Resource
	private TprojectInvestService tprojecInvestService;
	@Resource
	private TuserTaskcompleteService tuserTaskcompleteService;
	@Action(description="到自动投标页面")
	@RequestMapping({"toAutoBidding"})
	public ModelAndView toAutoBidding(HttpServletRequest request, HttpServletResponse response){
		
		try {
			TUser u=(TUser)request.getSession().getAttribute("user");
			Long userId=u.getUserId();//当前用户id;
			//String taskId = request.getParameter("taskId");
			
			//根据用户id查询用户最近 设置的 投标 查询条件
			TuserSetauto t =tuserSetautoService.getTuserSetautoByUserId(userId);
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			if(t!=null){
				
				if(StringUtil.isNotEmpty(t.getAmountType())){
					if(t.getAmountType().equals("1")){
						t.setAmountType_1(t.getAmountType());
						t.setAmountTypeValue_1(t.getAmountTypeValue());
					}else if(t.getAmountType().equals("2")){
						t.setAmountType_2(t.getAmountType());
						t.setAmountTypeValue_2(t.getAmountTypeValue());
					}else{
						t.setAmountType_3(t.getAmountType());
					}
				}
				if(t.getAutoDateStart()!=null)
				t.setBeginDate(sdf.format(t.getAutoDateStart()));
				if(t.getAutoDateEnd()!=null)
				t.setEndDate(sdf.format(t.getAutoDateEnd()));
			}else{
				t=new TuserSetauto();
			}
			//if(taskId != null){   //新手任务
			tuserTaskcompleteService.viweAddcredit(userId,4);
			
			
			return  new ModelAndView("/loan/myAccount/autoBidding.jsp").addObject("TuserSetauto", t);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	@Action(description="保存自动投标设置")
	@RequestMapping({"saveToUserSetAuto"})
	public ModelAndView saveToUserSetAuto(HttpServletRequest request, HttpServletResponse response ,TuserSetauto tuserSetauto){
		TUser u=(TUser)request.getSession().getAttribute("user");
		Long userId=u.getUserId();//当前用户id;
		
		Map<String,String> mp=new HashMap<String,String>();
		try {
//			Long  userId=ContextUtil.getCurrentTUser().getUserId();
			tuserSetauto.setUserId(userId);
			
			//如果用户 的投标金额 选中了 '可用余额全部投标',则将 用户的可用余额 付给amountTypeValue,
			
			//如果用户选中了 ‘按借款金额比例’ 则将 amountTypeValue 值 除于100
			if(StringUtil.isNotEmpty(tuserSetauto.getAmountType_1())){
				tuserSetauto.setAmountType(tuserSetauto.getAmountType_1());
				tuserSetauto.setAmountTypeValue(tuserSetauto.getAmountTypeValue_1());
			}
			if(StringUtil.isNotEmpty(tuserSetauto.getAmountType_2())){
				tuserSetauto.setAmountType(tuserSetauto.getAmountType_2());
			}
			if(StringUtil.isNotEmpty(tuserSetauto.getAmountType_3())){//可用余额全部投标
				TUserFunds tu=tuserFundsService.getTUserFundsByUserId(userId);
				if(tu.getAvailable()!=null)
					tuserSetauto.setAmountTypeValue(tu.getAvailable().toString());
				
				
				tuserSetauto.setAmountType(tuserSetauto.getAmountType_3());
			}
			/*if(StringUtil.isNotEmpty(tuserSetauto.getAmountType())){
				if(tuserSetauto.getAmountType().equals("3")){//可用余额全部投标
					TUserFunds tu=tuserFundsService.getTUserFundsByUserId(1L);
					if(tu.getAvailable()!=null)
						tuserSetauto.setAmountTypeValue(tu.getAvailable().toString());
					
					tuserSetauto.setAmountTypeValue("");
				}//else if(tuserSetauto.getAmountType().equals("2")){//按借款金额比例
					//tuserSetauto.setAmountTypeValue(value);
				//}
			}*/
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			if(StringUtil.isNotEmpty(tuserSetauto.getBeginDate())){
				tuserSetauto.setAutoDateStart(sdf.parse(tuserSetauto.getBeginDate()));
			}
			if(StringUtil.isNotEmpty(tuserSetauto.getEndDate())){
				tuserSetauto.setAutoDateEnd(sdf.parse(tuserSetauto.getEndDate()));
			}
			
			tuserSetauto.setUpdateTime(new Date());
			int i =tuserSetautoService.saveOrUpdateTuserSetauto(tuserSetauto);
			
			//重新查询客户刚刚保存的记录
			TuserSetauto tu =tuserSetautoService.getTuserSetautoByUserId(userId);
			if(tu!=null){
				
				if(StringUtil.isNotEmpty(tu.getAmountType())){
					if(tu.getAmountType().equals("1")){
						tu.setAmountType_1(tu.getAmountType());
						tu.setAmountTypeValue_1(tu.getAmountTypeValue());
					}else if(tu.getAmountType().equals("2")){
						tu.setAmountType_2(tu.getAmountType());
					}else{
						tu.setAmountType_3(tu.getAmountType());
					}
				}
				if(tu.getAutoDateStart()!=null)
				tu.setBeginDate(sdf.format(tu.getAutoDateStart()));
				if(tu.getAutoDateEnd()!=null)
				tu.setEndDate(sdf.format(tu.getAutoDateEnd()));
			}else{
				tu=new TuserSetauto();
			}
			
			//查询自动投标记录
		
			String htmlStr="";
			if(i>0){//保存成功,则根据条件查询对应的 项目
				QueryFilter queryFilter=new QueryFilter(request,"projectId");
				queryFilter.addFilter("ptypeId",tuserSetauto.getProductsLoanId() );
				queryFilter.addFilter("prepayWay", tuserSetauto.getRepayWay());
				queryFilter.addFilter("prateIn",tuserSetauto.getRateOut() );
				queryFilter.addFilter("pdeadline",tuserSetauto.getDeadline());
				List<TProject> list=tprojectService.getProByWhere(queryFilter);
				
				
				if(list!=null&&list.size()>0){
					for (TProject t : list) {
						
						htmlStr+="<div class=\"con-box-list-item\">";
						
						htmlStr+="<div class=\"boxpic\">";
						if(StringUtil.isNotEmpty(t.getFileId())){
							
							htmlStr+="<img src=\"${ctx}/platform/system/sysFile/getFileById.ht?fileId="+t.getFileId()+"\">";
						}else{
							htmlStr+="<img src=\"${ctx }/images/huiyuantouxiang.png\">";
						}
						htmlStr+="</div>";
						
						htmlStr+=" <div class=\"box-btn\">";
						htmlStr+="<input type=\"button\" name=\"BtnSave\" class=\"btn\" id=\"BtnSave\" value=\"启 用\">";
						htmlStr+="</div>";
						
						htmlStr+="<div class=\"showtxt\">";
						htmlStr+="<a href=\"#\" target=\"_blank\">"+t.getPname()+"</a><br>";
						htmlStr+="<div>";
						htmlStr+="<span class=\"dp-i\" style=\"width:37%;\">投资金额：<span class=\"color-main dp-i\">"+t.getPloanReal()+"</span>元</span>";
						htmlStr+="<span class=\"dp-i\" style=\"width:30%;\">预计年化率：<span class=\"color-main dp-i\">"+t.getPrateOut()+"</span>%</span>";
						htmlStr+="<span class=\"dp-i\" style=\"width:33%;\">时间：<span class=\"color-main dp-i\">"+t.getPdeadline()+"</span>个月 付本还息</span>";
						htmlStr+="</div>";
						htmlStr+="</div>";
						htmlStr+="</div>";
						
						htmlStr+="<div  class=\"dotted-gray\"></div>";
					}
					
					if(StringUtil.isEmpty(htmlStr)){
						htmlStr="没有查询记录!";
					}
//					htmlStr+="<%@ taglib prefix=\"deelon\" uri=\"http://www.deelon.com/paging\" %>";
//					htmlStr+="<deelon:paging tableId=\"projectId\"/>";
				}
//				mp.put("htmlstr", htmlStr);
			}
			return new ModelAndView("/loan/myAccount/autoBidding.jsp").addObject("htmlStr", htmlStr).addObject("TuserSetauto", tu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		return null;
	}
	
	@Action(description="获取自动投标历史")
	@RequestMapping({"getBiddingHistory"})
	@ResponseBody
	public List<TProjectInvest> getBiddingHistory(HttpServletRequest request, HttpServletResponse response){
		TUser u=(TUser)request.getSession().getAttribute("user");
		Long userId=u.getUserId();//当前用户id;
		
		QueryFilter qf=new QueryFilter(request,"investId");
		qf.addFilter("userId", userId);
		qf.addFilter("plTypeId", "2");
		List<TProjectInvest> listVo=tprojecInvestService.getTProjectInvestByUserId(qf);
		if(listVo!=null&&listVo.size()>0){
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
			for (TProjectInvest t : listVo) {
				if(t.getPiBidTime()!=null)
				t.setPiBidTimeStr(sdf.format(t.getPiBidTime()));
				
				if(t.getPiHavedPay()==0){
					t.setPiHavedPayStr("成功");
				}else{
					t.setPiHavedPayStr("失败");
				}
			}
			
			
		}
		return listVo;
	}

}
