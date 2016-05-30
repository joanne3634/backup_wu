/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.crowdfunding.service.backstage;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.page.PageBean;
import com.deelon.core.service.BaseService;
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.crowdfunding.common.util.DateUtilWuyouchou;
import com.deelon.crowdfunding.dao.backstage.TcprojectDao;
import com.deelon.crowdfunding.model.backstage.*;
import com.deelon.crowdfunding.service.front.HomePageService;
import com.deelon.loan.dao.front.TmoneymoveDao;
import com.deelon.loan.model.front.TMoneymove;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.model.front.Tarea;
import com.deelon.loan.model.sysManager.Tsmsinformation;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TareaService;
import com.deelon.loan.service.front.TuserSafeService;
import com.deelon.loan.service.sysManager.TsmsinformationService;
import com.deelon.loan.service.sysManager.TuserFundsService;
import com.deelon.loan.util.HtmlRegexpUtil;
import com.deelon.payform.common.moneymoremore.RongpayConfig;
import com.deelon.payform.common.moneymoremore.RongpayFunction;
import com.deelon.platform.model.system.SysUser;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

@ Service
public class TcprojectService extends BaseService<Tcproject>{
	
	@ Resource
	private TcprojectDao tcprojectDao;
	@Resource
	private TuserFundsService tuserFundsService;
	@Resource
	private TcprojectInvestService tcprojectInvestService;
	@Resource
	private TcprojectPayplanService tcprojectPayplanService;
	@Resource
	private TareaService tareaService;
	@Resource
	private TcprojectTeamService tcprojectTeamService;
	@Resource
	private TcprojectHistoryplanService tcprojectHistoryplanService;//历史/计划
	@Resource
	private TcprojectHpPaymentsService tcprojectHpPaymentsService;//历史/计划 支出
	@Resource
	private TcprojectModelService tcprojectModelService;//商业计划
	@Resource
	private TcprojectAttachmentService tcprojectAttachmentService;//附件
	@Resource
	private TcprojectCommentsService tcprojectCommentsService;//评论
	@Resource
	private TcprojectNewsService tcprojectNewsService;//项目动态
	@Resource
	private TcprojectInvestService TcprojectInvestService;
	@Resource
	private TuserApplyLeaderService TuserApplyLeaderService;
	@Resource
	private TUserService tuserService;
	@Resource
	private TmoneymoveDao tmoneymoveDao;
	protected IEntityDao<Tcproject, Long> getEntityDao()
	{
		return this.tcprojectDao;
	}
	
	/**
	 * 查询待审核的项目
	 * @param queryFilter
	 * @return
	 */
	public List<Tcproject> getToAuditPro(QueryFilter queryFilter){
		List<Tcproject> list=tcprojectDao.getToAuditPro(queryFilter);
		if(list!=null&&list.size()>0){
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			for (Tcproject t : list) {
				//商业模式
				TcprojectModel tcprojectModel=tcprojectModelService.getByProId(t.getProjectId());
				if(null==tcprojectModel){
					t.setIsDel(1);//标志审核的时候不能通过，项目信息不完整
				}
				/**
				 * 地产项目去掉 创业团队，历史情况，未来计划 的查询
				 */
				if(t!=null&&!"3".equals(t.getPtypeId())){
					//创业团队
					List<TcprojectTeam> listT=tcprojectTeamService.getByProId(t.getProjectId());
					if(listT!=null&&listT.size()>0){
					}else{
						t.setIsDel(1);//标志审核的时候不能通过，项目信息不完整
					}
					//历史情况
					Map<String,Object> map =new HashMap<String,Object>();
					map.put("projectId", t.getProjectId());
					map.put("phptypeId", "1");//历史情况
					List<TcprojectHistoryplan> listH=tcprojectHistoryplanService.getByProId(map);
					if(listH!=null&&listH.size()>0){
					}else{
						t.setIsDel(1);//标志审核的时候不能通过，项目信息不完整
					}
					//未来计划
					Map<String,Object> map1 =new HashMap<String,Object>();
					map1.put("projectId", t.getProjectId());
					map1.put("phptypeId", "2");//历史情况

					List<TcprojectHistoryplan> listP=tcprojectHistoryplanService.getByProId(map1);

					if(listP!=null&&listP.size()>0){
					}else{
						t.setIsDel(1);//标志审核的时候不能通过，项目信息不完整;
					}
				}

				if(StringUtil.isNotEmpty(t.getPstateId())){
//					if(t.getPcheckTimes()<=1){//审核次数小于2次的,初次审核为0
						if(t.getPstateId().equals("1")){
							t.setLinkedAction("<a href=\"javascript:void(0)\" class=\"link primary\" onclick=\"agreeApply("+t.getProjectId()+",'agree',"+t.getIsDel()+");\">通过</a>&nbsp;&nbsp;&nbsp;&nbsp;"+
									"<a href=\"javascript:void(0)\" class=\"link resetPwd\" onclick=\"agreeApply("+t.getProjectId()+",'disagree');\">拒绝</a>");
						}
//					}
				}
				if(t.getCreateTime()!=null)
					t.setCreateTimestr(sdf.format(t.getCreateTime()));
				if(t.getPcheckTime()!=null)
					t.setAuditTimestr(sdf.format(t.getPcheckTime()));
			}
		}
		return list;
	}
	/**
	 * 查询招标中的项目
	 * @param queryFilter
	 * @return
	 */
	public List<Tcproject> getInvitationforPro(QueryFilter queryFilter){
		return tcprojectDao.getInvitationforPro(queryFilter);
	}
	
