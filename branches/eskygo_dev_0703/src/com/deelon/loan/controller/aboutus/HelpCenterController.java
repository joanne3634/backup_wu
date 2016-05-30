package com.deelon.loan.controller.aboutus;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.cmsform.model.site.CmsSiteMenu;
import com.deelon.cmsform.model.site.CmsSiteMenuContent;
import com.deelon.cmsform.service.site.CmsSiteMenuContentService;
import com.deelon.cmsform.service.site.CmsSiteMenuService;
import com.deelon.core.annotion.Action;
import com.deelon.core.page.PageBean;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.platform.model.system.SysFile;

/**
 * @author Administrator
 * @version 帮助中心
 * 
 */
@Controller
@RequestMapping({ "/loan/aboutus/" })
public class HelpCenterController extends BaseController {

	@Resource
	private CmsSiteMenuService cmsSiteMenuService;

	@Resource
	private CmsSiteMenuContentService cmsSiteMenuContentService;

	@RequestMapping({ "HelpCenterList" })
	@Action( description = " 帮助中心框架页" )
	public ModelAndView AboutUs(HttpServletRequest request,
			HttpServletResponse response) {
		//falg不为空，表示帮助中心请求的连接
		String flag = request.getParameter("flag")+"";
		if(StringUtils.isNotEmpty(flag) && !"null".equals(flag)){
			request.getSession().setAttribute("tmenuPath", null);
			request.getSession().setAttribute("contentTitle", null);
		}
		String srcurl = request.getParameter("srcurl");
		List<CmsSiteMenu> list = cmsSiteMenuService.getMenuPath("BZZX");//查询帮助中心菜单
		return new ModelAndView("/loan/aboutus/HelpCenterList.jsp").addObject(
				"list", list).addObject("srcurl", srcurl); 
	}

	@RequestMapping({ "toHelpCenter" })
	@Action( description = " 帮助中心菜单列表" )
	public ModelAndView toHelpCenter(HttpServletRequest request,
			HttpServletResponse response) {
		List<CmsSiteMenu> list = cmsSiteMenuService.getMenuPath("BZZX");//查询帮助中心菜单
		return new ModelAndView("/loan/aboutus/HelpCenterleft.jsp").addObject(
				"list", list);
	}

	@RequestMapping({ "HelpCenterDetails" })
	@Action( description = " 帮助中心详情" )
	public ModelAndView HelpCenterDetails(HttpServletRequest request,
			HttpServletResponse response,String contentTitle,String menupath) {
		int page = RequestUtil.getInt(request, "current_page", 1);//默认存入页码
		int pageSize = RequestUtil.getInt(request, "pageSize",15);//存入每页显示的条数
		PageBean pb=new  PageBean(page, pageSize); 
		request.setAttribute( "page_bean", pb);
		List<CmsSiteMenuContent> list = null;
		String content = "";
		try {
			content = StringUtil.isEmpty(contentTitle)?"":java.net.URLDecoder.decode(contentTitle , "UTF-8");
		} catch (UnsupportedEncodingException e) {
			logger.error("获取帮助中心信息失败", e);
		}
		list = this.findHelpCenterDetails(request, response, content ,menupath);
		return new ModelAndView("/loan/aboutus/HelpCenterDetails.jsp")
				.addObject("Details", list)
				.addObject("menu_path",menupath)
				.addObject( "page_bean", pb );
	}
	public List<CmsSiteMenuContent> findHelpCenterDetails(HttpServletRequest request,
			HttpServletResponse response,String contentTitle,String tmenuPath){
		QueryFilter filter = new QueryFilter();
		filter.setPageBean((PageBean)request.getAttribute("page_bean"));
		filter.addFilter("menu_path", tmenuPath);
		filter.addFilter("contentTitle", contentTitle==null || "null".equals(contentTitle)?"":contentTitle);
		List<CmsSiteMenuContent> list = cmsSiteMenuContentService.getMenu_Id(filter);//根据ID查询帮助中心详情
		return list;
	}
	@RequestMapping({ "ZYXZDetails" })
	@Action( description = " 帮助中心详情" )
	public ModelAndView ZYXZDetails(HttpServletRequest request,
			HttpServletResponse response) {
//		String menupath = request.getParameter("menupath");
//		System.out.println("------>"+menupath);
		List<CmsSiteMenuContent> list = cmsSiteMenuContentService
				.getMenuId("ZYXZ");//根据ID查询帮助中心详情
		SysFile sf = null;
		List<SysFile> resourceDownloadList = new ArrayList<SysFile>();
		for(CmsSiteMenuContent cm:list){
			List<String[]> arrayDataList = getArrayDataList(cm.getContentFileIds());
			for(int i=0;i<arrayDataList.size();i++){
				sf = new SysFile();
				sf.setFilesIds(arrayDataList.get(i)[0]);
				sf.setFileNames(arrayDataList.get(i)[1]+"("+cm.getContentTitle()+")");
				resourceDownloadList.add(sf);
			}
			
		}
		/* CmsSiteMenuContent cms=null; */
		/* cms.getContentTitle() */
		
		return new ModelAndView("/crowdfunding/front/DownloadResources.jsp")
				.addObject("resourceDownloadList", resourceDownloadList);
	}

