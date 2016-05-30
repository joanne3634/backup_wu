package com.deelon.loan.service.sysManager;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.quartz.JobExecutionContext;

import com.deelon.core.scheduler.BaseJob;
import com.deelon.core.util.AppUtil;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.dao.sysManager.TprojectDao;
import com.deelon.loan.dao.sysManager.TprojectRepaymentDao;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.model.front.TProjectRepayment;
import com.deelon.loan.service.front.TuserCreditService;

public class TlateRepayProjectJobService extends BaseJob{

	@Override
	public void executeJob(JobExecutionContext paramJobExecutionContext) throws Exception {
		TprojectDao tprojectDao=(TprojectDao)AppUtil.getBean(TprojectDao.class);
		TprojectRepaymentDao tprojectRepaymentDao=(TprojectRepaymentDao)AppUtil.getBean(TprojectRepaymentDao.class);
		
		//查询还款中的所有项目
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pstatusId", "6");
		QueryFilter queryFilter = new QueryFilter();
		queryFilter.setFilters(params);
		List<TProject> list = tprojectDao.getAll(queryFilter);
		for(TProject p:list){
			params.put("projectId", p.getProjectId());
			//最大逾期天数
			int plateDays = 0;
			//查询借款项目的还款记录
			List<TProjectRepayment> rlist = tprojectRepaymentDao.getAll(queryFilter);
			for(TProjectRepayment rp:rlist){
				Date plan = rp.getPrPlanPayTime();
				Calendar aCalendar = Calendar.getInstance();
				aCalendar.setTime(plan);
				int day1 = aCalendar.get(Calendar.DAY_OF_YEAR);
				aCalendar.setTime(new Date());
				int day2 = aCalendar.get(Calendar.DAY_OF_YEAR);
				int lateDays = day2 - day1;
				Integer credit = (Integer)AppUtil.getServletContext().getAttribute("LATE-CREDIT");
				int creditNum = lateDays*(credit==null?1:credit);
				//逾期需要扣除信用值调用接口
				TuserCreditService tuserCreditService = (TuserCreditService)AppUtil.getBean(TuserCreditService.class);
				tuserCreditService.updateUserCredit(p.getPapplicant(), p.getProjectId(), -creditNum, 3, "用户还清借款及利息加信用值");
				if("0".equals(rp.getPrIsDone())&&lateDays>0){//如果未完成还款的还款期数延迟了还款了就记录延迟天数
					rp.setPrLateDays(lateDays);
					rp.setPrisLate(1);
					tprojectRepaymentDao.update(rp);
					if((p.getPlateDays()==null?0:p.getPlateDays())<lateDays){//如果项目最大的逾期时间小于还款期数的时间则修改为期数的逾期时间为最大逾期时间
						plateDays = lateDays;
					}else{
						plateDays = p.getPlateDays();
					}
				}
			}
			if(plateDays>0){//如果逾期则修改借款项目主记录
				p.setPlateDays(plateDays);
				p.setPisLate((short) 1);
				tprojectDao.update(p);
			}
		}
	}

}
