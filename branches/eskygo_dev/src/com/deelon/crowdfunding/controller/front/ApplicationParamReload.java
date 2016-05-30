package com.deelon.crowdfunding.controller.front;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.deelon.core.util.AppUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.loan.model.backstage.TSettings;
import com.deelon.loan.service.backstage.TSettingsService;

@ Controller
@ RequestMapping({"/application/"})
public class ApplicationParamReload extends BaseController{
	/**刷新系统设置的信息*/
	@RequestMapping({"paramfresh"})
	@ResponseBody
	public Object paramRefresh(HttpServletRequest request,HttpServletResponse response) {
		TSettingsService tsettingsService=(TSettingsService)AppUtil.getBean(TSettingsService.class);
		List<TSettings> settings = tsettingsService.getAll();
		for (TSettings s : settings) {
			try {
				AppUtil.getServletContext().setAttribute(s.getSetCode(),s.getSetValue());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}
}
