package com.deelon.loan.dao.backstage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.loan.model.backstage.TSettings;

/**
 * 系统参数数据库操作
 * 
 * @author deelon.hejian
 * 
 */
@Repository
public class TSettingsDao extends BaseDao<TSettings> {

	@Override
	public Class<TSettings> getEntityClass() {
		return TSettings.class;
	}

	public long saveSettings(TSettings settings) {
		insert("insertSettings", settings);
		return settings.getSettingsId();
	}

	public void updateSettings(TSettings settings) {
		update("updateSettings", settings);
	}

	public List<TSettings> getAllSettings() {
		return getBySqlKey("getSettings");
	}

	public List<TSettings> getSettingsByColumn(String columnName,
			Object columnValue) {
		Map<String, Object> column = new HashMap<String, Object>();
		column.put("columnName", columnName);
		column.put("columnValue", columnValue);
		return getBySqlKey("getSettingsByColumn", column);
	}
	
	
	public TSettings getTSettingsBySetCode(String setCode){
		return getUnique("getsettingsBySetCode", setCode);
	}
	
	public void updatePaiXu(TSettings settings) {
		update("updatePaiXu", settings);
	}
	
}
