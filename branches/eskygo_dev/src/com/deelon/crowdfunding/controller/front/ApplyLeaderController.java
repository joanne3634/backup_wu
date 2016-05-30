package com.deelon.crowdfunding.controller.front;

import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.crowdfunding.common.constants.WuyouchouErrorCode;
import com.deelon.crowdfunding.common.exception.CrowdFundException;
import com.deelon.crowdfunding.model.backstage.TuserApplyLeader;
import com.deelon.crowdfunding.service.backstage.TuserApplyLeaderService;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.service.front.UserInfoService;
import com.deelon.platform.model.system.Dictionary;
import com.deelon.platform.service.system.DictionaryService;
import org.apache.cxf.common.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Create By [MyLiao]
 * 申请领投资格Controller
 */
@Controller
@RequestMapping({"/user/"})
public class ApplyLeaderController extends BaseController {
    @Autowired
    private UserInfoService userInfoService;
    @Autowired
    private TuserApplyLeaderService applyLeaderService;
    @Autowired
    DictionaryService dictionaryService;

    /***
     * 跳转到申请领投资格
     */
    @RequestMapping({"applyLeaderInit"})
    public ModelAndView applyLeaderInit(HttpServletRequest request, HttpServletResponse response) {
        TUser sessionUser = (TUser) request.getSession().getAttribute("user");
        if (sessionUser == null) {
            return new ModelAndView("/loginWeb.jsp");//重新登陆
        }
        String applyLeaderId = request.getParameter("applyLeaderId") + "";
        String type = request.getParameter("type");//1。从右边tap页请求2.从申请成功也请求
        List<Dictionary> list = null;
        TuserApplyLeader tuserApplyLeader = null;
        ModelAndView mv = null;

        try {
            sessionUser = userInfoService.getUserByUserId(sessionUser.getUserId());
            QueryFilter queryFilter = new QueryFilter();
            queryFilter.addFilter("loginName", sessionUser.getLoginName());
            if (null != applyLeaderId && !StringUtils.isEmpty(applyLeaderId)
                    && !"undefined".equals(applyLeaderId)
                    && !"null".equals(applyLeaderId)) {//修改
                tuserApplyLeader = applyLeaderService.getById(Long.valueOf(applyLeaderId));
            } else {
                List<TuserApplyLeader> tmplist = applyLeaderService.getApplyLeaderInfo(queryFilter);
                if (null != tmplist && tmplist.size() > 0){
                	tuserApplyLeader = tmplist.get(0);
                }
            }
            //获取项目所属行业
            if (null != dictionaryService) {
                list = dictionaryService.getByNodeKey("PIND");
            }
            String isCheck = null;
            if (null != tuserApplyLeader) {
                isCheck = null==tuserApplyLeader.getIsCheck()?null:tuserApplyLeader.getIsCheck().toString();
            }
            if ("1".equals(type) && ( "1".equals(isCheck) ||  "0".equals(isCheck))) {
                mv = new ModelAndView("/loan/front/applyLeaderSuccess.jsp").addObject("tuserApplyLeader", tuserApplyLeader);
            } else {
                mv = new ModelAndView("/loan/front/applyLeaderEdit.jsp")
                        .addObject("tuserApplyLeader", tuserApplyLeader).addObject("user", sessionUser)
                        .addObject("dictionaryList", list);
            }
        } catch (Exception e) {
            logger.error("ApplyLeaderController.applyLeaderInit error :code=020000,loginName={}", sessionUser.getLoginName(), e);
            throw new CrowdFundException(WuyouchouErrorCode.INVST_APPLY_LEADER_ERROR.getErrorCode(), WuyouchouErrorCode.INVST_APPLY_LEADER_ERROR.getErrorMsg(), e);
        }
        return mv;
    }

    /***
     * 提交申请领投资格
     */
    @RequestMapping({"subApplyLeaderInfo"})
    @ResponseBody
    public String subApplyLeaderInfo(HttpServletRequest request, HttpServletResponse response,
                                     String str, String strName, String contentText) {
        String result = "0";
        try {
            if (StringUtils.isEmpty(contentText))
                contentText = new String(request.getParameter("contentText").getBytes("iso8859-1"), "gb2312");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        String strID = request.getParameter("str");
        TUser sessionUser = (TUser) request.getSession().getAttribute("user");
        if (sessionUser == null) {
            result = "1";
            return result;
        }
        String applyLeaderId = request.getParameter("applyLeaderId") + "";
        long userId = sessionUser.getUserId();
        //增加一个存在性验证,找出除审核未通过或审核通过的记录,即在审核中的记录并返回
        //审核拒绝：2，审核通过：1
        List<TuserApplyLeader> list = this.applyLeaderService.getListByUserIdAndIsChecking(userId);
        if (null != list && 0 != list.size()) {
            result = "3";
            return result;
        }
        if (!StringUtils.isEmpty(applyLeaderId) && !"undefined".equals(applyLeaderId)) {//修改
            TuserApplyLeader tuserApplyLeader = applyLeaderService.getById(Long.valueOf(applyLeaderId));
            tuserApplyLeader.setIndustryId(str);
            tuserApplyLeader.setIndustryDesc(strName);
            tuserApplyLeader.setApplyInfo(contentText);
            tuserApplyLeader.setIsCheck(0);
            applyLeaderService.update(tuserApplyLeader);
        } else {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            TuserApplyLeader appLeader = new TuserApplyLeader();
            appLeader.setApplyLeaderId(Long.valueOf(UniqueIdUtil.genId()));
            appLeader.setUserId(userId);
            appLeader.setIndustryId(strID);
            appLeader.setIndustryDesc(strName);
            appLeader.setApplyInfo(contentText);
            appLeader.setApplyTime(new Date());
            appLeader.setIsCheck(0);
            appLeader.setChecker("0");
            appLeader.setCheckFailReason("");
            this.applyLeaderService.add(appLeader);
        }
        return result;
    }
}
