/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.loan.service.sysManager;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.encrypt.EncryptUtil;
import com.deelon.core.page.PageBean;
import com.deelon.core.service.BaseService;
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.DateUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.dao.front.TProjectInvestDao;
import com.deelon.loan.dao.front.TprojectAcceptDao;
import com.deelon.loan.dao.front.TprojectRiskDao;
import com.deelon.loan.dao.front.TriskCompanyDao;
import com.deelon.loan.dao.sysManager.TprojectDao;
import com.deelon.loan.dao.sysManager.TprojectRepaymentDao;
import com.deelon.loan.dao.sysManager.TuserFundsDao;
import com.deelon.loan.exception.ProjectException;
import com.deelon.loan.model.front.TMoneymove;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.model.front.TProjectAccept;
import com.deelon.loan.model.front.TProjectInvest;
import com.deelon.loan.model.front.TProjectRepayment;
import com.deelon.loan.model.front.TProjectRisk;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.model.front.TriskCompany;
import com.deelon.loan.service.front.TmoneymoveService;
import com.deelon.loan.service.front.TprojectInvestService;
import com.deelon.loan.service.front.UserInfoService;
import com.deelon.loan.service.operationLog.TuserLogService;
import com.deelon.platform.model.system.SysUser;

@Service
public class TprojectService extends BaseService<TProject> {

	@Resource
	private TprojectDao tprojectDao;
	@Resource
	private TprojectInvestService tprojectInvestService;
	@Resource
	private TuserFundsService TuserFundsService;
	@Resource
	private TProjectInvestDao tProjectInvestDao;
	@Resource
	private TprojectAcceptDao tprojectAcceptDao;
	@Resource
	private TprojectRepaymentDao tprojectRepaymentDao;
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private TuserFundsDao tuserFundsDao;
	@Autowired
	private TprojectRiskDao tprojectRiskDao;
	@Resource
	private TriskCompanyDao triskCompanyDao;
	@Resource
	private TmoneymoveService tmoneymoveService;
	
	
	protected IEntityDao<TProject, Long> getEntityDao() {
		return this.tprojectDao;
	}

	/**
	 * 查找待审核的，初审中的借款
	 * 
	 * @param queryFilter
	 * @return
	 */
	public List<TProject> getAllProtWaitingAudit(QueryFilter queryFilter) {
		return tprojectDao.getAllProtWaitingAudit(queryFilter);
	}

	public TProject getTProjectById(Long id) {
		return tprojectDao.getTProjectById(id);
	}

	/**
	 * 获取所有招标中的贷款
	 * @return
	 */
	public List<TProject> getInvitationOfTenderInfo(QueryFilter queryFilter){
		return tprojectDao.getInvitationOfTenderInfo(queryFilter);
	}
	
	/**
	 * 新增或者修改贷款项目
	 * 
	 * @param project
	 * @return
	 * @throws Exception 
	 */
	public long saveorUpdateProject(TProject project) throws Exception {
		if (project.getProjectId() > 0) {
			tprojectDao.update(project);
		} else {
			project.setProjectId(tprojectDao.getMaxProjectId());
			//初始化项目风险表的数据
			TProjectRisk entity = new TProjectRisk();
			entity.setRiskId(UniqueIdUtil.genId());
			entity.setProjectId(project.getProjectId());
			entity.setPrriskRate(new BigDecimal(AppUtil.getServletContext().getAttribute("RISK_FEE_PROPORTION").toString()));
			entity.setPrrisk(new BigDecimal(0));
			entity.setPraudit(0);
			entity.setPrcompay(0L);
			entity.setPradvice("");
			entity.setPrreplacePay(new BigDecimal(0));
			entity.setPrisReplacePay(0);
			tprojectRiskDao.add(entity);
			//修改平台借出利率默认为借入利率减去平台设置的利率差
			tprojectDao.add(project);
		}
		return project.getProjectId();
	}
	/**
	 * 添加借款项目的还款计划
	 * 
	 * @param project
	 * @return BigDecimal psumInterest
	 */
	public BigDecimal saveProjectRepayments(TProject project) {
		
		BigDecimal psumInterest = tprojectRepaymentDao.addRepayMent(project);
		return psumInterest;
	}
	/**
	 * 获取投标中的贷款项目
	 * 
	 * @return
	 */
	public List<TProject> getTenderProjects() {
		// 假设StatusID为2的为投标中的项目
		return tprojectDao.getProjectByStatus("2");
	}

