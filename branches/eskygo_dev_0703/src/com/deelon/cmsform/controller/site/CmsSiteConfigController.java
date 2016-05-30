/*
 * Powered By [Allen]
 * Since 2013 - 2013
 */

package com.deelon.cmsform.controller.site;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.cmsform.model.site.CmsSiteConfig;
import com.deelon.cmsform.service.site.CmsSiteConfigService;
import com.deelon.core.annotion.Action;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;

@ Controller
// 把本类变成一个handler
@ RequestMapping( { "/cmsform/site/cmssiteconfig/" } )
// 指定控制器映射url
public class CmsSiteConfigController extends BaseController {

	@ Resource
	private CmsSiteConfigService cmsSiteConfigService;

	@ RequestMapping( { "list" } )
	// 处理方法url 与控制器url对应 等于/cmsform/site/cmssiteconfig/list url
	@ Action( description = "查看站点分页列表" )
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception {
		List list = this.cmsSiteConfigService.getAll( new QueryFilter( request, "cmsSiteConfigItem" ) );
		ModelAndView mv = getAutoView().addObject( "cmsSiteConfigList", list );
		return mv; // 返回的逻辑视图名
	}

	@ RequestMapping( { "del" } )
	@ Action( description = "删除站点数据" )
	public void del( HttpServletRequest request, HttpServletResponse response ) throws Exception {
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request );
		try {
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "siteConfigId" );
			this.cmsSiteConfigService.delByIds( lAryId );
			message = new ResultMessage( 1, "删除数据成功" );
		}
		catch ( Exception e ) {
			message = new ResultMessage( 0, "删除数据失败" );
		}
		addMessage( message, request );
		response.sendRedirect( preUrl );
	}

	@ RequestMapping( { "edit" } )
	@ Action( description = "编辑站点数据" )
	public ModelAndView edit( HttpServletRequest request ) throws Exception {
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "siteConfigId" ) );
		CmsSiteConfig cmsSiteConfig = null;
		if ( pkId.longValue() != 0L )
			cmsSiteConfig = (CmsSiteConfig) this.cmsSiteConfigService.getById( pkId );
		else {
			cmsSiteConfig = new CmsSiteConfig();
		}
		return getAutoView().addObject( "cmsSiteConfig", cmsSiteConfig ).addObject( "siteConfigId", pkId );
	}

	@ RequestMapping( { "get" } )
	@ Action( description = "查看站点数据" )
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception {
		long pkId = RequestUtil.getLong( request, "siteConfigId" );
		CmsSiteConfig cmsSiteConfig = (CmsSiteConfig) this.cmsSiteConfigService.getById( Long.valueOf( pkId ) );
		return getAutoView().addObject( "cmsSiteConfig", cmsSiteConfig );
	}
}
