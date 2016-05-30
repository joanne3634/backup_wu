package com.deelon.loan.util;

import java.util.List;
import java.util.Locale;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.activiti.engine.impl.persistence.deploy.DeploymentCache;
import org.apache.log4j.MDC;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.support.AbstractMessageSource;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

import com.deelon.core.cache.ICache;
import com.deelon.core.util.AppConfigUtil;
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.BeanUtils;
import com.deelon.core.util.StringUtil;
import com.deelon.core.web.tag.AnchorTag;
import com.deelon.core.web.util.CookieUitl;
import com.deelon.core.web.util.RequestUtil;
import com.deelon.platform.model.system.Position;
import com.deelon.platform.model.system.SysOrg;
import com.deelon.platform.model.system.SysUser;
import com.deelon.platform.service.bpm.thread.MessageUtil;
import com.deelon.platform.service.bpm.thread.TaskThreadService;
import com.deelon.platform.service.bpm.thread.TaskUserAssignService;
import com.deelon.platform.service.system.PositionService;
import com.deelon.platform.service.system.SysOrgService;
import com.deelon.platform.service.system.SysPaurService;
import com.deelon.platform.service.system.SysUserService;
/**
 * @preserve public 
 */
public class ContextUtil
{
  private static Logger logger = LoggerFactory.getLogger(ContextUtil.class);
  private static ThreadLocal<String> curUserAccount = new ThreadLocal();
  private static ThreadLocal<SysUser> curUser = new ThreadLocal();
 // private static ThreadLocal<TUser> c_tuser = new ThreadLocal();
  private static ThreadLocal<Locale> curLocale = new ThreadLocal();
  private static ThreadLocal<SysOrg> curOrg = new ThreadLocal();
  public static final String CurrentOrg = "CurrentOrg_";
  private static Integer _connTimeout = Integer.valueOf(0);
  private static Integer _readTimeout = Integer.valueOf(0);
  
  public static Integer getConnectTimeout()
  {
    if (_connTimeout.intValue() == 0)
    {
      _connTimeout = Integer.valueOf(Integer.parseInt(AppConfigUtil.get("webservice.connTimeout")));
      if (_connTimeout.intValue() == 0) {
        _connTimeout = Integer.valueOf(3000);
      }
    }
    return _connTimeout;
  }
  
  public static Integer getReadTimeout()
  {
    if (_readTimeout.intValue() == 0)
    {
      _readTimeout = Integer.valueOf(Integer.parseInt(AppConfigUtil.get("webservice.readTimeout")));
      if (_readTimeout.intValue() == 0) {
        _readTimeout = Integer.valueOf(3000);
      }
    }
    return _readTimeout;
  }
  
  
  
/*  *//**
   * 网贷前端 登录用户
   * @return
   *//*
  public static TUser getCurrentTUser(HttpServletRequest request,String key){
	  TUser u=(TUser)request.getSession().getAttribute(key);
	  return u;
  }
  */
  
  
  public static SysUser getCurrentUser()
  {
    if (curUser.get() != null)
    {
      SysUser user = (SysUser)curUser.get();
      return user;
    }
    SysUser sysUser = null;
    SecurityContext securityContext = SecurityContextHolder.getContext();
    if (securityContext != null)
    {
      Authentication auth = securityContext.getAuthentication();
      if (auth != null)
      {
        Object principal = auth.getPrincipal();
        if ((principal instanceof SysUser))
        {
          sysUser = (SysUser)principal;
          setLog4jMDC(sysUser);
        }
      }
    }
    return sysUser;
  }
  
  /**
   * 获取当前登录用户所在的公司id
   * @return
   */
  public static long getOrgId(){
	  SysOrgService sysOrgService = (SysOrgService)AppUtil.getBean("sysOrgService");
	  SysUser curUser = getCurrentUser();
	    if (curUser != null) {
	    	 List<SysOrg> orgList=sysOrgService.getByUserId(curUser.getUserId() );
	    	 if(orgList!=null&&orgList.size()>0){
	   		  for(int i=0;i<orgList.size();i++){
	   			  SysOrg o=(SysOrg)orgList.get( i );
	   			  if(o.getIsPrimary()==1){//主组织
	   				 return o.getOrgId();
	   			  }
	   		  }
	   	  }
	     
	    }
	    return Long.valueOf(0L);
  }
  
