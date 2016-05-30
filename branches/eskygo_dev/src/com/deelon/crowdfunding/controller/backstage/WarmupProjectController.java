package com.deelon.crowdfunding.controller.backstage;

import com.deelon.core.annotion.Action;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.common.constants.WuyouchouErrorCode;
import com.deelon.crowdfunding.common.exception.CrowdFundException;
import com.deelon.crowdfunding.common.util.DateUtilWuyouchou;
import com.deelon.crowdfunding.model.backstage.Tcproject;
import com.deelon.crowdfunding.model.backstage.TcprojectComments;
import com.deelon.crowdfunding.model.backstage.TcprojectInvest;
import com.deelon.crowdfunding.service.backstage.TcprojectService;
import com.deelon.loan.service.front.TareaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;

/**
 * <p>
 * 预热期项目controller
 * <p>
 * Created by jiang on 15/5/27.
 */
@Controller
@RequestMapping({"/crowdfunding/backstage/warmUpProject/"})
public class WarmupProjectController extends BaseController {

    @Resource
    private TcprojectService tcprojectService;
    @Autowired
    private TareaService tareaService;

    @RequestMapping({"list"})
    @Action(description = "查看预热中项目分页列表")
    public ModelAndView warmUpList(HttpServletRequest request, HttpServletResponse response) throws Exception {

        QueryFilter filter = new QueryFilter(request, "pName");
//        filter.setForWeb();
        request.setAttribute("requestURI", request.getRequestURI());
        request.setAttribute("pageBean", filter.getPageBean());

        List<Tcproject> warmProjects = tcprojectService.getWarmUpProject(new QueryFilter(request, "projectId"));
//        request.setAttribute("requestURI", request.getRequestURI());
//        request.setAttribute("pageBean", filter.getPageBean());
        ModelAndView mv = getAutoView().addObject("tprojectList", warmProjects);
        return mv;
    }

    @RequestMapping({"edit"})
    @Action(description = "编辑Tproject数据")
    public ModelAndView edit(HttpServletRequest request) throws Exception {
        Long pkId = Long.valueOf(RequestUtil.getLong(request, "projectId"));
        Tcproject tproject = null;
        List<TcprojectInvest> listI = null;
        List<TcprojectComments> listc = null;
        if (pkId.longValue() != 0L) {
            tproject = (Tcproject) this.tcprojectService.getTcprojectById(pkId);
        }
        return getAutoView().addObject("tcproject", tproject);
    }

    @RequestMapping({"approve"})
    @Action(description = "将预热项目更新为认筹中")
    public void approve(HttpServletRequest request, HttpServletResponse response) {

        Long projectId = Long.valueOf(RequestUtil.getLong(request, "projectId"));
        try {
            Tcproject tproject = (Tcproject) this.tcprojectService.getTcprojectById(projectId);

            if (null != tproject) {
                Date currentDate = new Date();
                tproject.setPneedWarmUp(0);//取消预热标识
                tproject.setPstateId("3");//更新项目状态为认筹中
                tproject.setUpdateTime(currentDate);
                //修改项目开标、结束日期
                tproject.setPopenDate(currentDate);
                Date closeDate = DateUtilWuyouchou.addDays(tproject.getPcloseDate(), tproject.getLastDays());
                tproject.setPcloseDate(closeDate);
                tcprojectService.update(tproject);
            }

            response.setStatus(HttpStatus.FOUND.value());
            response.addHeader("location", "/crowdfunding/backstage/warmUpProject/list.ht");
        } catch (Exception e) {
            logger.error("更新预热中项目为认筹中失败,erroCode = 0300010,projectId={}", projectId, e);
            throw new CrowdFundException(WuyouchouErrorCode.PRJ_BACKAGE_UPDATE_ERROR.getErrorCode());

        }
    }

    @RequestMapping({"deny"})
    @Action(description = "项目流标")
    public void deny(HttpServletRequest request, HttpServletResponse response) {

        Long projectId = Long.valueOf(RequestUtil.getLong(request, "projectId"));
        try {
            Tcproject tproject = (Tcproject) this.tcprojectService.getTcprojectById(projectId);

            if (null != tproject) {
                Date currentDate = new Date();
                tproject.setPneedWarmUp(0);
                tproject.setPstateId("7");
                tproject.setPisBreak(1);//流标
                tproject.setPbreakRemark("预热流标");
                tproject.setUpdateTime(currentDate);
                tproject.setPcloseDate(new Date());
                tcprojectService.update(tproject);
            }

            response.setStatus(HttpStatus.FOUND.value());
            response.addHeader("location", "/crowdfunding/backstage/warmUpProject/list.ht");
        } catch (Exception e) {
            logger.error("更新预热中项目为认筹中失败,erroCode = 0300010,projectId={}", projectId, e);
            throw new CrowdFundException(WuyouchouErrorCode.PRJ_BACKAGE_UPDATE_ERROR.getErrorCode());

        }
    }
}
