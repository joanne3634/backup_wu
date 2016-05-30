package com.deelon.loan.controller.front;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.cmsform.model.site.CmsSiteConfig;
import com.deelon.cmsform.model.site.CmsSiteMenuContent;
import com.deelon.cmsform.service.site.CmsSiteMenuContentService;
import com.deelon.core.annotion.Action;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TMoneymove;
import com.deelon.loan.model.front.TProjectRisk;
import com.deelon.loan.service.front.TmoneymoveService;
import com.deelon.loan.service.front.TprojectRiskService;
/**
 * @author Administrator
 * 
 */
@Controller
@RequestMapping({ "/site/tprojectRisk/" })
public class TprojectRiskController extends BaseController {
	@Resource
	private TprojectRiskService tprojectRiskService;
	/**
	 * 跳列表
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping({"list"})
	public ModelAndView AboutUs(HttpServletRequest request,
			HttpServletResponse response) { 
		
		List<TProjectRisk> list =tprojectRiskService.getAll(new QueryFilter(request,"item"));
		return new ModelAndView("/loan/front/tprojectRisklist.jsp").addObject("list",list);
	}
	
	
	/**
	 * 跳编辑页面
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ RequestMapping( { "edit" } )
	@ Action( description = "编辑tmoneymove数据" )
	public ModelAndView edit( HttpServletRequest request ) throws Exception {
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "riskId" ) );
		TProjectRisk tprojectRisk = null;
		if ( pkId.longValue() != 0L ){
			tprojectRisk = (TProjectRisk) this.tprojectRiskService.getById( pkId );
			return new ModelAndView("/loan/front/tprojectRiskEdit.jsp").addObject( "tprojectRisk", tprojectRisk ).addObject( "riskId", pkId );
		}
		else {
			tprojectRisk = new TProjectRisk();
			return new ModelAndView("/loan/front/tprojectRiskAdd.jsp").addObject( "tprojectRisk", tprojectRisk ).addObject( "riskId", pkId );
		}
	}
	
	

	/**
	 * 删除操作
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@ RequestMapping( { "del" } )
	@ Action( description = "删除CmsSiteConfig数据" )
	public void del( HttpServletRequest request, HttpServletResponse response ) throws Exception {
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request );
		try {
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "riskId" );
			this.tprojectRiskService.delByIds( lAryId );
			message = new ResultMessage( 1, "删除数据成功" );
		}
		catch ( Exception e ) {
			message = new ResultMessage( 0, "删除数据失败" );
		}
		addMessage( message, request );
		response.sendRedirect( preUrl );
	}
	
	
}
