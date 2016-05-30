package com.deelon.loan.controller.sysManager;



import com.deelon.core.annotion.Action;
import com.deelon.core.util.FileUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TUserAuditMat;
import com.deelon.loan.model.front.TUserAuditMatUpload;
import com.deelon.loan.service.front.TUserAuditMatService;
import com.deelon.loan.service.front.TUserAuditMatUploadService;
import com.deelon.platform.model.system.Demension;
import com.deelon.platform.model.system.SysFile;
import com.deelon.platform.model.system.SysUser;
import com.deelon.platform.service.system.DemensionService;
import com.deelon.platform.service.system.SysUserService;
import com.deelon.platform.service.util.ServiceUtil;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@ Controller
@ RequestMapping( { "/loan/sysManager/tuserauditmat/" } )
public class TuserAuditmatController extends BaseController{
	
	@ Resource
	private TUserAuditMatService tuserAuditmatService;
	
	@ Resource
	private TUserAuditMatUploadService tuserAuditMatUploadService;
	
	@ Resource
	private SysUserService sysUserService;
	
    private String attachPath = ServiceUtil.getBasePath().replace("/", "\\");

	@ RequestMapping( { "list" } )
	@ Action( description = "查看TuserAuditmat分页列表" )
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{ 
		QueryFilter quertyFilter = new QueryFilter(request, "tuserAuditmatItem");
		quertyFilter.addFilter("groupId", 2);  //显示的是投资人
		List list = this.tuserAuditmatService.getAll(quertyFilter);
		
		List<SysUser> listjuese = sysUserService.getAll();   //获取全部后台角色
		ModelAndView mv = getAutoView().addObject( "tuserAuditmatList", list ).addObject("listjuese", listjuese);
		return mv;
	}

	@ RequestMapping( { "del" } )
	@ Action( description = "删除TuserAuditmat数据")
	public void del( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request );
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "auditMatId" );
			this.tuserAuditmatService.delByIds( lAryId );
			message = new ResultMessage( 1, "删除数据成功" );
		}
		catch ( Exception e )
		{
			message = new ResultMessage( 0, "删除数据失败" );
		}
		addMessage( message, request );
		response.sendRedirect( preUrl );
	}

	@ RequestMapping( { "edit" } )
	@ Action( description = "编辑TuserAuditmat数据")
	public ModelAndView edit( HttpServletRequest request ) throws Exception
	{
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "auditMatId" ) );
		TUserAuditMat tuserAuditmat = null;
		if ( pkId.longValue() != 0L ){
			Long userId = Long.valueOf( RequestUtil.getLong( request, "userId" ) );
			List<TUserAuditMatUpload> tauList = tuserAuditMatUploadService.getUserAuditMatUploadByUserAndauditMatId(userId, pkId);
			tuserAuditmat = (TUserAuditMat) this.tuserAuditmatService.getById( pkId );
			request.setAttribute("tuserAuditMatUpload", tauList);
			
		}else
		{
			tuserAuditmat = new TUserAuditMat();
		}
		return getAutoView().addObject( "tuserAuditmat", tuserAuditmat ).addObject( "auditMatId", pkId );
	}

	@ RequestMapping( { "get" } )
	@ Action( description = "查看TuserAuditmat数据")
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "auditMatId" );
		TUserAuditMat tuserAuditmat = (TUserAuditMat) this.tuserAuditmatService.getById( Long.valueOf( pkId ) );
		return getAutoView().addObject( "tuserAuditmat", tuserAuditmat );
	}
	
	@ RequestMapping( { "getTUploadImages" } )
	@ Action( description = "查看TuserAuditmatUpload的资料图片")
	public ModelAndView getTUploadImages( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "auditMatId" );
		Long userId = Long.valueOf( RequestUtil.getLong( request, "userId" ) );
		List<TUserAuditMatUpload> tauList = tuserAuditMatUploadService.getUserAuditMatUploadByUserAndauditMatId(userId, pkId);
		return new ModelAndView("/loan/sysManager/tuserauditmatUploadImages.jsp").addObject( "tuserAuditMatUpload", tauList );
	}
	
	
	  @RequestMapping({"getFileById"})
	  @Action(description="根据文件id取得附件数据", exectype="管理日志", detail="根据文件id取得附件数据")
	  public void getFileById(HttpServletRequest request, HttpServletResponse response)
	    throws IOException
	  {
	    long fileId = RequestUtil.getLong(request, "fileId", 0L);
	    String type = RequestUtil.getString(request, "type");
	   // if (fileId == null) {
	    //  return;
	   // }
	    //SysFile sysFile = (SysFile)this.sysFileService.getById(Long.valueOf(fileId));    
	    TUserAuditMatUpload t = tuserAuditMatUploadService.getById(Long.valueOf(fileId));
	    if(t==null)return;
	    String filePath = t.getSavePath();
	    String fullPath = StringUtil.trimSufffix(this.attachPath, File.separator) + File.separator + filePath.replace("/", File.separator);
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
	
	
	
	
	
}

