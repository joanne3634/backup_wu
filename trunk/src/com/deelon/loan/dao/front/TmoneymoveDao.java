/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.loan.dao.front;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.core.page.PageBean;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.model.front.TMoneymove;


@Repository
public class TmoneymoveDao extends  BaseDao<TMoneymove>{
	
	public Class getEntityClass()
	 {
	     return TMoneymove.class;
	 }
	
	public int saveOrUpdateTMoneymove(TMoneymove tmoneymove){
		if(tmoneymove.getMoneyMoveId()!=0){
			return update("update", tmoneymove);
		}else{
			return update("add", tmoneymove);
		}
	}
	
	public List<TMoneymove> getAllDataOfUser(Map<String,Object> map,PageBean pb){
		try {
			List<TMoneymove> list=getBySqlKey("getAll",map,pb);
			/*List<TMoneymove> listV=new ArrayList<TMoneymove>();
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
			if(list!=null&&list.size()>0){
				for (TMoneymove t : list) {
					if(t.getCreateTime()!=null){
						String c=sdf.format(t.getCreateTime());
						t.setCreateTimeS(c);
						listV.add(t);
					}
				}
			}
			return listV;*/
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * proid 
	 * userid
	 * resultType 
	 * @param map
	 * @return
	 */
	public TMoneymove getByProIdAndUserId(Map<String,Object> map){
		return getUnique("getAll",map);
	}
	
	
	public List<TMoneymove> getUserMoneyList(Map<String,Object> map,PageBean pb){
		return getBySqlKey("getUserMoneyList",map,pb);
	}

	public List<TMoneymove> getAllData(TMoneymove tmoneymove){
		return getBySqlKey("getAll", tmoneymove);
	}
	
	public int  updateAudit(TMoneymove tmoneymove){
		int i = update("updateAudit", tmoneymove);
		return i;
	}

	public TMoneymove getByIdFlowCode(String flowCode) {
		// TODO Auto-generated method stub
		List<TMoneymove> tmList=getBySqlKey("getByIdFlowCode", flowCode);
		if(tmList!=null&&tmList.size()>0){
			return tmList.get(0);
		}else{
		return  new TMoneymove();
		}
	}
	
	/**
	 * 根据流水号获取所有资金流动信息
	 * @param flowCode
	 * @return
	 */
	public List<TMoneymove> getListByIdFlowCode(String flowCode) {
		List<TMoneymove> tmList=getBySqlKey("getByIdFlowCode", flowCode);
		return tmList;
	}
	
	/**
	 * 根据 projectId,remark ,resultId 查询
	 * @param map
	 * @return
	 */
	public List<TMoneymove> getListByMap(Map<String,Object> map){
		List<TMoneymove> tmList=getBySqlKey("getListByMap", map);
		return tmList;
	}
	/**
	 * 根据 projectId,remark ,resultId 查询
	 * @param map
	 * @return
	 */
	public List<TMoneymove> getListByMap(QueryFilter queryFilter){
		List<TMoneymove> tmList=getBySqlKey("getListByMap", queryFilter);
		return tmList;
	}

	public List<TMoneymove> getChargeMoneyList(QueryFilter queryFilter) {
		return getBySqlKey("getChargeMoneyList",queryFilter);
	}
	
	public TMoneymove getByProIdAndUserIdAnd(Map<String,Object> map){
		return getUnique("getByProIdAndUserIdAnd",map);
	}
}
