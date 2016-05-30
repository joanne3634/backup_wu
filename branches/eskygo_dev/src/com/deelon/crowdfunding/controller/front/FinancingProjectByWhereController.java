package com.deelon.crowdfunding.controller.front;

import com.deelon.core.annotion.Action;
import com.deelon.core.encrypt.Base64;
import com.deelon.core.page.PageBean;
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.FileUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.servlet.ValidCode;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.common.constants.WuyouchouErrorCode;
import com.deelon.crowdfunding.common.exception.CrowdFundException;
import com.deelon.crowdfunding.common.util.TUserUtil;
import com.deelon.crowdfunding.dao.backstage.TcprojectDao;
import com.deelon.crowdfunding.model.backstage.*;
import com.deelon.crowdfunding.service.backstage.*;
import com.deelon.crowdfunding.service.front.TProjectApplyViewService;
import com.deelon.loan.model.aboutus.TUserMsgRemind;
import com.deelon.loan.model.front.TAttention;
import com.deelon.loan.model.front.TProjectApplyView;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.Tarea;
import com.deelon.loan.service.aboutus.TUserMsgRemindService;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TareaService;
import com.deelon.loan.service.front.TbankcardService;
import com.deelon.loan.service.sysManager.TattentionService;
import com.deelon.loan.util.HtmlRegexpUtil;
import com.deelon.platform.service.util.ServiceUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 创意创新项目列表
 * @author Administrator
 *
 */
@Controller
@RequestMapping({ "/crowdfunding/front/" })
public class FinancingProjectByWhereController extends BaseController {
	
	@Resource
	private TcprojectService tcprojectService;
	@Resource
	private TcprojectTeamService tcprojectTeamService;
	@Resource
	private TcprojectHistoryplanService tcprojectHistoryplanService;//历史/计划
	@Resource
	private TcprojectHpPaymentsService tcprojectHpPaymentsService;//历史/计划 支出
	@Resource
	private TcprojectModelService tcprojectModelService;//商业计划
	@Resource
	private TcprojectAttachmentService tcprojectAttachmentService;//附件
	@Resource
	private TcprojectCommentsService tcprojectCommentsService;//评论
	@Resource
	private TcprojectNewsService tcprojectNewsService;//项目动态
	@Resource
	private TcprojectInvestService tcprojectInvestService;
	@Resource
	private TattentionService tattentionService;
	@Resource
	private TuserApplyLeaderService TuserApplyLeaderService;
	@Resource
	private TUserMsgRemindService tuserMsgRemindService;//发送私信
	@Resource
	private TUserService tuserService;
	@ Resource
	private TareaService tareaService;
	@Autowired
	private TProjectApplyViewService tProjectApplyViewService;
	@Resource
	private TbankcardService tbankcardService;
	@ Resource
	private TcprojectDao tcprojectDao;
	
	private static final String Pstage1Constrant ="1";  //众筹中
	
	private static final String Pstage2Constrant ="2";  //融资成功
	
	private static final String DescType0Constrant = "0"; //项目性质 科技创新
	
	private static final String DescType1Constrant = "1"; //项目性质 实体经营
	
	private static final String DescType2Constrant = "2"; //项目性质 地产投资
	
	private String attachPath = ServiceUtil.getBasePath().replace("/", "\\");
	 
	@RequestMapping({ "tofinancingPro" })
	@Action( description = "进入查询条件页面" )
	public ModelAndView tofinancingPro(HttpServletRequest request,
			HttpServletResponse response) { 
		try {
	//		List<Tcproject> list=tcprojectService.getProOfCitys();
			//推荐项
			QueryFilter query = new QueryFilter();
			query.addFilter("isRecommended", 1);
			query.addFilter("orderField", "order_code");
			query.addFilter("orderSeq", "desc");
			
			request.setAttribute("success", request.getParameter("success"));
			request.setAttribute( "pisRecommended", request.getParameter("pisRecommended") );
			request.setAttribute( "DescList", request.getParameter("DescList") );
			request.setAttribute("needWarm",request.getParameter("needWarm"));
			//List<Tarea> list = tareaService.getAll(query);
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("isRecommended", 1);
			List<Tarea> list = tareaService.getRecommendCitysByMap(map);
			return new ModelAndView("/crowdfunding/front/financingProjectByWhere.jsp").addObject("list", list);
		} catch (Exception e) {
			logger.error("属地查询异常", e);
		}
		return null;
	}
	
	@RequestMapping({ "tofinancingProList" })
	@Action( description = "项目列表" )
	public ModelAndView tofinancingProList(HttpServletRequest request,
			HttpServletResponse response) { 
		//String pindustry=request.getParameter("pindustry");//去掉行业
		String stage = request.getParameter("pstage");//项目阶段:1众筹中2融资成功
		String pcityId = request.getParameter("pcityId");//项目属地
		String descList = request.getParameter("DescList");
		String descType = request.getParameter("DescType");//项目性质
		String orderBy = request.getParameter("orderBy");//顺序
		//新增一个needWarm参数表明是否在预热中
		String pneedWarmUp = request.getParameter("needWarm");//是否是预热阶段0：否；1：是
		
		String pstage = "";
		try {
			Map<String,Object> map = new HashMap<String,Object>();
			//map.put("pindustry",pindustry);
			List<String> array = new ArrayList<String>();

			 if(StringUtil.isNotEmpty(stage)){
				if(Pstage1Constrant.equals(stage)){
					pstage = "(3)";
					map.put("pstage",pstage); 
				} else if(Pstage2Constrant.equals(stage)){
					pstage = "(4,5,6)";
					map.put("pstage", pstage);
				}
			}

			map.put("pneedWarmUp",pneedWarmUp);
			map.put("pcityId",pcityId); 
			map.put("pisRecommended",request.getParameter("pisRecommended")); 
			if(StringUtil.isNotEmpty(descList)){
				if(descList.equals("0")){
					map.put("popenDate",1); 
				}else if(descList.equals("1")){
					map.put("pfinancingAmount",2); 
				}else if(descList.equals("2")){
					map.put("pcomplete",4); 
				}else if(descList.equals("3")){
					map.put("pinvestAmount",3); 
				}else if(descList.equals("4")){
					map.put("pviewCount",1); 
				}
			}
			String pro_type_name="";
			if(StringUtil.isNotEmpty(descType)){
				if( DescType0Constrant.equals(descType) ){//科技创新
					map.put("ptypeId",1); 
					pro_type_name="1";
				}else if(DescType1Constrant.equals(descType)){//实体经营
					map.put("ptypeId",2); 
					pro_type_name="2";
				}else if(DescType2Constrant.equals(descType)){//地产投资
					map.put("ptypeId",3);
					pro_type_name="3";
				}
			}
			if(StringUtil.isNotEmpty(orderBy) && "1".equals(orderBy)){
				map.put("orderBy","asc");
			}else{
				map.put("order", "desc");
			}
			//分页加参数
			int page = RequestUtil.getInt(request, "current_page", 1);
			int pageSize = RequestUtil.getInt(request, "pageSize",5);
			PageBean pb=new  PageBean(page, pageSize);
			List<Tcproject> list=tcprojectService.getAllProByWhere(map,pb);
			if(list!=null&&list.size()>0){
				for (Tcproject c : list) {
					//计算出让股份
					BigDecimal iBigDecimal = c.getPfinancingAmount().divide(c.getPvaluationFinal(), 2, BigDecimal.ROUND_HALF_UP);
					BigDecimal sharePercent = c.getPfinancingAmount().divide(c.getPvaluationFinal(), 2, BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(100));
					c.setPsharesPercent(sharePercent);
					//c.getPpic();
				}
			}
			request.setAttribute( "pisRecommended", request.getParameter("pisRecommended") );
			request.setAttribute( "pstage", stage );
			request.setAttribute( "DescList", descList );
			request.setAttribute( "orderBy", orderBy );
			request.setAttribute( "DescType", descType );
			request.setAttribute( "page_bean", pb );//分页参数传入页面
			request.setAttribute( "pro_type_name",pro_type_name);//
			return new ModelAndView("/crowdfunding/front/financingProList.jsp").addObject("ListVo", list);
		} catch (Exception e) {
			logger.error("list project error:errorCode = "+WuyouchouErrorCode.PRJ_SEARCH_LIST_ERROR.getErrorCode(),e);
			throw new CrowdFundException(WuyouchouErrorCode.PRJ_SEARCH_LIST_ERROR.getErrorCode(),
				WuyouchouErrorCode.PRJ_SEARCH_LIST_ERROR.getErrorMsg(),e);
		}
	}
	
