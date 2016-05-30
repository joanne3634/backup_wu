/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.service.front;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.page.PageBean;
import com.deelon.core.service.BaseService;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.crowdfunding.common.exception.CrowdFundException;
import com.deelon.crowdfunding.dao.backstage.TcprojectInvestDao;
import com.deelon.crowdfunding.model.backstage.TcprojectInvest;
import com.deelon.loan.dao.front.TUserDao;
import com.deelon.loan.dao.front.TmoneymoveDao;
import com.deelon.loan.model.front.TMoneymove;
import com.deelon.loan.model.front.TUser;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@ Service
public class TmoneymoveService extends BaseService<TMoneymove>{

	@ Resource
	private TmoneymoveDao tmoneymoveDao;

	@ Resource
	private TcprojectInvestDao tcprojectInvestDao;

	@ Resource
	private TUserDao tUserDao;


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

	/**
	 * 根据proId和userId 查询资金
	 * @param map
	 * @return
	 */
	public TMoneymove getByProIdAndUserIdAnd(Map<String,Object> map){
		return tmoneymoveDao.getByProIdAndUserIdAnd(map);
	}

	/**
	 * 更新支付结果以及投资结果
	 * @param tmoneymove
	 */
	@Transactional(rollbackFor = CrowdFundException.class)
	public void modifyInvestStatus(TMoneymove tmoneymove){
		try{
			tmoneymoveDao.update(tmoneymove);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("projectId", tmoneymove.getProjectId());
			map.put("userId", tmoneymove.getUserId());
			map.put("ispay", 0);// 未付款
			map.put("piisCancel", 0);
			map.put("piisCheck",1);//是否审核通过
			List<TcprojectInvest> list = tcprojectInvestDao
					.getInvestforPro(map, null);
			if (list != null && list.size() > 0) {
				for (TcprojectInvest tpi : list) {
					tpi.setPiisPay(1);// 已付款
					tpi.setPipayTime(new Date());
					tcprojectInvestDao.update(tpi);
				}
			}

		}catch (Exception e){
			logger.warn("modifyInvestStatus error:moneyMoveId={}",tmoneymove.getMoneyMoveId());
			throw new CrowdFundException(e);
		}
	}

	/**
	 * 更新诚意金支付结果
	 * @param tmoneymove
	 */
	@Transactional(rollbackFor = CrowdFundException.class)
	public void modifyQulifiedStatus(TMoneymove tmoneymove) {
        try {
            tmoneymoveDao.update(tmoneymove);

            //付给用户项目认筹资格
            TUser tuser = tUserDao.getById(tmoneymove.getUserId());
            tuser.setIsAskPrice(1);//项目认筹资格
            tUserDao.update(tuser);
        } catch (Exception e) {
            logger.warn("modifyQulifiedStatus error:moneyMoveId={}", tmoneymove.getMoneyMoveId());
            throw new CrowdFundException(e);
        }
    }

	/**
	 * 新增诚意金记录
	 *在新增一条诚意金就前先查询该用户是否有未付款的诚意金记录，若有则将该记录置为无效。状态为98
	 * @param moneymove
	 */
	@Transactional(propagation= Propagation.REQUIRED,rollbackFor=CrowdFundException.class)
	public void addNewMoneyMove(TMoneymove moneymove){
		if(null!=moneymove.getUserId()&& StringUtil.isNotEmpty(moneymove.getTypeId())){
			TMoneymove filter = new TMoneymove();
			filter.setUserId(moneymove.getUserId());
			filter.setTypeId(moneymove.getTypeId());
			filter.setResultId("99");
			if("3".equals(moneymove.getTypeId())){
				if(null==moneymove.getProjectId()){
					logger.warn("新增资金流记录：投资记录项目id不能为空");
					throw new CrowdFundException("新增资金流记录：投资记录项目id不能为空");
				}
				filter.setProjectId(moneymove.getProjectId());
			}
			try {
				tmoneymoveDao.disableRecord(filter);

				tmoneymoveDao.add(moneymove);
			}catch (Exception e){
				logger.warn("新增资金流记录异常:{}",e.getMessage());
				throw new CrowdFundException(e);
			}
		}
		else {
			logger.warn("新增资金流记录：参数不完整");
			throw new CrowdFundException("新增资金流记录：参数不完整");
		}
	}
}