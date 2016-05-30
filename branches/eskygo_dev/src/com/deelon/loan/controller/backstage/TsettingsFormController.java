/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.loan.controller.backstage;

import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.deelon.core.annotion.Action;
import com.deelon.core.annotion.ActionExecOrder;
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.ResultMessage;
import com.deelon.core.web.controller.BaseFormController;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.loan.model.backstage.TSettings;
import com.deelon.loan.service.backstage.TSettingsService;
import com.deelon.platform.model.system.SysAuditModelType;

@Controller
@RequestMapping({ "/loan/backstage/tsettings/" })
public class TsettingsFormController extends BaseFormController {

	@Resource
	private TSettingsService tsettingsService;

	@RequestMapping({ "save" })
	@Action(description = "添加或更新Tsettings" )
	public void save(HttpServletRequest request, HttpServletResponse response,
			TSettings tsettings, BindingResult bindResult) throws Exception {
		String preUrl = RequestUtil.getPrePage( request );
		ResultMessage resultMessage = validForm("tsettings", tsettings,
				bindResult, request);
		if (resultMessage.getResult() == 0) {
			writeResultMessage(response.getWriter(), resultMessage);
			return;
		}
		String logo = tsettings.getSetValue();
		if (StringUtils.startsWith(logo, request.getContextPath())) {
			tsettings.setSetValue(logo.replaceFirst(request.getContextPath(), ""));
		}
		String resultMsg = null;
		if (tsettings.getSettingsId() == null) {
			tsettings.setSettingsId(Long.valueOf(UniqueIdUtil.genId()));
			this.tsettingsService.add(tsettings);
			resultMsg = getText("record.added", new Object[] { "数据" });
			writeResultMessage(response.getWriter(), resultMsg, 1);
		} else {
			this.tsettingsService.update(tsettings);
			resultMsg = getText("record.updated", new Object[] { "数据" });
			writeResultMessage(response.getWriter(), resultMsg, 1);
		}
		AppUtil.getServletContext().setAttribute(tsettings.getSetCode(),tsettings.getSetValue());
		try{
			URL url = new URL((String)AppUtil.getServletContext().getAttribute("WEB-SITE-URL")+"/application/paramfresh.ht");
			URLConnection rulConnection = url.openConnection();// 此处的urlConnection对象实际上是根据URL的
			HttpURLConnection httpUrlConnection = (HttpURLConnection) rulConnection;
			httpUrlConnection.connect();
			httpUrlConnection.getInputStream();
			httpUrlConnection.disconnect();
		}catch(Exception e){
			throw new RuntimeException(e.getCause());
		}
		
		response.sendRedirect(preUrl);
	}

	@ModelAttribute
	protected TSettings getFormObject(
			@RequestParam("settingsId") Long settingsId, Model model)
			throws Exception {
		this.logger.debug("enter Tsettings getFormObject here....");
		TSettings tsettings = null;
		if (settingsId != null)
			tsettings = (TSettings) this.tsettingsService.getById(settingsId);
		else {
			tsettings = new TSettings();
		}
		return tsettings;
	}
}
