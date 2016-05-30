package com.deelon.crowdfunding.service.front;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.deelon.core.util.AppUtil;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.crowdfunding.common.util.TUserUtil;
import com.deelon.crowdfunding.dao.backstage.TcprojectAttachmentDao;
import com.deelon.crowdfunding.dao.backstage.TcprojectDao;
import com.deelon.crowdfunding.dao.backstage.TcprojectHistoryplanDao;
import com.deelon.crowdfunding.dao.backstage.TcprojectHpPaymentsDao;
import com.deelon.crowdfunding.dao.backstage.TcprojectModelDao;
import com.deelon.crowdfunding.dao.backstage.TcprojectNewsDao;
import com.deelon.crowdfunding.dao.backstage.TcprojectTeamDao;
import com.deelon.crowdfunding.model.backstage.Tcproject;
import com.deelon.crowdfunding.model.backstage.TcprojectAttachment;
import com.deelon.crowdfunding.model.backstage.TcprojectHistoryplan;
import com.deelon.crowdfunding.model.backstage.TcprojectHpPayments;
import com.deelon.crowdfunding.model.backstage.TcprojectModel;
import com.deelon.crowdfunding.model.backstage.TcprojectNews;
import com.deelon.crowdfunding.model.backstage.TcprojectTeam;
import com.deelon.loan.model.front.TUser;
import com.deelon.platform.model.system.SysUser;
import com.fr.third.org.apache.poi.hssf.record.formula.functions.Request;
import com.wabacus.util.Logger;

/**
 * 前台创业者对项目的设置控制服务类
 * @author Administrator
 *
 */
@ Service
public class TcprojectFrontSaveService {
	@ Resource
	private TcprojectDao tcprojectDao;
	
	@ Resource
	private TcprojectModelDao tcprojectModelDao;
	
	@ Resource
	private TcprojectTeamDao tcprojectTeamDao;
	
	@ Resource
	private TcprojectHistoryplanDao tcprojectHistoryplanDao;
	
	@ Resource
	private TcprojectHpPaymentsDao tcprojectHpPaymentsDao;
	
	@ Resource
	private TcprojectAttachmentDao tcprojectAttachmentDao;
	
	@ Resource
	private TcprojectNewsDao tcprojectNewsDao;
	/**
	 * 保存众筹项目
	 * @param project
	 * @return
	 */
	public Tcproject saveTcprojectBasicInfo(Tcproject project){
		try{
			project.setCreateTime(new Date());
			project.setPvideo("");
			project.setPcomplete(0);
			project.setPstateId("0");//初次保存项目 项目状态为0,发起申请后再修改为1 pyg 2/5
			project.setPfinancingAmount(project.getPfinancingAmount().multiply(new BigDecimal(10000)));//统一计算单位，前台传入的是万元单位
			//计算项目最小领投和跟投金额，小于10000按一万元算
			String investS = (String)AppUtil.getServletContext().getAttribute("INVESTOR_MIN_PERCENT");//最低跟投系数
			String leaderS = (String)AppUtil.getServletContext().getAttribute("LEADER_MIN_PERCENT");//最低领投系数
			String leaderMaxS = (String)AppUtil.getServletContext().getAttribute("LEADER_MAX_PERCENT");//最低领投系数
			if(StringUtil.isEmpty(leaderMaxS)||project.getPfinancingAmount().multiply(new BigDecimal(leaderMaxS).divide(new BigDecimal(100), 3, RoundingMode.UP)).compareTo(new BigDecimal(10000))<=0){
				project.setPinvestMaxLeader(new BigDecimal(10000));
			}else{
				project.setPinvestMaxLeader(project.getPfinancingAmount().multiply(new BigDecimal(leaderMaxS).divide(new BigDecimal(100), 3, RoundingMode.UP)).divide(new BigDecimal(10000), 0, RoundingMode.UP).multiply(new BigDecimal(10000)));
				if(project.getPinvestMaxLeader().compareTo(project.getPfinancingAmount())>0){
					project.setPinvestMaxLeader(project.getPfinancingAmount());
				}
			}
			if(StringUtil.isEmpty(leaderS)||project.getPfinancingAmount().multiply(new BigDecimal(leaderS).divide(new BigDecimal(100), 3, RoundingMode.UP)).compareTo(new BigDecimal(10000))<=0){
				project.setPinvestMinLeader(new BigDecimal(10000));
			}else{
				project.setPinvestMinLeader(project.getPfinancingAmount().multiply(new BigDecimal(leaderS).divide(new BigDecimal(100), 3, RoundingMode.UP)).divide(new BigDecimal(10000), 0, RoundingMode.UP).multiply(new BigDecimal(10000)));
				if(project.getPinvestMinLeader().compareTo(project.getPfinancingAmount())>0){
					project.setPinvestMinLeader(project.getPfinancingAmount());
				}
			}
			if(StringUtil.isEmpty(investS)||project.getPfinancingAmount().multiply(new BigDecimal(investS).divide(new BigDecimal(100), 3, RoundingMode.UP)).compareTo(new BigDecimal(10000))<=0){
				project.setPinvestMinFollow(new BigDecimal(10000));
			}else{
				project.setPinvestMinFollow(project.getPfinancingAmount().multiply(new BigDecimal(investS).divide(new BigDecimal(100), 3, RoundingMode.UP)).divide(new BigDecimal(10000), 0, RoundingMode.UP).multiply(new BigDecimal(10000)));
				if(project.getPinvestMinFollow().compareTo(project.getPfinancingAmount())>0){
					project.setPinvestMinFollow(project.getPfinancingAmount());
				}
			}
			project.setUpdateTime(new Date());
			if(null!=project.getProjectId()&&project.getProjectId().compareTo(new Long(0))>0){//存在大于0的id则是修改项目基本信息
				tcprojectDao.update(project);
			}else{//如果是新增则为其生成主键唯一号
				project.setProjectId(UniqueIdUtil.genId());
				tcprojectDao.add(project);
			}
		}catch(Exception e){
			Logger.error("保存项目信息失败。"+e.getCause());
			throw new RuntimeException();
		}
		
		return project;
	}
	
