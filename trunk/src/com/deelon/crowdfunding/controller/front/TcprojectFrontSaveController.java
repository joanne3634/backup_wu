package com.deelon.crowdfunding.controller.front;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.page.PageBean;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.crowdfunding.common.util.TUserUtil;
import com.deelon.crowdfunding.model.backstage.Tcproject;
import com.deelon.crowdfunding.model.backstage.TcprojectHistoryplan;
import com.deelon.crowdfunding.model.backstage.TcprojectHpPayments;
import com.deelon.crowdfunding.model.backstage.TcprojectModel;
import com.deelon.crowdfunding.model.backstage.TcprojectTeam;
import com.deelon.crowdfunding.service.backstage.TcprojectAttachmentService;
import com.deelon.crowdfunding.service.backstage.TcprojectHistoryplanService;
import com.deelon.crowdfunding.service.backstage.TcprojectHpPaymentsService;
import com.deelon.crowdfunding.service.backstage.TcprojectModelService;
import com.deelon.crowdfunding.service.backstage.TcprojectService;
import com.deelon.crowdfunding.service.backstage.TcprojectTeamService;
import com.deelon.crowdfunding.service.front.TcprojectFrontSaveService;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.Tarea;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TareaService;

/**
 * 处理前台项目编辑的请求 
 * @author verryqin
 *
 */
@Controller
@RequestMapping({ "/crowdfunding/tcproject/" })
public class TcprojectFrontSaveController {
	@ Resource
	private TUserService tuserService;
	@ Resource
	private TcprojectFrontSaveService tprojectFrontSaveService;
	@ Resource
	private TcprojectService tcprojectService;//项目主表
	@Resource
	private TcprojectHistoryplanService tcprojectHistoryplanService;//历史/计划
	@Resource
	private TcprojectHpPaymentsService tcprojectHpPaymentsService;//历史/计划 支出
	@Resource
	private TcprojectModelService tcprojectModelService;//商业计划
	@Resource
	private TcprojectAttachmentService tcprojectAttachmentService;//附件
	@Resource
	private TcprojectTeamService tcprojectTeamService;
	@ Resource
	private TareaService tareaService;
	
	@RequestMapping({ "sumbmitTcproject" })
	@Action( description = "提交项目基本信息" )
	public Object sumbmitTcproject(HttpServletRequest request, HttpServletResponse response) { 
		Tcproject model = tcprojectService.getById(Long.parseLong(request.getParameter("projectId")));
		model.setUpdateTime(new Date());
		if(StringUtil.isNotEmpty(request.getParameter("pvideo"))){//如果是上传视频路径，即非提交项目资料操作，则不修改项目状态
			model.setPvideo(request.getParameter("pvideo"));
		}else{//否则修改项目状态
			//if(model.getPcheckTimes()>1){
			//	model.setPcheckTimes(1);//修改之后，设置审核次数为1次，以便还可以被后台审核
			//}
			Long cityId = model.getPcityId();
			Tarea area = tareaService.getById(cityId);
			if(null != area && 0 == area.getIsRecommended()){
				area.setIsRecommended(1l);
				tareaService.update(area);
			}
			model.setPstateId("1");//设置为已提交
			model.setPiisCheck(0);
			model.setPcheckTime(null);//设置审核时间为空
			model.setPisBreak(0);
		}
		tcprojectService.update(model);
		return new ModelAndView("redirect:/crowdfunding/tcuserPersonalData/myAccount.ht?projectId="+model.getProjectId());
	}
	
	@RequestMapping({ "editorTcproject" })
	@Action( description = "去编辑项目基本信息,跳转到项目遍及页面请求" )
	public ModelAndView toEditTcproject(HttpServletRequest request, HttpServletResponse response) { 
		Tcproject tcproject = null;
		List<Integer> years = new ArrayList<Integer>();//用于项目创建时间 选择年
		List<Integer> months = new ArrayList<Integer>();//用于项目创建时间 选择月
		Calendar calendar = Calendar.getInstance();
		int year = calendar.get(calendar.YEAR);
		if(StringUtil.isEmpty(request.getParameter("projectId"))){
		}else{
			tcproject = tcprojectService.getById(Long.parseLong(request.getParameter("projectId")));
		}
		for(int i=0;i<25;i++){
			years.add(year-i);
		}
		request.setAttribute("years",years);
		for(int j=0;j<12;j++){
			months.add(12-j);
		}
		request.setAttribute("months",months);
		request.setAttribute("years",years);
		QueryFilter query = new QueryFilter();
		query.addFilter("parentId", 1);
		List<Tarea> arealist = tareaService.getAll(query);
		
		request.setAttribute("arealist", arealist);
		return new ModelAndView("/crowdfunding/front/tcproject/editorbasics.jsp").addObject("tcproject",tcproject);
	}
	
