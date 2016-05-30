/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.service.front;

import java.math.BigDecimal;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.loan.dao.front.TuserSetautoDao;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.model.front.TuserSetauto;
import com.deelon.loan.service.operationLog.TuserLogService;
import com.deelon.loan.service.sysManager.TprojectService;
import com.deelon.loan.service.sysManager.TuserFundsService;

@ Service
public class TuserSetautoService extends BaseService<TuserSetauto>{
	
	@ Resource
	private TuserSetautoDao tuserSetautoDao;
	@Resource
	private TprojectService tprojectService;
	@Resource
	private TuserFundsService TuserFundsService;
	@Resource
	private TuserLogService tuserLogService;
	
	protected IEntityDao<TuserSetauto, Long> getEntityDao()
	{
		return this.tuserSetautoDao;
	}
	
	/**
	 * 保存或修改
	 * @param tuserSetauto
	 * @return
	 */
	public int saveOrUpdateTuserSetauto(TuserSetauto tuserSetauto){
		return tuserSetautoDao.saveOrUpdateTuserSetauto(tuserSetauto);
	}
	
	/**
	 * 根据用户id 查询用户最近的 投标条件设置
	 * @param userId
	 * @return
	 */
	public TuserSetauto getTuserSetautoByUserId(Long userId){
		return tuserSetautoDao.getTuserSetautoByUserId(userId);
	}
	
