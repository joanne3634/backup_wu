package com.deelon.crowdfunding.controller.front;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.text.html.HTMLDocument.HTMLReader;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.page.PageBean;
import com.deelon.core.util.FileUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.common.util.TUserUtil;
import com.deelon.crowdfunding.model.backstage.Tcproject;
import com.deelon.crowdfunding.model.backstage.TcprojectAfter;
import com.deelon.crowdfunding.model.backstage.TcprojectAttachment;
import com.deelon.crowdfunding.service.backstage.TcprojectAfterService;
import com.deelon.crowdfunding.service.backstage.TcprojectAttachmentService;
import com.deelon.crowdfunding.service.backstage.TcprojectService;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.util.HtmlRegexpUtil;
import com.deelon.platform.service.util.ServiceUtil;

/**
 * 
 * czz
 */
@Controller
@RequestMapping({ "/crowdfunding/tcprojectAfter/" })
public class TcprojectAfterController extends BaseController {
	
	private String attachPath = ServiceUtil.getBasePath().replace("/", "\\");
	@Autowired
	private TcprojectService tcprojectService;
	@Autowired
	private TcprojectAfterService tcprojectAfterService;
	@Autowired
	TcprojectAttachmentService tcprojectAttachmentService;
	
	/*
	 * 投后管理项目列表
	 */
	@RequestMapping({"tcprojectAfterProjectList"})
	public ModelAndView tcprojectAfterProjectList(HttpServletRequest request,HttpServletResponse response){
		
		String pname = RequestUtil.getString(request, "pname");
		String ptypeId = RequestUtil.getString(request, "ptypeId");
		
		//分页加参数
		QueryFilter filter = new QueryFilter();
		filter.addFilter("pisCheck", 1);
		filter.addFilter("pname", pname);
		filter.addFilter("ptypeId", ptypeId);
		int page = RequestUtil.getInt(request, "current_page", 1);//默认存入页码
		int pageSize = RequestUtil.getInt(request, "pageSize",3);//存入每页显示的条数
		PageBean pb=new  PageBean(page, pageSize); 
		filter.setPageBean(pb);
		List<Tcproject> tcprojectList=tcprojectService.getAll(filter);
		request.setAttribute( "page_bean", pb);//分页参数传入页面
		request.setAttribute("pname", pname);
		request.setAttribute("ptypeId", ptypeId);
		return new ModelAndView("/crowdfunding/front/tcprojectAfterProjectList.jsp")
		.addObject("tcprojectList",tcprojectList).addObject( "page_bean", pb );
		
	}
	
//	/*
//	 * 项目关联的投后列表
//	 */
//	@RequestMapping({"tcprojectAfterListPr"})
//	public ModelAndView tcprojectAfterListPr(HttpServletRequest request,HttpServletResponse response){
//		
//		String projectId = RequestUtil.getString(request, "projectId");
//		
//		//分页加参数
//		Map map=new HashMap();
//		map.put("projectId", projectId);
//		int page = RequestUtil.getInt(request, "current_page", 1);//默认存入页码
//		int pageSize = RequestUtil.getInt(request, "pageSize",5);//存入每页显示的条数
//		PageBean pb=new  PageBean(page, pageSize);
//		List<TcprojectAfter> tcprojectAfterList=tcprojectAfterService.getAllPname(map, pb);
//		request.setAttribute( "page_bean", pb);//分页参数传入页面
//		request.setAttribute("projectId", projectId);
//		return new ModelAndView("/crowdfunding/front/tcprojectAfterListPr.jsp").addObject("tcprojectAfterList", tcprojectAfterList)
//		.addObject( "page_bean", pb );
//		
//	}
	
