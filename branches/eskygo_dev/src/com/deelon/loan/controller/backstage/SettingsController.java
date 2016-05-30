package com.deelon.loan.controller.backstage;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.loan.dao.front.TmoneymoveDao;
import com.deelon.loan.model.backstage.TSettings;
import com.deelon.loan.model.front.TMoneymove;
import com.deelon.loan.service.backstage.TSettingsService;
import com.deelon.loan.service.front.TmoneymoveService;

/**
 * 系统参数设置控制器
 * 
 * @author deelon.hejian
 * 
 */
@Controller
@RequestMapping({ "/settings/" })
public class SettingsController {

	@Autowired
	private TSettingsService settingsService;
	@ Resource
	private TmoneymoveDao tmoneymoveDao;
	
	@RequestMapping({ "addSettings" })
	public ModelAndView addSettings(TSettings settings) {
		settingsService.addSettings(settings);
		return new ModelAndView();
	}

	@RequestMapping({ "listConst" })
	public ModelAndView listConst(HttpServletRequest request) {
		List<TSettings> constSettings = settingsService.listConst();
		request.setAttribute("constSettings", constSettings);
		return new ModelAndView("loan/backstage/constSettings.jsp");
	}

	@RequestMapping({ "listTariff" })
	public ModelAndView listTariff(HttpServletRequest request) {
		List<TSettings> tariffSettings = settingsService.listTariff();
		request.setAttribute("tariffSettings", tariffSettings);
		return new ModelAndView("loan/backstage/tariffSetting.jsp");
	}

	/**
	 * 保存系统常量参数
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping({ "submitConstSettings" })
	public ModelAndView submitConstSettings(HttpServletRequest request) {
		String[] settingNames = request.getParameterValues("settingName");
		String[] settingValues = request.getParameterValues("setting");
		String[] settingsIds = request.getParameterValues("settingsId");
		for (int i = 0; i < settingValues.length; i++) {
			TSettings setting = new TSettings();
			setting.setSetCode(settingNames[i]);
			setting.setTypeId(1);
			setting.setSetValue(settingValues[i]);
			setting.setSettingsId(Long.parseLong(settingsIds[i]));
			settingsService.updateSettings(setting);
		}
		return new ModelAndView("redirect:/settings/listConst.ht");
	}

	/**
	 * 保存收费参数
	 * 
	 * @return
	 */
	@RequestMapping({ "submitTariffSettings" })
	public ModelAndView submitTariffSettings(HttpServletRequest request) {
		String[] settingNames = request.getParameterValues("settingName");
		String[] settingValues = request.getParameterValues("setting");
		String[] settingsIds = request.getParameterValues("settingsId");
		for (int i = 0; i < settingValues.length; i++) {
			TSettings setting = new TSettings();
			setting.setSetCode(settingNames[i]);
			setting.setTypeId(2);
			setting.setSetValue(settingValues[i]);
			setting.setSettingsId(Long.parseLong(settingsIds[i]));
			settingsService.updateSettings(setting);
		}
		return new ModelAndView("redirect:/settings/listTariff.ht");
	}
	
	/**
	 * 平台收益的后台数据展现
	 * @param request
	 * @return
	 */
	@RequestMapping({ "platforBenifits" })
	public ModelAndView platforBenifits(HttpServletRequest request){
		List<TMoneymove> moneys =  tmoneymoveDao.getBySqlKey("getPlatformSum");
		request.setAttribute("benifits", moneys);
		return new ModelAndView("loan/backstage/platforBenifits.jsp");
	}
}
