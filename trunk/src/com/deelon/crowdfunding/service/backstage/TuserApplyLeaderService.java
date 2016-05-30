package com.deelon.crowdfunding.service.backstage;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.crowdfunding.dao.backstage.TuserApplyLeaderDao;
import com.deelon.crowdfunding.model.backstage.TuserApplyLeader;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.service.front.TUserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Powered By [MyLiao]
 * 申请领投资格审核Service
 */
@Service
public class TuserApplyLeaderService extends BaseService<TuserApplyLeader> {

    @Resource
    private TuserApplyLeaderDao tuserApplyLeaderDao;

    @Resource
    private TUserService tcuserService;

    protected IEntityDao<TuserApplyLeader, Long> getEntityDao() {
        return this.tuserApplyLeaderDao;
    }

    /**
     * 查询所有申请领投资格信息
     *
     * @param queryFilter
     * @return
     */
    public List<TuserApplyLeader> getApplyLeaderInfo(QueryFilter queryFilter) {
        List<TuserApplyLeader> list = this.tuserApplyLeaderDao.getApplyLeaderInfo(queryFilter);
        /*if(list!=null && list.size()>0){
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			for(TuserApplyLeader leaderInfo : list) {
				if(leaderInfo.getApplyTime()!=null)
					leaderInfo.setApplyTimeStr(sdf.format(leaderInfo.getApplyTime()));
				if(leaderInfo.getCheckTime()!=null)
					leaderInfo.setCheckTimeStr(sdf.format(leaderInfo.getCheckTime()));
			}
		}*/
        return list;
    }

    /**
     * 更新申请领投资格的审核状态
     *
     * @category 在更改领投资格的同时更新其用户状态
     */
    public boolean passByIds(Long[] applyLeaderIDs) {
        try {
            for (int i = 0; i < applyLeaderIDs.length; i++) {
                TuserApplyLeader leaderObj = getById(applyLeaderIDs[i]);
                leaderObj.setIsCheck(1);
                update(leaderObj);//审核通过
                TUser userObj = this.tcuserService.getById(leaderObj.getUserId());
                userObj.setIsLeader(1);//更新是否领头人
                this.tcuserService.update(userObj);
            }

        } catch (Exception e) {
            //logger.error("众筹项目放款异常。");
            //throw new RuntimeException("众筹项目放款异常。");
            e.printStackTrace();
        }
        return true;
    }

    /**
     * 更新申请领投资格的审核状态
     *
     * @category 在更改领投资格的同时更新其用户状态
     */
    public boolean failByIds(Long[] applyLeaderIDs) {
        try {
            for (int i = 0; i < applyLeaderIDs.length; i++) {
                TuserApplyLeader leaderObj = getById(applyLeaderIDs[i]);
                leaderObj.setIsCheck(2);
                update(leaderObj);//审核通过
                TUser userObj = this.tcuserService.getById(leaderObj.getUserId());
                userObj.setIsLeader(0);//更新是否领头人
                this.tcuserService.update(userObj);
            }
            return true;
        } catch (Exception e) {
            logger.error("众筹项目放款异常。");
            throw new RuntimeException("众筹项目放款异常。");
        }
    }


    /**
     * 更新申请领投资格的审核状态
     *
     * @category 只针对审核失败的投资人，重新审核
     */
    public boolean cancel(Long[] applyLeaderIDs) {
        try {
            for (int i = 0; i < applyLeaderIDs.length; i++) {
                TuserApplyLeader leaderObj = getById(applyLeaderIDs[i]);
                leaderObj.setIsCheck(0);
                update(leaderObj);//撤销审核
            }
            return true;
        } catch (Exception e) {
            logger.error("众筹项目放款异常。");
            throw new RuntimeException("众筹项目放款异常。");
        }
    }

    /**
     * 查询领投人信息
     *
     * @param leaderId
     * @return
     */
    public TuserApplyLeader getLeaderInfoDetail(long leaderId) {
        return tuserApplyLeaderDao.getLeaderInfoDetail(leaderId);
    }

    /**
     * 根据用户id查询正在审核中的领头人信息
     *
     * @param userId
     * @return
     */
    public List<TuserApplyLeader> getListByUserIdAndIsChecking(long userId) {
        TuserApplyLeader user = new TuserApplyLeader();
        user.setUserId(userId);
        return tuserApplyLeaderDao.getListByPojo(user);
    }
}