	/*
	 * 投后管理创业者列表
	 */
	@RequestMapping({"tcprojectAfterCrList"})
	public ModelAndView tcprojectAfterCrList(HttpServletRequest request,HttpServletResponse response){
		
		String projectName = RequestUtil.getString(request, "projectName");
		String paTypeId = RequestUtil.getString(request, "paTypeId");
		String paTitle = RequestUtil.getString(request, "paTitle");
		
		//分页加参数
		Map map=new HashMap();
		map.put("projectName", projectName);
		map.put("paTypeId", paTypeId);
		map.put("paTitle", paTitle);
		map.put("creator", TUserUtil.getLogUser(request).getUserId());
		int page = RequestUtil.getInt(request, "current_page", 1);//默认存入页码
		int pageSize = RequestUtil.getInt(request, "pageSize",10);//存入每页显示的条数
		PageBean pb=new  PageBean(page, pageSize);
		List<TcprojectAfter> tcprojectAfterList=tcprojectAfterService.getAllPname(map, pb);
		request.setAttribute( "page_bean", pb);//分页参数传入页面
		request.setAttribute("projectName", projectName);
		request.setAttribute("paTypeId", paTypeId);
		request.setAttribute("paTitle", paTitle);
		return new ModelAndView("/crowdfunding/front/tcprojectAfterCrList.jsp").addObject("tcprojectAfterList", tcprojectAfterList)
		.addObject( "page_bean", pb );
		
	}

	/*
	 * 投后管理列表
	 */
	@RequestMapping({"tcprojectAfterList"})
	public ModelAndView tcprojectAfterList(HttpServletRequest request,HttpServletResponse response){
		
		String projectName = RequestUtil.getString(request, "projectName");
		String paTypeId = RequestUtil.getString(request, "paTypeId");
		String paTitle = RequestUtil.getString(request, "paTitle");
		
		//分页加参数
		Map map=new HashMap();
		map.put("projectName", projectName);
		map.put("paTypeId", paTypeId);
		map.put("paTitle", paTitle);
		int page = RequestUtil.getInt(request, "current_page", 1);//默认存入页码
		int pageSize = RequestUtil.getInt(request, "pageSize",10);//存入每页显示的条数
		PageBean pb=new  PageBean(page, pageSize);
		List<TcprojectAfter> tcprojectAfterList=tcprojectAfterService.getAllPname(map, pb);
		request.setAttribute( "page_bean", pb);//分页参数传入页面
		request.setAttribute("projectName", projectName);
		request.setAttribute("paTypeId", paTypeId);
		request.setAttribute("paTitle", paTitle);
		return new ModelAndView("/crowdfunding/front/tcprojectAfterList.jsp").addObject("tcprojectAfterList", tcprojectAfterList)
		//return new ModelAndView("/crowdfunding/front/investorAfterManage/AfterInvestors.jsp").addObject("tcprojectAfterList", tcprojectAfterList)
		.addObject( "page_bean", pb );
		
	}
	
	/*
	 * 投资人投后管理列表
	 */
	@RequestMapping({"tcprojectAfterInvestorList"})
	public ModelAndView tcprojectAfterInvestorList(HttpServletRequest request,HttpServletResponse response){
		TUser user = TUserUtil.getLogUser(request);//获取登陆用户
		//分页加参数
		Map map=new HashMap();
		map.put("userId", user.getUserId());
		int page = RequestUtil.getInt(request, "current_page", 1);//默认存入页码
		int pageSize = RequestUtil.getInt(request, "pageSize",10);//存入每页显示的条数
		PageBean pb=new  PageBean(page, pageSize);
		@SuppressWarnings("unchecked")
		List<TcprojectAfter> tcprojectAfterInvestorList=tcprojectAfterService.getAllAfter(map, pb);
		request.setAttribute( "page_bean", pb);//分页参数传入页面
		//return new ModelAndView("/crowdfunding/front/tcprojectAfterList.jsp").addObject("tcprojectAfterList", tcprojectAfterList)
		return new ModelAndView("/crowdfunding/front/investorAfterManage/AfterInvestors.jsp").addObject("tcprojectAfterInvestorList", tcprojectAfterInvestorList)
		.addObject( "page_bean", pb );
		
	}
	
	/**
	 * 
	 * @param request 添加投后管理
	 * @return
	 * @throws Exception
	 */
	@RequestMapping({ "projectAfterForm" })
	public ModelAndView projectAfterAdd(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Long afterId = UniqueIdUtil.genId();
		QueryFilter filter = new QueryFilter();
		filter.addFilter("creator", TUserUtil.getLogUser(request).getUserId());
		List<Tcproject> tcprojectList=tcprojectService.getAll(filter);
		return new ModelAndView("/crowdfunding/front/tcprojectAfterForm.jsp").addObject("afterId",afterId)
				.addObject("tcprojectList",tcprojectList);
	}
	
