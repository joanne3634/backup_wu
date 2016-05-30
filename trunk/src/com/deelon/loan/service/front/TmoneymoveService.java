/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.service.front;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.page.PageBean;
import com.deelon.core.service.BaseService;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.dao.front.TmoneymoveDao;
import com.deelon.loan.model.front.TMoneymove;

@ Service
public class TmoneymoveService extends BaseService<TMoneymove>{
	
	@ Resource
	private TmoneymoveDao tmoneymoveDao;
	
	protected IEntityDao<TMoneymove, Long> getEntityDao()
	{
		return this.tmoneymoveDao;
	}
	
	/**
	 * 保存或更新
	 * @param tmoneymove
	 * @return
	 */
	public int saveOrUpdateTMoneymove(TMoneymove tmoneymove){
		return tmoneymoveDao.saveOrUpdateTMoneymove(tmoneymove);
	}
	
	/**
	 * 分页,查询用户的资金流动记录 
	 * @param map 参数容器
	 * @param pb 分页
	 * @param 
	 * @return
	 */
	public List<TMoneymove> getAllDataOfUser(Map<String,Object> map,PageBean pb){
		return tmoneymoveDao.getAllDataOfUser(map,pb);
	}
	
	/**
	 * 分页,查询用户的资金流动记录 
	 * @param map 参数容器
	 * @param pb 分页
	 * @param 
	 * @return
	 */
	public List<TMoneymove> getUserMoneyList(Map<String,Object> map,PageBean pb){
		return tmoneymoveDao.getUserMoneyList(map,pb);
	}
	
	/**
	 * 获取用户的所有交易数据
	 * @return
	 */
	public List<TMoneymove> getAllData(TMoneymove tmoneymove){
		return tmoneymoveDao.getAllData(tmoneymove);
	}
	
	/**
	 * 用户资金审核
	 * @return
	 */
	public int updateAudit(TMoneymove tmoneymove){
		int i = tmoneymoveDao.updateAudit(tmoneymove);
		return i;
	}

	public TMoneymove getByIdFlowCode(String flowCode) {
		// TODO Auto-generated method stub
		return tmoneymoveDao.getByIdFlowCode(flowCode);
	}
	/**
	 * 根据流水号获取所有资金流动信息
	 * @param flowCode
	 * @return
	 */
	public List<TMoneymove> getListByIdFlowCode(String flowCode) {
		// TODO Auto-generated method stub
		return tmoneymoveDao.getListByIdFlowCode(flowCode);
	}
	
	/**
	 * 根据 projectId,remark ,resultId 查询
	 * @param map
	 * @return
	 */
	public List<TMoneymove> getListByMap(Map<String,Object> map){
		return tmoneymoveDao.getListByMap(map);
	}
	
	/**
	 * 根据 projectId,remark ,resultId 查询
	 * @param map
	 * @return
	 */
	public List<TMoneymove> getListByMap(QueryFilter queryFilter){
		return tmoneymoveDao.getListByMap(queryFilter);
	}

	public List<TMoneymove> getChargeMoneyList(QueryFilter queryFilter) { 
		return tmoneymoveDao.getChargeMoneyList(queryFilter);
	}
	
	/**
	 * proid 
	 * userid
	 * resultType 
	 * @param map
	 * @return
	 */
	public TMoneymove getByProIdAndUserId(Map<String,Object> map){
		return tmoneymoveDao.getByProIdAndUserId(map);
	}

}