	@RequestMapping({ "saveproject" })
	@Action( description = "保存项目基本信息" )
	public ModelAndView saveproject(Tcproject tcproject,HttpServletRequest request, HttpServletResponse response) { 
		tcproject.setCreator(TUserUtil.getLogUser(request).getUserId());
//		String[] dates = request.getParameter("start").split("-");//选择项目企业创建公司年份之后，处理年月的分别保存
//		if(dates.length>2){
//			tcproject.setPfoundedYear(Integer.parseInt(dates[0]));
//			tcproject.setPfoundedMonth(Integer.parseInt(dates[1]));
//		}
		if(null!=tcproject.getPcityId()&&tcproject.getPcityId()>0&&null!=tcproject.getPprovincesId()&&tcproject.getPprovincesId()>0){
			tcproject.setPcityIname(tareaService.getById(tcproject.getPcityId()).getAreaName());
			tcproject.setPprovincesName(tareaService.getById(tcproject.getPprovincesId()).getAreaName());
		}
		Tcproject model = tprojectFrontSaveService.saveTcprojectBasicInfo(tcproject);
		String url = "";
		if("2".equals(request.getParameter("next"))){//如果不是下一步，跳转会项目编辑展示页
			url = "redirect:/crowdfunding/tcuserPersonalData/myAccount.ht?projectId="+model.getProjectId();
		}else{//如果是下一步，则跳转到下一个项目编辑页面，到项目商业模型
			url = "redirect:/crowdfunding/tcproject/editorModels.ht?projectId="+model.getProjectId();
		}
		return new ModelAndView(url);
	}
	
	@RequestMapping({ "editorModels" })
	@Action( description = "去编辑项目基本商业模型信息" )
	public ModelAndView toEditTcprojectModels(HttpServletRequest request, HttpServletResponse response) { 
		TcprojectModel model = null;
		Tcproject tcproject = null;
		String projectId =request.getParameter("projectId");
		if(StringUtil.isNotEmpty(projectId)){
			model = tcprojectModelService.getByProId(Long.valueOf(projectId));
			tcproject = tcprojectService.getTcprojectById(Long.valueOf(projectId));
		}
		if(null == model){
			model = new TcprojectModel();
			//设置默认值    @author xul  
			model.setPmtargeted("无");
			model.setPmcurrentlyPlaguing("无");
			model.setPmservicesMode("无");
			model.setPmprofitableDesc("无");
			model.setPmcompetitors("无");
			model.setPmcoreCompetitiveness("无");
		}
		////如果是房产类型则跳到房产的页面
		if(tcproject!= null && "3".equals(tcproject.getPtypeId())){
			return new ModelAndView("/crowdfunding/front/tcproject/editorsHouse.jsp").addObject("tcprojectModel",model).addObject("projectId", projectId);
		}
		return new ModelAndView("/crowdfunding/front/tcproject/editors.jsp").addObject("tcprojectModel",model).addObject("projectId", projectId);
	}
	
	@RequestMapping({ "saveprojectmodel" })
	@Action( description = "保存项目商业模式" )
	public ModelAndView saveprojectmodel(TcprojectModel tcprojectmodel,HttpServletRequest request, HttpServletResponse response) { 
		
		TcprojectModel model = tprojectFrontSaveService.saveTcprojectModelInfo(tcprojectmodel);
		String url = "";
		if("2".equals(request.getParameter("next"))){
			url = "redirect:/crowdfunding/tcuserPersonalData/myAccount.ht?projectId="+model.getProjectId();
		}else{//如果是下一步，则跳转到下一个项目编辑页面，到项目团队编辑
			/**
			 * 如果是地产项目则是返回到项目展示页面
			 */
			Tcproject tcproject = tcprojectService.getTcprojectById(Long.valueOf(request.getParameter("projectId")));
			if(tcproject!=null&&"3".equals(tcproject.getPtypeId())){
				url = "redirect:/crowdfunding/tcuserPersonalData/myAccount.ht?projectId="+request.getParameter("projectId");
			}else{
				url = "redirect:/crowdfunding/tcproject/editorpartners.ht?projectId="+request.getParameter("projectId");
			}
		}
		return new ModelAndView(url);
	}
	
