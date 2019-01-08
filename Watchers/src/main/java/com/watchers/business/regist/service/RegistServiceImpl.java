package com.watchers.business.regist.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.watchers.business.login.mapper.LoginMapper;
import com.watchers.business.login.model.UserVo;
import com.watchers.business.login.service.LoginServiceImpl;
import com.watchers.business.regist.mapper.RegistMapper;
import com.watchers.common.constant.FrameworkConst;
import com.watchers.common.exception.WatchersBizException;

import net.sf.json.JSONObject;

@Service
public class RegistServiceImpl implements RegistService{
	Logger logger = LoggerFactory.getLogger(LoginServiceImpl.class);
	
	@Autowired
	LoginMapper loginMapper;
	
	@Autowired
	RegistMapper registMapper;
	
	@Override
	public JSONObject procRegist(UserVo user) {
		JSONObject result = new JSONObject();
		
		int cnt = registMapper.insUser(user);
		
		if(cnt == 1) {
			result.put(FrameworkConst.RESULT_CODE, FrameworkConst.RESULT_SUCCESS);
			result.put(FrameworkConst.RESULT_MSG, "회원가입이 완료되었습니다!");
			return result;
		} else {
			throw new WatchersBizException("회원가입 처리 중 오류가 발생하였습니다");
		}
	}

}
