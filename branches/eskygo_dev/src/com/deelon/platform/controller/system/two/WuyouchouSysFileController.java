package com.deelon.platform.controller.system.two;

import com.deelon.core.annotion.Action;
import com.deelon.core.annotion.ActionExecOrder;
import com.deelon.core.log.SysAuditThreadLocalHolder;
import com.deelon.core.util.*;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.common.constants.WuyouchouConfigKeys;
import com.deelon.crowdfunding.common.exception.ResourceNotFoundException;
import com.deelon.platform.model.system.GlobalType;
import com.deelon.platform.model.system.SysFile;
import com.deelon.platform.model.system.SysUser;
import com.deelon.platform.service.system.GlobalTypeService;
import com.deelon.platform.service.system.SysFileService;
import com.deelon.platform.service.system.SysTypeKeyService;
import com.deelon.platform.service.system.SysUserService;
import com.deelon.platform.service.util.ServiceUtil;
import com.deelon.platform.util.SysFileHelper;
import com.google.common.hash.Hashing;
import com.google.common.io.ByteStreams;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
@RequestMapping({"/wuyouchou/system/sysFile/"})
public class WuyouchouSysFileController
        extends BaseController {
    private Log logger = LogFactory.getLog(WuyouchouSysFileController.class);
    @Resource
    private SysFileService sysFileService;

    @Resource
    private SysUserService sysUserService;
    @Resource
    private GlobalTypeService globalTypeService;
    @Resource
    private SysTypeKeyService sysTypeKeyService;
    private String attachPath = ServiceUtil.getBasePath().replace("/", "\\");

    @RequestMapping({"getFileById"})
    @Action(description = "根据文件id取得附件数据", exectype = "管理日志", detail = "根据文件id取得附件数据")
    public void getFileById(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        long fileId = RequestUtil.getLong(request, "fileId", 0L);
        String type = RequestUtil.getString(request, "type");
        if (fileId == 0L) {
            throw new ResourceNotFoundException();
        }
        SysFile sysFile = (SysFile) SysFileHelper.getSysFileById(Long.valueOf(fileId));
        if (sysFile == null) {
            throw new ResourceNotFoundException();
        }
        String filePath = sysFile.getFilePath();
        String fullPath = StringUtil.trimSufffix(this.attachPath, File.separator) + File.separator + filePath.replace("/", File.separator);
        if ("small".equals(type)) {
            String filePrex = fullPath.substring(0, fullPath.lastIndexOf("."));
            fullPath = filePrex + "_small" + fullPath.substring(filePrex.length());
        }

        String fileExt = sysFile.getExt();
        if ("jpg".equals(fileExt.toLowerCase())) {
            response.setContentType("image/jpeg");
        } else if ("png".equals(fileExt.toLowerCase()) || "gif".equals(fileExt.toLowerCase())) {
            response.setContentType("image/" + fileExt.toLowerCase());
        }
        String etag = Hashing.goodFastHash(32).hashUnencodedChars(filePath + String.valueOf(sysFile.getDelFlag())).toString();
        if (etag.toString().equals(request.getHeader("If-None-Match"))) {
            response.setHeader("Cache-Control", "max-age=300");
            response.setStatus(HttpStatus.NOT_MODIFIED.value());
            return;
        }

        FileInputStream fileInputStream = null;
        try {
            fileInputStream = new FileInputStream(fullPath);
        } catch (FileNotFoundException fe) {
            logger.error("文件路径不存在:" + fullPath);
            logger.error(fe.toString());
            throw new ResourceNotFoundException();
        }
        if (null != fileInputStream) {
            response.setHeader("ETag", etag.toString());
            response.setContentLength(sysFile.getTotalBytes().intValue());
            response.setHeader("Cache-Control", "max-age=300");
            ByteStreams.copy(fileInputStream, response.getOutputStream());
            response.flushBuffer();
        }
    }

    @RequestMapping({"fileUpload"})
    @Action(description = "文件上传", exectype = "管理日志", detail = "上传文件<#list sysFiles as item>【${item.fileName}】</#list>")
    public void fileUpload(MultipartHttpServletRequest request, HttpServletResponse response)
            throws Exception {
        PrintWriter writer = response.getWriter();
        String picSizeStr = (String) AppUtil.getServletContext().getAttribute("PIC_UPLOAD_LIMIT");
        Long picSize = StringUtil.isEmpty(picSizeStr) ? WuyouchouConfigKeys.PIC_SIZE_LIMIT_DEFAULT : Long.valueOf(picSizeStr);
        try {
            long userId = ContextUtil.getCurrentUserId().longValue();
            long typeId = RequestUtil.getLong(request, "typeId");
            String uploadType = RequestUtil.getString(request, "uploadType");
            String fileFormates = RequestUtil.getString(request, "fileFormates");

            String CKEditorFuncNum = RequestUtil.getString(request, "CKEditorFuncNum");//ck控件上传
            String catKey = RequestUtil.getString(request, "catKey");//ck控件上传
            String nodeKey = RequestUtil.getString(request, "nodeKey");//ck控件上传

            boolean mark = true;
            SysUser appUser = null;
            if (userId > 0L) {
                appUser = (SysUser) this.sysUserService.getById(Long.valueOf(userId));
            }
            if (appUser == null) {
                appUser = new SysUser();
                Object u = (Object) request.getSession().getAttribute("user");
                if (u != null) {
                    appUser.setUserId(Long.parseLong(BeanUtils.getProperty(u, "userId")));
                    appUser.setAccount(BeanUtils.getProperty(u, "loginName"));
                } else {
                    appUser.setUserId(1l);
                    appUser.setAccount("admin");
                }
            }
            String attachPath = ServiceUtil.getBasePath().replace("/", "\\");

            GlobalType globalType = null;
            if (typeId > 0L) {
                globalType = (GlobalType) this.globalTypeService.getById(Long.valueOf(typeId));
            }
            if (globalType == null) {    //ck控件上传
                QueryFilter qf = new QueryFilter();
                qf.getFilters().put("catKey", catKey);
                qf.getFilters().put("nodeKey", nodeKey);
                List list = globalTypeService.getBySqlKeyAll(qf, GlobalType.class, "getByCatKeyNodeKey");
                if (list != null && list.size() > 0) globalType = (GlobalType) list.get(0);
            }
            Map<String, MultipartFile> files = request.getFileMap();
            Iterator<MultipartFile> it = files.values().iterator();
            while (it.hasNext()) {
                Long fileId = Long.valueOf(UniqueIdUtil.genId());
                MultipartFile f = (MultipartFile) it.next();
                String oriFileName = f.getOriginalFilename();
                String extName = FileUtil.getFileExt(oriFileName);
                if ((StringUtil.isNotEmpty(fileFormates)) &&
                        (!fileFormates.contains("*." + extName))) {
                    mark = false;
                }
//              判断图片大小
                Pattern p=Pattern.compile("([^\\s]+(\\.(?i)(jpg|png|gif|jpeg))$)");
                Matcher m=p.matcher(oriFileName);
                if(m.matches()) {
                    if (com.deelon.crowdfunding.common.util.FileUtil.isExceedSizeLimitation(f, picSize)) {
                        logger.info("pic exceed the size,originalPicName=" + f.getOriginalFilename());
                        mark = false;
                    }
                }
                if (mark) {
                    String fileName = fileId + "." + extName;

                    String filePath = "";
                    if ("pictureShow".equals(uploadType)) {
                        filePath = createFilePath(attachPath + File.separator + appUser.getUserId() + File.separator + "pictureShow", fileName);
                    } else {
                        filePath = createFilePath(attachPath + File.separator + appUser.getUserId(), fileName);
                    }
                    this.logger.info("上传的文件路径：" + filePath);
                    if ("IMAGE".equals(nodeKey)) {//FCK图片上传
                        StringBuffer errorMsg = new StringBuffer();
                        if (!FileUtil.isFileType(extName, nodeKey)) {
                            errorMsg.append("<script type=\"text/javascript\">");
                            errorMsg.append("window.parent.CKEDITOR.tools.callFunction(").append(CKEditorFuncNum).append(",'")
                                    .append(filePath).append("','").append("附件不是正确的图片类型!").append("')");
                            errorMsg.append("</script>");
                            response.setContentType("text/html;charset=utf-8");
                            writer.print(errorMsg.toString());
                            return;
                        }
                    }
                    FileUtil.writeByte(filePath, f.getBytes());
                    SysFile sysFile = new SysFile();
                    sysFile.setFileId(fileId);
                    sysFile.setFileName(oriFileName.substring(0, oriFileName.lastIndexOf('.')));
                    Calendar cal = Calendar.getInstance();
                    Integer year = Integer.valueOf(cal.get(1));
                    Integer month = Integer.valueOf(cal.get(2) + 1);
                    sysFile.setFilePath(filePath.replace(attachPath + File.separator, ""));
                    if (globalType != null) {
                        sysFile.setTypeId(globalType.getTypeId());
                        sysFile.setFileType(globalType.getTypeName());
                    } else {
                        sysFile.setTypeId(this.sysTypeKeyService.getByKey("FILE_TYPE").getTypeId());
                        sysFile.setFileType("-");
                    }
                    sysFile.setCreatetime(new Date());

                    sysFile.setExt(extName);

                    sysFile.setTotalBytes(Long.valueOf(f.getSize()));

                    sysFile.setNote(FileUtil.getSize(f.getSize()));
                    if (appUser != null) {
                        sysFile.setCreatorId(appUser.getUserId());
                        sysFile.setCreator(appUser.getUsername());
                    } else {
                        sysFile.setCreator(SysFile.FILE_UPLOAD_UNKNOWN);
                    }
                    sysFile.setDelFlag(SysFile.FILE_NOT_DEL);
                    this.sysFileService.add(sysFile);
                    if ("pictureShow".equals(uploadType)) {
                        int width = Integer.parseInt(this.configproperties.getProperty("compression.width"));
                        String filePrex = filePath.substring(0, filePath.lastIndexOf("."));
                        filePath = filePrex + "_small" + filePath.substring(filePrex.length());
                        String reutrnStr = ImageUtil.doCompressByByte(f.getBytes(), filePath, width, 40, 1.0F, true);
                        this.logger.info("压缩后的文件：" + reutrnStr);
                    }
                    if ("IMAGE".equals(nodeKey) || "FILE".equals(nodeKey) || "FLASH".equals(nodeKey)) {//FCK图片上传//FCK图片上传
                        StringBuffer returnMsg = new StringBuffer();
                        returnMsg.append("<script type=\"text/javascript\">");
                        filePath = request.getContextPath() + "/wuyouchou/system/sysFile/getFileById.ht?fileId=" + fileId;
                        returnMsg.append("window.parent.CKEDITOR.tools.callFunction(").append(CKEditorFuncNum).append(",'").append(filePath).append("','").append("')");
                        returnMsg.append("</script>");
                        writer.print(returnMsg.toString());
                    } else {
                        writer.println("{\"success\":\"true\",\"fileId\":\"" + fileId + "\",\"fileName\":\"" + oriFileName + "\"}");
                    }
                    try {
                        List<SysFile> sysFiles;
                        if (SysAuditThreadLocalHolder.getParamerter("sysFiles") == null) {
                            sysFiles = new ArrayList();
                            SysAuditThreadLocalHolder.putParamerter("sysFiles", sysFiles);
                        } else {
                            sysFiles = (List) SysAuditThreadLocalHolder.getParamerter("sysFiles");
                        }
                        sysFiles.add(sysFile);

                    } catch (Exception e) {
                        e.printStackTrace();
                        this.logger.error(e.getMessage());
                    }
                } else {
                    this.logger.error("文件格式不符合要求！");
                    writer.println("{\"success\":\"false\"}");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            writer.println("{\"success\":\"false\"}");
        }
    }

    @RequestMapping({"delByFileId"})
    @Action(description = "删除附件", execOrder = ActionExecOrder.BEFORE, exectype = "管理日志", detail = "删除系统附件<#list StringUtils.split(ids,\",\") as item><#assign entity=sysFileService.getById(Long.valueOf(item))/>【${entity.fileName}】</#list>")
    public void delByFileId(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        PrintWriter out = response.getWriter();
        Long[] lAryId = RequestUtil.getLongAryByStr(request, "ids");
        try {
            for (Long id : lAryId) {
                SysFile sysFile = (SysFile) this.sysFileService.getById(id);
                String filePath = sysFile.getFilePath();
                filePath = filePath.replace('\\', '/');
                if (StringUtil.isEmpty(this.attachPath)) {
                    filePath = AppUtil.getRealPath(filePath);
                }
                FileUtil.deleteFile(this.attachPath + File.separator + filePath);
            }
            this.sysFileService.delByIds(lAryId);
            out.print("{\"success\":\"true\"}");
        } catch (Exception e) {
            out.print("{\"success\":\"false\"}");
        }
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
        return one.getPath() + File.separator + fileName;
    }

}
