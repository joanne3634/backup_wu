/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.controller.sysManager;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.annotion.ActionExecOrder;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.sysManager.TprojectAuction;
import com.deelon.loan.model.sysManager.TprojectTransfer;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.sysManager.TprojectAuctionService;
import com.deelon.loan.service.sysManager.TprojectTransferService;
import com.deelon.platform.model.system.SysAuditModelType;

@ Controller
@ RequestMapping( { "/loan/sysManager/tprojecttransfer/" } )
@Action(ownermodel=SysAuditModelType.TPROJECTTRANSFER)
public class TprojectTransferController extends BaseController{
	Logger log = Logger.getLogger(getClass());
	@ Resource
	private TprojectTransferService tprojectTransferService;
	@ Resource
	private TprojectAuctionService tprojectAuctionService;
	@Autowired
	private TUserService tUserService;
	/**
	 * 
	 * @param request
	 * @param response
	 * @param type 1：申请转让 2：转让中（竞拍中） 3：转让成功 4：转让失败（流标）
	 * @return
	 * @throws Exception
	 */
	@ RequestMapping( { "list" } )
	@ Action( description = "查看TprojectTransfer分页列表")
	public ModelAndView list( HttpServletRequest request, HttpServletResponse response,String type) throws Exception
	{ 
		QueryFilter queryFilter = new QueryFilter(request, "tprojectTransferItem");
		if(StringUtil.isEmpty(type)){
			type = "1";
			queryFilter.addFilter("isCancel", "0");
			queryFilter.addFilter("stateId", "1");
			queryFilter.addFilter("isCheck", "0");
			request.setAttribute("isCancel", "0");
			request.setAttribute("stateId", "1");
			request.setAttribute("isCheck", "0");
		}
		request.setAttribute("type", type);
		
		List<TprojectTransfer> list = this.tprojectTransferService.getAll(queryFilter);
		if(type.equals("2")){
			if(list !=null){
				for(TprojectTransfer tprojectTransfer:list){ //获取竞标最高价者，同价者先报者得
					List<TprojectAuction> transferList = tprojectAuctionService.getByTransferId(tprojectTransfer.getTransferId());
					Date closeDate = tprojectTransfer.getCloseDate();
					String remainTime = "--";
					if(closeDate != null){
						Date now = new Date();
						if(closeDate.before(now)){
							remainTime = "已超时";
						}else{
							long time = closeDate.getTime() - now.getTime();
							time = time/1000;
							long days = time/(60*60*24);
							long hour = (time % (60*60*24))/(60*60);
							long min = (time % (60*60))/60;
							remainTime = days+"天"+hour+"小时"+min+"分";
						}
					}
					tprojectTransfer.setRemainTime(remainTime);
					if(transferList!=null){
						Long bidder = null;
						BigDecimal hightestPrice = BigDecimal.valueOf(0);
						Date date = new Date(0);
						for(TprojectAuction auction:transferList){
							if(hightestPrice.compareTo(auction.getOfferPrice()) < 0){
								hightestPrice = auction.getOfferPrice();
								bidder = auction.getUserId();
								date = auction.getOfferTime(); //报价时间
							}else if(hightestPrice.compareTo(auction.getOfferPrice()) == 0){
								if(date.after(auction.getOfferTime())){
									bidder = auction.getUserId();
									date = auction.getOfferTime();
								}
							}
						}
						TUser tuser = tUserService.getById(bidder);
						if(tuser!=null){
							tprojectTransfer.setBidderName(tuser.getRealName());
						}
						tprojectTransfer.setHightestPrice(hightestPrice);
					}
				}
			}
		}
		ModelAndView mv = getAutoView().addObject( "tprojectTransferList", list );
		return mv;
	}

	@ RequestMapping( { "del" } )
	@ Action( description = "删除TprojectTransfer数据")
	public void del( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		ResultMessage message = null;
		String preUrl = RequestUtil.getPrePage( request );
		try
		{
			Long[] lAryId = RequestUtil.getLongAryByStr( request, "transferId" );
			this.tprojectTransferService.delByIds( lAryId );
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
	@ Action( description = "编辑TprojectTransfer数据")
	public ModelAndView edit( HttpServletRequest request ) throws Exception
	{
		Long pkId = Long.valueOf( RequestUtil.getLong( request, "transferId" ) );
		TprojectTransfer tprojectTransfer = null;
		if ( pkId.longValue() != 0L )
			tprojectTransfer = (TprojectTransfer) this.tprojectTransferService.getById( pkId );
		else
		{
			tprojectTransfer = new TprojectTransfer();
		}
		return getAutoView().addObject( "tprojectTransfer", tprojectTransfer ).addObject( "transferId", pkId );
	}

	@ RequestMapping( { "get" } )
	@ Action( description = "查看TprojectTransfer数据")
	public ModelAndView get( HttpServletRequest request, HttpServletResponse response ) throws Exception
	{
		long pkId = RequestUtil.getLong( request, "transferId" );
		TprojectTransfer tprojectTransfer = (TprojectTransfer) this.tprojectTransferService.getById( Long.valueOf( pkId ) );
		return getAutoView().addObject( "tprojectTransfer", tprojectTransfer );
	}
	
	/**
	 * 审核、竞标审核，撤回操作
	 * @param transferId 转让ID
	 * @param type 1：审核转让申请通过 2：审核转让申请不通过 3：审核竞标成功 4：撤回
	 * @return
	 */
	@RequestMapping("doAction")
	@ResponseBody
	@Action(description="审核、竞标审核，撤回操作", execOrder=ActionExecOrder.BEFORE,detail="审核、竞标审核，撤回操作")
	public Object doAction(String transferId,String type){
		ResultMessage resultMessage = new ResultMessage(1, "操作成功！");
		try{
			if(StringUtil.isEmpty(transferId) || StringUtil.isEmpty(type)){
				throw new Exception("参数不正确！");
			}
			String msg = tprojectTransferService.doAction(Long.valueOf(transferId), type);
			resultMessage.setMessage(msg);
		}catch(Exception e){
			log.error(e);
			e.printStackTrace();
			resultMessage.setResult(0);
			Throwable ex = e;
			while(ex.getCause()!=null){
				ex = ex.getCause();
			}
			resultMessage.setMessage(StringUtil.isEmpty(e.getMessage())?"操作失败。":"操作失败,"+ex.getMessage());
		}
		return resultMessage;
	}
	/**
	 * 前台列表
	 * @param request
	 * @return
	 */
	@RequestMapping("listFront")
	@Action(description="前台列表债权转让列表")
	public ModelAndView listFront( HttpServletRequest request, HttpServletResponse response ){
		QueryFilter queryFilter = new QueryFilter(request);
		queryFilter.addFilter("now", new Date());
		
		List<TprojectTransfer> list = tprojectTransferService.getBySqlKeyAll(queryFilter, TprojectTransfer.class, "getAllFront");
		if(list!=null){ //取头像图片
			for(TprojectTransfer tprojectTransfer:list){
				Date closeDate = tprojectTransfer.getCloseDate();
				String remainTime = "--";
				if(closeDate==null){
					tprojectTransfer.setRemainTime(remainTime);
					continue;
				}
				long time = closeDate.getTime() - new Date().getTime();
				time = time/1000;
				long days = time/(60*60*24);
				long hour = (time % (60*60*24))/(60*60);
				long min = (time % (60*60))/60;
				remainTime = days+"天"+hour+"小时"+min+"分";
			}
		}
	
		return new ModelAndView("loan/myAccount/transfer.jsp").addObject("tprojectTransferList", list);
	}
}

