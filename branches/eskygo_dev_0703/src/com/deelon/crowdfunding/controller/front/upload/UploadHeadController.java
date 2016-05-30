package com.deelon.crowdfunding.controller.front.upload;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.FileUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.common.util.TUserUtil;
import com.deelon.crowdfunding.service.backstage.TcprojectService;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.service.aboutus.TUserMsgRemindService;
import com.deelon.loan.service.front.TUserService;
import com.deelon.platform.service.system.SysFileService;
import com.deelon.platform.service.util.ServiceUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.Calendar;

/**
 * 
 * hqx
 */
@Controller
@RequestMapping({ "/crowdfunding/upload/" })
public class UploadHeadController extends BaseController {

	@Autowired
	private TUserService tUserService;
	@Autowired
	private TcprojectService tcprojectService;
	@Autowired
	private TUserMsgRemindService tUserMsgRemindService;
	@Resource
	private SysFileService sysFileService;

	private String identifying = "";
	
	public String getIdentifying() {
		return identifying;
	}

	public void setIdentifying(String identifying) {
		this.identifying = identifying;
	}
	
	
	
	@RequestMapping({ "uploadHeadPage" })
	public ModelAndView uploadHeadPage(HttpServletRequest request,HttpServletResponse response) {
		TUser u = TUserUtil.getLogUser(request);
		u = tUserService.getById(u.getUserId());
		
		return new ModelAndView("/crowdfunding/front/uploadHead/uploadHead.jsp").addObject("user",u);
		
	}
	
	  @RequestMapping({"getFileById"})
	  @Action(description="根据文件id取得附件数据", exectype="管理日志", detail="根据文件id取得附件数据")
	  public void getFileById(HttpServletRequest request, HttpServletResponse response)
	    throws IOException
	  {
	    String path = RequestUtil.getString(request, "path");
	    String type = RequestUtil.getString(request, "type");
	   // if (fileId == null) {
	    //  return;
	   // }
	    //SysFile sysFile = (SysFile)this.sysFileService.getById(Long.valueOf(fileId));    
	    //TUserAuditMatUpload t = tuserAuditMatUploadService.getById(Long.valueOf(fileId));
	    if(path==null)return;
	    String filePath = path;
	    String fullPath = StringUtil.trimSufffix(ServiceUtil.getBasePath().replace("/", "\\"), File.separator) + File.separator + filePath.replace("/", File.separator);
	    if ("small".equals(type))
	    {
	      String filePrex = fullPath.substring(0, fullPath.lastIndexOf("."));
	      fullPath = filePrex + "_small" + fullPath.substring(filePrex.length());
	    }
	    try{
	    byte[] bytes = FileUtil.readByte(fullPath);
	    if(bytes!=null)
	    	response.getOutputStream().write(bytes);
	    }catch(FileNotFoundException fe){
	    	logger.error( "文件路径不存在:"+fullPath );
	    }
	  }
	
	@RequestMapping({ "saveSheXiangTou" })
	public void saveSheXiangTou(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
//		System.out.println("进来了");
		String radom = request.getParameter("radom");//页面传过来的参数
		TUser user = TUserUtil.getLogUser(request);
		
		if(user == null){
			return;
		}
		
		if("2".equals(radom)){
			if(!"".equals(identifying)){
				identifying = "";
				//此处必需返回这种格式,要不然不会第二次调用
				//{"data":{"urls":["1243251304_big.jpg"]},"status":1,"statusText":"保存存成功!"}
				String s= "{\"data\":{\"urls\":[\"\"]},\"status\":1,\"statusText\":\"保存存成功\"}";
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				out.println(s);
				out.flush();
				out.close();
				return;
			}
		}else{
			//此处必需返回这种格式,要不然不会第二次调用
			//{"data":{"urls":["1243251304_big.jpg"]},"status":1,"statusText":"保存存成功!"}
			String s= "{\"data\":{\"urls\":[\"\"]},\"status\":1,\"statusText\":\"保存存成功\"}";
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.println(s);
			out.flush();
			out.close();
			return;
		}
		identifying = "identifying";
		
		//这个方法是swf提交，如果是拍照的，有三次提交，如果是修改图片的，则有两次提交。
		Long fileId = Long.valueOf(UniqueIdUtil.genId());
		String fileName = fileId + ".jpg";
		String filePath = createFilePath(ServiceUtil.getBasePath().replace("/", "\\") + File.separator + user.getUserId() + File.separator, fileName);
		
		this.logger.info("上传的文件路径：" + filePath);
		
		try {
			File file=new File(filePath);
			System.out.println(file.getPath());
			if(!file.exists()){
				file.createNewFile();
			}
			FileOutputStream dos=new FileOutputStream(file);  
			int x=request.getInputStream().read();
			while (x>-1) {			
				dos.write(x);
				x=request.getInputStream().read();
			}
			
			user = tUserService.getById(user.getUserId());
			user.setMyPhoto(createFilePath(user.getUserId() + File.separator, fileName));
			tUserService.update(user);
			
			//SysFile sysFile = new SysFile();
			//sysFile.setFileId(fileId);
			//sysFile.setFileName(fileId + "");
			//sysFile.setTypeId((long)6);
			//sysFile.setFilePath(filePath.replace(configproperties.getProperty("file.upload") + "\\", ""));
			//sysFile.setCreatetime(new Date());
			//sysFile.setExt("jpg");
			//sysFile.setFileType("-");
			//sysFile.setNote(FileUtil.getFileSize(new File(filePath)));
			//sysFile.setCreatorId(user.getUserId());
			//sysFile.setCreator(user.getLoginName());
			//sysFile.setTotalBytes(Long.valueOf(x));
			//sysFile.setDelFlag(SysFile.FILE_NOT_DEL);
			//TUserUtil.saveSysFile(sysFile);
			
			dos.flush();
			dos.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		//此处必需返回这种格式,要不然不会第二次调用
		//{"data":{"urls":["1243251304_big.jpg"]},"status":1,"statusText":"保存存成功!"}
		String s= "{\"data\":{\"urls\":[\""+fileName+"\"]},\"status\":1,\"statusText\":\"保存存成功\"}";
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println(s);
		out.flush();
		out.close();

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
	
	
	
}
