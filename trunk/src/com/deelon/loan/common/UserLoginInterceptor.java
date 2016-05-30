package com.deelon.loan.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.deelon.loan.model.front.TUser;

public class UserLoginInterceptor implements HandlerInterceptor {
	private String mappingURL;//利用正则映射到需要拦截的路径    
    public void setMappingURL(String mappingURL) {    
           this.mappingURL = mappingURL;    
    }   
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub  
	}

	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		// TODO Auto-generated method stub  
	}

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object arg2) throws Exception {
		// TODO Auto-generated method stub  
        TUser user=(TUser)request.getSession().getAttribute("user");
		if(null==user){  
			//String script ="<script>window.('"+ request.getContextPath()+"/loginWeb.jsp');</script>";
         //   response.getWriter().write(script);
			request.getSession().setAttribute("loginPreUrl", request.getRequestURI()+(null==request.getQueryString()? "":"?"+request.getQueryString()));
            response.sendRedirect(request.getContextPath()+ "/loginWeb.jsp"); 
            return false;   
        }    
        return true;  
	} 

}
