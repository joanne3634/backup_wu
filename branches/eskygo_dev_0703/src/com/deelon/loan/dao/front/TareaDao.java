package com.deelon.loan.dao.front;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.front.Tarea;





@Repository
public class TareaDao extends  BaseDao<Tarea>{
	
	public Class getEntityClass()
	 {
	     return Tarea.class;
	 }
	
	//根据父类parentId获取   1=省   2=市   3=区,县
	public List<Tarea> getbyParentId(long parentId){
		Map map = new HashMap();
		map.put("parentId", parentId);
		
		return getListBySqlKey("getbyParentId", map);
		
	}
	
	/**
	 * 获取系统推荐的城市
	 * @return
	 */
	public List<Tarea> getRecommendTheCitys(){
		return getBySqlKey("getbyParentId");
	}
	
	/**
	 * 获取满足条件的城市
	 * @return
	 */
	public List<Tarea> getRecommendCitysByMap(Map map){
		return getBySqlKey("getRecommendCitysByMap", map);
	}

	public List<Tarea> getByAreaIds(List<Long> ids) {
		// TODO Auto-generated method stub
		return getBySqlKey("getByAreaIds", ids);
	}

}
