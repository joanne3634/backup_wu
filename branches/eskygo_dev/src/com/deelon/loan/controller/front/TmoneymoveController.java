package com.deelon.loan.controller.front;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TMoneymove;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TmoneymoveService;
import com.deelon.loan.service.front.UserInfoService;
import com.deelon.loan.service.sysManager.TuserFundsService;
/**
 * @author Administrator
 * 
 */
@Controller
@RequestMapping({ "/loan/front/tmoneymove" })
public class TmoneymoveController extends BaseController {
	@Resource
	private TmoneymoveService tmoneymoveService;
	@Resource
	private TUserService tuserService;
	@ Resource
	private UserInfoService userInfoService;
	@Resource
	private TuserFundsService tuserFundsService;
	/**
	 * 列表
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping({"list"})
	public ModelAndView List(HttpServletRequest request,
			HttpServletResponse response) throws Exception { 
		List<TMoneymove> list =tmoneymoveService.getAll(new QueryFilter(request,"item"));
		return new ModelAndView("/loan/front/tmoneymovelist.jsp").addObject("list",list);
	}
	
	/**
	 * 列表
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping({"listToAutid"})
	public ModelAndView listToAutid(HttpServletRequest request, HttpServletResponse response) throws Exception { 
		List<TMoneymove> list =tmoneymoveService.getAll(new QueryFilter(request,"item"));
		request.setAttribute("autid", 1);
		return new ModelAndView("/loan/front/tmoneymovelist.jsp").addObject("list",list);
	}
	/**
	 * 更新充值记录为有效
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ RequestMapping( { "update" } )
	@ Action( description = "编辑tmoneymove数据" )
	@ ResponseBody
	public Object update( HttpServletRequest request ) throws Exception {
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "tmoneymoveId" ) );
		TMoneymove tmoneymove = null;
		if ( pkId.longValue() != 0L ){
			tmoneymove = (TMoneymove) this.tmoneymoveService.getById( pkId );
			tmoneymove.setAudit(1);
			if("12".equals(tmoneymove.getTypeId())){
				TUser u = tuserService.getById(tmoneymove.getUserId());
				u.setIsAskPrice(1);//1为有询价资格
				tuserService.update(u);
			}else{
				TUserFunds userFunds = userInfoService.getUserFundsInfo(tmoneymove.getUserId());
				userFunds.setAvailable(userFunds.getAvailable().add(tmoneymove.getMoneyInOut()));
				userFunds.setFundsIn(userFunds.getFundsIn().add(tmoneymove.getMoneyInOut()));//充值总额
				userFunds.setBalance(userFunds.getFreeze().add(userFunds.getAvailable().add(tmoneymove.getMoneyInOut())));//账户余额
				tuserFundsService.saveOrUpdateToFunds(userFunds,null);
			}
			tmoneymoveService.update(tmoneymove);
			
		}
		return "1";
	}
	
	/**
	 * 编辑
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ RequestMapping( { "edit" } )
	@ Action( description = "编辑tmoneymove数据" )
	public ModelAndView edit( HttpServletRequest request ) throws Exception {
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "tmoneymoveId" ) );
		TMoneymove tmoneymove = null;
		if ( pkId.longValue() != 0L )
			tmoneymove = (TMoneymove) this.tmoneymoveService.getById( pkId );
		else {
			tmoneymove = new TMoneymove();
		}
		request.setAttribute("audit", request.getParameter("audit"));
		return new ModelAndView("/loan/front/tmoneymoveEdit.jsp").addObject( "tmoneymove", tmoneymove ).addObject( "tmoneymoveId", pkId );
	}
	
	/**
	 * 列表
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping({"listTo"})
	public ModelAndView ListTo(HttpServletRequest request,
			HttpServletResponse response) throws Exception { 
		QueryFilter queryFilter = new QueryFilter(request,"item");
		queryFilter.addFilter("typeId", 12);
		
		List<TMoneymove> list =tmoneymoveService.getChargeMoneyList(queryFilter);
		return new ModelAndView("/loan/front/listTMoneyMove.jsp").addObject("list",list);
	}
	
	/**
	 * 编辑
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ RequestMapping( { "editTo" } )
	@ Action( description = "编辑风险保障金数据" )
	public ModelAndView editTo( HttpServletRequest request ) throws Exception {
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "tmoneymoveId" ) );
		TMoneymove tmoneymove = null;
		if ( pkId.longValue() != 0L )
			tmoneymove = (TMoneymove) this.tmoneymoveService.getById( pkId );
		else {
			tmoneymove = new TMoneymove();
		}
		return new ModelAndView("/loan/front/EditTmoneymove.jsp").addObject( "tmoneymove", tmoneymove ).addObject( "tmoneymoveId", pkId );
	}
}
