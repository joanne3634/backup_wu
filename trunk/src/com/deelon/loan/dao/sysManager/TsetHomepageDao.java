/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.loan.dao.sysManager;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.deelon.core.db.BaseDao;
import com.deelon.core.util.StringUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.query.QueryFilter;
import com.deelon.loan.model.sysManager.TSetHomepage;

@Repository
public class TsetHomepageDao extends BaseDao<TSetHomepage> {

	public Class getEntityClass() {
		return TSetHomepage.class;
	}

	public List<TSetHomepage> getTSetHomepageByQuery(QueryFilter queryFilter) {

		return getBySqlKey("getAll", queryFilter);
	}

	public TSetHomepage getTSetHomepageById(String id) {
		// Long ids=Long.valueOf(id);
		return getUnique("getById", id);
	}

	public void saveOrUpTSetHomepage(TSetHomepage tSetHomepage) {
		if (tSetHomepage != null && tSetHomepage.getHomePageId() != null) {

			update("update", tSetHomepage);
		} else if (tSetHomepage != null && tSetHomepage.getHomePageId() == null) {
			tSetHomepage.setHomePageId(UniqueIdUtil.genId());
			update("add", tSetHomepage);
		}
	}

	public void delTSetHomepageById(Long id) {
		delBySqlKey("delById", id);
	}
}
