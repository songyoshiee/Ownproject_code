package com.watchers.business.login.service;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.watchers.business.login.mapper.LoginMapper;
import com.watchers.business.login.model.UserVo;
import com.watchers.common.constant.FrameworkConst;
import com.watchers.common.exception.WatchersBizException;
import com.watchers.common.session.manager.SessionLoginUtil;

import net.sf.json.JSONObject;

@Service
public class LoginServiceImpl implements LoginService{
	
	Logger logger = LoggerFactory.getLogger(LoginServiceImpl.class);
	
	@Autowired
	LoginMapper loginMapper;
	
	@Override
	public JSONObject getUser(UserVo user) {
		
		UserVo userInfo = loginMapper.getUser(user);
		
		if(userInfo == null) {
			throw new WatchersBizException("아이디 또는 비밀번호를 확인해주세요.");
		} else {
			// 로그인 성공시 세션에 유저정보 객체를 설정한다.
			HttpSession session = SessionLoginUtil.getCurrentSession();
			session.setAttribute(FrameworkConst.LOGIN_USER, userInfo);
			
			// 로그인 성공시 최종 로그인 시각을 재설정한다.
			loginMapper.updUser(userInfo);
			
			return JSONObject.fromObject(userInfo);
		}
	}
}
