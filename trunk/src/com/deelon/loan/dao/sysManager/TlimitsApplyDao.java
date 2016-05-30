/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.loan.dao.sysManager;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.model.front.TLimitsApply;


@Repository
public class TlimitsApplyDao extends  BaseDao<TLimitsApply>{
	
	public Class getEntityClass()
	 {
	     return TLimitsApply.class;
	 }
	
	public List<TLimitsApply> getAllTLimitsApply(QueryFilter queryFilter){
		List<TLimitsApply> list= getBySqlKey("getAllData", queryFilter);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		List<TLimitsApply> lv=new ArrayList<TLimitsApply>();
		String applyTime="";
		String checkTime="";
		try {
			if(list!=null&&list.size()>0){
				for (TLimitsApply t : list) {
					
				/*	TLimitsApply nt=new TLimitsApply();
					nt.setApplyId(t.getApplyId());
					nt.setApplicant(t.getApplicant());
					nt.setLimitApply(t.getLimitApply());
					nt.setLimitOld(t.getLimitOld());
					
					nt.setApplyName(t.getApplyName());
					nt.setAudit(t.getAudit());
					nt.setAudit_desc(t.getAudit_desc());
					nt.setChecker(t.getChecker());
					nt.setCheckrName(t.getCheckrName());
					
					nt.setAudit_status(t.getAudit_status());*/
					if(t!=null){
						if(t.getApplyTime()!=null){
							applyTime=sdf.format(t.getApplyTime());
							
							t.setApplytimeStr(applyTime);
						}
						if(t.getTypeId()!=null){
							if(t.getTypeId().equals("1")){
								t.setAppLyType("借入");
							}
						}else if(t.getTypeId()!=null&&t.getTypeId().equals("2")){
							t.setAppLyType("借出");
						}
						
						if(t.getCheckTime()!=null){
							checkTime=sdf.format(t.getCheckTime());
							t.setChecktimeStr(checkTime);
						}
						lv.add(t);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return lv;
	}
	
	public int updateTLimitsApplyByPk(TLimitsApply tLimitsApply){
		return update("update", tLimitsApply);
	}
	
	public TLimitsApply getTLimitsApplyById(Long id){
		return getUnique("getById", id);
	}

}
