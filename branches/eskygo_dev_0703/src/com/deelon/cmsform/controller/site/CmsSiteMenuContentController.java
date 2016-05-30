/*
 * Powered By [Allen]
 * Since 2013 - 2013
 */


package com.deelon.cmsform.controller.site;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.platform.model.system.Demension;
import com.deelon.platform.service.system.DemensionService;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.cmsform.model.site.CmsSiteMenu;
import com.deelon.cmsform.model.site.CmsSiteMenuContent;
import com.deelon.cmsform.service.site.CmsSiteMenuContentService;
import com.deelon.cmsform.service.site.CmsSiteMenuService;

@ Controller
@ RequestMapping( { "/cmsform/site/cmssitemenucontent/" } )
public class CmsSiteMenuContentController extends BaseController{
	
	@ Resource
	private CmsSiteMenuContentService cmsSiteMenuContentService;
	
	@ Resource
	private CmsSiteMenuService cmsSiteMenuService;
	
	@ RequestMapping( { "list" } )
	@ Action( description = "查看CmsSiteMenuContent分页列表" )
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		String siteConfigId=RequestUtil.getString( request, "siteConfigId" );
		String siteMenuId=RequestUtil.getString( request, "siteMenuId" );
		String menuSupId=RequestUtil.getString( request, "menuSupId" );
		List list = this.cmsSiteMenuContentService.getAll(new QueryFilter(request, "cmsSiteMenuContentItem"));
		ModelAndView mv = getAutoView().addObject( "cmsSiteMenuContentList", list ).addObject( "siteConfigId", "siteConfigId" ).addObject( "siteMenuId",siteMenuId ).addObject( "menuSupId", menuSupId );
		
		String menuPath=RequestUtil.getString( request,"menuPath");
		String menuUrl=RequestUtil.getString( request,"menuUrl");
		System.out.println("-->"+menuPath+"-->"+menuUrl);
		if(!menuUrl.equals(null)&&!menuUrl.equals("")){
			response.sendRedirect(request.getContextPath()+menuUrl );
		}
		return mv;
	}
	@ RequestMapping( { "tree" } )
	@ Action( description = "查看CmsSiteMenuContent树列表")
	public ModelAndView tree( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		return getAutoView();
	}
	@ RequestMapping( { "del" } )
	@ Action( description = "删除CmsSiteMenuContent数据" )
	public void del( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request ); 
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "siteMenuContentId" );
			CmsSiteMenuContent cmsSiteMenuContent=this.cmsSiteMenuContentService.getById(lAryId[0]); 
			CmsSiteMenu cmsSiteMenu=this.cmsSiteMenuService.getById(cmsSiteMenuContent.getSiteMenuId()); 
			//判断广告大图的条数 ，少于2张将不能删除并提示不能少于2张
			if(cmsSiteMenu.getMenuPath().equals("SYGGDT")){
				List<CmsSiteMenuContent> cmsSiteMenuContents=this.cmsSiteMenuContentService.getMenuId("SYGGDT");
				int cmssize=cmsSiteMenuContents.size()-lAryId.length; 
				if(cmssize<2){
					message = new ResultMessage( 2, "广告大图发布的图片不能少于2张" );
				}else{
					this.cmsSiteMenuContentService.delByIds( lAryId );
					message = new ResultMessage( 1, "删除数据成功" );
				}
			} else{
				this.cmsSiteMenuContentService.delByIds( lAryId );
				message = new ResultMessage( 1, "删除数据成功" );
			}
		}
		catch ( Exception e )
		{
			message = new ResultMessage( 0, "删除数据失败" );
		}
		addMessage( message, request );
		response.sendRedirect( preUrl );
	}

	@ RequestMapping( { "edit" } )
	@ Action( description = "编辑CmsSiteMenuContent数据")
	public ModelAndView edit( HttpServletRequest request ) throws Exception
	{
		String siteConfigId=RequestUtil.getString( request, "siteConfigId" ); 
		String siteMenuId=RequestUtil.getString( request, "siteMenuId" );
		String menuSupId=RequestUtil.getString( request, "menuSupId" );
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "siteMenuContentId" ) );
		CmsSiteMenuContent cmsSiteMenuContent = null;
		if ( pkId.longValue() != 0L )
			cmsSiteMenuContent = (CmsSiteMenuContent) this.cmsSiteMenuContentService.getById( pkId );
		else
		{
			cmsSiteMenuContent = new CmsSiteMenuContent();
		}
		
		ModelAndView mv=getAutoView().addObject( "cmsSiteMenuContent", cmsSiteMenuContent ).addObject( "siteConfigId", siteConfigId ).addObject( "siteMenuId", siteMenuId );
		if(!StringUtil.isEmpty( siteMenuId )){
			QueryFilter queryFilter=new QueryFilter();
			queryFilter.addFilter( "id", siteMenuId );
			List l=cmsSiteMenuContentService.getBySqlKeyAll( queryFilter,  CmsSiteMenu.class, "getById" );
			if(l!=null&&l.size()>0){
				mv.addObject( "cmsSiteMenu", (CmsSiteMenu)l.get( 0 ) );
			}
		}
		
		return mv;
	}

	@ RequestMapping( { "get" } )
	@ Action( description = "查看CmsSiteMenuContent数据")
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "siteMenuContentId" );
		CmsSiteMenuContent cmsSiteMenuContent = (CmsSiteMenuContent) this.cmsSiteMenuContentService.getById( Long.valueOf( pkId ) );
		return getAutoView().addObject( "cmsSiteMenuContent", cmsSiteMenuContent );
	}
	
	@ RequestMapping( { "publish" } )
	@ Action( description = "发布CmsSiteMenuContent数据" )
	public void publish( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request );
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "siteMenuContentId" );
			for(int i = 0;i<lAryId.length;i++){
				CmsSiteMenuContent csmc = this.cmsSiteMenuContentService.getById(lAryId[i]);
				if(csmc != null){
					csmc.setContentIfPublish(1);
					Calendar c = Calendar.getInstance();
	                long now = c.getTime().getTime();
	                Timestamp t = new Timestamp(now);
					csmc.setContentUpdateDate(t);
					if(csmc.getContentCreateDate() == null){
						csmc.setContentCreateDate(t);
					}
					this.cmsSiteMenuContentService.update(csmc);
					message = new ResultMessage( 1, "发布成功" );
				}
			}
			
		}
		catch ( Exception e )
		{
			message = new ResultMessage( 0, "发布失败" );
		}
		addMessage( message, request );
		response.sendRedirect( preUrl );
	}
}