	/**
	 * 保存众筹项目的商业模式信息
	 * @param project
	 * @return TcprojectModel
	 */
	public TcprojectModel saveTcprojectModelInfo(TcprojectModel projectModel){
		try{
			if(null!=projectModel.getModelId()&&projectModel.getModelId().compareTo(new Long(0))>0){//存在大于0的id则是修改项目基本信息
				tcprojectModelDao.update(projectModel);
			}else{//如果是新增则为其生成主键唯一号
				projectModel.setModelId(UniqueIdUtil.genId());
				tcprojectModelDao.add(projectModel);
			}
		}catch(Exception e){
			e.printStackTrace();
			Logger.error("保存项目商业模式信息失败。"+e.getCause());
			throw new RuntimeException();
		}
		
		return projectModel;
	}
	
	/**
	 * 保存众筹项目的团队信息
	 * @param project
	 * @return
	 */
	public TcprojectTeam saveTcprojectTeamInfo(TcprojectTeam projectTeam){
		try{
			if(null!=projectTeam.getTeamId()&&projectTeam.getTeamId().compareTo(new Long(0))>0){//存在大于0的id则是修改项目基本信息
				tcprojectTeamDao.update(projectTeam);
			}else{//如果是新增则为其生成主键唯一号
				projectTeam.setTeamId(UniqueIdUtil.genId());
				tcprojectTeamDao.add(projectTeam);
			}
		}catch(Exception e){
			Logger.error("保存项目团队信息失败。"+e.getCause());
			throw new RuntimeException();
		}
		
		return projectTeam;
	}
	
	/**
	 * 保存众筹项目的历史和未来计划信息
	 * @param project
	 * @return
	 */
	public TcprojectHistoryplan saveTcprojectHistoryAndPlanInfo(TcprojectHistoryplan projectHistoryplan){
		try{
			if(null!=projectHistoryplan.getHistoryPlanId()&&projectHistoryplan.getHistoryPlanId().compareTo(new Long(0))>0){//存在大于0的id则是修改项目基本信息
				tcprojectHistoryplanDao.update(projectHistoryplan);
			}else{//如果是新增则为其生成主键唯一号
				projectHistoryplan.setHistoryPlanId(UniqueIdUtil.genId());
				tcprojectHistoryplanDao.add(projectHistoryplan);
			}
			for(TcprojectHpPayments payment:projectHistoryplan.getListHpPayMent()){
				payment.setHistoryPlanId(projectHistoryplan.getHistoryPlanId());
				saveTcprojectHistoryAndPlanPayInfo(payment);
			}
		}catch(Exception e){
			Logger.error("保存项目历史和未来计划信息失败。"+e.getCause());
			throw new RuntimeException();
		}
		
		return projectHistoryplan;
	}
	/**
	 * 保存众筹项目的历史和未来计划的收支信息
	 * @param project
	 * @return
	 */
	public TcprojectHpPayments saveTcprojectHistoryAndPlanPayInfo(TcprojectHpPayments projectHpPayments){
		try{
			if(null!=projectHpPayments.getPaymentsId()&&projectHpPayments.getPaymentsId().compareTo(new Long(0))>0){//存在大于0的id则是修改项目基本信息
				tcprojectHpPaymentsDao.update(projectHpPayments);
			}else{//如果是新增则为其生成主键唯一号
				projectHpPayments.setPaymentsId(UniqueIdUtil.genId());
				tcprojectHpPaymentsDao.add(projectHpPayments);
			}
		}catch(Exception e){
			Logger.error("保存项历史和未来计划的收支信息失败。"+e.getCause());
			throw new RuntimeException();
		}
		
		return projectHpPayments;
	}
	
	/**
	 * 保存众筹项目的附件信息
	 * @param project
	 * @return
	 */
	public TcprojectAttachment saveTcprojectAttachmentInfo(TcprojectAttachment projectAttachment){
		try{
			if(null!=projectAttachment.getAttachmentId()&&projectAttachment.getAttachmentId().compareTo(new Long(0))>0){//存在大于0的id则是修改项目基本信息
				tcprojectAttachmentDao.update(projectAttachment);
			}else{//如果是新增则为其生成主键唯一号
				projectAttachment.setAttachmentId(UniqueIdUtil.genId());
				tcprojectAttachmentDao.add(projectAttachment);
			}
		}catch(Exception e){
			Logger.error("保存项目附件信息失败。"+e.getCause());
			throw new RuntimeException();
		}
		
		return projectAttachment;
	}
	
	/**
	 * 保存众筹项目的动态信息
	 * @param project
	 * @return
	 */
	public TcprojectNews saveTcprojectNewsInfo(TcprojectNews projectNews){
		try{
			if(null!=projectNews.getNewsId()&&projectNews.getNewsId().compareTo(new Long(0))>0){//存在大于0的id则是修改项目基本信息
				tcprojectNewsDao.update(projectNews);
			}else{//如果是新增则为其生成主键唯一号
				projectNews.setNewsId(UniqueIdUtil.genId());
				projectNews.setCreateTime(new Date());
				projectNews.setPntypeId(1);
				tcprojectNewsDao.add(projectNews);
			}
		}catch(Exception e){
			Logger.error("保存项目动态信息失败。"+e.getCause());
			throw new RuntimeException();
		}
		
		return projectNews;
	}
}
