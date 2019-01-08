package com.watchers.business.login.service;

import com.watchers.business.login.model.UserVo;

import net.sf.json.JSONObject;

public interface LoginService {
	JSONObject getUser(UserVo user);
}