	/**
	 * 根据条件查询项目
	 * @param queryFilter
	 * @return
	 */
	public List<Tcproject> getAllProByWhere(Map<String,Object> map,PageBean pb){
		List<Tcproject> list=tcprojectDao.getAllProByWhere(map,pb);
		if(list!=null&&list.size()>0){
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
			for (Tcproject t : list) {
				String cityName = t.getPcityIname();
				//如果是直辖市区划，则只显示一级
				if("市辖区".equals(cityName)||"县".equals(cityName)){
					t.setPcityIname("");
				}
				if(t.getPopenDate()!=null){
					t.setPopenDateStr(sdf.format(t.getPopenDate()));
				}
				if(t.getCreateTime()!=null){
					t.setCreateTimestr(sdf.format(t.getCreateTime()));
				}
				if(t.getPfullTime()!=null){
					t.setPfullTimeStr(sdf.format(t.getPfullTime()));
				}
				if(t.getPfinancingAmount()!=null)
					t.setPfinancingAmount(t.getPfinancingAmount().setScale(0).divide(new BigDecimal(10000)));
				if(t.getPinvestAmount()!=null)
					t.setPinvestAmount(t.getPinvestAmount().setScale(0).divide(new BigDecimal(10000)));
			}
		}
		return list;
	}
	/**
	 * 根据热门项目
	 * @param filter
	 * @return
	 */
	public List<Tcproject> getAllHotProjects(QueryFilter filter){
		List<Tcproject> list=tcprojectDao.getAllHotProjects(filter);
		return list;
	}

	/**
	 * 查询成功案例（状态为4，5，6）
	 * @return
	 */
	public List<Tcproject> getSuccessTcProjects(){
		List<Tcproject> list=tcprojectDao.getSuccessTcProjects();
		return list;
	}
	/**
	 * 查询有项目的城市
	 * @return
	 */
	public List<Tcproject> getProOfCitys(){
		List<Tcproject> list=tcprojectDao.getProOfCitys();
		if(list==null||list.size()==0){
			List<Tarea> listT=tareaService.getRecommendTheCitys();
			if(listT!=null&&listT.size()>0){
				for (Tarea r : listT) {
					Tcproject cp=new Tcproject();
					cp.setPcityIname(r.getAreaName());
					cp.setPcityId(r.getAreaId());
					list.add(cp);
				}
			}
		}
		return list;
	}
	
	
	
	
	/**
	 * 查询满标的项目或符合满标条件的项目
	 * @param queryFilter
	 * @return
	 */
	public List<Tcproject> getFullTenderForPro(QueryFilter queryFilter) throws Exception{
		
		List<Tcproject> list=tcprojectDao.getFullTenderForPro(queryFilter);
		if(list!=null&&list.size()>0){
			SimpleDateFormat sdf=new SimpleDateFormat("yyy-MM-dd HH:mm");
			for (Tcproject t : list) {
				if(t.getPisFull()==0){
					t.setLinkedAction("<a href=\"javascript:void(0)\" class=\"link primary\" onclick=\"agreeApply("+t.getProjectId()+",'agree');\">满标</a>&nbsp;&nbsp;&nbsp;&nbsp;"+
							"<a href=\"get.ht?projectId="+t.getProjectId()+" \"  class=\"link resetPwd\" >流标</a>");
				}else{
					t.setLinkedAction("已审核");
				}
				if(t.getPopenDate()!=null){
					
					t.setPopenDateStr(sdf.format(t.getPopenDate()));
				}
				if(t.getPcloseDate()!=null){
					
					t.setPcloseDateStr(sdf.format(t.getPcloseDate()));
				}
				if(t.getCreateTime()!=null){
					t.setCreateTimestr(sdf.format(t.getCreateTime()));
				}
				t.setPcompleateStr(t.getPcomplete()+"%");
			}
		}
		return list;
	}
	
	
	
	/**
	 * 查询所有满标的项目
	 * @param queryFilter
	 * @return
	 * @throws Exception
	 */
	public List<Tcproject> getAllFullTender(QueryFilter queryFilter) throws Exception{
		List<Tcproject> list=tcprojectDao.getAllFullTender(queryFilter);
		if(list!=null&&list.size()>0){
			SimpleDateFormat sdf=new SimpleDateFormat("yyy-MM-dd HH:mm");
			for (Tcproject t : list) {
				if("5".equals(t.getPstateId())||"4".equals(t.getPstateId())){
					t.setLinkedAction("<a href=\"edit.ht?projectId="+t.getProjectId()+"&contractId="+(t.getContractId()==null?0:t.getContractId())+"\" class=\"link primary\" >编辑</a>");//&nbsp;&nbsp;&nbsp;&nbsp;"+
				} 
				if(t.getPopenDate()!=null){
					
					t.setPopenDateStr(sdf.format(t.getPopenDate()));
				}
				if(t.getPcloseDate()!=null){
					
					t.setPcloseDateStr(sdf.format(t.getPcloseDate()));
				}
				if(t.getCreateTime()!=null){
					t.setCreateTimestr(sdf.format(t.getCreateTime()));
				}
				t.setPcompleateStr(t.getPcomplete()+"%");
			}
		}
		return list;
	}
	
	
	/**
	 * 有创业者名字,照片 的项目
	 * @param proId
	 * @return
	 */
	public Tcproject getTcprojectById(long proId){
		Tcproject tc = tcprojectDao.getTcprojectById(proId);
		if (tc.getPopenDate() != null) {			
			int lastDays =  HomePageService.daysBetween(new Date(), tc.getPopenDate());
			/**
			 * 处理剩余天数显示负数的问题【负数显示为0】
			 */
			int lastDaysView = tc.getPopenDays() - lastDays;
			if (lastDaysView < 0) {
				lastDaysView = 0;
			}
			tc.setLastDays(lastDaysView);
		}
		return tc;
	}

