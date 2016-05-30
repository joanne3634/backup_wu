/*
 * Powered By [Allen]
 * Since 2013 - 2013
 */

package com.deelon.cmsform.service.site;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.cmsform.dao.site.CmsSiteMenuContentDao;
import com.deelon.cmsform.dao.site.CmsSiteMenuDao;
import com.deelon.cmsform.model.site.CmsSiteMenu;
import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.platform.dao.system.SubSystemDao;

@Service
public class CmsSiteMenuService extends BaseService<CmsSiteMenu> {

	@Resource
	private CmsSiteMenuDao cmsSiteMenuDao;

	@Resource
	private SubSystemDao subSystemDao;
	

	@Resource
	private CmsSiteMenuContentDao cmsSiteMenuContentDao;

	protected IEntityDao<CmsSiteMenu, Long> getEntityDao() {
		return this.cmsSiteMenuDao;
	}



	public CmsSiteMenu getParentMenuByParentId(long systemId, long parentId,
			String ctx) {
		CmsSiteMenu parent = (CmsSiteMenu) this.cmsSiteMenuDao.getById(Long
				.valueOf(parentId));
		return parent;
	}

	public List<CmsSiteMenu> getSubMenuByParentId(Integer number, Long parentId) {
		return (List<CmsSiteMenu>) this.cmsSiteMenuDao.getSubMenuByParentId(
				number, parentId);
	}

	public List getAllMenu(CmsSiteMenu cmsSiteMenu, String type) {
		// TODO Auto-generated method stub
		List listAll = this.cmsSiteMenuDao.getAll();
		CmsSiteMenu wm = getRoot(listAll, cmsSiteMenu);
		List l = new ArrayList();
		getAllTreeMenu(listAll, wm, type, l);
		return l;
	}

	public List getAllTreeMenu(List listAll, CmsSiteMenu cmsSiteMenu,
			String type, List l) {

		for (int i = 0; i < listAll.size(); i++) {
			CmsSiteMenu wm = (CmsSiteMenu) listAll.get(i);
			if ("1".equals(type)) {// 找下级
				if (cmsSiteMenu != null
						&& wm != null
						&& cmsSiteMenu.getSiteMenuId()
								.equals(wm.getMenuSupId())) {
					l.add(wm);
					getAllTreeMenu(listAll, wm, type, l);
				}
			} else if ("2".equals(type)) {// 找上级
				if (cmsSiteMenu != null
						&& wm != null
						&& cmsSiteMenu.getMenuSupId()
								.equals(wm.getSiteMenuId())) {
					l.add(wm);
					getAllTreeMenu(listAll, wm, type, l);
				}
			}
		}
		return l;
	}

	public CmsSiteMenu getRoot(List listAll, CmsSiteMenu cmsSiteMenu) {
		for (Iterator iterator = listAll.iterator(); iterator.hasNext();) {
			CmsSiteMenu wmu = (CmsSiteMenu) iterator.next();
			if (!"".equals(cmsSiteMenu.getMenuPath())) {
				if (cmsSiteMenu.getMenuPath().equals(wmu.getMenuPath())) {
					return wmu;
				}
			}
			if (!"".equals(cmsSiteMenu.getSiteMenuId())) {
				if (cmsSiteMenu.getSiteMenuId().equals(wmu.getSiteMenuId())) {
					return wmu;
				}
			}

		}
		return null;
	}

	public List<CmsSiteMenu> getSubMenuByParentMenuPath(String ifShow,
			String parentMenuPath) {
		return (List<CmsSiteMenu>) this.cmsSiteMenuDao
				.getSubMenuByParentMenuPath(ifShow, parentMenuPath);
	}

	public CmsSiteMenu getRootCmsSiteMenu(Long menuId){
		CmsSiteMenu newCSM=cmsSiteMenuDao.getById( menuId );   
		if(newCSM.getMenuSupId()==0L){
			return newCSM;
		}else{
			newCSM=cmsSiteMenuDao.getById( newCSM.getMenuSupId() ); 
			if(newCSM.getMenuSupId()==0L){
				return newCSM;
			}else{
				newCSM=cmsSiteMenuDao.getById( newCSM.getMenuSupId() ); 
				if(newCSM.getMenuSupId()==0L){
					return newCSM;
				}else{
					newCSM=cmsSiteMenuDao.getById( newCSM.getMenuSupId() ); 
					if(newCSM.getMenuSupId()==0L){
						return newCSM;
					}else{
						newCSM=cmsSiteMenuDao.getById( newCSM.getMenuSupId() ); 					
					}
				}
			}
		} 
		return newCSM;
	}

	public CmsSiteMenu getTopCmsSiteMenuByMenuIdRooT(Long menuId,CmsSiteMenu csmR) {
System.out.println(menuId+"---------------");
		CmsSiteMenu csm1 =null;  
		csm1=	this.cmsSiteMenuDao.getById(menuId);  
		if (csm1 != null && csm1.getMenuSupId() > 0L) {
			System.out.println(menuId+"*******************");
			getTopCmsSiteMenuByMenuIdRooT(csm1.getMenuSupId(),csmR);
		} 
		if (csm1.getMenuSupId() == 0L) { 
			csmR=csm1;
			return csmR;
		}
		System.out.println(menuId+"+++++++++++++");
		return csmR;
		
	}
	public CmsSiteMenu getTopCmsSiteMenuByMenuId(Long menuId) {
		CmsSiteMenu csmR = new CmsSiteMenu();
		CmsSiteMenu csm = this.cmsSiteMenuDao.getById(menuId); 
		if (csm != null && csm.getMenuSupId() >= 0L) {
			if (csm.getMenuSupId() == 0L) { 
				csmR =  csm;
			}else{
				csmR = getTopCmsSiteMenuByMenuId(csm.getMenuSupId());
			}
		}
		return csmR;
	}
	
	public List<String> getAllMenuPathForMenuTree(List<String> menuPathList,CmsSiteMenu csm){
		if(csm != null && csm.getMenuSupId() != null && !"".equals(csm.getMenuSupId()) && !"undefined".equals(csm.getMenuSupId())){
			CmsSiteMenu csmTemp = this.cmsSiteMenuDao.getById(csm.getMenuSupId());
			if(csmTemp != null && csmTemp.getMenuPath() != null && !"".equals(csmTemp.getMenuPath()) && !"undefined".equals(csmTemp.getMenuPath())){
				menuPathList.add(csmTemp.getMenuPath());
				getAllMenuPathForMenuTree(menuPathList,csmTemp);
			}
		}
		return menuPathList;
	}
	public List<CmsSiteMenu> getMenuPath(String menupath){
		return this.cmsSiteMenuDao.getMenuPath(menupath); 
	}
	
	/**
	 * 根据栏目名称查询
	 * @param menuName
	 * @return
	 */
	public CmsSiteMenu checkIsExist(String menuName){
		return this.cmsSiteMenuDao.checkIsExist(menuName);
	}
}