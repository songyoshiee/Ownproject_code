package com.watchers.business.login.mapper;

import com.watchers.business.login.model.UserVo;
import com.watchers.common.annotation.WatchersMyBatisMapper;

@WatchersMyBatisMapper
public interface LoginMapper {
	UserVo getUser(UserVo user);
	
	int updUser(UserVo user);
}