	@RequestMapping({ "financingSuccessProList" })
	@Action( description = "项目列表" )
	public ModelAndView financingSuccessProList(HttpServletRequest request,
			HttpServletResponse response) { 
		
		String descType=request.getParameter("DescType");
		Map<String,Object> map = new HashMap<String,Object>();
		String pro_type_name="";
		if(StringUtil.isNotEmpty(descType)){
			if(descType.equals("3")){//融资成功
//				map.put("phavedPay",3);
				pro_type_name="4";
			}
		}
		//分页加参数
		int page = RequestUtil.getInt(request, "current_page", 1);
		int pageSize = RequestUtil.getInt(request, "pageSize",5);
		PageBean pb=new  PageBean(page, pageSize);
		List<Tcproject> list = null;
		try {
			list = tcprojectService.getAllProByWhere(map,pb);
		} catch (Exception e) {
			logger.error("list project error:errorCode = "+WuyouchouErrorCode.PRJ_SEARCH_LIST_ERROR.getErrorCode(),e);
			throw new CrowdFundException(WuyouchouErrorCode.PRJ_SEARCH_LIST_ERROR.getErrorCode(),
				WuyouchouErrorCode.PRJ_SEARCH_LIST_ERROR.getErrorMsg(),e);
		}
			
		if(list!=null&&list.size()>0){
			for (Tcproject c : list) {
					//根据项目id查询投资的估值最小值
					/*TcprojectInvest tcprojectInvest = tcprojectInvestService.getMinValueByProId(c.getProjectId());
					if(tcprojectInvest!=null){
						if(!tcprojectInvest.getPivaluation().equals("0.000")){
							BigDecimal sharePercent = c.getPfinancingAmount().divide(c.getPvaluationFinal().multiply(new BigDecimal("10000")), 2,RoundingMode.HALF_UP).multiply(new BigDecimal(100));
							c.setPsharesPercent(sharePercent);
						}else{
							c.setPsharesPercent(new BigDecimal(0.00));	
						}
					}*/
				BigDecimal sharePercent = c.getPfinancingAmount().divide(c.getPvaluationFinal(), 2,RoundingMode.HALF_UP).multiply(new BigDecimal(100));
				c.setPsharesPercent(sharePercent);
				c.getPpic();
			}
		}
		request.setAttribute( "page_bean", pb );//分页参数传入页面
		request.setAttribute( "pro_type_name",pro_type_name);//
		request.setAttribute("DescType", descType);
		return new ModelAndView("/crowdfunding/front/financingSuccessProList.jsp").addObject("ListVo", list);
	}
	
