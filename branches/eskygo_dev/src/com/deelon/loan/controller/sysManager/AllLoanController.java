package com.deelon.loan.controller.sysManager;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.service.sysManager.TprojectService;
@Controller
@RequestMapping({"/loan/sysManager/allLoan/"})
public class AllLoanController extends BaseController {
	@Resource
	private TprojectService tprojectService;
	
	@Action(description="所有借款")
	@RequestMapping({"list"})
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response){
		
		try {
			QueryFilter queryFileter=new QueryFilter(request,"projectId");
			 Map<String,Object> map=queryFileter.getFilters();
				String endDate=(String)map.get("endDate");
				if(StringUtil.isNotEmpty(endDate)){
					queryFileter.addFilter("endDate", endDate+" 23:59:59");
				}
				String beginDate=(String)map.get("beginDate");
				if(StringUtil.isNotEmpty(beginDate)){
					queryFileter.addFilter("beginDate", beginDate+" 00:00:00");
				}
			
			
			List<TProject> listVo=tprojectService.getAllLoan(queryFileter);
			if(listVo!=null&&listVo.size()>0){
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
				for (TProject t : listVo) {
					if(t.getPapplicationTime()!=null){
						t.setAppleyTime(sdf.format(t.getPapplicationTime()));
					}
					if(t.getPhavedPayTime()!=null){
						t.setHavedPayTimeStr(sdf.format(t.getPhavedPayTime()));
					}
				}
			}
			return getAutoView().addObject("ListVo", listVo);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return null;
	}

}