	/**
	 * 确认众筹项目放款
	 * @param projectId
	 * @return boolean
	 */
	public boolean confirmPayProject(/*String projectId*/Tcproject project,TUserFunds tf)throws Exception {
	
			float paymethod = 1;//拨付方式的比例
			if("1".equals(project.getPpayWay())){//每季度一次，每次25%
				paymethod = 0.25f;
			}else if("2".equals(project.getPpayWay())){//每半年一次，每次50%
				paymethod = 0.5f;
			}else if("3".equals(project.getPpayWay())){//一次性投资拨付全到帐
				paymethod = 1;
			}else{
				logger.error("众筹项目投资拨付方式丢失或者不存在此拨付款类型，付款失败");
				return false;
			}
			String poundage =(String)AppUtil.getServletContext().getAttribute("CROWD_SUCCESS_FEES");//平台手续费比例
			double dealFee = 0;//平台放款处理费用
			if(StringUtil.isNotEmpty(poundage)){//如果平台借款比例不为空则处理此次拨付放款的处理费为以下计算得
				project.setPdealRate(Float.valueOf(poundage));//设置项目平台拨付筹集资金款费用比例
			}
		
			TUserFunds uaco=tuserFundsService.getTUserFundsByUserId(project.getCreator());//借款人账户
			if(uaco!=null){
				//将扣取的平台手续费 插入资金流动记录
				if(project.getPdealFees()>0)
				tuserFundsService.inMoneyMove(project.getCreator(),"7",new BigDecimal(project.getPdealFees()),uaco.getAvailable().add(uaco.getFreeze()),new BigDecimal(0));
			}else{
				throw new Exception("用户账户异常,请检查是否创建资金账户!");
			}
			SysUser sysUser=ContextUtil.getCurrentUser();//当前系统后台审核放款用户
			
			QueryFilter qf = new QueryFilter();
			qf.addFilter("projectId", project.getProjectId());//根据项目id查询项目认筹投资记录
			//根据项目id查询项目拨付融资款项的拨付款计划
			List<TcprojectPayplan> plist = tcprojectPayplanService.getAll(qf);
			for(TcprojectPayplan pp:plist){
				if(project.getPcurrent()==0){//如果初始化众筹项目的当前期数为0，则设置本次还款的期数为1
					project.setPcurrent(1);
				}
				if(pp.getPppcurrent().compareTo(project.getPcurrent())==0){//如果支付的是当前拨付计划期数，则修改计划为已支付
					pp.setPppisDone(1);
					pp.setPpppayer(sysUser.getUserId());
					pp.setPpprealPay(project.getPinvestAmount().multiply(new BigDecimal(paymethod)).subtract(new BigDecimal(dealFee)).doubleValue());
					pp.setPpprealPayTime(new Date());
					if(pp.getPppcurrent().compareTo(plist.size())==0){//修改筹款项目的拨付比例
						pp.setPppisPayOff(1);//如果是最后一期则拨付完成
						project.setPpayPercent(100);
						project.setPstateId("6");//设置众筹已经完成拨付款
					}else{
						project.setPpayPercent((int) (Double.valueOf(pp.getPppcurrent())/Double.valueOf(plist.size())*100));
						//设置下次当前期数+1
						project.setPcurrent(project.getPcurrent()+1);
					}
					tcprojectPayplanService.update(pp);
				}
			}
			
		
			
			// 3修改借款人账户 
			//先判断 实际借款金额够不够减 平台手续费和担保金 
			if(dealFee-(project.getPinvestAmount().multiply(new BigDecimal(paymethod)).doubleValue())>0){
				logger.error("请检查此次拨付款和平台处理费用比例，系统发现实际拨付金额小于要扣取的手续费!");
				throw new Exception("操作异常!"+"实际拨付金额小于要扣取的手续费!");
			}	
			//查询所有认筹人投资记录，减少投资冻结住的资金，拨付款项成功
			qf.addFilter("piisCancel", 0);//没有取消的投资
			qf.addFilter("piisCheck", 1);//通过审核的投资
			qf.addFilter("piisPay", 1);//投资人已付款
			List<TcprojectInvest> list=tcprojectInvestService.getAll(qf);
			if(list!=null&&list.size()>0){
				for (TcprojectInvest tpi : list) {
					tpi.setPiisLoans(1);//设置已开始放款
					tpi.setPiLoansTime(new Date());
					//认筹总数和单个投资人认筹额 算得支付结果需要乘以 融资拨付款方式的比例
					if(null!=tpi.getPihavedPay()&&tpi.getPihavedPay()>0){
						tpi.setPihavedPay(tpi.getPihavedPay()+project.getPinvestAmount().multiply(new BigDecimal(paymethod)).doubleValue()*(tpi.getPiinvest().doubleValue()/project.getPinvestAmount().doubleValue()));
					}else{
						tpi.setPihavedPay(project.getPinvestAmount().multiply(new BigDecimal(paymethod)).doubleValue()*(tpi.getPiinvest().doubleValue()/project.getPinvestAmount().doubleValue()));
					}
					
					tcprojectInvestService.update(tpi);
					
				}
			}
			update(project);
			if(tf!=null)
				tuserFundsService.update(tf);//修改用户资金
			return true;
	}
	/**
	 * 根据众筹项目拨付款项方式初始化项目拨付款的计划
	 * @param project
	 */
	public void createInvestPaymentPlan(Tcproject project){
		int payCount=0;
		if("1".equals(project.getPpayWay())){//每季度一次，每次25%
			payCount = 4;
		}else if("2".equals(project.getPpayWay())){//每半年一次，每次50%
			payCount = 2;
		}else if("3".equals(project.getPpayWay())){//一次性投资拨付全到帐
			payCount = 1;
		}else{
			logger.error("众筹项目不存在此拨付款类型，保存失败");
			return ;
		}
		Calendar theCa = Calendar.getInstance();
		theCa.setTime(new Date());
		tcprojectPayplanService.delByProjectId(project.getProjectId());
		for(int i=1;i<=payCount;i++){
			if(i==1){
				theCa.add(theCa.DATE, +(7));//第一期默认一个礼拜内为计划拨付时间
			}else{//后面的期数按照一年的拨付次数来计算计划拨付日期
				theCa.add(theCa.DATE, +(365/payCount));
			}
			TcprojectPayplan entity = new TcprojectPayplan();
			entity.setPayPlanId(UniqueIdUtil.genId());
			entity.setPppcurrent(i);
			entity.setPppcurrentOfAll(i+"/"+payCount);
			entity.setPppisDone(0);
			entity.setPppisPayOff(0);
			entity.setPpppay(project.getPinvestAmount().doubleValue()*(Double.valueOf(1)/Double.valueOf(payCount)));
			entity.setPpprealPay(0d);
			entity.setPppplanPayTime(theCa.getTime());
			entity.setPpppayer(0l);
			entity.setProjectId(project.getProjectId());
			tcprojectPayplanService.add(entity);
		}
	}
	/**
	 * 确认取消或者暂停放款中处理
	 * @param projectId
	 * @param ispay
	 * @return
	 * @throws Exception 
	 */
	public boolean cancelPayProject(String projectId, String ispay) throws Exception {
		Tcproject project = getById(Long.parseLong(projectId));
		//createInvestPaymentPlan(project);//临时用于测试生成项目还款计划
		if("2".equals(ispay)){
			//否则恢复支付状态为正常1/0
			if(project.getPpayPercent()<=0){
				project.setPisPay(0);
			}else{
				project.setPisPay(1);
			}
		}else if("3".equals(ispay)){//如果是取消则设置支付状态为异常3
			project.setPisPay(3);//终止放款操作，众筹项目结束，将项目的剩余款项打回给投资人
			project.setPstateId("7");//作流标处理
			project.setPbreakTime(new Date());
			project.setPisBreak(1);
			project.setPbreakRemark("众筹确认放款环节的流标处理操作，操作人："+ContextUtil.getCurrentUser().getUsername());
			
			QueryFilter qf = new QueryFilter();
			qf.addFilter("projectId", project.getProjectId());//根据项目id查询项目认筹投资记录
			List<TcprojectInvest> list=tcprojectInvestService.getAll(qf);
			if(list!=null&&list.size()>0){
				for (TcprojectInvest tpi : list) {
					//将认筹剩余为拨付款项解冻，还给投资人
					tuserFundsService.userFundsChangeFunction(null, null, tpi.getUserId(), tpi.getPiinvest().subtract(new BigDecimal(tpi.getPihavedPay())), null, "",null,"");
				}
			}
		}else{//如果是取消则设置支付状态为异常2
			project.setPisPay(2);
		}
		project.setPcheckRemark(project.getPcheckRemark()+"-确认拨付款异常，取消或恢复拨付款操作人："+ContextUtil.getCurrentUser().getUsername());
		update(project);
		return true;
	}
	
