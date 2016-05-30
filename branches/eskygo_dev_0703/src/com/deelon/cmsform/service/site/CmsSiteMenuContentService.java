/*
 * Powered By [Allen]
 * Since 2013 - 2013
 */

package com.deelon.cmsform.service.site;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.cmsform.dao.site.CmsSiteMenuContentDao;
import com.deelon.cmsform.dao.site.CmsSiteMenuDao; 
import com.deelon.cmsform.model.site.CmsSiteMenu;
import com.deelon.cmsform.model.site.CmsSiteMenuContent; 
import com.deelon.core.db.IEntityDao;
import com.deelon.core.page.PageBean;
import com.deelon.core.service.BaseService;
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.query.QueryFilter;
import com.fr.report.core.A.q;

@Service
public class CmsSiteMenuContentService extends BaseService<CmsSiteMenuContent> {

	@Resource
	private CmsSiteMenuContentDao cmsSiteMenuContentDao;

	@Resource
	private CmsSiteMenuDao cmsSiteMenuDao;
	 

	protected IEntityDao<CmsSiteMenuContent, Long> getEntityDao() {
		return this.cmsSiteMenuContentDao;
	}

	public List<CmsSiteMenuContent> getAllSubContentByParentMenuId(Long menuId,Integer showNum,PageBean pb) {

		List<Long> menuIdList = new ArrayList();
		List newList = new ArrayList();
		menuIdList = cc(menuId, menuIdList);
		menuIdList.add(menuId);
		if (menuIdList != null && menuIdList.size() > 0) {

//			Set set = new HashSet();
//			for (Iterator iter = menuIdList.iterator(); iter.hasNext();) {
//				Object element = iter.next();
//				if (set.add(element))
//					newList.add(element);
//			}
//			menuIdList = newList;
			QueryFilter qf = new  QueryFilter();
			qf.addFilter("menuIdList", menuIdList);
			qf.addFilter("contentNoticeType","1");
			qf.addFilter("contentIfPublish","1");		//是否发布
//			if(showNum > 0){
//				PageBean pb = new PageBean();
//				pb.setPagesize(showNum);
//				qf.setPageBean(pb);
//			}
			if(pb != null){   
				qf.setPageBean(pb); 
			}
			return this.cmsSiteMenuContentDao.getAll(qf);
		} else {
			return null;
		}
	}

	public List<Long> cc(Long menuId, List<Long> menuIdList) {
		// List<Long> menuIdList = new ArrayList();

		CmsSiteMenuDao cmsSiteMenuDao = (CmsSiteMenuDao) AppUtil
				.getBean(CmsSiteMenuDao.class);
		List cmssiteMenuList = (List) cmsSiteMenuDao.getSubMenuByParentId(0,
				menuId);
		if (cmssiteMenuList != null && cmssiteMenuList.size() > 0) {
			for (int i = 0; i < cmssiteMenuList.size(); i++) {
				CmsSiteMenu csm = (CmsSiteMenu) cmssiteMenuList.get(i);
				if (csm != null && csm.getSiteMenuId() > 0&&!"GPQGG".equals( csm.getMenuPath() )) {
					menuIdList.add(csm.getSiteMenuId());
					cc(csm.getSiteMenuId(), menuIdList);
				}
			}
		}
		return menuIdList;
	}
	public List<CmsSiteMenuContent> getBySearch(String title){
		return this.cmsSiteMenuContentDao.getBySearch(title);
	}
	
	public List<CmsSiteMenuContent> getMenuId(String menupath){
		return this.cmsSiteMenuContentDao.getMenuId(menupath);
	}
	
	public List<CmsSiteMenuContent> getMenu_Id(QueryFilter filter){
		return this.cmsSiteMenuContentDao.getMenu_Id(filter);
	}
	
	public List<CmsSiteMenuContent> getContentTitle(String menupath,String contenttitle){
		return this.cmsSiteMenuContentDao.getContentTitle(menupath, contenttitle);
	}

}