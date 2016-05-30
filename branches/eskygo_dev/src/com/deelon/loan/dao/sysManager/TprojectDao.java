/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.loan.dao.sysManager;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.core.page.PageBean;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.model.front.TProject;
import com.deelon.platform.model.system.SysUser;

@Repository
public class TprojectDao extends BaseDao<TProject> {

	public Class<TProject> getEntityClass() {
		return TProject.class;
	}

	/*public List<TProject> getAllProtWaitingAudit(QueryFilter queryFilter) {
		return getBySqlKey("getAllWaitingAudit", queryFilter);
	}*/

	/*public TProject getProjectById(long projectId) {
		return getUnique("getProjectById", projectId);
	}*/

	public List<TProject> getProjectByStatus(String status) {
		return getBySqlKey("getByStatusID", status);
	}

	public TProject getPJById(long projectId) {
		return getUnique("getPJById", projectId);
	}
	
	/**
	 * 获取项目,跟进业务员
	 * @param projectId 项目id
	 * @return
	 */
	public TProject getPro_clerkByProId(long projectId){
		return getUnique("getPro_clerkByProId", projectId);
	}
	
	
	/**
	 * 查询所有借款(根据条件)
	 * @param 
	 * prepayWay 还款方式
	 * prateIn 借款利率
	 * pdeadline 还款期限
	 * @return
	 */
	public List<TProject> getAllLoanByWhere(TProject tproject){
		return getBySqlKey("getProByWhere", tproject);
	}
	
