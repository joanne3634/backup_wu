package com.deelon.loan.controller.myAccount;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.core.annotion.Action;
import com.deelon.core.page.PageBean;
import com.deelon.core.web.controller.BaseController;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.service.sysManager.TprojectService;

@Controller
@RequestMapping({"/loan/myAccount/"})
public class IFocusOnBorrowingController extends BaseController {
	 
	@Resource
	private TprojectService tprojectService;
	
	@Action(description="到我关注的借款页面")
	@RequestMapping({"toIFocusBorrow"})
	public ModelAndView toIFocusBorrow(HttpServletRequest request,HttpServletResponse response,TProject tp){
		int page = RequestUtil.getInt(request, "current_page", 1);
		int pageSize = RequestUtil.getInt(request, "pageSize",PageBean.getDefaultPageSize().intValue());
		PageBean pb=new  PageBean(page, pageSize);
		request.setAttribute( "page_bean", pb );//分页参数传入页面
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
		TUser u=(TUser)request.getSession().getAttribute("user");
		tp.setUserId(u.getUserId());
		List<TProject> listVo=tprojectService.getUserFocusBorrowOnTpro(tp,pb);
		if(listVo!=null&&listVo.size()>0){
			for (TProject t : listVo) {
				if(t.getPcloseDate()!=null){
					int timess=(int)(t.getPcloseDate().getTime()-System.currentTimeMillis());
					t.setTimeRemaining(getTime(timess));
					t.setPopenDateStr(sdf.format(t.getPopenDate()));
//					t.setPcloaseDateStr(sdf.format(t.getPcloseDate()));
				}
			}
		}
		String beginDateS="";
		String endDateS="";
		if(tp!=null){
			SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
			if(tp.getBeginDate()!=null){
				 beginDateS=sdf1.format(tp.getBeginDate());
			}
			if(tp.getEndDate()!=null){
				 endDateS=sdf1.format(tp.getEndDate());
			}
		}
		
		
		return new ModelAndView("/loan/myAccount/ifocusOnBorrowing.jsp").addObject("ListVo", listVo).addObject("beginDateS", beginDateS).addObject("endDateS", endDateS);
	}
	
	
	
	 public String getTime(int time){

		 int theDay,theHour,theMinutes;
		 theDay = 24*60*60*1000;//一天
		 theHour = 60*60*1000; //一小时
		 theMinutes = 60*1000; //一分钟

		 int nowTime = 0; //当前的总秒数

		 //现在的天数，小时，分，秒
		 int nowDay = 0, nowHour = 0, nowMinutes = 0, nowSenconds = 0;
		 StringBuffer sb = new StringBuffer();

		 if (time-theDay>=0)//显示：天，小时
		 {
		 nowDay = time/theDay;
		 nowTime = time%theDay;

		 if(nowTime-theHour>=0)
		 nowHour = nowTime/theHour;
		 else
		 theHour =0;

		 sb.append(nowDay + "天");
		 sb.append(nowHour + "小时");
		 }

		 else if(time-theHour>=0){//显示：小时，分钟
		 nowHour = time/theHour;
		 nowTime = time%theHour;
		 if(nowTime - theMinutes>=0)
		 nowMinutes = nowTime/theMinutes;
		 else
		 nowMinutes = 0;
		 sb.append(nowHour + "小时");
		 sb.append(nowMinutes + "分钟");

		 }
		 else if(time-theHour< 0 && time - theMinutes>=0){//显示：分钟
		 nowMinutes = time/theMinutes;
		 sb.append("0小时"+ nowMinutes + "分");
		 }
		 else{
		nowSenconds = time;

		// sb.append("0分" + nowSenconds*1000 + "秒");
			sb.append("已过期");
		 }


		 return sb.toString();
	}

}
