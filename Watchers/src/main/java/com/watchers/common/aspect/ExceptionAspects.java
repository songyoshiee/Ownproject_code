package com.watchers.common.aspect;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;

import com.watchers.common.constant.FrameworkConst;
import com.watchers.common.exception.WatchersBizException;
import com.watchers.common.exception.WatchersDataAccessException;
import com.watchers.common.exception.WatchersException;

public class ExceptionAspects {
    Logger logger = LoggerFactory.getLogger(ExceptionAspects.class);

    public void controllerExceptionAdvice(Throwable ex) throws Throwable {
        this.logger.error("ExceptionAdvice (Controller)>>> Throwable: " + ex.getMessage());
        ex.printStackTrace();
        if (ex instanceof WatchersException) {
            this.logger.error("ExceptionAdvice (Controller) -- WatchersException >> " + ((WatchersException)ex).getBizErrorMsg());
            throw ex;
        }
        this.logger.error("ExceptionAdvice (Controller) -- RuntimeException >> " + ex.getMessage());
        throw new WatchersBizException(FrameworkConst.RESULT_ERR_BIZ, "RuntimeException 발생", ex.getMessage());
    }

    public void exceptionAdvice(Throwable ex) throws Throwable {
        this.logger.error("ExceptionAdvice >>> Throwable: " + ex.getMessage());
        ex.printStackTrace();
        if (ex instanceof DataAccessException) {
            this.logger.error("ExceptionAdvice -- DataAccessException >> " + ex.getCause().getMessage());
            throw new WatchersDataAccessException(ex);
        }
        if (ex instanceof WatchersDataAccessException) {
            this.logger.error("ExceptionAdvice -- BookDataAccessException >> " + ((WatchersException)ex).getBizErrorMsg());
            throw ex;
        }
        if (ex instanceof WatchersBizException) {
            this.logger.error("ExceptionAdvice -- BookBizException >> " + ((WatchersException)ex).getBizErrorMsg());
            throw ex;
        }
        this.logger.error("ExceptionAdvice -- RuntimeException >> " + ex.getMessage());
        throw new WatchersBizException(FrameworkConst.RESULT_ERR_BIZ, "RuntimeException 발생", ex.getMessage());
    }
}