	@RequestMapping({ "toProDetails" })
	@Action( description = "项目详情" )
	public ModelAndView toProDetails(HttpServletRequest request,
			HttpServletResponse response) { 
		String projectId=request.getParameter("projectId");
		TUser u=TUserUtil.getLogUser(request);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		try {
			//查询项目 包括 创业者和创业者信息
			Tcproject tcproject=tcprojectService.getTcprojectById(Long.valueOf(projectId));
			if(tcproject!=null){
				BigDecimal sharePercent = tcproject.getPfinancingAmount().divide(tcproject.getPvaluationFinal().multiply(new BigDecimal("10000")), 2,RoundingMode.HALF_UP).multiply(new BigDecimal(100));
				tcproject.setPsharesPercent(sharePercent);
				tcproject.setYearmonth(tcproject.getPfoundedYear()+"年"+tcproject.getPfoundedMonth()+"月");
				if(tcproject.getPfinancingAmount().compareTo(new BigDecimal(0))>0)
					tcproject.setPfinancingAmount(tcproject.getPfinancingAmount().setScale(0).divide(new BigDecimal(10000)));
				if(tcproject.getPinvestAmount().compareTo(new BigDecimal(0))>0)
				 tcproject.setPinvestAmount(tcproject.getPinvestAmount().setScale(0).divide(new BigDecimal(10000)));
				if(tcproject.getCreator() != null&&null!=u){
					TUser tuser = tuserService.getById(tcproject.getCreator());
					if(tuser!=null){
						tcproject.setLoginName(tuser.getLoginName());
					}
					tcproject.setLeaderLoginName(u.getRealName());
				}
				String cityName = tcproject.getPcityIname();
				//如果是直辖市区划，则只显示一级
				if("市辖区".equals(cityName)||"县".equals(cityName)){
					tcproject.setPcityIname("");
				}
			}
			if(null!=TUserUtil.getLogUser(request)){
				QueryFilter filter = new QueryFilter();
				filter.addFilter("projectId", projectId);
				filter.addFilter("pavIsAgree", 1);
				filter.addFilter("userId", TUserUtil.getLogUser(request).getUserId());
				List<TProjectApplyView> ls = tProjectApplyViewService.getAll(filter);
				if(tcproject.getCreator().compareTo(TUserUtil.getLogUser(request).getUserId())==0||(null!=ls&&ls.size()>0)){//如果是项目创建人,或者通过查看申请通过的人，可以查看项目
					//设置项目可查看
					tcproject.setPviewLimit(0);
				}
			}
			//商业模式
			TcprojectModel tcprojectModel=tcprojectModelService.getByProId(Long.valueOf(projectId));
			/**
			 * 如果是地产类项目[3] 就不需要查询 创业团队， 历史情况，未来计划
			 */
			if(!"3".equals(tcproject.getPtypeId())) {
				//创业团队
				List<TcprojectTeam> listT = tcprojectTeamService.getByProId(Long.valueOf(projectId));
				//历史情况
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("projectId", Long.valueOf(projectId));
				map.put("phptypeId", "1");//历史情况
				List<TcprojectHistoryplan> listH = tcprojectHistoryplanService.getByProId(map);
				BigDecimal hmoneyIn = new BigDecimal(0);
				BigDecimal hmoneyOut = new BigDecimal(0);
				if (listH != null && listH.size() > 0) {
					for (TcprojectHistoryplan h : listH) {
						if (h.getListHpPayMent() != null && h.getListHpPayMent().size() > 0) {
							for (TcprojectHpPayments m : h.getListHpPayMent()) {
								if (m.getHpptypeId().equals("1")) {
									hmoneyIn = hmoneyIn.add(m.getHpppayment().setScale(0));
								} else {
									hmoneyOut = hmoneyOut.add(m.getHpppayment().setScale(0));
								}
							}
						}
					}
				}
				//未来计划
				Map<String, Object> map1 = new HashMap<String, Object>();
				map1.put("projectId", Long.valueOf(projectId));
				map1.put("phptypeId", "2");//历史情况

				BigDecimal fmoneyIn = new BigDecimal(0);
				BigDecimal fmoneyOut = new BigDecimal(0);
				List<TcprojectHistoryplan> listP = tcprojectHistoryplanService.getByProId(map1);

				if (listP != null && listP.size() > 0) {
					for (TcprojectHistoryplan p : listP) {
						if (p.getListHpPayMent() != null && p.getListHpPayMent().size() > 0) {
							for (TcprojectHpPayments n : p.getListHpPayMent()) {
								if (n.getHpptypeId().equals("1")) {
									if (n.getHpppayment() != null)
										fmoneyIn = fmoneyIn.add(n.getHpppayment().setScale(0));
								} else {
									if (n.getHpppayment() != null)
										fmoneyOut = fmoneyOut.add(n.getHpppayment().setScale(0));
								}
							}
						}
					}
				}
				request.setAttribute("listT",listT );//创业团队
				request.setAttribute("listH", listH);//历史情况
				request.setAttribute("listP",listP );//未来计划
				request.setAttribute("hmoneyIn", hmoneyIn);
				request.setAttribute("hmoneyOut", hmoneyOut);
				request.setAttribute("fmoneyIn", fmoneyIn);
				request.setAttribute("fmoneyOut", fmoneyOut);
			}//如果是地产类项目 就不需要查询 创业团队， 历史情况，未来计划--end
			
			//项目附件
			List<TcprojectAttachment> listA=tcprojectAttachmentService.getByProId(Long.valueOf(projectId));
			//项目动态
		    Map<String,Object> pronews =new HashMap<String,Object>();
		    pronews.put("projectId", Long.valueOf(projectId));
		    pronews.put("pntypeId", "1");//项目动态
		    pronews.put("isDel", 0);//未删除的项目动态
		    
			List<TcprojectNews> listN=tcprojectNewsService.getByProId(pronews);
			if(listN!=null&&listN.size()>0){
				for (TcprojectNews n : listN) {
					n.setPncontent(HtmlRegexpUtil.filterHtml(n.getPncontent()));
					if(n.getCreateTime()!=null){
						n.setCreateTimeStr(sdf.format(n.getCreateTime()));
					}
				}
			}
			
			//项目领投人
			Map<String,Object> invest=new HashMap<String,Object>();
			invest.put("projectId", Long.valueOf(projectId));
		//	invest.put("userId", userId);
			invest.put("piisLeader",1);
			invest.put("piisCheck2",1);//创业者未拒绝的领投人
			invest.put("piisCancel",0);
			List<TcprojectInvest> listIn=tcprojectInvestService.getInvestforPro(invest,null);
			TcprojectInvest tcprojectInvest=null;
			TuserApplyLeader tuserApplyLeader=null;
			if(listIn!=null&&listIn.size()>0){
				tcprojectInvest=listIn.get(0);
				if(tcprojectInvest!=null){
					if(tcprojectInvest.getPiinvestTime()!=null){
						tcprojectInvest.setPiinvestTimeS(sdf.format(tcprojectInvest.getPiinvestTime()));
					}
					tcprojectInvest.setPiinvest(tcprojectInvest.getPiinvest().setScale(0).divide(new BigDecimal(10000)));
					tuserApplyLeader=TuserApplyLeaderService.getLeaderInfoDetail(tcprojectInvest.getUserId());//领投人资料
				}
			}
			//项目跟投人
			Map<String,Object> invest1=new HashMap<String,Object>();
			invest1.put("projectId", Long.valueOf(projectId));
		//	invest.put("userId", userId);
			invest1.put("piisLeader",0);
			invest1.put("piisCheck2",1);//创业者未拒绝的跟投人
			invest1.put("piisCancel",0);
			List<TcprojectInvest> listInV=tcprojectInvestService.getInvestforPro(invest1,null);
			if(listInV!=null&&listInV.size()>0){
				for (TcprojectInvest t : listInV) {
					if(t.getPiinvestTime()!=null){
						t.setPiinvestTimeS(sdf.format(t.getPiinvestTime()));
						t.setPiinvest(t.getPiinvest().setScale(0).divide(new BigDecimal(10000)));
					}
				}
			}
			/**/
			request.setAttribute("tcproject",tcproject );
			request.setAttribute("tcprojectModel",tcprojectModel );
			request.setAttribute("listA",listA );
			request.setAttribute("listN",listN );
			request.setAttribute("tcprojectInvest", tcprojectInvest);
			request.setAttribute("TuserApplyLeader", tuserApplyLeader);
			request.setAttribute("listInV", listInV);

			//当前用户
			int isleader=0;
			int isaskPrice=0;
			if(u!=null){
				isaskPrice=u.getIsAskPrice();
				TUser tuser = this.tuserService.getById(u.getUserId());
				if(tuser != null){
					 isleader = tuser.getIsLeader();
					 isaskPrice = tuser.getIsAskPrice();
				}
				//isleader=u.getIsLeader();
				//当前用户对同一个项目的跟投
				Map<String,Object> uask=new HashMap<String,Object>();
				uask.put("projectId", Long.valueOf(projectId));
				uask.put("userId", u.getUserId());
				uask.put("piisCheck2",1);
				uask.put("piisCancel",0);
				List<TcprojectInvest> listInvest=tcprojectInvestService.getInvestforPro(uask,null);
				if(listInvest!=null&&listInvest.size()>0){
					//如果已经 跟投过 ，判断是否 付了款 ，如果付过款，则不能再次跟投了. 15/2/10 pyg
					TcprojectInvest ji=listInvest.get(0);
					if(ji.getPiisPay()!=null&&ji.getPiisPay()==1&&ji.getPiisCancel()==0){
						request.setAttribute("listInvest","2");//已经付款
					}else{
						request.setAttribute("listInvest","1");
					}
				}
			}
			request.setAttribute("TUser", u);
			request.setAttribute("isleader", isleader);
			request.setAttribute("isaskPrice", isaskPrice);
			//项目是否搜藏
			boolean isCollected = false;
			Map<String,Object> mapf=new HashMap<String,Object>();
			mapf.put("projectId",projectId);
			if(u!=null){
				mapf.put("userId",u.getUserId());
			}
			mapf.put("isDel",0);
			TAttention ta=tattentionService.selectTattention(mapf);
			if(ta!=null && ta.getTypeId().equals("2")){
				isCollected = true;
			}
			request.setAttribute("isCollected", isCollected);
			//项目浏览次数+1
			Tcproject tcpr=tcprojectService.getById(Long.valueOf(projectId));
			tcpr.setPviewCount(tcpr.getPviewCount()+1);
			tcprojectService.update(tcpr);
			
			//取得系统设置的项目融资上限
			 String recruitment=(String)AppUtil.getServletContext().getAttribute("RECRUITMENT_LIMIT_FINANCING");
			 request.setAttribute("RECRUITMENT_LIMIT_FINANCING", recruitment);
			 request.setAttribute("TUser", u);
			 //平台设置的项目认筹诚意金
			 String enquiryMoney=(String)AppUtil.getServletContext().getAttribute("ASK_PRICE_SINCERITY");
			 if(StringUtil.isEmpty(enquiryMoney)){
				 enquiryMoney="100";
			 }
			 request.setAttribute("EnquiryMoney00", enquiryMoney);
			//未审批项目不可浏览
			if("0".equals(tcproject.getPstateId())||"1".equals(tcproject.getPstateId())||"9".equals(tcproject.getPstateId())){
				return new ModelAndView("redirect:/index-web.jsp");
			}
			 //如果是房产类型则跳到房产的页面
			 if("3".equals(tcproject.getPtypeId())){
				 return new ModelAndView("/crowdfunding/front/innovationProjectDetailsHouse.jsp");
			 }
			return new ModelAndView("/crowdfunding/front/innovationProjectDetails.jsp");
		} catch (Exception e) {
			logger.error("project detail error:errorCode = "+WuyouchouErrorCode.PRJ_DETAIL_QUERY_ERROR.getErrorCode(),e);
			throw new CrowdFundException(WuyouchouErrorCode.PRJ_DETAIL_QUERY_ERROR.getErrorCode(),
				WuyouchouErrorCode.PRJ_DETAIL_QUERY_ERROR.getErrorMsg(),e);
		}
	}
	
