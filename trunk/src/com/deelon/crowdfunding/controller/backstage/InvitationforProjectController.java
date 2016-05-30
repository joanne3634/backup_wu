package com.deelon.crowdfunding.controller.backstage;

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
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.model.backstage.Tcproject;
import com.deelon.crowdfunding.model.backstage.TcprojectComments;
import com.deelon.crowdfunding.model.backstage.TcprojectInvest;
import com.deelon.crowdfunding.service.backstage.TcprojectCommentsService;
import com.deelon.crowdfunding.service.backstage.TcprojectInvestService;
import com.deelon.crowdfunding.service.backstage.TcprojectService;

/**
 * 招标中的项目
 * @author pyg
 *
 */
@Controller
@RequestMapping( { "/crowdfunding/backstage/invitationforProject/" } )
public class InvitationforProjectController extends BaseController {
	@Resource
	private TcprojectService tcprojectService;
	@Resource
	private TcprojectCommentsService tcprojectCommentsService;
	@Resource
	private TcprojectInvestService tcprojectInvestService;
	@RequestMapping( { "list" } )
	@Action( description = "查看招标中项目的分页列表" )
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception{ 
		List<Tcproject> list = tcprojectService.getInvitationforPro(new QueryFilter(request, "projectId"));
		
		ModelAndView mv = getAutoView().addObject("tprojectList", list );
		return mv;
	}
	
	@RequestMapping( { "edit" } )
	@Action( description = "编辑Tproject数据"  )
	public ModelAndView edit( HttpServletRequest request ) throws Exception{
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "projectId" ) );
		Tcproject tproject = null;
		List<TcprojectInvest> listI=null;
		List<TcprojectComments> listc=null;
		if ( pkId.longValue() != 0L ){
				tproject = (Tcproject) this.tcprojectService.getTcprojectById( pkId );
				Map<String,Object> map=new HashMap<String,Object>();
	    		map.put("projectId", pkId);
			//	invest.put("userId", userId);
	    		map.put("piisPay",0);
	    		map.put("isCancel", 0);
			 listI=tcprojectInvestService.getInvestforPro(map,null);//查询项目下的所有投资,且是未付款的
			 if(listI!=null&&listI.size()>0){
				 SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
				 for (TcprojectInvest t : listI) {
					 if(t.getPiinvestTime()!=null)
						 t.setPiinvestTimeS(sdf.format(t.getPiinvestTime()));
					 if(t.getPiinvest()!=null){
						 t.setPiinvest(t.getPiinvest().setScale(2, BigDecimal.ROUND_HALF_UP));
					 }
				}
			 }
			 Map<String,Object> map1=new HashMap<String,Object>();
	    		map1.put("projectId", pkId);
			 listc=tcprojectCommentsService.getTcprojectCommentsByProId(map1,null);
		}
		return getAutoView().addObject( "listI", listI ).addObject( "listc", listc ).addObject( "tcproject", tproject );
	}
}
