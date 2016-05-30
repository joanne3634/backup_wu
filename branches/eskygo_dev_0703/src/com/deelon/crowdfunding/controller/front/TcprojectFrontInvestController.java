/*
 * Powered By [Allen]
 * Since 1011 - 1011
 */


package com.deelon.crowdfunding.controller.front;

import com.deelon.core.annotion.Action;
import com.deelon.core.page.PageBean;
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.DateUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.servlet.ValidCode;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.common.constants.WuyouchouConfigKeys;
import com.deelon.crowdfunding.common.constants.WuyouchouErrorCode;
import com.deelon.crowdfunding.common.exception.CrowdFundException;
import com.deelon.crowdfunding.common.util.FileUtil;
import com.deelon.crowdfunding.common.util.TUserUtil;
import com.deelon.crowdfunding.model.backstage.Tcproject;
import com.deelon.crowdfunding.model.backstage.TcprojectAttachment;
import com.deelon.crowdfunding.model.backstage.TcprojectInvest;
import com.deelon.crowdfunding.service.backstage.TcprojectAttachmentService;
import com.deelon.crowdfunding.service.backstage.TcprojectInvestService;
import com.deelon.crowdfunding.service.backstage.TcprojectService;
import com.deelon.crowdfunding.service.front.TProjectApplyViewService;
import com.deelon.loan.model.aboutus.TUserMsgRemind;
import com.deelon.loan.model.front.TAttention;
import com.deelon.loan.model.front.TMoneymove;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.model.sysManager.Tbank;
import com.deelon.loan.service.aboutus.TUserMsgRemindService;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TmoneymoveService;
import com.deelon.loan.service.sysManager.TattentionService;
import com.deelon.loan.service.sysManager.TbankService;
import com.deelon.loan.service.sysManager.TuserFundsService;
import com.deelon.payform.common.PayCommon;
import com.deelon.payform.common.moneymoremore.PayCommonMoney;
import com.deelon.payform.common.moneymoremore.RongpayConfig;
import com.deelon.payform.common.moneymoremore.RongpayService;
import com.deelon.platform.service.util.ServiceUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping({"/crowdfunding/front/tcprojectinvest/"})
public class TcprojectFrontInvestController extends BaseController {
    @Resource
    private TuserFundsService tuserFundsService;
    @Resource
    private TcprojectInvestService tcprojectInvestService;
    @Resource
    private TUserMsgRemindService tuserMsgRemindService;
    @Resource
    private TcprojectService tcprojectService;
    @Resource
    private TmoneymoveService tmoneymoveService;
    @Resource
    private TattentionService tattentionService;
    @Resource
    private TUserService tuserService;
    @Autowired
    private TProjectApplyViewService tProjectApplyViewService;
    @Autowired
    TcprojectAttachmentService tcprojectAttachmentService;

    @Resource
    private TbankService tbankService;


    @RequestMapping({"list"})
    @Action(description = "查看询价审核TcprojectInvest分页列表")
    public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws Exception {
        QueryFilter qf = new QueryFilter(request, "tcprojectInvestItem");
        qf.addFilter("piisCancel", "0");//没有撤销的投资记录
        if (!StringUtil.isEmpty(request.getParameter("Q_piinvestTime_DL"))) {
            qf.addFilter("piinvestTimeBegin", DateUtil.parseDate(request.getParameter("Q_piinvestTime_DL") + " 00:00:00"));
            qf.addFilter("piinvestTimeEnd", DateUtil.parseDate(request.getParameter("Q_piinvestTime_DL") + " 11:59:59"));
        }
        List<TcprojectInvest> list = this.tcprojectInvestService.getAll(qf);
        ModelAndView mv = getAutoView().addObject("tcprojectInvestList", list);
        return mv;
    }

    @RequestMapping({"get"})
    @Action(description = "查看TcprojectInvest数据")
    public ModelAndView get(HttpServletRequest request, HttpServletResponse response) throws Exception {
        long pkId = RequestUtil.getLong(request, "investId");
        TcprojectInvest tcprojectInvest = (TcprojectInvest) this.tcprojectInvestService.getById(Long.valueOf(pkId));
        String preurl = "";
        if ("1".equals(request.getParameter("list"))) {
            preurl = "list";
        } else {
            preurl = "paylist";
        }
        return getAutoView().addObject("tcprojectInvest", tcprojectInvest).addObject("preurl", preurl);
    }

    @RequestMapping({"paylist"})
    @Action(description = "查看单个项目投资人付款TcprojectInvest分页列表")
    public ModelAndView paylist(HttpServletRequest request, HttpServletResponse response) throws Exception {
        QueryFilter qf = new QueryFilter(request, "tcprojectInvestItem");
        qf.addFilter("projectId", request.getParameter("projectId"));//投资项目id
        qf.addFilter("piisCancel", "0");//没有撤销的投资记录
        if (!StringUtil.isEmpty(request.getParameter("Q_pipayTime_DL"))) {
            qf.addFilter("pipayTimeBegin", DateUtil.parseDate(request.getParameter("Q_pipayTime_DL") + " 00:00:00"));
            qf.addFilter("pipayTimeEnd", DateUtil.parseDate(request.getParameter("Q_pipayTime_DL") + " 11:59:59"));
        }
        List<TcprojectInvest> list = this.tcprojectInvestService.getAll(qf);
        ModelAndView mv = getAutoView().addObject("tcprojectInvestList", list).addObject("preurl", "/loan/sysManager/tcproject/list.ht");
        return mv;
    }