	/**
	 * 查询所有设置了自动投标的用户
	 * @return
	 */
	public List<TuserSetauto> getAllAutoTenderList(){
		return tuserSetautoDao.getAllAutoTenderList();
	}
	
	
	/**
	 * 自动投标 方法
	 */
	public void autoBidding(TuserSetauto auto,TUserFunds uf) throws Exception{
		
		try {
			//根据用户的投标设置 查询符合条件的招标项目
			if(auto!=null){
				
				//2.看用户是否设置了 单日自动投标金额限制,如果设置了,则自动投标的总金额不能大于这个限制
				/*if(StringUtil.isNotEmpty(auto.getAmountTypeValue())){
					if(new BigDecimal(auto.getAmountTypeValue()).compareTo(auto.getLessThan())==-1){
						throw new Exception("投标固定金额大于单日投标金额!");
					}
				}*/
				
				
				TProject tp=new TProject();
				if(auto.getIsRepayWay()!=null){
					if(auto.getIsRepayWay()==1){
						tp.setPrepayWay(auto.getRepayWay());//还款方式
					}
				}
				if(auto.getIsDeadline()!=null){
					if(auto.getIsDeadline()==1){
						tp.setPdeadline(auto.getDeadline());//还款期限
					}
				}
				
				if(auto.getIsRateOut()!=null){
					if(auto.getIsRateOut()==1){
						tp.setPrateIn(auto.getRateOut());//借款利率
					}
				}
				
				//符合条件的招标项目
				List<TProject> list=tprojectService.getAllLoanByWhere(tp);
				//1.看用户是否设置了投标金额,投标金额分 _固定投标金额 _ 按借款金额比例 _可用余额全部投标 三种
				//a.如果设置了固定投标金额 则 先赛选 招标最小金额小于用户设置的,固定金额的标   每笔投标金额 为固定金额  并且判断 固定
				/*b.如果设置了 按招标金额比例  则应是
				 *  用户设置的比例乘以 项目招标金额 大于项目的最小投资额 
				 *  并且小于 项目的招标金额乘以20%
				 */
				//c.可用余额全部招标  每笔自动投标金额 不能大于 项目的招标金额乘以20%  并且判断 每笔投标额是否大于 项目的最小投资额
				
				
				
				if(list!=null&&list.size()>0){
					BigDecimal tenderMoney=new BigDecimal(0);//用来计算投标的金额总和
					for (TProject t : list) {
						
						
						
							
							if(tenderMoney.compareTo(auto.getLessThan())<0){//是否超过单日自动投资限制
								//取出系统设置的 自动投标最大限额比例
								//每笔自动投标 不能大于 系统设置的 投标 的20%
								String autoProportion =(String)AppUtil.getServletContext().getAttribute("AUTO_TENDER_PROPORTION");
								if(StringUtil.isNotEmpty(auto.getAmountType())){
									if(auto.getAmountType().equals("1")){//固定金额
										
										//判断用户的可用资金是否够用
										if(uf.getAvailable().compareTo(new BigDecimal(auto.getAmountTypeValue()))>=0){//可用资金是否够用
											
											//设置的固定金额大于等于 项目最小投资额
											if(new BigDecimal(auto.getAmountTypeValue()).compareTo(new BigDecimal(t.getPminInvest()))>=0){
												//设置的固定金额小于等于 项目最大投资额
												if(new BigDecimal(auto.getAmountTypeValue()).compareTo(new BigDecimal(t.getPmaxInvest()))<=0){
													if(StringUtil.isNotEmpty(autoProportion)){
														//每笔自动投标 不能大于 系统设置的 投标 的20%
														if(new BigDecimal(auto.getAmountTypeValue()).compareTo(t.getPloan().multiply(new BigDecimal(autoProportion)))<=0){
															
															tprojectService.bidProject(uf.getUserId(), t.getProjectId(), auto.getAmountTypeValue(),"2");
															tenderMoney=tenderMoney.add(new BigDecimal(auto.getAmountTypeValue()));
															//如果成功 则 插入操作记录
															tuserLogService.recordUserOperation(uf.getUserId(), 2, 4, 1, 1, auto.getAmountTypeValue(),null);
														}else{//如一定要按自动投标比例设置 则 此步不要
															tprojectService.bidProject(uf.getUserId(), t.getProjectId(), auto.getAmountTypeValue(),"2");
															tenderMoney=tenderMoney.add(new BigDecimal(auto.getAmountTypeValue()));
															//如果成功 则 插入操作记录
															tuserLogService.recordUserOperation(uf.getUserId(), 2, 4, 1, 1, auto.getAmountTypeValue(),null);
														}
													}
												}
											}
										}
										
										//	}
										
										
									}else if(auto.getAmountType().equals("2")){//按招标金额比例
										
										if(StringUtil.isNotEmpty(auto.getAmountTypeValue())){
											BigDecimal tend=t.getPloan().multiply(new BigDecimal(auto.getAmountTypeValue()));
											//可用资金是否大于 设置的招标比例乘以招标金额
											if(uf.getAvailable().compareTo(tend)>=0){//可用资金是否够用
												
												//用户设置的比例乘以 项目招标金额 大于项目的最小投资额 
												// 并且小于 项目的招标金额乘以20%
												if(tend.divide(new BigDecimal(100))
														.compareTo(new BigDecimal(t.getPminInvest()))>=0){//自动投资比例*招标金额>招标最低投资金额
													if(tend.divide(new BigDecimal(100))
															.compareTo(new BigDecimal(t.getPmaxInvest()))<=0){//自动投资比例*招标金额<=招标最大投资金额
														
														if(t.getPloan().multiply(new BigDecimal(auto.getAmountTypeValue()))
																.compareTo(t.getPloan().multiply(new BigDecimal(autoProportion)))<=0){
															tprojectService.bidProject(uf.getUserId(), t.getProjectId(), auto.getAmountTypeValue(),"2");
															tenderMoney=tenderMoney.add(new BigDecimal(auto.getAmountTypeValue()));
															//如果成功 则 插入操作记录
															tuserLogService.recordUserOperation(uf.getUserId(), 2, 4, 1, 1, auto.getAmountTypeValue(),null);
														}
													}
													
												}
											}
										}
									}else{//全部可用金额投标
										
									}
								}
							}
						
					}
				}
				
				//?ModelName=2&ActionName=4
			}
		} catch (Exception e) {
			//如果失败 则 插入操作记录
			tuserLogService.recordUserOperation(uf.getUserId(), 2, 4, 1, 2, "操作失败",null);
			e.printStackTrace();
			throw e;
		}
		
		
	}

}