	/**
	 * 
	 * @param request 保存投后管理
	 * @return
	 * @throws Exception
	 */
	@RequestMapping({ "projectAfterSave" })
	public void projectAfterSave(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Long afterId=RequestUtil.getLong( request, "afterId" );
		Long projectId=RequestUtil.getLong( request, "projectId" );
		//String attachmentId=RequestUtil.getString( request, "attachmentId" );
		
		int paTypeId=RequestUtil.getInt(request, "paTypeId" );
		String paTitle=RequestUtil.getString( request, "paTitle" );
		String paContent=RequestUtil.getString( request, "paContent" );
		String fileId=request.getParameter("fileId");
		//TUser user = getSessionUser(request);
		Long userId = TUserUtil.getLogUser(request).getUserId();
		String message="添加成功";
		
		      try {
//		    	  JSONArray jsonArray = new JSONArray();
		    	 // String fileIds="[]";
		    	 // if(!projectAfterFile.equals("")){
		    	//	  fileIds = projectAfterFile;
		    	 // }
//		    	  if(!projectAfterFile.equals("") && !projectAfterFile.equals("[]")){
//		    		  JSONArray jsonArray2 = JSONArray.fromObject(projectAfterFile);
//		    		  System.out.println(jsonArray2);
//		    		  
//		    		  System.out.println(jsonArray2.size());
//		    		  
//		    		  int size = jsonArray2.size();
//		    		  if(jsonArray2!=null && jsonArray2.size()>0){
//		    			  for(int i=0;i<jsonArray2.size();i++){
//		    				  JSONObject objt = jsonArray2.getJSONObject(i);
//		    				  String fileId=objt.getString("fileId");
//		    				  String fileName=objt.getString("fileName");
//		    				  JSONObject obj = new JSONObject();
//		    				  obj.put("fileId", fileId);
//		    				  obj.put("fileName", fileName);
//		    				  jsonArray.add(obj);
//		    			  }	
//		    		  }
//		    		  fileIds = jsonArray.toString();
//		    		  
//		    	  }
		    	  
		    	  TcprojectAfter tcprojectAfter=new TcprojectAfter();
		    	  tcprojectAfter.setAfterId(afterId);
		    	  tcprojectAfter.setProjectId(projectId);
		    	  tcprojectAfter.setPaTypeId(paTypeId);
		    	  tcprojectAfter.setPaTitle(paTitle);
		    	  tcprojectAfter.setPaContent(paContent);
		    	  tcprojectAfter.setCreator(userId);
		    	  tcprojectAfter.setCreateTime(new Date());
		    	  tcprojectAfter.setFileId(fileId);
		    	  tcprojectAfter.setViewCount(0);
		    	  tcprojectAfter.setIsDel(0);
		    	  tcprojectAfterService.add(tcprojectAfter);
		    	  
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
					message = "添加失败";
				} 
		      
		      response.getWriter().write(message);
		
	}
	
	/**
	 * 
	 * @param request 编辑投后管理
	 * @return
	 * @throws Exception
	 */
	@RequestMapping({ "projectAfterEdit" })
	public ModelAndView projectAfterEdit(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Long afterId=RequestUtil.getLong( request, "afterId" );
		
		QueryFilter filter = new QueryFilter();
		filter.addFilter("creator", TUserUtil.getLogUser(request).getUserId());
		TcprojectAfter tcprojectAfter=tcprojectAfterService.getById(afterId);
		List<Tcproject> tcprojectList=tcprojectService.getAll(filter);
		//List arrayDataList = getArrayDataList(tcprojectAfter.getFileId());
		return new ModelAndView("/crowdfunding/front/tcprojectAfterEdit.jsp").addObject("tcprojectAfter", tcprojectAfter)
				.addObject("tcprojectList", tcprojectList);
	}
	
	/**
	 * 
	 * @param request 修改投后管理
	 * @return
	 * @throws Exception
	 */
	@RequestMapping({ "projectAfterUpdate" })
	public void projectAfterUpdate(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Long afterId=RequestUtil.getLong( request, "afterId" );
		Long projectId=RequestUtil.getLong( request, "projectId" );
		int paTypeId=RequestUtil.getInt(request, "paTypeId" );
		String paTitle=RequestUtil.getString( request, "paTitle" );
		String paContent=RequestUtil.getString( request, "paContent" );
		String fileId=request.getParameter("fileId");
		String message ="修改失败";
		try{
		TcprojectAfter tcprojectAfter=tcprojectAfterService.getById(afterId);
	
		tcprojectAfter.setProjectId(projectId);
		tcprojectAfter.setPaTypeId(paTypeId);
		tcprojectAfter.setPaTitle(paTitle);
		tcprojectAfter.setPaContent(paContent);
		tcprojectAfter.setFileId(fileId);
		tcprojectAfterService.update(tcprojectAfter);
		message ="修改成功";
		}catch(Exception e){
			e.printStackTrace();
			message = "修改失败";
		}

		 response.getWriter().write(message);
//		return new ModelAndView("/urlDialog.jsp").addObject("message", message)
//		.addObject("url", "tcprojectAfterList.ht");
		
	}
	
