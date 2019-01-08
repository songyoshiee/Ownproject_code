package com.watchers.common.session.manager;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.watchers.business.login.model.UserVo;
import com.watchers.common.constant.FrameworkConst;

@Component
public class SessionLoginUtil {
	
    public static String getClientIp() {
        ServletRequestAttributes sra = (ServletRequestAttributes)RequestContextHolder.currentRequestAttributes();
        String clientIp = sra.getRequest().getHeader("X-Forwarded-For");
        if (clientIp != null && clientIp.trim().length() != 0 && !"unknown".equalsIgnoreCase(clientIp)) {
            return clientIp;
        }
        clientIp = sra.getRequest().getHeader("Proxy-Client-IP");
        if (clientIp != null && clientIp.trim().length() != 0 && !"unknown".equalsIgnoreCase(clientIp)) {
            return clientIp;
        }
        clientIp = sra.getRequest().getHeader("HTTP_CLIENT_IP");
        if (clientIp != null && clientIp.trim().length() != 0 && !"unknown".equalsIgnoreCase(clientIp)) {
            return clientIp;
        }
        clientIp = sra.getRequest().getHeader("HTTP_X_FORWARDED_FOR");
        if (clientIp != null && clientIp.trim().length() != 0 && !"unknown".equalsIgnoreCase(clientIp)) {
            return clientIp;
        }
        clientIp = sra.getRequest().getHeader("REMOTE_ADDR");
        if (clientIp != null && clientIp.trim().length() != 0 && !"unknown".equalsIgnoreCase(clientIp)) {
            return clientIp;
        }
        clientIp = sra.getRequest().getRemoteAddr();
        return clientIp;
    }

    public static HttpSession getCurrentSession() {
        ServletRequestAttributes sra = (ServletRequestAttributes)RequestContextHolder.currentRequestAttributes();
        return sra.getRequest().getSession(false);
    }

    public static UserVo getLoginUser() {
        HttpSession session = SessionLoginUtil.getCurrentSession();
        if (session != null) {
            return (UserVo)session.getAttribute(FrameworkConst.LOGIN_USER);
        }
        return null;
    }

    public static String getCurrentSessionId() {
        HttpSession session = SessionLoginUtil.getCurrentSession();
        if (session != null) {
            return session.getId();
        }
        return null;
    }

    public static String getLoginUserId() {
        UserVo loginUser = SessionLoginUtil.getLoginUser();
        if (loginUser != null) {
            return loginUser.getUser_id();
        }
        return null;
    }
    
    public static boolean procLogout(){
    	
    	UserVo loginUser = getLoginUser();
    	if(loginUser != null){
			// 로그아웃 정보 로깅
			// AuthUtil.regLogoutInfo(loginUser);
		}
    	
		// 세션 폐기
    	HttpSession session = getCurrentSession();
    	if(session != null){
    		session.invalidate();
    	}
		
    	return true;
    }
}