	/**
	 * 查询领投人数量
	 * @return
	 */
	public Long getProLeadCount(Long projectId){
		return tcprojectDao.getProLeadCount(projectId);
	}
	/**
	 * 查询跟投人数量
	 * @return
	 */
	public Long getProFollowCount(Long projectId){
		return tcprojectDao.getProFollowCount(projectId);
	}
	
	/**
	 * 查询创业者项目
	 * @return
	 */
	public List<Tcproject> getProjectCr(QueryFilter filter){
		return tcprojectDao.getProjectCr(filter);
	}
	/**
	 * 查询项目详情返回给前台页面
	 * @return
	 */
	public HttpServletRequest getProjcteDetail(HttpServletRequest request,String projectId){ 
		
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");	
		//查询项目 包括 创业者和创业者信息
		Tcproject tcproject=getTcprojectById(Long.valueOf(projectId));
		if(tcproject!=null){
			tcproject.setYearmonth(tcproject.getPfoundedYear()+"年"+tcproject.getPfoundedMonth()+"月");
			if(tcproject.getPfinancingAmount().compareTo(new BigDecimal(0))>0)
				tcproject.setPfinancingAmount(tcproject.getPfinancingAmount().setScale(0).divide(new BigDecimal(10000)));
			tcproject.setPsharesPercent(tcproject.getPsharesPercent().setScale(2));
			if(tcproject.getPinvestAmount().compareTo(new BigDecimal(0))>0)
			 tcproject.setPinvestAmount(tcproject.getPinvestAmount().setScale(0).divide(new BigDecimal(10000)));
			
		}
		//商业模式
		TcprojectModel tcprojectModel=tcprojectModelService.getByProId(Long.valueOf(projectId));
		/**
		 * 地产项目去掉 创业团队，历史情况，未来计划
		 */
		if(tcproject!=null&&!"3".equals(tcproject.getPtypeId())) {
			//创业团队
			List<TcprojectTeam> listT = tcprojectTeamService.getByProId(Long.valueOf(projectId));
			if (listT != null && listT.size() > 0) {

			} else {
				request.setAttribute("ok", 0);
			}
			//历史情况
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("projectId", Long.valueOf(projectId));
			map.put("phptypeId", "1");//历史情况
			List<TcprojectHistoryplan> listH = tcprojectHistoryplanService.getByProId(map);
			BigDecimal hmoneyIn = new BigDecimal(0);
			BigDecimal hmoneyOut = new BigDecimal(0);
			if (listH != null && listH.size() > 0) {
				for (TcprojectHistoryplan h : listH) {
					if (h.getListHpPayMent() != null && h.getListHpPayMent().size() > 0) {
						for (TcprojectHpPayments m : h.getListHpPayMent()) {
							if (m.getHpptypeId().equals("1")) {
								hmoneyIn = hmoneyIn.add(m.getHpppayment().setScale(0));
							} else {
								hmoneyOut = hmoneyOut.add(m.getHpppayment().setScale(0));
							}
						}
					}
				}
			} else {
				request.setAttribute("ok", 0);
			}
			//未来计划
			Map<String, Object> map1 = new HashMap<String, Object>();
			map1.put("projectId", Long.valueOf(projectId));
			map1.put("phptypeId", "2");//历史情况

			BigDecimal fmoneyIn = new BigDecimal(0);
			BigDecimal fmoneyOut = new BigDecimal(0);
			List<TcprojectHistoryplan> listP = tcprojectHistoryplanService.getByProId(map1);

			if (listP != null && listP.size() > 0) {
				for (TcprojectHistoryplan p : listP) {
					if (p.getListHpPayMent() != null && p.getListHpPayMent().size() > 0) {
						for (TcprojectHpPayments n : p.getListHpPayMent()) {
							if (n.getHpptypeId().equals("1")) {
								if (n.getHpppayment() != null)
									fmoneyIn = fmoneyIn.add(n.getHpppayment().setScale(0));
							} else {
								if (n.getHpppayment() != null)
									fmoneyOut = fmoneyOut.add(n.getHpppayment().setScale(0));
							}
						}
					}
				}
			} else {
				request.setAttribute("ok", 0);
			}
			request.setAttribute("listT",listT );
			request.setAttribute("listH", listH);
			request.setAttribute("listP",listP );
			request.setAttribute("hmoneyIn", hmoneyIn);
			request.setAttribute("hmoneyOut", hmoneyOut);
			request.setAttribute("fmoneyIn", fmoneyIn);
			request.setAttribute("fmoneyOut", fmoneyOut);

		}//地产项目去掉 创业团队，历史情况，未来计划--end
		
		//项目附件
		List<TcprojectAttachment> listA=tcprojectAttachmentService.getByProId(Long.valueOf(projectId));
		//项目动态
		
	    
	    Map<String,Object> pronews =new HashMap<String,Object>();
	    pronews.put("projectId", Long.valueOf(projectId));
	    pronews.put("pntypeId", "1");//项目动态
		List<TcprojectNews> listN=tcprojectNewsService.getByProId(pronews);
		if(listN!=null&&listN.size()>0){
			for (TcprojectNews n : listN) {
				n.setPncontent(HtmlRegexpUtil.filterHtml(n.getPncontent()));
				if(n.getCreateTime()!=null){
					n.setCreateTimeStr(sdf.format(n.getCreateTime()));
				}
			}
		}
		
		//项目领投人
		Map<String,Object> invest=new HashMap<String,Object>();
		invest.put("projectId", Long.valueOf(projectId));
	//	invest.put("userId", userId);
		invest.put("piisLeader",1);
		invest.put("piisCancel", 0);
		List<TcprojectInvest> listIn=TcprojectInvestService.getInvestforPro(invest,null);
		TcprojectInvest tcprojectInvest=null;
		TuserApplyLeader tuserApplyLeader=null;
		if(listIn!=null&&listIn.size()>0){
			tcprojectInvest=listIn.get(0);
			if(tcprojectInvest!=null){
				if(tcprojectInvest.getPiinvestTime()!=null){
					tcprojectInvest.setPiinvestTimeS(sdf.format(tcprojectInvest.getPiinvestTime()));
				}
			
				tcprojectInvest.setPiinvest(tcprojectInvest.getPiinvest().setScale(0).divide(new BigDecimal(10000)));
				tuserApplyLeader=TuserApplyLeaderService.getLeaderInfoDetail(tcprojectInvest.getUserId());//领投人资料
			}
		}
		//项目跟投人
		Map<String,Object> invest1=new HashMap<String,Object>();
		invest1.put("projectId", Long.valueOf(projectId));
	//	invest.put("userId", userId);
		invest1.put("piisLeader",0);
		invest1.put("piisCancel", 0);
		List<TcprojectInvest> listInV=TcprojectInvestService.getInvestforPro(invest1,null);
		if(listInV!=null&&listInV.size()>0){
			for (TcprojectInvest t : listInV) {
				if(t.getPiinvestTime()!=null){
					t.setPiinvestTimeS(sdf.format(t.getPiinvestTime()));
					t.setPiinvest(t.getPiinvest().setScale(0).divide(new BigDecimal(10000)));
				}
			}
		}
		/**/
		
		request.setAttribute("tcproject",tcproject );
		request.setAttribute("tcprojectModel",tcprojectModel );
		if(null==tcprojectModel){
			request.setAttribute("ok",0 );
		}

		request.setAttribute("listA",listA );
		request.setAttribute("listN",listN );
		
		request.setAttribute("tcprojectInvest", tcprojectInvest);
		request.setAttribute("TuserApplyLeader", tuserApplyLeader);
		
		request.setAttribute("listInV", listInV);
		
		

		return request;
	}
	