	 @Action(description="打开项目评论页面")
	 @RequestMapping({"toProComment"})
	  public ModelAndView toProComment(HttpServletRequest request, HttpServletResponse response)
	    throws Exception {
		String projectId = request.getParameter("projectId");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("projectId", projectId);
		// 项目评论
		List<TcprojectComments> listC = tcprojectCommentsService
				.getTcprojectCommentsByProId(map, null);
		if (listC != null && listC.size() > 0) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			for (TcprojectComments c : listC) {
				if (c.getCreteTime() != null) {
					c.setCreteTimeStr(sdf.format(c.getCreteTime()));
				}
				for (TcprojectComments o : c.getListProComments()) {
					o.setWriteBackCreator(o.getLoginName());
					if (o.getCreteTime() != null) {
						o.setWriteBackDateStr(sdf.format(o.getCreteTime()));
					}
				}
			}
		}
		request.setAttribute("listC", listC);
		request.setAttribute("projectId", projectId);
		return new ModelAndView("/crowdfunding/front/proComment.jsp");
	}
	 
	 
	 @Action(description="项目的所有评论")
	 @RequestMapping({"toProCommentAll"})
	  public ModelAndView toProCommentAll(HttpServletRequest request, HttpServletResponse response)
	    throws Exception {
		 String projectId=request.getParameter("projectId");
		 try {
			 Map<String,Object> map = new HashMap<String,Object>();
				map.put("projectId", projectId);  
				int Num=0;
				List<TcprojectComments> listNum=tcprojectCommentsService.getTcprojectCommentsByProId(map,null);
				if(listNum!=null&&listNum.size()>0){
					Num=listNum.size();
				}
			//查询项目 包括 创业者和创业者信息
				Tcproject tcproject=tcprojectService.getTcprojectById(Long.valueOf(projectId));
				if(tcproject!=null){
					tcproject.setYearmonth(tcproject.getPfoundedYear()+"年"+tcproject.getPfoundedMonth()+"月");
					if(tcproject.getPfinancingAmount().compareTo(new BigDecimal(0))>0)
						tcproject.setPfinancingAmount(tcproject.getPfinancingAmount().setScale(0).divide(new BigDecimal(10000)));
					tcproject.setPsharesPercent(tcproject.getPsharesPercent().setScale(2));
					if(tcproject.getPinvestAmount().compareTo(new BigDecimal(0))>0)
					 tcproject.setPinvestAmount(tcproject.getPinvestAmount().setScale(0).divide(new BigDecimal(10000)));
				}
				request.setAttribute("Num",Num );
				request.setAttribute("tcproject",tcproject );
				request.setAttribute("projectId",projectId );
				return new ModelAndView("/crowdfunding/front/proCommentAll.jsp");
		} catch (Exception e) {
			logger.error("项目评论查询异常", e);
		}
		 return null;
	 }
	 
	 @Action(description="项目的所有评论")
	 @RequestMapping({"toProCommentAllIframe"})
	  public ModelAndView toProCommentAllIframe(HttpServletRequest request, HttpServletResponse response)
	    throws Exception {
		 String projectId=request.getParameter("projectId");
		 try {
			 Map<String,Object> map = new HashMap<String,Object>();
				map.put("projectId", projectId);  
				//分页加参数
				int page = RequestUtil.getInt(request, "current_page", 1);
			    int pageSize = RequestUtil.getInt(request, "pageSize",5);
				PageBean pb=new  PageBean(page, pageSize);
				//项目评论
				List<TcprojectComments> listC=tcprojectCommentsService.getTcprojectCommentsByProId(map,pb);
				if(listC!=null&&listC.size()>0){
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
					for (TcprojectComments c : listC) {
						if(c.getCreteTime()!=null){
							c.setCreteTimeStr(sdf.format(c.getCreteTime()));
						}
						for (TcprojectComments o : c.getListProComments()) {
							o.setWriteBackCreator(o.getLoginName());
							if(o.getCreteTime()!=null){
								o.setWriteBackDateStr(sdf.format(o.getCreteTime()));
							}
						}
					}
				}
				request.setAttribute("listC",listC );
				request.setAttribute("projectId",projectId );
				request.setAttribute( "page_bean", pb );//分页参数传入页面
				return new ModelAndView("/crowdfunding/front/proCommentAllIframe.jsp");
		} catch (Exception e) {
			logger.error("项目所有评论查询异常", e);
		}
		 return null;
	 }
	
	 @Action(description="打开跟投人列表")
	 @RequestMapping({"toInvestPersonList"})
	  public ModelAndView toInvestPersonList(HttpServletRequest request, HttpServletResponse response)
	    throws Exception {
		 String projectId=request.getParameter("projectId");
		 SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		 TUser u=TUserUtil.getLogUser(request);
		 try {
			//查询项目 包括 创业者和创业者信息
				Tcproject tcproject=tcprojectService.getTcprojectById(Long.valueOf(projectId));
				if(tcproject!=null){
					tcproject.setYearmonth(tcproject.getPfoundedYear()+"年"+tcproject.getPfoundedMonth()+"月");
//					if(tcproject.getPfinancingAmount().compareTo(new BigDecimal(0))>0)
//						tcproject.setPfinancingAmount(tcproject.getPfinancingAmount().setScale(0).divide(new BigDecimal(10000)));
					BigDecimal sharePercent = tcproject.getPfinancingAmount().divide(tcproject.getPvaluationFinal().multiply(new BigDecimal("10000")), 2,RoundingMode.HALF_UP).multiply(new BigDecimal(100));
					tcproject.setPsharesPercent(sharePercent);
					tcproject.setPfinancingAmount(tcproject.getPfinancingAmount().setScale(0).divide(new BigDecimal(10000)));
					if(tcproject.getPinvestAmount().compareTo(new BigDecimal(0))>0)
					 tcproject.setPinvestAmount(tcproject.getPinvestAmount().setScale(0).divide(new BigDecimal(10000)));
				}
				//项目领投人
				Map<String,Object> invest=new HashMap<String,Object>();
				invest.put("projectId", Long.valueOf(projectId));
			//	invest.put("userId", userId);
				invest.put("piisLeader",1);
				invest.put("piisCheck2",1);//创业者未拒绝的领投人
				invest.put("piisCancel",0);
				List<TcprojectInvest> listIn=tcprojectInvestService.getInvestforPro(invest,null);
				TcprojectInvest tcprojectInvest=null;
				TuserApplyLeader tuserApplyLeader=null;
				if(listIn!=null&&listIn.size()>0){
					tcprojectInvest=listIn.get(0);
					if(tcprojectInvest!=null){
						if(tcprojectInvest.getPiinvestTime()!=null){
							tcprojectInvest.setPiinvestTimeS(sdf.format(tcprojectInvest.getPiinvestTime()));
						}
						tcprojectInvest.setPiinvest(tcprojectInvest.getPiinvest().setScale(0).divide(new BigDecimal(10000)));
						tuserApplyLeader=TuserApplyLeaderService.getLeaderInfoDetail(tcprojectInvest.getUserId());//领投人资料
					}
				}
				//项目跟投人
				Map<String,Object> invest1=new HashMap<String,Object>();
				invest1.put("projectId", Long.valueOf(projectId));
			//	invest.put("userId", userId);
				invest1.put("piisLeader",0);
				invest1.put("piisCheck2",1);//创业者未拒绝的跟投人
				//分页加参数
				int page = RequestUtil.getInt(request, "current_page", 1);
				int pageSize = RequestUtil.getInt(request, "pageSize",5);
				PageBean pb=new  PageBean(page, pageSize);
				invest1.put("piisCancel",0);
				List<TcprojectInvest> listInV=tcprojectInvestService.getInvestforPro(invest1,pb);
				if(listInV!=null&&listInV.size()>0){
					for (TcprojectInvest t : listInV) {
						if(t.getPiinvestTime()!=null){
							t.setPiinvestTimeS(sdf.format(t.getPiinvestTime()));
							t.setPiinvest(t.getPiinvest().setScale(0).divide(new BigDecimal(10000)));
						}
					}
				}
				
				int isleader=0;
				int isaskPrice=0;
				if(u!=null){
					TUser tuser = this.tuserService.getById(u.getUserId());
					if(tuser != null)
						   isleader = tuser.getIsLeader();
					//isleader=u.getIsLeader();
					isaskPrice=u.getIsAskPrice();
					//当前用户对同一个项目的跟投
					Map<String,Object> uask=new HashMap<String,Object>();
					uask.put("projectId", Long.valueOf(projectId));
					uask.put("userId", u.getUserId());
					uask.put("piisCheck2",1);
					uask.put("piisCancel",0);
					List<TcprojectInvest> listInvest=tcprojectInvestService.getInvestforPro(uask,null);
					if(listInvest!=null&&listInvest.size()>0){
						request.setAttribute("listInvest","1");
					}
				}
				request.setAttribute("TUser", u);
				request.setAttribute("isleader", isleader);
				request.setAttribute("isaskPrice", isaskPrice);
				request.setAttribute( "page_bean", pb );//分页参数传入页面
				request.setAttribute("tcproject",tcproject );
				request.setAttribute("tcprojectInvest", tcprojectInvest);
				request.setAttribute("TuserApplyLeader", tuserApplyLeader);
				request.setAttribute("listInV", listInV);
		} catch (Exception e) {
			logger.error("list gentou error:errorCode = "+WuyouchouErrorCode.INVST_GENTOU_LIST_ERROR.getErrorCode(),e);
			throw new CrowdFundException(WuyouchouErrorCode.INVST_GENTOU_LIST_ERROR.getErrorCode(),
				WuyouchouErrorCode.INVST_GENTOU_LIST_ERROR.getErrorMsg(),e);
		}
		 return new ModelAndView("/crowdfunding/front/investPersonList.jsp");
	 }
	
	 @Action(description="打开发送信息窗口")
	 @RequestMapping({"openSendInfoWin"})
	  public ModelAndView openSendInfoWin(HttpServletRequest request, HttpServletResponse response)
	    throws Exception {
//		 String receiverName=request.getParameter("receiverName");
		 String receiverId=request.getParameter("receiverId");
		 String projectId=request.getParameter("projectId");
		 String type_id=request.getParameter("type_id");
		 String alsnInfo="";
		 if(StringUtil.isNotEmpty(type_id)){
			 if(type_id.equals("2")){
				 SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
				 
				 //查看当前登录人 是否今天约谈过创业者
				 TUser u=(TUser)request.getSession().getAttribute("user");
				 Map<String,Object> mp=new HashMap<String,Object>();
				 mp.put("typeId",2);
				 mp.put("senderId", u.getUserId());
				 mp.put("am",sdf.format(new Date())+" 00:00:00");
				 mp.put("pm",sdf.format(new Date())+" 23:59:59");
				 mp.put("receiverId", receiverId);
				 mp.put("projectId", projectId);
				 List<TUserMsgRemind> listmsg=tuserMsgRemindService.getNowDaySendInfo(mp);
				 if(listmsg!=null&&listmsg.size()>0){
					 alsnInfo="1";
				 }
			 }
		 }
		 
		 TUser tuser=tuserService.getById(Long.valueOf(receiverId));
		 request.setAttribute("receiverName", tuser.getLoginName());
		 request.setAttribute("receiverId", receiverId);
		 request.setAttribute("projectId", projectId);
		 request.setAttribute("type_id", type_id);
		 request.setAttribute("alsnInfo", alsnInfo);
		 return  new ModelAndView("/crowdfunding/front/sendPrivateMessages.jsp");
	 }
	 
	 @Action(description="打开询价认筹窗口")
	 @RequestMapping({"openinquiryIframe"})
	  public ModelAndView openinquiryIframe(HttpServletRequest request, HttpServletResponse response)
	    throws Exception {
		 //查询投资人 对要询价的项目  剩余 询价次数
		 String projectId=request.getParameter("projectId");
		 TUser u=TUserUtil.getLogUser(request);
		 long userId=u.getUserId();
		 String piisLeader=request.getParameter("piisLeader");//是否领投人
		 int askPriceNum=0;
		 String alreadyInveLeader="";
		 //如果当前用户具有领投资格,查看是否已经领投过
		/* List<TcprojectInvest> listLeadeer=null;
		 if(u!=null&&u.getIsLeader()==1){
			 
			 Map<String,Object> lea=new HashMap<String,Object>();
			 lea.put("projectId", Long.valueOf(projectId));
			 lea.put("userId", userId);
			 lea.put("piisLeader", 1);
			 lea.put("piisCancel",0);
			 listLeadeer=TcprojectInvestService.getInvestforPro(lea,null);
		 }
		 if(listLeadeer!=null&&listLeadeer.size()>0){
			
			 alreadyInveLeader="alreadyInveLeader";
			 request.setAttribute("alreadyInveLeader", alreadyInveLeader);
		 }else{
			 */
			 Map<String,Object> invest=new HashMap<String,Object>();
			 invest.put("projectId", StringUtils.isNotEmpty(projectId) && !"undefined".equals(projectId)?Long.valueOf(projectId):null);
			 invest.put("userId",userId);
//			 invest.put("piisCancel",0);不管是不是反悔或者拒绝取消的，只要有是否询价为1则统计询价次数
			 List<TcprojectInvest> listIn=tcprojectInvestService.getInvestforPro(invest,null);
			 int askedPriceNum=0;
			 for(TcprojectInvest tinvest:listIn){
				 /*if(tinvest.getPiisAskPrice()>0){
					 askedPriceNum++;
				 }*/
				 askedPriceNum=askedPriceNum+tinvest.getPiaskPriceTimes();
			 }
			 
			 //系统设置的询价次数
			 String askPriceMaxTimes=(String)AppUtil.getServletContext().getAttribute("ASK_PRICE_MAX_TIMES");
			 askPriceNum=Integer.valueOf(askPriceMaxTimes)-askedPriceNum;
			 request.setAttribute("askPriceMaxTimes", askPriceMaxTimes);
			 request.setAttribute("piisLeader", piisLeader);
			 request.setAttribute("projectId", projectId);
	//	 }
		 
		 return  new ModelAndView("/crowdfunding/front/inquiryIframe.jsp").addObject("askPriceNum", askPriceNum+"");
	 }
	 
	 @Action(description="打开询价认筹填写窗口")
	 @RequestMapping({"openinquiryIframeNext"})
	  public ModelAndView openinquiryIframeNext(HttpServletRequest request, HttpServletResponse response)
	    throws Exception {
//		 String askPriceNum=request.getParameter("askPriceNum");//剩余询价次数  //4/17 根据客户要求取消询价功能
//		 String yesAsk=request.getParameter("yesAsk"); //4/17 根据客户要求取消询价功能
		 String projectId=request.getParameter("projectId");
	//	 String noAsk=request.getParameter("noAsk");
		 String piisLeader=request.getParameter("piisLeader");//是否领投人
		 
		 if(null != projectId && !"undefined".equals(projectId) && !"null".equals(projectId)){
			 Tcproject tcproject= tcprojectService.getById(Long.valueOf(projectId));
			 request.setAttribute("pinvestMinLeader", tcproject.getPinvestMinLeader());
			 
			 request.setAttribute("pinvestMaxLeader", tcproject.getPinvestMaxLeader());
			 
			 request.setAttribute("pinvestMinFollow", tcproject.getPinvestMinFollow());
			 
			 //超募比例
			 BigDecimal recruitment=new BigDecimal((String)AppUtil.getServletContext().getAttribute("RECRUITMENT_LIMIT_FINANCING")).divide(new BigDecimal(100));
			 
			 //项目可投金额=项目总额*1.2-项目已投金额
			 BigDecimal allowInvest = tcproject.getPfinancingAmount().multiply(recruitment).subtract(tcproject.getPinvestAmount());
			 
			 request.setAttribute("pfinancingAmount", allowInvest);//项目可投资金额
		 }
//		 request.setAttribute("yesAsk", yesAsk);
	//	 request.setAttribute("noAsk", noAsk);
		 request.setAttribute("piisLeader", piisLeader);
		 request.setAttribute("projectId", projectId);
		 return  new ModelAndView("/crowdfunding/front/inquiryIframeNext.jsp");//.addObject("askPriceNum", askPriceNum);
	 }
	 
	 @Action(description="申请投资：领投、跟投")
	 @RequestMapping({"doInvest"})
	 @ResponseBody
	 @Transactional
	  public String doInvest(HttpServletRequest request, HttpServletResponse response){
		 
		 String piinvest=request.getParameter("piinvest");
		 String pireasons=request.getParameter("pireasons");
		 String pimyHelp=request.getParameter("pimyHelp");
		 String projectId=request.getParameter("projectId");
		 String piisGeneralPartner=request.getParameter("piisGeneralPartner");
		 String piisLeader=request.getParameter("piisLeader");
		 long userId=TUserUtil.getLogUser(request).getUserId();
		 Tcproject tcproject=tcprojectDao.getById(Long.valueOf(projectId));
		 BigDecimal totalAmount = tcproject.getPinvestAmount();
		 BigDecimal financingAmount = tcproject.getPfinancingAmount();
		 //超募比例
		 BigDecimal recruitment = null;
		 try{
			 recruitment = new BigDecimal((String)AppUtil.getServletContext().
					 getAttribute("RECRUITMENT_LIMIT_FINANCING")).divide(new BigDecimal(100));
		 }catch(Exception e){
			 recruitment = new BigDecimal("1.2");//获取超募比例失败则默认给1.2
		 }
		 //如果输入金额超过超募上限 return -1
		 if ( financingAmount.multiply(recruitment).compareTo(totalAmount.add(new BigDecimal(piinvest).multiply(new BigDecimal("10000")))) == -1 ) {
			 return "-1";
		 }
		 
		try {
			TcprojectInvest tcprojectInvest=new TcprojectInvest();
			tcprojectInvest.setInvestId(UniqueIdUtil.genId());
			tcprojectInvest.setUserId(userId);
			tcprojectInvest.setPiinvestTime(new Date());
			//Tcproject tcproject=tcprojectService.getById(Long.valueOf(projectId));
			if(StringUtil.isNotEmpty(piisLeader)){
				if(piisLeader.equals("1")){//领投人
					tcprojectInvest.setPiisLeader(1);
						if(StringUtil.isNotEmpty(piinvest))
							tcprojectInvest.setPiinvest(new BigDecimal(piinvest).multiply(new BigDecimal(10000)));
						tcprojectInvest.setPitypeId(2);//领投部分
				}else{
					tcprojectInvest.setPiisLeader(0);
					tcprojectInvest.setPitypeId(3);//跟投
					
					if(StringUtil.isNotEmpty(piinvest))
						tcprojectInvest.setPiinvest(new BigDecimal(piinvest).multiply(new BigDecimal(10000)));
				}
			}
			tcprojectInvest.setPiisGeneralPartner(Integer.valueOf(piisGeneralPartner));
			tcprojectInvest.setPivaluation(new BigDecimal("0"));//客户要求 去掉询价功能
			tcprojectInvest.setPireasons(pireasons);
			tcprojectInvest.setPimyHelp(pimyHelp);
			tcprojectInvest.setProjectId(Long.valueOf(projectId));
			tcprojectInvest.setPiisAskPrice(0);//客户要求 去掉询价功能
			tcprojectInvest.setPiisCancel(0);
			tcprojectInvestService.addInvest(tcprojectInvest);
			
			//更新t_c_project表 数据
			long proid=Long.valueOf(projectId);
			String pinvestAmount=new BigDecimal(piinvest).multiply(new BigDecimal(10000))+"";
			String addOrSubTract="add";
			tcprojectService.countInvestMoneyScheduleNumber(proid,pinvestAmount,addOrSubTract);
			//处理项目投资数和投资金额计算的
			tcprojectService.calculateProjectInvestmentInfo(proid);
			return "1";
		} catch (Exception e) {
			logger.error("申请投资异常", e);
		}
		 return  null;
	 }
	 
	 //addtoInvestMoney.jsp
	 @Action(description="打开追加投资金额填写窗口")
	 @RequestMapping({"addtoInvestMoney"})
	  public ModelAndView addtoInvestMoney(HttpServletRequest request, HttpServletResponse response)
	    throws Exception {
		// String askPriceNum=request.getParameter("askPriceNum");//剩余询价次数
		 String project=request.getParameter("projectId");
		 long projectId = Long.valueOf(project);
		 long userId=TUserUtil.getLogUser(request).getUserId();
		 //查询本人已投资多少钱
		 List<TcprojectInvest> investAlready = tcprojectInvestService.getTcprojectInvest(projectId, userId);
		 
		 BigDecimal investMoney = BigDecimal.ZERO;
		 String checkFlag = "0";
		 for(TcprojectInvest invest : investAlready){
			 Integer isCheck = invest.getPiisCheck();
			 Integer piisCancel = invest.getPiisCancel();
			 //只有未审核的投资记录才能追加
			 if(isCheck == 0 && 0 == piisCancel){
				 investMoney = investMoney.add(invest.getPiinvest());
			 }else if(isCheck == 1 && 0 == piisCancel){
				 checkFlag = "1";
			 }
		 }
		 TUser user = TUserUtil.getLogUser(request);
		 String piisLeader = user.getIsLeader()+"";
		 Tcproject cp= tcprojectService.getById(projectId);
		//超募比例
		 BigDecimal recruitment=new BigDecimal((String)AppUtil.getServletContext().getAttribute("RECRUITMENT_LIMIT_FINANCING")).divide(new BigDecimal(100));
		 //项目可投金额=项目总额*1.2-项目已投金额
		 BigDecimal allowInvest = cp.getPfinancingAmount().multiply(recruitment).subtract(cp.getPinvestAmount()).divide(new BigDecimal(10000));
		 String pfinancingAmount=allowInvest+"";//剩余可投资金额
		 String collectPro = request.getParameter("collectPro");//从项目管理界面发生的请求
		//计算剩余最大可领投金额
		 BigDecimal leadMaxPrecent=new BigDecimal((String)AppUtil.getServletContext().getAttribute("LEADER_MAX_PERCENT")).divide(new BigDecimal(100));
		 BigDecimal allowApply = cp.getPfinancingAmount().multiply(leadMaxPrecent).subtract(investMoney);
		 if(StringUtil.isNotEmpty(collectPro)&&"1".equals(collectPro)){
			 TUser u=TUserUtil.getLogUser(request);
			 Map<String,Object> invest=new HashMap<String,Object>();
			 invest.put("projectId", StringUtils.isNotEmpty(project) && !"undefined".equals(project)?Long.valueOf(project):null);
			 invest.put("userId",u.getUserId());
		 }
		 return  new ModelAndView("/crowdfunding/front/addtoInvestMoney.jsp").addObject("pfinancingAmount", pfinancingAmount)
				 .addObject("investMoney", investMoney+"").addObject("projectId", projectId).addObject("pinvestMaxLeader", allowApply+"")
				 .addObject("piisLeader", piisLeader).addObject("checkFlag", checkFlag);
	 }
	
	 @Action(description="修改询价认筹操作")
	 @RequestMapping({"updateInvest"})
	 @ResponseBody
	  public String updateInvest(HttpServletRequest request, HttpServletResponse response)
	    throws Exception {
		 String piinvest = request.getParameter("piinvest");
		 String projectId = request.getParameter("projectId");
		 //String piisGeneralPartner=request.getParameter("piisGeneralPartner");
		 long userId=TUserUtil.getLogUser(request).getUserId();
		 Tcproject tcproject=tcprojectDao.getById(Long.valueOf(projectId));
		 BigDecimal totalAmount = tcproject.getPinvestAmount();
		 BigDecimal financingAmount = tcproject.getPfinancingAmount();
		 //超募比例
		 BigDecimal recruitment = null;
		 try{
			 recruitment = new BigDecimal((String)AppUtil.getServletContext().
					 getAttribute("RECRUITMENT_LIMIT_FINANCING")).divide(new BigDecimal(100));
		 }catch(Exception e){
			 recruitment = new BigDecimal("1.2");//获取超募比例失败则默认给1.2
		 }
		 //如果输入金额超过超募上限 return -1
		 if ( financingAmount.multiply(recruitment).compareTo(totalAmount.add(new BigDecimal(piinvest).multiply(new BigDecimal("10000")))) == -1 ) {
			 return "-1";
		 }
		 //查询该用户的投资记录
		try {
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("projectId", Long.valueOf(projectId));
			map.put("userId", userId);
			map.put("piisCheck2",1);//查询 待审核 和已经审核的跟投
			map.put("piisCancel",0);
			TcprojectInvest tcprojectInvest=null;
			List<TcprojectInvest> list = tcprojectInvestService.getInvestforPro(map,null);
			if(list!=null&&list.size()>0){
				tcprojectInvest=list.get(0);
			}
			
			if(null != tcprojectInvest){
				if(1 == tcprojectInvest.getPiisCheck()){
					//已通过审核不能再进行追加
					return "3";
				}
				tcprojectInvest.setPiinvestTime(new Date());
				if(StringUtil.isNotEmpty(piinvest))
				tcprojectInvest.setPiinvest(tcprojectInvest.getPiinvest().add(new BigDecimal(piinvest).multiply(new BigDecimal(10000))));
				//tcprojectInvest.setPiisGeneralPartner(Integer.valueOf(piisGeneralPartner));
				tcprojectInvest.setPiisCancel(0);
				tcprojectInvestService.update(tcprojectInvest);
				//更新t_c_project表 数据
				long proid=Long.valueOf(projectId);
				String pinvestAmount=new BigDecimal(piinvest).multiply(new BigDecimal(10000))+"";
				String addOrSubTract="add";
				tcprojectService.countInvestMoneyScheduleNumber(proid,pinvestAmount,addOrSubTract);
				//处理项目投资数和投资金额计算的
				tcprojectService.calculateProjectInvestmentInfo(proid);
				return "1";
			}else{
				return "2";
			}
		} catch (Exception e) {
			logger.error("",e);
		}
		 return  null;
	 }
	 
	 @Action(description="收藏项目")
	 @RequestMapping({"favorite"})
	 @ResponseBody
	  public String favorite(HttpServletRequest request, HttpServletResponse response)
	    throws Exception {
		 String projectId=request.getParameter("projectId");//
		 String creator=request.getParameter("Creator");//
		 TUser u=(TUser)request.getSession().getAttribute("user");
		 if(u == null){
			return "0";
		 }
		try{
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("projectId",projectId);
			map.put("userId",u.getUserId());//TODO
			map.put("isDel",0);
			TAttention ta=tattentionService.selectTattention(map);
			if(ta==null){
				 ta=new TAttention();
				 ta.setAttentionId(UniqueIdUtil.genId());
				 ta.setTypeId("2");//收藏
				 ta.setCreateTime(new Date());
				 ta.setProjectId(Long.valueOf(projectId));
				 ta.setIsDel(0);
				 ta.setUserId(u.getUserId());
				 ta.setBeUserId(Long.valueOf(creator));
				tattentionService.add(ta);
				//更新项目的收藏次数
				Tcproject tcproject=tcprojectService.getById(Long.valueOf(projectId));
				tcproject.setPfavoritesCount(tcproject.getPfavoritesCount()+1);
				tcprojectService.update(tcproject);
				return "1";
			}else{
				return "2";
			}
		   } catch (Exception e){
		       logger.error("收藏项目异常", e);
	      }
		return null;
	 }
	 
	 /**
	  * 发表评论
	  * @param request
	  * @param response
	  * @return
	  * @throws Exception
	  */
	 @Action(description="发表评论")
	 @RequestMapping({"sendTalkmsg"})
	 @ResponseBody
	  public String sendTalkmsg(HttpServletRequest request, HttpServletResponse response)
	    throws Exception {
		 String projectId=request.getParameter("projectId");//
		 String commentConten=request.getParameter("commentConten");//
		 TUser u=(TUser)request.getSession().getAttribute("user");
		 if(u == null){
				return "0";
		  }
		 try {
			 TcprojectComments tcprojectComments=new TcprojectComments();
			 tcprojectComments.setCommentsId(UniqueIdUtil.genId());//id
			 tcprojectComments.setCreteTime(new Date());//发表时间
			 tcprojectComments.setCreator(u.getUserId());//发表人
			 tcprojectComments.setProjectId(Long.valueOf(projectId));//发表的项目id
			 tcprojectComments.setPctypeID(1);//评论
			 tcprojectComments.setPcparentD(0L);//初次评论
			 tcprojectComments.setPccontent(commentConten);//评论内容
			 tcprojectCommentsService.add(tcprojectComments);
			 return "1";
		} catch (Exception e) {
			logger.error("add comment error:errorCode = "+WuyouchouErrorCode.PRJ_COMMENT_ADD_ERROR.getErrorCode(),e);
			throw new CrowdFundException(WuyouchouErrorCode.PRJ_COMMENT_ADD_ERROR.getErrorCode(),
				WuyouchouErrorCode.PRJ_COMMENT_ADD_ERROR.getErrorMsg(),e);
		}
	 }
	 
	 /**
	  * 回复评论
	  * @param request
	  * @param response
	  * @return
	  * @throws Exception
	  */
	 @Action(description="回复评论")
	 @RequestMapping({"replyMsg"})
	 @ResponseBody
	  public String replyMsg(HttpServletRequest request, HttpServletResponse response)
	    throws Exception {
		 String projectId=request.getParameter("projectId");//
		 String commentConten=request.getParameter("commentConten");//
		 String commentsId=request.getParameter("commentsId");//
		 TUser u=(TUser)request.getSession().getAttribute("user");
		 if(u == null){
				return "0";
		  }
		 try {
			 TcprojectComments tcprojectComments=new TcprojectComments();
			 tcprojectComments.setCommentsId(UniqueIdUtil.genId());
			 tcprojectComments.setCreteTime(new Date());//回复时间
			 tcprojectComments.setCreator(u.getUserId());//回复人
			 tcprojectComments.setProjectId(Long.valueOf(projectId));//项目id
			 tcprojectComments.setPctypeID(2);//回复
			 tcprojectComments.setPcparentD(Long.valueOf(commentsId));//回复的评论
			 tcprojectComments.setPccontent(commentConten);//回复的内容
			 tcprojectCommentsService.add(tcprojectComments);
			 return "1";
		} catch (Exception e) {
			logger.error("replay comment error:errorCode = "+WuyouchouErrorCode.PRJ_COMMENT_REPLAY_ERROR.getErrorCode(),e);
			throw new CrowdFundException(WuyouchouErrorCode.PRJ_COMMENT_REPLAY_ERROR.getErrorCode(),
				WuyouchouErrorCode.PRJ_COMMENT_REPLAY_ERROR.getErrorMsg(),e);
		}
	 }
	 
	 /**
	  * 发送私信
	  * @param request
	  * @param response
	  * @return
	  * @throws IOException
	  */
	 @RequestMapping({ "sendPrivateMsg" })
	 @ResponseBody
	public String sendPrivateMsg(HttpServletRequest request,
				HttpServletResponse response) throws IOException {
		 String projectId=request.getParameter("projectId");//
		 String receiverId=request.getParameter("receiverId");//
		 String content_id=request.getParameter("content_id");//
		 String type_id = request.getParameter("type_id");
		 		
		 //String valiCode_=request.getParameter("code");
		 //String validCode = (String)request.getSession().getAttribute(ValidCode.getSessionName_Randcode());
	     //   if(!valiCode_.equals(validCode))   //验证吗输入不正确  	
	     //   	return "0";
	     TUser u= TUserUtil.getLogUser(request);
		 try {
			TUserMsgRemind tuserMsgRemind=new TUserMsgRemind();
			tuserMsgRemind.setMsgRemindId(UniqueIdUtil.genId());//id 
			if(StringUtil.isNotEmpty(projectId))
				tuserMsgRemind.setProjectId(Long.valueOf(projectId));
			tuserMsgRemind.setReceiverId(Long.valueOf(receiverId));
			tuserMsgRemind.setContent(content_id);
			tuserMsgRemind.setTypeId(Integer.valueOf(type_id));//私信
			tuserMsgRemind.setSenderId(u.getUserId());//发送私信人id
			tuserMsgRemind.setSendTime(new Date());//发送时间
			tuserMsgRemind.setStateId(0);//未读
			tuserMsgRemind.setIsReply(0L);//未回复
			tuserMsgRemind.setReplyID(0L);
			tuserMsgRemind.setIsDel(0L);
			tuserMsgRemindService.add(tuserMsgRemind);
			return "发送成功!";
		} catch (Exception e) {
			logger.error("发送私信异常,receiverId="+receiverId, e);
			return "发送失败!";
		}
	}
	 
	 
	 /**
		 * 验证随机验证码
		 * 
		 * @param request
		 * @param response
		 * @return
		 * @throws IOException
		 */
		@RequestMapping({ "validateCode" })
		@ResponseBody
		public int validateCode(HttpServletRequest request,
				HttpServletResponse response) throws IOException {
			String code = request.getParameter("valiCode_");
			String validCode = (String)request.getSession().getAttribute(ValidCode.getSessionName_Randcode());
	        if(code.equalsIgnoreCase(validCode))   //输入正确  	
	        	return 1;
	        else
	        	return 0;
		}
		
		
		@RequestMapping({"downloadFile"})
		  @Action(description="附件下载", exectype="管理日志", detail="附件【${SysAuditLinkService.getSysFileLink(Long.valueOf(fileId))}】下载")
		  public void downloadFile(HttpServletRequest request, HttpServletResponse response)
		    throws IOException
		  {
			OutputStream outp = response.getOutputStream();
		    long fileId = RequestUtil.getLong(request, "fileId", 0L);
		    if (fileId == 0L) {
		    	 outp.write("文件不存在!".getBytes("utf-8"));
		      return;
		    }
		    TcprojectAttachment tcprojectAttachment =tcprojectAttachmentService.getById(Long.valueOf(fileId));
		  /*  SysFile sysFile = (SysFile)this.sysFileService.getById(Long.valueOf(fileId));
		    if (sysFile == null) {
		      return;
		    }*/
		    if(tcprojectAttachment==null){
		    	 outp.write("文件不存在!".getBytes("utf-8"));
		    	return;
		    }
		//    String filePath = sysFile.getFilePath();
		    String filePath=tcprojectAttachment.getPapath();
		    if (StringUtil.isEmpty(filePath)) {
		      return;
		    }
		   /* if (StringUtil.isEmpty(this.attachPath)) {
		      this.attachPath = AppUtil.getRealPath("/attachFiles/temp");
		    }*/
		    String path = request.getSession().getServletContext().getRealPath("/").replace("/", "\\");;
		    String fullPath = StringUtil.trimSufffix(path, File.separator) + File.separator +filePath.replace("/", File.separator);
		    String fileName = tcprojectAttachment.getPafileName();// + "." + tcprojectAttachment.getExt();
		    this.logger.info("下载的文件路径为：" + fullPath+",名称为："+fileName);
		 //   FileUtil.downLoadFile(request, response, fullPath, fileName);
		    downLoadFile(request, response, fullPath, fileName);
		  }
		
		 public static void downLoadFile(HttpServletRequest request, HttpServletResponse response, String fullPath, String fileName)
				    throws IOException
				  {
			
				    OutputStream outp = response.getOutputStream();
				    File file = new File(fullPath);
				    if (file.exists())
				    {
				      response.setContentType("APPLICATION/OCTET-STREAM");
				      String filedisplay = fileName;
				      String agent = request.getHeader("USER-AGENT");
				      if ((agent != null) && (agent.indexOf("MSIE") == -1))
				      {
				        String enableFileName = "=?UTF-8?B?" + new String(Base64.getBase64(filedisplay)) + "?=";
				        response.setHeader("Content-Disposition", "attachment; filename=" + enableFileName);
				      }
				      else
				      {
				        filedisplay = URLEncoder.encode(filedisplay, "utf-8");
				        response.addHeader("Content-Disposition", "attachment;filename=" + filedisplay);
				      }
				      FileInputStream in = null;
				      try
				      {
				        outp = response.getOutputStream();
				        in = new FileInputStream(fullPath);
				        byte[] b = new byte[1024];
				        int i = 0;
				        while ((i = in.read(b)) > 0) {
				          outp.write(b, 0, i);
				        }
				        outp.flush();
				      }
				      catch (Exception e)
				      {
				        e.printStackTrace();
				      }
				      finally
				      {
				        if (in != null)
				        {
				          in.close();
				          in = null;
				        }
				        if (outp != null)
				        {
				          outp.close();
				          outp = null;
				          response.flushBuffer();
				        }
				      }
				    }
				    else
				    {
				      outp.write("文件不存在!".getBytes("utf-8"));
				    }
				  }
		 
			@ RequestMapping( { "delAttachment" } )
			@ Action( description = "删除TcprojectAttachment数据" )
			@ResponseBody
			public void delAttachment( HttpServletRequest request, HttpServletResponse response ) throws Exception
			{
				 PrintWriter out = response.getWriter();
				    Long[] lAryId = RequestUtil.getLongAryByStr(request, "ids");
				    try
				    {
				      for (Long id : lAryId)
				      {
				    	TcprojectAttachment tcprojectAttachment = tcprojectAttachmentService.getById(id);
				        String filePath = tcprojectAttachment.getPapath();
				        filePath = filePath.replace('\\', '/');
				        FileUtil.deleteFile(filePath);
				        tcprojectAttachmentService.delById(id);
				      }
				      out.print("删除成功");
				    }
				    catch (Exception e)
				    {
				      out.print("删除失败");
				    }
			}
}
