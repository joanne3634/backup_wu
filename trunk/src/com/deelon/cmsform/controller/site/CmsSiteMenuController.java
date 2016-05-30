/*
 * Powered By [Allen]
 * Since 2013 - 2013
 */

package com.deelon.cmsform.controller.site;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.cmsform.model.site.CmsSiteConfig;
import com.deelon.cmsform.model.site.CmsSiteMenu;
import com.deelon.cmsform.service.site.CmsSiteConfigService;
import com.deelon.cmsform.service.site.CmsSiteMenuService;
import com.deelon.core.annotion.Action;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.FileUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.servlet.ValidCode;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.platform.model.system.SysRole;

@ Controller
@ RequestMapping( { "/cmsform/site/cmssitemenu/" } )
public class CmsSiteMenuController extends BaseController
{

	@ Resource
	private CmsSiteMenuService cmsSiteMenuService;
	@ Resource
	private CmsSiteConfigService cmsSiteConfigService;

	@ RequestMapping( { "list" } )
	@ Action( description = "查看CmsSiteMenu分页列表")
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		List list = this.cmsSiteMenuService.getAll( new QueryFilter( request, "cmsSiteMenuItem" ) );
		ModelAndView mv = getAutoView().addObject( "cmsSiteMenuList", list );
		return mv;
	}

	@ RequestMapping( { "tree" } )
	@ Action( description = "查看CmsSiteMenu树列表" )
	public ModelAndView tree( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		return getAutoView();
	}

	@ RequestMapping( { "treeFile" } )
	@ Action( description = "查看文件模板树列表")
	public ModelAndView treeFile( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{		
		return getAutoView();
	}

	@ RequestMapping( { "getSiteMenuTreeFile" } )
	@ ResponseBody
	public Object getSiteMenuTreeFile( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{	
		Long siteConfigId=RequestUtil.getLong( request, "siteConfigId" ) ;
		CmsSiteConfig cmsSiteConfig=cmsSiteConfigService.getById( siteConfigId );
		String[] extName=null;
		if(StringUtil.isNotEmpty( cmsSiteConfig.getSiteMeta())){
			extName=cmsSiteConfig.getSiteMeta().split( "," );
		}
		String folderUrl =cmsSiteConfig.getSiteDirPath();
		folderUrl=folderUrl+cmsSiteConfig.getSiteCode()+"\\"+cmsSiteConfig.getSiteTemplet()+"\\";

		return null;
	}

	@ RequestMapping( { "getSiteMenuTree" } )
	@ ResponseBody
	public Object getSiteMenuTree( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{   
		String siteConfigId = RequestUtil.getString( request, "siteConfigId" );
		QueryFilter qf = new QueryFilter( request, false );
		List<Long> curUserRole = new ArrayList();
		if(curUserRole != null && curUserRole.size() > 0){
			qf.addFilter( "siteUserRolesId", curUserRole );
		}
		qf.addFilter( "siteConfigId", siteConfigId );
		return cmsSiteMenuService.getAll( qf );
	}

	@ RequestMapping( { "del" } )
	@ Action( description = "删除CmsSiteMenu数据")
	public void del( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request );
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "siteMenuId" );
			this.cmsSiteMenuService.delByIds( lAryId );
			message = new ResultMessage( 1, "删除数据成功" );
		}
		catch ( Exception e )
		{
			message = new ResultMessage( 0, "删除数据失败" );
		}
		addMessage( message, request );
		response.sendRedirect( preUrl );
	}

	@ RequestMapping( { "edit" } )
	@ Action( description = "编辑CmsSiteMenu数据")
	public ModelAndView edit( HttpServletRequest request ) throws Exception
	{
		Long menuSupId;
		Long siteConfigId;
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "siteMenuId", 0L ) );
		CmsSiteMenu cmsSiteMenu = null;
		if ( pkId.longValue() != 0L )
		{
			cmsSiteMenu = (CmsSiteMenu) this.cmsSiteMenuService.getById( pkId );
			menuSupId = cmsSiteMenu.getMenuSupId();
			siteConfigId = cmsSiteMenu.getSiteConfigId();
		}
		else
		{
			menuSupId = Long.valueOf( RequestUtil.getLong( request, "menuSupId" ) );
			siteConfigId = Long.valueOf( RequestUtil.getLong( request, "siteConfigId" ) );
			cmsSiteMenu = new CmsSiteMenu();
		}
		return getAutoView().addObject( "cmsSiteMenu", cmsSiteMenu ).addObject( "siteMenuId", pkId )
				.addObject( "menuSupId", menuSupId ).addObject( "siteConfigId", siteConfigId );
	}
	
	@ RequestMapping( { "editfile" } )
	@ Action( description = "查看物理文件数据" )
	public ModelAndView editfile( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		 String path=RequestUtil.getStringEnc( request, "path");
		 String title=RequestUtil.getStringEnc( request, "title"); 
		return getAutoView().addObject( "path", path ).addObject( "title", title );
	}
	@ RequestMapping( { "saveFile" } )
	@ Action( description = "保存物理文件数据" )
	public void saveFile( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{   
		 String path=RequestUtil.getStringEnc( request, "path");
		 String text=RequestUtil.getStringEnc( request, "text");  
		 try{
		 FileUtil.writeFile( path, text ) ;
		 writeResultMessage(response.getWriter(), "数据保存成功!", 1);
		 }catch(Exception e){
	      writeResultMessage(response.getWriter(), e.getMessage(), 0);
		 }
	     
	}
	@ RequestMapping( { "get" } )
	@ Action( description = "查看CmsSiteMenu数据" )
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "siteMenuId" );
		CmsSiteMenu cmsSiteMenu = (CmsSiteMenu) this.cmsSiteMenuService.getById( Long.valueOf( pkId ) );
		return getAutoView().addObject( "cmsSiteMenu", cmsSiteMenu );
	}
	
	@ RequestMapping( { "getSysRolMenuTreeChecked" } )
	@ ResponseBody
	public List<CmsSiteMenu> getSysRolMenuTreeChecked( HttpServletRequest request, HttpServletResponse response )
			throws Exception
	{
		long systemId = RequestUtil.getLong( request, "systemId", 0L );
		long roleId = RequestUtil.getLong( request, "roleId", 0L );

		

		CmsSiteMenu parent = this.cmsSiteMenuService.getParentMenuByParentId( systemId, 0L, request.getContextPath() );
		if(parent != null){
			//resourcesList.add( parent );
		}

		return null;
	}
	
	@RequestMapping({"checkIsExist"})
	public void checkIsExist(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String menuName = request.getParameter("menuName");
		
		boolean tag = false;
		CmsSiteMenu cm = cmsSiteMenuService.checkIsExist(menuName);
		if(cm!=null){
			tag = true;//已存在
		}else{
			tag = false;
		}
      
		PrintWriter out = response.getWriter();
		if(tag) {
			out.print("true");
		}else{
			out.print("false");
		}
	}
	
	
}