	public List<Tcproject> getProjectByUserId(Long userId){
		return tcprojectDao.getProjectByUserId(userId);
	}
	
	/**
	 * 根据查询条件获取收藏的项目
	 * @param start
	 * @param end
	 * @param status
	 * @param userId
	 * @param pb 
	 * @return
	 */
	public List<Tcproject> getProjectCollections(String start, String end, long userId,PageBean pb) {
		QueryFilter filter = new QueryFilter();
		filter.addFilter("userId", userId);
		filter.setPageBean(pb);
		List<Tcproject> tcprojectInvests = tcprojectDao.getBySqlKeyAll(filter,Tcproject.class, "getProjectCollections");
		return tcprojectInvests;
	}
	
	
	/**
	 * 根据查询条件获取领投项目
	 * @param start
	 * @param end
	 * @param status
	 * @param userId
	 * @param pb 
	 * @return
	 */
	public List<Tcproject> getProjectLeads(String start, String end, long userId, PageBean pb) {
		QueryFilter filter = new QueryFilter();
		filter.addFilter("userId", userId);
		filter.setPageBean(pb);
		List<Tcproject> tcprojectInvests = tcprojectDao.getBySqlKeyAll(filter,TcprojectInvest.class, "getProjectLeads");
		return tcprojectInvests;
	}
	/**
	 * 根据查询条件获取拒绝的项目
	 * @param start
	 * @param end
	 * @param status
	 * @param userId
	 * @param pb 
	 * @return
	 */
	public List<Tcproject> getProjectRefuse(String start, String end, long userId, PageBean pb) {
		QueryFilter filter = new QueryFilter();
		filter.addFilter("userId", userId);
		filter.setPageBean(pb);
		List<Tcproject> tcprojectInvests = tcprojectDao.getBySqlKeyAll(filter,TcprojectInvest.class, "getProjectRefuse");
		return tcprojectInvests;
	}
	/**
	 * 根据查询条件获取跟投项目
	 * @param start
	 * @param end
	 * @param status
	 * @param userId
	 * @param pb 
	 * @return
	 */
	public List<Tcproject> getProjectVotes(String start, String end, long userId, PageBean pb) {
		QueryFilter filter = new QueryFilter();
		filter.addFilter("userId", userId);
		filter.setPageBean(pb);
		List<Tcproject> tcprojectInvests = tcprojectDao.getBySqlKeyAll(filter,TcprojectInvest.class, "getProjectVotes");
		return tcprojectInvests;
	}

	
	/**
	 * 根据查询条件查看约谈项目
	 * @param start
	 * @param end
	 * @param status
	 * @param userId
	 * @param pb 
	 * @return
	 */
	public List<Tcproject> getAboutProjs(String start, String end, long userId, PageBean pb) {
		QueryFilter filter = new QueryFilter();
		filter.addFilter("userId", userId);
		filter.setPageBean(pb);
		List<Tcproject> tcprojectInvests = tcprojectDao.getBySqlKeyAll(filter,TcprojectInvest.class, "getAboutProjs");
		return tcprojectInvests;
	}

