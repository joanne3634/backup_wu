package com.deelon.loan.job;

import java.util.List;

import org.quartz.JobExecutionContext;

import com.deelon.core.scheduler.BaseJob;
import com.deelon.core.util.AppUtil;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.model.front.TuserSetauto;
import com.deelon.loan.service.front.TuserSetautoService;
import com.deelon.loan.service.sysManager.TuserFundsService;

public class AutoTenderJob extends BaseJob {

	@Override
	public void executeJob(JobExecutionContext paramJobExecutionContext)
			throws Exception {
		TuserSetautoService tuserSetautoService=(TuserSetautoService)AppUtil.getBean(TuserSetautoService.class);
		TuserFundsService tuserFundsService=(TuserFundsService)AppUtil.getBean(TuserFundsService.class);
		//先找出用户设置的最新的(视最新的为有效的)自动投标设置
		//找出 设置了 自动投标的用户
		
		List<TuserSetauto> list=tuserSetautoService.getAllAutoTenderList();
		if(list!=null&&list.size()>0){
			for (TuserSetauto t : list) {
				//每次要判断用户的可用资金是否够用来投标
				TUserFunds uf=tuserFundsService.getByUserId(t.getUserId());
				if(uf!=null)
				 tuserSetautoService.autoBidding(t,uf);
			}
		}
	}

}