	public TProject getProjectById(long projectId) {
		return tprojectDao.getPJById(projectId);
	}
	
	/**
	 * 获取项目,跟进业务员
	 * @param projectId 项目id
	 * @return
	 */
	public TProject getPro_clerkByProId(long projectId){
		return tprojectDao.getPro_clerkByProId(projectId);
	}
	
	/**
	 * byId，和用户的 投资成功与否 统计
	 * @param projectId
	 * @param userId
	 * @return
	 */
	public TProject getProjectByIdandUserId(long projectId,long userId) {
		return tprojectDao.getProjectByIdandUserId(projectId,userId);
	}

	/**
	 * 对一个贷款项目进行投标
	 * @param userId 投资人id
	 * @param projectId 投资项目id
	 * @param money 投资金额
	 * @param piTypeId 投标类型 1为手动投标,2为自动投标
	 * @throws Exception
	 */

	public synchronized void bidProject(long userId, long projectId, String money,String piTypeId)
			throws Exception {
		TUserFunds userFunds = tuserFundsDao.getTUserFundsByUserId(userId);
		if (userFunds.getAvailable().compareTo(new BigDecimal(money))<0) {
			throw new Exception("借出金额超出可用金额!");
		}
		
		try {
			// 改变标的数据和状态
			TProject project = tprojectDao.getById(projectId);
			
			
			//如果还需招标金额小于最低投标金额
			if(project.getPloan().subtract(project.getPloanReal()).compareTo(new BigDecimal(project.getPminInvest()))<0){
				throw new Exception("该项目已经停止招标!");
			}
			//招标金额=实际招标金额
			if(project.getPloan().compareTo(project.getPloanReal())==0){
				throw new Exception("该项目已经停止招标!");
			}
			//再次判断投资金额是否已经超过 招标的还需金额
			if(project.getPloan().subtract(project.getPloanReal()).compareTo(new BigDecimal(money))<0){
				throw new Exception("您最多能投资"+project.getPloan().subtract(project.getPloanReal())+"元!");
			}
			
			
			
			
	//		tprojectDao.update(project);//.updateProjectBybid(project);
			
//			TProject pro = tprojectDao.getById(projectId);
			
			//如果进度达到100%停止招标
			if(project.getPcomplete()>=100){
				throw new Exception("该项目已经停止招标!");
			}
			
			project.setPbided(project.getPbided() + 1);
			project.setPloanReal(project.getPloanReal().add(new BigDecimal(money)));
			// 计算贷款项目完成进度
			double a=project.getPloanReal().divide(project.getPloan(),2,BigDecimal.ROUND_HALF_UP).doubleValue()*100;
						
			project.setPcomplete((int)a);
			tprojectDao.update(project);//.updateProjectBybid(project);

			//先查看投资人是否已经投资过 该项目,如果投资过,则修改,反之
			
		
			TProjectInvest proji=tprojectInvestService.getTProjectInvestByUserIdAndProId(project.getProjectId(),userId);
			if(proji!=null){
				proji.setPiAmount(proji.getPiAmount().add(new BigDecimal(money)));
				proji.setPiEffectAmount(proji.getPiEffectAmount().add(new BigDecimal(money)));
				proji.setPiBidTime(new Date());
				
				tprojectInvestService.update(proji);
			}else{
				// 插入项目投资记录
				TProjectInvest projectInvest = new TProjectInvest();
				projectInvest.setProjectId(projectId);
				projectInvest.setPiInvestors(userId);
				projectInvest.setPiAmount(new BigDecimal(money));
				projectInvest.setPiEffectAmount(new BigDecimal(money));
				projectInvest.setPiBidTime(new Date());
				projectInvest.setPitypeID(piTypeId);//1人工投标,2自动投标
				//projectInvest.setPiHavedPay(0);
				//	projectInvest.setPiIsCancel(1);
				projectInvest.setPiGetSum(new BigDecimal(0));
				projectInvest.setPiBeGetSum(new BigDecimal(0));
				projectInvest.setPiGetRateSum(new BigDecimal(0));
				projectInvest.setPiBeGetRateSum(new BigDecimal(0));
				projectInvest.setPiGetPrincipalSum(new BigDecimal(0));
				projectInvest.setPiBeGetPrincipalSum(new BigDecimal(0));
				projectInvest.setPiGetLate(new BigDecimal(0));
				projectInvest.setPiIsPayoff(0);
				tProjectInvestDao.add(projectInvest);//saveTProjectInvest(projectInvest);
			}
			
			
			// 减少用户可用资金
			TuserFundsService.userFundsChangeFunction(null, userFunds, userFunds.getUserId(), new BigDecimal(money),null,  "3",null,"");//投资投标
			
		} catch (Exception e) {
			// TODO: handle exception
			logger.error(e.getMessage());
			
			e.printStackTrace();
			throw  e;
		}
		
		
	}