	/**
	 * 根据查询条件查看已完成的项目
	 * @param start
	 * @param end
	 * @param status
	 * @param userId
	 * @param pb 
	 * @return
	 */
	public List<Tcproject> getFinishProjs(String start, String end, long userId, PageBean pb) {
		QueryFilter filter = new QueryFilter();
		filter.addFilter("userId", userId);
		filter.setPageBean(pb);
		List<Tcproject> tcprojectInvests = tcprojectDao.getBySqlKeyAll(filter,TcprojectInvest.class, "getFinishProjs");
		return tcprojectInvests;
	}
	
	/**
	 * 计算项目的 认投资金、跟投人数、完成比例
	 * @param projectId 项目实体
	 * @param pinvestAmount 投资人投资金额  注意:投资金额请 乘以 10000 后 转换成字符串 传递
	 * @param addOrSubTract 区分 跟投 还是取消认投 
	 * addOrSubTract="add" 为跟投
	 * addOrSubTract="subTract" 或 未空 时   表明是取消跟投则 
	 *********************业务逻辑********************************
	 *	1.认投金额=已筹到的金额+投资人投资金额                     	                 
	 *	2.完成比例=认投金额/融资金额*100							 
	 *  3.跟投人数=已认投的人数+1									 
	 **********************************************************														 
	 */
	public  void countInvestMoneyScheduleNumber(long projectId,String pinvestAmount,String addOrSubTract)throws Exception{
			Tcproject tcproject=tcprojectDao.getById(projectId);
			if(tcproject!=null){
				if(StringUtil.isNotEmpty(addOrSubTract)&&addOrSubTract.equals("add")){//跟投
					
					//计算认投金额
					if(StringUtil.isNotEmpty(pinvestAmount)){
						tcproject.setPinvestAmount(tcproject.getPinvestAmount().add(new BigDecimal(pinvestAmount)));
					}else{
						throw new Exception("投资金额不能为空!");
					}
					
					//计算完成比例
					int complate=tcproject.getPinvestAmount().divide(tcproject.getPfinancingAmount(), 2, BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(100)).intValue();
					tcproject.setPcomplete(complate);
					//计算跟投人数
					tcproject.setPinvestCount(tcproject.getPinvestCount()+1);
					
				}else{//取消认投
					//计算认投金额
					if(StringUtil.isNotEmpty(pinvestAmount)){
						if(tcproject.getPinvestAmount().subtract(new BigDecimal(pinvestAmount)).compareTo(new BigDecimal(0))<0){
							tcproject.setPinvestAmount(new BigDecimal(0));
						}else{
							
							tcproject.setPinvestAmount(tcproject.getPinvestAmount().subtract(new BigDecimal(pinvestAmount)));
						}
					}else{
						throw new Exception("投资金额不能为空!");
					}
					
					//计算完成比例
					int complate=tcproject.getPinvestAmount().divide(tcproject.getPfinancingAmount(), 2, BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(100)).intValue();
					tcproject.setPcomplete(complate);
					//计算跟投人数
					if(tcproject.getPinvestCount()==0){
						tcproject.setPinvestCount(0);
					}else{
						tcproject.setPinvestCount(tcproject.getPinvestCount()-1);
					}
				}
				tcprojectDao.update(tcproject);
			}else{
				throw new Exception("项目不存在!");
			}	
	}
	/**
	 * 更新项目的投资金额和完成比例
	 * @param projectId
	 * @return boolean
	 */
	public boolean calculateProjectInvestmentInfo(Long projectId){
		boolean flag = false;
		try{
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("projectId", Long.valueOf(projectId));
			map.put("piisCheck2",1);//查询未审核和已通过的投资计算总投资数
			map.put("piisCancel", 0);//未取消的
			List<TcprojectInvest> listIn=TcprojectInvestService.getInvestforProBymap(map); 
			Tcproject tcproject=tcprojectDao.getById(projectId);
			if(listIn!=null&&listIn.size()>0){
				tcproject.setPinvestCount(listIn.size());
				BigDecimal totalInvest = new BigDecimal(0);
				int asks = 0;
				int investCount = listIn.size();
				for(TcprojectInvest invest:listIn){
					totalInvest = totalInvest.add(invest.getPiinvest());
					if(invest.getPiisLeader()>0){//如果有领头人，则把跟投数目减去一个
						investCount = investCount-1;
					}
				}
				tcproject.setPinvestCount(investCount);
				tcproject.setPinvestAmount(totalInvest);
				int complate=tcproject.getPinvestAmount().divide(tcproject.getPfinancingAmount(), 2, BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(100)).intValue();
				tcproject.setPcomplete(complate);
				tcproject.setPaskPriceCount(asks);
			}else{
				tcproject.setPinvestAmount(new BigDecimal(0));
				tcproject.setPcomplete(0);
			}
			tcprojectDao.update(tcproject);
			flag = true;
		}catch(Exception e){
			logger.error("",e);
			throw e;
		}
		return flag;
	}

