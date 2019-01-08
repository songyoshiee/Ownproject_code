package com.watchers.business.regist.mapper;

import com.watchers.business.login.model.UserVo;
import com.watchers.common.annotation.WatchersMyBatisMapper;

@WatchersMyBatisMapper
public interface RegistMapper {
	int insUser(UserVo user);
}
