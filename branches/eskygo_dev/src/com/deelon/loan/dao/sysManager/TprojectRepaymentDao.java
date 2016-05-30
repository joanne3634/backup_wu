package com.deelon.loan.dao.sysManager;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Calendar;
import java.util.Date;

import org.apache.ibatis.transaction.Transaction;
import org.apache.ibatis.transaction.TransactionFactory;
import org.apache.ibatis.transaction.jdbc.JdbcTransactionFactory;
import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.model.front.TProjectRepayment;

@Repository
public class TprojectRepaymentDao extends BaseDao<TProjectRepayment> {

	public Class getEntityClass() {
		return TProjectRepayment.class;
	}
	/**
	 * 获取最大的还款id
	 * @return
	 */
	public long getMaxProjectRepayId(){
		String getStatement = getIbatisMapperNamespace() + ".getMaxProjectRepayId";
		Long max = (Long)getSqlSessionTemplate().selectOne(getStatement, null);
		if(null==max){
			return 1;
		}else{
			return max+1;	
		}
	}
	
	public static void main(String[] args) {
		Calendar theCa = Calendar.getInstance();
		Double dd = (30*0.55);
		System.out.println(dd.intValue());
		for(int i=1;i<=12;i++){
			theCa.add(theCa.DATE, +dd.intValue());
			System.out.println(theCa.getTime());
		}
		System.out.println(new BigDecimal(1.01).pow(12).multiply(new BigDecimal(100)).divide((new BigDecimal(1.01).pow(12).subtract(new BigDecimal(1))),9,RoundingMode.HALF_UP));
		 TProject project = new TProject();
		 project.setPdeadline(12);
		 project.setPloanReal(new BigDecimal(10000));
		 project.setPrateIn(new BigDecimal(12));
		 System.out.println((project.getPloanReal().subtract(new BigDecimal(833.33).multiply(new BigDecimal(2-1)))).multiply(project.getPrateIn().divide(new BigDecimal(1200),9,RoundingMode.HALF_UP)));
		 System.out.println(project.getPloanReal().multiply(project.getPrateIn().divide(new BigDecimal(1200),9,RoundingMode.HALF_UP)));
		 System.out.println(project.getPloanReal().multiply(project.getPrateIn().divide(new BigDecimal(1200),9,RoundingMode.HALF_UP))
					.multiply((project.getPrateIn().divide(new BigDecimal(1200),9,RoundingMode.HALF_UP).add(new BigDecimal(1))).pow(project.getPdeadline()))
					.divide(((project.getPrateIn().divide(new BigDecimal(1200),9,RoundingMode.HALF_UP).add(new BigDecimal(1))).pow(project.getPdeadline())).subtract(new BigDecimal(1)),9,RoundingMode.HALF_UP));
	}
	/**
	 * 根据项目的实际借款金额、还款方式和借款利率生成项目的还款计划
	 * 还款方式：字典值，1、一次性还本付息；2、先息后本，每月还款；3、等额本息还款；4、等额本金还款
	 * 借款年利率是prateIn记录值
	 * @param project
	 * @return BigDecimal 返回值是计算得来的项目利息总和，需要修改到项目psumInterest属性对应的字段值
	 */
	public BigDecimal addRepayMent(TProject project) {
		BigDecimal psumInterest = new BigDecimal(0);
		BigDecimal psumPricipal = new BigDecimal(0);
		TProjectRepayment tr = new TProjectRepayment();
		tr.setProjectId(project.getProjectId());
		tr.setPrRepayWay(project.getPrepayWay());
		tr.setPrRepayer(project.getPapplicant());
		Calendar theCa = Calendar.getInstance();
		theCa.setTime(new Date());
		if("1".equals(project.getPrepayWay())){//如果是第一种还款方式 一次性还本付息
			tr.setRepaymentId(getMaxProjectRepayId());
			theCa.add(theCa.DATE, +(project.getPdeadline()*30));
			tr.setPrCurrentOfAll("1/1");
			tr.setPrCurrent(project.getPdeadline());
			tr.setPrPrincipal(project.getPloanReal());
			//一次计算总利息
			tr.setPrInterest(project.getPloanReal().multiply(project.getPrateIn().multiply(new BigDecimal(project.getPdeadline())).divide(new BigDecimal(1200),9,RoundingMode.HALF_UP)).setScale(3, RoundingMode.HALF_UP));
			tr.setPrPlanPayTime(theCa.getTime());
			tr.setPrPay(tr.getPrInterest().add(tr.getPrPrincipal()));
			tr.setPrRealPay(new BigDecimal(0.00));
			tr.setPrIsPayoff(0);
			tr.setPrPayless(project.getPloanReal().add(tr.getPrInterest()));
			tr.setPrLate(new BigDecimal(0.00));
			tr.setPrisLate(0);
			tr.setPrLateDays(0);
			tr.setPrIsDone(0);
			psumInterest = psumInterest.add(tr.getPrInterest());
			add(tr);
		}else if("2".equals(project.getPrepayWay())){//先息后本，每月还款
			for(int i=1;i<=project.getPdeadline();i++){
				tr.setRepaymentId(getMaxProjectRepayId());
				theCa.add(theCa.DATE, 30);
				tr.setPrCurrentOfAll(i+"/"+project.getPdeadline());
				tr.setPrCurrent(i);
				if(i==project.getPdeadline()){//先息后本，最后一期才将本金还上
					tr.setPrPrincipal(project.getPloanReal());	
				}else{//不是最后一期还的本金都为0
					tr.setPrPrincipal(new BigDecimal(0.00));
				}
				tr.setPrInterest(project.getPloanReal().multiply(project.getPrateIn().divide(new BigDecimal(1200),9,RoundingMode.HALF_UP)).setScale(3, RoundingMode.HALF_UP));
				tr.setPrPlanPayTime(theCa.getTime());
				tr.setPrPay(tr.getPrInterest().add(tr.getPrPrincipal()));
				tr.setPrRealPay(new BigDecimal(0.00));
				tr.setPrIsPayoff(0);
				tr.setPrPayless(tr.getPrPrincipal().add(tr.getPrInterest()));
				tr.setPrLate(new BigDecimal(0.00));
				tr.setPrisLate(0);
				tr.setPrLateDays(0);
				tr.setPrIsDone(0);
				psumInterest = psumInterest.add(tr.getPrInterest());
				add(tr);
			}
		}else if("3".equals(project.getPrepayWay())){//等额本息还款
			for(int i=1;i<=project.getPdeadline();i++){
				tr.setRepaymentId(getMaxProjectRepayId());
				theCa.add(theCa.DATE, +30);
				tr.setPrCurrentOfAll(i+"/"+project.getPdeadline());
				tr.setPrCurrent(i);
				//先根据等额本息的公式计算每月还款的等额本息数
				tr.setPrPay(project.getPloanReal().multiply(project.getPrateIn().divide(new BigDecimal(1200),9,RoundingMode.HALF_UP))
						.multiply((project.getPrateIn().divide(new BigDecimal(1200),9,RoundingMode.HALF_UP).add(new BigDecimal(1))).pow(project.getPdeadline()))
						.divide(((project.getPrateIn().divide(new BigDecimal(1200),9,RoundingMode.HALF_UP).add(new BigDecimal(1))).pow(project.getPdeadline())).subtract(new BigDecimal(1)),9,RoundingMode.HALF_UP).setScale(3, RoundingMode.HALF_UP));
				tr.setPrPlanPayTime(theCa.getTime());
				//计算每期还款中利息金额
				tr.setPrInterest((project.getPloanReal().subtract(psumPricipal)).multiply(project.getPrateIn().divide(new BigDecimal(1200),9,RoundingMode.HALF_UP)).setScale(3, RoundingMode.HALF_UP));
				//等额本金减去每期利息就是每期的本金
				tr.setPrPrincipal(tr.getPrPay().subtract(tr.getPrInterest()));
				tr.setPrRealPay(new BigDecimal(0.00));
				tr.setPrIsPayoff(0);
				tr.setPrPayless(tr.getPrPay());
				tr.setPrLate(new BigDecimal(0.00));
				tr.setPrisLate(0);
				tr.setPrLateDays(0);
				tr.setPrIsDone(0);
				psumInterest = psumInterest.add(tr.getPrInterest());
				psumPricipal = psumPricipal.add(tr.getPrPrincipal());
				add(tr);
			}
		}else if("4".equals(project.getPrepayWay())){//等额本金还款
			for(int i=1;i<=project.getPdeadline();i++){
				tr.setRepaymentId(getMaxProjectRepayId());
				theCa.add(theCa.DATE, +30);
				tr.setPrCurrentOfAll(i+"/"+project.getPdeadline());
				tr.setPrCurrent(i);
				//等额本金，先将本金总额除以贷款期数，得到每期本金
				tr.setPrPrincipal(project.getPloanReal().divide(new BigDecimal(project.getPdeadline()),9,RoundingMode.HALF_UP).setScale(3, RoundingMode.HALF_UP));	
				tr.setPrPlanPayTime(theCa.getTime());
				//计算每期利息
				tr.setPrInterest((project.getPloanReal().subtract(tr.getPrPrincipal().multiply(new BigDecimal(i-1)))).multiply(project.getPrateIn().divide(new BigDecimal(1200),9,RoundingMode.HALF_UP)).setScale(3, RoundingMode.HALF_UP));
				//等额每期本金加上每期的应还利息就等于每期应还金额
				tr.setPrPay(tr.getPrInterest().add(tr.getPrPrincipal()));
				tr.setPrRealPay(new BigDecimal(0.00));
				tr.setPrIsPayoff(0);
				tr.setPrPayless(tr.getPrPrincipal().add(tr.getPrInterest()));
				tr.setPrLate(new BigDecimal(0.00));
				tr.setPrisLate(0);
				tr.setPrLateDays(0);
				tr.setPrIsDone(0);
				psumInterest = psumInterest.add(tr.getPrInterest());
				add(tr);
			}
		}
		//根据以上算法，每期应还利息相加得到借款应还总利息。返回给项目用于统计项目的应还总利息
		return psumInterest;
	}
}