	@RequestMapping({ "editorhplans" })
	@Action( description = "去编辑项目历史或者未来计划" )
	public ModelAndView toEditTcprojecthplansss(HttpServletRequest request, HttpServletResponse response) { 
		if(StringUtil.isEmpty(request.getParameter("projectId"))){
		}else{
			List<Integer> years = new ArrayList<Integer>();
			List<Integer> months = new ArrayList<Integer>();
			Calendar calendar = Calendar.getInstance();
			int year = calendar.get(calendar.YEAR);
			if("1".equals(request.getParameter("type"))){
				//历史情况
				Map<String,Object> map =new HashMap<String,Object>();
				map.put("projectId", Long.valueOf(request.getParameter("projectId")));
				map.put("phptypeId", "1");//历史情况
				List<TcprojectHistoryplan> listH=tcprojectHistoryplanService.getByProId(map);
				BigDecimal hmoneyIn=new BigDecimal(0);
				BigDecimal hmoneyOut=new BigDecimal(0);
				if(listH!=null&&listH.size()>0){
					for (TcprojectHistoryplan h : listH) {
						if(h.getListHpPayMent()!=null&&h.getListHpPayMent().size()>0){
							for (TcprojectHpPayments m : h.getListHpPayMent()) {
								if(m.getHpptypeId().equals("1")){
									hmoneyIn=hmoneyIn.add(m.getHpppayment().setScale(0));
								}else{
									hmoneyOut=hmoneyOut.add(m.getHpppayment().setScale(0));
								}
							}
						}
					}
				}else{
					TcprojectHistoryplan t = new TcprojectHistoryplan();
					t.setPhpname("阶段一");
					t.setPhpstartYear(2015);
					t.setPhpstartMonth(1);
					t.setPhpendYear(2015);
					t.setPhpendMonth(12);
					t.setPhptargetDesc("无");
					t.setPhptargetWay("无");
					listH.add(t);
				}
				for(int i=0;i<10;i++){
					years.add(year-i);
				}
				request.setAttribute("years",years);
				for(int j=0;j<12;j++){
					months.add(12-j);
				}
				request.setAttribute("months",months);
				request.setAttribute("list", listH);
				request.setAttribute("moneyIn", hmoneyIn);
				request.setAttribute("moneyOut", hmoneyOut);
			}else{
				//未来计划
				Map<String,Object> map1 =new HashMap<String,Object>();
				map1.put("projectId", Long.valueOf(request.getParameter("projectId")));
				map1.put("phptypeId", "2");//历史情况
				
				BigDecimal fmoneyIn=new BigDecimal(0);
				BigDecimal fmoneyOut=new BigDecimal(0);
				List<TcprojectHistoryplan> listP=tcprojectHistoryplanService.getByProId(map1);
				
				if(listP!=null&&listP.size()>0){
					for (TcprojectHistoryplan p : listP) {
						if(p.getListHpPayMent()!=null&&p.getListHpPayMent().size()>0){
							for (TcprojectHpPayments n : p.getListHpPayMent()) {
								if(n.getHpptypeId().equals("1")){
									if(n.getHpppayment()!=null)
										fmoneyIn=fmoneyIn.add(n.getHpppayment().setScale(0));
								}else{
									if(n.getHpppayment()!=null)
										fmoneyOut=fmoneyOut.add(n.getHpppayment().setScale(0));
								}
							}
						}
					}
				}else{
					TcprojectHistoryplan t = new TcprojectHistoryplan();
					t.setPhpname("阶段一");
					t.setPhpstartYear(2015);
					t.setPhpstartMonth(1);
					t.setPhpendYear(2015);
					t.setPhpendMonth(12);
					t.setPhptargetDesc("无");
					t.setPhptargetWay("无");
					listP.add(t);
				}
				for(int i=0;i<10;i++){
					years.add(year+i);
				}
				for(int j=0;j<12;j++){
					months.add(12-j);
				}
				request.setAttribute("months",months);
				request.setAttribute("years",years);
				request.setAttribute("list",listP );
				request.setAttribute("moneyIn", fmoneyIn);
				request.setAttribute("moneyOut", fmoneyOut);
			}
		}
		request.setAttribute("type", request.getParameter("type"));
		return new ModelAndView("/crowdfunding/front/tcproject/editorhisandplan.jsp").addObject("projectId",request.getParameter("projectId"));
	}
	@RequestMapping({ "savehplans" })
	@Action( description = "保存项目历史和未来信息" )
	public ModelAndView saveTcprojecthplansss(HttpServletRequest request, HttpServletResponse response) { 
		JSONArray jsonArr = JSONArray.fromObject(request.getParameter("datas"));
		Long projectId = Long.valueOf(request.getParameter("projectId"));
		TcprojectHistoryplan hp = null;
		int i=1;
		for(Object obj:jsonArr){
			JSONObject json = JSONObject.fromObject(obj);
			if(!"".equals(json.getString("phpname"))){
				hp = new TcprojectHistoryplan();
				hp.setProjectId(projectId);
				String planId = json.getString("historyPlanId");
				if(null != planId && !"".equals(planId)){
					hp.setHistoryPlanId(Long.parseLong(planId));
				}
				hp.setPhptypeId(request.getParameter("type"));//保存历史或者未来计划的类型，1为历史情况，2为未来计划
				hp.setPhpname(json.getString("phpname"));
				hp.setPhpstartYear(Integer.valueOf(json.getString("phpstartYear")));
				hp.setPhpstartMonth(Integer.valueOf(json.getString("phpstartMonth")));
				hp.setPhpendYear(Integer.valueOf(json.getString("phpendYear")));
				hp.setPhpendMonth(Integer.valueOf(json.getString("phpendMonth")));
				hp.setPhptargetDesc(json.getString("phptargetDesc"));
				hp.setPhptargetWay(json.getString("phptargetWay"));
				hp.setPhporderId(i++);
				hp.setIsDel(0);
				JSONArray subjsonArr = null;
				List<TcprojectHpPayments> listHpPayMent = new ArrayList<TcprojectHpPayments>();
				TcprojectHpPayments tcprojectHp = null;
				JSONObject subjson = null;
				if(json.getString("income").contains("[")){
					int order=1;
					subjsonArr = JSONArray.fromObject(json.getString("income"));
					for(Object subobj:subjsonArr){
						subjson = JSONObject.fromObject(subobj);
						createHppayment(order++,"1", tcprojectHp, projectId, subjson, listHpPayMent);
					}
				}
				if(json.getString("outcome").contains("[")){
					int order=1;
					subjsonArr = JSONArray.fromObject(json.getString("outcome"));
					for(Object subobj:subjsonArr){
						subjson = JSONObject.fromObject(subobj);
						createHppayment(order++,"2", tcprojectHp, projectId, subjson, listHpPayMent);
					}
				}
				hp.setListHpPayMent(listHpPayMent);
				tprojectFrontSaveService.saveTcprojectHistoryAndPlanInfo(hp);
			}
		}
		String url = "";
		if("2".equals(request.getParameter("next"))){
			url = "redirect:/crowdfunding/tcuserPersonalData/myAccount.ht?projectId="+request.getParameter("projectId");
		}else{//跳转到下一步
			if("2".equals(request.getParameter("type"))){//如果是未来计划页面跳转过来则是返回到项目展示页面
				url = "redirect:/crowdfunding/tcuserPersonalData/myAccount.ht?projectId="+request.getParameter("projectId");
			}else{//否则跳转到未来计划编辑页面
				url = "redirect:/crowdfunding/tcproject/editorhplans.ht?type=2&projectId="+request.getParameter("projectId");
			}
		}
		return new ModelAndView(url);
	}
	/**
	 * 组织阶段收支情况对象，并添加到阶段对象的收支list中去
	 * @param type
	 * @param tcprojectHp
	 * @param projectId
	 * @param json
	 * @param listHpPayMent
	 */
	private void createHppayment(int j,String type, TcprojectHpPayments tcprojectHp,Long projectId,JSONObject json,List<TcprojectHpPayments> listHpPayMent){
		tcprojectHp = new TcprojectHpPayments();
		tcprojectHp.setProjectId(projectId);
		tcprojectHp.setHpptypeId(type);
		tcprojectHp.setPaymentsId(json.getLong("paymentsId"));
		tcprojectHp.setHppkindName(json.getString("hppkindName"));
		tcprojectHp.setHpppayment(new BigDecimal(json.getString("hpppayment")));
		tcprojectHp.setHppremarks(json.getString("hppremarks"));
		tcprojectHp.setIsDel(0);
		tcprojectHp.setHpporderId(j);
		listHpPayMent.add(tcprojectHp);
	}
	
