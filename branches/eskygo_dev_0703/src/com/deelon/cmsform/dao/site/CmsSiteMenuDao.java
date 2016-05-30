/*
 * Powered By [Allen]
 * Since 2013 - 2013
 */

package com.deelon.cmsform.dao.site;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.deelon.cmsform.model.site.CmsSiteMenu;
import com.deelon.core.db.BaseDao;
import com.deelon.core.page.PageBean;

@Repository
public class CmsSiteMenuDao extends BaseDao<CmsSiteMenu> {

	public Class getEntityClass() {
		return CmsSiteMenu.class;
	}

	public List<CmsSiteMenu> getBySystemId(long systemId) {
		return getBySqlKey("getBySystemId", Long.valueOf(systemId));
	}

	public List getSubMenuByParentId(Integer number, Long id) {
		Map params = new HashMap();
		params.put("id", id);
		params.put("orderField","content_sort");
		params.put("orderSeq","asc");
		params.put("menuContentTemplet", "1"); // 首页是否显示，‘1’为仅显示设置为首页显示的菜单，‘0’为不显示
		PageBean pb=new PageBean();
		if(number > 0){
			pb.setPagesize(number);
		}
		return getList("getSubMenuByParentId", params, pb);
		//return getBySqlKey("getSubMenuByParentId", params);
	}

	public List getSubMenuByParentMenuPath(String ifShow, String parentMenuPath) {
		Map params = new HashMap();
		if (ifShow != null && "true".equals(ifShow)) {
			params.put("menuContentTemplet", "1"); // 首页是否显示，‘1’为仅显示设置为首页显示的菜单，‘0’为不显示
		}
		params.put("menuPath", parentMenuPath);
		// PageBean pb=new PageBean();
		// pb.setPagesize(2);
		// return getList("getSubMenuByParentMenuPath", params, pb);
		return getBySqlKey("getSubMenuByParentMenuPath", params);
	}
	public List<CmsSiteMenu> getMenuPath(String menupath){
		Map params = new HashMap(); 
		params.put("menu_path", menupath);
		List<CmsSiteMenu> cmsSiteMenu=getBySqlKey("menu_path",params);
		return cmsSiteMenu;
	}
	
	/**
	 * 根据栏目名称查询
	 * @param menuName
	 * @return
	 */
	public CmsSiteMenu checkIsExist(String menuName){
		return getUnique("checkIsExist", menuName);
	}
}
