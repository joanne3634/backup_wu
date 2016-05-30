package com.deelon.loan.service.backstage;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.loan.dao.backstage.TSettingsDao;
import com.deelon.loan.model.backstage.TSettings;

/**
 * 系统参数设置类
 * 
 * @author deelon.hejian
 * 
 */
@Service
public class TSettingsService extends BaseService<TSettings>{
	
	protected IEntityDao<TSettings, Long> getEntityDao()
	{
		return this.settingsDao;
	}

	@Resource
	private TSettingsDao settingsDao;

	/**
	 * 添加系统参数
	 * 
	 * @param settings
	 *            参数设置对象
	 */
	public void addSettings(TSettings settings) {
		settingsDao.saveSettings(settings);
	}

	public void updateSettings(TSettings settings) {
		settingsDao.updateSettings(settings);
	}

	public List<TSettings> listConst() {
		return settingsDao.getSettingsByColumn("TypeID", 1);
	}
	
	public List<TSettings> listTariff() {
		return settingsDao.getSettingsByColumn("TypeID", 2);
	}
	
	/**
	 * 根据设置代码查询记录
	 * @param setCode
	 * @return
	 */
	public TSettings getTSettingsBySetCode(String setCode){
		return settingsDao.getTSettingsBySetCode(setCode);
	}
	
	public void updatePaiXu(TSettings settings) {
		settingsDao.updatePaiXu(settings);
	}

}