	@RequestMapping({ "editorpartners" })
	@Action( description = "去编辑项目团队成员信息" )
	public ModelAndView editorpartners(HttpServletRequest request, HttpServletResponse response) { 
		List<TcprojectTeam> listT = null;
		TcprojectTeam t1 = new TcprojectTeam();
		t1.setPttypeId(1);
		t1.setPtname("xx");
		t1.setPtduty("技术总监");
		t1.setPtmisFullTime(1);
		t1.setPttheShare(0);
		t1.setPtrealPay("0");
		t1.setPtrelationship("无");
		t1.setPtmemberInfo("无");
		
		if(StringUtil.isEmpty(request.getParameter("projectId"))){
			listT = new ArrayList<TcprojectTeam>();
			//增加默认值
			listT.add(t1);
			listT.add(t1);
		}else{
			listT = tcprojectTeamService.getByProId(Long.valueOf(request.getParameter("projectId")));
			for (TcprojectTeam t : listT) {
				if(t.getPttypeId()<=0){
					request.setAttribute("has", 1);
				}
			}
			//增加默认值
			if(null == listT || 0 == listT.size()){
				listT.add(t1);
				listT.add(t1);
			}
		}
		return new ModelAndView("/crowdfunding/front/tcproject/editorpartners.jsp").addObject("listT",listT).addObject("projectId", request.getParameter("projectId"));
	}
	@RequestMapping({ "savepartners" })
	@Action( description = "保存项目团队成员信息" )
	public ModelAndView savepartners(HttpServletRequest request, HttpServletResponse response) { 
		JSONArray jsonArr = JSONArray.fromObject(request.getParameter("datas"));
		Long projectId = Long.valueOf(request.getParameter("projectId"));
		TcprojectTeam tm = null;
		int i=1;
		for(Object obj:jsonArr){
			JSONObject json = JSONObject.fromObject(obj);
			if(!"".equals(json.getString("teamId"))){
				tm = new TcprojectTeam();
				tm.setProjectId(projectId);
				tm.setTeamId(json.getLong("teamId"));
				tm.setPttypeId(json.getInt("pttypeId"));
				tm.setPtname(json.getString("ptname"));
				tm.setPtduty(json.getString("ptduty"));
				tm.setPtmisFullTime(json.getInt("ptmisFullTime"));
				tm.setPttheShare(json.getInt("pttheShare"));
				tm.setPtrealPay(json.getString("ptrealPay"));
				tm.setPtrelationship(json.getString("ptrelationship"));
				tm.setPtmemberInfo(json.getString("ptmemberInfo"));
				tm.setPtentryTime(json.getString("ptentryTime"));
				tm.setPtorderId(i++);
				tm.setIsDel(0);
				tprojectFrontSaveService.saveTcprojectTeamInfo(tm);
			}
		}
		String url = "";
		if("2".equals(request.getParameter("next"))){
			url = "redirect:/crowdfunding/tcuserPersonalData/myAccount.ht?projectId="+request.getParameter("projectId");
		}else{//否则跳转到历史阶段编辑页面
			url = "redirect:/crowdfunding/tcproject/editorhplans.ht?type=1&projectId="+request.getParameter("projectId");
		}
		return new ModelAndView(url);
	}
	
