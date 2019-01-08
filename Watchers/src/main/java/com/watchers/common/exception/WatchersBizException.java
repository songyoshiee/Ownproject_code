package com.watchers.common.exception;

import com.watchers.common.constant.FrameworkConst;

public class WatchersBizException extends WatchersException {
	
	private static final long serialVersionUID = 8280847788518812106L;

	public WatchersBizException() {
    }

    public WatchersBizException(String bizErrorMsg) {
        super(FrameworkConst.RESULT_ERR_BIZ, bizErrorMsg);
    }

    public WatchersBizException(String bizErrorMsg, String errorDetail) {
        super(FrameworkConst.RESULT_ERR_BIZ, bizErrorMsg, errorDetail);
    }

    public WatchersBizException(String errorCode, String bizErrorMsg, String errorDetail) {
        super(errorCode, bizErrorMsg, errorDetail);
    }
}
