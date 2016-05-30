/*
 * Powered By [Allen]
 * Since 2013 - 2015
 */


package com.deelon.crowdfunding.service.backstage;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.core.util.AppUtil;
import com.deelon.crowdfunding.dao.backstage.TcprojectLoanRecordsDao;
import com.deelon.crowdfunding.model.backstage.Tcproject;
import com.deelon.crowdfunding.model.backstage.TcprojectLoanRecords;
import com.deelon.loan.dao.front.TmoneymoveDao;
import com.deelon.loan.model.front.TMoneymove;

@ Service
public class TcprojectLoanRecordsService extends BaseService<TcprojectLoanRecords>{
	
	@ Resource
	private TcprojectLoanRecordsDao tcprojectLoanRecordsDao;
	@ Resource
	private TmoneymoveDao tmoneymoveDao;
	
	protected IEntityDao<TcprojectLoanRecords, Long> getEntityDao()
	{
		return this.tcprojectLoanRecordsDao;
	}
	
	
	//
	public void updateProject(TcprojectLoanRecords tcprojectLoanRecords,TMoneymove tmoneymove,Tcproject project)throws Exception{
		
		tcprojectLoanRecordsDao.add(tcprojectLoanRecords);
		tmoneymoveDao.add(tmoneymove);
		TcprojectService pc = (TcprojectService) AppUtil
				.getBean(TcprojectService.class);
		pc.confirmPayProject(project, null);
		
	}

}