package com.deelon.loan.controller.myAccount;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.util.StringUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.util.ValiBankCark;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.crowdfunding.common.util.TUserUtil;
import com.deelon.loan.model.front.TBankcard;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.model.front.Tarea;
import com.deelon.loan.model.sysManager.Tbank;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TareaService;
import com.deelon.loan.service.front.TbankcardService;
import com.deelon.loan.service.front.TuserCreditService;
import com.deelon.loan.service.front.TuserSafeService;
import com.deelon.loan.service.sysManager.TbankService;
import com.deelon.loan.service.sysManager.TuserFundsService;

@Controller
@RequestMapping({"/loan/myAccount/"})
public class BindBankCardsController extends BaseController {

	@Resource
	private TbankcardService tbankcardService;
	@Resource
	private TuserSafeService tusersafeService;
	@Resource
	private TuserCreditService tuserCreditService;
	@Resource
	private TuserFundsService tuserFundsService;
	@Resource
	private TbankService tbankService;
	@Resource
	private TUserService tuserService;
	@ Resource
	private TareaService tareaService;
	
	
	//跳转至绑定银行卡页面
	@RequestMapping({"toBindBCPage"})
	public ModelAndView toBindBCPage(HttpServletRequest request,HttpServletResponse response){
		
		TUser user = TUserUtil.getLogUser(request);
		
		
		if(null == user){
			try {
				response.sendRedirect(request.getContextPath()+"/loginWeb.jsp");
				return null;
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		QueryFilter queryFilter = new QueryFilter();
		queryFilter.addFilter("parentId", 0);
		List<Tbank> banklist = tbankService.getAll(queryFilter);  //获取所有银行下拉数据
		 
		QueryFilter query = new QueryFilter();
		query.addFilter("parentId", 1);
		query.addFilter("orderField", "order_code");
		query.addFilter("orderSeq", "desc");
		List<Tarea> arealist = tareaService.getAll(query);
		
	    List<TBankcard> list = tbankcardService.getTBankcardByUserId(user.getUserId());
		
		user = tuserService.getById(user.getUserId());
		TUserSafe userSafe = tusersafeService.getUserSafeByUserId(user.getUserId());
		request.setAttribute("arealist", arealist);
		if(list.size() > 0){
			request.setAttribute("user", user);
			request.setAttribute("userSafe", userSafe);
			request.setAttribute("isbindkcard", "isbindkcard");
			request.setAttribute("bindkcard", list.get(0));
		}
		
		return new ModelAndView("/loan/myAccount/bindBankCards.jsp").addObject("banklist", banklist);
	}
	
	//通过银行接口 ,向用户 开卡时绑定的手机号 发送一条验证码,再根据 验证码的正确性 确定 用户是否绑定成功.
	@RequestMapping({"bindBandCard"})
	@ResponseBody
public String bindBandCard(HttpServletRequest request,HttpServletResponse response,TBankcard tBankcard) throws IOException{
		
		String cityNumber = request.getParameter("cityNumber");
		String openingNumber = request.getParameter("openingNumber");
		
		String bankCode = request.getParameter("bankCode");
		String bankName = java.net.URLDecoder.decode(request.getParameter("bankName"),"UTF-8");
		
		TUser u= TUserUtil.getLogUser(request);
		
		
		if(u == null){
			logger.info("登录已失效，");
		}
		
		 //实名认证
  		/*if(StringUtil.isNotEmpty(tBankcard.getRealName()) && StringUtil.isNotEmpty(tBankcard.getIdNo())){
  			String message = "";
  			Map<String,Object> map = tusersafeService.idcardIsReal(request,response,tBankcard.getRealName(),tBankcard.getIdNo());
  			if(map.get("same")!=null && String.valueOf(map.get("same")).equals("1")){
  				message = "1";//姓名，身份证号一致
  			}else{
  				message = String.valueOf(map.get("msg"));
  				return message;
  			}
  		}*/

		Long userId=u.getUserId();//当前用户id;
		//这里先预设 银行返回的验证码为 aaa
		//和客户收到的验证码对比
		//String bankValiCode="aaa";//银行返回的验证码
		//if(StringUtil.isNotEmpty(customer_valiCode)&&StringUtil.isNotEmpty(bankValiCode)){
			//if(bankValiCode.equals(customer_valiCode)){
				
//				tBankcard.setIsBindSsucceed();
				tBankcard.setIsBindSsucceed((short) 1);
				tBankcard.setCreateTime(new Date());
				tBankcard.setUserId(userId); 
				tBankcard.setCityNumber(cityNumber);
				tBankcard.setOpeningNumber(openingNumber);
				tBankcard.setCardPwd("0");
				tBankcard.setMobileNum("0");
				tBankcard.setRemark("0");
				//add by nicole 2015/3/3 添加银行信息
				tBankcard.setBankCode(bankCode);
				tBankcard.setBankName(bankName);
				tBankcard.setRealName(u.getRealName());
				
				
				if(tBankcard.getBankCardId()==0){
					tBankcard.setBankCardId(Long.valueOf(UniqueIdUtil.genId()));
					tbankcardService.add(tBankcard);
				} else{
					tbankcardService.update(tBankcard);
				}
			
				
				TUser user = tuserService.getById(userId);
				user.setRealName(tBankcard.getRealName());
				tuserService.update(user);
				
				//修改 t_user_safe 绑定身份认证
				TUserSafe us=tusersafeService.queryTUserSafeByuserId(String.valueOf(userId));
				us.setBindIdNo((short) 1);

				/**
				 *[针对投资机构] 将银行卡绑定信息的身份证件号 同时保存到 t_user_safe
				 */
				if(StringUtil.isEmpty(us.getIdNo())){
					us.setIdNo(tBankcard.getIdNo());
				}

				tusersafeService.updateTUserSafeByPk(us);
				
				//先判断 用户的性质(是投资人,还是贷款人),给t_user_funds表中的借出(投资人),借入(贷款人)信用字段+1
//				TUserFunds uf=tuserFundsService.getTUserFundsByUserId(userId);
//				if(StringUtil.isNotEmpty(u.getGroupID())){//当前登录人 角色 是投资人 还是 贷款人
//					if(u.getGroupID().equals("1")){//投资人
//						if(uf.getCreditOut()!=null)
//							uf.setCreditOut(uf.getCreditOut()+1);
//						else{
//							uf.setCreditOut(1);
//						}
//					}else{//贷款人
//						if(uf.getCreditIn()!=null)
//							uf.setCreditIn(uf.getCreditIn()+1);
//						else{
//							uf.setCreditIn(1);
//						}
//					}
//				}
//				tuserFundsService.update(uf);
				
				//给t_user_credit信用历史表中增加一条记录,并且指明typeId为1.（任务增加信用）
				//TuserCredit uc=new TuserCredit();
				///uc.setUserId(userId);
				//uc.setCreateTime(new Date());
				//uc.setTypeId(1);//1.任务 2.资料通过审核,3.投资.4.贷款,
//				uc.setKeyId();//这里任务表t_task表的主键,先暂时空着,看到时候取到任务主键再放入
				
				//tuserCreditService.saveTuserCredit(uc);
				
			//}else{
				//提示验证吗不正确
			//}
		//}
		
		return "0";
	}
	
	
	
	//验证银行卡是否合法
	@RequestMapping({"valiBankCard"})
	public ModelAndView validateBankCard(HttpServletRequest request,HttpServletResponse response,@RequestParam("bankCard") String bankCard){
		boolean flag=ValiBankCark.checkBankCard("bankCard");
		if(!flag){//银行卡不合法 
			//return new ModelAndView();
		}else{//合法
			
		}
		return null;
		
	}
}
