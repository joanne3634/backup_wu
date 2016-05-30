package com.deelon.loan.dao.front;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.core.page.PageBean;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.model.front.TProjectInvest;

@Repository
public class TProjectInvestDao extends BaseDao<TProjectInvest>{

	@Override
	public Class<TProjectInvest> getEntityClass() {
		
		return TProjectInvest.class;
	}
	
	public void saveTProjectInvest(TProjectInvest projectInvest){
		insert("insertProjectInvest", projectInvest);
	}
	
	
	/**
	 * 
	 * @param userId 投资人id
	 * @param plTypeId 投标类型,自动还是手动
	 * @return
	 */
	public List<TProjectInvest> getTProjectInvestByUserId(QueryFilter queryFilter){
		return getBySqlKey("getTProjectInvestByUserId", queryFilter);
	}
	
	/**
	 * 获取用户的理财统计
	 * @param userId
	 * @return
	 */
	public TProjectInvest getCountInfo(Long userId){
		TProjectInvest t1=getUnique("getCountInfo1", userId);
		TProjectInvest t2=getUnique("getCountInfo2", userId);
		TProjectInvest t3=getUnique("getCountInfo3", userId);
		TProjectInvest t4=getUnique("getCountInfo4", userId);
		TProjectInvest t5=getUnique("getCountInfo5", userId);
		TProjectInvest t6=getUnique("getCountInfo6", userId);
		TProjectInvest t7=getUnique("getCountInfo7", userId);
		TProjectInvest t8=getUnique("getCountInfo8", userId);
		TProjectInvest t9=getUnique("getCountInfo9", userId);
		TProjectInvest t10=getUnique("getCountInfo10", userId);
		TProjectInvest t11=getUnique("getCountInfo11", userId);
		TProjectInvest t12=getUnique("getCountInfo12", userId);
		TProjectInvest tp=new TProjectInvest();
		if(t1!=null){
			
			tp.setSm_t_PA_Interest(t1.getSm_t_PA_Interest());
			tp.setSm_t_PA_Late(t1.getSm_t_PA_Late());
			tp.setSm_benjin(t1.getSm_benjin());
			tp.setSm_benxi(t1.getSm_benxi());
			tp.setSm_PI_EffectAmount(t1.getSm_PI_EffectAmount());
			tp.setSm_totOutnum(t1.getSm_totOutnum());
			tp.setSm_daihuanbenxi(t1.getSm_daihuanbenxi());
			
		}
		if(t2!=null){
			tp.setSm_Balance(t2.getSm_Balance());
		}
		if(t3!=null){
			if(StringUtil.isNotEmpty(t3.getSm_totIn()))
			tp.setSm_totIn(t3.getSm_totIn());
			else{
				tp.setSm_totIn("0");
			}
		}
		if(t4!=null){
			if(StringUtil.isNotEmpty(t4.getSm_applying()))
			tp.setSm_applying(t4.getSm_applying());
			else
				tp.setSm_applying("0");
		}
		if(t5!=null){
			if(StringUtil.isNotEmpty(t5.getSm_expect()))
			tp.setSm_expect(t5.getSm_expect());
			else
				tp.setSm_expect("0");
		}
		if(t6!=null){
			if(StringUtil.isNotEmpty(t6.getSm_daichang()))
			tp.setSm_daichang(t6.getSm_daichang());
			else{
				tp.setSm_daichang("0");
			}
		}
		if(t7!=null){
			if(StringUtil.isNotEmpty(t7.getSm_Natural_repayMent()))
			tp.setSm_Natural_repayMent(t7.getSm_Natural_repayMent());
			else
				tp.setSm_Natural_repayMent("0");
		}
		if(t8!=null){
			if(StringUtil.isNotEmpty(t8.getSm_compleate_repayMent()))
			tp.setSm_compleate_repayMent(t8.getSm_compleate_repayMent());
			else
				tp.setSm_compleate_repayMent("0");
		}
		if(t9!=null){
			if(StringUtil.isNotEmpty(t9.getSm_yidaichang()))
			tp.setSm_yidaichang(t9.getSm_yidaichang());
			else{
				tp.setSm_yidaichang("0");
			}
		}
		if(t10!=null){
			if(StringUtil.isNotEmpty(t10.getSm_zhengchangPayment()))
			tp.setSm_zhengchangPayment(t10.getSm_zhengchangPayment());
			else
				tp.setSm_zhengchangPayment("0");
		}
		if(t11!=null){
			if(StringUtil.isNotEmpty(t11.getSm_tiqianPayMent()))
			tp.setSm_tiqianPayMent(t11.getSm_tiqianPayMent());
			else
				tp.setSm_tiqianPayMent("0");
		}
		if(t12!=null){
			if(StringUtil.isNotEmpty(t12.getSm_totIn_ing()))
			tp.setSm_totIn_ing(t12.getSm_totIn_ing());
			else
				tp.setSm_totIn_ing("0");
		}
		return tp;
	}
	
	/**
	 * 获取用户 等待收款的记录
	 * @return
	 */
	public List<TProjectInvest> getWaitingForthePayMent(Map<String,Object> map,PageBean pb){
		return getBySqlKey("getWaitingForthePayMent", map,pb);
	}

	/**
	 * 获取用户正在收款的记录
	 * @return
	 */
	public List<TProjectInvest> getRePayMenetList(Map<String,Object> map,PageBean pb){
		return getBySqlKey("getRePayMenetList", map,pb);
	}
	
	/**
	 * 获取用户已收款完成的记录
	 * @return
	 */
	public List<TProjectInvest> getPayOffList(Map<String,Object> map,PageBean pb){
		return getBySqlKey("getPayOffList", map,pb);
	}
	
	/**
	 * 根据用户id和项目id查询一条记录
	 * @param t
	 * @return
	 */
	public TProjectInvest getTProjectInvestByUserIdAndProId(long proId,long userId){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("projectId", proId);
		map.put("userId", userId);
		return getUnique("getTProjectInvestByUserIdAndProId", map);
	}
	
	/**
	 * 通过项目id查询记录
	 * @param project
	 * @return
	 */
	public List<TProjectInvest> getTprojectInvestByProId(Long projectid,PageBean pb){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("projectid", projectid);
		return getBySqlKey("getTprojectInvestByProId", map,pb);
	}

	public List<TProjectInvest> getTprojectInvestByProIdForUserGet(long projectid) {
		return getBySqlKey("getTprojectInvestByProIdForUserGet", projectid);
	}
}
