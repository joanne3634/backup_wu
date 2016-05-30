package com.deelon.loan.service.front;

/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */




import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.loan.dao.front.TareaDao;
import com.deelon.loan.model.front.Tarea;


@ Service
public class TareaService extends BaseService<Tarea>{

	@ Resource
	private TareaDao tareaDao;
	
	protected IEntityDao<Tarea, Long> getEntityDao()
	{
		return this.tareaDao;
	}
	
	//根据父类parentId获取   1=省   2=市   3=区,县
	public List<Tarea> getbyParentId(long parentId){
		return tareaDao.getbyParentId(parentId);
	}
	
	/**
	 * 获取系统推荐的城市
	 * @return
	 */
	public List<Tarea> getRecommendTheCitys(){
		return tareaDao.getRecommendTheCitys();
	}
	
	/**
	 * 获取满足条件的系统推荐城市
	 * @return
	 */
	public List<Tarea> getRecommendCitysByMap(Map<String, Object> map){
		return tareaDao.getRecommendCitysByMap(map);
	}

}