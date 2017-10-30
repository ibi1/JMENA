package kr.co.jmena.www.common.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Service
public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger  =  Logger.getLogger(LoginCheckInterceptor.class);
 
	public LoginCheckInterceptor() { }

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
        logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@test");
        if (session == null || session.getAttribute("userId")==null) {
        	 logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@inner");
            response.sendRedirect("/");
            return false;
        }
        
        
        return true;
	}
}