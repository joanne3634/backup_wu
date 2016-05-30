package com.wuyouchou.crowdfunding.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContextHolder;

public class LoggedInUserOnlySecurityFilter implements Filter {

	private ListType listType = ListType.WHITELIST;

	private List<Pattern> urlList = new ArrayList<Pattern>();
	
	@Override
	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        // lets check if there is a user in here already
        Set<String> roles = AuthorityUtils.authorityListToSet(authentication.getAuthorities());
        if (roles.contains("ROLE_ANONYMOUS")) { // this is the ones used by the admin interface, skip straight away
        	// if it is whitelist, it means urls that does match
        	// will be allowed for non-loggedin users
        	// if it is blacklist, it means urls that does match,
        	// will not be allowed for non-loggedin users
        	// first match the url
        	// TODO: consider caching matches
        	String url = request.getRequestURI().substring(request.getContextPath().length());
        	Object user = request.getSession().getAttribute("user");
        	if ( null == user ) {
        		// if user not logged in, then we will check
        		Matcher matcher;
	        	for ( Pattern pattern : urlList ) {
	        		matcher = pattern.matcher(url);
	        		if ( matcher.matches() && this.listType.equals(ListType.BLACKLIST) ) {
	        			response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
	        			return;
	        		} else if ( matcher.matches() && this.listType.equals(ListType.WHITELIST)) {
	        			chain.doFilter(req, res);
	        			return;
	        		}
	        	}
	        	if ( this.listType.equals(ListType.WHITELIST) ) {
	        		// if this is a whitelist and nothing matches, this hsould be unauthorized
	        		response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
	        		return;
	        	}
        	}
        }

        chain.doFilter(req, res);

	}

	public enum ListType {
		WHITELIST,
		BLACKLIST
	}
	
	public void setListType(ListType listType) {
		this.listType = listType;
	}
	
	public ListType getListType() {
		return this.listType;
	}
	
	public void setFilterList(List<String> list) {
		for ( String filter : list ) {
			Pattern pattern = Pattern.compile(filter);
			urlList.add(pattern);
		}
	}
	
	public List<Pattern> getFilterList() {
		return this.urlList;
	}
	
	@Override
	public void destroy() {
		
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		
	}

}
