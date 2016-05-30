package com.deelon.platform.service.system;


import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.platform.dao.system.SysErrorLogDao;
import com.deelon.platform.model.system.SysErrorLog;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class SysErrorLogService
        extends BaseService<SysErrorLog>
{

    @Resource
    private SysErrorLogDao dao;

    protected IEntityDao<SysErrorLog, Long> getEntityDao()
    {
        return this.dao;
    }
    public Long addError(String account, String ip, String error, String errorUrl)
    {
        //System.out.println("-------replace ----addError()----"+account+ip+error+errorUrl);
        logger.error("error: url={},stackTrace={}",errorUrl,error);
        return null;
    }
    public void add(SysErrorLog var1) {
        //System.out.println("--------repalce ----add()------");
        logger.error("error: url={},stackTrace={}",var1.getErrorurl(),var1.getError());
   }
}
