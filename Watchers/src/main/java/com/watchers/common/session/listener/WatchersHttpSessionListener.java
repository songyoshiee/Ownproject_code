package com.watchers.common.session.listener;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.watchers.common.constant.FrameworkConst;
import com.watchers.common.mstdata.util.SystemPropsUtil;

public class WatchersHttpSessionListener implements HttpSessionListener {
    Logger logger = LoggerFactory.getLogger(WatchersHttpSessionListener.class);

    public void sessionCreated(HttpSessionEvent hse) {
        int timeOut = 0;
        try {
            timeOut = Integer.parseInt(SystemPropsUtil.getEnvironProperty(FrameworkConst.HTTP_SESSION_TIME_OUT));
        }
        catch (NumberFormatException e) {
            timeOut = FrameworkConst.HTTPSESSION_TIME_OUT;
        }
        hse.getSession().setMaxInactiveInterval(timeOut * 60);
        this.logger.debug("HttpSession Created -- SessionId: " + hse.getSession().getId() + "  ( MaxInactiveInterval :" + timeOut + " minutes )");
    }

    public void sessionDestroyed(HttpSessionEvent hse) {
        this.logger.debug("HttpSession Destroyed -- SessionId: " + hse.getSession().getId());
    }
}