	public List<Tcproject> getAllSendMoney(QueryFilter qf) {
		return tcprojectDao.getAllSendMoney(qf);
	}
	
	
	/**
	 * 过期的项目查询
	 * @param queryFilter
	 * @return
	 */
	public List<Tcproject> getExpiredForPro(QueryFilter queryFilter) throws Exception{
		List<Tcproject> list=tcprojectDao.getExpiredForPro(queryFilter);
		return list;
	}
	
	/**
	 * 流标退款 操作
	 * @param tcproject 要更新的项目
	 * @param List<TcprojectInvest> list 项目已经付款的投资人
	 * @param  SysUser sysUser 当前操作流标的平台人员
	 * @throws Exception
	 */
	public String flowRefundAction(Tcproject tcproject,List<TcprojectInvest> list,SysUser sysUser)throws Exception {
		
		String resultStr="";
		try {
			
			boolean flag=true;
			 
			if(list!=null&&list.size()>0){
				for(int i=0;i<list.size();i++){
					TcprojectInvest tpi=list.get(i);
			//	for (TcprojectInvest tpi : list) {
				
					
					String flowCode=String.valueOf(UniqueIdUtil.genId());
				
					//查询 项目下 已经付款的投资人的  付款流水号
					Map<String,Object> map2=new HashMap<String,Object>();
					map2.put("projectId",tpi.getProjectId());
					map2.put("typeId", "3");
					map2.put("userId", tpi.getUserId());
					map2.put("resultId","1");
					TMoneymove mm=tmoneymoveDao.getByProIdAndUserIdAnd(map2);
					if(mm!=null){
						
						String merchant_ID = RongpayConfig.merchant_ID;
						String key=RongpayConfig.key;
						String charset=RongpayConfig.charset;
						String sign_type=RongpayConfig.sign_type;
						
						String refundUrl=RongpayConfig.refund_url;
						
						//		String orig_order_no=request.getParameter("orig_order_no");
						String order_no=String.valueOf(UniqueIdUtil.genId());//request.getParameter("order_no");
						String amount=mm.getMoneyInOut().abs()+"";//request.getParameter("amount");
						String note="";//request.getParameter("note");
						
						
						HashMap params=new HashMap();
						params.put("merchant_ID",merchant_ID);
						params.put("charset",charset);
						params.put("orig_order_no",mm.getFlowCode());
						params.put("order_no",order_no);
						params.put("amount","0.01");
						params.put("note",note);
						
						String sign=RongpayFunction.BuildMysign(params,key);
						//	String url="http://interface.reapal.com/service/refund?";
						String paramstr=RongpayFunction.CreateLinkString(params).append("&sign=").append(sign).append("&sign_type=").append(sign_type).toString();
						
						HashMap returnxml=RongpayFunction.GetMessage(refundUrl+paramstr);
						
						//如果 退款成功,则 插入一条资金记录 并且给投资人发消息
						String issucess=(String)returnxml.get("is_success");
						String resultCode=(String)returnxml.get("result_code");
						if(StringUtil.isNotEmpty(issucess)){
							if("T".equals(issucess)){//成功
								
								TMoneymove m=new TMoneymove();	
								m.setMoneyMoveId(UniqueIdUtil.genId());
								m.setUserId(tpi.getUserId());
								m.setProjectId(tcproject.getProjectId());
								m.setTypeId("9");//融资流标
								m.setMoneyInOut(tpi.getPiinvest());
								m.setGetFee(new BigDecimal(0));//手续费
								m.setMoneyCurrent(/*uaco.getBalance()*/new BigDecimal("0"));//成功后再加上 返回的资金
								m.setAudit(0);
								m.setResultId("1");
								m.setRemark("满标审核,流标操作 资金归还给投资者成功");
								m.setSerialNo("");	
								m.setChecker(0);
								m.setCreateTime(new Timestamp(System.currentTimeMillis()));
								m.setFlowCode(mm.getFlowCode());
								tmoneymoveDao.add(m);
								
								//将投资记录表中对应的 投资人投资记录 状态修改
								tpi.setPiisCancel(1);
								tpi.setPicancelReason("项目流标,资金已归还,取消认投记录");
								TcprojectInvestService.update(tpi);
								
								// 发信息给用户
								TsmsinformationService smsServie = (TsmsinformationService) AppUtil
										.getBean(TsmsinformationService.class);
								TuserSafeService safe = (TuserSafeService) AppUtil
										.getBean(TuserSafeService.class);
								TUserSafe usafe = safe.queryTUserSafeByuserId(mm
										.getUserId().toString());
								Tsmsinformation s = new Tsmsinformation();
								s.setInfoId(UniqueIdUtil.genId());
								s.setServiceType(2);// 系统
								s.setMobileNum(usafe.getMobile());
								s.setMessasge("尊敬的会员你好,你在我平台投资的项目，项目融资不成功，现已将您的投资款项原路退还到您的账户，请查收!，如有疑问请联系客服人员!");
								s.setCreator(sysUser.getUserId());
								s.setStatus(0);
								s.setCreateTime(new Date());
								smsServie.add(s);// 保存
								int n=i+1;
								resultStr+="<TR><TD height=\"40\" align=\"right\">"+n+"</TD>"
										 +"<TD height=\"40\" align=\"right\">"+mm.getRealName()+"</TD>"
										 +"<TD height=\"40\" align=\"right\">"+mm.getFlowCode()+"</TD>"
										 +"<TD height=\"40\" align=\"right\">退款成功</TD>"
									     +"<TD height=\"40\" align=\"right\">"+resultCode+"</TD></TR>";
								
								
							}else{
								flag=false;
								int n=i+1;
								resultStr+="<TR><TD height=\"40\" align=\"right\">"+n+"</TD>"
										 +"<TD height=\"40\" align=\"right\">"+mm.getRealName()+"</TD>"
										 +"<TD height=\"40\" align=\"right\">"+mm.getFlowCode()+"</TD>"
										 +"<TD height=\"40\" align=\"right\">退款失败,请联系管理员!</TD>"
									     +"<TD height=\"40\" align=\"right\">"+resultCode+"</TD></TR>";
								//
								
							}
						}
					}else{
					//	return resultStr="没有在平台找到投资人的支付记录!";
						throw new Exception("没有在平台找到投资人的支付记录!");
					}
					
				}
				
				if(flag){
					tcproject.setPisBreak(1);//流标
					tcproject.setPbreakTime(new Date());
					tcproject.setPbreakRemark("项目流标,资金已归还");
					tcprojectDao.update(tcproject);//更新
				}
				
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultStr;
	}


	/**
	 * 查询预热期项目
	 * @param filter
	 * @return
	 */
	public List<Tcproject> getWarmUpProject(QueryFilter filter){
		List<Tcproject> warmPro = tcprojectDao.getWarmUpProjets(filter);
		String dateFormat = "yyy-MM-dd";

		for(Tcproject tcproject:warmPro){
			tcproject.setPopenDateStr(DateUtilWuyouchou.formatDate(tcproject.getPopenDate(),dateFormat));
			tcproject.setPcloseDateStr(DateUtilWuyouchou.formatDate(tcproject.getPcloseDate(),dateFormat));
		}

		return warmPro;
	}
	
}