package com.deelon.loan.service.aboutus;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.cmsform.model.site.CmsSiteConfig;
import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.loan.dao.aboutus.TUserMessageDao;
import com.deelon.loan.model.aboutus.TUserMessage;

@ Service
public class TUserMessageService extends BaseService<TUserMessage> {
	
	@Resource
	private TUserMessageDao tusermessagedao;
	
	protected IEntityDao<TUserMessage, Long> getEntityDao()
	{
		return this.tusermessagedao;
	}
	public void add(TUserMessage entity) {
		tusermessagedao.add(entity);
	}
	public TUserMessage getById(long messageid){
		return tusermessagedao.getById(messageid);
	}
	public void update(TUserMessage entity){
		tusermessagedao.update(entity);
	}
	public List<TUserMessage>   getAll() {
		return tusermessagedao.getAll();
	}
	public List<TUserMessage>   getMessageUserId(int userid) {
		return tusermessagedao.getUserId(userid);
	}
	public void del(long messageid){
		tusermessagedao.delById(messageid);
	}
}