	/**
	 * byId，和用户的 投资成功与否 统计
	 * @param projectId
	 * @param userId
	 * @return
	 */
	public TProject getProjectByIdandUserId(long projectId,long userId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("projectId", projectId);
		map.put("userId", userId);
		return getUnique("getProjectByIdandUserId", map);
	}
	
	
	public List<TProject> getAllProtWaitingAudit(QueryFilter queryFilter){
		
		try {
			List<TProject> list=getBySqlKey("getAllApplyPro", queryFilter);
			SysUser su=ContextUtil.getCurrentUser();
			String roles=su.getRoles();
			
			/*
			 * 根据当前登录用户 的角色 （担保审核人员,平台审核人员），
			 * 来控制 列表的数据的操作
			 * 1.担保审核人员  只能审核发起借款的数据
			 * 2.平台审核人员,只能审核 担保审核通过后的数据
			 * 3.根据tproject中的pstatusId = 1,2,3,4,5,6,7,8 来判定
			 * 1=发起申请 
			 * 2=担保审核
			 * 3=平台审核
			 * 
			 * 4.或者P_Audit_Guarantee  '担保审核',默认值0  当发起申请后 会修改 值 为 1.
	   			P_Audit_Platform '平台审核' 默认值0 当担保审核通过后 会修改 值为1
			 */
			
			List<TProject> listVo=new ArrayList<TProject>();
			if(list!=null&&list.size()>0){
				for (TProject t : list) {
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
					if(StringUtil.isNotEmpty(roles)){
						if(roles.contains("bpm_DANBAO_SHENHE_RENYUAN")){//担保审核
							if(t.getPstatusId().equals("1")){//发起申请,担保审核人员操作
								if(t.getPrrisk()==null){
									t.setAlinkAction("<a href=\"javascript:void(0)\" class=\"link primary\" onclick=\"agreeApply("+t.getProjectId()+","+t.getPstatusId()+",'0','agree');\">同意</a>&nbsp;&nbsp;&nbsp;&nbsp;"
											+"<a href=\"javascript:void(0)\" class=\"link resetPwd\" onclick=\"agreeApply("+t.getProjectId()+",'','disagree');\">流标</a>&nbsp;&nbsp;&nbsp;&nbsp;"
											+"<a href=\"get.ht?projectId="+t.getProjectId()+"&loanMoney="+t.getPloan()+"\" class=\"link setting\" >设置担保金比例</a>&nbsp;&nbsp;&nbsp;&nbsp;"
											+"<a href=\"edit.ht?userId="+t.getPapplicant()+"\" class=\"link detail\" >用户信息</a>");
								}else{
									t.setAlinkAction("<a href=\"javascript:void(0)\" class=\"link primary\" onclick=\"agreeApply("+t.getProjectId()+","+t.getPstatusId()+","+t.getPrrisk()+",'agree');\">同意</a>&nbsp;&nbsp;&nbsp;&nbsp;"
											+"<a href=\"javascript:void(0)\" class=\"link resetPwd\" onclick=\"agreeApply("+t.getProjectId()+",'','disagree');\">流标</a>&nbsp;&nbsp;&nbsp;&nbsp;"
											+"<a href=\"get.ht?projectId="+t.getProjectId()+"&loanMoney="+t.getPloan()+"\" class=\"link setting\" >设置担保金比例</a>&nbsp;&nbsp;&nbsp;&nbsp;"
											+"<a href=\"edit.ht?userId="+t.getPapplicant()+"\" class=\"link detail\" >用户信息</a>");
								}
								
								t.setAuditStatus("待审核");
							}else if(t.getPstatusId().equals("2")){//担保审核通过,修改p_statusId=2,流程已走到 平台审核环节
								t.setAlinkAction("已审核");
								
								t.setAuditStatus("已审核");
							}else if(t.getPstatusId().equals("8")){
								t.setAlinkAction("已审核");
								t.setAuditStatus("流标");
							}else{
								t.setAlinkAction("已审核");
								t.setAuditStatus("已审核");
							}
						}else if(roles.contains("bpm_PINGTAI_SHENHE_RENYUAN")){//
							if(t.getPstatusId().equals("2")){//(担保已经审核过的)平台审核,平台审核人员操作
								if(StringUtil.isEmpty(t.getPcertifiLevel())){
									t.setAlinkAction("<a href=\"javascript:void(0)\" class=\"link primary\" onclick=\"agreeApply("+t.getProjectId()+","+t.getPstatusId()+",'xyjb','agree');\">同意</a>&nbsp;&nbsp;&nbsp;&nbsp;"
											+"<a href=\"javascript:void(0)\" class=\"link resetPwd\" onclick=\"agreeApply("+t.getProjectId()+",'','disagree');\">流标</a>&nbsp;&nbsp;&nbsp;&nbsp;"
											+"<a href=\"credit.ht?projectId="+t.getProjectId()+"\" class=\"link setting\" >标的认证</a>&nbsp;&nbsp;&nbsp;&nbsp;"
											+"<a href=\"edit.ht?userId="+t.getPapplicant()+"\" class=\"link detail\" >用户信息</a>");
									//评定用户信用级别
									t.setPcertifiLevel("xyjb");
								}else{
									
									t.setAlinkAction("<a href=\"javascript:void(0)\" class=\"link primary\" onclick=\"agreeApply("+t.getProjectId()+","+t.getPstatusId()+",'"+t.getPcertifiLevel()+"','agree');\">同意</a>&nbsp;&nbsp;&nbsp;&nbsp;"
											+"<a href=\"javascript:void(0)\" class=\"link resetPwd\" onclick=\"agreeApply("+t.getProjectId()+",'','disagree');\">流标</a>&nbsp;&nbsp;&nbsp;&nbsp;"
											+"<a href=\"credit.ht?projectId="+t.getProjectId()+"\" class=\"link setting\" >标的认证</a>&nbsp;&nbsp;&nbsp;&nbsp;"
											+"<a href=\"edit.ht?userId="+t.getPapplicant()+"\" class=\"link detail\" >用户信息</a>");
								}
								t.setAuditStatus("待审核");
							}else if(t.getPstatusId().equals("1")){//担保审核中
								t.setAlinkAction("无操作权限");
								t.setAuditStatus("担保审核中");
							}else if(t.getPstatusId().equals("8")){
								t.setAlinkAction("已审核");
								t.setAuditStatus("流标");
							}else{
								t.setAlinkAction("已审核");
								t.setAuditStatus("已审核");
							}
						}else{
							t.setAlinkAction("无操作权限");
							t.setAuditStatus("");
						}
					}
					t.setPdeadlineS(t.getPdeadline()+"天");
					if(t.getPrriskRate()!=null)
					t.setPrriskRateStr(t.getPrriskRate()+"%");
//					t.setUserCreditInfo("<a href=\"edit.ht?userId="+t.getPapplicant()+"\" css=\"link detail\"  >用户信息</a>");//onclick=\"userCreditInfo("+t.getPapplicant()+");\"
					if(t.getPapplicationTime()!=null)
					t.setAppleyTime(sdf.format(t.getPapplicationTime()));
					listVo.add(t);
					
				}
			}
			return listVo;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return null;
	}

	public List<TProject> getProjectByCnd(String pType, int pDeadlineMin,
			int pDeadlineMax, String pCertifiLevel) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pType", pType);
		map.put("pDeadlineMin", pDeadlineMin);
		map.put("pDeadlineMax", pDeadlineMax);
		map.put("pCertifiLevel", pCertifiLevel);
		return getBySqlKey("getProjectByCnd", map);
	}
	public List<TProject> getProjectByCnd(TProject project) {
		return getBySqlKey("getProjectByCnd", project);
	}

	public long getMaxProjectId(){
		String getStatement = getIbatisMapperNamespace() + ".getMaxProjectId";
	    long max = (Long)getSqlSessionTemplate().selectOne(getStatement, null);
		return max+1;
	}
	
