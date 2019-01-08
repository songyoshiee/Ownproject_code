package com.watchers.business.regist.service;

import com.watchers.business.login.model.UserVo;

import net.sf.json.JSONObject;

public interface RegistService {
	JSONObject procRegist(UserVo user);
}