	/**
	 * 搜索投标中的贷款项目
	 * 
	 * @return
	 */
	public List<TProject> searchTenderProject(String pType, int pDeadlineMin,
			int pDeadlineMax, String pCertifiLevel) {
		return tprojectDao.getProjectByCnd(pType, pDeadlineMin, pDeadlineMax,
				pCertifiLevel);
	}
	
	/**
	 * 取得用户的投资记录
	 * @param UserId
	 * @return
	 */
	public List<TProject> getUserInvestList(QueryFilter queryFilter){
		return tprojectDao.getUserInvestList(queryFilter);
	}
	
	/**
	 * 根据用户设定的条件查询投资项目
	 * @param queryFilter
	 * @return
	 */
	public List<TProject> getProByWhere(QueryFilter queryFilter){
		return tprojectDao.getProByWhere(queryFilter);
	}
	
	
	/**
	 * 根据查询条件获取我的借款项目的列表内容
	 * @param start
	 * @param end
	 * @param status
	 * @param userId
	 * @param pb 
	 * @return
	 */
	public List<TProject> getmyinProjects(String start, String end,String status, long userId, PageBean pb) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("status", status);
		if(null!=start&&""!=start){
			map.put("start", DateUtil.parseDate(start+" 00:00:00"));
		}
		if(null!=end&&""!=end){
			map.put("end", DateUtil.parseDate(end+" 23:59:59"));
		}
		map.put("userId", userId);
		return tprojectDao.getBySqlKey("getProjectByCnd", map,pb);
	}
	/**
	 * 我的借款统计信息
	 * @param status
	 * @param userId
	 * @return
	 */
	public TProject getmyLoanStatistics(String status, long userId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("status", status);
		map.put("userId", userId);
		return tprojectDao.getUnique("getprojectStatistics", map);	
	}
	
	/**
	 * 获取用户关注的借款
	 * @param pb 
	 * @param userId
	 * @return
	 */
	public List<TProject> getUserFocusBorrowOnTpro(TProject tproject, PageBean pb){
		return tprojectDao.getUserFocusBorrowOnTpro(tproject,pb);
	}
	
	/**
	 * 查询等待放款的记录
	 * @param queryFilter
	 * @return
	 */
	public List<TProject> getWaitingForTheLoanList(QueryFilter queryFilter){
		return tprojectDao.getWaitingForTheLoanList(queryFilter);
	}
	
	/**
	 * 查询流标的借款
	 * @param queryFilter
	 * @return
	 */
	public List<TProject> getBreakedList(QueryFilter queryFilter){
		
		
		return tprojectDao.getBreakedList(queryFilter);
	}
	
	/**
	 * 查询所有借款
	 * @param queryFilter
	 * @return
	 */
	public List<TProject> getAllLoan(QueryFilter queryFilter){
		return tprojectDao.getAllLoan(queryFilter);
	}
	
	/**
	 * 查询所有借款(根据条件)
	 * @param map
	 * @return
	 * 
	 */
	public List<TProject> getAllLoanByWhere(Map map,PageBean pb){
		return tprojectDao.getAllLoanByWhere(map,pb);
	}
	
	/**
	 * 查询所有借款(根据条件)
	 * @param 参数对象
	 * @param prepayWay 还款方式
	 * @param prateIn 借款利率
	 * @param  pdeadline 还款期限
	 * @return
	 */
	public List<TProject> getAllLoanByWhere(TProject tproject){
		return tprojectDao.getAllLoanByWhere(tproject);
	}
	
	/**
	 * 查询所有借款(根据条件),微信版
	 * @param map
	 * @return
	 */
	public List<TProject> wxgetAllLoanByWhere(Map map,PageBean pb){
		return tprojectDao.wxgetAllLoanByWhere(map,pb);
	}
	
	/**
	 * 项目还款处理接口
	 * @param projectId
	 * @param repaymentId
	 * @param paypwd
	 * @param user
	 * @return JSONObject
	 */
	@Transactional(rollbackFor=Exception.class) 
	public JSONObject repaymenting(String projectId, String repaymentId, String paypwd, TUser user) {
		JSONObject json = new JSONObject();
		try{
			
			TProjectRepayment repayment = tprojectRepaymentDao.getById(Long.parseLong(repaymentId));
			if(null!=user){
				//验证支付密码是否正确
				if (user.getTradingPwdErrCount() >= 3) {
					logger.error("交易密码输入错误次数3次!");
					json.put("result", "交易密码输入错误次数3次!请稍候再操作，或者联系客服人员。");
					return json;
				}
				if(!EncryptUtil.encryptSha256(paypwd).equals(userInfoService.getTUserByLoginName(user.getLoginName()).getTradingPwd())){
					user.setTradingPwdErrCount(user.getTradingPwdErrCount()+1);
					userInfoService.editUserInfo(user);
					json.put("result", "交易密码输入错误，如果忘记交易密码请联系客服人员。");
					return json;
				}
				TUserFunds userFunds = userInfoService.getUserFundsInfo(user.getUserId());
				
				if(userFunds.getAvailable().longValue()<repayment.getPrPay().longValue()){
					json.put("result", "账户可用余额不足，请充值之后再进行还款操作。");
					return json;
				}else{//从借款账户中扣除还款金额
					
					TuserFundsService.userFundsChangeFunction(null, userFunds, userFunds.getUserId(), repayment.getPrPay(), null, "4",null,"");
					
				}
			}else{//担保机构代付业务处理
				//获取项目的担保风险记录
				TProjectRisk risk = tprojectRiskDao.getTprojectRiskInfoByProjectId(Long.parseLong(projectId));
				//验证担保机构支付密码
				List<TriskCompany> riskComs = triskCompanyDao.getBySqlKey("findById",(null!=risk)? risk.getPrcompay():0);
				if(null==risk||null==riskComs||riskComs.size()<=0){
					json.put("result", "该项目没有担保机构担保的记录，请核实项目之后再进行处理。");
					return json;
				}
				if(!EncryptUtil.encryptSha256(paypwd).equals(riskComs.get(0).getRcPaypwd())){//担保机构的支付密码比较
					json.put("result", "交易密码输入错误，请核实后再进行操作。");
					return json;
				}
				//调用银行接口处理支付
				repayment.getPrPay();//本期应还
				repayment.getPrLate();//逾期罚息
				
				//回写项目风险担保记录的数据
				risk.setPrisReplacePay(1);
				risk.setPrreplacePay(risk.getPrreplacePay().add(repayment.getPrPay()).add(repayment.getPrLate()));
				risk.setPrreplacePayTime(new Date());
				tprojectRiskDao.update(risk);
			}
			//调用私有还款处理方法处理数据
			repaying(repayment, Long.parseLong(projectId));
			json.put("result", "1");
		}catch (Exception e) {
			e.printStackTrace();
			json.put("result", "还款操作失败。");
			logger.error("还款操作失败!");
			throw new RuntimeException();
		}
		return json;
	}
	/**
	 * 私有 方法处理还款之后项目还款表和投资人投资记录及项目的汇总还款数额
	 * @param repayment
	 * @param projectId
	 * @throws Exception 
	 */
	private void repaying(TProjectRepayment repayment, Long projectId) throws Exception{
		//修改还款记录
		repayment.setPrRealPay(repayment.getPrPay());
		repayment.setPrPayless(new BigDecimal(0));
		repayment.setPrRealPayTime(new Date());
		repayment.setPrIsDone(1);
		repayment.setPrIsPayoff(1);
		tprojectRepaymentDao.update(repayment);
		
		TProject project = tprojectDao.getById(projectId);
		project.setPsumHavedPay(repayment.getPrRealPay().add(null==project.getPsumHavedPay()?new BigDecimal(0):project.getPsumHavedPay()));
		project.setPsumHavedPayInterest(repayment.getPrInterest().add(null==project.getPsumHavedPayInterest()?new BigDecimal(0):project.getPsumHavedPayInterest()));
		project.setPsumHavedPayPrincipal(repayment.getPrPrincipal().add(null==project.getPsumHavedPayPrincipal()?new BigDecimal(0):project.getPsumHavedPayPrincipal()));
		project.setCurrentNum(repayment.getPrCurrent());
		project.setPupdateTime(new Date());
		
		//修改收款记录(根据用户分组计算每个用户投资比例插入本期还款的收款记录)
		List<TProjectInvest> invests = tProjectInvestDao.getTprojectInvestByProIdForUserGet(projectId);
		 
		TProjectAccept projectAccept = null;
		for(TProjectInvest tpi:invests){
			//初始化还款接收记录
			projectAccept = new TProjectAccept();
			projectAccept.setAcceptId(UniqueIdUtil.genId());
			projectAccept.setInvestId(tpi.getInvestId());
			projectAccept.setProjectId(projectId);
			projectAccept.setRepaymentId(repayment.getRepaymentId());
			projectAccept.setPainvestors(tpi.getPiInvestors());
			//加入借入借出利率比例的效果，计算理财用户利息占比计算每期还款所得利息
			projectAccept.setPainterest(repayment.getPrInterest().multiply(project.getPrateOut().divide(project.getPrateIn(),9,RoundingMode.HALF_UP)).multiply(tpi.getPiEffectAmount().divide(project.getPloanReal(),9,RoundingMode.HALF_UP)).setScale(3, RoundingMode.HALF_UP));
			projectAccept.setPaprincipal(repayment.getPrPrincipal().multiply(tpi.getPiEffectAmount().divide(project.getPloanReal(),9,RoundingMode.HALF_UP)).setScale(3, RoundingMode.HALF_UP));
			projectAccept.setPapayBack(projectAccept.getPainterest().add(projectAccept.getPaprincipal()));
			
			//如果借出和借入和利率平台设置了不一样，则将还款还利息相对于理财用户的利息减去理财用户收益的利息差额记录到平台收入里
			if(!project.getPrateIn().equals(project.getPrateOut())){
				TuserFundsService.userFundsChangeFunction(null, null, repayment.getPrRepayer(), repayment.getPrInterest().multiply(tpi.getPiEffectAmount().divide(project.getPloanReal(),9,RoundingMode.HALF_UP)).subtract(projectAccept.getPainterest()), null, "10",null,"");//平台利率差额收入
			}
			
			projectAccept.setPapayBackTime(new Date());
			projectAccept.setPalate(repayment.getPrLate().multiply(tpi.getPiEffectAmount().divide(project.getPloanReal(),9,RoundingMode.HALF_UP)).setScale(3, RoundingMode.HALF_UP));
			projectAccept.setPalateDays(repayment.getPrLateDays());
			projectAccept.setPaisLate(repayment.getPrisLate());
			projectAccept.setPaisReplacePay(0);
			projectAccept.setPareplacePay(new BigDecimal(0));
			projectAccept.setPaOldinvestors(0);
			projectAccept.setPaHavePay(1);
			if(project.getPdeadline()==repayment.getPrCurrent()){//如果是最后一期则修改为已还清
				tpi.setPiIsPayoff(1);
			}
			if(1==tpi.getPiTransferStateId()||5==tpi.getPiTransferStateId()){//如果正在进行债权转让则修改还款接收表的记录为不支付，正在转让中
				projectAccept.setPaTransfering(1);
				projectAccept.setPaHavePay(0);//修改为未支付
			}else{
				//更新投资表的已收金额和待收金额
				 dealRepaymentAcceptAndInvests(tpi, projectAccept);
			}
			tprojectAcceptDao.add(projectAccept);
		}
		//修改项目记录
		if(project.getPdeadline()==repayment.getPrCurrent()){
			project.setPisPayOff((short) 1);//设置项目状态为已还清
			project.setPstatusId("7");//设置项目状态为已还款
		}
		tprojectDao.update(project);
	}
	/**
	 * 处理还款记录的投资人收入逻辑方法
	 * @param invest 投资人投资记录
	 * @param accept 投资人接收还款记录
	 * @return
	 */
	public boolean dealRepaymentAcceptAndInvests(TProjectInvest invest, TProjectAccept accept){
		try{
			invest.setPiGetRateSum(invest.getPiGetRateSum().add(accept.getPainterest()));
			invest.setPiBeGetRateSum(invest.getPiBeGetRateSum().subtract(accept.getPainterest()).setScale(3, RoundingMode.HALF_UP));
			invest.setPiGetPrincipalSum(invest.getPiGetPrincipalSum().add(accept.getPaprincipal()));
			invest.setPiBeGetPrincipalSum(invest.getPiBeGetPrincipalSum().subtract(accept.getPaprincipal()).setScale(3, RoundingMode.HALF_UP));
			invest.setPiGetLate(accept.getPalate());
			invest.setPiGetSum(invest.getPiGetSum().add(accept.getPainterest().add(accept.getPaprincipal())));
			invest.setPiBeGetSum(invest.getPiBeGetSum().subtract(accept.getPainterest().add(accept.getPaprincipal())).setScale(3, RoundingMode.HALF_UP));
			tprojectInvestService.update(invest);//修改投资人所得还款额和待收额。
			//修改投资者收款用户的账户可用金额
			TuserFundsService.userFundsChangeFunction(null, null, invest.getPiInvestors(), accept.getPapayBack().add(accept.getPalate()), null, "5",null,"");
			 
			return true;
		}catch(Exception e){
			logger.error("处理还款，投资人收款信息失败，");
			throw new RuntimeException();
		}
	}
	
	/**
	 * 获取用户的理财信息
	 * @param userId
	 * @return
	 */
	public List<TProject> getPersonalFinanceByUserId(long userId){
		
		
		return tprojectDao.getPersonalFinanceByUserId(userId);
	}
	
	/**
	 * 查询用户的借款账户
	 * @param userId
	 * @return
	 */
	public List<TProject> getPersnalLoanByUserId(long userId){
		return tprojectDao.getPersnalLoanByUserId(userId);
	}
	/**
	 * 平台放款，插入还款计划和处理投资解冻资金及其借款和投资用户的资金处理
	 * @param id projectId
	 * @param sysUser 
	 */
	public void platformPayProject(long id, SysUser sysUser) throws Exception{
		try{
			//修改 t_project 中的 相应字段
			TProject p=getById(id);
			
			
			//调用还款计划接口,列出还款计划
			BigDecimal psumInterest = saveProjectRepayments(p);
			//应还总额 是 在扣除 担保金 平台手续费前 计算.
			//比如 实际借款3000 ,担保金 50,手续费 40 那么计算应还总额 则应根据 实际借款的3000来计算,
			p.setPsumInterest(psumInterest);//设置项目根据还款方式算得的总利息
			p.setPsumPayBack(psumInterest.add(p.getPloanReal()));//设置借款项目应还总额
			
			
			//1.扣除 担保机构的担保金费用
			TProjectRisk risk=tprojectRiskDao.getTProjectRiskByProId(p.getProjectId());
			BigDecimal big=p.getPloanReal().multiply(risk.getPrriskRate().divide(new BigDecimal(100))).setScale(2, BigDecimal.ROUND_HALF_UP);//担保手续费
			
			
			
			//2.扣除平台的手续费 (按比例 字典参数)
			//
			String poundage =(String)AppUtil.getServletContext().getAttribute("BORROWING_SUCCESS_FEES");//平台手续费比例
			 BigDecimal big2=new BigDecimal(0);
			if(StringUtil.isNotEmpty(poundage))
				big2=p.getPloanReal().multiply(new BigDecimal(poundage).divide(new BigDecimal(100))).setScale(2, BigDecimal.ROUND_HALF_UP);//平台手续费
				
			//	big2.divide(new BigDecimal(100));
			TUserFunds uaco=TuserFundsService.getTUserFundsByUserId(p.getPapplicant());//借款人账户
			if(uaco!=null){
				//将扣取的担保金插入资金流动记录
				inMoneyMove(p.getPapplicant(),"6",big,uaco.getAvailable().add(uaco.getFreeze()),new BigDecimal(0));
				//将扣取的平台手续费 插入资金流动记录
				inMoneyMove(p.getPapplicant(),"7",big2,uaco.getAvailable().add(uaco.getFreeze()),new BigDecimal(0));
			}else{
				throw new Exception("用户账户异常,请检查是否创建资金账户!");
			}
			
			
			BigDecimal big_big2=big.add(big2);
			//3.更新借款项目
		//	p.setPloanReal(p.getPloanReal().subtract(big_big2));//扣取手续费后的 实际借款金额
			
			p.setPhavedPay((short)1);
			p.setPhavedPayTime(new Date());
			p.setPhavedPayer(sysUser.getUserId());
			
			
			
			p.setPstatusId("6");
			update(p);
			
			
			//TO-DO调用银行接口 放款给借款人
			 //放款金额 应为                实际到账金额=  实际借款金额-担保金-平台手续费
			//如果银行扣款成功
			
			
			// 3修改借款人账户 
		//	TUserFunds ufu=TuserFundsService.getTUserFundsByUserId(p.getPapplicant());//借款人
		//	if(ufu!=null){
			//先判断 实际借款金额够不够减 平台手续费和担保金 
			if(p.getPloanReal().compareTo(big_big2)>=0){
				
				uaco.setAvailable(uaco.getAvailable().add(p.getPloanReal().subtract(big_big2)));//可用余额增加
			}else{
				throw new Exception("操作异常!"+"实际借款金额小于要扣取的手续费!");
			}
			uaco.setBalance(uaco.getAvailable().add(uaco.getFreeze()));//总金额重新计算
		//	}
			
			//资金记录 资金记录表插入一条记录
			TMoneymove t=new TMoneymove(); 
			t.setUserId(uaco.getUserId());
			t.setCardId(0);//这里 如果有多个银行卡的话，就先取第一个
			t.setTypeId("1");//充值
			t.setResultId("1");
			t.setMoneyInOut(p.getPloanReal().subtract(big_big2));//实际招标金额-平台手续费-担保金
			t.setMoneyCurrent(uaco.getAvailable().add(uaco.getFreeze()));//t_user_funds表的账户余额
			t.setCreateTime(new Timestamp(System.currentTimeMillis()));
			t.setGetFee(big_big2);//手续费
			t.setRemark("");
			TuserFundsService.saveOrUpdateToFunds(uaco, t);
//			TuserFundsService.update(ufu);
			
			
			//修改 t_project_invest中的相应字段
			//查询出同一个项目的所有投资
			List<TProjectInvest> list=tprojectInvestService.getTprojectInvestByProId(id,null);
			if(list!=null&&list.size()>0){
				for (TProjectInvest tpi : list) {
					tpi.setPiBeGetRateSum(p.getPsumInterest().multiply(p.getPrateOut().divide(p.getPrateIn(),9,RoundingMode.HALF_UP)).multiply(tpi.getPiEffectAmount().divide(p.getPloanReal(),9,RoundingMode.HALF_UP)).setScale(3, RoundingMode.HALF_UP));
					tpi.setPiBeGetPrincipalSum(tpi.getPiEffectAmount());
					tpi.setPiBeGetSum(tpi.getPiBeGetRateSum().add(tpi.getPiBeGetPrincipalSum()));
					tpi.setPiHavedPay(1);
					tpi.setPiHavedPayTime(new Date());
					tprojectInvestService.update(tpi);
					
					//修改 t_user_funds 中的冻结金额 和余额   投资成功，减少冻结金额即可
					TuserFundsService.userFundsChangeFunction(null, null, tpi.getPiInvestors(), tpi.getPiEffectAmount(), null, "9",null,"");
//					TUserFunds uf=TuserFundsService.getTUserFundsByUserId(tpi.getPiInvestors());//投资人
//					if(uf!=null){
//						
//						uf.setFreeze(uf.getFreeze().subtract(tpi.getPiEffectAmount()));
//						uf.setBalance(uf.getFreeze().add(uf.getAvailable()));
//						TuserFundsService.update(uf);
//					}
				}
			}
			
			
			//发短信或邮件给贷款人
		}catch (Exception e) {
			logger.error("放款失败，事务回滚");
			e.printStackTrace();
			throw new Exception("放款失败，事务回滚!");
		}
				
	}
	
	/**
	 * 
	 * @param userId//用户id
	 * @param typeId 资金类型 
	 * @param moneyIn //金额
	 * @param currentMoney 当前账户余额
	 * @param getFee 手续费
	 */
	public void inMoneyMove(long userId,String typeId,BigDecimal moneyIn,BigDecimal currentMoney,BigDecimal getFee){
		//资金记录 资金记录表插入一条记录
		TMoneymove t=new TMoneymove(); 
		t.setUserId(userId);
		t.setCardId(0);//这里 如果有多个银行卡的话，就先取第一个
		t.setTypeId(typeId);//充值
		t.setResultId("1");
		t.setMoneyInOut(moneyIn);//实际招标金额-平台手续费-担保金
		t.setMoneyCurrent(currentMoney);//t_user_funds表的账户余额
		t.setCreateTime(new Timestamp(System.currentTimeMillis()));
		t.setGetFee(getFee);//手续费
		t.setRemark("");
		tmoneymoveService.add(t);
	}
	
	
}