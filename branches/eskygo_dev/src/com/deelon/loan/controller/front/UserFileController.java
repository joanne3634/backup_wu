package com.deelon.loan.controller.front;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.util.FileUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserAuditMat;
import com.deelon.loan.model.front.TUserAuditMatUpload;
import com.deelon.loan.service.front.TUserAuditMatService;
import com.deelon.loan.service.front.TUserAuditMatUploadService;
import com.deelon.loan.service.front.UserInfoService;
import com.deelon.platform.service.util.ServiceUtil;


@Controller
@RequestMapping({ "/user/file/" })
public class UserFileController extends BaseController{

	@Resource
	private UserInfoService userInfoService;
	@Resource
	private TUserAuditMatService userAuditMatService;
	@Resource
	private TUserAuditMatUploadService tuserAuditMatUploadService;

	//private static Logger logger = LoggerFactory.getLogger(TUserAuditMatService.class);
	 private Log logger = LogFactory.getLog(UserFileController.class);
  
	 

		/**
		 * 上传资料
		 * 
		 * @param request
		 * @param response
		 * @param materialsId  材料Id
		 * @return
		 * @throws IOException
		 */
  @RequestMapping({"fileUpload"})
  public void fileUpload(HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    PrintWriter writer = response.getWriter();
    try
    {
      //long userId = ContextUtil.getCurrentUserId().longValue();
      long typeId = RequestUtil.getLong(request, "typeId");
      String uploadType = RequestUtil.getString(request, "uploadType");
      String fileFormates = RequestUtil.getString(request, "fileFormates");
     
      String CKEditorFuncNum=RequestUtil.getString( request, "CKEditorFuncNum" );//ck控件上传
	  String catKey=RequestUtil.getString( request, "catKey" );//ck控件上传
	  String nodeKey=RequestUtil.getString( request, "nodeKey" );//ck控件上传
	  
	  String materialsId = RequestUtil.getString(request, "materialsId");
		
      boolean mark = true;
      TUser user = getSessionUser(request);

      String attachPath = ServiceUtil.getBasePath().replace("/", "\\");
      
      
      
     // GlobalType globalType = null;
//      if (typeId > 0L) {
//        globalType = (GlobalType)this.globalTypeService.getById(Long.valueOf(typeId));
//      }
//      if(globalType==null){	//ck控件上传				
//			QueryFilter qf=new QueryFilter();
//			qf.getFilters().put( "catKey", catKey );
//			qf.getFilters().put( "nodeKey", nodeKey );
//			List list=globalTypeService.getBySqlKeyAll( qf, GlobalType.class, "getByCatKeyNodeKey" );
//			if(list!=null&&list.size()>0)globalType=(GlobalType)list.get( 0 );
//		}
      Map<String, MultipartFile> files =  ((MultipartRequest) request).getFileMap();
      Iterator<MultipartFile> it = files.values().iterator();
      while (it.hasNext())
      {
        Long fileId = Long.valueOf(UniqueIdUtil.genId());
        MultipartFile f = (MultipartFile)it.next();
        String oriFileName = f.getOriginalFilename();
        String extName = FileUtil.getFileExt(oriFileName);
        if ((StringUtil.isNotEmpty(fileFormates)) && 
          (!fileFormates.contains("*." + extName))) {
          mark = false;
        }
        if (mark)
        {
          String fileName = fileId + "." + extName;
          
          String filePath = "";
         // if ("pictureShow".equals(uploadType)) {
         //   filePath = createFilePath(attachPath + File.separator + appUser.getAccount() + File.separator + "pictureShow", fileName);
         // } else {
            filePath = createFilePath(attachPath + File.separator + user.getLoginName() + File.separator, fileName);
         // } 
          this.logger.info("上传的文件路径：" + filePath);
          
          try {
         	 TUserAuditMat userAuditMat = new TUserAuditMat(); 
         	  userAuditMat.setAuditMatId(UniqueIdUtil.genId());
              userAuditMat.setUserId(user.getUserId());   //用户Id
              userAuditMat.setIsPass(2);//默认为待审核
              userAuditMat.setChecker((long) 0);   //默认审核人为0
              userAuditMat.setMaterialsId(Long.valueOf(materialsId));   //审核材料ID
              userAuditMat.setReasons("待审核");    
              userAuditMat.setIsRePass(2);    //默认为待审核
              QueryFilter query = new QueryFilter(request);
              query.addFilter("userId", user.getUserId());
              query.addFilter("materialsId", Long.valueOf(materialsId));
              List list = userAuditMatService.getAll(query);
              if(list.size() == 0){  
            	  userAuditMatService.add(userAuditMat);
              }
              TUserAuditMat t = userAuditMatService.getAll(query).get(0);
              
              if(t.getIsPass() == 1){    //已审核通过的资料
             	 return;
              }
              
              TUserAuditMatUpload userAuditMatUpload = new TUserAuditMatUpload();
              userAuditMatUpload.setUploadId(Long.valueOf(UniqueIdUtil.genId()));
              userAuditMatUpload.setAuditMatId(t.getAuditMatId());
              userAuditMatUpload.setSavePath(filePath.replace(attachPath + File.separator, ""));
              userAuditMatUpload.setUserId(user.getUserId());
              userAuditMatUpload.setUploadTime(new Date());
              userAuditMatUpload.setMaterialsId(Long.valueOf(materialsId));
              tuserAuditMatUploadService.add(userAuditMatUpload);   //保存上传图片资料
              t.setIsPass(2);   //有资料图片上传，，状态恢复为待审核
              t.setReasons("待审核");
              userAuditMatService.update(t);    //更新状态
 		} catch (Exception e) {
 			// TODO: handle exception
 			e.printStackTrace();
 		}
          
          
          FileUtil.writeByte(filePath, f.getBytes()); 
          //SysFile sysFile = new SysFile();
          
          

          
          //sysFile.setFileId(fileId);
         // sysFile.setFileName(oriFileName.substring(0, oriFileName.lastIndexOf('.')));
          //Calendar cal = Calendar.getInstance();
          //Integer year = Integer.valueOf(cal.get(1));
          //Integer month = Integer.valueOf(cal.get(2) + 1);
          //sysFile.setFilePath(filePath.replace(attachPath + File.separator, ""));
         // if (globalType != null)
          //{
          //  sysFile.setTypeId(globalType.getTypeId());
          //  sysFile.setFileType(globalType.getTypeName());
          //}
          //else
         //{
           // sysFile.setTypeId(this.sysTypeKeyService.getByKey("FILE_TYPE").getTypeId());
          //  sysFile.setFileType("-");
          //}
         // sysFile.setCreatetime(new Date());
          
          //sysFile.setExt(extName);
          
         // sysFile.setTotalBytes(Long.valueOf(f.getSize()));
          
         // sysFile.setNote(FileUtil.getSize(f.getSize()));
         // if (appUser != null)
         // {
         //   sysFile.setCreatorId(appUser.getUserId());
         ///   sysFile.setCreator(appUser.getUsername());
         // }
         // else
         // {
          //  sysFile.setCreator(SysFile.FILE_UPLOAD_UNKNOWN);
         // }
          //sysFile.setDelFlag(SysFile.FILE_NOT_DEL);
          //this.sysFileService.add(sysFile);
//          if ("pictureShow".equals(uploadType))
//          {
//            int width = Integer.parseInt(this.configproperties.getProperty("compression.width"));
//            String filePrex = filePath.substring(0, filePath.lastIndexOf("."));
//            filePath = filePrex + "_small" + filePath.substring(filePrex.length());
//            String reutrnStr = ImageUtil.doCompressByByte(f.getBytes(), filePath, width, 40, 1.0F, true);
//            this.logger.info("压缩后的文件：" + reutrnStr);
//          }
          if("IMAGE".equals(nodeKey)||"FILE".equals( nodeKey )||"FLASH".equals( nodeKey )){//FCK图片上传//FCK图片上传
				StringBuffer	returnMsg=new StringBuffer();
				returnMsg.append("<script type=\"text/javascript\">");//userAuditMatUpload.getSavePath().replace("\\", "/")).append("','").append("')"
				returnMsg.append("window.parent.CKEDITOR.tools.callFunction(" ).append(CKEditorFuncNum).append(",'").append(request.getContextPath()+"/file_upload/");
				returnMsg.append("</script>"); 			
				writer.print(returnMsg.toString());
			}else{ 
				writer.println("{\"success\":\"true\",\"fileId\":\"" + fileId + "\",\"fileName\":\"" + oriFileName + "\"}");
			}
        }
        else
        {
          this.logger.error("文件格式不符合要求！");
          writer.println("{\"success\":\"false\"}");
        }
      }
    }
    catch (Exception e)
    {
      e.printStackTrace();
      writer.println("{\"success\":\"false\"}");
    }
  }
  private String createFilePath(String tempPath, String fileName)
  {
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
  
  @RequestMapping({"uploadDialog"})
  public ModelAndView uploadDialog(HttpServletRequest request){
		String materialsId = request.getParameter("materialsId");	  
	return new ModelAndView("/loan/front/fileUploadDialog.jsp").addObject("materialsId", materialsId);
	  
  }
  
	/**
	 * 获取Session中的用户信息
	 * @param request
	 * @return
	 */
	public TUser getSessionUser(HttpServletRequest request) {
		return (TUser) request.getSession().getAttribute("user");
	}
	
}
