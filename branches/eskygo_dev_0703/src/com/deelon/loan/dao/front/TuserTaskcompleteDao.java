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
import com.deelon.loan.model.front.TuserTaskcomplete;




@Repository
public class TuserTaskcompleteDao extends  BaseDao<TuserTaskcomplete>{
	
	public Class getEntityClass()
	 {
	     return TuserTaskcomplete.class;
	 }
	
	public TuserTaskcomplete gettuserTaskcomplete(long userId,long taskId){
		Map map = new HashMap();
		map.put("userId", userId);
		map.put("taskId", taskId);
		
		List list = getBySqlKey("getAll",map);
		
		if(list.size() >0){
			return (TuserTaskcomplete) list.get(0);
		}
		
		return null;
		
	}
}
