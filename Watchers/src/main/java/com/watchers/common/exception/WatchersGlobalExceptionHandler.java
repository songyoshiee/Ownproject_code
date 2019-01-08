package com.watchers.common.exception;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import com.watchers.common.constant.FrameworkConst;

import net.sf.json.JSONObject;

@ControllerAdvice
public class WatchersGlobalExceptionHandler {
	
	@ExceptionHandler(WatchersDataAccessException.class)
    @ResponseBody
    public JSONObject handleBookDataAccessException(HttpServletRequest request, WatchersDataAccessException ex) {
        JSONObject response = new JSONObject();
        response.put(FrameworkConst.RESULT_CODE, ex.getErrorCode());
        response.put(FrameworkConst.RESULT_MSG, ex.getBizErrorMsg());
        response.put(FrameworkConst.RESULT_DET_MSG, ex.getErrorDetail());
        return response;
    }

	@ExceptionHandler(WatchersBizException.class)
    @ResponseBody
    public JSONObject handleBookBizException(HttpServletRequest request, WatchersBizException ex) {
        JSONObject response = new JSONObject();
        if (ex.getErrorCode() == null) {
            response.put(FrameworkConst.RESULT_CODE, FrameworkConst.RESULT_ERR_BIZ);
        } else {
            response.put(FrameworkConst.RESULT_CODE, ex.getErrorCode());
        }
        response.put(FrameworkConst.RESULT_MSG, ex.getBizErrorMsg());
        response.put(FrameworkConst.RESULT_DET_MSG, ex.getErrorDetail());
        return response;
    }
}
