/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.loan.service.sysManager;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.core.util.DateUtil;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.crowdfunding.model.backstage.TcprojectInvest;
import com.deelon.loan.dao.front.TProjectInvestDao;
import com.deelon.loan.dao.sysManager.TattentionDao;
import com.deelon.loan.dao.sysManager.TprojectDao;
import com.deelon.loan.dao.sysManager.TuserFundsDao;
import com.deelon.loan.exception.ProjectException;
import com.deelon.loan.exception.UserException;
import com.deelon.loan.model.front.TAttention;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.model.front.TProjectInvest;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.model.front.TUserSafe;

@Service
public class TattentionService extends BaseService<TAttention> {

	@Resource
	private TattentionDao tattentionDao;

	@Override
	protected IEntityDao<TAttention, Long> getEntityDao() {
		return this.tattentionDao;
	}



	/**
	 * 关注保存
	 * 
	 * @param TAttention
	 * @throws UserException
	 */
	public int saveTattention(TAttention tAttention) throws UserException {
		
		return tattentionDao.saveTattention(tAttention);
		
	}
	

	/**
	 * 查询关注
	 * 
	 * @param map
	 * @throws UserException
	 */
	public TAttention selectTattention(Map map) throws UserException {
		
		return tattentionDao.selectTattention(map);
		
	}
	
	/*
	 * 取消收藏
	 */
	public void cancleCollect(TAttention tAttention){
		tattentionDao.update(tAttention);
	}
}