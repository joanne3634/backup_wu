/*
 * Powered By [Allen]
 * Since 2013 - 2013
 */

package com.deelon.cmsform.dao.site;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.core.page.PageBean;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.cmsform.model.site.CmsSiteMenuContent;



@Repository
public class CmsSiteMenuContentDao extends  BaseDao<CmsSiteMenuContent>{
	
	public Class getEntityClass()
	 {
	     return CmsSiteMenuContent.class;
	 }
	public List<CmsSiteMenuContent> getBySearch(String title){
		Map params = new HashMap();
		params.put("id", title);
		List<CmsSiteMenuContent> cmsSiteMenuContent=new java.util.ArrayList<CmsSiteMenuContent>();
		cmsSiteMenuContent = getBySqlKey("getBySearch", params);
		return cmsSiteMenuContent;
	}
	public List<CmsSiteMenuContent> getMenuId(String menupath){
		Map params = new HashMap(); 
		params.put("menu_path", menupath);
		List<CmsSiteMenuContent> cmsSiteMenuContent =getBySqlKey("getMenuid",params);
		return cmsSiteMenuContent;
	}
	public List<CmsSiteMenuContent> getMenu_Id(QueryFilter filter){
//		Map params = new HashMap(); 
//		params.put("menu_path", menupath);
		List<CmsSiteMenuContent> cmsSiteMenuContent =getBySqlKey("getMenuid",filter);
		return cmsSiteMenuContent;
	}
	public List<CmsSiteMenuContent> getContentTitle(String menupath,String contenttitle){
		Map params = new HashMap();  
		params.put("menu_path", menupath);
		params.put("content_title", contenttitle); 
		List<CmsSiteMenuContent> cmsSiteMenuContent =getBySqlKey("getContentTitle",params);
		return cmsSiteMenuContent;
	}
}
