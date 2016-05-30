package com.deelon.loan.retention;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.asm.commons.Method;
import org.springframework.web.bind.annotation.support.HandlerMethodInvoker;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.fr.base.core.UUID;

public class AvoidDuplicateSubmissionInterceptor extends
		HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		// TODO Auto-generated method stub
		
		if(handler instanceof HandlerMethodInvoker){
			HandlerMethodInvoker hm=(HandlerMethodInvoker)handler;
			/*Object[] obj=hm.getClass().getMethods();
			for(Object o:obj){
				Method method=(Method)o;
			}*/
//			HandlerInterceptorAdapter hd=(HandlerInterceptorAdapter)handler;
			AvoidDuplicateSubmission annotation=hm.getClass().getAnnotation(AvoidDuplicateSubmission.class);
			if(annotation!=null){
				boolean needSaveToken =annotation.needSaveToken();
				if(needSaveToken){
					request.getSession().setAttribute("token", UUID.randomUUID().toString());
				}
				boolean needRemoveToken=annotation.needRemoveToken();
				if(needRemoveToken){
					if(isRepeatSubmit(request)){
						return false;
					}
					
					request.getSession(false).removeAttribute("token");
				}
			}
		}
		return true;
	}

	   private boolean isRepeatSubmit(HttpServletRequest request) {
	        String serverToken = (String) request.getSession(false).getAttribute("token");
	        if (serverToken == null) {
	            return true;
	        }
	        String clinetToken = request.getParameter("token");
	        if (clinetToken == null) {
	            return true;
	        }
	        if (!serverToken.equals(clinetToken)) {
	            return true;
	        }
	        return false;
	    }
	
	
	//static Map<String, String> springmvc_token = null;
    
		/*    //生成一个唯一值的token
		@SuppressWarnings("unchecked")
		public synchronized static String generateGUID(HttpSession session) {
		    String token = "";
		    try {
		        Object obj =  session.getAttribute("SPRINGMVC.TOKEN");
		        if(obj!=null)
		            springmvc_token = (Map<String,String>)session.getAttribute("SPRINGMVC.TOKEN");
		       else
		           springmvc_token = new HashMap<String, String>()
		        token = new BigInteger(165, new Random()).toString(36)
		                .toUpperCase();
		        springmvc_token.put(Constants.DEFAULT_TOKEN_NAME + "." + token,token);
		        session.setAttribute("SPRINGMVC.TOKEN", springmvc_token);
		        Constants.TOKEN_VALUE = token;
		
		    } catch (IllegalStateException e) {
		        logger.error("generateGUID() mothod find bug,by token session...");
		    }
		    return token;
		}
		 //验证表单token值和session中的token值是否一致
	    @SuppressWarnings("unchecked")
	    public static boolean validToken(HttpServletRequest request) {
	        String inputToken = getInputToken(request);
	 
	        if (inputToken == null) {
	            logger.warn("token is not valid!inputToken is NULL");
	            return false;
	        }
	 
	        HttpSession session = request.getSession();
	        Map<String, String> tokenMap = (Map<String, String>)           session.getAttribute("SPRINGMVC.TOKEN");
	        if (tokenMap == null || tokenMap.size() < 1) {
	            logger.warn("token is not valid!sessionToken is NULL");
	            return false;
	        }
	        String sessionToken = tokenMap.get(Constants.DEFAULT_TOKEN_NAME + "."
	                + inputToken);
	        if (!inputToken.equals(sessionToken)) {
	            logger.warn("token is not valid!inputToken='" + inputToken
	                    + "',sessionToken = '" + sessionToken + "'");
	            return false;
	        }
	        tokenMap.remove(Constants.DEFAULT_TOKEN_NAME + "." + inputToken);
	        session.setAttribute("SPRINGMVC.TOKEN", tokenMap);
	 
	        return true;
	    }
	    
	    //获取表单中token值
	    @SuppressWarnings("unchecked")
	    public static String getInputToken(HttpServletRequest request) {
	        Map params = request.getParameterMap();
	 
	        if (!params.containsKey(Constants.DEFAULT_TOKEN_NAME)) {
	            logger.warn("Could not find token name in params.");
	            return null;
	        }
	 
	        String[] tokens = (String[]) (String[]) params
	                .get(Constants.DEFAULT_TOKEN_NAME);
	 
	        if ((tokens == null) || (tokens.length < 1)) {
	            logger.warn("Got a null or empty token name.");
	            return null;
	        }
	 
	        return tokens[0];
	    }*/
	  
}