	public TProject getTProjectById(Long id){
		return getUnique("getById", id);
	}
	/**
	 * 投标修改
	 * 
	 * @param project
	 */
	public void updateProjectBybid(TProject project) {
		update("updateProjectBybid", project);
	}
	
	/**
	 * 获取所有招标中的贷款
	 * @return
	 */
	public List<TProject> getInvitationOfTenderInfo(QueryFilter queryFilter){
		
		queryFilter.addFilter("Invitation", "YES");
		long times=System.currentTimeMillis();
		Date d=new Date(times);
		queryFilter.addFilter("currentDate", d);
		Map<String,Object> map=queryFilter.getFilters();
		List<TProject> list=null;
		if(map.get("fullLoan").equals("1")){//招标中的借款
		
		
			 list=getBySqlKey("getAllWaitingAudit", queryFilter);
		}else{//满标审核
			
			 list=getBySqlKey("getAllWaitingAudit2", queryFilter);
		}
		
		return list;
	}
	
	/**
	 * 取得用户的投资记录
	 * @param UserId
	 * @return
	 */
	public List<TProject> getUserInvestList(QueryFilter queryFilter){
		return getBySqlKey("getUserInvestList", queryFilter);
	}
	/**
	 * 根据用户设定的条件查询投资项目
	 * @param queryFilter
	 * @return
	 */
	public List<TProject> getProByWhere(QueryFilter queryFilter){
		return getBySqlKey("getProByWhere", queryFilter);
	}
	
	/**
	 * 获取用户关注的借款
	 * @param pb 
	 * @param userId
	 * @return
	 */
	public List<TProject> getUserFocusBorrowOnTpro(TProject tproject, PageBean pb){
		return getBySqlKey("getUserFocusBorrowOnTpro", tproject,pb);
	}
	/**
	 * 查询等待放款的记录
	 * @param queryFilter
	 * @return
	 */
	public List<TProject> getWaitingForTheLoanList(QueryFilter queryFilter){
		List<TProject> list=getBySqlKey("getWaitingForTheLoanList", queryFilter);
		if(list!=null&&list.size()>0){
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
			for (TProject t : list) {
				if(t.getPhavedPay()==0){
					t.setAlinkAction("<a href=\"javascript:void(0)\" class=\"link detail\" onclick=\"agreePayLoan("+t.getProjectId()+");\">放款</a>&nbsp;&nbsp;");
				}else{
					t.setAlinkAction("已放款");//&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"edit.ht?projectId="+t.getProjectId()+"\" class=\"link edit\" >填写备注</a>
				}
				if(t.getPhavedPayTime()!=null)
					t.setHavedPayTimeStr(sdf.format(t.getPhavedPayTime()));
			}
		}
		return list;
	}
	
	/**
	 * 查询流标的借款
	 * @param queryFilter
	 * @return
	 */
	public List<TProject> getBreakedList(QueryFilter queryFilter){
		List<TProject> listVo=getBySqlKey("getBreakedList", queryFilter);
		if(listVo!=null&&listVo.size()>0){
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
			for (TProject t : listVo) {
				if(t.getPopenDate()!=null){//招标阶段的流标
					t.setAlinkAction("<a href=\"javascript:void(0)\" onclick=\"deblockingForFund("+t.getProjectId()+");\">解冻资金</a>");
				}else{
					t.setAlinkAction("无冻结资金");
				}
				if(t.getPapplicationTime()!=null)
					t.setHavedPayTimeStr(sdf.format(t.getPapplicationTime()));
			}
		}
		return listVo;
	}
	
	/**
	 * 查询所有借款
	 * @param queryFilter
	 * @return
	 */
	public List<TProject> getAllLoan(QueryFilter queryFilter){
		return getBySqlKey("getAllLoan", queryFilter);
	}
	
	/**
	 * 查询所有借款（根据条件）
	 * @param map
	 * @return
	 */
	public List<TProject> getAllLoanByWhere(Map map,PageBean pb){
		return getBySqlKey("gettprojectByWhere", map,pb);
	}
	
	/**
	 * 查询所有借款（根据条件）,微信版
	 * @param map
	 * @return
	 */
	public List<TProject> wxgetAllLoanByWhere(Map map,PageBean pb){
		return getBySqlKey("wxgettprojectByWhere", map,pb);
	}
	
	/**
	 * 获取用户的理财信息
	 * @param userId
	 * @return
	 */
	public List<TProject> getPersonalFinanceByUserId(long userId){
		
		return getBySqlKey("getPersonalFinanceByUserId", userId);
	}
	
	/**
	 * 查询用户的借款账户
	 * @param userId
	 * @return
	 */
	public List<TProject> getPersnalLoanByUserId(long userId){
		return getBySqlKey("getPersnalLoanByUserId", userId);
	}
 
}
