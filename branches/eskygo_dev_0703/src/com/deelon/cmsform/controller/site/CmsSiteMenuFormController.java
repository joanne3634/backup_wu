/*
 * Powered By [Allen]
 * Since 2013 - 2013
 */


package com.deelon.cmsform.controller.site;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.deelon.cmsform.model.site.CmsSiteMenu;
import com.deelon.cmsform.service.site.CmsSiteMenuService;
import com.deelon.core.annotion.Action;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.core.web.query.QueryFilter;

@ Controller
@ RequestMapping( { "/cmsform/site/cmssitemenu/" } )
public class CmsSiteMenuFormController extends BaseFormController{
	
	   @Resource
	   private CmsSiteMenuService cmsSiteMenuService;

	   @RequestMapping({"save"})
	   @Action(description="添加或更新CmsSiteMenu")
	   public void save(HttpServletRequest request, HttpServletResponse response, CmsSiteMenu cmsSiteMenu, BindingResult bindResult) throws Exception
	   {
		   ResultMessage resultMessage = validForm("cmsSiteMenu", cmsSiteMenu, bindResult, request);		   
		     if (resultMessage.getResult() == 0) {
		       writeResultMessage(response.getWriter(), resultMessage);
		       return;
		     }
		
		     String resultMsg = null;
		     
		     
		 	CmsSiteMenu cm = cmsSiteMenuService.checkIsExist(cmsSiteMenu.getMenuName());
		 	if(cm!=null&&!cm.getSiteMenuId().equals(cmsSiteMenu.getSiteMenuId())){
		 		 resultMsg = getText("栏目名称已经存在！");
	              writeResultMessage(response.getWriter(), resultMsg, 0);
	              return;
		 	}
		    
		    	 QueryFilter qf=new QueryFilter(); 
		    	 if(null!=cmsSiteMenu.getMenuPath()&&!"".equals(cmsSiteMenu.getMenuPath())){
		    		 qf.addFilter( "menuPath", cmsSiteMenu.getMenuPath() );
		    	 } 
		         List listCode=cmsSiteMenuService.getAll( qf );
		         if(listCode!=null&&listCode.size()>0){
		        	  if (cmsSiteMenu.getSiteMenuId() == null){
		        		  resultMsg = getText("栏目代码已经存在！");
			              writeResultMessage(response.getWriter(), resultMsg, 0);
			              return;
		        	  }else{
		        		  for(int i=0;i<listCode.size();i++){
		        			  CmsSiteMenu csm=(CmsSiteMenu)listCode.get( i );
		        			  if(csm.getMenuPath().equals( cmsSiteMenu.getMenuPath()  )){
		        				  if(!csm.getSiteMenuId().equals( cmsSiteMenu.getSiteMenuId() )){
		        					  resultMsg = getText("栏目代码已经存在！");
		    			              writeResultMessage(response.getWriter(), resultMsg, 0);
		    			              return;
			        			  }
		        			  }
		        			  
		        			 
		        		  }
		        	  }
		        	
		         }
		     if (cmsSiteMenu.getSiteMenuId() == null){
		    	 cmsSiteMenu.setSiteMenuId(Long.valueOf(UniqueIdUtil.genId()));
		         this.cmsSiteMenuService.add(cmsSiteMenu);
		         resultMsg = getText("record.added", new Object[] { "数据" });
		         writeResultMessage(response.getWriter(), resultMsg, 1);
		     }else{
		       this.cmsSiteMenuService.update(cmsSiteMenu);
		       resultMsg = getText("record.updated", new Object[] { "数据" });
		       writeResultMessage(response.getWriter(), resultMsg, 1);
		     }
	   }
	   
	   @ModelAttribute
	   protected CmsSiteMenu getFormObject(@RequestParam("siteMenuId") Long siteMenuId, Model model)  throws Exception
	   {
	     this.logger.debug("enter CmsSiteMenu getFormObject here....");
	     CmsSiteMenu cmsSiteMenu = null;
	     if (siteMenuId != null)
	    	 cmsSiteMenu = (CmsSiteMenu)this.cmsSiteMenuService.getById(siteMenuId);
	     else {
	    	 cmsSiteMenu = new CmsSiteMenu();
	     }
	     return cmsSiteMenu;
	   }
}