    @RequestMapping({"uploadSurvey"})
    @Action(description = "上传调查报告与评价")
    public ModelAndView uploadSurvey(HttpServletRequest request, HttpServletResponse response) {
        /*try {
            request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
        response.setContentType("text/html;charset=utf-8");
        TUser user = (TUser) request.getSession().getAttribute("user");
        String projectId = request.getParameter("projectId");
        String investId = request.getParameter("investId");
        String pi_evaluationteam = request.getParameter("pi_evaluationteam");
        String pi_evaluationproject = request.getParameter("pi_evaluationproject");
        String fileNameAtt = request.getParameter("fileNameAtt");
        String attachmentId = request.getParameter("attachmentId");
        try {
            if (StringUtil.isNotEmpty(pi_evaluationteam)) {
                pi_evaluationteam = new String(pi_evaluationteam.getBytes("ISO-8859-1"), "Utf-8");
            }
            if (StringUtil.isNotEmpty(pi_evaluationproject)) {
                pi_evaluationproject = new String(pi_evaluationproject.getBytes("ISO-8859-1"), "Utf-8");
            }
            if (StringUtil.isNotEmpty(fileNameAtt)) {
                fileNameAtt = new String(fileNameAtt.getBytes("ISO-8859-1"), "Utf-8");
            }
        } catch (UnsupportedEncodingException e) {
            logger.error("", e);
        }

        String projectName = null;
        if (StringUtils.isNotEmpty(projectId)) {
            Tcproject tp = tcprojectService.getById(Long.valueOf(projectId));
            if (tp != null) {
                projectName = tp.getPname();
            }
        }

        request.setAttribute("pi_evaluationteam", pi_evaluationteam);
        request.setAttribute("pi_evaluationproject", pi_evaluationproject);//pyg 2/3
        request.setAttribute("fileNameAtt", fileNameAtt);//pyg 2/3
        request.setAttribute("attachmentId", attachmentId);

        return new ModelAndView("/crowdfunding/front/myProjectInvestor/uploadSurvey.jsp")
                .addObject("projectId", projectId).addObject("projectName", projectName)
                .addObject("investId", investId);
    }

    @RequestMapping({"openUploadDialog"})
    @Action(description = "打开上传窗口")
    public ModelAndView openUploadDialog(HttpServletRequest request, HttpServletResponse response) {
        String projectId = request.getParameter("projectId");
        String investId = request.getParameter("investId");
        String projectName = null;
        if (StringUtils.isNotEmpty(projectId)) {
            Tcproject tp = tcprojectService.getById(Long.valueOf(projectId));
            if (tp != null)
                projectName = tp.getPname();
        }
        ///	return new ModelAndView("/crowdfunding/front/myProjectInvestor/uploadSurveyDialog.jsp")
        return new ModelAndView("/crowdfunding/front/myProjectInvestor/auditMaterialsUpload.jsp")
                .addObject("projectId", projectId).addObject("projectName", projectName)
                .addObject("investId", investId);
    }


//    public static void main(String[] args) {
//        try {
//            String body = new String("项目认投".getBytes(), "utf-8");
//            System.out.println("str========" + body);
//
//        }
//        catch (Exception e){
//            e.printStackTrace();
//        }
//
//    }

    /**
     * 上传调查报告与评价
     *
     * @param request
     * @param response
     * @param materialsId 材料Id
     * @return
     * @throws IOException
     */
    @RequestMapping({"uploadSurveyFileUpload"})
    public void uploadSurveyFileUpload(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        PrintWriter writer = response.getWriter();
        String msg = null;
        String docSizeStr = (String) AppUtil.getServletContext().getAttribute("DOC_UPLOAD_LIMIT");
        Long docSize = StringUtil.isEmpty(docSizeStr) ? WuyouchouConfigKeys.DOC_SIZE_LIMIT_DEFAULT : Long.valueOf(docSizeStr);
        String uploadType = (String) AppUtil.getServletContext().getAttribute("DOC_UPLOAD_TYPE");
        uploadType = StringUtil.isEmpty(uploadType) ? WuyouchouConfigKeys.DOC_UPLOAD_TYPE_DEFAULT : uploadType;
        String[] fileType = uploadType.split("[;]");

        //long userId = ContextUtil.getCurrentUserId().longValue();
        String investId = RequestUtil.getString(request, "investId");
        String projectId = RequestUtil.getString(request, "projectId");
//	  String uploadType = RequestUtil.getString(request, "uploadType");
        String CKEditorFuncNum = RequestUtil.getString(request, "CKEditorFuncNum");//ck控件上传
        //String catKey=RequestUtil.getString( request, "catKey" );//ck控件上传
        String nodeKey = RequestUtil.getString(request, "nodeKey");//ck控件上传

        //取得已经填写的评价信息 pyg 2/3
        String pi_evaluationteam = RequestUtil.getString(request, "pi_evaluationteam");
        String pi_evaluationproject = RequestUtil.getString(request, "pi_evaluationproject");
        String pcode = null;
        TcprojectAttachment tcprojectAttachment = null;

        try {
//            boolean mark = true;
            // TUser user = getSessionUser(request);
            Long userId = TUserUtil.getLogUser(request).getUserId();
            //file_upload/uploadSurvey/10000019280000/2014/11
            String attachPath = ServiceUtil.getBasePath().replace("/", "\\");

            Map<String, MultipartFile> files = ((MultipartRequest) request).getFileMap();
            int size = files.size();
            if (size > 1) {
                msg = "一次只能上传一份文件，请重试";
            }
//            String fileJson = "";
            Iterator<MultipartFile> it = files.values().iterator();
            while (it.hasNext()) {
                Long fileId = Long.valueOf(UniqueIdUtil.genId());
                MultipartFile f = (MultipartFile) it.next();
                Long fileSize = f.getSize();
                if (FileUtil.isExceedSizeLimitation(f, docSize)) {
                    this.logger.error(f.getOriginalFilename() + "文件过大！size=" + f.getSize());
                    msg = "文件太大，请修改文件，系统限制为10M";
                }
                if (!FileUtil.isFileTypeMatched(f, fileType)) {
                    this.logger.error(f.getOriginalFilename() + "文件类型不正确");
                    msg = "文件格式不正确。系统支持的格式为：" + uploadType + ",请修改文件";
                }

                String oriFileName = f.getOriginalFilename();
                String extName = FileUtil.getFileExt(oriFileName);

                if (StringUtil.isEmpty(msg)) {
                    String fileName = fileId + "." + extName;
                    String projectPath = request.getSession().getServletContext().getRealPath("/");
                    String filePath = "";
                    filePath = createFilePath(attachPath);
                    String realPath = projectPath + filePath;
                    File realPathFile = new File(realPath);
                    if (!realPathFile.exists()) {
                        realPathFile.mkdirs();
                    }

                    this.logger.info("上传的文件路径：" + filePath);
                    String extpath = filePath.replace("\\", "/") + "/" + fileName;
                    TcprojectInvest tcprojectvsest = null;

                    try {

                        FileUtil.writeByte(realPath + File.separator + fileName, f.getBytes());
                        Long attachmentId = UniqueIdUtil.genId();
                        tcprojectAttachment = new TcprojectAttachment();
                        tcprojectAttachment.setAttachmentId(attachmentId);
                        tcprojectAttachment.setProjectId(Long.valueOf(0));
                        tcprojectAttachment.setPaname(oriFileName);
                        tcprojectAttachment.setPafileName(oriFileName);
                        tcprojectAttachment.setPapath(extpath);
                        tcprojectAttachment.setCreator(userId); //用户Id
                        tcprojectAttachment.setCreateTime(new Date());
                        tcprojectAttachmentService.add(tcprojectAttachment);
                        if (investId != null && investId.trim().length() > 0) {
                            tcprojectvsest = this.tcprojectInvestService.getById(Long.valueOf(investId));
                            if (null != tcprojectvsest) {
                                //未点击确定不把附件关联到调查文档记录
//                                tcprojectvsest.setPI_DueDoc(attachmentId + "");
//                                tcprojectInvestService.update(tcprojectvsest);
                                if (StringUtils.isEmpty(projectId))
                                    projectId = tcprojectvsest.getProjectId() + "";
                            }
                        }
                    } catch (Exception e) {
                        logger.error("", e);
                        msg = "上传文件错误，请重试";
                    }
                }
            }

        } catch (Exception e) {
            logger.error("上传调查报告异常", e);
//            writer.println("{\"success\":\"false\"}");
            msg = "上传文件错误，请重试";
        }

//        fileJson += "{fileId:" + fileId + "," + "fileName:" + oriFileName + "}";
        if (null != tcprojectAttachment) {
            pcode = "&pi_evaluationteam=" + URLEncoder.encode(pi_evaluationteam) +
                    "&pi_evaluationproject=" + URLEncoder.encode(pi_evaluationproject) +
                    "&fileNameAtt=" + URLEncoder.encode(StringUtil.isEmpty(msg) ? tcprojectAttachment.getPaname() : msg) +
                    "&projectId=" + projectId + "&attachmentId=" + tcprojectAttachment.getAttachmentId();
        } else {
            pcode = "&pi_evaluationteam=" + URLEncoder.encode(pi_evaluationteam) +
                    "&pi_evaluationproject=" + URLEncoder.encode(pi_evaluationproject) +
                    "&fileNameAtt=" + URLEncoder.encode(StringUtil.isEmpty(msg) ? tcprojectAttachment.getPaname() : msg) +
                    "&projectId=" + projectId;
        }
        response.setContentType("text/html");
        if ("IMAGE".equals(nodeKey) || "FILE".equals(nodeKey) || "FLASH".equals(nodeKey)) {//FCK图片上传//FCK图片上传
            StringBuffer returnMsg = new StringBuffer();
            returnMsg.append("<script type=\"text/javascript\">");//userAuditMatUpload.getSavePath().replace("\\", "/")).append("','").append("')"
            returnMsg.append("window.parent.CKEDITOR.tools.callFunction(").append(CKEditorFuncNum).append(",'").append(request.getContextPath() + "/file_upload/");
            returnMsg.append("</script>");
            //		writer.print(returnMsg.toString());
            response.sendRedirect(request.getContextPath() + "/crowdfunding/front/tcprojectinvest/uploadSurvey.ht?investId=" + investId + pcode);
            //		response.sendRedirect();
        } else {
            response.sendRedirect(request.getContextPath() + "/crowdfunding/front/tcprojectinvest/uploadSurvey.ht?investId=" + investId + pcode);
        }
    }

    /**
     * @param request 删除上传调查报告与评价附件
     */
    @Action(description = "删除上传调查报告与评价附件")
    @RequestMapping({"uploadSurveyAttachDel"})
    public void projectAfterAttachDel(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String ids = RequestUtil.getString(request, "fileId");
        String idArray[] = ids.split(";");
        String result = "0";
        try {
            for (int i = 0; i < idArray.length; i++) {
                Long id = Long.valueOf(idArray[i]);
                tcprojectAttachmentService.delById(id);
            }
            result = "1";
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.getWriter().write(result);

    }

    private String createFilePath(String tempPath, String fileName) {
        File one = new File(tempPath);
        Calendar cal = Calendar.getInstance();
        Integer year = Integer.valueOf(cal.get(1));
        Integer month = Integer.valueOf(cal.get(2) + 1);
        one = new File(tempPath + "/" + year + "/" + month);
        if (!one.exists()) {
            one.mkdirs();
        }
        String path = one.getPath();
        return path + "/" + fileName;
    }

    private String createFilePath(String tempPath) {
        Calendar cal = Calendar.getInstance();
        Integer year = Integer.valueOf(cal.get(1));
        Integer month = Integer.valueOf(cal.get(2) + 1);
        return tempPath + "/" + year + "/" + month;
    }

    @RequestMapping({"saveUploadSurvey"})
    @ResponseBody
    @Action(description = "保存上传调查报告与评价")
    public String saveUploadSurvey(HttpServletRequest request, HttpServletResponse response,
                                   String pi_evaluationteam, String pi_evaluationproject, String pi_duedoc,
                                   String projectId, String investId, String attachmentId) {
        String result = "文件上传失败";
        TcprojectInvest tp = null;
        if (StringUtils.isNotEmpty(investId) && StringUtil.isNotEmpty(attachmentId)) {
            try {
                tp = tcprojectInvestService.getById(Long.valueOf(investId));
                if(StringUtil.isNotEmpty(attachmentId)){
                if (tp != null) {
                    tp.setPI_EvaluationProject(pi_evaluationproject);
                    tp.setPI_EvaluationTeam(pi_evaluationteam);
                    tp.setPI_DueDoc(attachmentId);
                    tcprojectInvestService.update(tp);
                    result = "保存成功!";
                }
                }
                else{
                    result = "未上传调查报告，请上传!";
                }
            } catch (Exception e) {
                if (tp != null) {
                    tp.setPI_DueDoc(null);
                    tcprojectInvestService.update(tp);
                }
                result = e.getMessage();
                logger.error("save uploadSurvey error:investId={}", investId, e);
            }
        }
        return result;
    }

    @RequestMapping({"leadProj"})
    @Action(description = "查看领投的项目")
    public ModelAndView leadProj(HttpServletRequest request) throws Exception {
        TUser user = (TUser) request.getSession().getAttribute("user");
        //分页加参数
        int page = RequestUtil.getInt(request, "current_page", 1);
        //查询询价诚意金
        String askPrice = (String) AppUtil.getServletContext().getAttribute("ASK_PRICE_SINCERITY");
        if (StringUtils.isEmpty(askPrice))
            askPrice = "1000";
        int pageSize = RequestUtil.getInt(request, "pageSize", 3);
        PageBean pb = new PageBean(page, pageSize);
        List<Tcproject> leadProjectInfos = tcprojectService.getProjectLeads(null, null, user.getUserId(), pb);
        //设置显示金额
        setProperty(leadProjectInfos, request);
        request.setAttribute("leadProjectInfos", leadProjectInfos);//查询领投项目
        return new ModelAndView("/crowdfunding/front/myProjectInvestor/leadProj.jsp").addObject("askPrice", askPrice).addObject("page_bean", pb);
    }

    @RequestMapping({"refuseProj"})
    @Action(description = "拒绝的认投项目")
    public ModelAndView refuseProj(HttpServletRequest request) throws Exception {
        TUser user = (TUser) request.getSession().getAttribute("user");
        //分页加参数
        int page = RequestUtil.getInt(request, "current_page", 1);

        String askPrice = (String) AppUtil.getServletContext().getAttribute("ASK_PRICE_SINCERITY");
        if (StringUtils.isEmpty(askPrice))
            askPrice = "1000";
        int pageSize = RequestUtil.getInt(request, "pageSize", 3);
        PageBean pb = new PageBean(page, pageSize);
        List<Tcproject> leadProjectInfos = tcprojectService.getProjectRefuse(null, null, user.getUserId(), pb);
        //设置显示金额
        setProperty(leadProjectInfos, request);
        request.setAttribute("leadProjectInfos", leadProjectInfos);//查询领投项目
        return new ModelAndView("/crowdfunding/front/myProjectInvestor/refuseProj.jsp").addObject("askPrice", askPrice).addObject("page_bean", pb);
    }

    @RequestMapping({"voteProj"})
    @Action(description = "查看跟投的项目")
    public ModelAndView voteProj(HttpServletRequest request) throws Exception {
        TUser user = (TUser) request.getSession().getAttribute("user");
        String askPrice = (String) AppUtil.getServletContext().getAttribute("ASK_PRICE_SINCERITY");
        if (StringUtils.isEmpty(askPrice))
            askPrice = "1000";
        //分页加参数
        int page = RequestUtil.getInt(request, "current_page", 1);
        int pageSize = RequestUtil.getInt(request, "pageSize", 3);
        PageBean pb = new PageBean(page, pageSize);
        List<Tcproject> voteProjectInfos = tcprojectService.getProjectVotes(null, null, user.getUserId(), pb);
        //设置显示金额
        setProperty(voteProjectInfos, request);
        request.setAttribute("voteProjectInfos", voteProjectInfos);//查询领投项目
        return new ModelAndView("/crowdfunding/front/myProjectInvestor/voteProj.jsp").addObject("askPrice", askPrice).addObject("page_bean", pb);
    }


    @RequestMapping({"collectProj"})
    @Action(description = "查看收藏的项目")
    public ModelAndView collectProj(HttpServletRequest request, HttpServletResponse response) {
        //当前用户
        int isleader = 0;
        int isaskPrice = 0;
        if (TUserUtil.getLogUser(request) != null) {

            isleader = TUserUtil.getLogUser(request).getIsLeader();
            isaskPrice = TUserUtil.getLogUser(request).getIsAskPrice();
        }
        TUser user = (TUser) request.getSession().getAttribute("user");
        if (null != user) {
            TUser tuser = this.tuserService.getById(user.getUserId());
            isleader = tuser.getIsLeader();
            isaskPrice = tuser.getIsAskPrice();
        } else {
            try {
                response.sendRedirect(request.getContextPath() + "/loginWeb.jsp");
                return null;
            } catch (IOException e) {
                logger.error("查看收藏的项目异常", e);
            }
        }
        //分页加参数
        int page = RequestUtil.getInt(request, "current_page", 1);
        int pageSize = RequestUtil.getInt(request, "pageSize", 3);
        PageBean pb = new PageBean(page, pageSize);
        List<Tcproject> collectProjectInfos = tcprojectService.getProjectCollections(null, null, user.getUserId(), pb);
        //设置显示金额
        setProperty(collectProjectInfos, request);
        request.setAttribute("collectProjectInfos", collectProjectInfos);//查询收藏的项目
        request.setAttribute("isleader", isleader);
        request.setAttribute("isaskPrice", isaskPrice);
        return new ModelAndView("/crowdfunding/front/myProjectInvestor/collectProj.jsp").addObject("page_bean", pb);
    }

    private void setProperty(List<Tcproject> collectProjectInfos, HttpServletRequest request) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        TUser user = (TUser) request.getSession().getAttribute("user");
        if (null != collectProjectInfos && collectProjectInfos.size() > 0) {
            for (int i = 0; i < collectProjectInfos.size(); i++) {
                Tcproject tcproject = collectProjectInfos.get(i);
                if (tcproject != null && tcproject.getProjectId() != null) {

                    Map<String, Object> uask = new HashMap<String, Object>();
                    uask.put("projectId", tcproject.getProjectId());
                    uask.put("userId", user.getUserId());
                    uask.put("piisCheck2", 1);
                    uask.put("piisCancel", 0);
                    List<TcprojectInvest> listInvest = tcprojectInvestService.getInvestforPro(uask, null);
                    if (listInvest != null && listInvest.size() > 0) {//已经存在有效的投资记录
                        tcproject.setIsDel(1);//标志有投资记录
                    }
                    if (tcproject.getPfinancingAmount().compareTo(new BigDecimal(0)) > 0) {
                        tcproject.setPfinancingAmount(tcproject.getPfinancingAmount().setScale(0).divide(new BigDecimal(10000)));
                    } else {
                        tcproject.setPfinancingAmount(new BigDecimal(0));
                    }
                    if (tcproject.getPinvestAmount().compareTo(new BigDecimal(0)) > 0) {
                        BigDecimal pinvestAmount = tcproject.getPinvestAmount().setScale(0).divide(new BigDecimal(10000));
                        tcproject.setPinvestAmount(pinvestAmount);
                    } else {
                        tcproject.setPinvestAmount(new BigDecimal(0));
                    }
                    if (tcproject.getPinvestMaxLeader().compareTo(new BigDecimal(0)) > 0) {
                        BigDecimal pinvestMaxLeader = tcproject.getPinvestMaxLeader().setScale(0).divide(new BigDecimal(10000));
                        tcproject.setPinvestMaxLeader(pinvestMaxLeader);
                    } else {
                        tcproject.setPinvestMaxLeader(new BigDecimal(0));
                    }
                    if (tcproject.getPinvestMinFollow().compareTo(new BigDecimal(0)) > 0) {
                        BigDecimal pinvestMinFollow = tcproject.getPinvestMinFollow().setScale(0).divide(new BigDecimal(10000));
                        tcproject.setPinvestMinFollow(pinvestMinFollow);
                    } else {
                        tcproject.setPinvestMaxLeader(new BigDecimal(0));
                    }
                    tcproject.setPsharesPercent(tcproject.getPsharesPercent().setScale(1));
                    //----zhangjj moify 2014-10-28
                    if (tcproject.getLeaderAmount() != null && tcproject.getLeaderAmount().compareTo(new BigDecimal(0)) > 0) {
                        BigDecimal leaderAmount = tcproject.getLeaderAmount().setScale(0).divide(new BigDecimal(10000));
                        tcproject.setLeaderAmount(leaderAmount);
                    } else {
                        tcproject.setLeaderAmount(new BigDecimal(0));
                    }
                    if (tcproject.getFollowAmount() != null && tcproject.getFollowAmount().compareTo(new BigDecimal(0)) > 0) {
                        BigDecimal followAmount = tcproject.getFollowAmount().setScale(0).divide(new BigDecimal(10000));
                        tcproject.setFollowAmount(followAmount);
                    } else {
                        tcproject.setFollowAmount(new BigDecimal(0));
                    }
                    if (tcproject.getPivaluation() != null && tcproject.getPivaluation().compareTo(new BigDecimal(0)) > 0) {
                        BigDecimal followAmount = tcproject.getPivaluation().setScale(0).divide(new BigDecimal(10000));
                        tcproject.setPivaluation(followAmount);
                    } else {
                        tcproject.setPivaluation(new BigDecimal(0));
                    }
                    //设置我的领投金额sumPivaluation
                    if (tcproject.getSumPivaluation() != null && tcproject.getSumPivaluation().compareTo(new BigDecimal(0)) > 0) {
                        BigDecimal sumPivaluation = tcproject.getSumPivaluation().setScale(0).divide(new BigDecimal(10000));
                        tcproject.setSumPivaluation(sumPivaluation);
                    } else {
                        tcproject.setSumPivaluation(new BigDecimal(0));
                    }
                    //设置我的领投金额myleaderAmount
                    if (tcproject.getMyleaderAmount() != null && tcproject.getMyleaderAmount().compareTo(new BigDecimal(0)) > 0) {
                        BigDecimal myleaderAmount = tcproject.getMyleaderAmount().setScale(0).divide(new BigDecimal(10000));
                        tcproject.setMyleaderAmount(myleaderAmount);
                    } else {
                        tcproject.setMyleaderAmount(new BigDecimal(0));
                    }
                    if (tcproject.getMyfollowAmount() != null && tcproject.getMyfollowAmount().compareTo(new BigDecimal(0)) > 0) {
                        BigDecimal myleaderAmount = tcproject.getMyfollowAmount().setScale(0).divide(new BigDecimal(10000));
                        tcproject.setMyfollowAmount(myleaderAmount);
                    } else {
                        tcproject.setMyfollowAmount(new BigDecimal(0));
                    }
                    if (tcproject.getCreator() != null) {
                        TUser tuser = tuserService.getById(tcproject.getCreator());
                        if (tuser != null)
                            tcproject.setMyPhoto(tuser.getMyPhoto());
                    }
                    if (tcproject.getSumleaderPivaluation() != null && tcproject.getSumleaderPivaluation().compareTo(new BigDecimal(0)) > 0) {
                        BigDecimal sumleaderPivaluation = tcproject.getSumleaderPivaluation().setScale(0).divide(new BigDecimal(10000));
                        tcproject.setSumleaderPivaluation(sumleaderPivaluation);
                    } else {
                        tcproject.setSumleaderPivaluation(new BigDecimal(0));
                    }
                    if (tcproject.getSumlfollowPivaluation() != null && tcproject.getSumlfollowPivaluation().compareTo(new BigDecimal(0)) > 0) {
                        BigDecimal sumleaderPivaluation = tcproject.getSumlfollowPivaluation().setScale(0).divide(new BigDecimal(10000));
                        tcproject.setSumlfollowPivaluation(sumleaderPivaluation);
                    } else {
                        tcproject.setSumlfollowPivaluation(new BigDecimal(0));
                    }
                    //设置项目约谈的sendTime
                    if (tcproject.getSendTime() != null) {
                        String sendTime = format.format(tcproject.getSendTime());
                        tcproject.setCreateTimestr(sendTime);
                    }
                }
            }
        }
    }

    @RequestMapping({"aboutProj"})
    @Action(description = "查看约谈的项目")
    public ModelAndView aboutProj(HttpServletRequest request) {
        TUser user = (TUser) request.getSession().getAttribute("user");
        //分页加参数
        int page = RequestUtil.getInt(request, "current_page", 1);
        int pageSize = RequestUtil.getInt(request, "pageSize", 3);
        PageBean pb = new PageBean(page, pageSize);
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        List<Tcproject> aboutProjectInfos = tcprojectService.getAboutProjs(null, null, user.getUserId(), pb);
        //设置显示金额
        setProperty(aboutProjectInfos, request);
        request.setAttribute("aboutProjectInfos", aboutProjectInfos);//查询约谈项目
        return new ModelAndView("/crowdfunding/front/myProjectInvestor/aboutProj.jsp").addObject("page_bean", pb);
    }

    @RequestMapping({"finishProj"})
    @Action(description = "查看完成的项目")
    public ModelAndView finishProj(HttpServletRequest request) {
        TUser user = (TUser) request.getSession().getAttribute("user");
        //分页加参数
        int page = RequestUtil.getInt(request, "current_page", 1);
        int pageSize = RequestUtil.getInt(request, "pageSize", 3);
        PageBean pb = new PageBean(page, pageSize);
        List<Tcproject> finishProjectInfos = tcprojectService.getFinishProjs(null, null, user.getUserId(), pb);
        //设置显示金额
        setProperty(finishProjectInfos, request);
        request.setAttribute("finishProjectInfos", finishProjectInfos);//查询领投项目
        return new ModelAndView("/crowdfunding/front/myProjectInvestor/finishProj.jsp").addObject("page_bean", pb);
    }

    @RequestMapping({"getProjectLeadAndVote"})
    @Action(description = "投资人项目管理跳转")
    public ModelAndView getProjectLeadAndVote(HttpServletRequest request) {
        String flag = request.getParameter("flag");
        return new ModelAndView("/crowdfunding/front/myProjectInvestor/projectManage.jsp").addObject("flag", flag);
    }

    @RequestMapping({"updateProjectInvestStatus"})
    @Action(description = "更新项目投资状态")
    public void updateProjectInvestStatus(HttpServletRequest request, TcprojectInvest tcprojectInvest) {
        long investId = RequestUtil.getLong(request, "investId");
        tcprojectInvest = tcprojectInvestService.getById(investId);
        String typeId = request.getParameter("typeId");
        if ("1".equals(typeId) || "1".equals(typeId)) {
            tcprojectInvest.setPitypeId(1);
        } else {
            tcprojectInvest.setPitypeId(1);//暂时业务还不明确，更新为1
        }
        tcprojectInvestService.update(tcprojectInvest);
    }

    @RequestMapping({"cancelLed"})
    @Action(description = "取消领投")
    @ResponseBody
    public String cancelLed(HttpServletRequest request, HttpServletResponse response, String investId, String projectid) {
        TcprojectInvest tcprojectInvest = null;
        if (StringUtils.isNotEmpty(investId)) {
            tcprojectInvest = tcprojectInvestService.getById(Long.valueOf(investId));
            tcprojectInvest.setPiisCancel(1);
            tcprojectInvest.setPiCancelTime(new Date());//设置反悔时间
            tcprojectInvestService.cancleLed(tcprojectInvest);
        }
        //处理项目投资数和投资金额计算的
        if (StringUtils.isNotEmpty(projectid) && StringUtils.isNotBlank(projectid)
                && !"undefined".equals(projectid)
                && !"null".equals(projectid)) {
            try {
                //如果反悔之前是创业者同意过的领头人，则清空项目表的领头人字段为0


                Tcproject tp = tcprojectService.getById(Long.valueOf(projectid));
                tp.setPinvestAmount(tp.getPinvestAmount().subtract(tcprojectInvest.getPiinvest()));

                //重新计算 融资比例

				/*int complate=tp.getPinvestAmount().divide(tp.getPfinancingAmount(), 2, BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(100)).intValue();
                tp.setPcomplete(complate);
				*/
                tcprojectService.update(tp);
                tcprojectService.calculateProjectInvestmentInfo(Long.valueOf(projectid));
                if (tcprojectInvest.getUserId().longValue() == tp.getPleaderId().longValue()) {
                    tp.setPleaderId(0L);
                    tcprojectService.update(tp);
                }
                if (tcprojectInvest != null && tcprojectInvest.getUserId() != null) {
                    TUser tuser = tuserService.getById(tcprojectInvest.getUserId());
                    if (tuser != null) {
                        //更新是否有询价认投资格
                        tuser.setIsAskPrice(0);
                        tuserService.update(tuser);
                        //清除当前会话设置到询价资格
                        request.getSession(false).removeAttribute("isAskPrice");
                    }
                }
                return "您已经成功取消了对该项目的领投!";
            } catch (Exception e) {
                logger.error("", e);
                return e.getMessage();
            }
        }
        return null;
    }

    @RequestMapping({"cancelVote"})
    @Action(description = "取消跟投")
    @ResponseBody
    public String cancelVote(HttpServletRequest request, HttpServletResponse response, String investId, String projectid) {
//		String investId = request.getParameter("investId");
//		String projectid = request.getParameter("projectid");
        TcprojectInvest tcprojectInvest = null;
        if (StringUtils.isNotEmpty(investId)) {
            tcprojectInvest = tcprojectInvestService.getById(Long.valueOf(investId));
            tcprojectInvest.setPiisCancel(1);
            tcprojectInvest.setPiCancelTime(new Date());//设置反悔时间
            tcprojectInvestService.cancleVote(tcprojectInvest);
        }
        //处理项目投资数和投资金额计算的
        if (StringUtils.isNotEmpty(projectid) && StringUtils.isNotBlank(projectid)
                && !"undefined".equals(projectid)
                && !"null".equals(projectid)) {
            try {
                Tcproject tp = tcprojectService.getById(Long.valueOf(projectid));
                tp.setPinvestAmount(tp.getPinvestAmount().subtract(tcprojectInvest.getPiinvest()));
                //重新计算 融资比例
				/*int complate=tp.getPinvestAmount().divide(tp.getPfinancingAmount(), 2, BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(100)).intValue();
				tp.setPcomplete(complate);*/
                tcprojectService.update(tp);
                tcprojectService.calculateProjectInvestmentInfo(Long.valueOf(projectid));
                if (tcprojectInvest != null && tcprojectInvest.getUserId() != null) {
                    TUser tuser = tuserService.getById(tcprojectInvest.getUserId());
                    if (tuser != null) {
                        //更新是否有询价认投资格
                        tuser.setIsAskPrice(0);
                        tuserService.update(tuser);
                    }
                }
                return "您已经成功取消了项目的认筹!";
            } catch (Exception e) {
                logger.error("", e);
                throw e;
            }
        }
        return null;
    }


    @RequestMapping({"cancelCollect"})
    @Action(description = "取消收藏")
    @ResponseBody
    public String cancelCollect(HttpServletRequest request) {
        long AttentionId = RequestUtil.getLong(request, "AttentionId");
        TAttention attention = tattentionService.getById(AttentionId);
        attention.setIsDel(1);
        tattentionService.cancleCollect(attention);
        return "取消收藏成功";
    }


    @RequestMapping({"voteTou"})
    @Action(description = "我要跟投")
    @ResponseBody
    public String voteTou(HttpServletRequest request, HttpServletResponse response) {
        //当前用户
        int isleader = 0;
        int isaskPrice = 0;
        String result = "";
        try {
            if (TUserUtil.getLogUser(request) != null) {
                isleader = TUserUtil.getLogUser(request).getIsLeader();
                isaskPrice = TUserUtil.getLogUser(request).getIsAskPrice();
            }
            TUser user = (TUser) request.getSession().getAttribute("user");
            if (null != user) {
                TUser tuser = this.tuserService.getById(user.getUserId());
                isleader = tuser.getIsLeader();
                isaskPrice = tuser.getIsAskPrice();
            }
            //先判断登陆是否有权限询价
            if (isaskPrice == 0) {
                return result = "0";
            }


        } catch (Exception e) {
            e.getMessage();
        }
		/*TUser user = (TUser) request.getSession().getAttribute("user");
		long ProjectId = RequestUtil.getLong(request, "ProjectId");
		//根据工程id，和用户id查询记录
		List<TcprojectInvest> tcprojectInvest = tcprojectInvestService.getTcprojectInvest(ProjectId,user.getUserId());
		//TcprojectInvest tcprojectInvest = tcprojectInvestService.getById(ProjectId);
		if(null==tcprojectInvest || "".equals(tcprojectInvest)){
			TcprojectInvest tcprojectInvest1 = new TcprojectInvest();
			tcprojectInvest1.setInvestId(UniqueIdUtil.genId());
			tcprojectInvest1.setProjectId(ProjectId);
			tcprojectInvest1.setUserId(user.getUserId());
			tcprojectInvest1.setPitypeId(1);
		}else{
			TcprojectInvest tcprojectInvest1 = tcprojectInvest.get(0); 
			tcprojectInvest1.setPitypeId(1);
			tcprojectInvestService.update(tcprojectInvest1);
		}*/
        return result = "1";
    }


    @RequestMapping({"ledTou"})
    @Action(description = "我要领投")
    @ResponseBody
    public String ledTou(HttpServletRequest request) {
        String result = "1";
        TUser user = (TUser) request.getSession().getAttribute("user");
        String projectId = request.getParameter("projectId");
        String typeId = request.getParameter("typeId");
        //根据工程id，和用户id查询记录
        List<TcprojectInvest> tcprojectInvest = tcprojectInvestService.getTcprojectInvest(Long.valueOf(projectId), user.getUserId());
        //TcprojectInvest tcprojectInvest = tcprojectInvestService.getById(ProjectId);
        if (null == tcprojectInvest || "".equals(tcprojectInvest) || tcprojectInvest.size() == 0) {
            TcprojectInvest tcprojectInvest1 = new TcprojectInvest();
            tcprojectInvest1.setInvestId(UniqueIdUtil.genId());
            tcprojectInvest1.setProjectId(Long.valueOf(projectId));
            tcprojectInvest1.setUserId(user.getUserId());
            tcprojectInvest1.setPitypeId(Integer.valueOf(typeId));
        } else {
            TcprojectInvest tcprojectInvest1 = tcprojectInvest.get(0);
            tcprojectInvest1.setPitypeId(Integer.valueOf(typeId));
            tcprojectInvestService.update(tcprojectInvest1);
        }
        String code = request.getParameter("validCode");
        String validCode = (String) request.getSession().getAttribute(ValidCode.getSessionName_Randcode());
        if (!code.equalsIgnoreCase(validCode)) {
            result = "0";
            return result;
        }
        return result;
    }


    @RequestMapping({"ledPage"})
    @Action(description = "我要领投页面跳转")
    public ModelAndView ledPage(HttpServletRequest request) {
        String projectId = request.getParameter("projectId");
        return new ModelAndView("/crowdfunding/front/myProjectInvestor/ledTou.jsp")
                .addObject("projectId", projectId);
    }


    @RequestMapping({"aboutEntrepre"})
    @Action(description = "约谈项目创业者")
    public ModelAndView aboutEntrepre(HttpServletRequest request) {
        String createrId = request.getParameter("createrId");
        String projectId = request.getParameter("projectId");
        String receiverName = "";
        try {
            if (createrId != null && StringUtils.isNotEmpty(createrId)) {
                TUser tuser = this.tuserService.getById(Long.valueOf(createrId));
                if (null != tuser)
                    receiverName = tuser.getLoginName();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("/crowdfunding/front/myProjectInvestor/aboutCreater.jsp")
                .addObject("createrId", createrId)
                .addObject("projectId", projectId)
                .addObject("receiverName", receiverName);
    }

    @RequestMapping({"timeLimit"})
    @ResponseBody
    @Action(description = "约谈时间限制")
    public String timeLimit(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String result = "0";
        TUserMsgRemind msgremind = null;
        String sendTime = request.getParameter("sendTime");
        String projectId = request.getParameter("projectId");
        if (null == sendTime || "".equals(sendTime)) {
            result = "2";
            return result;
        }
        if (StringUtils.isNotEmpty(projectId)) {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("projectId", projectId);
            List<TUserMsgRemind> tusermsid = tuserMsgRemindService.getlastSendTimeInfo(map);
            if (null != tusermsid && tusermsid.size() > 0) {
                msgremind = tusermsid.get(0);
            }
        }
        String interval = (String) AppUtil.getServletContext().getAttribute("INTERVIEWS_TIMESPAN");
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            if (msgremind != null) {
                sendTime = sdf.format(msgremind.getSendTime());
            }
            Date date = sdf.parse(sendTime);
            //int senday = Integer.parseInt(interval != null?interval:"0")/24;
            if (nHoursBetweenTwoDate(date, new Date()) >= Integer.parseInt(null != interval ? interval : "0")) {
                result = "1";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    //   计算两个日期相隔的小时数
    public int nHoursBetweenTwoDate(Date firstDate, Date secondDate) {
        int hours = (int) ((secondDate.getTime() - firstDate.getTime()) / (60 * 60 * 1000));
        return hours;
    }

    @RequestMapping({"toPayment"})
    @Action(description = "我要付款")
    public ModelAndView toPayment(HttpServletRequest request) throws Exception {
        TUser user = (TUser) request.getSession().getAttribute("user");
        if (user == null) {

        }
        String projectId = request.getParameter("projectId");
        String investId = request.getParameter("investId");
        Tcproject tcp = null;
        TUserFunds userFund = null;
        TcprojectInvest ivest = null;
        if (StringUtils.isNotEmpty(projectId) && StringUtils.isNotBlank(projectId)) {
            tcp = tcprojectService.getById(Long.valueOf(projectId));
            if (null != tcp) {
                if (tcp.getPinvestAmount().compareTo(new BigDecimal(0)) > 0) {
                    BigDecimal pinvestAmount = tcp.getPinvestAmount().setScale(0).divide(new BigDecimal(10000));
                    tcp.setPinvestAmount(pinvestAmount);
                } else {
                    tcp.setPinvestAmount(new BigDecimal(0));
                }
                if (StringUtils.isNotEmpty(investId)) {
                    ivest = tcprojectInvestService.getById(Long.valueOf(investId));
                    if (null != ivest) {
                        if (ivest.getPiinvest().compareTo(new BigDecimal(0)) > 0) {
                            BigDecimal piinvest = ivest.getPiinvest().setScale(0).divide(new BigDecimal(10000));
                            ivest.setPiinvest(piinvest);
                        } else {
                            ivest.setPiinvest(new BigDecimal(0));
                        }
                    }
                    if (ivest.getUserId() != null) {
                        userFund = tuserFundsService.getByUserId(Long.valueOf(ivest.getUserId()));
                    }
                }
            }
        }

        //根据当前登录人的 isCompany字段判断，是否为机构投资
        Map<String, Object> map = new HashMap<String, Object>();

        String iscompany = "";
        if (user != null) {
            if (user.getIsCompany() == 1) {
                iscompany = "_B2B";
                map.put("isCompanyPay", 1);
            } else {
                map.put("isCompanyPay", 0);
            }
        }
        String htmlStr = "";
        String contentUrl = (String) AppUtil.getServletContext().getAttribute("PLATFORM-SYSTEM-URL");

        //取得客户 支持的银行
        List<Tbank> list = tbankService.getAllByWhere(map);
//        for (int i = 0; i < list.size(); i++) {
//            Tbank k0 = list.get(i);
//            k0.getBankPic();
//            String fileId0 = k0.getFilesIds();
//
//            Tbank k1 = null;
//            String fileId1 = "";
//            if (i + 1 < list.size()) {
//
//                k1 = list.get(i + 1);
//                k1.getBankPic();
//                fileId1 = k1.getFilesIds();
//            }
//
//            Tbank k2 = null;
//            String fileId2 = "";
//            if (i + 2 < list.size()) {
//
//                k2 = list.get(i + 2);
//                k2.getBankPic();
//                fileId2 = k2.getFilesIds();
//            }
//
//
//            htmlStr += "<tr>";
//            if (k0 != null) {
//                int n0 = i + 1;
//                htmlStr += "<td width=\"5%\" height=\"85\" align=\"right\"><input type=\"radio\" name=\"defaultbank3\" id=\"defaultbank" + n0 + "\" onclick=\"setvalueFun('" + n0 + "')\" value=\"" + k0.getBankCode() + iscompany + "\"/></td>"
//                        + " <td width=\"6%\"><img src=\"" + contentUrl + "/wuyouchou/system/sysFile/getFileById.ht?fileId=" + fileId0 + "\"/></td>";
//
//            }
//            if (k1 != null) {
//                int n1 = i + 2;
//                htmlStr += " <td width=\"5%\" height=\"85\" align=\"right\"><input type=\"radio\" name=\"defaultbank3\" id=\"defaultbank" + n1 + "\" onclick=\"setvalueFun('" + n1 + "')\" value=\"" + k1.getBankCode() + iscompany + "\"/></td>"
//                        + " <td width=\"6%\"><img src=\"" + contentUrl + "/wuyouchou/system/sysFile/getFileById.ht?fileId=" + fileId1 + "\"/></td>";
//            }
//            if (k2 != null) {
//                int n2 = i + 3;
//                htmlStr += " <td width=\"5%\" height=\"85\" align=\"right\"><input type=\"radio\" name=\"defaultbank3\" id=\"defaultbank" + n2 + "\" onclick=\"setvalueFun('" + n2 + "')\"  value=\"" + k2.getBankCode() + iscompany + "\"/></td>"
//                        + " <td width=\"6%\" align=\"left\"><img src=\"" + contentUrl + "/wuyouchou/system/sysFile/getFileById.ht?fileId=" + fileId2 + "\"/></td>";
//            }
//            htmlStr += "  </tr>";
//            i = i + 2;
//        }

        return new ModelAndView("/crowdfunding/front/myProjectInvestor/payment.jsp").addObject("project", tcp)
                .addObject("userFund", userFund).addObject("projectId", projectId)
                .addObject("investId", investId).addObject("ivest", ivest).addObject("htmlStr", htmlStr)
                .addObject("list",list).addObject("iscompany",iscompany).addObject("contentUrl",contentUrl);
    }

    @RequestMapping({"toRoonpay"})
    @Action(description = "我要付款")
    public ModelAndView toRoonpay(HttpServletRequest request) throws Exception {

        String projectId = request.getParameter("projectId");
        String investId = request.getParameter("investId");
        TUser user = (TUser) request.getSession().getAttribute("user");
        if (user == null) {
            throw new CrowdFundException(WuyouchouErrorCode.USR_NOT_FOUND_ERROR.getErrorCode(),
                    WuyouchouErrorCode.USR_NOT_FOUND_ERROR.getErrorMsg(), new Exception());
        }

        Tcproject tcp = null;
        TUserFunds userFund = null;
        TcprojectInvest ivest = null;
        String sHtmlText = null;
        try {
            if (StringUtils.isNotEmpty(projectId) && StringUtils.isNotBlank(projectId)) {
                tcp = tcprojectService.getById(Long.valueOf(projectId));
                if (null != tcp) {
                    if (tcp.getPinvestAmount().compareTo(new BigDecimal(0)) > 0) {
                        BigDecimal pinvestAmount = tcp.getPinvestAmount().setScale(0).divide(new BigDecimal(10000));
                        tcp.setPinvestAmount(pinvestAmount);
                    } else {
                        tcp.setPinvestAmount(new BigDecimal(0));
                    }
                    if (StringUtils.isNotEmpty(investId)) {
                        ivest = tcprojectInvestService.getById(Long.valueOf(investId));
                        if (null != ivest) {
                            if (ivest.getPiinvest().compareTo(new BigDecimal(0)) > 0) {
                                BigDecimal piinvest = ivest.getPiinvest().setScale(0).divide(new BigDecimal(10000));
                                ivest.setPiinvest(piinvest);
                            } else {
                                ivest.setPiinvest(new BigDecimal(0));
                            }
                        }
                        if (ivest.getUserId() != null) {
                            userFund = tuserFundsService.getByUserId(Long.valueOf(ivest.getUserId()));
                        }
                    }
                }
            }

            //
            //RongpayConfig.java中配置信息（不可以修改）
            String charset = RongpayConfig.charset;
            String sign_type = RongpayConfig.sign_type;
            String seller_email = RongpayConfig.seller_email;
            String merchant_ID = RongpayConfig.merchant_ID;
            String key = RongpayConfig.key;
            String notify_url = RongpayConfig.notify_url;
            String return_url = RongpayConfig.return_url;
            String service = RongpayConfig.service;
            String payment_type = RongpayConfig.payment_type;

            //以下参数是需要通过下单时的订单数据传入进来获得
            //必填参数
            //请与贵网站订单系统中的唯一订单号匹配
            String order_no = String.valueOf(UniqueIdUtil.genId());
            //      String order_no = new SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
            //订单名称，显示在融宝支付收银台里的“商品名称”里，显示在融宝支付的交易管理的“商品名称”的列表里。
            //     String title =new String(request.getParameter("subject").getBytes("ISO-8859-1"),"GBK");
            String title = new String(tcp.getPname().getBytes(charset),charset);

            //订单描述、订单详细、订单备注，显示在融宝支付收银台里的“商品描述”里
            //    String body =new String(request.getParameter("body").getBytes("ISO-8859-1"),"GBK");
            String body = new String("项目认投".getBytes(charset),charset);
            //订单总金额，显示在融宝支付收银台里的“应付总额”里
            //      String total_fee = request.getParameter("Rongmoney");
            String actualPay = configproperties.getProperty("actualPay");
            String amount = request.getParameter("Rongmoney");
            String payAmount = StringUtil.isNotEmpty(amount) ? amount : "0";
            payAmount = new BigDecimal(payAmount).multiply(new BigDecimal("10000")).toString();
            String total_fee = "";
            if ("0".equals(actualPay)) {
                total_fee = "0.01";
            } else {
                total_fee = payAmount;
            }
            //默认买家融宝支付账号
            String buyer_email = "";
            //支付方式
            String paymethod = "";

            //网银代码
            String defaultbank = request.getParameter("defaultbank");
            if ("".equals(defaultbank)) {
                paymethod = "bankPay";
                defaultbank = "";
            } else {
                paymethod = "directPay";
            }
            int isCompany = user.getIsCompany();
            ////构造函数，生成请求URL
            sHtmlText = RongpayService.BuildForm(service, payment_type, merchant_ID, seller_email, return_url, notify_url, order_no,
                    title, body, total_fee, buyer_email, charset, paymethod, defaultbank, key, sign_type, isCompany);
            //插入一条自己记录，记录用户的 资金流动/这里起始 设为 等待支付
            TMoneymove t = new TMoneymove();
            t.setMoneyMoveId(UniqueIdUtil.genId());
            t.setUserId(user.getUserId());//
            t.setProjectId(Long.valueOf(projectId));
            t.setTypeId("3");
            t.setMoneyInOut(new BigDecimal("-" + amount).multiply(new BigDecimal("10000")));
            t.setGetFee(new BigDecimal(0));
            t.setMoneyCurrent(new BigDecimal(0));
            t.setCreateTime(new Timestamp(System.currentTimeMillis()));
            t.setResultId("99");
            t.setAudit(0l);
            t.setRemark("投资金额等待支付");
            t.setSerialNo("");
            t.setFlowCode(order_no);
            t.setIsOffLine(0);
            tmoneymoveService.addNewMoneyMove(t);
        } catch (Exception e) {
            logger.error("投资金额支付异常:investId={}", investId, e);
            throw new CrowdFundException(WuyouchouErrorCode.PAYMENT_INVST_ADD_ERROR.getErrorCode(),
                    WuyouchouErrorCode.PAYMENT_INVST_ADD_ERROR.getErrorMsg(), e);
        }

        return new ModelAndView("/crowdfunding/front/myProjectInvestor/autoSubmitPay.jsp").addObject("project", tcp)
                .addObject("userFund", userFund).addObject("projectId", projectId)
                .addObject("investId", investId).addObject("ivest", ivest).addObject("sHtmlText", sHtmlText);
    }

    @RequestMapping({"toPayment2"})
    @Action(description = "我要支付认筹诚意金")
    public ModelAndView toPayment2(HttpServletRequest request) throws Exception {

        TUser user = (TUser) request.getSession().getAttribute("user");
        String pinvestAmount = request.getParameter("pinvestAmount");//缴纳认筹诚意金用到
        //RongpayConfig.java中配置信息（不可以修改）
        String charset = RongpayConfig.charset;
        String sign_type = RongpayConfig.sign_type;
        String seller_email = RongpayConfig.seller_email;
        String merchant_ID = RongpayConfig.merchant_ID;
        String key = RongpayConfig.key;
        String notify_url = RongpayConfig.notify_url;
        String return_url = RongpayConfig.return_url;
        String service = RongpayConfig.service;
        String payment_type = RongpayConfig.payment_type;

        //以下参数是需要通过下单时的订单数据传入进来获得
        //必填参数
        //请与贵网站订单系统中的唯一订单号匹配
        String order_no = String.valueOf(UniqueIdUtil.genId());
        //      String order_no = new SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());

        //订单名称，显示在融宝支付收银台里的“商品名称”里，显示在融宝支付的交易管理的“商品名称”的列表里。
        //     String title =new String(request.getParameter("subject").getBytes("ISO-8859-1"),"GBK");
//        String title =new String("项目认筹诚意金".getBytes("ISO-8859-1"),"UTF-8");
        String title = "项目认筹诚意金";
        //订单描述、订单详细、订单备注，显示在融宝支付收银台里的“商品描述”里
        //    String body =new String(request.getParameter("body").getBytes("ISO-8859-1"),"GBK");
//        String body =new String("项目认筹诚意金".getBytes("ISO-8859-1"),"UTF-8");
        String body = "项目认筹诚意金";
        logger.info("TcprojectFrontInvestController.toPayment2===>body={}", body);

        //订单总金额，显示在融宝支付收银台里的“应付总额”里
        //根据app.properties中actualPay属性设置支付金额
        String actualPay = configproperties.getProperty("actualPay");
        String amount = request.getParameter("pinvestAmount");
        String total_fee = "";
        if ("0".equals(actualPay)) {
            total_fee = "0.01";
        } else {
            total_fee = amount;
        }

        //默认买家融宝支付账号
        String buyer_email = "";
        //支付方式
        String paymethod = "";

        //网银代码
        String defaultbank = request.getParameter("defaultbank");
        if ("".equals(defaultbank)) {
            paymethod = "bankPay";
            defaultbank = "";
        } else {
            paymethod = "directPay";
        }
        int isCompany = user.getIsCompany();
        ////构造函数，生成请求URL
        String sHtmlText = RongpayService.BuildForm(service, payment_type, merchant_ID, seller_email, return_url, notify_url, order_no,
                title, body, total_fee, buyer_email, charset, paymethod, defaultbank, key, sign_type, isCompany);
        //插入一条自己记录，记录用户的 资金流动/这里起始 设为 支付失败
        //将资金流动初始设为"失败"状态修改为"初始状态:99"
        try {
            TMoneymove t = new TMoneymove();
            t.setMoneyMoveId(UniqueIdUtil.genId());
            t.setUserId(user.getUserId());//
            //	t.setProjectId();
            t.setTypeId("12");
            t.setMoneyInOut(new BigDecimal("-" + amount));
            t.setGetFee(new BigDecimal(0));
            t.setMoneyCurrent(new BigDecimal(0));
            t.setCreateTime(new Timestamp(System.currentTimeMillis()));
            t.setResultId("99");
            t.setAudit(0l);
            t.setRemark("诚意金等待支付");
            t.setSerialNo("");
            t.setFlowCode(order_no);
            t.setIsOffLine(0);
            tmoneymoveService.addNewMoneyMove(t);
//			tmoneymoveService.add(t);
        } catch (Exception e) {
            logger.error("支付诚意金异常,userId={}", user.getUserId(), e);
            throw new CrowdFundException(WuyouchouErrorCode.PAYMENT_ASKPAY_ADD_ERROR.getErrorCode(),
                    WuyouchouErrorCode.PAYMENT_ASKPAY_ADD_ERROR.getErrorMsg(), e);
        }
        return new ModelAndView("/crowdfunding/front/myProjectInvestor/autoSubmitPay.jsp")
                .addObject("sHtmlText", sHtmlText).addObject("pinvestAmount", pinvestAmount);
    }


    @RequestMapping({"toAutoSubmitjsp"})
    @Action(description = "我要付款")
    public ModelAndView toAutoSubmitjsp(HttpServletRequest request) throws Exception {
        TUser u = (TUser) request.getSession().getAttribute("user");//当前用户id

        String projectId = request.getParameter("projectId");
        String investId = request.getParameter("investId");
        String pinvestAmount = request.getParameter("pinvestAmount");//缴纳认筹诚意金用到
        //根据当前登录用户取得 用户资金信息
        String htmlStr = "";
        String htmlStrB2B = "";
        String contentUrl = (String) AppUtil.getServletContext().getAttribute("PLATFORM-SYSTEM-URL");
        try {
            //取得客户 支持的银行
            List<Tbank> list = tbankService.getAll();
            for (int i = 0; i < list.size(); i++) {

                Tbank k0 = list.get(i);
                k0.getBankPic();
                String fileId0 = k0.getFilesIds();

                Tbank k1 = null;
                String fileId1 = "";
                if (i + 1 < list.size()) {

                    k1 = list.get(i + 1);
                    k1.getBankPic();
                    fileId1 = k1.getFilesIds();
                }

                Tbank k2 = null;
                String fileId2 = "";
                if (i + 2 < list.size()) {

                    k2 = list.get(i + 2);
                    k2.getBankPic();
                    fileId2 = k2.getFilesIds();
                }


                htmlStr += "<tr>";
                htmlStrB2B += "<tr>";
                if (k0 != null) {
                    int n0 = i + 1;
                    htmlStr += "<td width=\"5%\" height=\"85\" align=\"right\"><input type=\"radio\" name=\"defaultbank3\" id=\"defaultbank" + n0 + "\" onclick=\"setvalueFun('" + n0 + "')\" value=\"" + k0.getBankCode() + "\"/></td>"
                            + " <td width=\"10%\"><img src=\"" + contentUrl + "/wuyouchou/system/sysFile/getFileById.ht?fileId=" + fileId0 + "\"/></td>";


                    htmlStrB2B += "<td width=\"5%\" height=\"85\" align=\"right\"><input type=\"radio\" name=\"defaultbank3\" id=\"defaultbankB2b" + n0 + "\" onclick=\"setvalueFunB2b('" + n0 + "')\" value=\"" + k0.getBankCode() + "_B2B" + "\"/></td>"
                            + " <td width=\"10%\"><img src=\"" + contentUrl + "/wuyouchou/system/sysFile/getFileById.ht?fileId=" + fileId0 + "\"/></td>";
                }
                if (k1 != null) {
                    int n1 = i + 2;
                    htmlStr += " <td width=\"5%\" height=\"85\" align=\"right\"><input type=\"radio\" name=\"defaultbank3\" id=\"defaultbank" + n1 + "\" onclick=\"setvalueFun('" + n1 + "')\" value=\"" + k1.getBankCode() + "\"/></td>"
                            + " <td width=\"10%\"><img src=\"" + contentUrl + "/wuyouchou/system/sysFile/getFileById.ht?fileId=" + fileId1 + "\"/></td>";

                    htmlStrB2B += " <td width=\"5%\" height=\"85\" align=\"right\"><input type=\"radio\" name=\"defaultbank3\" id=\"defaultbankB2b" + n1 + "\" onclick=\"setvalueFunB2b('" + n1 + "')\" value=\"" + k1.getBankCode() + "_B2B" + "\"/></td>"
                            + " <td width=\"10%\"><img src=\"" + contentUrl + "/wuyouchou/system/sysFile/getFileById.ht?fileId=" + fileId1 + "\"/></td>";
                }
                if (k2 != null) {
                    int n2 = i + 3;
                    htmlStr += " <td width=\"5%\" height=\"85\" align=\"right\"><input type=\"radio\" name=\"defaultbank3\" id=\"defaultbank" + n2 + "\" onclick=\"setvalueFun('" + n2 + "')\"  value=\"" + k2.getBankCode() + "\"/></td>"
                            + " <td width=\"10%\" align=\"left\"><img src=\"" + contentUrl + "/wuyouchou/system/sysFile/getFileById.ht?fileId=" + fileId2 + "\"/></td>";

                    htmlStrB2B += " <td width=\"5%\" height=\"85\" align=\"right\"><input type=\"radio\" name=\"defaultbank3\" id=\"defaultbankB2b" + n2 + "\" onclick=\"setvalueFunB2b('" + n2 + "')\"  value=\"" + k2.getBankCode() + "_B2B" + "\"/></td>"
                            + " <td width=\"10%\" align=\"left\"><img src=\"" + contentUrl + "/wuyouchou/system/sysFile/getFileById.ht?fileId=" + fileId2 + "\"/></td>";
                }
                htmlStr += "  </tr>";
                htmlStrB2B += "  </tr>";
                i = i + 2;
            }


            return new ModelAndView("/crowdfunding/front/myProjectInvestor/autoSubmitPay.jsp")
                    .addObject("projectId", projectId)
                    .addObject("investId", investId)
                    .addObject("pinvestAmount", pinvestAmount).addObject("htmlStr", htmlStr).addObject("htmlStrB2B", htmlStrB2B);

        } catch (Exception e) {
            logger.error("", e);
        }

        return null;
    }

    @RequestMapping({"savePaymenys"})
    @Action(description = "我要付款")
    public ModelAndView savePaymenys(HttpServletRequest request) throws Exception {
        TUser u = (TUser) request.getSession().getAttribute("user");//当前用户id
        String flowCode = request.getParameter("flowCode");
        //根据当前登录用户取得 用户资金信息
        try {
            //TUserFunds tf=tuserFundsService.getTUserFundsByUserId(u.getUserId());
            HashMap hm = new HashMap();
            TUserFunds tuf = tuserFundsService.getByUserId(u.getUserId());
            TMoneymove tmoneymove = tmoneymoveService.getByIdFlowCode(flowCode);
            hm.put("LoanOutMoneymoremore", tuf.getPayMark());
            hm.put("LoanInMoneymoremore", PayCommonMoney.payformNo);
            hm.put("Amount", tmoneymove.getMoneyInOut().abs());
            hm.put("TransferName", "支付投资金额");
            hm.put("OrderNo", flowCode);
            hm.put("BatchNo", flowCode);
            PayCommon.loanTrans(hm);
            return new ModelAndView("/crowdfunding/onlinePayment/payAskPriceMoneys.jsp")
                    .addObject("hm", hm)
                    .addObject("hmData", hm.get(PayCommonMoney.payDataKey));
        } catch (Exception e) {
            e.printStackTrace();
            // TODO: handle exception
        }

        return null;
    }

    @RequestMapping({"savePaymeny"})
    @ResponseBody
    @Action(description = "保存付款金额")
    public String savePaymeny(HttpServletRequest request, HttpServletResponse response,
                              String investId, String projectId, String freeze, String tradingPwdErrCount) throws Exception {
        String result = "";
        String flowCode = String.valueOf(UniqueIdUtil.genId());
        if (StringUtils.isNotEmpty(investId)) {
            try {

                //(-)
                //
                //1.生成资金记录为 状态为付款失败 tmoneymove


                //2 PayMoneyController
                //2、付款成功之后,a.更新用户投资记录 中的 付款字段为 已付款.
                //  b. 修改用户的资金账户 资金直接减去.
                //c.修改 tmoneymove 资金记录表的状态 为 付款成功
                TcprojectInvest ivest = tcprojectInvestService.getById(Long.valueOf(investId));
                TUserFunds tf = tuserFundsService.getByUserId(Long.valueOf(ivest.getUserId()));
                TMoneymove t = new TMoneymove();
                t.setMoneyMoveId(UniqueIdUtil.genId());
                t.setUserId(tf.getUserId());//
                t.setTypeId("3");
                freeze = "-" + freeze;
                t.setMoneyInOut(new BigDecimal(freeze));
                t.setGetFee(new BigDecimal(0));
                t.setMoneyCurrent(tf.getBalance());
                t.setCreateTime(new Timestamp(System.currentTimeMillis()));
                t.setResultId("2");
                t.setAudit(0l);
                t.setRemark("支付投资金额失败");
                t.setSerialNo("");
                t.setFlowCode(flowCode);
                t.setIsOffLine(0);
                tmoneymoveService.add(t);
				
				
				/*if(StringUtils.isNotEmpty(investId)){
					TcprojectInvest ivest = tcprojectInvestService.getById(Long.valueOf(investId));
					if(ivest.getUserId() != null){
						//验证交易密码
						
						TUser tuser = tuserService.getById(Long.valueOf(ivest.getUserId()));
						//String tradingpwd = tuser.getTradingPwd();
						//String enrypwd = EncryptUtil.encryptSha256(tradingPwdErrCount);
						//if(tradingpwd.equals(enrypwd)){
							TUserFunds  tf = tuserFundsService.getByUserId(Long.valueOf(ivest.getUserId()));
							if(null != tf && StringUtils.isNotEmpty(freeze) 
									&& !"null".equals(freeze) && !"undefined".equals(freeze)){
								
								userFund.setFreeze(new BigDecimal(userFund.getFreeze().doubleValue() + new BigDecimal(freeze).doubleValue()));
								userFund.setAvailable(new BigDecimal(userFund.getAvailable().doubleValue()-new BigDecimal(freeze).doubleValue()));
								//余额不变
								//userFund.setBalance(new BigDecimal(userFund.getBalance().doubleValue() - new BigDecimal(freeze).doubleValue()));
								tuserFundsService.update(userFund);
								TMoneymove t=new TMoneymove();
								t.setMoneyMoveId(UniqueIdUtil.genId());
								t.setUserId(tuser.getUserId());// 
								t.setTypeId("3");
								freeze="-"+freeze;
								t.setMoneyInOut(new BigDecimal(freeze));
								t.setGetFee(new BigDecimal(0));
								t.setMoneyCurrent(tf.getBalance());
								t.setCreateTime(new Timestamp(System.currentTimeMillis())); 
								t.setResultId("2");
								t.setAudit(0l);
								t.setRemark("支付投资金额失败");
								t.setSerialNo("");	
								t.setFlowCode(flowCode);
								t.setIsOffLine(0);
								tmoneymoveService.add(t);
							}
						//}else{
						//	return result= "交易密码输入错误!";
						//}
					}
				}*/
                return flowCode;
            } catch (Exception e) {
                result = "0";
                throw e;
            }
        }
        return result;
    }

    @RequestMapping({"isLeaveMoneny"})
    @ResponseBody
    @Action(description = "是否有足够的余额付款")
    public String isLeaveMoneny(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String result = "0";
        TUserMsgRemind msgremind = null;
        String sendTime = request.getParameter("sendTime");
        String projectId = request.getParameter("projectId");
        if (StringUtils.isNotEmpty(projectId)) {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("projectId", projectId);
            List<TUserMsgRemind> tusermsid = tuserMsgRemindService.getlastSendTimeInfo(map);
            if (null != tusermsid && tusermsid.size() > 0) {
                msgremind = tusermsid.get(0);
            }
        }
        String interval = (String) AppUtil.getServletContext().getAttribute("INTERVIEWS_TIMESPAN");
        try {
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}

