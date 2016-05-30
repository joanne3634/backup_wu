package com.deelon.crowdfunding.controller.backstage;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.model.backstage.Tcproject;
import com.deelon.crowdfunding.model.backstage.TcprojectContract;
import com.deelon.crowdfunding.model.backstage.TcprojectInvest;
import com.deelon.crowdfunding.service.backstage.TcprojectContractService;
import com.deelon.crowdfunding.service.backstage.TcprojectInvestService;
import com.deelon.crowdfunding.service.backstage.TcprojectService;
import com.deelon.loan.model.front.TUserContact;
import com.deelon.loan.model.sysManager.Tsmsinformation;
import com.deelon.loan.service.front.TuserContactService;
import com.deelon.loan.service.sysManager.TsmsinformationService;
import com.deelon.platform.model.system.SysUser;

/**
 * 对满标的项目发起合同签订
 * @author pyg
 *
 */
@Controller
@RequestMapping( { "/crowdfunding/backstage/startProContract/" } )
public class StartProContractController extends BaseController {
	@Resource
	private TcprojectService tcprojectService;
	@Resource
	private TsmsinformationService tsmsinformationService;
	@Resource
	private TcprojectInvestService tcprojectInvestService;
	@Resource
	private TuserContactService tuserContactService;
	@Resource
	private TcprojectContractService tcprojectContractService;
	
	@RequestMapping( { "list" } )
	@Action( description = "查看满标分页列表" )
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response ) throws Exception{ 
		QueryFilter queryFilter=new QueryFilter(request, "projectId");
		List<Tcproject> list = tcprojectService.getAllFullTender(queryFilter);
		
		ModelAndView mv = getAutoView().addObject("tprojectList", list );
		return mv;
	}
	@ RequestMapping( { "edit" } )
	@ Action( description = "编辑TcprojectContract数据" )
	public ModelAndView edit( HttpServletRequest request ) throws Exception
	{
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "contractId" ) );
		TcprojectContract tcprojectContract = null;
		if ( pkId.longValue() != 0L )
			tcprojectContract = (TcprojectContract) this.tcprojectContractService.getById( pkId );
		else
		{
			tcprojectContract = new TcprojectContract();
			tcprojectContract.setProjectId(RequestUtil.getLong( request, "projectId" ));
		}
		return getAutoView().addObject( "tcprojectContract", tcprojectContract ).addObject( "contractId", pkId );
	}
	@RequestMapping({"updates"})
	 @Action(description="合同签订")
	  public void save(TcprojectContract tcprojectContract, HttpServletRequest request, HttpServletResponse response){
		 SysUser su=ContextUtil.getCurrentUser();
		 String preUrl = RequestUtil.getPrePage( request );	
		 try {
			 	tcprojectContract.setCreator(su.getUserId());
			 	tcprojectContract.setCreateTime(new Date());
			 	//保存合同签订信息
				 if (tcprojectContract.getContractId() == null){
			    	 tcprojectContract.setContractId(Long.valueOf(UniqueIdUtil.genId()));
			         this.tcprojectContractService.add(tcprojectContract);
			     }else{
			    	 this.tcprojectContractService.update(tcprojectContract);
			     }
				 
				    //更新项目状态
			    	Tcproject t=tcprojectService.getById(tcprojectContract.getProjectId());
			    	t.setPstateId(5+"");//众筹付款中
			    	tcprojectService.update(t);
			    	
			    	//调用放款计划借款,生成放款计划
			    	tcprojectService.createInvestPaymentPlan(t);
			    	//如果放款计划调用成功
			    	
			    	//调用短信模板
			    	
			    	//1发短信 (是发给领投人和创业者,还是所有跟投人,再确定下)
			    	//a.找出项目的相关投资人,发短信给他们
			    	
			    	//发短信
			    	
			    	//b.现将信息保存
			    	Map<String,Object> map=new HashMap<String,Object>();
		    		map.put("projectId", tcprojectContract.getProjectId());
				//	invest.put("userId", userId);
		    		map.put("piisPay",0);
		    		map.put("isCancel", 0);
			    	List<TcprojectInvest> list =tcprojectInvestService.getInvestforPro(map, null);
			    	if(list!=null&&list.size()>0){
			    		for (TcprojectInvest ti : list) {
			    			//如果只发给领投人和创业者
//							if(ti.getPiisLeader()==1){//如果发给所有跟投人 则取得此句
//								TUserContact tc=tuserContactService.queryTUserContactByuserId(ti.getUserId().toString());
//								Tsmsinformation info=new Tsmsinformation();
//								info.setServiceType(1);
//								info.setMessasge("");//短信内容,短信内容要从短信模板中取
//								info.setMobileNum(tc.getCMobile());//电话号码
//								info.setCreator(su.getUserId());
//								info.setCreateTime(new Date());
//								info.setStatus(1);//未发送
//								tsmsinformationService.add(info);
//							}
							
						}
			    	}
			    	
			     //response.sendRedirect(preUrl);
			    response.sendRedirect("list.ht");
		} catch (Exception e) {
			   e.printStackTrace();
		}
		 
	  }
}
