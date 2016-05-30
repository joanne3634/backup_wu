package com.deelon.loan.controller.front;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.encrypt.EncryptUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TriskCompany;
import com.deelon.loan.service.front.TriskCompanyService;

@Controller
@RequestMapping({ "/loan/front/riskCompany/" })
public class TRiskCompanyController extends BaseController {
	
	@Resource
	private TriskCompanyService TriskCompanyService; 
	
	 @RequestMapping({"list"})
	 @ Action( description = "查看TriskCompany分页列表")
	  public ModelAndView list(HttpServletRequest request, HttpServletResponse response) {
		 
		 try {
			 //begin 获得查询条件
			 String name = request.getParameter("name");
			 String address = request.getParameter("address");
			 String contact = request.getParameter("contact");
			 //end
			 QueryFilter queryFilter=new QueryFilter(request,"riskCompanyItem");//分页
			 queryFilter.addFilter("name", name);
			 queryFilter.addFilter("address", address);
			 queryFilter.addFilter("contact", contact);
			 List<TriskCompany> list = TriskCompanyService.getAll(queryFilter);//查询分页列表数据
			 return new ModelAndView("/loan/front/TRiskCompanyList.jsp").addObject("riskCompanyList", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		 return null;
	  }
	 
	@ RequestMapping( { "del" } )
	@ Action( description = "删除TriskCompany数据" )
	public void del( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request );		//获取跳转路径
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "companyId" );//接受页面返回的Id
			this.TriskCompanyService.delByIds( lAryId );		//通过Id删除对应数据
			message = new ResultMessage( 1, "删除数据成功" );		//返回页面的提示信息
		}
		catch ( Exception e )
		{
			message = new ResultMessage( 0, "删除数据失败" );
		}
		addMessage( message, request );
		response.sendRedirect( preUrl );				//跳转获取的路径
	}

	@ RequestMapping( { "edit" } )
	@ Action( description = "编辑TriskCompany数据")
	public ModelAndView edit( HttpServletRequest request ) throws Exception
	{
		EncryptUtil encryptUtil = new EncryptUtil();
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "companyId" ) );//接受页面返回的Id
		TriskCompany triskCompany = new TriskCompany();
		if ( pkId.longValue() != 0L){
			triskCompany = TriskCompanyService.getById( pkId );				//通过Id查询相应数据
			String psd = encryptUtil.decrypt(triskCompany.getRcPaypwd());	//解密
			triskCompany.setRcPaypwd(psd);									//存入对象
		}else{
			triskCompany = new TriskCompany();
		}
		return new ModelAndView("/loan/front/TRiskCompanyEdit.jsp").addObject( "triskCompany", triskCompany ).addObject( "companyId", pkId );
	}

	@ RequestMapping( { "get" } )
	@ Action( description = "查看TriskCompany数据")
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "companyId" );
		TriskCompany triskCompany = (TriskCompany) this.TriskCompanyService.getById( Long.valueOf( pkId ) );
		return getAutoView().addObject( "triskCompany", triskCompany );
	}

}