  public static Position getCurrentPos()
  {
    SysUser curUser = getCurrentUser();
    PositionService positionService = (PositionService)AppUtil.getBean("positionService");
    List<Position> positions = positionService.getByUserId(curUser.getUserId());
    if (BeanUtils.isNotEmpty(positions))
    {
      Position posMain = null;
      for (Position pos : positions) {
        if (pos.getIsPrimary().shortValue() == 1)
        {
          posMain = pos;
          return posMain;
        }
      }
      if (posMain == null) {
        return (Position)positions.get(0);
      }
    }
    return null;
  }
  
  public static Locale getLocale()
  {
    if (curLocale.get() != null) {
      return (Locale)curLocale.get();
    }
    setLocale(new Locale("zh", "CN"));
    return (Locale)curLocale.get();
  }
  
  public static void setLocale(Locale locale)
  {
    curLocale.set(locale);
  }
  
  public static Long getCurrentUserId()
  {
    SysUser curUser = getCurrentUser();
    if (curUser != null) {
      return curUser.getUserId();
    }
    return Long.valueOf(0L);
  }
  
  public static void setCurrentUserAccount(String account)
  {
    SysUserService sysUserService = (SysUserService)AppUtil.getBean("sysUserService");
    SysUser sysUser = sysUserService.getByAccount(account);
    curUser.set(sysUser);
    setLog4jMDC(sysUser);
  }
  
  public static void setCurrentUser(SysUser sysUser)
  {
    curUser.set(sysUser);
    setLog4jMDC(sysUser);
  }
  
/*  private static void setLog4jMDC(TUser tuser){
	  if(tuser!=null){
		  MDC.put("current_user_id", tuser.getUserId());
	      MDC.put("current_user_realName", tuser.getRealName());
	      MDC.put("current_user_loginName", tuser.getLoginName());
	      MDC.put("current_user_groupId", tuser.getGroupID());
	  }
  }*/
  
  private static void setLog4jMDC(SysUser user)
  {
    if (user != null)
    {
      MDC.put("current_user_id", user.getUserId());
      MDC.put("current_user_name", user.getFullname());
      MDC.put("current_user_account", user.getAccount());
    }
  }
  
  public static void setCurrentOrg(Long orgId)
  {
    SysOrgService sysOrgService = (SysOrgService)AppUtil.getBean("sysOrgService");
    SysOrg sysOrg = (SysOrg)sysOrgService.getById(orgId);
    HttpServletRequest request = RequestUtil.getHttpServletRequest();
    HttpServletResponse response = RequestUtil.getHttpServletResponse();
    HttpSession session = request.getSession();
    saveSessionCookie(sysOrg, request, response, session);
  }
  
  public static void getCurrentOrgFromSession()
  {
    HttpServletRequest request = RequestUtil.getHttpServletRequest();
    HttpServletResponse response = RequestUtil.getHttpServletResponse();
    SysOrg sysOrg = null;
    HttpSession session = request.getSession();
    if (request != null) {
      sysOrg = (SysOrg)session.getAttribute("CurrentOrg_");
    }
    Long userId = getCurrentUserId();
    if (sysOrg == null)
    {
      SysOrgService sysOrgService = (SysOrgService)AppUtil.getBean("sysOrgService");
      
      String currentOrgId = CookieUitl.getValueByName("CurrentOrg_", request);
      if (StringUtil.isEmpty(currentOrgId))
      {
        sysOrg = sysOrgService.getDefaultOrgByUserId(userId);
      }
      else
      {
        Long orgId = Long.valueOf(Long.parseLong(currentOrgId));
        sysOrg = (SysOrg)sysOrgService.getById(orgId);
      }
      if (sysOrg != null) {
        saveSessionCookie(sysOrg, request, response, session);
      }
    }
    if (sysOrg != null) {
      setCurrentOrg(sysOrg);
    }
  }
  
  public static void setDefaultOrg()
  {
    HttpServletRequest request = RequestUtil.getHttpServletRequest();
    HttpServletResponse response = RequestUtil.getHttpServletResponse();
    
    HttpSession session = null;
    if (request != null)
    {
      session = request.getSession();
      session.removeAttribute("CurrentOrg_");
    }
    CookieUitl.delCookie("CurrentOrg_", request, response);
    SysOrgService sysOrgService = (SysOrgService)AppUtil.getBean("sysOrgService");
    Long userId = getCurrentUserId();
    SysOrg sysOrg = sysOrgService.getDefaultOrgByUserId(userId);
    if (sysOrg != null)
    {
      saveSessionCookie(sysOrg, request, response, session);
      setCurrentOrg(sysOrg);
    }
  }
  
