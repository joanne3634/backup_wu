package com.deelon.loan.common;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;

import org.springframework.web.context.ContextLoaderListener;

import com.deelon.core.util.AppUtil;
import com.deelon.loan.model.backstage.TSettings;
import com.deelon.loan.service.backstage.TSettingsService;

public class ApplicationInit extends ContextLoaderListener {
	private ServletContext context = null;

	
	public void contextInitialized(ServletContextEvent event) {

		TSettingsService tsettingsService=(TSettingsService)AppUtil.getBean(TSettingsService.class);
		List<TSettings> settings = tsettingsService.getAll();
		for (TSettings s : settings) {
			try {
				event.getServletContext().setAttribute(s.getSetCode(),s.getSetValue());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public void contextDestroyed(ServletContextEvent event) {
		this.context = null;
	}
}