	@RequestMapping({ "HelpCenterQuery" })
	@Action( description = " 帮助中心搜索" )
	public ModelAndView HelpCenterQuery(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String contenttitle = request.getParameter("Queryconditions");//接受查询信息
		String contenttitle1 =new String(contenttitle.getBytes("ISO-8859-1"),"UTF-8"); //对接收信息进行转码
		String submenupath = request.getParameter("menupath");
		List<String> menupath=this.getAllMenuPath();
		List<CmsSiteMenuContent> list = null;
		List<CmsSiteMenu> cmslist = null;
		if(StringUtils.isNotEmpty(submenupath) && !"null".equals(submenupath)){
			list = findHelpCenterDetails(request, response,contenttitle1,submenupath);
		}else{
			list = getCmsSiteMenuContent(menupath, contenttitle1);
			if(null == list ||(list != null && list.size() == 0)){
				return new ModelAndView("redirect:/loan/aboutus/toHelpCenter.ht");
			}
		}
		return new ModelAndView("/loan/aboutus/HelpCenterDetails.jsp").addObject("Details", list!=null && list.size() > 0?list:cmslist);
	}
/*
 *    根据栏目id和查询条件查询帮助中心下相应的信息
 *    List<String> menupath 帮助中心下所有菜单的栏目代码
 *    contenttitle  查询条件
 */
	public List<CmsSiteMenuContent> getCmsSiteMenuContent(
			List<String> menupath, String contenttitle) {
		List<CmsSiteMenuContent> cmsSiteMenuContent = new ArrayList<CmsSiteMenuContent>();//储存所有符合条件的内容
		for (String s : menupath) { 
			//根据条件循环查询帮助中心
			List<CmsSiteMenuContent> list = cmsSiteMenuContentService
					.getContentTitle(s, contenttitle);
			for (CmsSiteMenuContent cmsSiteMenuContents : list) { 
				cmsSiteMenuContent.add(cmsSiteMenuContents);//存入所有符合条件的内容
			}
		}
		return cmsSiteMenuContent;
	}
 /*
  * 查询帮助中心下所有菜单，返回所有菜单的栏目代码
  */
	public List<String> getAllMenuPath() {
		List<CmsSiteMenu> list = cmsSiteMenuService.getMenuPath("BZZX");
		List<String> menuPath = new ArrayList<String>();//所有一级菜单的栏目代码
		List<String> menuPaths = new ArrayList<String>();//所有二级菜单的栏目代码
		//将查询出的一级菜单的栏目代码存入menuPath
		for (int i = 0; i < list.size(); i++) {
			CmsSiteMenu cmsSiteMenu = list.get(i);
			menuPath.add(cmsSiteMenu.getMenuPath());
		}
		for (String Strpath : menuPath) {
			List<CmsSiteMenu> cmssitemenu = cmsSiteMenuService
					.getMenuPath(Strpath);//根据一级菜单的栏目代码查询出二级菜单的栏目代码
			//将查询出的二级菜单的栏目代码存入menuPaths
			for (int i = 0; i < cmssitemenu.size(); i++) {
				CmsSiteMenu cmsSiteMenu = cmssitemenu.get(i);
				menuPaths.add(cmsSiteMenu.getMenuPath());
			}
		}
		return menuPaths;
	}
	
	public List<String[]> getArrayDataList(String jsonString){
		List<String[]> dataList = null;
		if(jsonString!=null && !jsonString.equals("")){
			JSONObject jsonObj = JSONObject.fromObject(jsonString);
			JSONArray jsonArray = jsonObj.getJSONArray("attachs");
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
}