	/**
	 * 
	 * @param request 投后管理查看
	 * @return
	 * @throws Exception
	 */
	@RequestMapping({ "projectAfterDetail" })
	public ModelAndView projectAfterDetail(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Long afterId=RequestUtil.getLong( request, "afterId" );
		TcprojectAfter tcprojectAfter=tcprojectAfterService.getById(afterId);
		
		
		//List dataList=getArrayDataList(tcprojectAfter.getFileId());
		return new ModelAndView("/crowdfunding/front/tcprojectAfterDetail.jsp").addObject("tcprojectAfter",tcprojectAfter);
	}
	
	/**
	 * 
	 * @param request 删除投后数据
	 * @return
	 * @throws Exception
	 */
	@RequestMapping({ "projectAfterDelByIds" })
	@ Action( description = "删除投后数据")
	@ResponseBody
	public void projectAfterDelByIds(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String ids=RequestUtil.getString(request, "ids");
		String idArray[]=ids.split(";");
		String message="删除成功";
		String projectPath=request.getSession().getServletContext().getRealPath("/");
		try {
			TcprojectAfter tcprojectAfter = null;
//			TcprojectAttachment tcprojectAttachment = null;
			String idStr="";
			for(int i=0;i<idArray.length;i++){
				idStr = idArray[i];
				if(!idStr.equals("")){					
				tcprojectAfter=tcprojectAfterService.getById(Long.valueOf(idStr));
				tcprojectAfter.setIsDel(1);
				tcprojectAfterService.update(tcprojectAfter);
//				String fileIds = tcprojectAfter.getFileId();
//				if(fileIds!=null && !fileIds.equals("") && fileIds.equals("[]")){
//					JSONArray jsonArray = JSONArray.fromObject(fileIds);
//					for(int j=0;j<jsonArray.size();j++){
//						String  id = jsonArray.getJSONObject(j).getString("fileId");
//						tcprojectAttachment=tcprojectAttachmentService.getById(Long.valueOf(id));
//						tcprojectAttachmentService.delById(Long.valueOf(id));
//						new File((projectPath+"/"+tcprojectAttachment.getPapath()).replace("/", File.separator)).delete();
//					}
//				}
//				tcprojectAfterService.delById(Long.valueOf(idStr));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			message="删除失败";
		}
		response.getWriter().write(message);
	}
	
	/**
	 * 
	 * @param request 初始化投后页面
	 * @return
	 * @throws Exception
	 */
	/*@RequestMapping({ "loadInvestedProject" })
	public ModelAndView loadInvestedProject(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Long projectId=RequestUtil.getLong( request, "projectId" );
		Tcproject tcproject=null;
		List<TcprojectAttachment> attachList=null;
		if (projectId.longValue() != 0L){
			//tcproject=tcprojectService.getById(projectId);
			//attachList=tcprojectAttachmentService.getByProId(projectId);
			//tcprojectAttachmentService.
		}
		return new ModelAndView("/crowdfunding/front/loadInvestedProject.jsp")
		.addObject( "tcproject", tcproject).addObject("attachList", attachList);
	}
	*/
	
	
	
	/**
	 * 投后上传资料
	 * 
	 * @param request
	 * @param response
	 * @param materialsId  材料Id
	 * @return
	 * @throws IOException
	 */
@RequestMapping({"projectAfterFileUpload"})
public void fileUpload(HttpServletRequest request, HttpServletResponse response)
throws Exception
{
PrintWriter writer = response.getWriter();
try
{
  //long userId = ContextUtil.getCurrentUserId().longValue();
  String projectId = RequestUtil.getString(request, "projectId");
 // String uploadType = RequestUtil.getString(request, "uploadType");

  String CKEditorFuncNum=RequestUtil.getString( request, "CKEditorFuncNum" );//ck控件上传
  //String catKey=RequestUtil.getString( request, "catKey" );//ck控件上传
  String nodeKey=RequestUtil.getString( request, "nodeKey" );//ck控件上传
	
  boolean mark = true;
 // TUser user = getSessionUser(request);
  Long userId = TUserUtil.getLogUser(request).getUserId();

  String attachPath = ServiceUtil.getBasePath().replace("/", "\\");
  
  Map<String, MultipartFile> files =  ((MultipartRequest) request).getFileMap();
  int size=files.size();
  if(size>1){
	  this.logger.error("只能选择一个文件！");
      writer.println("{\"success\":\"false\"}");
      return;
  }
  String fileJson="";
  Iterator<MultipartFile> it = files.values().iterator();
  while (it.hasNext())
  {
    Long fileId = Long.valueOf(UniqueIdUtil.genId());
    MultipartFile f = (MultipartFile)it.next();
    String oriFileName = f.getOriginalFilename();
    String extName = FileUtil.getFileExt(oriFileName);
    //String preName = oriFileName.substring(0,oriFileName.lastIndexOf("."));
    if (mark)
    {
      String fileName = fileId + "." + extName;
      
    //  String filePath = "";
     // if ("pictureShow".equals(uploadType)) {
     //   filePath = createFilePath(attachPath + File.separator + appUser.getAccount() + File.separator + "pictureShow", fileName);
     // } else {
     // filePath = createFilePath(attachPath + File.separator + afterId + File.separator + userId + File.separator, fileName);
        //filePath = createFilePath(attachPath + File.separator + projectId + File.separator  + File.separator, fileName);
     // } 
        
        
        String projectPath = request.getSession().getServletContext().getRealPath("/");
	      String filePath = "";
	
	        filePath = createFilePath(attachPath + "/" + "projectAfterFile" + "/" + projectId + "/" + userId);
	        String realPath=projectPath+filePath;
	        File realPathFile = new File(realPath);
	        if(!realPathFile.exists()){
	        	realPathFile.mkdirs();
	        }
	   
	        this.logger.info("上传的文件路径：" + filePath);
	        String extpath=filePath.replace("\\", "/")+"/"+fileName;
        
      this.logger.info("上传的文件路径：" + filePath);
      
      TcprojectAttachment tcprojectAttachment=null;
      
      try {
    	  
    	  FileUtil.writeByte(realPath+File.separator+fileName, f.getBytes());
    	  Long attachmentId=UniqueIdUtil.genId();
    	  tcprojectAttachment = new TcprojectAttachment(); 
    	  tcprojectAttachment.setAttachmentId(attachmentId);
    	  tcprojectAttachment.setProjectId(Long.valueOf(projectId));
    	  tcprojectAttachment.setPaname(oriFileName);
    	  tcprojectAttachment.setPafileName(oriFileName);
    	  tcprojectAttachment.setPapath(extpath);
    	  tcprojectAttachment.setCreator(userId); //用户Id
    	  tcprojectAttachment.setCreateTime(new Date());  
    	  tcprojectAttachmentService.add(tcprojectAttachment);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
      
      fileJson+="{fileId:"+fileId+","+"fileName:"+oriFileName+"}";
      if("IMAGE".equals(nodeKey)||"FILE".equals( nodeKey )||"FLASH".equals( nodeKey )){//FCK图片上传//FCK图片上传
			StringBuffer	returnMsg=new StringBuffer();
			returnMsg.append("<script type=\"text/javascript\">");//userAuditMatUpload.getSavePath().replace("\\", "/")).append("','").append("')"
			returnMsg.append("window.parent.CKEDITOR.tools.callFunction(" ).append(CKEditorFuncNum).append(",'").append(request.getContextPath()+"/file_upload/");
			returnMsg.append("</script>"); 			
			writer.print(returnMsg.toString());
		}else{ 
			writer.println("{\"success\":\"true\",\"fileId\":\"" + tcprojectAttachment.getAttachmentId()
					+ "\",\"fileName\":\"" + tcprojectAttachment.getPaname() + "\"}");
		}
    }
    else
    {
      this.logger.error("文件格式不符合要求！");
      writer.println("{\"success\":\"false\"}");
    }
  }
 // writer.println("{\"success\":\"true\",\"fileId\":\"" + 123 + "\",\"fileName\":\"" + "tyu" + "\"}");
  
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
private String createFilePath(String tempPath)
{
Calendar cal = Calendar.getInstance();
Integer year = Integer.valueOf(cal.get(1));
Integer month = Integer.valueOf(cal.get(2) + 1);
return tempPath + File.separator + year + File.separator + month;
}

@RequestMapping({"projectAfterUploadDialog"})
public ModelAndView uploadDialog(HttpServletRequest request){
		String projectId = RequestUtil.getString(request, "projectId");
	return new ModelAndView("/crowdfunding/front/projectAfterUploadDialog.jsp").addObject("projectId", projectId);
	  
}

/**
 * @param request 删除投后附件
 */
@Action(description="删除项目附件")
@RequestMapping({ "projectAfterAttachDel" })
public void projectAfterAttachDel(HttpServletRequest request,HttpServletResponse response) throws Exception {
	String ids=RequestUtil.getString(request, "ids");
	String idArray[]=ids.split(";");
	String result="0";
	try{
		for(int i=0;i<idArray.length;i++){
			Long id=Long.valueOf(idArray[i]);
			tcprojectAttachmentService.delById(id);
		}
		result="1";
	}catch(Exception e){
		e.printStackTrace();
	}
	response.getWriter().write(result);

}


public List<String[]> getArrayDataList(String jsonString){
	List<String[]> dataList = null;
	
	//JSONObject jsonObj = JSONObject.fromObject(jsonString);
	//JSONArray jsonArray = jsonObj.getJSONArray("attachs");
	if(jsonString!=null && !jsonString.equals("") && !jsonString.equals("[]")){
		JSONArray jsonArray = JSONArray.fromObject(jsonString);
		String fileId="";
		String fileName="";
		if(jsonArray!=null && jsonArray.size()>0){
			dataList = new ArrayList<String[]>();
			for(int i=0;i<jsonArray.size();i++){
				fileId=jsonArray.getJSONObject(i).getString("fileId");
				fileName=jsonArray.getJSONObject(i).getString("fileName");
				String fileArray[]={fileId,fileName};
				dataList.add(fileArray);
			}	
		}
		
	}
	return dataList;
	
}
	
	//private TUser getSessionUser(HttpServletRequest request) {
	//	return (TUser) request.getSession().getAttribute("user");
	//}

	@RequestMapping({"afterFileDownloadById"})
	@Action(description="附件下载")
	@ResponseBody
	public void afterFileDownloadById(HttpServletRequest request,HttpServletResponse response){
			String fileId = RequestUtil.getString(request, "fileId");

			InputStream is = null;  
			OutputStream os = null;
			String rootpath = request.getSession().getServletContext().getRealPath("/");
			try{
				TcprojectAttachment tcprojectAttachment=tcprojectAttachmentService.getById(Long.valueOf(fileId));
				
				
				if(tcprojectAttachment == null){
					this.writeObjectToClient("文件不存在", response);
				}
				
				response.setHeader("Content-disposition", "attachment; filename="	 
						+ new String(tcprojectAttachment.getPaname().getBytes("gb2312"), "ISO8859-1" ));
				String fullpath = rootpath +File.separator+tcprojectAttachment.getPapath();
				File file=new File(fullpath);
				is=new FileInputStream(file); 
				os=response.getOutputStream();
				 byte[] b=new byte[1024];
				 int length;
				 while((length=is.read(b))>0){
					 os.write(b,0,length);
				}		 
				 os.flush();
				 os.close();
				 is.close();
				
			}catch (Exception e) { 
				e.printStackTrace();
			} finally {
				try {
					if (is != null)
					is.close();
					if (os != null)  
					os.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}  
			}  
		
	}
	
	@RequestMapping({"afterFileProcess"})
	@Action(description="附件处理")
	public void afterFileProcess(HttpServletRequest request,HttpServletResponse response){
			String fileId = RequestUtil.getString(request, "fileId");
			String jsonString = RequestUtil.getString(request, "jsonString");
			String afterId = RequestUtil.getString(request, "afterId");
			String type = RequestUtil.getString(request, "type");
			TcprojectAfter tcprojectAfter=null;
			JSONArray jsonArray = null;
			String retString = "";

			String projectPath=request.getSession().getServletContext().getRealPath("/");
			try{
				if(type!=null && type.equals("1")){//添加时删除附件
					if(jsonString!=null && !jsonString.equals("") && !jsonString.equals("[]")){
						jsonArray = JSONArray.fromObject(jsonString);
						for(int i=0;i<jsonArray.size();i++){
							if(jsonArray.getJSONObject(i).getString("fileId").equals(fileId)){
								jsonArray.remove(i);
							}
						}
						retString=jsonArray.toString();
					}
					
				}
				else if(type!=null && type.equals("2")){//编辑时删除附件
					tcprojectAfter=tcprojectAfterService.getById(Long.valueOf(afterId));
					jsonArray = JSONArray.fromObject(tcprojectAfter.getFileId());
					TcprojectAttachment tcprojectAttachment = tcprojectAttachmentService.getById(Long.valueOf(fileId));
					for(int i=0;i<jsonArray.size();i++){
						if(jsonArray.getJSONObject(i).getString("fileId").equals(fileId)){
							jsonArray.remove(i);
						}
					}
					retString=jsonArray.toString();
					tcprojectAfter.setFileId(retString);
					tcprojectAfterService.update(tcprojectAfter);
					tcprojectAttachmentService.delById(Long.valueOf(fileId));
					new File((projectPath+"/"+tcprojectAttachment.getPapath()).replace("/", File.separator)).delete();
					
				}else if(type!=null && type.equals("3")){//编辑时添加附件
					tcprojectAfter=tcprojectAfterService.getById(Long.valueOf(afterId));
					jsonArray = JSONArray.fromObject(tcprojectAfter.getFileId());
					JSONArray jsonArray2 = JSONArray.fromObject(jsonString);
					jsonArray.addAll(jsonArray2);
					//for(int i=0;i<jsonArray2.size();i++){
					//}
					retString=jsonArray.toString();
					tcprojectAfter.setFileId(retString);
					tcprojectAfterService.update(tcprojectAfter);

				}
				
			}catch (Exception e) { 
				e.printStackTrace();
			}
			try{
				if((type!=null) && (type.equals("2") || type.equals("3"))){
					tcprojectAfter=tcprojectAfterService.getById(Long.valueOf(afterId));
					jsonArray = JSONArray.fromObject(tcprojectAfter.getFileId());
				}

				if(jsonArray!=null && jsonArray.size()>0){
					response.getWriter().write(jsonArray.toString());			
				}else{
					response.getWriter().write("");
				}
				
			}catch (Exception e) { 
				e.printStackTrace();
			}
			
	}
	
	

    
    @RequestMapping({"investorAfterDeail"})
    @Action(description="投资者投后管理详情")
    public ModelAndView investorAfterDeail(HttpServletRequest request){
      Long afterId=RequestUtil.getLong( request, "afterId" );
		TcprojectAfter tcprojectAfter=tcprojectAfterService.getById(afterId);
		//List arrayDataList = getArrayDataList(tcprojectAfter.getFileId());
		 return new ModelAndView("/crowdfunding/front/investorAfterManage/AfterInvestorsIframe.jsp")
		.addObject("tcprojectAfter", tcprojectAfter);
    		
   
    }
   
    //根据文件id获得附件数据
    @RequestMapping({"getAttachmentByFileId"})
	  @Action(description="根据文件id取得附件数据", exectype="管理日志", detail="根据文件id取得附件数据")
	  public void getAttachmentByFileId(HttpServletRequest request, HttpServletResponse response)
	    throws IOException
	  {
    	String projectPath = request.getSession().getServletContext().getRealPath("/");
	    long fileId = RequestUtil.getLong(request, "fileId", 0L);
	    TcprojectAttachment t = tcprojectAttachmentService.getById(Long.valueOf(fileId));
	    if(t==null)return;
	    String filePath = t.getPapath();
	    String fullPath = StringUtil.trimSufffix(this.attachPath, File.separator) + File.separator + filePath.replace("/", File.separator);
	    try{
	    	fullPath = projectPath+ File.separator+filePath.replace("/", File.separator);
	    byte[] bytes = FileUtil.readByte(fullPath);
	    if(bytes!=null)
	    	response.getOutputStream().write(bytes);
	    }catch(FileNotFoundException fe){
	    	logger.error( "文件路径不存在:"+fullPath );
	    }
	  }
    
    
}