	/**站点首页模糊查询项目，或者投资人*/
	@RequestMapping({"querywebinfos"})
	public Object queryTcprojectsOrInvestors(HttpServletRequest request,HttpServletResponse response) {
		
		String param = request.getParameter("paramValue");
		if(StringUtil.isEmpty(param)){
			
		}else{
			//分页加参数
			int page = RequestUtil.getInt(request, "current_page", 1);
			int pageSize = RequestUtil.getInt(request, "pageSize",5);
			PageBean pb=new  PageBean(page, pageSize);
			
			QueryFilter queryFilter = new QueryFilter(request);
			queryFilter.setPageBean(pb);
			queryFilter.addFilter("groupId", 2);  //投资人
			queryFilter.addFilter("likename", param);
					
			List<TUser> list = tuserService.getAll(queryFilter);
			
			request.setAttribute( "page_bean", pb );//分页参数传入页面
			request.setAttribute("investorList", list);
			
			
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("likepname",param);  
			
			List<Tcproject> ListVo=tcprojectService.getAllProByWhere(map,pb);
			request.setAttribute( "page_bean", pb );//分页参数传入页面
			request.setAttribute("ListVo", ListVo); 
		}
		request.setAttribute("paramNow", param);//查询参数前台展现
		return new ModelAndView("/crowdfunding/front/likeInvestorProList.jsp");
	}
}