  public static SysOrg getCurrentOrg()
  {
    SysOrg sysOrg = null;
    Long userId = getCurrentUserId();
    if (userId.longValue() > 0L)
    {
      ICache iCache = (ICache)AppUtil.getBean(ICache.class);
      String userKey = "CurrentOrg_" + userId;
      sysOrg = (SysOrg)iCache.getByKey(userKey);
    }
    if (sysOrg == null) {
      sysOrg = (SysOrg)curOrg.get();
    }
    return sysOrg;
  }
  
  public static Long getCurrentOrgId()
  {
    SysOrg sysOrg = getCurrentOrg();
    if (sysOrg != null) {
      return sysOrg.getOrgId();
    }
    return null;
  }
  
  public static String getCurrentUserSkin(HttpServletRequest request)
  {
    String skinStyle = "default";
    
    HttpSession session = request.getSession();
    String skin = (String)session.getAttribute("skinStyle");
    if (StringUtil.isNotEmpty(skin)) {
      return skin;
    }
    SysPaurService sysPaurService = (SysPaurService)AppUtil.getBean("sysPaurService");
    Long userId = getCurrentUserId();
    skinStyle = sysPaurService.getCurrentUserSkin(userId);
    session.setAttribute("skinStyle", skinStyle);
    return skinStyle;
  }
  
  public static void setCurrentOrg(SysOrg sysOrg)
  {
    if (sysOrg == null) {
      return;
    }
    curOrg.set(sysOrg);
  }
  
  public static void cleanCurrentOrg()
  {
    curOrg.remove();
  }
  
  public static void cleanCurUser()
  {
    curUser.remove();
  }
  
  private static void saveSessionCookie(SysOrg sysOrg, HttpServletRequest request, HttpServletResponse response, HttpSession session)
  {
    session.setAttribute("CurrentOrg_", sysOrg);
    
    Long orgId = sysOrg.getOrgId();
    
    CookieUitl.addCookie("CurrentOrg_", orgId.toString(), request, response);
    
    Long userId = getCurrentUserId();
    

    ICache iCache = (ICache)AppUtil.getBean(ICache.class);
    String userKey = "CurrentOrg_" + userId;
    iCache.add(userKey, sysOrg);
  }
  
  public static void removeCurrentOrg(HttpServletRequest request, HttpServletResponse response)
  {
    HttpSession session = request.getSession(false);
    if (session != null) {
      session.removeAttribute("CurrentOrg_");
    }
    CookieUitl.delCookie("CurrentOrg_", request, response);
    Long userId = getCurrentUserId();
    ICache iCache = (ICache)AppUtil.getBean(ICache.class);
    String userKey = "CurrentOrg_" + userId;
    iCache.delByKey(userKey);
  }
  
  public static void clearAll()
  {
    curUser.remove();
    curOrg.remove();
    curLocale.remove();
    
    RequestUtil.clearHttpReqResponse();
    TaskThreadService.clearAll();
    TaskUserAssignService.clearAll();
    MessageUtil.clean();
    
    DeploymentCache.clearProcessDefinitionEntity();
    SysUser.removeRoleList();
    
    AnchorTag.cleanFuncRights();
  }
  
  public static void removeCurrentUser()
  {
    curUserAccount.remove();
  }
  
  public static String getMessages(String code)
  {
    return getMessages(code, null);
  }
  
  public static String getMessagesL(String code, Locale locale)
  {
    return getMessages(code, null, locale);
  }
  
  public static String getMessages(String code, Object[] args, Locale locale)
  {
    AbstractMessageSource messages = (AbstractMessageSource)AppUtil.getBean("messageSource");
    if (locale == null) {
      locale = getLocale();
    }
    return messages.getMessage(code, args, locale);
  }
  
  public static String getMessages(String code, Object[] args)
  {
    return getMessages(code, args, getLocale());
  }
  
  public static String getPropertyByName(String propertyName)
  {
    Properties configproperties = (Properties)AppUtil.getBean("configproperties");
    String propertyValue = configproperties.getProperty(propertyName);
    if (StringUtil.isEmpty(propertyValue)) {
    	propertyValue = "";
    }
    return propertyValue;
  }
}
